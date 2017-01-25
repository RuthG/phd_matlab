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
load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat')


%transfer v to ll
xi=-179:2:180;yi=-89:2:90;
t_000_ll = cube2latlon(xc,yc,t_000,xi,yi);
t_010_ll = cube2latlon(xc,yc,t_010,xi,yi);
t_025_ll = cube2latlon(xc,yc,t_025,xi,yi);
t_050_ll = cube2latlon(xc,yc,t_050,xi,yi);
t_075_ll = cube2latlon(xc,yc,t_075,xi,yi);
t_100_ll = cube2latlon(xc,yc,t_100,xi,yi);

t_000_ll_tav = repmat(mean(t_000_ll,4),[1 1 1 720]);
t_010_ll_tav = repmat(mean(t_010_ll,4),[1 1 1 720]);
t_025_ll_tav = repmat(mean(t_025_ll,4),[1 1 1 720]);
t_050_ll_tav = repmat(mean(t_050_ll,4),[1 1 1 720]);
t_075_ll_tav = repmat(mean(t_075_ll,4),[1 1 1 720]);
t_100_ll_tav = repmat(mean(t_100_ll,4),[1 1 1 720]);

%locate region of interest
tsq_ed_000_n = (t_000_ll(:,x000n-7:x000n+7,:,:) - t_000_ll_tav(:,x000n-7:x000n+7,:,:)).^2;
tsq_ed_010_n = (t_010_ll(:,x010n-7:x010n+7,:,:) - t_010_ll_tav(:,x010n-7:x010n+7,:,:)).^2;
tsq_ed_025_n = (t_025_ll(:,x025n-7:x025n+7,:,:) - t_025_ll_tav(:,x025n-7:x025n+7,:,:)).^2;
tsq_ed_050_n = (t_050_ll(:,x050n-7:x050n+7,:,:) - t_050_ll_tav(:,x050n-7:x050n+7,:,:)).^2;
tsq_ed_075_n = (t_075_ll(:,x075n-7:x075n+7,:,:) - t_075_ll_tav(:,x075n-7:x075n+7,:,:)).^2;
tsq_ed_100_n = (t_100_ll(:,x100n-7:x100n+7,:,:) - t_100_ll_tav(:,x100n-7:x100n+7,:,:)).^2;

tsq_ed_000_s = (t_000_ll(:,x000s-7:x000s+7,:,:) - t_000_ll_tav(:,x000s-7:x000s+7,:,:)).^2;
tsq_ed_010_s = (t_010_ll(:,x010s-7:x010s+7,:,:) - t_010_ll_tav(:,x010s-7:x010s+7,:,:)).^2;
tsq_ed_025_s = (t_025_ll(:,x025s-7:x025s+7,:,:) - t_025_ll_tav(:,x025s-7:x025s+7,:,:)).^2;
tsq_ed_050_s = (t_050_ll(:,x050s-7:x050s+7,:,:) - t_050_ll_tav(:,x050s-7:x050s+7,:,:)).^2;
tsq_ed_075_s = (t_075_ll(:,x075s-7:x075s+7,:,:) - t_075_ll_tav(:,x075s-7:x075s+7,:,:)).^2;
tsq_ed_100_s = (t_100_ll(:,x100s-7:x100s+7,:,:) - t_100_ll_tav(:,x100s-7:x100s+7,:,:)).^2;

%clear large matrices
clear('t_000_ll','t_010_ll','t_025_ll','t_050_ll','t_075_ll','t_100_ll','t_000','t_010','t_025','t_050','t_075','t_100')

