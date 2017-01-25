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

load('/project/rg312/mat_files/heat_rates.mat','htrt_050')
htrt_050_ll = cube2latlon(xc,yc,htrt_050(:,:,:,360),xi,yi).*86400;
htrt_050_ll_tav = cube2latlon(xc,yc,mean(htrt_050,4),xi,yi).*86400;
htrt_ed_050_ll = htrt_050_ll - htrt_050_ll_tav;
clear('htrt_050')

load('/project/rg312/mat_files/snapshot_data/theta_snapshots.mat','theta_050')
theta_050_ll = cube2latlon(xc,yc,theta_050(:,:,:,360),xi,yi);
theta_after_ll = cube2latlon(xc,yc,theta_050(:,:,:,361),xi,yi);
theta_050_ll_tav = cube2latlon(xc,yc,mean(theta_050,4),xi,yi);
theta_ed_050_ll = theta_050_ll - theta_050_ll_tav;
clear('theta_050')

load('/project/rg312/mat_files/snapshot_data/uE_snapshots.mat','uE_050')
uE_050_ll = cube2latlon(xc,yc,uE_050(:,:,:,360),xi,yi);
uE_050_ll_tav = cube2latlon(xc,yc,mean(uE_050,4),xi,yi);
uE_ed_050_ll = uE_050_ll - uE_050_ll_tav;
clear('uE_050')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat','vN_050')
vN_050_ll = cube2latlon(xc,yc,vN_050(:,:,:,360),xi,yi);
vN_050_ll_tav = cube2latlon(xc,yc,mean(vN_050,4),xi,yi);
vN_ed_050_ll = vN_050_ll - vN_050_ll_tav;
clear('vN_050')

load('/project/rg312/mat_files/snapshot_data/w_snapshots.mat','w_050')
w_050_ll_half = zeros(180,90,26); w_050_ll_tav_half = zeros(180,90,26);
w_050_ll_half(:,:,1:25) = cube2latlon(xc,yc,w_050(:,:,:,360),xi,yi);
w_050_ll_tav_half(:,:,1:25) = cube2latlon(xc,yc,mean(w_050,4),xi,yi);
w_ed_050_ll_half = w_050_ll_half - w_050_ll_tav_half;
clear('w_050')

rC_half = (100000:-4000:0)';
w_ed_050_ll = shiftdim(interp1(rC_half,shiftdim(w_ed_050_ll_half,2),rC),1);
w_050_ll_tav = shiftdim(interp1(rC_half,shiftdim(w_050_ll_tav_half,2),rC),1);
w_050_ll = shiftdim(interp1(rC_half,shiftdim(w_050_ll_half,2),rC),1);

load('/project/rg312/mat_files/front_diag.mat')

[dtheta_ed_dy_050,dtheta_ed_dx_050,dtheta_ed_dp_050] = gradient(theta_ed_050_ll,pi./90,pi./90,-4000);
dtheta_ed_dy_050 = dtheta_ed_dy_050./radius;

[dthetady_050_tav,dthetadx_050_tav,dthetadp_050_tav] = gradient(theta_050_ll_tav,pi./90,pi./90,-4000);
dthetady_050_tav = dthetady_050_tav./radius;

for i=1:90
dtheta_ed_dx_050(:,i,:) = dtheta_ed_dx_050(:,i,:)./cos(yi(i).*pi./180)./radius;
end

udtheta_ed_dx_050 = -uE_050_ll_tav.*dtheta_ed_dx_050.*86400;
v_ed_dthetady_050 = -vN_ed_050_ll.*dthetady_050_tav.*86400;
w_ed_dthetadp_050 = -w_ed_050_ll.*dthetadp_050_tav.*86400;


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,theta_after_ll(:,:,5)' - theta_050_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('\Theta_{361} - \Theta_{360}, K/day, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','theta_change_050.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_050_ll(:,:,5)' + w_ed_dthetadp_050(:,:,5)' + udtheta_ed_dx_050(:,:,5)' + v_ed_dthetady_050(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('Sum of eddy heat budget terms, K/day, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','eddy_heat_budg_sum_050.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_050_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('Total Diabatic Heating, eddy part, K/day, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrt_ed_050.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udtheta_ed_dx_050(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('<u>d\Theta''/dx, K/day, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','udthetapdx_050.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,v_ed_dthetady_050(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('v''d<\Theta>/dy, K/day, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vpdthetady_050.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,w_ed_dthetadp_050(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('w''d<\Theta>/dp, K/day, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wpdthetadp_050.png')

