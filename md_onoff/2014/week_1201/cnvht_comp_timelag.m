%plot w composites with time lag to see if 100 run develops differently?


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
load('/project/rg312/mat_files/heat_rates.mat')

clear('difht_000','difht_010','difht_025','difht_050','difht_075','difht_100' ...
,'radht_000','radht_010','radht_025','radht_050','radht_075','radht_100'...
,'cndht_000','cndht_010','cndht_025','cndht_050','cndht_075','cndht_100'...
,'htrt_000','htrt_010','htrt_025','htrt_050','htrt_075','htrt_100')

%transfer to ll
xi=-179:2:180;yi=-89:2:90;
cnvht_000_ll = cube2latlon(xc,yc,cnvht_000,xi,yi).*86400;
cnvht_010_ll = cube2latlon(xc,yc,cnvht_010,xi,yi).*86400;
cnvht_025_ll = cube2latlon(xc,yc,cnvht_025,xi,yi).*86400;
cnvht_050_ll = cube2latlon(xc,yc,cnvht_050,xi,yi).*86400;
cnvht_075_ll = cube2latlon(xc,yc,cnvht_075,xi,yi).*86400;
cnvht_100_ll = cube2latlon(xc,yc,cnvht_100,xi,yi).*86400;

%locate region of interest
cnvht_000_n = squeeze(cnvht_000_ll(:,x000n-7:x000n+7,:,:));
cnvht_010_n = squeeze(cnvht_010_ll(:,x010n-7:x010n+7,:,:));
cnvht_025_n = squeeze(cnvht_025_ll(:,x025n-7:x025n+7,:,:));
cnvht_050_n = squeeze(cnvht_050_ll(:,x050n-7:x050n+7,:,:));
cnvht_075_n = squeeze(cnvht_075_ll(:,x075n-7:x075n+7,:,:));
cnvht_100_n = squeeze(cnvht_100_ll(:,x100n-7:x100n+7,:,:));

cnvht_000_s = squeeze(cnvht_000_ll(:,x000s-7:x000s+7,:,:));
cnvht_010_s = squeeze(cnvht_010_ll(:,x010s-7:x010s+7,:,:));
cnvht_025_s = squeeze(cnvht_025_ll(:,x025s-7:x025s+7,:,:));
cnvht_050_s = squeeze(cnvht_050_ll(:,x050s-7:x050s+7,:,:));
cnvht_075_s = squeeze(cnvht_075_ll(:,x075s-7:x075s+7,:,:));
cnvht_100_s = squeeze(cnvht_100_ll(:,x100s-7:x100s+7,:,:));

%clear large matrices
clear('cnvht_000_ll','cnvht_010_ll','cnvht_025_ll','cnvht_050_ll','cnvht_075_ll','cnvht_100_ll','cnvht_000','cnvht_010','cnvht_025','cnvht_050','cnvht_075','cnvht_100')

