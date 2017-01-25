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

clear('difht_th','cnvht_th','cndht_th','htrt_th')

%transfer to ll
xi=-179:2:180;yi=-89:2:90;
radht_th_ll = cube2latlon(xc,yc,radht_th,xi,yi).*86400;

%locate region of interest
radht_th_n = squeeze(radht_th_ll(:,xthn-7:xthn+7,:,:));

radht_th_s = squeeze(radht_th_ll(:,xths-7:xths+7,:,:));

%clear large matrices
clear('radht_th_ll','radht_th')

[comp_radht_th_m2,check0] = composite_fun_timelag(peaks_th,vt_thresh_th,radht_th_n,radht_th_s,-2,'/project/rg312/mat_files/composite_data_tlag/radht_compdata_thm2.mat');
[comp_radht_th_m1,check0] = composite_fun_timelag(peaks_th,vt_thresh_th,radht_th_n,radht_th_s,-1,'/project/rg312/mat_files/composite_data_tlag/radht_compdata_thm1.mat');
[comp_radht_th_0,check0] = composite_fun_timelag(peaks_th,vt_thresh_th,radht_th_n,radht_th_s,0,'/project/rg312/mat_files/composite_data_tlag/radht_compdata_th.mat');
[comp_radht_th_p1,check0] = composite_fun_timelag(peaks_th,vt_thresh_th,radht_th_n,radht_th_s,1,'/project/rg312/mat_files/composite_data_tlag/radht_compdata_thp1.mat');
[comp_radht_th_p2,check0] = composite_fun_timelag(peaks_th,vt_thresh_th,radht_th_n,radht_th_s,2,'/project/rg312/mat_files/composite_data_tlag/radht_compdata_thp2.mat');





x=-34:2:34;
v = -3:0.2:0.2;
figure
 contourf(x,rC./100,nanmean(comp_radht_th_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-3,0.2));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_radht_th_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Radiative heating composite, 0.5es0, tropical heating, lag -2','FontSize',15)
print('-dpng','../radht_tlag_plots/radht_th_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_radht_th_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-3,0.2));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_radht_th_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Radiative heating composite, 0.5es0, tropical heating, lag -1','FontSize',15)
print('-dpng','../radht_tlag_plots/radht_th_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_radht_th_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-3,0.2));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_radht_th_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Radiative heating composite, 0.5es0, tropical heating','FontSize',15)
print('-dpng','../radht_tlag_plots/radht_th_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_radht_th_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-3,0.2));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_radht_th_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Radiative heating composite, 0.5es0, tropical heating, lag 1','FontSize',15)
print('-dpng','../radht_tlag_plots/radht_th_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_radht_th_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-3,0.2));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_radht_th_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Radiative heating composite, 0.5es0, tropical heating, lag 2','FontSize',15)
print('-dpng','../radht_tlag_plots/radht_th_p2.png')
hold off

