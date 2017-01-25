%load climatology vars file and plot

load('/project/rg312/mat_files/climatology_vars_best.mat')

yi = -89:2:89;
rC = 980:-40:20;

uv_ed_000 = uv_000_zav - uE_000_zav.*vN_000_zav;
vNt_ed_000 = vNt_000_zav - vN_000_zav.*t_000_zav;
uv_ed_010 = uv_010_zav - uE_010_zav.*vN_010_zav;
vNt_ed_010 = vNt_010_zav - vN_010_zav.*t_010_zav;
uv_ed_025 = uv_025_zav - uE_025_zav.*vN_025_zav;
vNt_ed_025 = vNt_025_zav - vN_025_zav.*t_025_zav;
uv_ed_050 = uv_050_zav - uE_050_zav.*vN_050_zav;
vNt_ed_050 = vNt_050_zav - vN_050_zav.*t_050_zav;
uv_ed_075 = uv_075_zav - uE_075_zav.*vN_075_zav;
vNt_ed_075 = vNt_075_zav - vN_075_zav.*t_075_zav;
uv_ed_100 = uv_100_zav - uE_100_zav.*vN_100_zav;
vNt_ed_100 = vNt_100_zav - vN_100_zav.*t_100_zav;
uv_ed_125 = uv_125_zav - uE_125_zav.*vN_125_zav;
vNt_ed_125 = vNt_125_zav - vN_125_zav.*t_125_zav;
uv_ed_150 = uv_150_zav - uE_150_zav.*vN_150_zav;
vNt_ed_150 = vNt_150_zav - vN_150_zav.*t_150_zav;

figure

