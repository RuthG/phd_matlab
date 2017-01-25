%load climatology vars file and plot

load('/project/rg312/mat_files/climatology_vars.mat')

yi = -89:2:89;
rC = 980:-40:20;

v=-0.05:0.005:0.05;
[C,h] = contour(yi,rC,w_000_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Pressure Windspeed, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','w_000.png')

[C,h] = contour(yi,rC,w_010_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Pressure Windspeed, 0.1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','w_010.png')

[C,h] = contour(yi,rC,w_025_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Pressure Windspeed, 0.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','w_025.png')

[C,h] = contour(yi,rC,w_050_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Pressure Windspeed, 0.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','w_050.png')

[C,h] = contour(yi,rC,w_075_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Pressure Windspeed, 0.75es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','w_075.png')

[C,h] = contour(yi,rC,w_100_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Pressure Windspeed, 1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','w_100.png')