[comp_cnvht_000_m2,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,cnvht_000_n,cnvht_000_s,-2,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_000.mat');
[comp_cnvht_000_m1,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,cnvht_000_n,cnvht_000_s,-1,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_000.mat');
[comp_cnvht_000_0,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,cnvht_000_n,cnvht_000_s,0,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_000.mat');
[comp_cnvht_000_p1,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,cnvht_000_n,cnvht_000_s,1,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_000.mat');
[comp_cnvht_000_p2,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,cnvht_000_n,cnvht_000_s,2,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_000.mat');

[comp_cnvht_010_m2,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,cnvht_010_n,cnvht_010_s,-2,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_010.mat');
[comp_cnvht_010_m1,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,cnvht_010_n,cnvht_010_s,-1,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_010.mat');
[comp_cnvht_010_0,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,cnvht_010_n,cnvht_010_s,0,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_010.mat');
[comp_cnvht_010_p1,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,cnvht_010_n,cnvht_010_s,1,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_010.mat');
[comp_cnvht_010_p2,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,cnvht_010_n,cnvht_010_s,2,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_010.mat');

[comp_cnvht_025_m2,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,cnvht_025_n,cnvht_025_s,-2,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_025.mat');
[comp_cnvht_025_m1,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,cnvht_025_n,cnvht_025_s,-1,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_025.mat');
[comp_cnvht_025_0,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,cnvht_025_n,cnvht_025_s,0,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_025.mat');
[comp_cnvht_025_p1,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,cnvht_025_n,cnvht_025_s,1,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_025.mat');
[comp_cnvht_025_p2,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,cnvht_025_n,cnvht_025_s,2,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_025.mat');

[comp_cnvht_050_m2,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,cnvht_050_n,cnvht_050_s,-2,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_050.mat');
[comp_cnvht_050_m1,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,cnvht_050_n,cnvht_050_s,-1,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_050.mat');
[comp_cnvht_050_0,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,cnvht_050_n,cnvht_050_s,0,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_050.mat');
[comp_cnvht_050_p1,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,cnvht_050_n,cnvht_050_s,1,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_050.mat');
[comp_cnvht_050_p2,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,cnvht_050_n,cnvht_050_s,2,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_050.mat');

[comp_cnvht_075_m2,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,cnvht_075_n,cnvht_075_s,-2,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_075.mat');
[comp_cnvht_075_m1,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,cnvht_075_n,cnvht_075_s,-1,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_075.mat');
[comp_cnvht_075_0,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,cnvht_075_n,cnvht_075_s,0,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_075.mat');
[comp_cnvht_075_p1,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,cnvht_075_n,cnvht_075_s,1,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_075.mat');
[comp_cnvht_075_p2,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,cnvht_075_n,cnvht_075_s,2,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_075.mat');

[comp_cnvht_100_m2,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,cnvht_100_n,cnvht_100_s,-2,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_100.mat');
[comp_cnvht_100_m1,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,cnvht_100_n,cnvht_100_s,-1,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_100.mat');
[comp_cnvht_100_0,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,cnvht_100_n,cnvht_100_s,0,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_100.mat');
[comp_cnvht_100_p1,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,cnvht_100_n,cnvht_100_s,1,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_100.mat');
[comp_cnvht_100_p2,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,cnvht_100_n,cnvht_100_s,2,'/project/rg312/mat_files/composite_data_tlag/cnvht_compdata_100.mat');



x=-34:2:34;
v = -0.5:0.125:1.5;
figure
 contourf(x,rC./100,nanmean(comp_cnvht_000_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_000_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.0es0, lag -2','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_000_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_000_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_000_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.0es0, lag -1','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_000_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_000_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_000_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.0es0','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_000_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_000_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_000_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.0es0, lag 1','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_000_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_000_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_000_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.0es0, lag 2','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_000_p2.png')
hold off


figure
 contourf(x,rC./100,nanmean(comp_cnvht_010_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_010_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.1es0, lag -2','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_010_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_010_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_010_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.1es0, lag -1','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_010_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_010_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_010_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.1es0','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_010_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_010_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_010_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.1es0, lag 1','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_010_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_010_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_010_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.1es0, lag 2','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_010_p2.png')
hold off



figure
 contourf(x,rC./100,nanmean(comp_cnvht_025_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_025_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.25es0, lag -2','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_025_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_025_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_025_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.25es0, lag -1','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_025_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_025_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_025_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.25es0','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_025_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_025_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_025_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.25es0, lag 1','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_025_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_025_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_025_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.25es0, lag 2','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_025_p2.png')
hold off


figure
 contourf(x,rC./100,nanmean(comp_cnvht_050_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_050_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.5es0, lag -2','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_050_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_050_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_050_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.5es0, lag -1','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_050_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_050_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_050_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.5es0','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_050_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_050_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_050_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.5es0, lag 1','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_050_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_050_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_050_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.5es0, lag 2','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_050_p2.png')
hold off


figure
 contourf(x,rC./100,nanmean(comp_cnvht_075_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_075_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.75es0, lag -2','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_075_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_075_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_075_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.75es0, lag -1','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_075_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_075_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_075_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.75es0','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_075_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_075_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_075_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.75es0, lag 1','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_075_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_075_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_075_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 0.75es0, lag 2','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_075_p2.png')
hold off



figure
 contourf(x,rC./100,nanmean(comp_cnvht_100_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_100_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 1.0es0, lag -2','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_100_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_100_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_100_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 1.0es0, lag -1','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_100_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_100_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_100_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 1.0es0','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_100_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_100_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_100_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 1.0es0, lag 1','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_100_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_cnvht_100_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.5,1.5));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_cnvht_100_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Convective heating composite, 1.0es0, lag 2','FontSize',15)
print('-dpng','cnvht_tlag_plots/cnvht_100_p2.png')
hold off







