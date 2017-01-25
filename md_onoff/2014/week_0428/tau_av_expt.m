rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';

xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
arc=rdmds([rDir,'RAC']);
arw=rdmds([rDir,'RAW']);
ars=rdmds([rDir,'RAS']);
rC=squeeze(rdmds([rDir,'RC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
ny=90;

i=0;
for nit = 259200:86400:604800;
i=i+1


[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_ctrl(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_ctrl(:,:,:,i) = dyn(:,:,:,J);
[uE_ctrl(:,:,:,i),vN_ctrl(:,:,:,i)] = rotate_uv2uvEN(ucs_ctrl(:,:,:,i),vcs_ctrl(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_ctrl(:,:,:,i) = dyn(:,:,:,J);

end

[uv_zavc,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ctrl,ny,yc,arc,hc);
[uE_zavw,mskzon,ylat,areazon]=calcZonalAvgCube(uE_ctrl,ny,yc,arw,hw);
[vN_zavs,mskzon,ylat,areazon]=calcZonalAvgCube(vN_ctrl,ny,yg,ars,hs);

[uE_zavc,mskzon,ylat,areazon]=calcZonalAvgCube(uE_ctrl,ny,yc,arc,hc);
[vN_zavc,mskzon,ylat,areazon]=calcZonalAvgCube(vN_ctrl,ny,yc,arc,hc);

%Calc zon product and eddy component
uv_zon_zav = uE_zavw.*vN_zavs;
uv_ed_zav = uv_zavc - uv_zon_zav;


uE_tzavc = mean(uE_zavc,3);
vN_tzavc = mean(vN_zavc,3);
uE_tzavw = mean(uE_zavw,3);
vN_tzavs = mean(vN_zavs,3);



ylat = -89:2:89;
a=6371.0e3;
omega = 7.292e-5;
f = 2.*omega.*sin(ylat.*pi./180);

%Differentiate over lat

%First weight uv by cos(lat).^2
for i=1:90
uv_ed_zav_weighted(i,:,:) = cos(ylat(i).*pi./180).^2.*uv_ed_zav(i,:,:);
uv_zon_zav_weighted(i,:,:) = cos(ylat(i).*pi./180).^2.*uv_zon_zav(i,:,:);
uv_zav_weighted(i,:,:) = cos(ylat(i).*pi./180).^2.*uv_zavc(i,:,:);

end

%Then calculate gradient with 2 degree spacing
[moo,uv_ed_grad_s,boo] = gradient(uv_ed_zav_weighted,pi./90);
[moo,uv_grad_s,boo] = gradient(uv_zav_weighted,pi./90);
[moo,uv_zon_grad_s,boo] = gradient(uv_zon_zav_weighted,pi./90);

%Then divide by acos(lat).^2
for i=1:90
uv_ed_grad(i,:,:) = -1.*uv_ed_grad_s(i,:,:)./(a.*cos(ylat(i).*pi./180).^2);
uv_grad(i,:,:) = -1.*uv_grad_s(i,:,:)./(a.*cos(ylat(i).*pi./180).^2);
uv_zon_grad(i,:,:) = -1.*uv_zon_grad_s(i,:,:)./(a.*cos(ylat(i).*pi./180).^2);
end

%Calculate vertical integral, level spacing 4000 Pa, divide by gravity to do density weighting
uv_ed_grad_vint(:,:) = sum(uv_ed_grad.*4000,2)./9.81;
uv_zon_grad_vint(:,:) = sum(uv_zon_grad.*4000,2)./9.81;
uv_grad_vint(:,:) = sum(uv_grad.*4000,2)./9.81;


%Take time averages for plotting
uv_ed_grad_vint_mean = mean(uv_ed_grad_vint,2);
uv_zon_grad_vint_mean = mean(uv_zon_grad_vint,2);
uv_grad_vint_mean = mean(uv_grad_vint,2);

