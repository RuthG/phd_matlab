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


[comp_vt_000_0,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,vt_ed_000n,vt_ed_000s,0,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_000.mat');

[comp_vt_100_0,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,vt_ed_100n,vt_ed_100s,0,'/project/rg312/mat_files/composite_data_tlag/vt_compdata_100.mat');




x=-34:2:34;
v = -40:5:110;
figure

 contourf(x,rC./100,nanmean(comp_vt_000_0,3)',v,'LineWidth',2)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_000_0,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('e_{s0} = 0.0 Pa')
print('-dpng','vt_000_0.png')
hold off


x=-34:2:34;
v = -40:5:110;
figure

 contourf(x,rC./100,nanmean(comp_vt_100_0,3)',v,'LineWidth',2)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-40,110));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_vt_100_0,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('e_{s0} = 610.78 Pa')
print('-dpng','vt_100_0.png')
hold off


clear

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

load('/project/rg312/mat_files/composite_data_tlag/w_compdata_000.mat')
comp_w_000 = nanmean(comp_data,3);

load('/project/rg312/mat_files/composite_data_tlag/w_compdata_100.mat')
comp_w_100 = nanmean(comp_data,3);

load('/project/rg312/mat_files/composite_data_tlag/htrt_compdata_000.mat')
comp_htrt_000 = nanmean(comp_data,3);

load('/project/rg312/mat_files/composite_data_tlag/htrt_compdata_100.mat')
comp_htrt_100 = nanmean(comp_data,3);

x=-34:2:34;
v = -0.25:0.01:0.16;
figure
[C,h] = contourf(x,rC./100,comp_w_000',v);
set(h,'LineColor','none')
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
v=-1000:1000:1000;
[C,h] = contour(x,rC./100,comp_w_000',v,'Color',[0.6 0.6 0.6],'LineWidth',2);
v = 0:1:3;
[C,h] = contour(x,rC./100,comp_htrt_000',v,'k','LineWidth',2);
clabel(C,h,[-2:1:3])
v = -2:1:-1;
[C,h] = contour(x,rC./100,comp_htrt_000',v,'k--','LineWidth',2);
clabel(C,h,[-2:1:3])
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('e_{s0} = 0.0 Pa')
print('-dpng','wht_000_0.png')
hold off


x=-34:2:34;
v = -0.25:0.01:0.16;
figure
[C,h] = contourf(x,rC./100,comp_w_100',v);
set(h,'LineColor','none')
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
v=-1000:1000:1000;
[C,h] = contour(x,rC./100,comp_w_100',v,'Color',[0.6 0.6 0.6],'LineWidth',2);
v = 0:1:3;
[C,h] = contour(x,rC./100,comp_htrt_100',v,'k','LineWidth',2);
clabel(C,h,[-2:1:3])
v = -2:1:-1;
[C,h] = contour(x,rC./100,comp_htrt_100',v,'k--','LineWidth',2);
clabel(C,h,[-2:1:3])
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
%set(gca,'YTickLabel',[]);
title('e_{s0} = 610.78 Pa')
print('-dpng','wht_100_0.png')
hold off


