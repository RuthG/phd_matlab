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

load('/project/rg312/mat_files/heat_rates.mat','htrt_025')
htrt_025_ll = cube2latlon(xc,yc,htrt_025(:,:,:,360),xi,yi).*86400;
htrt_025_ll_tav = cube2latlon(xc,yc,mean(htrt_025,4),xi,yi).*86400;
htrt_ed_025_ll = htrt_025_ll - htrt_025_ll_tav;
clear('htrt_025')

load('/project/rg312/mat_files/snapshot_data/theta_snapshots.mat','theta_025')
theta_025_ll = cube2latlon(xc,yc,theta_025(:,:,:,360),xi,yi);
theta_after_ll = cube2latlon(xc,yc,theta_025(:,:,:,361),xi,yi);
theta_025_ll_tav = cube2latlon(xc,yc,mean(theta_025,4),xi,yi);
theta_ed_025_ll = theta_025_ll - theta_025_ll_tav;
clear('theta_025')

load('/project/rg312/mat_files/snapshot_data/uE_snapshots.mat','uE_025')
uE_025_ll = cube2latlon(xc,yc,uE_025(:,:,:,360),xi,yi);
uE_025_ll_tav = cube2latlon(xc,yc,mean(uE_025,4),xi,yi);
uE_ed_025_ll = uE_025_ll - uE_025_ll_tav;
clear('uE_025')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat','vN_025')
vN_025_ll = cube2latlon(xc,yc,vN_025(:,:,:,360),xi,yi);
vN_025_ll_tav = cube2latlon(xc,yc,mean(vN_025,4),xi,yi);
vN_ed_025_ll = vN_025_ll - vN_025_ll_tav;
clear('vN_025')

load('/project/rg312/mat_files/snapshot_data/w_snapshots.mat','w_025')
w_025_ll_half = zeros(180,90,26); w_025_ll_tav_half = zeros(180,90,26);
w_025_ll_half(:,:,1:25) = cube2latlon(xc,yc,w_025(:,:,:,360),xi,yi);
w_025_ll_tav_half(:,:,1:25) = cube2latlon(xc,yc,mean(w_025,4),xi,yi);
w_ed_025_ll_half = w_025_ll_half - w_025_ll_tav_half;
clear('w_025')

rC_half = (100000:-4000:0)';
w_ed_025_ll = shiftdim(interp1(rC_half,shiftdim(w_ed_025_ll_half,2),rC),1);
w_025_ll_tav = shiftdim(interp1(rC_half,shiftdim(w_025_ll_tav_half,2),rC),1);
w_025_ll = shiftdim(interp1(rC_half,shiftdim(w_025_ll_half,2),rC),1);

load('/project/rg312/mat_files/front_diag.mat')


[dthetady_025,dthetadx_025,dthetadp_025] = gradient(theta_025_ll,pi./90,pi./90,-4000);
dthetady_025 = dthetady_025./radius;

[dthetady_025_tav,dthetadx_025_tav,dthetadp_025_tav] = gradient(theta_025_ll_tav,pi./90,pi./90,-4000);
dthetady_025_tav = dthetady_025_tav./radius;

[dtheta_ed_dy_025,dtheta_ed_dx_025,dtheta_ed_dp_025] = gradient(theta_ed_025_ll,pi./90,pi./90,-4000);
dtheta_ed_dy_025 = dtheta_ed_dy_025./radius;

for i=1:90
dtheta_ed_dx_025(:,i,:) = dtheta_ed_dx_025(:,i,:)./cos(yi(i).*pi./180)./radius;
dthetadx_025_tav(:,i,:) = dthetadx_025_tav(:,i,:)./cos(yi(i).*pi./180)./radius;
dthetadx_025(:,i,:) = dthetadx_025(:,i,:)./cos(yi(i).*pi./180)./radius;
end

udtheta_ed_dx_025 = -uE_025_ll_tav.*dtheta_ed_dx_025.*86400;
vdtheta_ed_dy_025 = -vN_025_ll_tav.*dtheta_ed_dy_025.*86400;
wdtheta_ed_dp_025 = -w_025_ll_tav.*dtheta_ed_dp_025.*86400;

u_ed_dthetadx_025 = -uE_ed_025_ll.*dthetadx_025_tav.*86400;
v_ed_dthetady_025 = -vN_ed_025_ll.*dthetady_025_tav.*86400;
w_ed_dthetadp_025 = -w_ed_025_ll.*dthetadp_025_tav.*86400;

