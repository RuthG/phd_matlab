%load in v't' and t' and theta data from new runs
%plot v't', and t' with dthetadp in grey contours on top


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
ny=90;
xi=-179:2:180;yi=-89:2:90;

load('/project/rg312/mat_files/front_diag_full_000_best.mat')
front_diag_000 = arnaud_diag_000(:,:,360); 
clear('arnaud_diag_000');
load('/project/rg312/mat_files/front_diag_full_010_best.mat')
front_diag_010 = arnaud_diag_010(:,:,360); 
clear('arnaud_diag_010');
load('/project/rg312/mat_files/front_diag_full_025_best.mat')
front_diag_025 = arnaud_diag_025(:,:,360); 
clear('arnaud_diag_025');
load('/project/rg312/mat_files/front_diag_full_050_best.mat')
front_diag_050 = arnaud_diag_050(:,:,360); 
clear('arnaud_diag_050');
load('/project/rg312/mat_files/front_diag_full_075_best.mat')
front_diag_075 = arnaud_diag_075(:,:,360); 
clear('arnaud_diag_075');
load('/project/rg312/mat_files/front_diag_full_100_best.mat')
front_diag_100 = arnaud_diag_100(:,:,360); 
clear('arnaud_diag_100');

load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat')
theta_000_ll = cube2latlon(xc,yc,theta_000(:,:,:,360),xi,yi);
theta_010_ll = cube2latlon(xc,yc,theta_010(:,:,:,360),xi,yi);
theta_025_ll = cube2latlon(xc,yc,theta_025(:,:,:,360),xi,yi);
theta_050_ll = cube2latlon(xc,yc,theta_050(:,:,:,360),xi,yi);
theta_075_ll = cube2latlon(xc,yc,theta_075(:,:,:,360),xi,yi);
theta_100_ll = cube2latlon(xc,yc,theta_100(:,:,:,360),xi,yi);
clear('theta_000','theta_010','theta_025','theta_050','theta_075','theta_100')

[a,b,dthetadp_000] = gradient(theta_000_ll,-40);
[a,b,dthetadp_010] = gradient(theta_010_ll,-40);
[a,b,dthetadp_025] = gradient(theta_025_ll,-40);
[a,b,dthetadp_050] = gradient(theta_050_ll,-40);
[a,b,dthetadp_075] = gradient(theta_075_ll,-40);
[a,b,dthetadp_100] = gradient(theta_100_ll,-40);

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat')
t_ed_000_ll = cube2latlon(xc,yc,t_000(:,:,5,360) - mean(t_000(:,:,5,:),4),xi,yi);
t_ed_010_ll = cube2latlon(xc,yc,t_010(:,:,5,360) - mean(t_010(:,:,5,:),4),xi,yi);
t_ed_025_ll = cube2latlon(xc,yc,t_025(:,:,5,360) - mean(t_025(:,:,5,:),4),xi,yi);
t_ed_050_ll = cube2latlon(xc,yc,t_050(:,:,5,360) - mean(t_050(:,:,5,:),4),xi,yi);
t_ed_075_ll = cube2latlon(xc,yc,t_075(:,:,5,360) - mean(t_075(:,:,5,:),4),xi,yi);
t_ed_100_ll = cube2latlon(xc,yc,t_100(:,:,5,360) - mean(t_100(:,:,5,:),4),xi,yi);
clear('t_000','t_010','t_025','t_050','t_075','t_100')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat')
vN_ed_000_ll = cube2latlon(xc,yc,vN_000(:,:,5,360) - mean(vN_000(:,:,5,:),4),xi,yi);
vN_ed_010_ll = cube2latlon(xc,yc,vN_010(:,:,5,360) - mean(vN_010(:,:,5,:),4),xi,yi);
vN_ed_025_ll = cube2latlon(xc,yc,vN_025(:,:,5,360) - mean(vN_025(:,:,5,:),4),xi,yi);
vN_ed_050_ll = cube2latlon(xc,yc,vN_050(:,:,5,360) - mean(vN_050(:,:,5,:),4),xi,yi);
vN_ed_075_ll = cube2latlon(xc,yc,vN_075(:,:,5,360) - mean(vN_075(:,:,5,:),4),xi,yi);
vN_ed_100_ll = cube2latlon(xc,yc,vN_100(:,:,5,360) - mean(vN_100(:,:,5,:),4),xi,yi);
clear('vN_000','vN_010','vN_025','vN_050','vN_075','vN_100')

