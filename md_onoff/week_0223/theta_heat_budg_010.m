%produce tidy version of the heat budget terms

%calculate advective heat transport terms carefully on the lat-lon grid


% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_doshallower10/';
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
yi = -89:2:89;
xi = -179:2:179;

radius = 6371.0e3;

%load heat rates

load('/project/rg312/mat_files/heat_rates.mat','htrt_010')
htrt_010_ll = cube2latlon(xc,yc,htrt_010(:,:,:,360),xi,yi).*86400;
htrt_010_ll_tav = cube2latlon(xc,yc,mean(htrt_010,4),xi,yi).*86400;
htrt_ed_010_ll = htrt_010_ll - htrt_010_ll_tav;
clear('htrt_010')

load('/project/rg312/mat_files/snapshot_data/theta_snapshots.mat','theta_010')
theta_010_ll = cube2latlon(xc,yc,theta_010(:,:,:,360),xi,yi);
theta_after_ll = cube2latlon(xc,yc,theta_010(:,:,:,361),xi,yi);
theta_010_ll_tav = cube2latlon(xc,yc,mean(theta_010,4),xi,yi);
theta_ed_010_ll = theta_010_ll - theta_010_ll_tav;
clear('theta_010')

load('/project/rg312/mat_files/snapshot_data/uE_snapshots.mat','uE_010')
uE_010_ll = cube2latlon(xc,yc,uE_010(:,:,:,360),xi,yi);
uE_010_ll_tav = cube2latlon(xc,yc,mean(uE_010,4),xi,yi);
uE_ed_010_ll = uE_010_ll - uE_010_ll_tav;
clear('uE_010')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat','vN_010')
vN_010_ll = cube2latlon(xc,yc,vN_010(:,:,:,360),xi,yi);
vN_010_ll_tav = cube2latlon(xc,yc,mean(vN_010,4),xi,yi);
vN_ed_010_ll = vN_010_ll - vN_010_ll_tav;
clear('vN_010')

load('/project/rg312/mat_files/snapshot_data/w_snapshots.mat','w_010')
w_010_ll_half = zeros(180,90,26); w_010_ll_tav_half = zeros(180,90,26);
w_010_ll_half(:,:,1:25) = cube2latlon(xc,yc,w_010(:,:,:,360),xi,yi);
w_010_ll_tav_half(:,:,1:25) = cube2latlon(xc,yc,mean(w_010,4),xi,yi);
w_ed_010_ll_half = w_010_ll_half - w_010_ll_tav_half;
clear('w_010')

rC_half = (100000:-4000:0)';
w_ed_010_ll = shiftdim(interp1(rC_half,shiftdim(w_ed_010_ll_half,2),rC),1);
w_010_ll_tav = shiftdim(interp1(rC_half,shiftdim(w_010_ll_tav_half,2),rC),1);
w_010_ll = shiftdim(interp1(rC_half,shiftdim(w_010_ll_half,2),rC),1);

load('/project/rg312/mat_files/front_diag.mat')


[dthetady_010,dthetadx_010,dthetadp_010] = gradient(theta_010_ll,pi./90,pi./90,-4000);
dthetady_010 = dthetady_010./radius;

[dthetady_010_tav,dthetadx_010_tav,dthetadp_010_tav] = gradient(theta_010_ll_tav,pi./90,pi./90,-4000);
dthetady_010_tav = dthetady_010_tav./radius;

[dtheta_ed_dy_010,dtheta_ed_dx_010,dtheta_ed_dp_010] = gradient(theta_ed_010_ll,pi./90,pi./90,-4000);
dtheta_ed_dy_010 = dtheta_ed_dy_010./radius;

for i=1:90
dtheta_ed_dx_010(:,i,:) = dtheta_ed_dx_010(:,i,:)./cos(yi(i).*pi./180)./radius;
dthetadx_010_tav(:,i,:) = dthetadx_010_tav(:,i,:)./cos(yi(i).*pi./180)./radius;
dthetadx_010(:,i,:) = dthetadx_010(:,i,:)./cos(yi(i).*pi./180)./radius;
end

udtheta_ed_dx_010 = -uE_010_ll_tav.*dtheta_ed_dx_010.*86400;
vdtheta_ed_dy_010 = -vN_010_ll_tav.*dtheta_ed_dy_010.*86400;
wdtheta_ed_dp_010 = -w_010_ll_tav.*dtheta_ed_dp_010.*86400;

