%Load in data to calculate quasi-geostrophic refractive index. Use control data to test calculation first.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%We need: u, theta, T

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/'; %p_2014/';
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

i=0;
for nit = 259200:86400:604800; %950400:86400:1296000;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp(:,:,j,i)=theta(:,:,j,i).*convthetatoT(j,1);
end

end

uE_av = mean(uE,4);
theta_av = mean(theta,4);
temp_av = mean(temp,4);

[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_av,ny,yc,ar,hc);
[theta_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_av,ny,yc,ar,hc);
[temp_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_av,ny,yc,ar,hc);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Constants needed: a, c, k, f/omega, H, R

a = 6371000; % radius of earth
c = 8.0; %phase speed guesstimate for now
k = 7;   %waveno to look at
omeg = 2.*pi./(24.*60.*60);  %rotation rate of earth
f = 2.*omeg.*sin(ylat.*pi./180);
H = 8000 ;   % Density scale height (taken from Isla's thesis)
R = 287.0 ; %gas const for dry air
g=9.81;

ylat_arr = zeros(90,25);
rC_arr = zeros(90,25);
for i=1:25
ylat_arr(:,i) = ylat.*pi./180;
f_arr(:,i) = f;
end
for i=1:90
rC_arr(i,:) = rC;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Next evaluate dq/dphi. Need du/dp, dtheta/dp

term1 = 2.*omeg.*cos(ylat_arr);

[b,top] = gradient(uE_zav.*cos(ylat_arr),pi./90);
bottom = a.*cos(ylat_arr);

frac = top./bottom;

[b,term2] = gradient(frac,pi./90);

[dudp,b] = gradient(uE_zav,-4000);
[dthetadp,b] = gradient(theta_zav,-4000);

prod = rC_arr.*theta_zav./temp_zav.*dudp./dthetadp;

[diff,b] = gradient(prod,-4000);

term3 = a.*f_arr.^2./R.*diff;

dqdphi = term1 - term2 + term3;


figure
v=-7e-3:2e-4:4e-3;
contourf(ylat,rC,dqdphi',v)
colorbar
set(gca,'YDir','reverse')
print('-dpng','dqdphi.png')

figure
contourf(ylat,rC,term1')
colorbar
set(gca,'YDir','reverse')
print('-dpng','dqdphi_term1.png')

figure
v=-4e-4:0.5e-4:2e-4;
contourf(ylat,rC,term2',v)
colorbar
set(gca,'YDir','reverse')
print('-dpng','dqdphi_term2.png')

figure
v=-8e-3:1e-4:3e-3;
contourf(ylat,rC,term3',v)
colorbar
set(gca,'YDir','reverse')
print('-dpng','dqdphi_term3.png')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Also evaluate N = sqrt (g/theta dtheta/dz)

Nsq = -(g.^2.*rC_arr)./(R.*temp_zav.*theta_zav) .* dthetadp;
N = sqrt(Nsq);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%qg ref index!

bit1 = dqdphi./(a.*(uE_zav-c));
bit2 = (k./(a.*cos(ylat_arr))).^2 ;
bit3 = (f_arr./(2.*N.*H)).^2 ;

qgref = ( dqdphi./(a.*(uE_zav-c)) -  (k./(a.*cos(ylat_arr))).^2   - (f_arr./(2.*N.*H)).^2 ) .*a.^2;

figure
v=0:1e-12:1e-11;
contourf(ylat,rC,bit1',v)
colorbar
set(gca,'YDir','reverse')
print('-dpng','first_term.png')

figure
v=0:1e-12:1e-11;
contourf(ylat,rC,bit2',v)
colorbar
set(gca,'YDir','reverse')
print('-dpng','second_term.png')

figure
v=0:1e-12:1e-11;
contourf(ylat,rC,bit3',v)
colorbar
set(gca,'YDir','reverse')
print('-dpng','third_term.png')

figure
v=-1e-7:1e-8:1e-7;
contourf(ylat,rC,(1./(a.*(uE_zav-c)))',v)
colorbar
set(gca,'YDir','reverse')
print('-dpng','u_part.png')

save('qg_control.mat','qgref','ylat','rC','dqdphi');




