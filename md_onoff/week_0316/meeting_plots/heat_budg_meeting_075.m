%produce tidy version of the heat budget terms

%calculate advective heat transport terms carefully on the lat-lon grid


% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_075_best/';
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

load('/project/rg312/mat_files/heat_rates_best.mat','htrt_075')
htrt_075_ll = cube2latlon(xc,yc,htrt_075(:,:,:,360),xi,yi).*86400;
htrt_075_ll_tav = cube2latlon(xc,yc,mean(htrt_075,4),xi,yi).*86400;
htrt_ed_075_ll = htrt_075_ll - htrt_075_ll_tav;
clear('htrt_075')

load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat','theta_075')
theta_075_ll = cube2latlon(xc,yc,theta_075(:,:,:,360),xi,yi);
theta_after_ll = cube2latlon(xc,yc,theta_075(:,:,:,361),xi,yi);
theta_075_ll_tav = cube2latlon(xc,yc,mean(theta_075,4),xi,yi);
theta_ed_075_ll = theta_075_ll - theta_075_ll_tav;
clear('theta_075')

load('/project/rg312/mat_files/snapshot_data/uE_snapshots_best.mat','uE_075')
uE_075_ll = cube2latlon(xc,yc,uE_075(:,:,:,360),xi,yi);
uE_075_ll_tav = cube2latlon(xc,yc,mean(uE_075,4),xi,yi);
uE_ed_075_ll = uE_075_ll - uE_075_ll_tav;
clear('uE_075')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_075')
vN_075_ll = cube2latlon(xc,yc,vN_075(:,:,:,360),xi,yi);
vN_075_ll_tav = cube2latlon(xc,yc,mean(vN_075,4),xi,yi);
vN_ed_075_ll = vN_075_ll - vN_075_ll_tav;
clear('vN_075')

load('/project/rg312/mat_files/snapshot_data/w_snapshots_best.mat','w_075')
w_075_ll_half = zeros(180,90,26); w_075_ll_tav_half = zeros(180,90,26);
w_075_ll_half(:,:,1:25) = cube2latlon(xc,yc,w_075(:,:,:,360),xi,yi);
w_075_ll_tav_half(:,:,1:25) = cube2latlon(xc,yc,mean(w_075,4),xi,yi);
w_ed_075_ll_half = w_075_ll_half - w_075_ll_tav_half;
clear('w_075')

rC_half = (100000:-4000:0)';
w_ed_075_ll = shiftdim(interp1(rC_half,shiftdim(w_ed_075_ll_half,2),rC),1);
w_075_ll_tav = shiftdim(interp1(rC_half,shiftdim(w_075_ll_tav_half,2),rC),1);
w_075_ll = shiftdim(interp1(rC_half,shiftdim(w_075_ll_half,2),rC),1);

load('/project/rg312/mat_files/front_diag_full_075_best.mat')

[dtheta_ed_dy_075,dtheta_ed_dx_075,dtheta_ed_dp_075] = gradient(theta_ed_075_ll,pi./90,pi./90,-4000);
dtheta_ed_dy_075 = dtheta_ed_dy_075./radius;

[dthetady_075_tav,dthetadx_075_tav,dthetadp_075_tav] = gradient(theta_075_ll_tav,pi./90,pi./90,-4000);
dthetady_075_tav = dthetady_075_tav./radius;

for i=1:90
dtheta_ed_dx_075(:,i,:) = dtheta_ed_dx_075(:,i,:)./cos(yi(i).*pi./180)./radius;
end

udtheta_ed_dx_075 = -uE_075_ll_tav.*dtheta_ed_dx_075.*86400;
v_ed_dthetady_075 = -vN_ed_075_ll.*dthetady_075_tav.*86400;
w_ed_dthetadp_075 = -w_ed_075_ll.*dthetadp_075_tav.*86400;


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,theta_after_ll(:,:,5)' - theta_075_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,360)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('\Theta_{361} - \Theta_{360}, K/day, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','theta_change_075.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_075_ll(:,:,5)' + w_ed_dthetadp_075(:,:,5)' + udtheta_ed_dx_075(:,:,5)' + v_ed_dthetady_075(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,360)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('Sum of eddy heat budget terms, K/day, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','eddy_heat_budg_sum_075.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,360)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('Total Diabatic Heating, eddy part, K/day, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrt_ed_075.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udtheta_ed_dx_075(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,360)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('<u>d\Theta''/dx, K/day, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','udthetapdx_075.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,v_ed_dthetady_075(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,360)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('v''d<\Theta>/dy, K/day, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vpdthetady_075.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,w_ed_dthetadp_075(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,360)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('w''d<\Theta>/dp, K/day, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wpdthetadp_075.png')