vt_ed_000_ll = vN_ed_000_ll.*t_ed_000_ll;
vt_ed_010_ll = vN_ed_010_ll.*t_ed_010_ll;
vt_ed_025_ll = vN_ed_025_ll.*t_ed_025_ll;
vt_ed_050_ll = vN_ed_050_ll.*t_ed_050_ll;
vt_ed_075_ll = vN_ed_075_ll.*t_ed_075_ll;
vt_ed_100_ll = vN_ed_100_ll.*t_ed_100_ll;



figure
v=-160:10:160;
[C,h] = contourf(xi,yi,vt_ed_000_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_000',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
colormap(b2r(-160,160));
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('v''T'', Km/s, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vt_ed_000.png')

figure
v=-160:10:160;
[C,h] = contourf(xi,yi,vt_ed_010_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_010',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
colormap(b2r(-160,160));
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('v''T'', Km/s, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vt_ed_010.png')

figure
v=-160:10:160;
[C,h] = contourf(xi,yi,vt_ed_025_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_025',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
colormap(b2r(-160,160));
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('v''T'', Km/s, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vt_ed_025.png')

figure
v=-160:10:160;
[C,h] = contourf(xi,yi,vt_ed_050_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_050',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
colormap(b2r(-160,160));
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('v''T'', Km/s, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vt_ed_050.png')

figure
v=-160:10:160;
[C,h] = contourf(xi,yi,vt_ed_075_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_075',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
colormap(b2r(-160,160));
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('v''T'', Km/s, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vt_ed_075.png')

figure
v=-160:10:160;
[C,h] = contourf(xi,yi,vt_ed_100_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_100',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
colormap(b2r(-160,160));
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('v''T'', Km/s, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vt_ed_100.png')




figure
v=-12:1:12;
[C,h] = contourf(xi,yi,t_ed_000_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_000',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
colormap(b2r(-12,12));
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('T'', K, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','t_ed_000.png')

figure
v=-12:1:12;
[C,h] = contourf(xi,yi,t_ed_010_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_010',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
colormap(b2r(-12,12));
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('T'', K, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','t_ed_010.png')

figure
v=-12:1:12;
[C,h] = contourf(xi,yi,t_ed_025_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_025',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
colormap(b2r(-12,12));
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('T'', K, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','t_ed_025.png')

figure
v=-12:1:12;
[C,h] = contourf(xi,yi,t_ed_050_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_050',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
colormap(b2r(-12,12));
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('T'', K, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','t_ed_050.png')

figure
v=-12:1:12;
[C,h] = contourf(xi,yi,t_ed_075_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_075',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
colormap(b2r(-12,12));
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('T'', K, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','t_ed_075.png')

figure
v=-12:1:12;
[C,h] = contourf(xi,yi,t_ed_100_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_100',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
colormap(b2r(-12,12));
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('T'', K, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','t_ed_100.png')



figure
v=-12:1:12;
[C,h] = contourf(xi,yi,t_ed_000_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_000',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
v=-0.14:0.02:0;
[C,h] = contour(xi,yi,dthetadp_000(:,:,5)',v,'k','LineWidth',2);
clabel(C,h,'FontSize',15);
colormap(b2r(-12,12));
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('T'', K, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','t_ed_000_dthdp.png')

figure
v=-12:1:12;
[C,h] = contourf(xi,yi,t_ed_010_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_010',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
v=-0.14:0.02:0;
[C,h] = contour(xi,yi,dthetadp_010(:,:,5)',v,'k','LineWidth',2);
clabel(C,h,'FontSize',15);
colormap(b2r(-12,12));
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('T'', K, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','t_ed_010_dthdp.png')

figure
v=-12:1:12;
[C,h] = contourf(xi,yi,t_ed_025_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_025',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
v=-0.14:0.02:0;
[C,h] = contour(xi,yi,dthetadp_025(:,:,5)',v,'k','LineWidth',2);
clabel(C,h,'FontSize',15);
colormap(b2r(-12,12));
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('T'', K, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','t_ed_025_dthdp.png')

figure
v=-12:1:12;
[C,h] = contourf(xi,yi,t_ed_050_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_050',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
v=-0.14:0.02:0;
[C,h] = contour(xi,yi,dthetadp_050(:,:,5)',v,'k','LineWidth',2);
clabel(C,h,'FontSize',15);
colormap(b2r(-12,12));
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('T'', K, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','t_ed_050_dthdp.png')

figure
v=-12:1:12;
[C,h] = contourf(xi,yi,t_ed_075_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_075',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
v=-0.14:0.02:0;
[C,h] = contour(xi,yi,dthetadp_075(:,:,5)',v,'k','LineWidth',2);
clabel(C,h,'FontSize',15);
colormap(b2r(-12,12));
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('T'', K, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','t_ed_075_dthdp.png')

figure
v=-12:1:12;
[C,h] = contourf(xi,yi,t_ed_100_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_100',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
v=-0.14:0.02:0;
[C,h] = contour(xi,yi,dthetadp_100(:,:,5)',v,'k','LineWidth',2);
clabel(C,h,'FontSize',15);
colormap(b2r(-12,12));
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('T'', K, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','t_ed_100_dthdp.png')








figure
v=-0.14:0.01:0;
[C,h] = contourf(xi,yi,dthetadp_000(:,:,5)',v,'k','LineWidth',2);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_000',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
v=-1000:1000:1000;
[C,h] = contour(xi,yi,t_ed_000_ll',v,'k','LineWidth',2);
caxis([-0.14 0]);
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('d\Theta/dp, K/hPa, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthdp_000_t.png')

figure
v=-0.14:0.01:0;
[C,h] = contourf(xi,yi,dthetadp_010(:,:,5)',v,'k','LineWidth',2);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_010',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
v=-1000:1000:1000;
[C,h] = contour(xi,yi,t_ed_010_ll',v,'k','LineWidth',2);
caxis([-0.14 0]);
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('d\Theta/dp, K/hPa, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthdp_010_t.png')

figure
v=-0.14:0.01:0;
[C,h] = contourf(xi,yi,dthetadp_025(:,:,5)',v,'k','LineWidth',2);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_025',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
v=-1000:1000:1000;
[C,h] = contour(xi,yi,t_ed_025_ll',v,'k','LineWidth',2);
caxis([-0.14 0]);
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('d\Theta/dp, K/hPa, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthdp_025_t.png')

figure
v=-0.14:0.01:0;
[C,h] = contourf(xi,yi,dthetadp_050(:,:,5)',v,'k','LineWidth',2);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_050',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
v=-1000:1000:1000;
[C,h] = contour(xi,yi,t_ed_050_ll',v,'k','LineWidth',2);
caxis([-0.14 0]);
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('d\Theta/dp, K/hPa, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthdp_050_t.png')

figure
v=-0.14:0.01:0;
[C,h] = contourf(xi,yi,dthetadp_075(:,:,5)',v,'k','LineWidth',2);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_075',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
v=-1000:1000:1000;
[C,h] = contour(xi,yi,t_ed_075_ll',v,'k','LineWidth',2);
caxis([-0.14 0]);
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('d\Theta/dp, K/hPa, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthdp_075_t.png')

figure
v=-0.14:0.01:0;
[C,h] = contourf(xi,yi,dthetadp_100(:,:,5)',v,'k','LineWidth',2);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_100',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
v=-1000:1000:1000;
[C,h] = contour(xi,yi,t_ed_100_ll',v,'k','LineWidth',2);
caxis([-0.14 0]);
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('d\Theta/dp, K/hPa, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthdp_100_t.png')










figure
v=-0.14:0.01:0;
[C,h] = contourf(xi,yi,dthetadp_000(:,:,5)',v,'k','LineWidth',2);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_000',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
caxis([-0.14 0]);
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('d\Theta/dp, K/hPa, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthdp_000.png')

figure
v=-0.14:0.01:0;
[C,h] = contourf(xi,yi,dthetadp_010(:,:,5)',v,'k','LineWidth',2);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_010',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
caxis([-0.14 0]);
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('d\Theta/dp, K/hPa, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthdp_010.png')

figure
v=-0.14:0.01:0;
[C,h] = contourf(xi,yi,dthetadp_025(:,:,5)',v,'k','LineWidth',2);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_025',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
caxis([-0.14 0]);
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('d\Theta/dp, K/hPa, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthdp_025.png')

figure
v=-0.14:0.01:0;
[C,h] = contourf(xi,yi,dthetadp_050(:,:,5)',v,'k','LineWidth',2);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_050',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
caxis([-0.14 0]);
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('d\Theta/dp, K/hPa, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthdp_050.png')

figure
v=-0.14:0.01:0;
[C,h] = contourf(xi,yi,dthetadp_075(:,:,5)',v,'k','LineWidth',2);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_075',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
caxis([-0.14 0]);
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('d\Theta/dp, K/hPa, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthdp_075.png')

figure
v=-0.14:0.01:0;
[C,h] = contourf(xi,yi,dthetadp_100(:,:,5)',v,'k','LineWidth',2);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_100',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
caxis([-0.14 0]);
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('d\Theta/dp, K/hPa, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthdp_100.png')

