%test time lag function; do events look at all coherent the day before.... NB might have to isolate latitudes for this if phase speeds diff with lat...




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
load('/project/rg312/mat_files/snapshot_data/vt_ed_data.mat')


[comp_vt_000_m2,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,vt_ed_000n,vt_ed_000s,-2,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_000m2.mat');
[comp_vt_000_m1,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,vt_ed_000n,vt_ed_000s,-1,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_000m1.mat');
[comp_vt_000_0,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,vt_ed_000n,vt_ed_000s,0,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_000.mat');
[comp_vt_000_p1,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,vt_ed_000n,vt_ed_000s,1,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_000p1.mat');
[comp_vt_000_p2,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,vt_ed_000n,vt_ed_000s,2,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_000p2.mat');

[comp_vt_010_m2,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,vt_ed_010n,vt_ed_010s,-2,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_010m2.mat');
[comp_vt_010_m1,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,vt_ed_010n,vt_ed_010s,-1,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_010m1.mat');
[comp_vt_010_0,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,vt_ed_010n,vt_ed_010s,0,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_010.mat');
[comp_vt_010_p1,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,vt_ed_010n,vt_ed_010s,1,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_010p1.mat');
[comp_vt_010_p2,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,vt_ed_010n,vt_ed_010s,2,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_010p2.mat');

[comp_vt_025_m2,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,vt_ed_025n,vt_ed_025s,-2,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_025m2.mat');
[comp_vt_025_m1,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,vt_ed_025n,vt_ed_025s,-1,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_025m1.mat');
[comp_vt_025_0,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,vt_ed_025n,vt_ed_025s,0,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_025.mat');
[comp_vt_025_p1,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,vt_ed_025n,vt_ed_025s,1,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_025p1.mat');
[comp_vt_025_p2,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,vt_ed_025n,vt_ed_025s,2,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_025p2.mat');

[comp_vt_050_m2,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,vt_ed_050n,vt_ed_050s,-2,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_050m2.mat');
[comp_vt_050_m1,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,vt_ed_050n,vt_ed_050s,-1,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_050m1.mat');
[comp_vt_050_0,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,vt_ed_050n,vt_ed_050s,0,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_050.mat');
[comp_vt_050_p1,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,vt_ed_050n,vt_ed_050s,1,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_050p1.mat');
[comp_vt_050_p2,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,vt_ed_050n,vt_ed_050s,2,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_050p2.mat');

[comp_vt_075_m2,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,vt_ed_075n,vt_ed_075s,-2,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_075m2.mat');
[comp_vt_075_m1,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,vt_ed_075n,vt_ed_075s,-1,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_075m1.mat');
[comp_vt_075_0,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,vt_ed_075n,vt_ed_075s,0,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_075.mat');
[comp_vt_075_p1,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,vt_ed_075n,vt_ed_075s,1,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_075p1.mat');
[comp_vt_075_p2,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,vt_ed_075n,vt_ed_075s,2,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_075p2.mat');

[comp_vt_100_m2,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,vt_ed_100n,vt_ed_100s,-2,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_100m2.mat');
[comp_vt_100_m1,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,vt_ed_100n,vt_ed_100s,-1,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_100m1.mat');
[comp_vt_100_0,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,vt_ed_100n,vt_ed_100s,0,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_100.mat');
[comp_vt_100_p1,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,vt_ed_100n,vt_ed_100s,1,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_100p1.mat');
[comp_vt_100_p2,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,vt_ed_100n,vt_ed_100s,2,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_100p2.mat');



x=-34:2:34;
v = -40:5:110;
figure
 contourf(x,rC./100,nanmean(comp_vt_000_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_000_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.0es0, lag -2','FontSize',15)
print('-dpng','vt_tlag_plots/vt_000_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_000_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_000_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.0es0, lag -1','FontSize',15)
print('-dpng','vt_tlag_plots/vt_000_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_000_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_000_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.0es0','FontSize',15)
print('-dpng','vt_tlag_plots/vt_000_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_000_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_000_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.0es0, lag 1','FontSize',15)
print('-dpng','vt_tlag_plots/vt_000_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_000_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_000_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.0es0, lag 2','FontSize',15)
print('-dpng','vt_tlag_plots/vt_000_p2.png')
hold off



x=-34:2:34;
v = -40:5:110;
figure
 contourf(x,rC./100,nanmean(comp_vt_010_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_010_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.1es0, lag -2','FontSize',15)
print('-dpng','vt_tlag_plots/vt_010_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_010_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_010_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.1es0, lag -1','FontSize',15)
print('-dpng','vt_tlag_plots/vt_010_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_010_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_010_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.1es0','FontSize',15)
print('-dpng','vt_tlag_plots/vt_010_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_010_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_010_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.1es0, lag 1','FontSize',15)
print('-dpng','vt_tlag_plots/vt_010_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_010_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_010_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.1es0, lag 2','FontSize',15)
print('-dpng','vt_tlag_plots/vt_010_p2.png')
hold off



x=-34:2:34;
v = -40:5:110;
figure
 contourf(x,rC./100,nanmean(comp_vt_025_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_025_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.25es0, lag -2','FontSize',15)
print('-dpng','vt_tlag_plots/vt_025_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_025_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_025_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.25es0, lag -1','FontSize',15)
print('-dpng','vt_tlag_plots/vt_025_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_025_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_025_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.25es0','FontSize',15)
print('-dpng','vt_tlag_plots/vt_025_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_025_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_025_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.25es0, lag 1','FontSize',15)
print('-dpng','vt_tlag_plots/vt_025_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_025_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_025_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.25es0, lag 2','FontSize',15)
print('-dpng','vt_tlag_plots/vt_025_p2.png')
hold off



x=-34:2:34;
v = -40:5:110;
figure
 contourf(x,rC./100,nanmean(comp_vt_050_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_050_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.5es0, lag -2','FontSize',15)
print('-dpng','vt_tlag_plots/vt_050_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_050_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_050_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.5es0, lag -1','FontSize',15)
print('-dpng','vt_tlag_plots/vt_050_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_050_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_050_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.5es0','FontSize',15)
print('-dpng','vt_tlag_plots/vt_050_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_050_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_050_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.5es0, lag 1','FontSize',15)
print('-dpng','vt_tlag_plots/vt_050_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_050_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_050_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.5es0, lag 2','FontSize',15)
print('-dpng','vt_tlag_plots/vt_050_p2.png')
hold off



x=-34:2:34;
v = -40:5:110;
figure
 contourf(x,rC./100,nanmean(comp_vt_075_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_075_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.75es0, lag -2','FontSize',15)
print('-dpng','vt_tlag_plots/vt_075_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_075_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_075_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.75es0, lag -1','FontSize',15)
print('-dpng','vt_tlag_plots/vt_075_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_075_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_075_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.75es0','FontSize',15)
print('-dpng','vt_tlag_plots/vt_075_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_075_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_075_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.75es0, lag 1','FontSize',15)
print('-dpng','vt_tlag_plots/vt_075_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_075_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_075_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.75es0, lag 2','FontSize',15)
print('-dpng','vt_tlag_plots/vt_075_p2.png')
hold off



x=-34:2:34;
v = -40:5:110;
figure
 contourf(x,rC./100,nanmean(comp_vt_100_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_100_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 1.0es0, lag -2','FontSize',15)
print('-dpng','vt_tlag_plots/vt_100_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_100_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_100_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 1.0es0, lag -1','FontSize',15)
print('-dpng','vt_tlag_plots/vt_100_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_100_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_100_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 1.0es0','FontSize',15)
print('-dpng','vt_tlag_plots/vt_100_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_100_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_100_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 1.0es0, lag 1','FontSize',15)
print('-dpng','vt_tlag_plots/vt_100_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_100_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_100_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 1.0es0, lag 2','FontSize',15)
print('-dpng','vt_tlag_plots/vt_100_p2.png')
hold off

