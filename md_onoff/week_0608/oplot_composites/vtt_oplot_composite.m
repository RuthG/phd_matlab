%load in v' and T' and produce overplotted composite

rDir='/project/rg312/wv_on_rad_off/run_000_best/';
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
xi = -179:2:179;

load('/project/rg312/mat_files/front_diag_composite_data/t_ed_000_best.mat')
t_ed_comp = comp_data;
load('/project/rg312/mat_files/front_diag_composite_data/vNt_ed_000_best.mat')
vNt_ed_comp = comp_data;
clear comp_data
x=-34:2:34;

figure
v=-20:5:50;
[C,h] = contourf(x,rC./100,nanmean(vNt_ed_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15); set(h,'LineStyle','none');
colorbar('FontSize',15)
colormap(b2r(-20,50));
hold on
[C,h] = contour(x,rC./100,nanmean(vNt_ed_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
v=-5:1:5;
[C,h] = contour(x,rC./100,nanmean(t_ed_comp,3)',v,'k','LineWidth',2);
clabel(C,h);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.0e_{s0}')
print('-dpng','vtt_oplot_000.png')
hold off





rDir='/project/rg312/wv_on_rad_off/run_010_best/';
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
xi = -179:2:179;

load('/project/rg312/mat_files/front_diag_composite_data/t_ed_010_best.mat')
t_ed_comp = comp_data;
load('/project/rg312/mat_files/front_diag_composite_data/vNt_ed_010_best.mat')
vNt_ed_comp = comp_data;
clear comp_data
x=-34:2:34;

figure
v=-20:5:50;
[C,h] = contourf(x,rC./100,nanmean(vNt_ed_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15); set(h,'LineStyle','none');
colorbar('FontSize',15)
colormap(b2r(-20,50));
hold on
[C,h] = contour(x,rC./100,nanmean(vNt_ed_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
v=-5:1:5;
[C,h] = contour(x,rC./100,nanmean(t_ed_comp,3)',v,'k','LineWidth',2);
clabel(C,h);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.1e_{s0}')
print('-dpng','vtt_oplot_010.png')
hold off






rDir='/project/rg312/wv_on_rad_off/run_025_best/';
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
xi = -179:2:179;

load('/project/rg312/mat_files/front_diag_composite_data/t_ed_025_best.mat')
t_ed_comp = comp_data;
load('/project/rg312/mat_files/front_diag_composite_data/vNt_ed_025_best.mat')
vNt_ed_comp = comp_data;
clear comp_data
x=-34:2:34;

figure
v=-20:5:50;
[C,h] = contourf(x,rC./100,nanmean(vNt_ed_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15); set(h,'LineStyle','none');
colorbar('FontSize',15)
colormap(b2r(-20,50));
hold on
[C,h] = contour(x,rC./100,nanmean(vNt_ed_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
v=-5:1:5;
[C,h] = contour(x,rC./100,nanmean(t_ed_comp,3)',v,'k','LineWidth',2);
clabel(C,h);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.25e_{s0}')
print('-dpng','vtt_oplot_025.png')
hold off






rDir='/project/rg312/wv_on_rad_off/run_050_best/';
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
xi = -179:2:179;

load('/project/rg312/mat_files/front_diag_composite_data/t_ed_050_best.mat')
t_ed_comp = comp_data;
load('/project/rg312/mat_files/front_diag_composite_data/vNt_ed_050_best.mat')
vNt_ed_comp = comp_data;
clear comp_data
x=-34:2:34;

figure
v=-20:5:50;
[C,h] = contourf(x,rC./100,nanmean(vNt_ed_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15); set(h,'LineStyle','none');
colorbar('FontSize',15)
colormap(b2r(-20,50));
hold on
[C,h] = contour(x,rC./100,nanmean(vNt_ed_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
v=-5:1:5;
[C,h] = contour(x,rC./100,nanmean(t_ed_comp,3)',v,'k','LineWidth',2);
clabel(C,h);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.5e_{s0}')
print('-dpng','vtt_oplot_050.png')
hold off






rDir='/project/rg312/wv_on_rad_off/run_075_best/';
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
xi = -179:2:179;

load('/project/rg312/mat_files/front_diag_composite_data/t_ed_075_best.mat')
t_ed_comp = comp_data;
load('/project/rg312/mat_files/front_diag_composite_data/vNt_ed_075_best.mat')
vNt_ed_comp = comp_data;
clear comp_data
x=-34:2:34;

figure
v=-20:5:50;
[C,h] = contourf(x,rC./100,nanmean(vNt_ed_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15); set(h,'LineStyle','none');
colorbar('FontSize',15)
colormap(b2r(-20,50));
hold on
[C,h] = contour(x,rC./100,nanmean(vNt_ed_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
v=-5:1:5;
[C,h] = contour(x,rC./100,nanmean(t_ed_comp,3)',v,'k','LineWidth',2);
clabel(C,h);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.75e_{s0}')
print('-dpng','vtt_oplot_075.png')
hold off






rDir='/project/rg312/wv_on_rad_off/run_100_best/';
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
xi = -179:2:179;

load('/project/rg312/mat_files/front_diag_composite_data/t_ed_100_best.mat')
t_ed_comp = comp_data;
load('/project/rg312/mat_files/front_diag_composite_data/vNt_ed_100_best.mat')
vNt_ed_comp = comp_data;
clear comp_data
x=-34:2:34;

figure
v=-20:5:50;
[C,h] = contourf(x,rC./100,nanmean(vNt_ed_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15); set(h,'LineStyle','none');
colorbar('FontSize',15)
colormap(b2r(-20,50));
hold on
[C,h] = contour(x,rC./100,nanmean(vNt_ed_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
v=-5:1:5;
[C,h] = contour(x,rC./100,nanmean(t_ed_comp,3)',v,'k','LineWidth',2);
clabel(C,h);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('1.0e_{s0}')
print('-dpng','vtt_oplot_100.png')
hold off



