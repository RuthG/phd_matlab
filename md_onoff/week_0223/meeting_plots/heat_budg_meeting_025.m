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

[dtheta_ed_dy_025,dtheta_ed_dx_025,dtheta_ed_dp_025] = gradient(theta_ed_025_ll,pi./90,pi./90,-4000);
dtheta_ed_dy_025 = dtheta_ed_dy_025./radius;

[dthetady_025_tav,dthetadx_025_tav,dthetadp_025_tav] = gradient(theta_025_ll_tav,pi./90,pi./90,-4000);
dthetady_025_tav = dthetady_025_tav./radius;

for i=1:90
dtheta_ed_dx_025(:,i,:) = dtheta_ed_dx_025(:,i,:)./cos(yi(i).*pi./180)./radius;
end

udtheta_ed_dx_025 = -uE_025_ll_tav.*dtheta_ed_dx_025.*86400;
v_ed_dthetady_025 = -vN_ed_025_ll.*dthetady_025_tav.*86400;
w_ed_dthetadp_025 = -w_ed_025_ll.*dthetadp_025_tav.*86400;


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,theta_after_ll(:,:,5)' - theta_025_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('\Theta_{361} - \Theta_{360}, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','theta_change_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_025_ll(:,:,5)' + w_ed_dthetadp_025(:,:,5)' + udtheta_ed_dx_025(:,:,5)' + v_ed_dthetady_025(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('Sum of eddy heat budget terms, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','eddy_heat_budg_sum_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_025_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('Total Diabatic Heating, eddy part, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrt_ed_025.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udtheta_ed_dx_025(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('<u>d\Theta''/dx, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','udthetapdx_025.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,v_ed_dthetady_025(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('v''d<\Theta>/dy, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vpdthetady_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,w_ed_dthetadp_025(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('w''d<\Theta>/dp, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wpdthetadp_025.png')

