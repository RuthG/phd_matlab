%calculate the coriolis and vorticity terms daily to try to figure out what our diags are!


% choose directory, load grid
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_mombudg_2/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
ny=90;

%start reading files: u, v, w
i=0;
for nit = 605040:240:691200;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'WVEL    '));
w(:,:,:,i) = dyn(:,:,:,J);

end

%convert to lat lon grid
xi=-179:2:180;yi=-89:2:90;
uEll=cube2latlon(xc,yc,uE,xi,yi);
vNll=cube2latlon(xc,yc,vN,xi,yi);
wll=cube2latlon(xc,yc,w,xi,yi);

%define constants
omega = 7.292e-5;
f = 2.*omega.*sin(yi.*pi./180);
a=6371.0e3;
acos = a.*cos(yi.*pi./180);

%calculate weighted u for dudy, and fv for coriolis

for i=1:90
uEcos(:,i,:,:) = uEll(:,i,:,:).*cos(yi(i).*pi./180);
fvN(:,i,:,:) = vNll(:,i,:,:).*f(i);
end

%take gradients w.r.t. y and p
[dudy_s,moo,dudp,boo] = gradient(uEcos,pi./90,1,-4000,1);

%redivide by acos(theta) to give dudy
for i=1:90
dudy(:,i,:,:) = dudy_s(:,i,:,:)./acos(i);
end

%calculate zon and time mean vorticity and coriolis terms
vdudy = -1.*mean(dudy.*vNll,4);
vdudy_zav(:,:) = mean(vdudy,1);

wdudp = -1.*mean(dudp.*wll,4);
wdudp_zav(:,:) = mean(wdudp,1);

fvN_zav(:,:) = mean(mean(fvN,4),1);

dudy_zav(:,:) = mean(mean(dudy,4),1);
dudp_zav(:,:) = mean(mean(dudp,4),1);
w_zav(:,:) = mean(mean(wll,4),1);
v_zav(:,:) = mean(mean(vNll,4),1);
u_zav(:,:) = mean(mean(uEll,4),1);

%plot up
v=-2e-4:0.2e-4:2e-4;
[C,h] = contourf(yi,rC,vdudy_zav',v);
set(gca,'YDir','reverse')
colorbar
ylabel('Pressure, Pa')
xlabel('Latitiude')
print('-dpng','vdudy.png')

figure
[C,h] = contourf(yi,rC,wdudp_zav',v);
set(gca,'YDir','reverse')
colorbar
ylabel('Pressure, Pa')
xlabel('Latitiude')
print('-dpng','wdudp.png')

figure
[C,h] = contourf(yi,rC,fvN_zav',v);
set(gca,'YDir','reverse')
colorbar
ylabel('Pressure, Pa')
xlabel('Latitiude')
print('-dpng','coriolis.png')


figure
[C,h] = contourf(yi,rC,dudp_zav');
set(gca,'YDir','reverse')
colorbar
ylabel('Pressure, Pa')
xlabel('Latitiude')
print('-dpng','dudp.png')

figure
[C,h] = contourf(yi,rC,dudy_zav');
set(gca,'YDir','reverse')
colorbar
ylabel('Pressure, Pa')
xlabel('Latitiude')
print('-dpng','dudy.png')

figure
[C,h] = contourf(yi,rC,w_zav');
set(gca,'YDir','reverse')
colorbar
ylabel('Pressure, Pa')
xlabel('Latitiude')
print('-dpng','w.png')

figure
[C,h] = contourf(yi,rC,v_zav');
set(gca,'YDir','reverse')
colorbar
ylabel('Pressure, Pa')
xlabel('Latitiude')
print('-dpng','v.png')

figure
[C,h] = contourf(yi,rC,u_zav');
set(gca,'YDir','reverse')
colorbar
ylabel('Pressure, Pa')
xlabel('Latitiude')
print('-dpng','u.png')
return

dudy_mean = mean(dudy,4);
dudp_mean = mean(dudp,4);

dudy_zav(:,:) = mean(dudy_mean,1);
dudp_zav(:,:) = mean(dudp_mean,1);

