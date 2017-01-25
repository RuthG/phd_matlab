%load in the heat budget terms and plot up nicely

load('/project/rg312/mat_files/eddy_diabatic_heating.mat')
load('/project/rg312/mat_files/eddy_adiabatic_heating.mat')
load('/project/rg312/mat_files/front_diag.mat')



%000


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Total Diabatic Heating, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrtfrontdiag_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,radht_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Radiative Heating, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','radhtfrontdiag_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,difht_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Diffusive Heating, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','difhtfrontdiag_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cndht_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Largescale Heating, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cndhtfrontdiag_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cnvht_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Convective Heating, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cnvhtfrontdiag_000.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udT_ed_dx_000',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('udT''dx, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','udtpdx_000.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,v_ed_dTdy_000',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('v''dTdy, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vpdtdy_000.png')



figure
v=-15:1:15;
[C,h] = contourf(xi,yi,w_ed_dTdp_000(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('w''dTdp, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wpdtdp_000.png')



%010


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_010_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Total Diabatic Heating, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrtfrontdiag_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,radht_ed_010_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Radiative Heating, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','radhtfrontdiag_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,difht_ed_010_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Diffusive Heating, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','difhtfrontdiag_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cndht_ed_010_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Largescale Heating, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cndhtfrontdiag_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cnvht_ed_010_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Convective Heating, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cnvhtfrontdiag_010.png')



figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udT_ed_dx_010',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('udT''dx, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','udtpdx_010.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,v_ed_dTdy_010',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('v''dTdy, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vpdtdy_010.png')



figure
v=-15:1:15;
[C,h] = contourf(xi,yi,w_ed_dTdp_010(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('w''dTdp, K/day, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wpdtdp_010.png')




%025


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_025_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Total Diabatic Heating, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrtfrontdiag_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,radht_ed_025_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Radiative Heating, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','radhtfrontdiag_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,difht_ed_025_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Diffusive Heating, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','difhtfrontdiag_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cndht_ed_025_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Largescale Heating, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cndhtfrontdiag_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cnvht_ed_025_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Convective Heating, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cnvhtfrontdiag_025.png')



figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udT_ed_dx_025',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('udT''dx, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','udtpdx_025.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,v_ed_dTdy_025',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('v''dTdy, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vpdtdy_025.png')



figure
v=-15:1:15;
[C,h] = contourf(xi,yi,w_ed_dTdp_025(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('w''dTdp, K/day, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wpdtdp_025.png')





%050


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_050_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Total Diabatic Heating, K/day, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrtfrontdiag_050.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,radht_ed_050_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Radiative Heating, K/day, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','radhtfrontdiag_050.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,difht_ed_050_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Diffusive Heating, K/day, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','difhtfrontdiag_050.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cndht_ed_050_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Largescale Heating, K/day, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cndhtfrontdiag_050.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cnvht_ed_050_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Convective Heating, K/day, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cnvhtfrontdiag_050.png')



figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udT_ed_dx_050',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('udT''dx, K/day, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','udtpdx_050.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,v_ed_dTdy_050',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('v''dTdy, K/day, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vpdtdy_050.png')



figure
v=-15:1:15;
[C,h] = contourf(xi,yi,w_ed_dTdp_050(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('w''dTdp, K/day, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wpdtdp_050.png')





%075


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Total Diabatic Heating, K/day, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrtfrontdiag_075.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,radht_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Radiative Heating, K/day, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','radhtfrontdiag_075.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,difht_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Diffusive Heating, K/day, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','difhtfrontdiag_075.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cndht_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Largescale Heating, K/day, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cndhtfrontdiag_075.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cnvht_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Convective Heating, K/day, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cnvhtfrontdiag_075.png')



figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udT_ed_dx_075',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('udT''dx, K/day, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','udtpdx_075.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,v_ed_dTdy_075',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('v''dTdy, K/day, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vpdtdy_075.png')



figure
v=-15:1:15;
[C,h] = contourf(xi,yi,w_ed_dTdp_075(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('w''dTdp, K/day, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wpdtdp_075.png')





%100


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Total Diabatic Heating, K/day, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrtfrontdiag_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,radht_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Radiative Heating, K/day, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','radhtfrontdiag_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,difht_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Diffusive Heating, K/day, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','difhtfrontdiag_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cndht_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Largescale Heating, K/day, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cndhtfrontdiag_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cnvht_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Convective Heating, K/day, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cnvhtfrontdiag_100.png')



figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udT_ed_dx_100',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('udT''dx, K/day, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','udtpdx_100.png')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,v_ed_dTdy_100',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('v''dTdy, K/day, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vpdtdy_100.png')



figure
v=-15:1:15;
[C,h] = contourf(xi,yi,w_ed_dTdp_100(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('w''dTdp, K/day, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wpdtdp_100.png')



