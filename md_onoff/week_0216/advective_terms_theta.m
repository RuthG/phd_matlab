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


load('/project/rg312/mat_files/heat_rates.mat','htrt_000')
htrt_000_ll = cube2latlon(xc,yc,htrt_000(:,:,:,360),xi,yi).*86400;
htrt_000_ll_tav = cube2latlon(xc,yc,mean(htrt_000,4),xi,yi).*86400;
htrt_ed_000_ll = htrt_000_ll - htrt_000_ll_tav;

htrt_000_ll_zav = squeeze(mean(htrt_000_ll,1));
htrt_000_ll_tav_zav = squeeze(mean(htrt_000_ll_tav,1));
htrt_ed_000_ll_zav = squeeze(mean(htrt_ed_000_ll,1));

load('/project/rg312/mat_files/snapshot_data/theta_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/uE_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/w_snapshots.mat')
load('/project/rg312/mat_files/front_diag.mat')

w_000_ll_half = zeros(180,90,26);
w_000_ll_tav_half = zeros(180,90,26);
w_000_ll_half(:,:,1:25) = cube2latlon(xc,yc,w_000(:,:,:,360),xi,yi);
w_000_ll_tav_half(:,:,1:25) = cube2latlon(xc,yc,mean(w_000,4),xi,yi);
w_ed_000_ll_half = w_000_ll_half - w_000_ll_tav_half;
clear('w_000','w_010','w_025','w_050','w_075','w_100')

rC_half = (100000:-4000:0)';
w_ed_000_ll = shiftdim(interp1(rC_half,shiftdim(w_ed_000_ll_half,2),rC),1);
w_000_ll_tav = shiftdim(interp1(rC_half,shiftdim(w_000_ll_tav_half,2),rC),1);
w_000_ll = shiftdim(interp1(rC_half,shiftdim(w_000_ll_half,2),rC),1);

theta_000_ll = cube2latlon(xc,yc,theta_000(:,:,:,360),xi,yi);
theta_000_ll_tav = cube2latlon(xc,yc,mean(theta_000,4),xi,yi);
theta_ed_000_ll = theta_000_ll - theta_000_ll_tav;
clear('theta_000','theta_010','theta_025','theta_050','theta_075','theta_100')

uE_000_ll = cube2latlon(xc,yc,uE_000(:,:,:,360),xi,yi);
uE_000_ll_tav = cube2latlon(xc,yc,mean(uE_000,4),xi,yi);
uE_ed_000_ll = uE_000_ll - uE_000_ll_tav;
clear('uE_000','uE_010','uE_025','uE_050','uE_075','uE_100')

vN_000_ll = cube2latlon(xc,yc,vN_000(:,:,:,360),xi,yi);
vN_000_ll_tav = cube2latlon(xc,yc,mean(vN_000,4),xi,yi);
vN_ed_000_ll = vN_000_ll - vN_000_ll_tav;
clear('vN_000','vN_010','vN_025','vN_050','vN_075','vN_100')


[dthetady_000,dthetadx_000,dthetadp_000] = gradient(theta_000_ll,pi./90,pi./90,-4000);
dthetady_000 = dthetady_000./radius;

[dthetady_000_tav,dthetadx_000_tav,dthetadp_000_tav] = gradient(theta_000_ll_tav,pi./90,pi./90,-4000);
dthetady_000_tav = dthetady_000_tav./radius;

[dtheta_ed_dy_000,dtheta_ed_dx_000,dtheta_ed_dp_000] = gradient(theta_ed_000_ll,pi./90,pi./90,-4000);
dtheta_ed_dy_000 = dtheta_ed_dy_000./radius;

for i=1:90
dtheta_ed_dx_000(:,i,:) = dtheta_ed_dx_000(:,i,:)./cos(yi(i).*pi./180)./radius;
dthetadx_000_tav(:,i,:) = dthetadx_000_tav(:,i,:)./cos(yi(i).*pi./180)./radius;
dthetadx_000(:,i,:) = dthetadx_000(:,i,:)./cos(yi(i).*pi./180)./radius;
end

udtheta_ed_dx_000 = -uE_000_ll_tav.*dtheta_ed_dx_000.*86400;
u_ed_dthetadx_000 = -uE_ed_000_ll.*dthetadx_000_tav.*86400;
vdtheta_ed_dy_000 = -vN_000_ll_tav.*dtheta_ed_dy_000.*86400;
v_ed_dthetady_000 = -vN_ed_000_ll.*dthetady_000_tav.*86400;
wdtheta_ed_dp_000 = -w_000_ll_tav.*dtheta_ed_dp_000.*86400;
w_ed_dthetadp_000 = -w_ed_000_ll.*dthetadp_000_tav.*86400;

udthetadx_000_tav = -uE_000_ll_tav.*dthetadx_000_tav.*86400;
vdthetady_000_tav = -vN_000_ll_tav.*dthetady_000_tav.*86400;
wdthetadp_000_tav = -w_000_ll_tav.*dthetadp_000_tav.*86400;

udthetadx_000 = -uE_000_ll.*dthetadx_000.*86400;
vdthetady_000 = -vN_000_ll.*dthetady_000.*86400;
wdthetadp_000 = -w_000_ll.*dthetadp_000.*86400;

u_ed_dtheta_ed_dx_000 = -uE_ed_000_ll.*dtheta_ed_dx_000.*86400;
v_ed_dtheta_ed_dy_000 = -vN_ed_000_ll.*dtheta_ed_dy_000.*86400;
w_ed_dtheta_ed_dp_000 = -w_ed_000_ll.*dtheta_ed_dp_000.*86400;

