%plot t composites with time lag to see if 100 run develops differently?


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
load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat')


%transfer t to ll
xi=-179:2:180;yi=-89:2:90;
t_000_ll = cube2latlon(xc,yc,t_000,xi,yi);
t_010_ll = cube2latlon(xc,yc,t_010,xi,yi);
t_025_ll = cube2latlon(xc,yc,t_025,xi,yi);
t_050_ll = cube2latlon(xc,yc,t_050,xi,yi);
t_075_ll = cube2latlon(xc,yc,t_075,xi,yi);
t_100_ll = cube2latlon(xc,yc,t_100,xi,yi);

%locate region of interest
for i=1:720
t_000_n(:,:,:,i) = squeeze(t_000_ll(:,x000n-7:x000n+7,:,i)) - mean(t_000_ll(:,x000n-7:x000n+7,:,:),4);
t_010_n(:,:,:,i) = squeeze(t_010_ll(:,x010n-7:x010n+7,:,i)) - mean(t_010_ll(:,x010n-7:x010n+7,:,:),4);
t_025_n(:,:,:,i) = squeeze(t_025_ll(:,x025n-7:x025n+7,:,i)) - mean(t_025_ll(:,x025n-7:x025n+7,:,:),4);
t_050_n(:,:,:,i) = squeeze(t_050_ll(:,x050n-7:x050n+7,:,i)) - mean(t_050_ll(:,x050n-7:x050n+7,:,:),4);
t_075_n(:,:,:,i) = squeeze(t_075_ll(:,x075n-7:x075n+7,:,i)) - mean(t_075_ll(:,x075n-7:x075n+7,:,:),4);
t_100_n(:,:,:,i) = squeeze(t_100_ll(:,x100n-7:x100n+7,:,i)) - mean(t_100_ll(:,x100n-7:x100n+7,:,:),4);

t_000_s(:,:,:,i) = squeeze(t_000_ll(:,x000s-7:x000s+7,:,i)) - mean(t_000_ll(:,x000s-7:x000s+7,:,:),4);
t_010_s(:,:,:,i) = squeeze(t_010_ll(:,x010s-7:x010s+7,:,i)) - mean(t_010_ll(:,x010s-7:x010s+7,:,:),4);
t_025_s(:,:,:,i) = squeeze(t_025_ll(:,x025s-7:x025s+7,:,i)) - mean(t_025_ll(:,x025s-7:x025s+7,:,:),4);
t_050_s(:,:,:,i) = squeeze(t_050_ll(:,x050s-7:x050s+7,:,i)) - mean(t_050_ll(:,x050s-7:x050s+7,:,:),4);
t_075_s(:,:,:,i) = squeeze(t_075_ll(:,x075s-7:x075s+7,:,i)) - mean(t_075_ll(:,x075s-7:x075s+7,:,:),4);
t_100_s(:,:,:,i) = squeeze(t_100_ll(:,x100s-7:x100s+7,:,i)) - mean(t_100_ll(:,x100s-7:x100s+7,:,:),4);
end

%clear large matrices
clear('t_000_ll','t_010_ll','t_025_ll','t_050_ll','t_075_ll','t_100_ll','t_000','t_010','t_025','t_050','t_075','t_100')

