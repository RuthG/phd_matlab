%Look at momentum budget...

rDir='/disk1/MITgcm/verification/atm_gray_ruth/ensemble_control/';

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

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0421/yzav_c.mat')
load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0421/yzav_th.mat')
load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0421/yzav_w.mat')

ylat = 1:2:89;
a=6371.0e3;
omega = 2.*pi./86400;
f = 2.*omega.*sin(ylat.*pi./180);

%Use HBD eqns

uv_c = uE_c_yzav.*vN_c_yzav;
uv_th = uE_th_yzav.*vN_th_yzav;
uv_w = uE_w_yzav.*vN_w_yzav;

%vertical integral first
uv_c_vint = sum(uv_c.*4000,2);
uv_ed_c_vint = sum(uv_ed_c_yzav.*4000,2);
uv_c_vint_check = sum(uv_c_yzav.*4000,2);
uv_th_vint = sum(uv_th.*4000,2);
uv_ed_th_vint = sum(uv_ed_th_yzav.*4000,2);
uv_th_vint_check = sum(uv_th_yzav.*4000,2);
uv_w_vint = sum(uv_w.*4000,2);
uv_ed_w_vint = sum(uv_ed_w_yzav.*4000,2);
uv_w_vint_check = sum(uv_w_yzav.*4000,2);

%Then differentiate over lat

for i=1:45
uv_c_vint_weighted(i,:) = (cos(ylat(i).*pi./180)).^2.*uv_c_vint(i,:);
uv_ed_c_vint_weighted(i,:) = (cos(ylat(i).*pi./180)).^2.*uv_ed_c_vint(i,:);
uv_c_vint_check_weighted(i,:) = (cos(ylat(i).*pi./180)).^2.*uv_c_vint_check(i,:);

uv_th_vint_weighted(i,:) = (cos(ylat(i).*pi./180)).^2.*uv_th_vint(i,:);
uv_ed_th_vint_weighted(i,:) = (cos(ylat(i).*pi./180)).^2.*uv_ed_th_vint(i,:);
uv_th_vint_check_weighted(i,:) = (cos(ylat(i).*pi./180)).^2.*uv_th_vint_check(i,:);

uv_w_vint_weighted(i,:) = (cos(ylat(i).*pi./180)).^2.*uv_w_vint(i,:);
uv_ed_w_vint_weighted(i,:) = (cos(ylat(i).*pi./180)).^2.*uv_ed_w_vint(i,:);
uv_w_vint_check_weighted(i,:) = (cos(ylat(i).*pi./180)).^2.*uv_w_vint_check(i,:);
end

uv_grad_c_s= gradient(uv_c_vint_weighted,pi./90);
uv_ed_grad_c_s= gradient(uv_ed_c_vint_weighted,pi./90);
uv_grad_c_s_check= gradient(uv_c_vint_check_weighted,pi./90);

uv_grad_th_s= gradient(uv_th_vint_weighted,pi./90);
uv_ed_grad_th_s= gradient(uv_ed_th_vint_weighted,pi./90);
uv_grad_th_s_check= gradient(uv_th_vint_check_weighted,pi./90);

uv_grad_w_s= gradient(uv_w_vint_weighted,pi./90);
uv_ed_grad_w_s= gradient(uv_ed_w_vint_weighted,pi./90);
uv_grad_w_s_check= gradient(uv_w_vint_check_weighted,pi./90);

for i=1:45
uv_grad_c(i,:) = -1.*uv_grad_c_s(i,:)./a./(cos(ylat(i).*pi./180)).^2;
uv_ed_grad_c(i,:) = -1.*uv_ed_grad_c_s(i,:)./a./(cos(ylat(i).*pi./180)).^2;
uv_grad_c_check(i,:) = -1.*uv_grad_c_s_check(i,:)./a./(cos(ylat(i).*pi./180)).^2;

uv_grad_th(i,:) = -1.*uv_grad_th_s(i,:)./a./(cos(ylat(i).*pi./180)).^2;
uv_ed_grad_th(i,:) = -1.*uv_ed_grad_th_s(i,:)./a./(cos(ylat(i).*pi./180)).^2;
uv_grad_th_check(i,:) = -1.*uv_grad_th_s_check(i,:)./a./(cos(ylat(i).*pi./180)).^2;

uv_grad_w(i,:) = -1.*uv_grad_w_s(i,:)./a./(cos(ylat(i).*pi./180)).^2;
uv_ed_grad_w(i,:) = -1.*uv_ed_grad_w_s(i,:)./a./(cos(ylat(i).*pi./180)).^2;
uv_grad_w_check(i,:) = -1.*uv_grad_w_s_check(i,:)./a./(cos(ylat(i).*pi./180)).^2;
end

C_zonal_c = uv_grad_c./9.81;
C_eddy_c = uv_ed_grad_c./9.81;
C_total_c = C_zonal_c + C_eddy_c;
C_zonal_th = uv_grad_th./9.81;
C_eddy_th = uv_ed_grad_th./9.81;
C_total_th = C_zonal_th + C_eddy_th;
C_zonal_w = uv_grad_w./9.81;
C_eddy_w = uv_ed_grad_w./9.81;
C_total_w = C_zonal_w + C_eddy_w;

C_check_c = uv_grad_c_check./9.81;
C_check_th = uv_grad_th_check./9.81;
C_check_w = uv_grad_w_check./9.81;
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




