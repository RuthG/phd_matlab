%Look at momentum budget...

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

uv_ctrl_tav = mean(uv_ctrl,4);
uE_ctrl_tav = mean(uE_ctrl,4);
vN_ctrl_tav = mean(vN_ctrl,4);
tauE_ctrl_tav = mean(tauE_ctrl,3);

[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_ctrl,ny,yc,ar,hc);
[uE_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_ctrl_tav,ny,yc,ar,hc);

[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_ctrl,ny,yc,ar,hc);
[vN_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_ctrl_tav,ny,yc,ar,hc);

[uv_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ctrl,ny,yc,ar,hc);
[uv_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ctrl_tav,ny,yc,ar,hc);

[tauE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tauE_ctrl,ny,yc,ar,hc);
[tauE_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(tauE_ctrl_tav,ny,yc,ar,hc);

uv_zon_zav = uE_zav.*vN_zav;
uv_zon_tzav = uE_tzav.*vN_tzav;

%without time averaging first
uv_ed_notav = uv_zav - uv_zon_zav;
%with time av
uv_ed_tav = uv_tzav - uv_zon_tzav;

%%%%%another go
for i=1:360
uv_ed_maybtrans(:,:,i) = uv_zav(:,:,i) - uv_zon_tzav(:,:);
end

ylat = -89:2:89;
a=6371.0e3;
omega = 7.292e-5;
f = 2.*omega.*sin(ylat.*pi./180);

%Use HBD eqns

%vertical integral first
uv_zon_not_vint(:,:) = sum(uv_zon_zav.*4000,2);
uv_ed_not_vint(:,:) = sum(uv_ed_notav.*4000,2);

uv_zon_t_vint(:,:) = sum(uv_zon_tzav.*4000,2);
uv_ed_t_vint(:,:) = sum(uv_ed_tav.*4000,2);

uE_vint(:,:) = sum(uE_zav.*4000,2);

duEdt = gradient(uE_vint,86400);

uv_ed_maybtrans_vint(:,:) = sum(uv_ed_maybtrans.*4000,2);

%Then differentiate over lat

for i=1:90

uv_zon_not_vint_weighted(i,:) = (cos(ylat(i).*pi./180)).^2.*uv_zon_not_vint(i,:);
uv_ed_not_vint_weighted(i,:) = (cos(ylat(i).*pi./180)).^2.*uv_ed_not_vint(i,:);

uv_zon_t_vint_weighted(i) = (cos(ylat(i).*pi./180)).^2.*uv_zon_t_vint(i);
uv_ed_t_vint_weighted(i) = (cos(ylat(i).*pi./180)).^2.*uv_ed_t_vint(i);

uv_ed_maybtrans_vint_weighted(i,:) = (cos(ylat(i).*pi./180)).^2.*uv_ed_maybtrans_vint(i,:);

end

[moo,uv_grad_zon_not_s] = gradient(uv_zon_not_vint_weighted,pi./90);
[moo,uv_grad_ed_not_s] = gradient(uv_ed_not_vint_weighted,pi./90);

[moo,uv_grad_ed_maybtrans_s] = gradient(uv_ed_maybtrans_vint_weighted,pi./90);

uv_grad_zon_t_s = gradient(uv_zon_t_vint_weighted,pi./90);
uv_grad_ed_t_s = gradient(uv_ed_t_vint_weighted,pi./90);


for i=1:90

uv_grad_zon_not(i,:) = -1.*uv_grad_zon_not_s(i,:)./a./(cos(ylat(i).*pi./180)).^2;
uv_grad_ed_not(i,:) = -1.*uv_grad_ed_not_s(i,:)./a./(cos(ylat(i).*pi./180)).^2;

uv_grad_zon_t(i) = -1.*uv_grad_zon_t_s(i)./a./(cos(ylat(i).*pi./180)).^2;
uv_grad_ed_t(i) = -1.*uv_grad_ed_t_s(i)./a./(cos(ylat(i).*pi./180)).^2;

uv_grad_ed_maybtrans(i,:) = -1.*uv_grad_ed_maybtrans_s(i,:)./a./(cos(ylat(i).*pi./180)).^2;

end

C_zonal_not = uv_grad_zon_not./9.81;
C_eddy_not = uv_grad_ed_not./9.81;
C_total_not = C_zonal_not + C_eddy_not;

C_zonal_t = uv_grad_zon_t./9.81;
C_eddy_t = uv_grad_ed_t./9.81;
C_total_t = C_zonal_t + C_eddy_t;

C_maybtrans = uv_grad_ed_maybtrans./9.81;

for i=1:360
C_total_equiv(:,i) = C_zonal_t(:) + C_maybtrans(:,i);
end

return

figure
plot(ylat,C_zonal_c,'k-.')
hold on
plot(ylat,C_eddy_c,'k:')
plot(ylat,-1.*tauE_c_yzav,'k--')
plot(ylat,C_total_c,'k')
plot(ylat,C_total_c+tauE_c_yzav,'m:')
legend('C zonal','C eddy','-Taux','C total','Residual')

figure
plot(ylat,C_zonal_th,'k-.')
hold on
plot(ylat,C_eddy_th,'k:')
plot(ylat,-1.*tauE_th_yzav,'k--')
plot(ylat,C_total_th,'k')
plot(ylat,C_total_th+tauE_th_yzav,'m:')
legend('C zonal','C eddy','-Taux','C total','Residual')

figure
plot(ylat,C_zonal_w,'k-.')
hold on
plot(ylat,C_eddy_w,'k:')
plot(ylat,-1.*tauE_w_yzav,'k--')
plot(ylat,C_total_w,'k')
plot(ylat,C_total_w+tauE_w_yzav,'m:')
legend('C zonal','C eddy','-Taux','C total','Residual')
return

for i=1:45
coriolis_c(i,:) = f(i).*vN_c_yzav(i,:);
coriolis_th(i,:) = f(i).*vN_th_yzav(i,:);
coriolis_w(i,:) = f(i).*vN_w_yzav(i,:);
end

coriolis_c_vint = sum(-1.*coriolis_c.*4000./9.81,2);
coriolis_th_vint = sum(-1.*coriolis_th.*4000./9.81,2);
coriolis_w_vint = sum(-1.*coriolis_w.*4000./9.81,2);

plot(ylat,coriolis_c_vint,'m')


[m,uv_grad_c]= gradient(uv_ed_c_yzav./a,pi./90);
[m,uv_grad_th]= gradient(uv_ed_th_yzav./a,pi./90);
[m,uv_grad_w]= gradient(uv_ed_w_yzav./a,pi./90);

uv_grad_c_vint = sum(-1.*uv_grad_c.*4000./9.81,2);
uv_grad_th_vint = sum(-1.*uv_grad_c.*4000./9.81,2);
uv_grad_w_vint = sum(-1.*uv_grad_c.*4000./9.81,2);

plot(ylat,coriolis_c_vint)
hold on
plot(ylat,uv_grad_c_vint)
hold on
plot(ylat,tauE_c_yzav)




