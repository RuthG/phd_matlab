%load in composite data and plot up

load('/project/rg312/mat_files/vt_compdata_000.mat')
comp_vt_000 = nanmean(comp_data,3);
load('/project/rg312/mat_files/vt_compdata_010.mat')
comp_vt_010 = nanmean(comp_data,3);
load('/project/rg312/mat_files/vt_compdata_025.mat')
comp_vt_025 = nanmean(comp_data,3);
load('/project/rg312/mat_files/vt_compdata_050.mat')
comp_vt_050 = nanmean(comp_data,3);
load('/project/rg312/mat_files/vt_compdata_075.mat')
comp_vt_075 = nanmean(comp_data,3);
load('/project/rg312/mat_files/vt_compdata_100.mat')
comp_vt_100 = nanmean(comp_data,3);

rC = 980:-40:20;
xi = -34:2:34;
v = -70:10:140;
figure
[C,h] = contourf(xi,rC,comp_vt_000',v);
colormap(b2r(-70,140));
hold on
[C,h] = contour(xi,rC,comp_vt_000',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.0es0','FontSize',15)
print('-dpng','vt_comp/vt_000.png')

hold off
[C,h] = contourf(xi,rC,comp_vt_010',v);
colormap(b2r(-70,140));
hold on
[C,h] = contour(xi,rC,comp_vt_010',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.10es0','FontSize',15)
print('-dpng','vt_comp/vt_010.png')

hold off
[C,h] = contourf(xi,rC,comp_vt_025',v);
colormap(b2r(-70,140));
hold on
[C,h] = contour(xi,rC,comp_vt_025',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.25es0','FontSize',15)
print('-dpng','vt_comp/vt_025.png')

hold off
[C,h] = contourf(xi,rC,comp_vt_050',v);
colormap(b2r(-70,140));
hold on
[C,h] = contour(xi,rC,comp_vt_050',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.5es0','FontSize',15)
print('-dpng','vt_comp/vt_050.png')

hold off
[C,h] = contourf(xi,rC,comp_vt_075',v);
colormap(b2r(-70,140));
hold on
[C,h] = contour(xi,rC,comp_vt_075',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 0.75es0','FontSize',15)
print('-dpng','vt_comp/vt_075.png')

hold off
[C,h] = contourf(xi,rC,comp_vt_100',v);
colormap(b2r(-70,140));
hold on
[C,h] = contour(xi,rC,comp_vt_100',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''t'' composite, 1.0es0','FontSize',15)
print('-dpng','vt_comp/vt_100.png')

clear


load('/project/rg312/mat_files/w_compdata_000.mat')
comp_w_000 = nanmean(comp_data,3);
load('/project/rg312/mat_files/w_compdata_010.mat')
comp_w_010 = nanmean(comp_data,3);
load('/project/rg312/mat_files/w_compdata_025.mat')
comp_w_025 = nanmean(comp_data,3);
load('/project/rg312/mat_files/w_compdata_050.mat')
comp_w_050 = nanmean(comp_data,3);
load('/project/rg312/mat_files/w_compdata_075.mat')
comp_w_075 = nanmean(comp_data,3);
load('/project/rg312/mat_files/w_compdata_100.mat')
comp_w_100 = nanmean(comp_data,3);

rC = 980:-40:20;
xi = -34:2:34;
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
print('-dpng','w_comp/w_000.png')

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
print('-dpng','w_comp/w_010.png')

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
print('-dpng','w_comp/w_025.png')

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
print('-dpng','w_comp/w_050.png')

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
print('-dpng','w_comp/w_075.png')

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
print('-dpng','w_comp/w_100.png')






clear


load('/project/rg312/mat_files/q_compdata_000.mat')
comp_q_000 = nanmean(comp_data,3);
load('/project/rg312/mat_files/q_compdata_010.mat')
comp_q_010 = nanmean(comp_data,3);
load('/project/rg312/mat_files/q_compdata_025.mat')
comp_q_025 = nanmean(comp_data,3);
load('/project/rg312/mat_files/q_compdata_050.mat')
comp_q_050 = nanmean(comp_data,3);
load('/project/rg312/mat_files/q_compdata_075.mat')
comp_q_075 = nanmean(comp_data,3);
load('/project/rg312/mat_files/q_compdata_100.mat')
comp_q_100 = nanmean(comp_data,3);

rC = 980:-40:20;
xi = -34:2:34;
v = 0:0.0003:0.006;
colormap('default')
hold off
[C,h] = contourf(xi,rC,comp_q_000',v);
caxis([0 0.006])
hold on
[C,h] = contour(xi,rC,comp_q_000',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.0es0','FontSize',15)
print('-dpng','q_comp/q_000.png')

hold off
[C,h] = contourf(xi,rC,comp_q_010',v);
caxis([0 0.006])
hold on
[C,h] = contour(xi,rC,comp_q_010',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.10es0','FontSize',15)
print('-dpng','q_comp/q_010.png')

hold off
[C,h] = contourf(xi,rC,comp_q_025',v);
caxis([0 0.006])
hold on
[C,h] = contour(xi,rC,comp_q_025',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.25es0','FontSize',15)
print('-dpng','q_comp/q_025.png')

hold off
[C,h] = contourf(xi,rC,comp_q_050',v);
caxis([0 0.006])
hold on
[C,h] = contour(xi,rC,comp_q_050',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.5es0','FontSize',15)
print('-dpng','q_comp/q_050.png')

hold off
[C,h] = contourf(xi,rC,comp_q_075',v);
caxis([0 0.006])
hold on
[C,h] = contour(xi,rC,comp_q_075',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 0.75es0','FontSize',15)
print('-dpng','q_comp/q_075.png')

hold off
[C,h] = contourf(xi,rC,comp_q_100',v);
caxis([0 0.006])
hold on
[C,h] = contour(xi,rC,comp_q_100',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('q composite, 1.0es0','FontSize',15)
print('-dpng','q_comp/q_100.png')







clear


load('/project/rg312/mat_files/theta_compdata_000.mat')
comp_theta_000 = nanmean(comp_data,3);
load('/project/rg312/mat_files/theta_compdata_010.mat')
comp_theta_010 = nanmean(comp_data,3);
load('/project/rg312/mat_files/theta_compdata_025.mat')
comp_theta_025 = nanmean(comp_data,3);
load('/project/rg312/mat_files/theta_compdata_050.mat')
comp_theta_050 = nanmean(comp_data,3);
load('/project/rg312/mat_files/theta_compdata_075.mat')
comp_theta_075 = nanmean(comp_data,3);
load('/project/rg312/mat_files/theta_compdata_100.mat')
comp_theta_100 = nanmean(comp_data,3);

rC = 980:-40:20;
xi = -34:2:34;
v = 250:10:400;
colormap('default')
hold off
[C,h] = contourf(xi,rC,comp_theta_000',v);
caxis([250 400])
hold on
[C,h] = contour(xi,rC,comp_theta_000',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.0es0','FontSize',15)
print('-dpng','theta_comp/theta_000.png')

hold off
[C,h] = contourf(xi,rC,comp_theta_010',v);
caxis([250 400])
hold on
[C,h] = contour(xi,rC,comp_theta_010',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.10es0','FontSize',15)
print('-dpng','theta_comp/theta_010.png')

hold off
[C,h] = contourf(xi,rC,comp_theta_025',v);
caxis([250 400])
hold on
[C,h] = contour(xi,rC,comp_theta_025',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.25es0','FontSize',15)
print('-dpng','theta_comp/theta_025.png')

hold off
[C,h] = contourf(xi,rC,comp_theta_050',v);
caxis([250 400])
hold on
[C,h] = contour(xi,rC,comp_theta_050',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.5es0','FontSize',15)
print('-dpng','theta_comp/theta_050.png')

hold off
[C,h] = contourf(xi,rC,comp_theta_075',v);
caxis([250 400])
hold on
[C,h] = contour(xi,rC,comp_theta_075',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 0.75es0','FontSize',15)
print('-dpng','theta_comp/theta_075.png')

hold off
[C,h] = contourf(xi,rC,comp_theta_100',v);
caxis([250 400])
hold on
[C,h] = contour(xi,rC,comp_theta_100',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('theta composite, 1.0es0','FontSize',15)
print('-dpng','theta_comp/theta_100.png')



convthetatoT=(rC'.*100/101325.0).^(2./7.);
for j=1:25
comp_temp_000(:,j)=comp_theta_000(:,j).*convthetatoT(j,1);
comp_temp_010(:,j)=comp_theta_010(:,j).*convthetatoT(j,1);
comp_temp_025(:,j)=comp_theta_025(:,j).*convthetatoT(j,1);
comp_temp_050(:,j)=comp_theta_050(:,j).*convthetatoT(j,1);
comp_temp_075(:,j)=comp_theta_075(:,j).*convthetatoT(j,1);
comp_temp_100(:,j)=comp_theta_100(:,j).*convthetatoT(j,1);
end


v=180:5:300;
colormap('default')
hold off
[C,h] = contourf(xi,rC,comp_temp_000',v);
caxis([180 300])
hold on
[C,h] = contour(xi,rC,comp_temp_000',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('temp composite, 0.0es0','FontSize',15)
print('-dpng','temp_comp/temp_000.png')

hold off
[C,h] = contourf(xi,rC,comp_temp_010',v);
caxis([180 300])
hold on
[C,h] = contour(xi,rC,comp_temp_010',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('temp composite, 0.10es0','FontSize',15)
print('-dpng','temp_comp/temp_010.png')

hold off
[C,h] = contourf(xi,rC,comp_temp_025',v);
caxis([180 300])
hold on
[C,h] = contour(xi,rC,comp_temp_025',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('temp composite, 0.25es0','FontSize',15)
print('-dpng','temp_comp/temp_025.png')

hold off
[C,h] = contourf(xi,rC,comp_temp_050',v);
caxis([180 300])
hold on
[C,h] = contour(xi,rC,comp_temp_050',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('temp composite, 0.5es0','FontSize',15)
print('-dpng','temp_comp/temp_050.png')

hold off
[C,h] = contourf(xi,rC,comp_temp_075',v);
caxis([180 300])
hold on
[C,h] = contour(xi,rC,comp_temp_075',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('temp composite, 0.75es0','FontSize',15)
print('-dpng','temp_comp/temp_075.png')

hold off
[C,h] = contourf(xi,rC,comp_temp_100',v);
caxis([180 300])
hold on
[C,h] = contour(xi,rC,comp_temp_100',[-1000:1000:1000],'k','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('temp composite, 1.0es0','FontSize',15)
print('-dpng','temp_comp/temp_100.png')
