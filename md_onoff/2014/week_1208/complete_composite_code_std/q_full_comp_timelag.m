%plot q composites with time lag to see if 100 run develops differently?


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
load('/project/rg312/mat_files/snapshot_data/q_snapshots.mat')


%transfer q to ll
xi=-179:2:180;yi=-89:2:90;
q_000_ll = cube2latlon(xc,yc,q_000,xi,yi);
q_010_ll = cube2latlon(xc,yc,q_010,xi,yi);
q_025_ll = cube2latlon(xc,yc,q_025,xi,yi);
q_050_ll = cube2latlon(xc,yc,q_050,xi,yi);
q_075_ll = cube2latlon(xc,yc,q_075,xi,yi);
q_100_ll = cube2latlon(xc,yc,q_100,xi,yi);

%locate region of interest

q_000_n = q_000_ll(:,x000n-7:x000n+7,:,:);
q_010_n = q_010_ll(:,x010n-7:x010n+7,:,:);
q_025_n = q_025_ll(:,x025n-7:x025n+7,:,:);
q_050_n = q_050_ll(:,x050n-7:x050n+7,:,:);
q_075_n = q_075_ll(:,x075n-7:x075n+7,:,:);
q_100_n = q_100_ll(:,x100n-7:x100n+7,:,:);

q_000_s = q_000_ll(:,x000s-7:x000s+7,:,:);
q_010_s = q_010_ll(:,x010s-7:x010s+7,:,:);
q_025_s = q_025_ll(:,x025s-7:x025s+7,:,:);
q_050_s = q_050_ll(:,x050s-7:x050s+7,:,:);
q_075_s = q_075_ll(:,x075s-7:x075s+7,:,:);
q_100_s = q_100_ll(:,x100s-7:x100s+7,:,:);


%clear large matrices
clear('q_000_ll','q_010_ll','q_025_ll','q_050_ll','q_075_ll','q_100_ll','q_000','q_010','q_025','q_050','q_075','q_100')

[comp_q_000_m2,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,q_000_n,q_000_s,-2,'/project/rg312/mat_files/composite_data_tlag/q_compdata_000m2.mat');
[comp_q_000_m1,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,q_000_n,q_000_s,-1,'/project/rg312/mat_files/composite_data_tlag/q_compdata_000m1.mat');
[comp_q_000_0,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,q_000_n,q_000_s,0,'/project/rg312/mat_files/composite_data_tlag/q_compdata_000.mat');
[comp_q_000_p1,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,q_000_n,q_000_s,1,'/project/rg312/mat_files/composite_data_tlag/q_compdata_000p1.mat');
[comp_q_000_p2,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,q_000_n,q_000_s,2,'/project/rg312/mat_files/composite_data_tlag/q_compdata_000p2.mat');

[comp_q_010_m2,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,q_010_n,q_010_s,-2,'/project/rg312/mat_files/composite_data_tlag/q_compdata_010m2.mat');
[comp_q_010_m1,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,q_010_n,q_010_s,-1,'/project/rg312/mat_files/composite_data_tlag/q_compdata_010m1.mat');
[comp_q_010_0,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,q_010_n,q_010_s,0,'/project/rg312/mat_files/composite_data_tlag/q_compdata_010.mat');
[comp_q_010_p1,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,q_010_n,q_010_s,1,'/project/rg312/mat_files/composite_data_tlag/q_compdata_010p1.mat');
[comp_q_010_p2,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,q_010_n,q_010_s,2,'/project/rg312/mat_files/composite_data_tlag/q_compdata_010p2.mat');

[comp_q_025_m2,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,q_025_n,q_025_s,-2,'/project/rg312/mat_files/composite_data_tlag/q_compdata_025m2.mat');
[comp_q_025_m1,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,q_025_n,q_025_s,-1,'/project/rg312/mat_files/composite_data_tlag/q_compdata_025m1.mat');
[comp_q_025_0,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,q_025_n,q_025_s,0,'/project/rg312/mat_files/composite_data_tlag/q_compdata_025.mat');
[comp_q_025_p1,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,q_025_n,q_025_s,1,'/project/rg312/mat_files/composite_data_tlag/q_compdata_025p1.mat');
[comp_q_025_p2,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,q_025_n,q_025_s,2,'/project/rg312/mat_files/composite_data_tlag/q_compdata_025p2.mat');

[comp_q_050_m2,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,q_050_n,q_050_s,-2,'/project/rg312/mat_files/composite_data_tlag/q_compdata_050m2.mat');
[comp_q_050_m1,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,q_050_n,q_050_s,-1,'/project/rg312/mat_files/composite_data_tlag/q_compdata_050m1.mat');
[comp_q_050_0,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,q_050_n,q_050_s,0,'/project/rg312/mat_files/composite_data_tlag/q_compdata_050.mat');
[comp_q_050_p1,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,q_050_n,q_050_s,1,'/project/rg312/mat_files/composite_data_tlag/q_compdata_050p1.mat');
[comp_q_050_p2,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,q_050_n,q_050_s,2,'/project/rg312/mat_files/composite_data_tlag/q_compdata_050p2.mat');

