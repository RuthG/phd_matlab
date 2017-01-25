%load up relative vorticity mitgcm output
%compare with offline calculation

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_diag_testing/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
dxc=rdmds([rDir,'DXC']);
dyc=rdmds([rDir,'DYC']);
dxg=rdmds([rDir,'DXG']);
dyg=rdmds([rDir,'DYG']);
drf=rdmds([rDir,'DRF']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
arc=rdmds([rDir,'RAC']);
ars=rdmds([rDir,'RAS']);
arw=rdmds([rDir,'RAW']);
arz=rdmds([rDir,'RAZ']);
rC=squeeze(rdmds([rDir,'RC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
ny=90;
a=6371.0e3;

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

J=find(strcmp(fldList,'momVort3'));
vort3(:,:,:,i) = dyn(:,:,:,J);

end

%Now shift onto lat lon grid
xi=-179:2:180;yi=-89:2:90;
uEll=cube2latlon(xc,yc,uE,xi,yi);
vNll=cube2latlon(xc,yc,vN,xi,yi);

dxll = zeros(180,90);
dyll = zeros(180,90);
dyll(:,:) = a.*pi./90;

for i=1:90
dxll(:,i) = a.*cos(yi(i).*pi./180).*pi./90;
end

%calculate area of grid cells
arll = dxll.*dyll;

for k=1:25
for tstep=1:360

dyv(:,:) = dyc.*vcs(:,:,k,tstep)./arz;
dxu(:,:) = dxc.*ucs(:,:,k,tstep)./arz;

dyvll(:,:) = dyll.*vNll(:,:,k,tstep)./arll;
dxull(:,:) = dxll.*uEll(:,:,k,tstep)./arll;

[dyvdy,dyvdx] = gradient(dyv);
[dxudy,dxudx] = gradient(dxu);

[dyvdyll,dyvdxll] = gradient(dyvll);
[dxudyll,dxudxll] = gradient(dxull);

zeta3(:,:,k,tstep) = dyvdx - dxudy;
zeta3ll(:,:,k,tstep) = dyvdxll - dxudyll;

end
end

vort3_mean = mean(vort3,4);
zeta3_mean = mean(zeta3,4);
zeta3ll_mean = mean(zeta3ll,4);

[vort3_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vort3_mean,ny,yc,arc,hc);
[zeta3_zav,mskzon,ylat,areazon]=calcZonalAvgCube(zeta3_mean,ny,yc,arc,hc);
zeta3ll_zav(:,:) = mean(zeta3ll_mean,1);

figure
v=-4e-5:0.4e-5:4e-5;
[C,h] = contourf(ylat,rC,vort3_zav',v);
colorbar;
colormap(b2r(-4e-5,4e-5));
xlabel('Latitude')
ylabel('Pressure, Pa')
title('Relative vorticity: MITgcm output')
set(gca,'YDir','reverse')
print('-dpng','relvort_mit.png')

v=-4e-5:0.4e-5:4e-5;
figure
[C,h] = contourf(ylat,rC,zeta3_zav',v);
colorbar;
colormap(b2r(-4e-5,4e-5));
xlabel('Latitude')
ylabel('Pressure, Pa')
title('Relative vorticity: offline cubesphere calc')
set(gca,'YDir','reverse')
print('-dpng','relvort_cs.png')

v=-4e-5:0.4e-5:4e-5;
figure
[C,h] = contourf(ylat,rC,zeta3ll_zav',v);
colorbar;
colormap(b2r(-4e-5,4e-5));
xlabel('Latitude')
ylabel('Pressure, Pa')
title('Relative vorticity: offline lat lon calc')
set(gca,'YDir','reverse')
print('-dpng','relvort_ll.png')
