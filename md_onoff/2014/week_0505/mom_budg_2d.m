rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';

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

%Load in U, V, UV, Tau

%read fields
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

J=find(strcmp(fldList,'AtPhdUdt'));
dudtcs_ctrl(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdVdt'));
dvdtcs_ctrl(:,:,:,i) = dyn(:,:,:,J);
[duEdt_ctrl(:,:,:,i),dvNdt_ctrl(:,:,:,i)] = rotate_uv2uvEN(dudtcs_ctrl(:,:,:,i),dvdtcs_ctrl(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_ctrl(:,:,:,i) = dyn(:,:,:,J);

end

%Take zonal averages
[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_ctrl,ny,yc,ar,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_ctrl,ny,yc,ar,hc);
[uv_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ctrl,ny,yc,ar,hc);
[duEdt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(duEdt_ctrl,ny,yc,ar,hc);
[dvNdt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(dvNdt_ctrl,ny,yc,ar,hc);

%Calc zon product and eddy component
uv_zon_zav = uE_zav.*vN_zav;
uv_ed_zav = uv_zav - uv_zon_zav;

%Take time averages
uv_tzav = mean(uv_zav,3);
uv_zon_tzav = mean(uv_zon_zav,3);
uv_ed_tzav = mean(uv_ed_zav,3);
duEdt_tzav = mean(duEdt_zav,3);
vN_tzav = mean(vN_zav,3);

ylat = -89:2:89;
a=6371.0e3;
omega = 7.292e-5;
f = 2.*omega.*sin(ylat.*pi./180);

%Differentiate over lat

%First weight uv by cos(lat).^2
for i=1:90
uv_ed_tzav_weighted(i,:) = cos(ylat(i).*pi./180).^2.*uv_ed_tzav(i,:);
uv_zon_tzav_weighted(i,:) = cos(ylat(i).*pi./180).^2.*uv_zon_tzav(i,:);
uv_tzav_weighted(i,:) = cos(ylat(i).*pi./180).^2.*uv_tzav(i,:);
fvN_tzav(i,:) = f(i).*vN_tzav(i,:);
end

%Then calculate gradient with 2 degree spacing
[moo,uv_ed_grad_s] = gradient(uv_ed_tzav_weighted,pi./90);
[moo,uv_grad_s] = gradient(uv_tzav_weighted,pi./90);
[moo,uv_zon_grad_s] = gradient(uv_zon_tzav_weighted,pi./90);

%Then divide by acos(lat).^2
for i=1:90
uv_ed_grad(i,:) = -1.*uv_ed_grad_s(i,:)./(a.*cos(ylat(i).*pi./180).^2);
uv_grad(i,:) = -1.*uv_grad_s(i,:)./(a.*cos(ylat(i).*pi./180).^2);
uv_zon_grad(i,:) = -1.*uv_zon_grad_s(i,:)./(a.*cos(ylat(i).*pi./180).^2);
end

for i=1:90
%fvN_mean_weighted(i,:) = fvN_mean(i,:).*cos(ylat(i).*pi./180);
duEdt_tzav_w(i,:) = duEdt_tzav(i,:).*cos(ylat(i).*pi./180);
uv_grad_ran(i,:) = uv_grad(i,:).*sin(ylat(i).*pi./180);
end

figure
v=-2e-4:0.1e-4:2e-4;
[C,h] = contourf(ylat,rC,uv_grad',v);
set(gca,'YDir','reverse')
colorbar
caxis([-1.5e-4 1.5e-4])
title('UV gradient')
print('-dpng','uvgrad.png')
figure
v=-2e-4:0.1e-4:2e-4;
[C,h] = contourf(ylat,rC,uv_ed_grad',v);
set(gca,'YDir','reverse')
colorbar
caxis([-1.5e-4 1.5e-4])
title('UV gradient')
print('-dpng','uvedgrad.png')
figure
v=-2e-4:0.1e-4:2e-4;
[C,h] = contourf(ylat,rC,uv_zon_grad',v);
set(gca,'YDir','reverse')
colorbar
caxis([-1.5e-4 1.5e-4])
title('UV gradient')
print('-dpng','uvzongrad.png')


figure
[C,h] = contourf(ylat,rC,fvN_tzav',v);
set(gca,'YDir','reverse')
colorbar
caxis([-1.5e-4 1.5e-4])
title('fv')
print('-dpng','fv.png')
figure
[C,h] = contourf(ylat,rC,duEdt_tzav',v);
set(gca,'YDir','reverse')
colorbar
caxis([-1.5e-4 1.5e-4])
title('Friction')
print('-dpng','friction.png')
figure
[C,h] = contourf(ylat,rC,fvN_tzav'+duEdt_tzav',v);
set(gca,'YDir','reverse')
colorbar
caxis([-1.5e-4 1.5e-4])
title('Friction + fv')
print('-dpng','frictionfv.png')
figure
[C,h] = contourf(ylat,rC,fvN_tzav'+duEdt_tzav'+uv_grad',v);
set(gca,'YDir','reverse')
colorbar
caxis([-1.5e-4 1.5e-4])
title('Friction + fv + UV gradient')
print('-dpng','residual.png')

figure
[C,h] = contourf(ylat,rC,uv_tzav');
set(gca,'YDir','reverse')
colorbar
title('UV (total)')
print('-dpng','uvtot.png')

figure
[C,h] = contourf(ylat,rC,uv_ed_tzav');
set(gca,'YDir','reverse')
colorbar
title('UV (eddy)')
print('-dpng','uved.png')

figure
[C,h] = contourf(ylat,rC,uv_zon_tzav');
set(gca,'YDir','reverse')
colorbar
title('UV (zonal)')
print('-dpng','uvzon.png')

return