[comp_q_075_m2,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,q_075_n,q_075_s,-2,'/project/rg312/mat_files/composite_data_tlag/q_compdata_075m2.mat');
[comp_q_075_m1,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,q_075_n,q_075_s,-1,'/project/rg312/mat_files/composite_data_tlag/q_compdata_075m1.mat');
[comp_q_075_0,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,q_075_n,q_075_s,0,'/project/rg312/mat_files/composite_data_tlag/q_compdata_075.mat');
[comp_q_075_p1,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,q_075_n,q_075_s,1,'/project/rg312/mat_files/composite_data_tlag/q_compdata_075p1.mat');
[comp_q_075_p2,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,q_075_n,q_075_s,2,'/project/rg312/mat_files/composite_data_tlag/q_compdata_075p2.mat');

[comp_q_100_m2,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,q_100_n,q_100_s,-2,'/project/rg312/mat_files/composite_data_tlag/q_compdata_100m2.mat');
[comp_q_100_m1,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,q_100_n,q_100_s,-1,'/project/rg312/mat_files/composite_data_tlag/q_compdata_100m1.mat');
[comp_q_100_0,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,q_100_n,q_100_s,0,'/project/rg312/mat_files/composite_data_tlag/q_compdata_100.mat');
[comp_q_100_p1,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,q_100_n,q_100_s,1,'/project/rg312/mat_files/composite_data_tlag/q_compdata_100p1.mat');
[comp_q_100_p2,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,q_100_n,q_100_s,2,'/project/rg312/mat_files/composite_data_tlag/q_compdata_100p2.mat');




x=-34:2:34;
v = 0.00:0.0002:0.006;
figure
 contourf(x,rC./100,nanmean(comp_q_000_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_000_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.0es0, lag -2','FontSize',15)
print('-dpng','../q_tlag_plots/q_000_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_000_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_000_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.0es0, lag -1','FontSize',15)
print('-dpng','../q_tlag_plots/q_000_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_000_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_000_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.0es0','FontSize',15)
print('-dpng','../q_tlag_plots/q_000_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_000_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_000_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.0es0, lag 1','FontSize',15)
print('-dpng','../q_tlag_plots/q_000_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_000_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_000_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.0es0, lag 2','FontSize',15)
print('-dpng','../q_tlag_plots/q_000_p2.png')
hold off



x=-34:2:34;
figure
 contourf(x,rC./100,nanmean(comp_q_010_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_010_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.1es0, lag -2','FontSize',15)
print('-dpng','../q_tlag_plots/q_010_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_010_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_010_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.1es0, lag -1','FontSize',15)
print('-dpng','../q_tlag_plots/q_010_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_010_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_010_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.1es0','FontSize',15)
print('-dpng','../q_tlag_plots/q_010_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_010_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_010_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.1es0, lag 1','FontSize',15)
print('-dpng','../q_tlag_plots/q_010_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_010_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_010_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.1es0, lag 2','FontSize',15)
print('-dpng','../q_tlag_plots/q_010_p2.png')
hold off


figure
 contourf(x,rC./100,nanmean(comp_q_025_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_025_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.25es0, lag -2','FontSize',15)
print('-dpng','../q_tlag_plots/q_025_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_025_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_025_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.25es0, lag -1','FontSize',15)
print('-dpng','../q_tlag_plots/q_025_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_025_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_025_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.25es0','FontSize',15)
print('-dpng','../q_tlag_plots/q_025_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_025_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_025_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.25es0, lag 1','FontSize',15)
print('-dpng','../q_tlag_plots/q_025_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_025_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_025_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.25es0, lag 2','FontSize',15)
print('-dpng','../q_tlag_plots/q_025_p2.png')
hold off



figure
 contourf(x,rC./100,nanmean(comp_q_050_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_050_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.5es0, lag -2','FontSize',15)
print('-dpng','../q_tlag_plots/q_050_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_050_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_050_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.5es0, lag -1','FontSize',15)
print('-dpng','../q_tlag_plots/q_050_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_050_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_050_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.5es0','FontSize',15)
print('-dpng','../q_tlag_plots/q_050_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_050_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_050_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.5es0, lag 1','FontSize',15)
print('-dpng','../q_tlag_plots/q_050_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_050_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_050_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.5es0, lag 2','FontSize',15)
print('-dpng','../q_tlag_plots/q_050_p2.png')
hold off



figure
 contourf(x,rC./100,nanmean(comp_q_075_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_075_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.75es0, lag -2','FontSize',15)
print('-dpng','../q_tlag_plots/q_075_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_075_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_075_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.75es0, lag -1','FontSize',15)
print('-dpng','../q_tlag_plots/q_075_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_075_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_075_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.75es0','FontSize',15)
print('-dpng','../q_tlag_plots/q_075_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_075_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_075_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.75es0, lag 1','FontSize',15)
print('-dpng','../q_tlag_plots/q_075_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_075_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_075_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.75es0, lag 2','FontSize',15)
print('-dpng','../q_tlag_plots/q_075_p2.png')
hold off



figure
 contourf(x,rC./100,nanmean(comp_q_100_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_100_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 1.0es0, lag -2','FontSize',15)
print('-dpng','../q_tlag_plots/q_100_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_100_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_100_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 1.0es0, lag -1','FontSize',15)
print('-dpng','../q_tlag_plots/q_100_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_100_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_100_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 1.0es0','FontSize',15)
print('-dpng','../q_tlag_plots/q_100_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_100_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_100_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 1.0es0, lag 1','FontSize',15)
print('-dpng','../q_tlag_plots/q_100_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_q_100_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.006])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_q_100_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 1.0es0, lag 2','FontSize',15)
print('-dpng','../q_tlag_plots/q_100_p2.png')
hold off




