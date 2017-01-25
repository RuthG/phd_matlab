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

J=find(strcmp(fldList,'UV_VEL_C'));
uv_ctrl(:,:,:,i) = dyn(:,:,:,J);

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhTauX'));
tauxcs_ctrl(:,:,i) = surf(:,:,J);
J=find(strcmp(fldList,'AtPhTauY'));
tauycs_ctrl(:,:,i) = surf(:,:,J);
[tauE_ctrl(:,:,i),tauN_ctrl(:,:,i)] = rotate_uv2uvEN(tauxcs_ctrl(:,:,i),tauycs_ctrl(:,:,i),AngleCS,AngleSN,Grid);

end

%Take zonal averages
[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_ctrl,ny,yc,ar,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_ctrl,ny,yc,ar,hc);
[uv_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ctrl,ny,yc,ar,hc);
[tauE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tauE_ctrl,ny,yc,ar,hc);
[tauN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tauN_ctrl,ny,yc,ar,hc);

%Calc zon product and eddy component
uv_zon_zav = uE_zav.*vN_zav;
uv_ed_zav = uv_zav - uv_zon_zav;

ylat = -89:2:89;
a=6371.0e3;
omega = 7.292e-5;
f = 2.*omega.*sin(ylat.*pi./180);

%Differentiate over lat

%First weight uv by cos(lat).^2
for i=1:90
uv_ed_zav_weighted(i,:,:) = cos(ylat(i).*pi./180).^2.*uv_ed_zav(i,:,:);
uv_zon_zav_weighted(i,:,:) = cos(ylat(i).*pi./180).^2.*uv_zon_zav(i,:,:);
uv_zav_weighted(i,:,:) = cos(ylat(i).*pi./180).^2.*uv_zav(i,:,:);
fvN_zav(i,:,:) = f(i).*vN_zav(i,:,:);
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
fvN_zav_vint(:,:) = sum(fvN_zav.*4000,2)./9.81;

%Take time averages for plotting
tauE_zav_mean = mean(tauE_zav,2);
tauN_zav_mean = mean(tauN_zav,2);
uv_ed_grad_vint_mean = mean(uv_ed_grad_vint,2);
uv_zon_grad_vint_mean = mean(uv_zon_grad_vint,2);
uv_grad_vint_mean = mean(uv_grad_vint,2);
fvN_zav_vint_mean = mean(fvN_zav_vint,2);

% Plot :) 
figure
plot(ylat,-1.*tauE_zav_mean,'k')
hold on
plot(ylat,uv_grad_vint_mean,'k--')
plot(ylat,uv_ed_grad_vint_mean,'k:')
plot(ylat,uv_zon_grad_vint_mean,'k-.')
residual = tauE_zav_mean + uv_grad_vint_mean;
plot(ylat,residual,'r')
xlabel('Latitude')
ylabel('U budget (N/m2)')
legend('-TauE','C total','C eddy','C zonal','Residual')

print('-dpng','mom_budget_5y.png')
