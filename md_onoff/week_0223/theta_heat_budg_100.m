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

load('/project/rg312/mat_files/heat_rates.mat','htrt_100')
htrt_100_ll = cube2latlon(xc,yc,htrt_100(:,:,:,360),xi,yi).*86400;
htrt_100_ll_tav = cube2latlon(xc,yc,mean(htrt_100,4),xi,yi).*86400;
htrt_ed_100_ll = htrt_100_ll - htrt_100_ll_tav;
clear('htrt_100')

load('/project/rg312/mat_files/snapshot_data/theta_snapshots.mat','theta_100')
theta_100_ll = cube2latlon(xc,yc,theta_100(:,:,:,360),xi,yi);
theta_after_ll = cube2latlon(xc,yc,theta_100(:,:,:,361),xi,yi);
theta_100_ll_tav = cube2latlon(xc,yc,mean(theta_100,4),xi,yi);
theta_ed_100_ll = theta_100_ll - theta_100_ll_tav;
clear('theta_100')

load('/project/rg312/mat_files/snapshot_data/uE_snapshots.mat','uE_100')
uE_100_ll = cube2latlon(xc,yc,uE_100(:,:,:,360),xi,yi);
uE_100_ll_tav = cube2latlon(xc,yc,mean(uE_100,4),xi,yi);
uE_ed_100_ll = uE_100_ll - uE_100_ll_tav;
clear('uE_100')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat','vN_100')
vN_100_ll = cube2latlon(xc,yc,vN_100(:,:,:,360),xi,yi);
vN_100_ll_tav = cube2latlon(xc,yc,mean(vN_100,4),xi,yi);
vN_ed_100_ll = vN_100_ll - vN_100_ll_tav;
clear('vN_100')

load('/project/rg312/mat_files/snapshot_data/w_snapshots.mat','w_100')
w_100_ll_half = zeros(180,90,26); w_100_ll_tav_half = zeros(180,90,26);
w_100_ll_half(:,:,1:25) = cube2latlon(xc,yc,w_100(:,:,:,360),xi,yi);
w_100_ll_tav_half(:,:,1:25) = cube2latlon(xc,yc,mean(w_100,4),xi,yi);
w_ed_100_ll_half = w_100_ll_half - w_100_ll_tav_half;
clear('w_100')

rC_half = (100000:-4000:0)';
w_ed_100_ll = shiftdim(interp1(rC_half,shiftdim(w_ed_100_ll_half,2),rC),1);
w_100_ll_tav = shiftdim(interp1(rC_half,shiftdim(w_100_ll_tav_half,2),rC),1);
w_100_ll = shiftdim(interp1(rC_half,shiftdim(w_100_ll_half,2),rC),1);

load('/project/rg312/mat_files/front_diag.mat')


[dthetady_100,dthetadx_100,dthetadp_100] = gradient(theta_100_ll,pi./90,pi./90,-4000);
dthetady_100 = dthetady_100./radius;

[dthetady_100_tav,dthetadx_100_tav,dthetadp_100_tav] = gradient(theta_100_ll_tav,pi./90,pi./90,-4000);
dthetady_100_tav = dthetady_100_tav./radius;

[dtheta_ed_dy_100,dtheta_ed_dx_100,dtheta_ed_dp_100] = gradient(theta_ed_100_ll,pi./90,pi./90,-4000);
dtheta_ed_dy_100 = dtheta_ed_dy_100./radius;

for i=1:90
dtheta_ed_dx_100(:,i,:) = dtheta_ed_dx_100(:,i,:)./cos(yi(i).*pi./180)./radius;
dthetadx_100_tav(:,i,:) = dthetadx_100_tav(:,i,:)./cos(yi(i).*pi./180)./radius;
dthetadx_100(:,i,:) = dthetadx_100(:,i,:)./cos(yi(i).*pi./180)./radius;
end

udtheta_ed_dx_100 = -uE_100_ll_tav.*dtheta_ed_dx_100.*86400;
vdtheta_ed_dy_100 = -vN_100_ll_tav.*dtheta_ed_dy_100.*86400;
wdtheta_ed_dp_100 = -w_100_ll_tav.*dtheta_ed_dp_100.*86400;

u_ed_dthetadx_100 = -uE_ed_100_ll.*dthetadx_100_tav.*86400;
v_ed_dthetady_100 = -vN_ed_100_ll.*dthetady_100_tav.*86400;
w_ed_dthetadp_100 = -w_ed_100_ll.*dthetadp_100_tav.*86400;