u_ed_dthetadx_010 = -uE_ed_010_ll.*dthetadx_010_tav.*86400;
v_ed_dthetady_010 = -vN_ed_010_ll.*dthetady_010_tav.*86400;
w_ed_dthetadp_010 = -w_ed_010_ll.*dthetadp_010_tav.*86400;

udthetadx_010_tav = -uE_010_ll_tav.*dthetadx_010_tav.*86400;
vdthetady_010_tav = -vN_010_ll_tav.*dthetady_010_tav.*86400;
wdthetadp_010_tav = -w_010_ll_tav.*dthetadp_010_tav.*86400;

udthetadx_010 = -uE_010_ll.*dthetadx_010.*86400;
vdthetady_010 = -vN_010_ll.*dthetady_010.*86400;
wdthetadp_010 = -w_010_ll.*dthetadp_010.*86400;

u_ed_dtheta_ed_dx_010 = -uE_ed_010_ll.*dtheta_ed_dx_010.*86400;
v_ed_dtheta_ed_dy_010 = -vN_ed_010_ll.*dtheta_ed_dy_010.*86400;
w_ed_dtheta_ed_dp_010 = -w_ed_010_ll.*dtheta_ed_dp_010.*86400;




figure
v=-15:1:15;
[C,h] = contourf(xi,yi,theta_after_ll(:,:,5)' - theta_010_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('\Theta_{361} - \Theta_{360}, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','theta_change_010.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_010_ll(:,:,5)' + wdthetadp_010(:,:,5)' + udthetadx_010(:,:,5)' + vdthetady_010(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Sum of total heat budget terms, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','tot_heat_budg_sum_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_010_ll_tav(:,:,5)' + wdthetadp_010_tav(:,:,5)' + udthetadx_010_tav(:,:,5)' + vdthetady_010_tav(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Sum of time mean heat budget terms, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','tav_heat_budg_sum_010.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_010_ll(:,:,5)' + w_ed_dthetadp_010(:,:,5)' + wdtheta_ed_dp_010(:,:,5)' + w_ed_dtheta_ed_dp_010(:,:,5)' + u_ed_dthetadx_010(:,:,5)' + udtheta_ed_dx_010(:,:,5)' + u_ed_dtheta_ed_dx_010(:,:,5)' + v_ed_dthetady_010(:,:,5)' + vdtheta_ed_dy_010(:,:,5)' + v_ed_dtheta_ed_dy_010(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Sum of eddy heat budget terms, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','eddy_heat_budg_sum_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_010_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Total Diabatic Heating, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_total/wv_010/htrt_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_010_ll_tav(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Total Diabatic Heating, time av part, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_tav/wv_010/htrt_tav_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_010_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Total Diabatic Heating, eddy part, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_010/htrt_ed_010.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udthetadx_010(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('ud\Theta/dx, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_total/wv_010/udthetadx_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udthetadx_010_tav(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<u>d<\Theta>/dx, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_tav/wv_010/udthetadx_tav_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udtheta_ed_dx_010(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<u>d\Theta''/dx, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_010/udthetapdx_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,u_ed_dthetadx_010(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('u''d<\Theta>/dx, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_010/updthetadx_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,u_ed_dtheta_ed_dx_010(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('u''d\Theta''/dx, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_010/updtpdx_010.png')




figure
v=-15:1:15;
[C,h] = contourf(xi,yi,vdthetady_010(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('vd\Theta/dy, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_total/wv_010/vdthetady_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,vdthetady_010_tav(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<v>d<\Theta>/dy, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_tav/wv_010/vdthetady_tav_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,vdtheta_ed_dy_010(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<v>d\Theta''/dy, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_010/vdthetapdy_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,v_ed_dthetady_010(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('v''d<\Theta>/dy, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_010/vpdthetady_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,v_ed_dtheta_ed_dy_010(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('v''d\Theta''/dy, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_010/vpdthetapdy_010.png')




figure
v=-15:1:15;
[C,h] = contourf(xi,yi,wdthetadp_010(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('wd\Theta/dp, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_total/wv_010/wdthetadp_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,wdthetadp_010_tav(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<w>d<\Theta>/dp, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_tav/wv_010/wdthetadp_tav_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,wdtheta_ed_dp_010(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<w>d\Theta''/dp, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_010/wdthetapdp_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,w_ed_dthetadp_010(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('w''d<\Theta>/dp, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_010/wpdthetadp_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,w_ed_dtheta_ed_dp_010(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('w''d\Theta''/dp, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_010/wpdthetapdp_010.png')





