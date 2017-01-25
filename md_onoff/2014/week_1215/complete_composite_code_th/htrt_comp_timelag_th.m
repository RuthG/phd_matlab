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
load('/project/rg312/mat_files/heat_rates_th.mat')

clear('difht_th','radht_th','cndht_th','cnvht_th')

%transfer to ll
xi=-179:2:180;yi=-89:2:90;
htrt_th_ll = cube2latlon(xc,yc,htrt_th,xi,yi).*86400;

%locate region of interest
htrt_th_n = squeeze(htrt_th_ll(:,xthn-7:xthn+7,:,:));

htrt_th_s = squeeze(htrt_th_ll(:,xths-7:xths+7,:,:));

%clear large matrices
clear('htrt_th_ll','htrt_th')

[comp_htrt_th_m2,check0] = composite_fun_timelag(peaks_th,vt_thresh_th,htrt_th_n,htrt_th_s,-2,'/project/rg312/mat_files/composite_data_tlag/htrt_compdata_thm2.mat');
[comp_htrt_th_m1,check0] = composite_fun_timelag(peaks_th,vt_thresh_th,htrt_th_n,htrt_th_s,-1,'/project/rg312/mat_files/composite_data_tlag/htrt_compdata_thm1.mat');
[comp_htrt_th_0,check0] = composite_fun_timelag(peaks_th,vt_thresh_th,htrt_th_n,htrt_th_s,0,'/project/rg312/mat_files/composite_data_tlag/htrt_compdata_th.mat');
[comp_htrt_th_p1,check0] = composite_fun_timelag(peaks_th,vt_thresh_th,htrt_th_n,htrt_th_s,1,'/project/rg312/mat_files/composite_data_tlag/htrt_compdata_thp1.mat');
[comp_htrt_th_p2,check0] = composite_fun_timelag(peaks_th,vt_thresh_th,htrt_th_n,htrt_th_s,2,'/project/rg312/mat_files/composite_data_tlag/htrt_compdata_thp2.mat');



x=-34:2:34;
v = -2:0.2:3;
figure
 contourf(x,rC./100,nanmean(comp_htrt_th_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-2,3));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_htrt_th_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Diabatic heating composite, 0.5es0, tropical heating, lag -2','FontSize',15)
print('-dpng','../htrt_tlag_plots/htrt_th_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_htrt_th_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-2,3));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_htrt_th_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Diabatic heating composite, 0.5es0, tropical heating, lag -1','FontSize',15)
print('-dpng','../htrt_tlag_plots/htrt_th_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_htrt_th_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-2,3));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_htrt_th_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Diabatic heating composite, 0.5es0, tropical heating','FontSize',15)
print('-dpng','../htrt_tlag_plots/htrt_th_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_htrt_th_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-2,3));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_htrt_th_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Diabatic heating composite, 0.5es0, tropical heating, lag 1','FontSize',15)
print('-dpng','../htrt_tlag_plots/htrt_th_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_htrt_th_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-2,3));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_htrt_th_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Diabatic heating composite, 0.5es0, tropical heating, lag 2','FontSize',15)
print('-dpng','../htrt_tlag_plots/htrt_th_p2.png')
hold off