[comp_t_000_m2,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,t_000_n,t_000_s,-2,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_000m2.mat');
[comp_t_000_m1,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,t_000_n,t_000_s,-1,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_000m1.mat');
[comp_t_000_0,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,t_000_n,t_000_s,0,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_000.mat');
[comp_t_000_p1,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,t_000_n,t_000_s,1,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_000p1.mat');
[comp_t_000_p2,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,t_000_n,t_000_s,2,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_000p2.mat');

[comp_t_010_m2,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,t_010_n,t_010_s,-2,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_010m2.mat');
[comp_t_010_m1,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,t_010_n,t_010_s,-1,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_010m1.mat');
[comp_t_010_0,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,t_010_n,t_010_s,0,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_010.mat');
[comp_t_010_p1,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,t_010_n,t_010_s,1,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_010p1.mat');
[comp_t_010_p2,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,t_010_n,t_010_s,2,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_010p2.mat');

[comp_t_025_m2,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,t_025_n,t_025_s,-2,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_025m2.mat');
[comp_t_025_m1,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,t_025_n,t_025_s,-1,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_025m1.mat');
[comp_t_025_0,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,t_025_n,t_025_s,0,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_025.mat');
[comp_t_025_p1,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,t_025_n,t_025_s,1,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_025p1.mat');
[comp_t_025_p2,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,t_025_n,t_025_s,2,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_025p2.mat');

[comp_t_050_m2,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,t_050_n,t_050_s,-2,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_050m2.mat');
[comp_t_050_m1,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,t_050_n,t_050_s,-1,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_050m1.mat');
[comp_t_050_0,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,t_050_n,t_050_s,0,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_050.mat');
[comp_t_050_p1,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,t_050_n,t_050_s,1,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_050p1.mat');
[comp_t_050_p2,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,t_050_n,t_050_s,2,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_050p2.mat');

[comp_t_075_m2,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,t_075_n,t_075_s,-2,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_075m2.mat');
[comp_t_075_m1,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,t_075_n,t_075_s,-1,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_075m1.mat');
[comp_t_075_0,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,t_075_n,t_075_s,0,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_075.mat');
[comp_t_075_p1,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,t_075_n,t_075_s,1,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_075p1.mat');
[comp_t_075_p2,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,t_075_n,t_075_s,2,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_075p2.mat');

[comp_t_100_m2,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,t_100_n,t_100_s,-2,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_100m2.mat');
[comp_t_100_m1,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,t_100_n,t_100_s,-1,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_100m1.mat');
[comp_t_100_0,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,t_100_n,t_100_s,0,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_100.mat');
[comp_t_100_p1,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,t_100_n,t_100_s,1,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_100p1.mat');
[comp_t_100_p2,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,t_100_n,t_100_s,2,'/project/rg312/mat_files/composite_data_tlag/ted_compdata_100p2.mat');




x=-34:2:34;
v = -6:0.5:6;
figure
 contourf(x,rC./100,nanmean(comp_t_000_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_000_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.0es0, lag -2','FontSize',15)
print('-dpng','../ted_tlag_plots/t_000_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_000_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_000_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.0es0, lag -1','FontSize',15)
print('-dpng','../ted_tlag_plots/t_000_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_000_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_000_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.0es0','FontSize',15)
print('-dpng','../ted_tlag_plots/t_000_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_000_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_000_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.0es0, lag 1','FontSize',15)
print('-dpng','../ted_tlag_plots/t_000_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_000_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_000_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.0es0, lag 2','FontSize',15)
print('-dpng','../ted_tlag_plots/t_000_p2.png')
hold off



figure
 contourf(x,rC./100,nanmean(comp_t_010_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_010_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.1es0, lag -2','FontSize',15)
print('-dpng','../ted_tlag_plots/t_010_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_010_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_010_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.1es0, lag -1','FontSize',15)
print('-dpng','../ted_tlag_plots/t_010_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_010_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_010_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.1es0','FontSize',15)
print('-dpng','../ted_tlag_plots/t_010_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_010_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_010_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.1es0, lag 1','FontSize',15)
print('-dpng','../ted_tlag_plots/t_010_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_010_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_010_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.1es0, lag 2','FontSize',15)
print('-dpng','../ted_tlag_plots/t_010_p2.png')
hold off



figure
 contourf(x,rC./100,nanmean(comp_t_025_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_025_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.25es0, lag -2','FontSize',15)
print('-dpng','../ted_tlag_plots/t_025_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_025_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_025_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.25es0, lag -1','FontSize',15)
print('-dpng','../ted_tlag_plots/t_025_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_025_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_025_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.25es0','FontSize',15)
print('-dpng','../ted_tlag_plots/t_025_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_025_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_025_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.25es0, lag 1','FontSize',15)
print('-dpng','../ted_tlag_plots/t_025_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_025_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_025_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.25es0, lag 2','FontSize',15)
print('-dpng','../ted_tlag_plots/t_025_p2.png')
hold off



figure
 contourf(x,rC./100,nanmean(comp_t_050_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_050_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.5es0, lag -2','FontSize',15)
print('-dpng','../ted_tlag_plots/t_050_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_050_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_050_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.5es0, lag -1','FontSize',15)
print('-dpng','../ted_tlag_plots/t_050_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_050_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_050_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.5es0','FontSize',15)
print('-dpng','../ted_tlag_plots/t_050_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_050_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_050_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.5es0, lag 1','FontSize',15)
print('-dpng','../ted_tlag_plots/t_050_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_050_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_050_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.5es0, lag 2','FontSize',15)
print('-dpng','../ted_tlag_plots/t_050_p2.png')
hold off



figure
 contourf(x,rC./100,nanmean(comp_t_075_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_075_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.75es0, lag -2','FontSize',15)
print('-dpng','../ted_tlag_plots/t_075_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_075_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_075_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.75es0, lag -1','FontSize',15)
print('-dpng','../ted_tlag_plots/t_075_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_075_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_075_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.75es0','FontSize',15)
print('-dpng','../ted_tlag_plots/t_075_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_075_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_075_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.75es0, lag 1','FontSize',15)
print('-dpng','../ted_tlag_plots/t_075_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_075_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_075_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 0.75es0, lag 2','FontSize',15)
print('-dpng','../ted_tlag_plots/t_075_p2.png')
hold off



figure
 contourf(x,rC./100,nanmean(comp_t_100_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_100_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 1.0es0, lag -2','FontSize',15)
print('-dpng','../ted_tlag_plots/t_100_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_100_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_100_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 1.0es0, lag -1','FontSize',15)
print('-dpng','../ted_tlag_plots/t_100_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_100_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_100_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 1.0es0','FontSize',15)
print('-dpng','../ted_tlag_plots/t_100_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_100_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_100_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 1.0es0, lag 1','FontSize',15)
print('-dpng','../ted_tlag_plots/t_100_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_t_100_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_t_100_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t composite, 1.0es0, lag 2','FontSize',15)
print('-dpng','../ted_tlag_plots/t_100_p2.png')
hold off




