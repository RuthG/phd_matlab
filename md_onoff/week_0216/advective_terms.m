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


convtheta(1,1,:)=(rC/101325.0).^(2./7.);
convthetatoT=repmat(convtheta,[180,90,1]);

load('/project/rg312/mat_files/heat_rates.mat','htrt_000')
htrt_000_ll = cube2latlon(xc,yc,htrt_000(:,:,:,360),xi,yi).*86400.*convthetatoT;
htrt_000_ll_tav = cube2latlon(xc,yc,mean(htrt_000,4),xi,yi).*86400.*convthetatoT;
htrt_ed_000_ll = htrt_000_ll - htrt_000_ll_tav;

htrt_000_ll_zav = squeeze(mean(htrt_000_ll,1));
htrt_000_ll_tav_zav = squeeze(mean(htrt_000_ll_tav,1));
htrt_ed_000_ll_zav = squeeze(mean(htrt_ed_000_ll,1));

load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat')
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

t_000_ll = cube2latlon(xc,yc,t_000(:,:,:,360),xi,yi);
t_000_ll_tav = cube2latlon(xc,yc,mean(t_000,4),xi,yi);
t_ed_000_ll = t_000_ll - t_000_ll_tav;
clear('t_000','t_010','t_025','t_050','t_075','t_100')

uE_000_ll = cube2latlon(xc,yc,uE_000(:,:,:,360),xi,yi);
uE_000_ll_tav = cube2latlon(xc,yc,mean(uE_000,4),xi,yi);
uE_ed_000_ll = uE_000_ll - uE_000_ll_tav;
clear('uE_000','uE_010','uE_025','uE_050','uE_075','uE_100')

vN_000_ll = cube2latlon(xc,yc,vN_000(:,:,:,360),xi,yi);
vN_000_ll_tav = cube2latlon(xc,yc,mean(vN_000,4),xi,yi);
vN_ed_000_ll = vN_000_ll - vN_000_ll_tav;
clear('vN_000','vN_010','vN_025','vN_050','vN_075','vN_100')


[dTdy_000,dTdx_000,dTdp_000] = gradient(t_000_ll,pi./90,pi./90,-4000);
dTdy_000 = dTdy_000./radius;

[dTdy_000_tav,dTdx_000_tav,dTdp_000_tav] = gradient(t_000_ll_tav,pi./90,pi./90,-4000);
dTdy_000_tav = dTdy_000_tav./radius;

[dT_ed_dy_000,dT_ed_dx_000,dT_ed_dp_000] = gradient(t_ed_000_ll,pi./90,pi./90,-4000);
dT_ed_dy_000 = dT_ed_dy_000./radius;

for i=1:90
dT_ed_dx_000(:,i,:) = dT_ed_dx_000(:,i,:)./cos(yi(i).*pi./180)./radius;
dTdx_000_tav(:,i,:) = dTdx_000_tav(:,i,:)./cos(yi(i).*pi./180)./radius;
dTdx_000(:,i,:) = dTdx_000(:,i,:)./cos(yi(i).*pi./180)./radius;
end

udT_ed_dx_000 = -uE_000_ll_tav.*dT_ed_dx_000.*86400;
u_ed_dTdx_000 = -uE_ed_000_ll.*dTdx_000_tav.*86400;
vdT_ed_dy_000 = -vN_000_ll_tav.*dT_ed_dy_000.*86400;
v_ed_dTdy_000 = -vN_ed_000_ll.*dTdy_000_tav.*86400;
wdT_ed_dp_000 = -w_000_ll_tav.*dT_ed_dp_000.*86400;
w_ed_dTdp_000 = -w_ed_000_ll.*dTdp_000_tav.*86400;

udTdx_000_tav = -uE_000_ll_tav.*dTdx_000_tav.*86400;
vdTdy_000_tav = -vN_000_ll_tav.*dTdy_000_tav.*86400;
wdTdp_000_tav = -w_000_ll_tav.*dTdp_000_tav.*86400;

udTdx_000 = -uE_000_ll.*dTdx_000.*86400;
vdTdy_000 = -vN_000_ll.*dTdy_000.*86400;
wdTdp_000 = -w_000_ll.*dTdp_000.*86400;

u_ed_dT_ed_dx_000 = -uE_ed_000_ll.*dT_ed_dx_000.*86400;
v_ed_dT_ed_dy_000 = -vN_ed_000_ll.*dT_ed_dy_000.*86400;
w_ed_dT_ed_dp_000 = -w_ed_000_ll.*dT_ed_dp_000.*86400;

