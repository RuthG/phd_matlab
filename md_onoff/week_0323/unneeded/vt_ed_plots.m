%load in and plot up vt ed data for negative and positive t'

load('/project/rg312/mat_files/vt_lat_means.mat')

pressure = 980:-40:20;
lat = -89:2:89;

%000
figure
v=-20:5:20;
[C,h] = contourf(lat,pressure,vNt_ll_tzav_000,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.0es0')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_000.png')

figure
[C,h] = contourf(lat,pressure,vNt_ll_tzav_tpos_000,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.0es0 (+T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_tpos_000.png')

figure
[C,h] = contourf(lat,pressure,vNt_ll_tzav_tneg_000,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.0es0 (-T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_tneg_000.png')


%010
figure
[C,h] = contourf(lat,pressure,vNt_ll_tzav_010,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.1es0')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_010.png')

figure
[C,h] = contourf(lat,pressure,vNt_ll_tzav_tpos_010,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.1es0 (+T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_tpos_010.png')

figure
[C,h] = contourf(lat,pressure,vNt_ll_tzav_tneg_010,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.1es0 (-T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_tneg_010.png')




%025
figure
[C,h] = contourf(lat,pressure,vNt_ll_tzav_025,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.25es0')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_025.png')

figure
[C,h] = contourf(lat,pressure,vNt_ll_tzav_tpos_025,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.25es0 (+T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_tpos_025.png')

figure
[C,h] = contourf(lat,pressure,vNt_ll_tzav_tneg_025,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.25es0 (-T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_tneg_025.png')





%050
figure
[C,h] = contourf(lat,pressure,vNt_ll_tzav_050,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.5es0')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_050.png')

figure
[C,h] = contourf(lat,pressure,vNt_ll_tzav_tpos_050,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.5es0 (+T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_tpos_050.png')

figure
[C,h] = contourf(lat,pressure,vNt_ll_tzav_tneg_050,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.5es0 (-T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_tneg_050.png')





%075
figure
[C,h] = contourf(lat,pressure,vNt_ll_tzav_075,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.75es0')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_075.png')

figure
[C,h] = contourf(lat,pressure,vNt_ll_tzav_tpos_075,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.75es0 (+T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_tpos_075.png')

figure
[C,h] = contourf(lat,pressure,vNt_ll_tzav_tneg_075,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.75es0 (-T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_tneg_075.png')





%100
figure
[C,h] = contourf(lat,pressure,vNt_ll_tzav_100,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 1.0es0')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_100.png')

figure
[C,h] = contourf(lat,pressure,vNt_ll_tzav_tpos_100,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 1.0es0 (+T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_tpos_100.png')

figure
[C,h] = contourf(lat,pressure,vNt_ll_tzav_tneg_100,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 1.0es0 (-T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_tneg_100.png')





%125
figure
[C,h] = contourf(lat,pressure,vNt_ll_tzav_125,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 1.25es0')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_125.png')

figure
[C,h] = contourf(lat,pressure,vNt_ll_tzav_tpos_125,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 1.25es0 (+T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_tpos_125.png')

figure
[C,h] = contourf(lat,pressure,vNt_ll_tzav_tneg_125,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 1.25es0 (-T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_tneg_125.png')





%150
figure
[C,h] = contourf(lat,pressure,vNt_ll_tzav_150,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 1.5es0')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_150.png')

figure
[C,h] = contourf(lat,pressure,vNt_ll_tzav_tpos_150,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 1.5es0 (+T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_tpos_150.png')

figure
[C,h] = contourf(lat,pressure,vNt_ll_tzav_tneg_150);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 1.5es0 (-T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vt_ed_tneg_150.png')