udthetadx_100_tav = -uE_100_ll_tav.*dthetadx_100_tav.*86400;
vdthetady_100_tav = -vN_100_ll_tav.*dthetady_100_tav.*86400;
wdthetadp_100_tav = -w_100_ll_tav.*dthetadp_100_tav.*86400;

udthetadx_100 = -uE_100_ll.*dthetadx_100.*86400;
vdthetady_100 = -vN_100_ll.*dthetady_100.*86400;
wdthetadp_100 = -w_100_ll.*dthetadp_100.*86400;

u_ed_dtheta_ed_dx_100 = -uE_ed_100_ll.*dtheta_ed_dx_100.*86400;
v_ed_dtheta_ed_dy_100 = -vN_ed_100_ll.*dtheta_ed_dy_100.*86400;
w_ed_dtheta_ed_dp_100 = -w_ed_100_ll.*dtheta_ed_dp_100.*86400;




figure
v=-15:1:15;
[C,h] = contourf(xi,yi,theta_after_ll(:,:,5)' - theta_100_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('\Theta_{361} - \Theta_{360}, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','theta_change_100.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_100_ll(:,:,5)' + wdthetadp_100(:,:,5)' + udthetadx_100(:,:,5)' + vdthetady_100(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Sum of total heat budget terms, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','tot_heat_budg_sum_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_100_ll_tav(:,:,5)' + wdthetadp_100_tav(:,:,5)' + udthetadx_100_tav(:,:,5)' + vdthetady_100_tav(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Sum of time mean heat budget terms, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','tav_heat_budg_sum_100.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_100_ll(:,:,5)' + w_ed_dthetadp_100(:,:,5)' + wdtheta_ed_dp_100(:,:,5)' + w_ed_dtheta_ed_dp_100(:,:,5)' + u_ed_dthetadx_100(:,:,5)' + udtheta_ed_dx_100(:,:,5)' + u_ed_dtheta_ed_dx_100(:,:,5)' + v_ed_dthetady_100(:,:,5)' + vdtheta_ed_dy_100(:,:,5)' + v_ed_dtheta_ed_dy_100(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Sum of eddy heat budget terms, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','eddy_heat_budg_sum_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_100_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Total Diabatic Heating, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_total/wv_100/htrt_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_100_ll_tav(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Total Diabatic Heating, time av part, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_tav/wv_100/htrt_tav_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Total Diabatic Heating, eddy part, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_100/htrt_ed_100.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udthetadx_100(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('ud\Theta/dx, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_total/wv_100/udthetadx_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udthetadx_100_tav(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<u>d<\Theta>/dx, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_tav/wv_100/udthetadx_tav_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udtheta_ed_dx_100(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<u>d\Theta''/dx, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_100/udthetapdx_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,u_ed_dthetadx_100(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('u''d<\Theta>/dx, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_100/updthetadx_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,u_ed_dtheta_ed_dx_100(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('u''d\Theta''/dx, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_100/updtpdx_100.png')




figure
v=-15:1:15;
[C,h] = contourf(xi,yi,vdthetady_100(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('vd\Theta/dy, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_total/wv_100/vdthetady_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,vdthetady_100_tav(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<v>d<\Theta>/dy, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_tav/wv_100/vdthetady_tav_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,vdtheta_ed_dy_100(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<v>d\Theta''/dy, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_100/vdthetapdy_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,v_ed_dthetady_100(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('v''d<\Theta>/dy, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_100/vpdthetady_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,v_ed_dtheta_ed_dy_100(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('v''d\Theta''/dy, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_100/vpdthetapdy_100.png')




figure
v=-15:1:15;
[C,h] = contourf(xi,yi,wdthetadp_100(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('wd\Theta/dp, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_total/wv_100/wdthetadp_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,wdthetadp_100_tav(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<w>d<\Theta>/dp, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_tav/wv_100/wdthetadp_tav_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,wdtheta_ed_dp_100(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<w>d\Theta''/dp, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_100/wdthetapdp_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,w_ed_dthetadp_100(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('w''d<\Theta>/dp, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_100/wpdthetadp_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,w_ed_dtheta_ed_dp_100(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('w''d\Theta''/dp, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_100/wpdthetapdp_100.png')





