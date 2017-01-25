%plot v composites with time lag to see if 100 run develops differently?


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
load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')


%transfer v to ll
xi=-179:2:180;yi=-89:2:90;
v_000_ll = cube2latlon(xc,yc,vN_000,xi,yi);
v_010_ll = cube2latlon(xc,yc,vN_010,xi,yi);
v_025_ll = cube2latlon(xc,yc,vN_025,xi,yi);
v_050_ll = cube2latlon(xc,yc,vN_050,xi,yi);
v_075_ll = cube2latlon(xc,yc,vN_075,xi,yi);
v_100_ll = cube2latlon(xc,yc,vN_100,xi,yi);

v_000_ll_tav = repmat(mean(v_000_ll,4),[1 1 1 720]);
v_010_ll_tav = repmat(mean(v_010_ll,4),[1 1 1 720]);
v_025_ll_tav = repmat(mean(v_025_ll,4),[1 1 1 720]);
v_050_ll_tav = repmat(mean(v_050_ll,4),[1 1 1 720]);
v_075_ll_tav = repmat(mean(v_075_ll,4),[1 1 1 720]);
v_100_ll_tav = repmat(mean(v_100_ll,4),[1 1 1 720]);

%locate region of interest
vsq_ed_000_n = (v_000_ll(:,x000n-7:x000n+7,:,:) - v_000_ll_tav(:,x000n-7:x000n+7,:,:)).^2;
vsq_ed_010_n = (v_010_ll(:,x010n-7:x010n+7,:,:) - v_010_ll_tav(:,x010n-7:x010n+7,:,:)).^2;
vsq_ed_025_n = (v_025_ll(:,x025n-7:x025n+7,:,:) - v_025_ll_tav(:,x025n-7:x025n+7,:,:)).^2;
vsq_ed_050_n = (v_050_ll(:,x050n-7:x050n+7,:,:) - v_050_ll_tav(:,x050n-7:x050n+7,:,:)).^2;
vsq_ed_075_n = (v_075_ll(:,x075n-7:x075n+7,:,:) - v_075_ll_tav(:,x075n-7:x075n+7,:,:)).^2;
vsq_ed_100_n = (v_100_ll(:,x100n-7:x100n+7,:,:) - v_100_ll_tav(:,x100n-7:x100n+7,:,:)).^2;

vsq_ed_000_s = (v_000_ll(:,x000s-7:x000s+7,:,:) - v_000_ll_tav(:,x000s-7:x000s+7,:,:)).^2;
vsq_ed_010_s = (v_010_ll(:,x010s-7:x010s+7,:,:) - v_010_ll_tav(:,x010s-7:x010s+7,:,:)).^2;
vsq_ed_025_s = (v_025_ll(:,x025s-7:x025s+7,:,:) - v_025_ll_tav(:,x025s-7:x025s+7,:,:)).^2;
vsq_ed_050_s = (v_050_ll(:,x050s-7:x050s+7,:,:) - v_050_ll_tav(:,x050s-7:x050s+7,:,:)).^2;
vsq_ed_075_s = (v_075_ll(:,x075s-7:x075s+7,:,:) - v_075_ll_tav(:,x075s-7:x075s+7,:,:)).^2;
vsq_ed_100_s = (v_100_ll(:,x100s-7:x100s+7,:,:) - v_100_ll_tav(:,x100s-7:x100s+7,:,:)).^2;

%clear large matrices
clear('v_000_ll','v_010_ll','v_025_ll','v_050_ll','v_075_ll','v_100_ll','vN_000','vN_010','vN_025','vN_050','vN_075','vN_100')

