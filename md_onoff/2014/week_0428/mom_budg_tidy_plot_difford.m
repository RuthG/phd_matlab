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

%read fields
i=0;
for nit = 605040:240:691200;
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


[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_ctrl,ny,yc,ar,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_ctrl,ny,yc,ar,hc);
[uv_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ctrl,ny,yc,ar,hc);
[tauE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tauE_ctrl,ny,yc,ar,hc);
[tauN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tauN_ctrl,ny,yc,ar,hc);
uv_zon_zav = uE_zav.*vN_zav;
uv_ed_zav = uv_zav - uv_zon_zav;

ylat = -89:2:89;
a=6371.0e3;
omega = 7.292e-5;
f = 2.*omega.*sin(ylat.*pi./180);

%Differentiate over lat

uv_ed_zav_vint(:,:) = sum(uv_ed_zav.*4000,2)./9.81;
uv_zon_zav_vint(:,:) = sum(uv_zon_zav.*4000,2)./9.81;
uv_zav_vint(:,:) = sum(uv_zav.*4000,2)./9.81;


for i=1:90
uv_ed_zav_weighted(i,:) = cos(ylat(i).*pi./180).^2.*uv_ed_zav_vint(i,:);
uv_zon_zav_weighted(i,:) = cos(ylat(i).*pi./180).^2.*uv_zon_zav_vint(i,:);
uv_zav_weighted(i,:) = cos(ylat(i).*pi./180).^2.*uv_zav_vint(i,:);
end

[moo,uv_ed_grad_s] = gradient(uv_ed_zav_weighted,pi./90);
[moo,uv_grad_s] = gradient(uv_zav_weighted,pi./90);
[moo,uv_zon_grad_s] = gradient(uv_zon_zav_weighted,pi./90);

for i=1:90
uv_ed_grad(i,:) = -1.*uv_ed_grad_s(i,:)./(a.*cos(ylat(i).*pi./180).^2);
uv_grad(i,:) = -1.*uv_grad_s(i,:)./(a.*cos(ylat(i).*pi./180).^2);
uv_zon_grad(i,:) = -1.*uv_zon_grad_s(i,:)./(a.*cos(ylat(i).*pi./180).^2);
end



tauE_zav_mean = mean(tauE_zav,2);
tauN_zav_mean = mean(tauN_zav,2);
uv_ed_grad_vint_mean = mean(uv_ed_grad,2);
uv_zon_grad_vint_mean = mean(uv_zon_grad,2);
uv_grad_vint_mean = mean(uv_grad,2);

plot(ylat,-1.*tauE_zav_mean,'k')
hold on
plot(ylat,uv_grad_vint_mean,'k--')
plot(ylat,uv_ed_grad_vint_mean,'k:')
plot(ylat,uv_zon_grad_vint_mean,'k-.')
residual = tauE_zav_mean + uv_grad_vint_mean;
plot(ylat,residual,'r')
ylabel('Latitude')
xlabel('u budget (N/m2)')
legend('-TauE','C total','C eddy','C zonal','Residual')
return
print('-dpng','mom_budget.png')
