%load in and plot up vq ed data for negative and positive t'

%load('/project/rg312/mat_files/vq_lats_best.mat')
load('/project/rg312/mat_files/vq_lat_means.mat')

pressure = 980:-40:20;
lat = -89:2:89;


vNq_ll_pzav_max(1) = (max(mean(vNq_ll_tzav_000,1)) - min(mean(vNq_ll_tzav_000,1)))./2;
vNq_ll_pzav_max(2) = (max(mean(vNq_ll_tzav_010,1)) - min(mean(vNq_ll_tzav_010,1)))./2;
vNq_ll_pzav_max(3) = (max(mean(vNq_ll_tzav_025,1)) - min(mean(vNq_ll_tzav_025,1)))./2;
vNq_ll_pzav_max(4) = (max(mean(vNq_ll_tzav_050,1)) - min(mean(vNq_ll_tzav_050,1)))./2;
vNq_ll_pzav_max(5) = (max(mean(vNq_ll_tzav_075,1)) - min(mean(vNq_ll_tzav_075,1)))./2;
vNq_ll_pzav_max(6) = (max(mean(vNq_ll_tzav_100,1)) - min(mean(vNq_ll_tzav_100,1)))./2;
vNq_ll_pzav_max(7) = (max(mean(vNq_ll_tzav_125,1)) - min(mean(vNq_ll_tzav_125,1)))./2;
vNq_ll_pzav_max(8) = (max(mean(vNq_ll_tzav_150,1)) - min(mean(vNq_ll_tzav_150,1)))./2;

vNq_ll_pzav_tpos_max(1) = (max(mean(vNq_ll_tzav_tpos_000,1)) - min(mean(vNq_ll_tzav_tpos_000,1)))./2;
vNq_ll_pzav_tpos_max(2) = (max(mean(vNq_ll_tzav_tpos_010,1)) - min(mean(vNq_ll_tzav_tpos_010,1)))./2;
vNq_ll_pzav_tpos_max(3) = (max(mean(vNq_ll_tzav_tpos_025,1)) - min(mean(vNq_ll_tzav_tpos_025,1)))./2;
vNq_ll_pzav_tpos_max(4) = (max(mean(vNq_ll_tzav_tpos_050,1)) - min(mean(vNq_ll_tzav_tpos_050,1)))./2;
vNq_ll_pzav_tpos_max(5) = (max(mean(vNq_ll_tzav_tpos_075,1)) - min(mean(vNq_ll_tzav_tpos_075,1)))./2;
vNq_ll_pzav_tpos_max(6) = (max(mean(vNq_ll_tzav_tpos_100,1)) - min(mean(vNq_ll_tzav_tpos_100,1)))./2;
vNq_ll_pzav_tpos_max(7) = (max(mean(vNq_ll_tzav_tpos_125,1)) - min(mean(vNq_ll_tzav_tpos_125,1)))./2;
vNq_ll_pzav_tpos_max(8) = (max(mean(vNq_ll_tzav_tpos_150,1)) - min(mean(vNq_ll_tzav_tpos_150,1)))./2;

vNq_ll_pzav_tneg_max(1) = (max(mean(vNq_ll_tzav_tneg_000,1)) - min(mean(vNq_ll_tzav_tneg_000,1)))./2;
vNq_ll_pzav_tneg_max(2) = (max(mean(vNq_ll_tzav_tneg_010,1)) - min(mean(vNq_ll_tzav_tneg_010,1)))./2;
vNq_ll_pzav_tneg_max(3) = (max(mean(vNq_ll_tzav_tneg_025,1)) - min(mean(vNq_ll_tzav_tneg_025,1)))./2;
vNq_ll_pzav_tneg_max(4) = (max(mean(vNq_ll_tzav_tneg_050,1)) - min(mean(vNq_ll_tzav_tneg_050,1)))./2;
vNq_ll_pzav_tneg_max(5) = (max(mean(vNq_ll_tzav_tneg_075,1)) - min(mean(vNq_ll_tzav_tneg_075,1)))./2;
vNq_ll_pzav_tneg_max(6) = (max(mean(vNq_ll_tzav_tneg_100,1)) - min(mean(vNq_ll_tzav_tneg_100,1)))./2;
vNq_ll_pzav_tneg_max(7) = (max(mean(vNq_ll_tzav_tneg_125,1)) - min(mean(vNq_ll_tzav_tneg_125,1)))./2;
vNq_ll_pzav_tneg_max(8) = (max(mean(vNq_ll_tzav_tneg_150,1)) - min(mean(vNq_ll_tzav_tneg_150,1)))./2;

es0 = [0,0.1,0.25,0.5,0.75,1.0,1.25,1.5];