[comp_vsq_ed_000_m2,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,vsq_ed_000_n,vsq_ed_000_s,-2,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_000m2.mat');
[comp_vsq_ed_000_m1,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,vsq_ed_000_n,vsq_ed_000_s,-1,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_000m1.mat');
[comp_vsq_ed_000_0,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,vsq_ed_000_n,vsq_ed_000_s,0,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_000.mat');
[comp_vsq_ed_000_p1,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,vsq_ed_000_n,vsq_ed_000_s,1,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_000p1.mat');
[comp_vsq_ed_000_p2,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,vsq_ed_000_n,vsq_ed_000_s,2,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_000p2.mat');

[comp_vsq_ed_010_m2,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,vsq_ed_010_n,vsq_ed_010_s,-2,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_010m2.mat');
[comp_vsq_ed_010_m1,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,vsq_ed_010_n,vsq_ed_010_s,-1,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_010m1.mat');
[comp_vsq_ed_010_0,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,vsq_ed_010_n,vsq_ed_010_s,0,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_010.mat');
[comp_vsq_ed_010_p1,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,vsq_ed_010_n,vsq_ed_010_s,1,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_010p1.mat');
[comp_vsq_ed_010_p2,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,vsq_ed_010_n,vsq_ed_010_s,2,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_010p2.mat');

[comp_vsq_ed_025_m2,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,vsq_ed_025_n,vsq_ed_025_s,-2,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_025m2.mat');
[comp_vsq_ed_025_m1,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,vsq_ed_025_n,vsq_ed_025_s,-1,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_025m1.mat');
[comp_vsq_ed_025_0,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,vsq_ed_025_n,vsq_ed_025_s,0,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_025.mat');
[comp_vsq_ed_025_p1,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,vsq_ed_025_n,vsq_ed_025_s,1,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_025p1.mat');
[comp_vsq_ed_025_p2,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,vsq_ed_025_n,vsq_ed_025_s,2,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_025p2.mat');

[comp_vsq_ed_050_m2,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,vsq_ed_050_n,vsq_ed_050_s,-2,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_050m2.mat');
[comp_vsq_ed_050_m1,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,vsq_ed_050_n,vsq_ed_050_s,-1,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_050m1.mat');
[comp_vsq_ed_050_0,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,vsq_ed_050_n,vsq_ed_050_s,0,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_050.mat');
[comp_vsq_ed_050_p1,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,vsq_ed_050_n,vsq_ed_050_s,1,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_050p1.mat');
[comp_vsq_ed_050_p2,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,vsq_ed_050_n,vsq_ed_050_s,2,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_050p2.mat');

[comp_vsq_ed_075_m2,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,vsq_ed_075_n,vsq_ed_075_s,-2,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_075m2.mat');
[comp_vsq_ed_075_m1,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,vsq_ed_075_n,vsq_ed_075_s,-1,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_075m1.mat');
[comp_vsq_ed_075_0,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,vsq_ed_075_n,vsq_ed_075_s,0,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_075.mat');
[comp_vsq_ed_075_p1,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,vsq_ed_075_n,vsq_ed_075_s,1,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_075p1.mat');
[comp_vsq_ed_075_p2,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,vsq_ed_075_n,vsq_ed_075_s,2,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_075p2.mat');

[comp_vsq_ed_100_m2,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,vsq_ed_100_n,vsq_ed_100_s,-2,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_100m2.mat');
[comp_vsq_ed_100_m1,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,vsq_ed_100_n,vsq_ed_100_s,-1,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_100m1.mat');
[comp_vsq_ed_100_0,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,vsq_ed_100_n,vsq_ed_100_s,0,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_100.mat');
[comp_vsq_ed_100_p1,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,vsq_ed_100_n,vsq_ed_100_s,1,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_100p1.mat');
[comp_vsq_ed_100_p2,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,vsq_ed_100_n,vsq_ed_100_s,2,'/project/rg312/mat_files/composite_data_tlag/vsq_ed_compdata_100p2.mat');




x=-34:2:34;
v = 0:50:750;
figure
 contourf(x,rC./100,nanmean(comp_vsq_ed_000_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
%colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_000_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.0es0, lag -2','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_000_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_000_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_000_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.0es0, lag -1','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_000_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_000_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_000_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.0es0','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_000_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_000_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_000_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.0es0, lag 1','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_000_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_000_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_000_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.0es0, lag 2','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_000_p2.png')
hold off



figure
 contourf(x,rC./100,nanmean(comp_vsq_ed_010_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_010_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.1es0, lag -2','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_010_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_010_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_010_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.1es0, lag -1','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_010_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_010_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_010_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.1es0','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_010_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_010_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_010_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.1es0, lag 1','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_010_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_010_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_010_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.1es0, lag 2','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_010_p2.png')
hold off



figure
 contourf(x,rC./100,nanmean(comp_vsq_ed_025_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_025_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.25es0, lag -2','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_025_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_025_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_025_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.25es0, lag -1','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_025_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_025_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_025_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.25es0','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_025_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_025_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_025_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.25es0, lag 1','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_025_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_025_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_025_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.25es0, lag 2','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_025_p2.png')
hold off



figure
 contourf(x,rC./100,nanmean(comp_vsq_ed_050_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_050_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.5es0, lag -2','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_050_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_050_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_050_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.5es0, lag -1','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_050_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_050_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_050_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.5es0','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_050_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_050_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_050_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.5es0, lag 1','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_050_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_050_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_050_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.5es0, lag 2','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_050_p2.png')
hold off




figure
 contourf(x,rC./100,nanmean(comp_vsq_ed_075_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_075_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.75es0, lag -2','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_075_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_075_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_075_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.75es0, lag -1','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_075_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_075_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_075_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.75es0','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_075_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_075_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_075_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.75es0, lag 1','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_075_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_075_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_075_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.75es0, lag 2','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_075_p2.png')
hold off




figure
 contourf(x,rC./100,nanmean(comp_vsq_ed_100_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_100_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 1.0es0, lag -2','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_100_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_100_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_100_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 1.0es0, lag -1','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_100_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_100_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_100_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 1.0es0','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_100_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_100_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_100_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 1.0es0, lag 1','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_100_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vsq_ed_100_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 750])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vsq_ed_100_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 1.0es0, lag 2','FontSize',15)
print('-dpng','../vsq_ed_tlag_plots/vsq_ed_100_p2.png')
hold off




