%plot theta composites with time lag to see if 100 run develops differently?


%load in data

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

load('/project/rg312/mat_files/snapshot_data/vt_extreme_data.mat')
load('/project/rg312/mat_files/vt_lats.mat')
load('/project/rg312/mat_files/snapshot_data/theta_snapshots.mat')


%transfer theta to ll
xi=-179:2:180;yi=-89:2:90;
theta_000_ll = cube2latlon(xc,yc,theta_000,xi,yi);
theta_010_ll = cube2latlon(xc,yc,theta_010,xi,yi);
theta_025_ll = cube2latlon(xc,yc,theta_025,xi,yi);
theta_050_ll = cube2latlon(xc,yc,theta_050,xi,yi);
theta_075_ll = cube2latlon(xc,yc,theta_075,xi,yi);
theta_100_ll = cube2latlon(xc,yc,theta_100,xi,yi);

%locate region of interest

theta_000_n = theta_000_ll(:,x000n-7:x000n+7,:,:);
theta_010_n = theta_010_ll(:,x010n-7:x010n+7,:,:);
theta_025_n = theta_025_ll(:,x025n-7:x025n+7,:,:);
theta_050_n = theta_050_ll(:,x050n-7:x050n+7,:,:);
theta_075_n = theta_075_ll(:,x075n-7:x075n+7,:,:);
theta_100_n = theta_100_ll(:,x100n-7:x100n+7,:,:);

theta_000_s = theta_000_ll(:,x000s-7:x000s+7,:,:);
theta_010_s = theta_010_ll(:,x010s-7:x010s+7,:,:);
theta_025_s = theta_025_ll(:,x025s-7:x025s+7,:,:);
theta_050_s = theta_050_ll(:,x050s-7:x050s+7,:,:);
theta_075_s = theta_075_ll(:,x075s-7:x075s+7,:,:);
theta_100_s = theta_100_ll(:,x100s-7:x100s+7,:,:);


%clear large matrices
clear('theta_000_ll','theta_010_ll','theta_025_ll','theta_050_ll','theta_075_ll','theta_100_ll','theta_000','theta_010','theta_025','theta_050','theta_075','theta_100')

[comp_theta_000_m2,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,theta_000_n,theta_000_s,-2,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_000m2.mat');
[comp_theta_000_m1,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,theta_000_n,theta_000_s,-1,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_000m1.mat');
[comp_theta_000_0,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,theta_000_n,theta_000_s,0,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_000.mat');
[comp_theta_000_p1,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,theta_000_n,theta_000_s,1,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_000p1.mat');
[comp_theta_000_p2,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,theta_000_n,theta_000_s,2,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_000p2.mat');

[comp_theta_010_m2,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,theta_010_n,theta_010_s,-2,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_010m2.mat');
[comp_theta_010_m1,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,theta_010_n,theta_010_s,-1,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_010m1.mat');
[comp_theta_010_0,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,theta_010_n,theta_010_s,0,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_010.mat');
[comp_theta_010_p1,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,theta_010_n,theta_010_s,1,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_010p1.mat');
[comp_theta_010_p2,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,theta_010_n,theta_010_s,2,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_010p2.mat');

[comp_theta_025_m2,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,theta_025_n,theta_025_s,-2,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_025m2.mat');
[comp_theta_025_m1,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,theta_025_n,theta_025_s,-1,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_025m1.mat');
[comp_theta_025_0,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,theta_025_n,theta_025_s,0,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_025.mat');
[comp_theta_025_p1,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,theta_025_n,theta_025_s,1,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_025p1.mat');
[comp_theta_025_p2,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,theta_025_n,theta_025_s,2,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_025p2.mat');

[comp_theta_050_m2,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,theta_050_n,theta_050_s,-2,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_050m2.mat');
[comp_theta_050_m1,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,theta_050_n,theta_050_s,-1,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_050m1.mat');
[comp_theta_050_0,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,theta_050_n,theta_050_s,0,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_050.mat');
[comp_theta_050_p1,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,theta_050_n,theta_050_s,1,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_050p1.mat');
[comp_theta_050_p2,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,theta_050_n,theta_050_s,2,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_050p2.mat');

[comp_theta_075_m2,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,theta_075_n,theta_075_s,-2,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_075m2.mat');
[comp_theta_075_m1,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,theta_075_n,theta_075_s,-1,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_075m1.mat');
[comp_theta_075_0,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,theta_075_n,theta_075_s,0,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_075.mat');
[comp_theta_075_p1,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,theta_075_n,theta_075_s,1,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_075p1.mat');
[comp_theta_075_p2,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,theta_075_n,theta_075_s,2,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_075p2.mat');

[comp_theta_100_m2,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,theta_100_n,theta_100_s,-2,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_100m2.mat');
[comp_theta_100_m1,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,theta_100_n,theta_100_s,-1,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_100m1.mat');
[comp_theta_100_0,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,theta_100_n,theta_100_s,0,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_100.mat');
[comp_theta_100_p1,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,theta_100_n,theta_100_s,1,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_100p1.mat');
[comp_theta_100_p2,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,theta_100_n,theta_100_s,2,'/project/rg312/mat_files/composite_data_tlag/theta_compdata_100p2.mat');




x=-34:2:34;
v = 270:10:350;
figure
 contourf(x,rC./100,nanmean(comp_theta_000_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_000_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.0es0, lag -2','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_000_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_000_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_000_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.0es0, lag -1','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_000_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_000_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_000_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.0es0','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_000_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_000_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_000_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.0es0, lag 1','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_000_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_000_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_000_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.0es0, lag 2','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_000_p2.png')
hold off



figure
 contourf(x,rC./100,nanmean(comp_theta_010_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_010_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.1es0, lag -2','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_010_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_010_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_010_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.1es0, lag -1','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_010_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_010_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_010_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.1es0','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_010_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_010_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_010_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.1es0, lag 1','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_010_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_010_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_010_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.1es0, lag 2','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_010_p2.png')
hold off



figure
 contourf(x,rC./100,nanmean(comp_theta_025_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_025_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.25es0, lag -2','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_025_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_025_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_025_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.25es0, lag -1','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_025_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_025_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_025_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.25es0','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_025_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_025_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_025_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.25es0, lag 1','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_025_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_025_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_025_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.25es0, lag 2','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_025_p2.png')
hold off



figure
 contourf(x,rC./100,nanmean(comp_theta_050_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_050_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.5es0, lag -2','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_050_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_050_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_050_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.5es0, lag -1','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_050_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_050_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_050_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.5es0','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_050_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_050_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_050_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.5es0, lag 1','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_050_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_050_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_050_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.5es0, lag 2','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_050_p2.png')
hold off



figure
 contourf(x,rC./100,nanmean(comp_theta_075_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_075_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.75es0, lag -2','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_075_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_075_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_075_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.75es0, lag -1','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_075_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_075_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_075_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.75es0','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_075_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_075_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_075_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.75es0, lag 1','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_075_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_075_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_075_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.75es0, lag 2','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_075_p2.png')
hold off




figure
 contourf(x,rC./100,nanmean(comp_theta_100_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_100_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 1.0es0, lag -2','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_100_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_100_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_100_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 1.0es0, lag -1','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_100_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_100_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_100_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 1.0es0','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_100_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_100_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_100_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 1.0es0, lag 1','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_100_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_theta_100_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 350]);
hold on
[C,h] = contour(x,rC./100,nanmean(comp_theta_100_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 1.0es0, lag 2','FontSize',15)
print('-dpng','../theta_tlag_plots/theta_100_p2.png')
hold off




