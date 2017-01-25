%plot w composites with time lag to see if 100 run develops differently?


%load in data

% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_doshallowerth/';
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

load('/project/rg312/mat_files/snapshot_data/vt_extreme_data_th.mat')
load('/project/rg312/mat_files/vt_lats_th.mat')
load('/project/rg312/mat_files/snapshot_data/w_snapshots_th.mat')


%transfer w to ll
xi=-179:2:180;yi=-89:2:90;
w_th_ll = cube2latlon(xc,yc,w_th,xi,yi);

%locate region of interest
w_th_n = squeeze(w_th_ll(:,xthn-7:xthn+7,:,:));

w_th_s = squeeze(w_th_ll(:,xths-7:xths+7,:,:));


%clear large matrices
clear('w_th_ll','w_th')

[comp_w_th_m2,check0] = composite_fun_timelag(peaks_th,vt_thresh_th,w_th_n,w_th_s,-2,'/project/rg312/mat_files/composite_data_tlag/w_compdata_thm2.mat');
[comp_w_th_m1,check0] = composite_fun_timelag(peaks_th,vt_thresh_th,w_th_n,w_th_s,-1,'/project/rg312/mat_files/composite_data_tlag/w_compdata_thm1.mat');
[comp_w_th_0,check0] = composite_fun_timelag(peaks_th,vt_thresh_th,w_th_n,w_th_s,0,'/project/rg312/mat_files/composite_data_tlag/w_compdata_th.mat');
[comp_w_th_p1,check0] = composite_fun_timelag(peaks_th,vt_thresh_th,w_th_n,w_th_s,1,'/project/rg312/mat_files/composite_data_tlag/w_compdata_thp1.mat');
[comp_w_th_p2,check0] = composite_fun_timelag(peaks_th,vt_thresh_th,w_th_n,w_th_s,2,'/project/rg312/mat_files/composite_data_tlag/w_compdata_thp2.mat');




x=-34:2:34;
v = -0.25:0.01:0.16;
figure
 contourf(x,rC./100,nanmean(comp_w_th_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_w_th_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.5es0, tropical heating, lag -2','FontSize',15)
print('-dpng','../w_tlag_plots/w_th_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_w_th_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_w_th_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.5es0, tropical heating, lag -1','FontSize',15)
print('-dpng','../w_tlag_plots/w_th_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_w_th_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_w_th_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.5es0, tropical heating','FontSize',15)
print('-dpng','../w_tlag_plots/w_th_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_w_th_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_w_th_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.5es0, tropical heating, lag 1','FontSize',15)
print('-dpng','../w_tlag_plots/w_th_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_w_th_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_w_th_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.5es0, tropical heating, lag 2','FontSize',15)
print('-dpng','../w_tlag_plots/w_th_p2.png')
hold off

