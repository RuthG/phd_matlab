%vtuv_ll.m
%Plot vt and uv lat lon cross secs for daily data for wet and dry runs to give and idea of relative eddy-ness

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_1yeardaily_c/';

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

nit = 613200;


[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_w = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w = dyn(:,:,:,J);
[uE_w,vN_w] = rotate_uv2uvEN(ucs_w,vcs_w,AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_w = dyn(:,:,:,J);

J=find(strcmp(fldList,'THETA   '));
theta_w = dyn(:,:,:,J);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_w = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_w = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_w = dyn(:,:,:,J);
[uEt_w,vNt_w] = rotate_uv2uvEN(ut_w,vt_w,AngleCS,AngleSN,Grid);

[uE_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_w,ny,yc,ar,hc);
[vN_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_w,ny,yc,ar,hc);
[theta_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_w,ny,yc,ar,hc);

uEvN_w(1,:,:) = uE_w_zav.*vN_w_zav;
vNth_w(1,:,:) = vN_w_zav.*theta_w_zav;


xi=-179:2:180;yi=-89:2:90;

uv_w_ll=cube2latlon(xc,yc,uv_w,xi,yi);
vt_w_ll=cube2latlon(xc,yc,vNt_w,xi,yi);


for i=1:180
uv_w_ed(i,:,:) = uv_w_ll(i,:,:) - uEvN_w(1,:,:);
vt_w_ed(i,:,:) = vt_w_ll(i,:,:) - vNth_w(1,:,:);
end


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_oneyrdaily_wvoffradoff/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_d = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_d = dyn(:,:,:,J);
[uE_d,vN_d] = rotate_uv2uvEN(ucs_d,vcs_d,AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_d = dyn(:,:,:,J);

J=find(strcmp(fldList,'THETA   '));
theta_d = dyn(:,:,:,J);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_d = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_d = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_d = dyn(:,:,:,J);
[uEt_d,vNt_d] = rotate_uv2uvEN(ut_d,vt_d,AngleCS,AngleSN,Grid);

[uE_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_d,ny,yc,ar,hc);
[vN_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_d,ny,yc,ar,hc);
[theta_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_d,ny,yc,ar,hc);

uEvN_d(1,:,:) = uE_d_zav.*vN_d_zav;
vNth_d(1,:,:) = vN_d_zav.*theta_d_zav;


xi=-179:2:180;yi=-89:2:90;

uv_d_ll=cube2latlon(xc,yc,uv_d,xi,yi);
vt_d_ll=cube2latlon(xc,yc,vNt_d,xi,yi);


for i=1:180
uv_d_ed(i,:,:) = uv_d_ll(i,:,:) - uEvN_d(1,:,:);
vt_d_ed(i,:,:) = vt_d_ll(i,:,:) - vNth_d(1,:,:);
end


figure
v=-250:25:250;
contourf(xi,yi,uv_d_ed(:,:,6)',v)
title('HEMF for dry case at 780hPa')
xlabel('Longitude')
ylabel('Latitude')
caxis([-250 250])
colorbar
print('-dpng','hemf_dry_780.png')
figure
contourf(xi,yi,uv_w_ed(:,:,6)',v)
title('HEMF for wet case at 780hPa')
xlabel('Longitude')
ylabel('Latitude')
caxis([-250 250])
colorbar
print('-dpng','hemf_wet_780.png')
figure
v=-5000:500:5000;
contourf(xi,yi,vt_d_ed(:,:,6)',v)
title('Eddy heat flux for dry case at 780hPa')
xlabel('Longitude')
ylabel('Latitude')
caxis([-5000 5000])
colorbar
print('-dpng','ehf_dry_780.png')
figure
contourf(xi,yi,vt_w_ed(:,:,6)',v)
title('Eddy heat flux for wet case at 780hPa')
xlabel('Longitude')
ylabel('Latitude')
caxis([-5000 5000])
colorbar
print('-dpng','ehf_wet_780.png')


figure
v=-1100:110:1100;
contourf(xi,yi,uv_d_ed(:,:,13)',v)
title('HEMF for dry case at 500hPa')
xlabel('Longitude')
ylabel('Latitude')
caxis([-1100 1100])
colorbar
print('-dpng','hemf_dry_500.png')
figure
contourf(xi,yi,uv_w_ed(:,:,13)',v)
title('HEMF for wet case at 500hPa')
xlabel('Longitude')
ylabel('Latitude')
caxis([-1100 1100])
colorbar
print('-dpng','hemf_wet_500.png')
figure
v=-10000:1000:10000;
contourf(xi,yi,vt_d_ed(:,:,13)',v)
title('Eddy heat flux for dry case at 500hPa')
xlabel('Longitude')
ylabel('Latitude')
caxis([-10000 10000])
colorbar
print('-dpng','ehf_dry_500.png')
figure
contourf(xi,yi,vt_w_ed(:,:,13)',v)
title('Eddy heat flux for wet case at 500hPa')
xlabel('Longitude')
ylabel('Latitude')
caxis([-10000 10000])
colorbar
print('-dpng','ehf_wet_500.png')
