%test time lag function; do events look at all coherent the day before.... NB might have to isolate latitudes for this if phase speeds diff with lat...




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
load('/project/rg312/mat_files/snapshot_data/vt_ed_data_th.mat')


[comp_vt_th_m2,check0] = composite_fun_timelag(peaks_th,vt_thresh_th,vt_ed_thn,vt_ed_ths,-2,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_thm2.mat');
[comp_vt_th_m1,check0] = composite_fun_timelag(peaks_th,vt_thresh_th,vt_ed_thn,vt_ed_ths,-1,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_thm1.mat');
[comp_vt_th_0,check0] = composite_fun_timelag(peaks_th,vt_thresh_th,vt_ed_thn,vt_ed_ths,0,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_th.mat');
[comp_vt_th_p1,check0] = composite_fun_timelag(peaks_th,vt_thresh_th,vt_ed_thn,vt_ed_ths,1,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_thp1.mat');
[comp_vt_th_p2,check0] = composite_fun_timelag(peaks_th,vt_thresh_th,vt_ed_thn,vt_ed_ths,2,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_thp2.mat');

x=-34:2:34;
v = -40:5:110;
figure
 contourf(x,rC./100,nanmean(comp_vt_th_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_th_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.5es0, tropical heating, lag -2','FontSize',15)
print('-dpng','../vt_tlag_plots/vt_th_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_th_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_th_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.5es0, tropical heating, lag -1','FontSize',15)
print('-dpng','../vt_tlag_plots/vt_th_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_th_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_th_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.5es0, tropical heating','FontSize',15)
print('-dpng','../vt_tlag_plots/vt_th_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_th_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_th_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.5es0, tropical heating, lag 1','FontSize',15)
print('-dpng','../vt_tlag_plots/vt_th_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_vt_th_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_th_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.5es0, tropical heating, lag 2','FontSize',15)
print('-dpng','../vt_tlag_plots/vt_th_p2.png')
hold off

