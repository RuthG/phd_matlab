%load in composite data and plot up



load('/project/rg312/mat_files/q_ed_compdata_000.mat')
comp_q_ed_000 = nanmean(comp_data,3);
load('/project/rg312/mat_files/q_ed_compdata_010.mat')
comp_q_ed_010 = nanmean(comp_data,3);
load('/project/rg312/mat_files/q_ed_compdata_025.mat')
comp_q_ed_025 = nanmean(comp_data,3);
load('/project/rg312/mat_files/q_ed_compdata_050.mat')
comp_q_ed_050 = nanmean(comp_data,3);
load('/project/rg312/mat_files/q_ed_compdata_075.mat')
comp_q_ed_075 = nanmean(comp_data,3);
load('/project/rg312/mat_files/q_ed_compdata_100.mat')
comp_q_ed_100 = nanmean(comp_data,3);

rC = 980:-40:20;
xi = -34:2:34;
v = -0.001:0.00025:0.003;
colormap('default')
hold off
[C,h] = contourf(xi,rC,comp_q_ed_000',v);
colormap(b2r(-0.001,0.003));
hold on
[C,h] = contour(xi,rC,comp_q_ed_000',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q'' composite, 0.0es0','FontSize',15)
print('-dpng','q_ed_comp/q_ed_000.png')

hold off
[C,h] = contourf(xi,rC,comp_q_ed_010',v);
colormap(b2r(-0.001,0.003));
hold on
[C,h] = contour(xi,rC,comp_q_ed_010',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q'' composite, 0.10es0','FontSize',15)
print('-dpng','q_ed_comp/q_ed_010.png')

hold off
[C,h] = contourf(xi,rC,comp_q_ed_025',v);
colormap(b2r(-0.001,0.003));
hold on
[C,h] = contour(xi,rC,comp_q_ed_025',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q'' composite, 0.25es0','FontSize',15)
print('-dpng','q_ed_comp/q_ed_025.png')

hold off
[C,h] = contourf(xi,rC,comp_q_ed_050',v);
colormap(b2r(-0.001,0.003));
hold on
[C,h] = contour(xi,rC,comp_q_ed_050',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q'' composite, 0.5es0','FontSize',15)
print('-dpng','q_ed_comp/q_ed_050.png')

hold off
[C,h] = contourf(xi,rC,comp_q_ed_075',v);
colormap(b2r(-0.001,0.003));
hold on
[C,h] = contour(xi,rC,comp_q_ed_075',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q'' composite, 0.75es0','FontSize',15)
print('-dpng','q_ed_comp/q_ed_075.png')

hold off
[C,h] = contourf(xi,rC,comp_q_ed_100',v);
colormap(b2r(-0.001,0.003));
hold on
[C,h] = contour(xi,rC,comp_q_ed_100',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q'' composite, 1.0es0','FontSize',15)
print('-dpng','q_ed_comp/q_ed_100.png')



clear


load('/project/rg312/mat_files/th_ed_compdata_000.mat')
comp_th_ed_000 = nanmean(comp_data,3);
load('/project/rg312/mat_files/th_ed_compdata_010.mat')
comp_th_ed_010 = nanmean(comp_data,3);
load('/project/rg312/mat_files/th_ed_compdata_025.mat')
comp_th_ed_025 = nanmean(comp_data,3);
load('/project/rg312/mat_files/th_ed_compdata_050.mat')
comp_th_ed_050 = nanmean(comp_data,3);
load('/project/rg312/mat_files/th_ed_compdata_075.mat')
comp_th_ed_075 = nanmean(comp_data,3);
load('/project/rg312/mat_files/th_ed_compdata_100.mat')
comp_th_ed_100 = nanmean(comp_data,3);

rC = 980:-40:20;
xi = -34:2:34;
v = -10:1:10;
colormap('default')
hold off
[C,h] = contourf(xi,rC,comp_th_ed_000',v);
colormap(b2r(-10,10));
hold on
[C,h] = contour(xi,rC,comp_th_ed_000',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta'' composite, 0.0es0','FontSize',15)
print('-dpng','th_ed_comp/th_ed_000.png')

hold off
[C,h] = contourf(xi,rC,comp_th_ed_010',v);
colormap(b2r(-10,10));
hold on
[C,h] = contour(xi,rC,comp_th_ed_010',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta'' composite, 0.10es0','FontSize',15)
print('-dpng','th_ed_comp/th_ed_010.png')

hold off
[C,h] = contourf(xi,rC,comp_th_ed_025',v);
colormap(b2r(-10,10));
hold on
[C,h] = contour(xi,rC,comp_th_ed_025',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta'' composite, 0.25es0','FontSize',15)
print('-dpng','th_ed_comp/th_ed_025.png')

hold off
[C,h] = contourf(xi,rC,comp_th_ed_050',v);
colormap(b2r(-10,10));
hold on
[C,h] = contour(xi,rC,comp_th_ed_050',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta'' composite, 0.5es0','FontSize',15)
print('-dpng','th_ed_comp/th_ed_050.png')

hold off
[C,h] = contourf(xi,rC,comp_th_ed_075',v);
colormap(b2r(-10,10));
hold on
[C,h] = contour(xi,rC,comp_th_ed_075',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta'' composite, 0.75es0','FontSize',15)
print('-dpng','th_ed_comp/th_ed_075.png')

hold off
[C,h] = contourf(xi,rC,comp_th_ed_100',v);
colormap(b2r(-10,10));
hold on
[C,h] = contour(xi,rC,comp_th_ed_100',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta'' composite, 1.0es0','FontSize',15)
print('-dpng','th_ed_comp/th_ed_100.png')


