%load climatology vars file and plot

load('/project/rg312/mat_files/climatology_vars_th.mat')

yi = -89:2:89;
rC = 980:-40:20;

uv_ed_th = uv_th_zav - uE_th_zav.*vN_th_zav;
vNt_ed_th = vNt_th_zav - vN_th_zav.*t_th_zav;


figure

v=190:10:310;
[C,h] = contour(yi,rC,t_th_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Temperature, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','t_th.png')


v=275:25:700;
[C,h] = contour(yi,rC,theta_th_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Potential Temperature, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_th.png')


v = -15:5:40;
[C,h] = contour(yi,rC,uE_th_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Zonal Windspeed, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','uE_th.png')



v=-6:0.5:6;
[C,h] = contour(yi,rC,vN_th_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Meridional Windspeed, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vN_th.png')




v=-0.06:0.02:0.06;
[C,h] = contour(yi,rC,w_th_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Pressure Windspeed, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','w_th.png')


v = 0:0.001:0.02
[C,h] = contour(yi,rC,q_th_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Specific Humidity, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','q_th.png')


v = -1:0.5:6;

[C,h] = contour(yi,rC,htrt_th_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Total Diabatic Heating, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','htrt_th.png')



v=-4:0.5:1;
[C,h] = contour(yi,rC,radht_th_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Radiative Heating, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','radht_th.png')



v = 0:0.25:2.5;
[C,h] = contour(yi,rC,cndht_th_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Large-scale Latent Heating, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','cndht_th.png')



v = 0:0.5:6;
[C,h] = contour(yi,rC,cnvht_th_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Convective Latent Heating, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','cnvht_th.png')



v=-3:0.5:3;
[C,h] = contour(yi,rC,difht_th_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Diffusive Heating, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','difht_th.png')


v=-60:10:60;
[C,h] = contour(yi,rC,uv_ed_th',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('u''v'', 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','uv_ed_th.png')


v=-20:5:20;
[C,h] = contour(yi,rC,vNt_ed_th',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('v''T'', 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vNt_ed_th.png')

