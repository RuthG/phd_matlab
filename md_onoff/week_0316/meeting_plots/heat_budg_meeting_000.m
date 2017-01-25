%produce tidy version of the heat budget terms

%calculate advective heat transport terms carefully on the lat-lon grid


% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_000_best/';
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

load('/project/rg312/mat_files/heat_rates_best.mat','htrt_000')
htrt_000_ll = cube2latlon(xc,yc,htrt_000(:,:,:,360),xi,yi).*86400;
htrt_000_ll_tav = cube2latlon(xc,yc,mean(htrt_000,4),xi,yi).*86400;
htrt_ed_000_ll = htrt_000_ll - htrt_000_ll_tav;
clear('htrt_000')

load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat','theta_000')
theta_000_ll = cube2latlon(xc,yc,theta_000(:,:,:,360),xi,yi);
theta_after_ll = cube2latlon(xc,yc,theta_000(:,:,:,361),xi,yi);
theta_000_ll_tav = cube2latlon(xc,yc,mean(theta_000,4),xi,yi);
theta_ed_000_ll = theta_000_ll - theta_000_ll_tav;
clear('theta_000')

load('/project/rg312/mat_files/snapshot_data/uE_snapshots_best.mat','uE_000')
uE_000_ll = cube2latlon(xc,yc,uE_000(:,:,:,360),xi,yi);
uE_000_ll_tav = cube2latlon(xc,yc,mean(uE_000,4),xi,yi);
uE_ed_000_ll = uE_000_ll - uE_000_ll_tav;
clear('uE_000')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_000')
vN_000_ll = cube2latlon(xc,yc,vN_000(:,:,:,360),xi,yi);
vN_000_ll_tav = cube2latlon(xc,yc,mean(vN_000,4),xi,yi);
vN_ed_000_ll = vN_000_ll - vN_000_ll_tav;
clear('vN_000')

load('/project/rg312/mat_files/snapshot_data/w_snapshots_best.mat','w_000')
w_000_ll_half = zeros(180,90,26); w_000_ll_tav_half = zeros(180,90,26);
w_000_ll_half(:,:,1:25) = cube2latlon(xc,yc,w_000(:,:,:,360),xi,yi);
w_000_ll_tav_half(:,:,1:25) = cube2latlon(xc,yc,mean(w_000,4),xi,yi);
w_ed_000_ll_half = w_000_ll_half - w_000_ll_tav_half;
clear('w_000')

rC_half = (100000:-4000:0)';
w_ed_000_ll = shiftdim(interp1(rC_half,shiftdim(w_ed_000_ll_half,2),rC),1);
w_000_ll_tav = shiftdim(interp1(rC_half,shiftdim(w_000_ll_tav_half,2),rC),1);
w_000_ll = shiftdim(interp1(rC_half,shiftdim(w_000_ll_half,2),rC),1);

load('/project/rg312/mat_files/front_diag_full_000_best.mat')

[dtheta_ed_dy_000,dtheta_ed_dx_000,dtheta_ed_dp_000] = gradient(theta_ed_000_ll,pi./90,pi./90,-4000);
dtheta_ed_dy_000 = dtheta_ed_dy_000./radius;

[dthetady_000_tav,dthetadx_000_tav,dthetadp_000_tav] = gradient(theta_000_ll_tav,pi./90,pi./90,-4000);
dthetady_000_tav = dthetady_000_tav./radius;

for i=1:90
dtheta_ed_dx_000(:,i,:) = dtheta_ed_dx_000(:,i,:)./cos(yi(i).*pi./180)./radius;
end

udtheta_ed_dx_000 = -uE_000_ll_tav.*dtheta_ed_dx_000.*86400;
v_ed_dthetady_000 = -vN_ed_000_ll.*dthetady_000_tav.*86400;
w_ed_dthetadp_000 = -w_ed_000_ll.*dthetadp_000_tav.*86400;


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,theta_after_ll(:,:,5)' - theta_000_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,360)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('\Theta_{361} - \Theta_{360}, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','theta_change_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_000_ll(:,:,5)' + w_ed_dthetadp_000(:,:,5)' + udtheta_ed_dx_000(:,:,5)' + v_ed_dthetady_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,360)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('Sum of eddy heat budget terms, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','eddy_heat_budg_sum_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,360)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('Total Diabatic Heating, eddy part, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrt_ed_000.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udtheta_ed_dx_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,360)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('<u>d\Theta''/dx, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','udthetapdx_000.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,v_ed_dthetady_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,360)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('v''d<\Theta>/dy, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vpdthetady_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,w_ed_dthetadp_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,360)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('w''d<\Theta>/dp, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wpdthetadp_000.png')

