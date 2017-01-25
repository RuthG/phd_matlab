%load in composite data and plot up

load('/project/rg312/mat_files/htrt_compdata_000.mat')
comp_htrt_000 = nanmean(comp_data,3).*86400;
load('/project/rg312/mat_files/htrt_compdata_010.mat')
comp_htrt_010 = nanmean(comp_data,3).*86400;
load('/project/rg312/mat_files/htrt_compdata_025.mat')
comp_htrt_025 = nanmean(comp_data,3).*86400;
load('/project/rg312/mat_files/htrt_compdata_050.mat')
comp_htrt_050 = nanmean(comp_data,3).*86400;
load('/project/rg312/mat_files/htrt_compdata_075.mat')
comp_htrt_075 = nanmean(comp_data,3).*86400;
load('/project/rg312/mat_files/htrt_compdata_100.mat')
comp_htrt_100 = nanmean(comp_data,3).*86400;

rC = 980:-40:20;
xi = -34:2:34;
v = -3.5:0.5:5;
[C,h] = contourf(xi,rC,comp_htrt_000',v);
colormap(b2r(-3.5,5));
hold on
[C,h] = contour(xi,rC,comp_htrt_000',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Total heating rate composite, 0.0es0','FontSize',15)
print('-dpng','htrt_comp/htrt_000.png')

hold off
[C,h] = contourf(xi,rC,comp_htrt_010',v);
colormap(b2r(-3.5,5));
hold on
[C,h] = contour(xi,rC,comp_htrt_010',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Total heating rate composite, 0.10es0','FontSize',15)
print('-dpng','htrt_comp/htrt_010.png')

hold off
[C,h] = contourf(xi,rC,comp_htrt_025',v);
colormap(b2r(-3.5,5));
hold on
[C,h] = contour(xi,rC,comp_htrt_025',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Total heating rate composite, 0.25es0','FontSize',15)
print('-dpng','htrt_comp/htrt_025.png')

hold off
[C,h] = contourf(xi,rC,comp_htrt_050',v);
colormap(b2r(-3.5,5));
hold on
[C,h] = contour(xi,rC,comp_htrt_050',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Total heating rate composite, 0.5es0','FontSize',15)
print('-dpng','htrt_comp/htrt_050.png')

hold off
[C,h] = contourf(xi,rC,comp_htrt_075',v);
colormap(b2r(-3.5,5));
hold on
[C,h] = contour(xi,rC,comp_htrt_075',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Total heating rate composite, 0.75es0','FontSize',15)
print('-dpng','htrt_comp/htrt_075.png')

hold off
[C,h] = contourf(xi,rC,comp_htrt_100',v);
colormap(b2r(-3.5,5));
hold on
[C,h] = contour(xi,rC,comp_htrt_100',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Total heating rate composite, 1.0es0','FontSize',15)
print('-dpng','htrt_comp/htrt_100.png')

clear


load('/project/rg312/mat_files/radht_compdata_000.mat')
comp_radht_000 = nanmean(comp_data,3).*86400;
load('/project/rg312/mat_files/radht_compdata_010.mat')
comp_radht_010 = nanmean(comp_data,3).*86400;
load('/project/rg312/mat_files/radht_compdata_025.mat')
comp_radht_025 = nanmean(comp_data,3).*86400;
load('/project/rg312/mat_files/radht_compdata_050.mat')
comp_radht_050 = nanmean(comp_data,3).*86400;
load('/project/rg312/mat_files/radht_compdata_075.mat')
comp_radht_075 = nanmean(comp_data,3).*86400;
load('/project/rg312/mat_files/radht_compdata_100.mat')
comp_radht_100 = nanmean(comp_data,3).*86400;

rC = 980:-40:20;
xi = -34:2:34;
v = -3:0.125:0.25;
hold off
[C,h] = contourf(xi,rC,comp_radht_000',v);
colormap(b2r(-3,0.25));
hold on
[C,h] = contour(xi,rC,comp_radht_000',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Radiative heating composite, 0.0es0','FontSize',15)
print('-dpng','radht_comp/radht_000.png')

hold off
[C,h] = contourf(xi,rC,comp_radht_010',v);
colormap(b2r(-3,0.25));
hold on
[C,h] = contour(xi,rC,comp_radht_010',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Radiative heating composite, 0.10es0','FontSize',15)
print('-dpng','radht_comp/radht_010.png')

hold off
[C,h] = contourf(xi,rC,comp_radht_025',v);
colormap(b2r(-3,0.25));
hold on
[C,h] = contour(xi,rC,comp_radht_025',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Radiative heating composite, 0.25es0','FontSize',15)
print('-dpng','radht_comp/radht_025.png')

hold off
[C,h] = contourf(xi,rC,comp_radht_050',v);
colormap(b2r(-3,0.25));
hold on
[C,h] = contour(xi,rC,comp_radht_050',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Radiative heating composite, 0.5es0','FontSize',15)
print('-dpng','radht_comp/radht_050.png')

hold off
[C,h] = contourf(xi,rC,comp_radht_075',v);
colormap(b2r(-3,0.25));
hold on
[C,h] = contour(xi,rC,comp_radht_075',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Radiative heating composite, 0.75es0','FontSize',15)
print('-dpng','radht_comp/radht_075.png')

hold off
[C,h] = contourf(xi,rC,comp_radht_100',v);
colormap(b2r(-3,0.25));
hold on
[C,h] = contour(xi,rC,comp_radht_100',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Radiative heating composite, 1.0es0','FontSize',15)
print('-dpng','radht_comp/radht_100.png')



clear


load('/project/rg312/mat_files/latht_compdata_000.mat')
comp_latht_000 = nanmean(comp_data,3).*86400;
load('/project/rg312/mat_files/latht_compdata_010.mat')
comp_latht_010 = nanmean(comp_data,3).*86400;
load('/project/rg312/mat_files/latht_compdata_025.mat')
comp_latht_025 = nanmean(comp_data,3).*86400;
load('/project/rg312/mat_files/latht_compdata_050.mat')
comp_latht_050 = nanmean(comp_data,3).*86400;
load('/project/rg312/mat_files/latht_compdata_075.mat')
comp_latht_075 = nanmean(comp_data,3).*86400;
load('/project/rg312/mat_files/latht_compdata_100.mat')
comp_latht_100 = nanmean(comp_data,3).*86400;

rC = 980:-40:20;
xi = -34:2:34;
v = -0.5:0.5:7.5;
hold off
[C,h] = contourf(xi,rC,comp_latht_000',v);
colormap(b2r(-0.5,7.5));
hold on
[C,h] = contour(xi,rC,comp_latht_000',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Latent heating composite, 0.0es0','FontSize',15)
print('-dpng','latht_comp/latht_000.png')

hold off
[C,h] = contourf(xi,rC,comp_latht_010',v);
colormap(b2r(-0.5,7.5));
hold on
[C,h] = contour(xi,rC,comp_latht_010',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Latent heating composite, 0.10es0','FontSize',15)
print('-dpng','latht_comp/latht_010.png')

hold off
[C,h] = contourf(xi,rC,comp_latht_025',v);
colormap(b2r(-0.5,7.5));
hold on
[C,h] = contour(xi,rC,comp_latht_025',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Latent heating composite, 0.25es0','FontSize',15)
print('-dpng','latht_comp/latht_025.png')

hold off
[C,h] = contourf(xi,rC,comp_latht_050',v);
colormap(b2r(-0.5,7.5));
hold on
[C,h] = contour(xi,rC,comp_latht_050',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Latent heating composite, 0.5es0','FontSize',15)
print('-dpng','latht_comp/latht_050.png')

hold off
[C,h] = contourf(xi,rC,comp_latht_075',v);
colormap(b2r(-0.5,7.5));
hold on
[C,h] = contour(xi,rC,comp_latht_075',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Latent heating composite, 0.75es0','FontSize',15)
print('-dpng','latht_comp/latht_075.png')

hold off
[C,h] = contourf(xi,rC,comp_latht_100',v);
colormap(b2r(-0.5,7.5));
hold on
[C,h] = contour(xi,rC,comp_latht_100',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Latent heating composite, 1.0es0','FontSize',15)
print('-dpng','latht_comp/latht_100.png')






clear


load('/project/rg312/mat_files/difht_compdata_000.mat')
comp_difht_000 = nanmean(comp_data,3).*86400;
load('/project/rg312/mat_files/difht_compdata_010.mat')
comp_difht_010 = nanmean(comp_data,3).*86400;
load('/project/rg312/mat_files/difht_compdata_025.mat')
comp_difht_025 = nanmean(comp_data,3).*86400;
load('/project/rg312/mat_files/difht_compdata_050.mat')
comp_difht_050 = nanmean(comp_data,3).*86400;
load('/project/rg312/mat_files/difht_compdata_075.mat')
comp_difht_075 = nanmean(comp_data,3).*86400;
load('/project/rg312/mat_files/difht_compdata_100.mat')
comp_difht_100 = nanmean(comp_data,3).*86400;

rC = 980:-40:20;
xi = -34:2:34;
v = -6:0.5:4;
hold off
[C,h] = contourf(xi,rC,comp_difht_000',v);
colormap(b2r(-6,4));
hold on
[C,h] = contour(xi,rC,comp_difht_000',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Diffusive heating composite, 0.0es0','FontSize',15)
print('-dpng','difht_comp/difht_000.png')

hold off
[C,h] = contourf(xi,rC,comp_difht_010',v);
colormap(b2r(-6,4));
hold on
[C,h] = contour(xi,rC,comp_difht_010',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Diffusive heating composite, 0.10es0','FontSize',15)
print('-dpng','difht_comp/difht_010.png')

hold off
[C,h] = contourf(xi,rC,comp_difht_025',v);
colormap(b2r(-6,4));
hold on
[C,h] = contour(xi,rC,comp_difht_025',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Diffusive heating composite, 0.25es0','FontSize',15)
print('-dpng','difht_comp/difht_025.png')

hold off
[C,h] = contourf(xi,rC,comp_difht_050',v);
colormap(b2r(-6,4));
hold on
[C,h] = contour(xi,rC,comp_difht_050',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Diffusive heating composite, 0.5es0','FontSize',15)
print('-dpng','difht_comp/difht_050.png')

hold off
[C,h] = contourf(xi,rC,comp_difht_075',v);
colormap(b2r(-6,4));
hold on
[C,h] = contour(xi,rC,comp_difht_075',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Diffusive heating composite, 0.75es0','FontSize',15)
print('-dpng','difht_comp/difht_075.png')

hold off
[C,h] = contourf(xi,rC,comp_difht_100',v);
colormap(b2r(-6,4));
hold on
[C,h] = contour(xi,rC,comp_difht_100',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('Diffusive heating composite, 1.0es0','FontSize',15)
print('-dpng','difht_comp/difht_100.png')