figure
plot(es0, vNq_ll_pzav_max-vNq_ll_pzav_max(1),'b') 
hold on
plot(es0, vNq_ll_pzav_tpos_max-vNq_ll_pzav_tpos_max(1),'g')  
plot(es0, vNq_ll_pzav_tneg_max-vNq_ll_pzav_tneg_max(1),'r')
ylabel('v''T'', Km/s, zonal, time, pressure average, dry values subtracted')
xlabel('Reference saturation vapour pressure fraction')
print('-dpng','vq_ed_change.png')

figure
plot(es0, vNq_ll_pzav_max,'b') 
hold on
plot(es0, vNq_ll_pzav_tpos_max,'g')  
plot(es0, vNq_ll_pzav_tneg_max,'r')
ylabel('v''T'', Km/s, zonal, time, pressure average')
xlabel('Reference saturation vapour pressure fraction')
print('-dpng','vq_ed_totandpn.png')

figure
plot(es0, vNq_ll_pzav_tpos_max./vNq_ll_pzav_max,'g')  
hold on
plot(es0, vNq_ll_pzav_tneg_max./vNq_ll_pzav_max,'r')
ylabel('v''T'', +T and -T contributions normalised by total')
xlabel('Reference saturation vapour pressure fraction')
print('-dpng','vq_ed_pnovertot.png')

figure
plot(es0, vNq_ll_pzav_tneg_max./vNq_ll_pzav_tpos_max)
ylabel('v''T'' (-T)/v''T'' (+T)')
xlabel('Reference saturation vapour pressure fraction')
print('-dpng','vq_ed_noverp.png')

return
%000
figure
v=-20:2.5:20;
[C,h] = contourf(lat,pressure,vNq_ll_tzav_000,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.0es0')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_000.png')

figure
[C,h] = contourf(lat,pressure,vNq_ll_tzav_tpos_000,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.0es0 (+T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_tpos_000.png')

figure
[C,h] = contourf(lat,pressure,vNq_ll_tzav_tneg_000,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.0es0 (-T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_tneg_000.png')


%010
figure
[C,h] = contourf(lat,pressure,vNq_ll_tzav_010,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.1es0')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_010.png')

figure
[C,h] = contourf(lat,pressure,vNq_ll_tzav_tpos_010,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.1es0 (+T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_tpos_010.png')

figure
[C,h] = contourf(lat,pressure,vNq_ll_tzav_tneg_010,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.1es0 (-T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_tneg_010.png')




%025
figure
[C,h] = contourf(lat,pressure,vNq_ll_tzav_025,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.25es0')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_025.png')

figure
[C,h] = contourf(lat,pressure,vNq_ll_tzav_tpos_025,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.25es0 (+T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_tpos_025.png')

figure
[C,h] = contourf(lat,pressure,vNq_ll_tzav_tneg_025,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.25es0 (-T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_tneg_025.png')





%050
figure
[C,h] = contourf(lat,pressure,vNq_ll_tzav_050,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.5es0')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_050.png')

figure
[C,h] = contourf(lat,pressure,vNq_ll_tzav_tpos_050,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.5es0 (+T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_tpos_050.png')

figure
[C,h] = contourf(lat,pressure,vNq_ll_tzav_tneg_050,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.5es0 (-T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_tneg_050.png')





%075
figure
[C,h] = contourf(lat,pressure,vNq_ll_tzav_075,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.75es0')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_075.png')

figure
[C,h] = contourf(lat,pressure,vNq_ll_tzav_tpos_075,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.75es0 (+T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_tpos_075.png')

figure
[C,h] = contourf(lat,pressure,vNq_ll_tzav_tneg_075,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 0.75es0 (-T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_tneg_075.png')





%100
figure
[C,h] = contourf(lat,pressure,vNq_ll_tzav_100,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 1.0es0')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_100.png')

figure
[C,h] = contourf(lat,pressure,vNq_ll_tzav_tpos_100,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 1.0es0 (+T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_tpos_100.png')

figure
[C,h] = contourf(lat,pressure,vNq_ll_tzav_tneg_100,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 1.0es0 (-T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_tneg_100.png')





%125
figure
[C,h] = contourf(lat,pressure,vNq_ll_tzav_125,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 1.25es0')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_125.png')

figure
[C,h] = contourf(lat,pressure,vNq_ll_tzav_tpos_125,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 1.25es0 (+T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_tpos_125.png')

figure
[C,h] = contourf(lat,pressure,vNq_ll_tzav_tneg_125,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 1.25es0 (-T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_tneg_125.png')





%150
figure
[C,h] = contourf(lat,pressure,vNq_ll_tzav_150,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 1.5es0')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_150.png')

figure
[C,h] = contourf(lat,pressure,vNq_ll_tzav_tpos_150,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 1.5es0 (+T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_tpos_150.png')

figure
[C,h] = contourf(lat,pressure,vNq_ll_tzav_tneg_150,v);
set(gca,'YDir','reverse','FontSize',15);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'' (Km/s), 1.5es0 (-T)')
colorbar('FontSize',15)
caxis([-20 20])
print('-dpng','vq_ed_tneg_150.png')