%calculate zonal averages for comparison...
udtheta_ed_dx_000_zav = squeeze(mean(udtheta_ed_dx_000,1));
vdtheta_ed_dy_000_zav = squeeze(mean(vdtheta_ed_dy_000,1));
wdtheta_ed_dp_000_zav = squeeze(mean(wdtheta_ed_dp_000,1));

u_ed_dthetadx_000_zav = squeeze(mean(u_ed_dthetadx_000,1));
v_ed_dthetady_000_zav = squeeze(mean(v_ed_dthetady_000,1));
w_ed_dthetadp_000_zav = squeeze(mean(w_ed_dthetadp_000,1));

udthetadx_000_tav_zav = squeeze(mean(udthetadx_000_tav,1));
vdthetady_000_tav_zav = squeeze(mean(vdthetady_000_tav,1));
wdthetadp_000_tav_zav = squeeze(mean(wdthetadp_000_tav,1));

udthetadx_000_zav  = squeeze(mean(udthetadx_000,1));
vdthetady_000_zav  = squeeze(mean(vdthetady_000,1));
wdthetadp_000_zav  = squeeze(mean(wdthetadp_000,1));

u_ed_dtheta_ed_dx_000_zav = squeeze(mean(u_ed_dtheta_ed_dx_000,1));
v_ed_dtheta_ed_dy_000_zav = squeeze(mean(v_ed_dtheta_ed_dy_000,1));
w_ed_dtheta_ed_dp_000_zav = squeeze(mean(w_ed_dtheta_ed_dp_000,1));


figure
contourf(xi,yi,htrt_ed_000_ll(:,:,5)' + w_ed_dthetadp_000(:,:,5)' + wdtheta_ed_dp_000(:,:,5)' + u_ed_dthetadx_000(:,:,5)' + udtheta_ed_dx_000(:,:,5)' + v_ed_dthetady_000(:,:,5)' + vdtheta_ed_dy_000(:,:,5)')

figure
contourf(xi,yi,htrt_ed_000_ll(:,:,5)' + w_ed_dthetadp_000(:,:,5)' + wdtheta_ed_dp_000(:,:,5)' + u_ed_dthetadx_000(:,:,5)' + udtheta_ed_dx_000(:,:,5)' + v_ed_dthetady_000(:,:,5)' + vdtheta_ed_dy_000(:,:,5)'  + w_ed_dtheta_ed_dp_000(:,:,5)' + u_ed_dtheta_ed_dx_000(:,:,5)' + v_ed_dtheta_ed_dy_000(:,:,5)')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_000_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Total Diabatic Heating, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/htrt_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_000_ll_tav(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Total Diabatic Heating, time av part, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/htrt_tav_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Total Diabatic Heating, eddy part, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/htrt_ed_000.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udthetadx_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('udthetadx, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/udthetadx_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udthetadx_000_tav(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<u>d<T>dx, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/udthetadx_tav_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udtheta_ed_dx_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<u>dtheta''dx, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/udthetapdx_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,u_ed_dthetadx_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('u''d<T>dx, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/updthetadx_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,u_ed_dtheta_ed_dx_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('u''dtheta''dx, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/updtpdx_000.png')




figure
v=-15:1:15;
[C,h] = contourf(xi,yi,vdthetady_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('vdthetady, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/vdthetady_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,vdthetady_000_tav(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<v>d<T>dy, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/vdthetady_tav_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,vdtheta_ed_dy_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<v>dtheta''dy, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/vdthetapdy_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,v_ed_dthetady_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('v''d<T>dy, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/vpdthetady_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,v_ed_dtheta_ed_dy_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('v''dtheta''dy, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/vpdthetapdy_000.png')




figure
v=-15:1:15;
[C,h] = contourf(xi,yi,wdthetadp_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('wdthetadp, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/wdthetadp_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,wdthetadp_000_tav(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<w>d<T>dp, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/wdthetadp_tav_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,wdthetaheta_ed_dp_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<w>dtheta''dp, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/wdthetapdp_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,w_ed_dthetadp_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('w''d<T>dp, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/wpdthetadp_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,w_ed_dtheta_ed_dp_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('w''dtheta''dp, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/wpdthetapdp_000.png')






figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,htrt_000_ll_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('Total Diabatic Heating, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/htrt_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,htrt_000_ll_tav_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('Total Diabatic Heating, time av part, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/htrt_tav_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,htrt_ed_000_ll_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('Total Diabatic Heating, eddy part, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/htrt_ed_000_zav.png')


figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,udthetadx_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('udthetadx, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/udthetadx_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,udthetadx_000_tav_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('<u>d<T>dx, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/udthetadx_tav_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,udtheta_ed_dx_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('<u>dtheta''dx, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/udthetapdx_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,u_ed_dthetadx_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('u''d<T>dx, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/updthetadx_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,u_ed_dtheta_ed_dx_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('u''dtheta''dx, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/updthetapdx_000_zav.png')




figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,vdthetady_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('vdthetady, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/vdthetady_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,vdthetady_000_tav_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('<v>d<T>dy, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/vdthetady_tav_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,vdtheta_ed_dy_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('<v>dtheta''dy, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/vdthetapdy_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,v_ed_dthetady_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('v''d<T>dy, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/vpdthetady_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,v_ed_dtheta_ed_dy_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('v''dtheta''dy, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/vpdthetapdy_000_zav.png')




figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,wdthetadp_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('wdthetadp, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/wdthetadp_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,wdthetadp_000_tav_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('<w>d<T>dp, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/wdthetadp_tav_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,wdtheta_ed_dp_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('<w>dtheta''dp, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/wdthetapdp_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,w_ed_dthetadp_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('w''d<T>dp, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/wpdthetadp_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,w_ed_dtheta_ed_dp_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('w''dtheta''dp, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/wpdthetapdp_000_zav.png')