%calculate zonal averages for comparison...
udT_ed_dx_000_zav = squeeze(mean(udT_ed_dx_000,1));
vdT_ed_dy_000_zav = squeeze(mean(vdT_ed_dy_000,1));
wdT_ed_dp_000_zav = squeeze(mean(wdT_ed_dp_000,1));

u_ed_dTdx_000_zav = squeeze(mean(u_ed_dTdx_000,1));
v_ed_dTdy_000_zav = squeeze(mean(v_ed_dTdy_000,1));
w_ed_dTdp_000_zav = squeeze(mean(w_ed_dTdp_000,1));

udTdx_000_tav_zav = squeeze(mean(udTdx_000_tav,1));
vdTdy_000_tav_zav = squeeze(mean(vdTdy_000_tav,1));
wdTdp_000_tav_zav = squeeze(mean(wdTdp_000_tav,1));

udTdx_000_zav  = squeeze(mean(udTdx_000,1));
vdTdy_000_zav  = squeeze(mean(vdTdy_000,1));
wdTdp_000_zav  = squeeze(mean(wdTdp_000,1));

u_ed_dT_ed_dx_000_zav = squeeze(mean(u_ed_dT_ed_dx_000,1));
v_ed_dT_ed_dy_000_zav = squeeze(mean(v_ed_dT_ed_dy_000,1));
w_ed_dT_ed_dp_000_zav = squeeze(mean(w_ed_dT_ed_dp_000,1));


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
[C,h] = contourf(xi,yi,udTdx_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('udTdx, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/udtdx_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udTdx_000_tav(:,:,5)',v);
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
print('-dpng','heat_budg_issues/udtdx_tav_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udT_ed_dx_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<u>dT''dx, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/udtpdx_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,u_ed_dTdx_000(:,:,5)',v);
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
print('-dpng','heat_budg_issues/updtdx_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,u_ed_dT_ed_dx_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('u''dT''dx, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/updtpdx_000.png')




figure
v=-15:1:15;
[C,h] = contourf(xi,yi,vdTdy_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('vdTdy, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/vdtdy_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,vdTdy_000_tav(:,:,5)',v);
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
print('-dpng','heat_budg_issues/vdtdy_tav_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,vdT_ed_dy_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<v>dT''dy, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/vdtpdy_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,v_ed_dTdy_000(:,:,5)',v);
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
print('-dpng','heat_budg_issues/vpdtdy_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,v_ed_dT_ed_dy_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('v''dT''dy, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/vpdtpdy_000.png')




figure
v=-15:1:15;
[C,h] = contourf(xi,yi,wdTdp_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('wdTdp, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/wdtdp_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,wdTdp_000_tav(:,:,5)',v);
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
print('-dpng','heat_budg_issues/wdtdp_tav_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,wdT_ed_dp_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('<w>dT''dp, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/wdtpdp_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,w_ed_dTdp_000(:,:,5)',v);
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
print('-dpng','heat_budg_issues/wpdtdp_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,w_ed_dT_ed_dp_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('w''dT''dp, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/wpdtpdp_000.png')






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
[C,h] = contourf(yi,rC./100,udTdx_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('udTdx, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/udtdx_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,udTdx_000_tav_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('<u>d<T>dx, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/udtdx_tav_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,udT_ed_dx_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('<u>dT''dx, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/udtpdx_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,u_ed_dTdx_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('u''d<T>dx, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/updtdx_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,u_ed_dT_ed_dx_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('u''dT''dx, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/updtpdx_000_zav.png')




figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,vdTdy_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('vdTdy, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/vdtdy_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,vdTdy_000_tav_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('<v>d<T>dy, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/vdtdy_tav_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,vdT_ed_dy_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('<v>dT''dy, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/vdtpdy_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,v_ed_dTdy_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('v''d<T>dy, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/vpdtdy_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,v_ed_dT_ed_dy_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('v''dT''dy, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/vpdtpdy_000_zav.png')




figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,wdTdp_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('wdTdp, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/wdtdp_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,wdTdp_000_tav_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('<w>d<T>dp, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/wdtdp_tav_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,wdT_ed_dp_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('<w>dT''dp, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/wdtpdp_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,w_ed_dTdp_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('w''d<T>dp, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/wpdtdp_000_zav.png')

figure
v=-2:0.2:2;
[C,h] = contourf(yi,rC./100,w_ed_dT_ed_dp_000_zav',v);
set(gca,'YDir','reverse')
set(h,'LineColor','none')
set(gca,'FontSize',15)
caxis([-2 2]);
colorbar
title('w''dT''dp, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_issues/wpdtpdp_000_zav.png')