[comp_tsq_ed_000_m2,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,tsq_ed_000_n,tsq_ed_000_s,-2,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_000m2.mat');
[comp_tsq_ed_000_m1,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,tsq_ed_000_n,tsq_ed_000_s,-1,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_000m1.mat');
[comp_tsq_ed_000_0,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,tsq_ed_000_n,tsq_ed_000_s,0,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_000.mat');
[comp_tsq_ed_000_p1,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,tsq_ed_000_n,tsq_ed_000_s,1,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_000p1.mat');
[comp_tsq_ed_000_p2,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,tsq_ed_000_n,tsq_ed_000_s,2,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_000p2.mat');

[comp_tsq_ed_010_m2,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,tsq_ed_010_n,tsq_ed_010_s,-2,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_010m2.mat');
[comp_tsq_ed_010_m1,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,tsq_ed_010_n,tsq_ed_010_s,-1,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_010m1.mat');
[comp_tsq_ed_010_0,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,tsq_ed_010_n,tsq_ed_010_s,0,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_010.mat');
[comp_tsq_ed_010_p1,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,tsq_ed_010_n,tsq_ed_010_s,1,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_010p1.mat');
[comp_tsq_ed_010_p2,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,tsq_ed_010_n,tsq_ed_010_s,2,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_010p2.mat');

[comp_tsq_ed_025_m2,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,tsq_ed_025_n,tsq_ed_025_s,-2,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_025m2.mat');
[comp_tsq_ed_025_m1,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,tsq_ed_025_n,tsq_ed_025_s,-1,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_025m1.mat');
[comp_tsq_ed_025_0,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,tsq_ed_025_n,tsq_ed_025_s,0,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_025.mat');
[comp_tsq_ed_025_p1,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,tsq_ed_025_n,tsq_ed_025_s,1,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_025p1.mat');
[comp_tsq_ed_025_p2,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,tsq_ed_025_n,tsq_ed_025_s,2,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_025p2.mat');

[comp_tsq_ed_050_m2,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,tsq_ed_050_n,tsq_ed_050_s,-2,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_050m2.mat');
[comp_tsq_ed_050_m1,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,tsq_ed_050_n,tsq_ed_050_s,-1,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_050m1.mat');
[comp_tsq_ed_050_0,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,tsq_ed_050_n,tsq_ed_050_s,0,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_050.mat');
[comp_tsq_ed_050_p1,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,tsq_ed_050_n,tsq_ed_050_s,1,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_050p1.mat');
[comp_tsq_ed_050_p2,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,tsq_ed_050_n,tsq_ed_050_s,2,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_050p2.mat');

[comp_tsq_ed_075_m2,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,tsq_ed_075_n,tsq_ed_075_s,-2,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_075m2.mat');
[comp_tsq_ed_075_m1,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,tsq_ed_075_n,tsq_ed_075_s,-1,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_075m1.mat');
[comp_tsq_ed_075_0,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,tsq_ed_075_n,tsq_ed_075_s,0,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_075.mat');
[comp_tsq_ed_075_p1,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,tsq_ed_075_n,tsq_ed_075_s,1,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_075p1.mat');
[comp_tsq_ed_075_p2,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,tsq_ed_075_n,tsq_ed_075_s,2,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_075p2.mat');

[comp_tsq_ed_100_m2,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,tsq_ed_100_n,tsq_ed_100_s,-2,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_100m2.mat');
[comp_tsq_ed_100_m1,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,tsq_ed_100_n,tsq_ed_100_s,-1,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_100m1.mat');
[comp_tsq_ed_100_0,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,tsq_ed_100_n,tsq_ed_100_s,0,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_100.mat');
[comp_tsq_ed_100_p1,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,tsq_ed_100_n,tsq_ed_100_s,1,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_100p1.mat');
[comp_tsq_ed_100_p2,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,tsq_ed_100_n,tsq_ed_100_s,2,'/project/rg312/mat_files/composite_data_tlag/tsq_ed_compdata_100p2.mat');




x=-34:2:34;
v = 0:5:60;
figure
 contourf(x,rC./100,nanmean(comp_tsq_ed_000_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
%colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_000_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.0es0, lag -2','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_000_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_000_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_000_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.0es0, lag -1','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_000_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_000_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_000_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.0es0','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_000_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_000_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_000_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.0es0, lag 1','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_000_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_000_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_000_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.0es0, lag 2','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_000_p2.png')
hold off



figure
 contourf(x,rC./100,nanmean(comp_tsq_ed_010_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_010_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.1es0, lag -2','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_010_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_010_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_010_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.1es0, lag -1','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_010_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_010_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_010_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.1es0','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_010_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_010_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_010_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.1es0, lag 1','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_010_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_010_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_010_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.1es0, lag 2','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_010_p2.png')
hold off



figure
 contourf(x,rC./100,nanmean(comp_tsq_ed_025_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_025_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.25es0, lag -2','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_025_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_025_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_025_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.25es0, lag -1','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_025_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_025_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_025_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.25es0','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_025_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_025_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_025_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.25es0, lag 1','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_025_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_025_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_025_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.25es0, lag 2','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_025_p2.png')
hold off



figure
 contourf(x,rC./100,nanmean(comp_tsq_ed_050_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_050_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.5es0, lag -2','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_050_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_050_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_050_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.5es0, lag -1','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_050_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_050_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_050_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.5es0','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_050_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_050_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_050_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.5es0, lag 1','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_050_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_050_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_050_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.5es0, lag 2','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_050_p2.png')
hold off




figure
 contourf(x,rC./100,nanmean(comp_tsq_ed_075_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_075_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.75es0, lag -2','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_075_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_075_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_075_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.75es0, lag -1','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_075_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_075_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_075_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.75es0','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_075_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_075_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_075_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.75es0, lag 1','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_075_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_075_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_075_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 0.75es0, lag 2','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_075_p2.png')
hold off




figure
 contourf(x,rC./100,nanmean(comp_tsq_ed_100_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_100_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 1.0es0, lag -2','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_100_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_100_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_100_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 1.0es0, lag -1','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_100_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_100_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_100_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 1.0es0','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_100_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_100_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_100_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 1.0es0, lag 1','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_100_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_tsq_ed_100_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 60])
hold on
[C,h] = contour(x,rC./100,nanmean(comp_tsq_ed_100_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('t''^{2} composite, 1.0es0, lag 2','FontSize',15)
print('-dpng','../tsq_ed_tlag_plots/tsq_ed_100_p2.png')
hold off