v=190:10:310;
[C,h] = contour(yi,rC,t_000_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Temperature, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','t_000.png')

[C,h] = contour(yi,rC,t_010_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Temperature, 0.1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','t_010.png')

[C,h] = contour(yi,rC,t_025_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Temperature, 0.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','t_025.png')

[C,h] = contour(yi,rC,t_050_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Temperature, 0.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','t_050.png')

[C,h] = contour(yi,rC,t_075_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Temperature, 0.75es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','t_075.png')

[C,h] = contour(yi,rC,t_100_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Temperature, 1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','t_100.png')

[C,h] = contour(yi,rC,t_125_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Temperature, 1.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','t_125.png')

[C,h] = contour(yi,rC,t_150_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Temperature, 1.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','t_150.png')


v=275:25:700;
[C,h] = contour(yi,rC,theta_000_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Potential Temperature, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_000.png')

[C,h] = contour(yi,rC,theta_010_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Potential Temperature, 0.1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_010.png')

[C,h] = contour(yi,rC,theta_025_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Potential Temperature, 0.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_025.png')

[C,h] = contour(yi,rC,theta_050_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Potential Temperature, 0.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_050.png')

[C,h] = contour(yi,rC,theta_075_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Potential Temperature, 0.75es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_075.png')

[C,h] = contour(yi,rC,theta_100_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Potential Temperature, 1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_100.png')

[C,h] = contour(yi,rC,theta_125_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Potential Temperature, 1.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_125.png')

[C,h] = contour(yi,rC,theta_150_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Potential Temperature, 1.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_150.png')


v = -15:5:40;
[C,h] = contour(yi,rC,uE_000_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Zonal Windspeed, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','uE_000.png')

[C,h] = contour(yi,rC,uE_010_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Zonal Windspeed, 0.1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','uE_010.png')

[C,h] = contour(yi,rC,uE_025_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Zonal Windspeed, 0.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','uE_025.png')

[C,h] = contour(yi,rC,uE_050_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Zonal Windspeed, 0.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','uE_050.png')

[C,h] = contour(yi,rC,uE_075_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Zonal Windspeed, 0.75es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','uE_075.png')

[C,h] = contour(yi,rC,uE_100_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Zonal Windspeed, 1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','uE_100.png')

[C,h] = contour(yi,rC,uE_125_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Zonal Windspeed, 1.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','uE_125.png')

[C,h] = contour(yi,rC,uE_150_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Zonal Windspeed, 1.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','uE_150.png')


v=-6:0.5:6;
[C,h] = contour(yi,rC,vN_000_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Meridional Windspeed, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vN_000.png')

[C,h] = contour(yi,rC,vN_010_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Meridional Windspeed, 0.1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vN_010.png')

[C,h] = contour(yi,rC,vN_025_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Meridional Windspeed, 0.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vN_025.png')

[C,h] = contour(yi,rC,vN_050_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Meridional Windspeed, 0.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vN_050.png')

[C,h] = contour(yi,rC,vN_075_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Meridional Windspeed, 0.75es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vN_075.png')

[C,h] = contour(yi,rC,vN_100_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Meridional Windspeed, 1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vN_100.png')

[C,h] = contour(yi,rC,vN_125_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Meridional Windspeed, 1.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vN_125.png')

[C,h] = contour(yi,rC,vN_150_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Meridional Windspeed, 1.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vN_150.png')


v=-0.06:0.02:0.06;
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

[C,h] = contour(yi,rC,w_125_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Pressure Windspeed, 1.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','w_125.png')

[C,h] = contour(yi,rC,w_150_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Pressure Windspeed, 1.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','w_150.png')

v = 0:0.001:0.02
[C,h] = contour(yi,rC,q_000_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Specific Humidity, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','q_000.png')

[C,h] = contour(yi,rC,q_010_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Specific Humidity, 0.1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','q_010.png')

[C,h] = contour(yi,rC,q_025_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Specific Humidity, 0.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','q_025.png')

[C,h] = contour(yi,rC,q_050_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Specific Humidity, 0.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','q_050.png')

[C,h] = contour(yi,rC,q_075_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Specific Humidity, 0.75es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','q_075.png')

[C,h] = contour(yi,rC,q_100_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Specific Humidity, 1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','q_100.png')

[C,h] = contour(yi,rC,q_125_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Specific Humidity, 1.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','q_125.png')

[C,h] = contour(yi,rC,q_150_zav',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Specific Humidity, 1.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','q_150.png')


v = -1:0.5:6;

[C,h] = contour(yi,rC,htrt_000_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Total Diabatic Heating, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','htrt_000.png')

[C,h] = contour(yi,rC,htrt_010_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Total Diabatic Heating, 0.1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','htrt_010.png')

[C,h] = contour(yi,rC,htrt_025_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Total Diabatic Heating, 0.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','htrt_025.png')

[C,h] = contour(yi,rC,htrt_050_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Total Diabatic Heating, 0.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','htrt_050.png')

[C,h] = contour(yi,rC,htrt_075_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Total Diabatic Heating, 0.75es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','htrt_075.png')

[C,h] = contour(yi,rC,htrt_100_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Total Diabatic Heating, 1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','htrt_100.png')

[C,h] = contour(yi,rC,htrt_125_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Total Diabatic Heating, 1.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','htrt_125.png')

[C,h] = contour(yi,rC,htrt_150_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Total Diabatic Heating, 1.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','htrt_150.png')



v=-4:0.5:1;
[C,h] = contour(yi,rC,radht_000_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Radiative Heating, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','radht_000.png')

[C,h] = contour(yi,rC,radht_010_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Radiative Heating, 0.1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','radht_010.png')

[C,h] = contour(yi,rC,radht_025_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Radiative Heating, 0.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','radht_025.png')

[C,h] = contour(yi,rC,radht_050_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Radiative Heating, 0.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','radht_050.png')

[C,h] = contour(yi,rC,radht_075_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Radiative Heating, 0.75es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','radht_075.png')

[C,h] = contour(yi,rC,radht_100_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Radiative Heating, 1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','radht_100.png')

[C,h] = contour(yi,rC,radht_125_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Radiative Heating, 1.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','radht_025.png')

[C,h] = contour(yi,rC,radht_150_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Radiative Heating, 1.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','radht_150.png')


v = 0:0.25:2.5;
[C,h] = contour(yi,rC,cndht_000_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Large-scale Latent Heating, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','cndht_000.png')

[C,h] = contour(yi,rC,cndht_010_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Large-scale Latent Heating, 0.1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','cndht_010.png')

[C,h] = contour(yi,rC,cndht_025_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Large-scale Latent Heating, 0.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','cndht_025.png')

[C,h] = contour(yi,rC,cndht_050_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Large-scale Latent Heating, 0.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','cndht_050.png')

[C,h] = contour(yi,rC,cndht_075_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Large-scale Latent Heating, 0.75es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','cndht_075.png')

[C,h] = contour(yi,rC,cndht_100_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Large-scale Latent Heating, 1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','cndht_100.png')

[C,h] = contour(yi,rC,cndht_125_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Large-scale Latent Heating, 1.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','cndht_125.png')

[C,h] = contour(yi,rC,cndht_150_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Large-scale Latent Heating, 1.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','cndht_150.png')



v = 0:0.5:6;
[C,h] = contour(yi,rC,cnvht_000_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Convective Latent Heating, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','cnvht_000.png')

[C,h] = contour(yi,rC,cnvht_010_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Convective Latent Heating, 0.1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','cnvht_010.png')

[C,h] = contour(yi,rC,cnvht_025_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Convective Latent Heating, 0.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','cnvht_025.png')

[C,h] = contour(yi,rC,cnvht_050_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Convective Latent Heating, 0.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','cnvht_050.png')

[C,h] = contour(yi,rC,cnvht_075_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Convective Latent Heating, 0.75es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','cnvht_075.png')

[C,h] = contour(yi,rC,cnvht_100_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Convective Latent Heating, 1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','cnvht_100.png')

[C,h] = contour(yi,rC,cnvht_125_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Convective Latent Heating, 1.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','cnvht_125.png')

[C,h] = contour(yi,rC,cnvht_150_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Convective Latent Heating, 1.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','cnvht_150.png')



v=-3:0.5:3;
[C,h] = contour(yi,rC,difht_000_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Diffusive Heating, 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','difht_000.png')

[C,h] = contour(yi,rC,difht_010_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Diffusive Heating, 0.1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','difht_010.png')

[C,h] = contour(yi,rC,difht_025_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Diffusive Heating, 0.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','difht_025.png')

[C,h] = contour(yi,rC,difht_050_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Diffusive Heating, 0.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','difht_050.png')

[C,h] = contour(yi,rC,difht_075_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Diffusive Heating, 0.75es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','difht_075.png')

[C,h] = contour(yi,rC,difht_100_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Diffusive Heating, 1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','difht_100.png')

[C,h] = contour(yi,rC,difht_125_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Diffusive Heating, 1.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','difht_125.png')

[C,h] = contour(yi,rC,difht_150_zav'.*86400,v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('Diffusive Heating, 1.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','difht_150.png')


v=-60:10:60;
[C,h] = contour(yi,rC,uv_ed_000',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('u''v'', 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','uv_ed_000.png')

[C,h] = contour(yi,rC,uv_ed_010',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('u''v'', 0.1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','uv_ed_010.png')

[C,h] = contour(yi,rC,uv_ed_025',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('u''v'', 0.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','uv_ed_025.png')

[C,h] = contour(yi,rC,uv_ed_050',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('u''v'', 0.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','uv_ed_050.png')

[C,h] = contour(yi,rC,uv_ed_075',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('u''v'', 0.75es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','uv_ed_075.png')

[C,h] = contour(yi,rC,uv_ed_100',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('u''v'', 1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','uv_ed_100.png')

[C,h] = contour(yi,rC,uv_ed_125',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('u''v'', 1.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','uv_ed_125.png')

[C,h] = contour(yi,rC,uv_ed_150',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('u''v'', 1.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','uv_ed_150.png')


v=-20:5:20;
[C,h] = contour(yi,rC,vNt_ed_000',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('v''T'', 0es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vNt_ed_000.png')

[C,h] = contour(yi,rC,vNt_ed_010',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('v''T'', 0.1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vNt_ed_010.png')

[C,h] = contour(yi,rC,vNt_ed_025',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('v''T'', 0.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vNt_ed_025.png')

[C,h] = contour(yi,rC,vNt_ed_050',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('v''T'', 0.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vNt_ed_050.png')

[C,h] = contour(yi,rC,vNt_ed_075',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('v''T'', 0.75es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vNt_ed_075.png')

[C,h] = contour(yi,rC,vNt_ed_100',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('v''T'', 1es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vNt_ed_100.png')

[C,h] = contour(yi,rC,vNt_ed_125',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('v''T'', 1.25es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vNt_ed_125.png')

[C,h] = contour(yi,rC,vNt_ed_150',v,'k');
set(gca,'yDir','reverse')
clabel(C,h);
title('v''T'', 1.5es0');
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vNt_ed_150.png')

