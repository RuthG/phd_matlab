%load in composite data and plot up

load('/project/rg312/mat_files/composite_data_ssw/w_compdata_000.mat')
comp_w_000 = nanmean(comp_data,3);
load('/project/rg312/mat_files/composite_data_ssw/w_compdata_010.mat')
comp_w_010 = nanmean(comp_data,3);
load('/project/rg312/mat_files/composite_data_ssw/w_compdata_025.mat')
comp_w_025 = nanmean(comp_data,3);
load('/project/rg312/mat_files/composite_data_ssw/w_compdata_050.mat')
comp_w_050 = nanmean(comp_data,3);
load('/project/rg312/mat_files/composite_data_ssw/w_compdata_075.mat')
comp_w_075 = nanmean(comp_data,3);
load('/project/rg312/mat_files/composite_data_ssw/w_compdata_100.mat')
comp_w_100 = nanmean(comp_data,3);

rC = 980:-40:20;
xi = -72:2:72;
v = -0.2:0.02:0.16;
hold off
[C,h] = contourf(xi,rC,comp_w_000',v);
colormap(b2r(-0.2,0.16));
hold on
[C,h] = contour(xi,rC,comp_w_000',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.0es0','FontSize',15)
print('-dpng','w_comp_wide/w_000.png')

hold off
[C,h] = contourf(xi,rC,comp_w_010',v);
colormap(b2r(-0.2,0.16));
hold on
[C,h] = contour(xi,rC,comp_w_010',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.10es0','FontSize',15)
print('-dpng','w_comp_wide/w_010.png')

hold off
[C,h] = contourf(xi,rC,comp_w_025',v);
colormap(b2r(-0.2,0.16));
hold on
[C,h] = contour(xi,rC,comp_w_025',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.25es0','FontSize',15)
print('-dpng','w_comp_wide/w_025.png')

hold off
[C,h] = contourf(xi,rC,comp_w_050',v);
colormap(b2r(-0.2,0.16));
hold on
[C,h] = contour(xi,rC,comp_w_050',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.5es0','FontSize',15)
print('-dpng','w_comp_wide/w_050.png')

hold off
[C,h] = contourf(xi,rC,comp_w_075',v);
colormap(b2r(-0.2,0.16));
hold on
[C,h] = contour(xi,rC,comp_w_075',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.75es0','FontSize',15)
print('-dpng','w_comp_wide/w_075.png')

hold off
[C,h] = contourf(xi,rC,comp_w_100',v);
colormap(b2r(-0.2,0.16));
hold on
[C,h] = contour(xi,rC,comp_w_100',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 1.0es0','FontSize',15)
print('-dpng','w_comp_wide/w_100.png')





