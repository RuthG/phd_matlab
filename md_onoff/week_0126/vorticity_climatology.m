%save zonal mean vorticity plots as first check

load('/project/rg312/mat_files/vorticity_data.mat')


vort_000_tav = mean(vort_000,4);
vort_010_tav = mean(vort_010,4);
vort_025_tav = mean(vort_025,4);
vort_050_tav = mean(vort_050,4);
vort_075_tav = mean(vort_075,4);
vort_100_tav = mean(vort_100,4);
vort_th_tav = mean(vort_th,4);

yi=-89:2:89;
xi = -179:2:179;
vort_000_zav = squeeze(mean(cube2latlon(xg,yg,vort_000_tav,xi,yi),1));
vort_010_zav = squeeze(mean(cube2latlon(xg,yg,vort_010_tav,xi,yi),1));
vort_025_zav = squeeze(mean(cube2latlon(xg,yg,vort_025_tav,xi,yi),1));
vort_050_zav = squeeze(mean(cube2latlon(xg,yg,vort_050_tav,xi,yi),1));
vort_075_zav = squeeze(mean(cube2latlon(xg,yg,vort_075_tav,xi,yi),1));
vort_100_zav = squeeze(mean(cube2latlon(xg,yg,vort_100_tav,xi,yi),1));
vort_th_zav = squeeze(mean(cube2latlon(xg,yg,vort_th_tav,xi,yi),1));


%also evaluate beta - uyy = beta + dvortdy

omega = 2.*pi./24./60./60;
yi = -89:2:90;
radius=6371.0e3;

beta = repmat(2.*omega./radius.*cos(yi.*pi./180),25,1)';

[a,vort_000_y] = gradient(vort_000_zav./radius,pi./90);
[a,vort_010_y] = gradient(vort_010_zav./radius,pi./90);
[a,vort_025_y] = gradient(vort_025_zav./radius,pi./90);
[a,vort_050_y] = gradient(vort_050_zav./radius,pi./90);
[a,vort_075_y] = gradient(vort_075_zav./radius,pi./90);
[a,vort_100_y] = gradient(vort_100_zav./radius,pi./90);
[a,vort_th_y] = gradient(vort_th_zav./radius,pi./90);



v = -5e-5:5e-6:5e-5;
[C,h] = contour(yi,rC,vort_000_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Relative Vorticity, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vort_000.png')

[C,h] = contour(yi,rC,vort_010_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Relative Vorticity, 0.1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vort_010.png')

[C,h] = contour(yi,rC,vort_025_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Relative Vorticity, 0.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vort_025.png')

[C,h] = contour(yi,rC,vort_050_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Relative Vorticity, 0.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vort_050.png')

[C,h] = contour(yi,rC,vort_075_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Relative Vorticity, 0.75es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vort_075.png')

[C,h] = contour(yi,rC,vort_100_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Relative Vorticity, 1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vort_100.png')

[C,h] = contour(yi,rC,vort_th_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Relative Vorticity, 0.5es0 + tropheat');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vort_th.png')




v = -5e-11:1e-11:5e-11;
[C,h] = contour(yi,rC,beta' + vort_000_y',v,'k');
clabel(C,h);
hold on
v = -100:100:100;
[C,h] = contour(yi,rC,beta' + vort_000_y',v,'k','LineWidth',2);
hold off
set(gca,'yDir','reverse')
title('Rayleigh-Kuo, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','rkuo_000.png')

v = -5e-11:1e-11:5e-11;
[C,h] = contour(yi,rC,beta' + vort_010_y',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
hold on
v = -100:100:100;
[C,h] = contour(yi,rC,beta' + vort_010_y',v,'k','LineWidth',2);
hold off
title('Rayleigh-Kuo, 0.1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','rkuo_010.png')

v = -5e-11:1e-11:5e-11;
[C,h] = contour(yi,rC,beta' + vort_025_y',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
hold on
v = -100:100:100;
[C,h] = contour(yi,rC,beta' + vort_025_y',v,'k','LineWidth',2);
hold off
title('Rayleigh-Kuo, 0.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','rkuo_025.png')

v = -5e-11:1e-11:5e-11;
[C,h] = contour(yi,rC,beta' + vort_050_y',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
hold on
v = -100:100:100;
[C,h] = contour(yi,rC,beta' + vort_050_y',v,'k','LineWidth',2);
hold off
title('Rayleigh-Kuo, 0.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','rkuo_050.png')

v = -5e-11:1e-11:5e-11;
[C,h] = contour(yi,rC,beta' + vort_075_y',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
hold on
v = -100:100:100;
[C,h] = contour(yi,rC,beta' + vort_075_y',v,'k','LineWidth',2);
hold off
title('Rayleigh-Kuo, 0.75es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','rkuo_075.png')

v = -5e-11:1e-11:5e-11;
[C,h] = contour(yi,rC,beta' + vort_100_y',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
hold on
v = -100:100:100;
[C,h] = contour(yi,rC,beta' + vort_100_y',v,'k','LineWidth',2);
hold off
title('Rayleigh-Kuo, 1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','rkuo_100.png')

v = -5e-11:1e-11:5e-11;
[C,h] = contour(yi,rC,beta' + vort_th_y',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
hold on
v = -100:100:100;
[C,h] = contour(yi,rC,beta' + vort_th_y',v,'k','LineWidth',2);
hold off
title('Rayleigh-Kuo, 0.5es0 + tropheat');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','rkuo_th.png')