udthetadx_025_tav = -uE_025_ll_tav.*dthetadx_025_tav.*86400;
vdthetady_025_tav = -vN_025_ll_tav.*dthetady_025_tav.*86400;
wdthetadp_025_tav = -w_025_ll_tav.*dthetadp_025_tav.*86400;

udthetadx_025 = -uE_025_ll.*dthetadx_025.*86400;
vdthetady_025 = -vN_025_ll.*dthetady_025.*86400;
wdthetadp_025 = -w_025_ll.*dthetadp_025.*86400;

u_ed_dtheta_ed_dx_025 = -uE_ed_025_ll.*dtheta_ed_dx_025.*86400;
v_ed_dtheta_ed_dy_025 = -vN_ed_025_ll.*dtheta_ed_dy_025.*86400;
w_ed_dtheta_ed_dp_025 = -w_ed_025_ll.*dtheta_ed_dp_025.*86400;




figure
v=-15:1:15;
[C,h] = contourf(xi,yi,theta_after_ll(:,:,5)' - theta_025_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('\Theta_{361} - \Theta_{360}, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','theta_change_025.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_025_ll(:,:,5)' + wdthetadp_025(:,:,5)' + udthetadx_025(:,:,5)' + vdthetady_025(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Sum of total heat budget terms, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','tot_heat_budg_sum_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_025_ll_tav(:,:,5)' + wdthetadp_025_tav(:,:,5)' + udthetadx_025_tav(:,:,5)' + vdthetady_025_tav(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Sum of time mean heat budget terms, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','tav_heat_budg_sum_025.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_025_ll(:,:,5)' + w_ed_dthetadp_025(:,:,5)' + wdtheta_ed_dp_025(:,:,5)' + w_ed_dtheta_ed_dp_025(:,:,5)' + u_ed_dthetadx_025(:,:,5)' + udtheta_ed_dx_025(:,:,5)' + u_ed_dtheta_ed_dx_025(:,:,5)' + v_ed_dthetady_025(:,:,5)' + vdtheta_ed_dy_025(:,:,5)' + v_ed_dtheta_ed_dy_025(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Sum of eddy heat budget terms, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','eddy_heat_budg_sum_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_025_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Total Diabatic Heating, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_total/wv_025/htrt_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_025_ll_tav(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Total Diabatic Heating, time av part, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_tav/wv_025/htrt_tav_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_025_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Total Diabatic Heating, eddy part, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_025/htrt_ed_025.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udthetadx_025(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('ud\Theta/dx, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_total/wv_025/udthetadx_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udthetadx_025_tav(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<u>d<\Theta>/dx, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_tav/wv_025/udthetadx_tav_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udtheta_ed_dx_025(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<u>d\Theta''/dx, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_025/udthetapdx_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,u_ed_dthetadx_025(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('u''d<\Theta>/dx, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_025/updthetadx_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,u_ed_dtheta_ed_dx_025(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('u''d\Theta''/dx, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_025/updtpdx_025.png')




figure
v=-15:1:15;
[C,h] = contourf(xi,yi,vdthetady_025(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('vd\Theta/dy, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_total/wv_025/vdthetady_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,vdthetady_025_tav(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<v>d<\Theta>/dy, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_tav/wv_025/vdthetady_tav_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,vdtheta_ed_dy_025(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<v>d\Theta''/dy, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_025/vdthetapdy_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,v_ed_dthetady_025(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('v''d<\Theta>/dy, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_025/vpdthetady_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,v_ed_dtheta_ed_dy_025(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('v''d\Theta''/dy, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_025/vpdthetapdy_025.png')




figure
v=-15:1:15;
[C,h] = contourf(xi,yi,wdthetadp_025(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('wd\Theta/dp, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_total/wv_025/wdthetadp_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,wdthetadp_025_tav(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<w>d<\Theta>/dp, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_tav/wv_025/wdthetadp_tav_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,wdtheta_ed_dp_025(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<w>d\Theta''/dp, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_025/wdthetapdp_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,w_ed_dthetadp_025(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('w''d<\Theta>/dp, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_025/wpdthetadp_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,w_ed_dtheta_ed_dp_025(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('w''d\Theta''/dp, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_eddy/wv_025/wpdthetapdp_025.png')




