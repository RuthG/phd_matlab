%plot snapshots of u, v, w 

load('climatology_vars.mat');

yi = -89:2:89;
xi = -179:2:179;


figure
v=-1.2:0.2:1.2;
[C,h] = contourf(xi,yi,w_snap_000_ll(:,:,11)',v);
colorbar; caxis([-1.2 1.2]);
xlabel('Longitude'); title('Pressure Velocity, 0es0');
ylabel('Latitude');
print('-dpng','w_snap_000.png');

v=-20:10:70;
[C,h] = contourf(xi,yi,uE_snap_000_ll(:,:,20)',v);
colorbar; caxis([-20 70]);
xlabel('Longitude'); title('Zonal Velocity, 0es0');
ylabel('Latitude');
print('-dpng','uE_snap_000.png');

v=-40:10:40;
[C,h] = contourf(xi,yi,vN_snap_000_ll(:,:,20)',v);
colorbar; caxis([-40 40]);
xlabel('Longitude'); title('Meridional Velocity, 0es0');
ylabel('Latitude');
print('-dpng','vN_snap_000.png');

v=-1.2:0.2:1.2;
[C,h] = contourf(xi,yi,w_snap_010_ll(:,:,11)',v);
colorbar; caxis([-1.2 1.2]);
xlabel('Longitude'); title('Pressure Velocity, 0.1es0');
ylabel('Latitude');
print('-dpng','w_snap_010.png');

v=-20:10:70;
[C,h] = contourf(xi,yi,uE_snap_010_ll(:,:,20)',v);
colorbar; caxis([-20 70]);
xlabel('Longitude'); title('Zonal Velocity, 0.1es0');
ylabel('Latitude');
print('-dpng','uE_snap_010.png');

v=-40:10:40;
[C,h] = contourf(xi,yi,vN_snap_010_ll(:,:,20)',v);
colorbar; caxis([-40 40]);
xlabel('Longitude'); title('Meridional Velocity, 0.1es0');
ylabel('Latitude');
print('-dpng','vN_snap_010.png');

v=-1.2:0.2:1.2;
[C,h] = contourf(xi,yi,w_snap_025_ll(:,:,11)',v);
colorbar; caxis([-1.2 1.2]);
xlabel('Longitude'); title('Pressure Velocity, 0.25es0');
ylabel('Latitude');
print('-dpng','w_snap_025.png');

v=-20:10:70;
[C,h] = contourf(xi,yi,uE_snap_025_ll(:,:,20)',v);
colorbar; caxis([-20 70]);
xlabel('Longitude'); title('Zonal Velocity, 0.25es0');
ylabel('Latitude');
print('-dpng','uE_snap_025.png');

v=-40:10:40;
[C,h] = contourf(xi,yi,vN_snap_025_ll(:,:,20)',v);
colorbar; caxis([-40 40]);
xlabel('Longitude'); title('Meridional Velocity, 0.25es0');
ylabel('Latitude');
print('-dpng','vN_snap_025.png');

v=-1.2:0.2:1.2;
[C,h] = contourf(xi,yi,w_snap_050_ll(:,:,11)',v);
colorbar; caxis([-1.2 1.2]);
xlabel('Longitude'); title('Pressure Velocity, 0.5es0');
ylabel('Latitude');
print('-dpng','w_snap_050.png');

v=-20:10:70;
[C,h] = contourf(xi,yi,uE_snap_050_ll(:,:,20)',v);
colorbar; caxis([-20 70]);
xlabel('Longitude'); title('Zonal Velocity, 0.5es0');
ylabel('Latitude');
print('-dpng','uE_snap_050.png');

v=-40:10:40;
[C,h] = contourf(xi,yi,vN_snap_050_ll(:,:,20)',v);
colorbar; caxis([-40 40]);
xlabel('Longitude'); title('Meridional Velocity, 0.5es0');
ylabel('Latitude');
print('-dpng','vN_snap_050.png');

v=-1.2:0.2:1.2;
[C,h] = contourf(xi,yi,w_snap_075_ll(:,:,11)',v);
colorbar; caxis([-1.2 1.2]);
xlabel('Longitude'); title('Pressure Velocity, 0.75es0');
ylabel('Latitude');
print('-dpng','w_snap_075.png');

v=-20:10:70;
[C,h] = contourf(xi,yi,uE_snap_075_ll(:,:,20)',v);
colorbar; caxis([-20 70]);
xlabel('Longitude'); title('Zonal Velocity, 0.75es0');
ylabel('Latitude');
print('-dpng','uE_snap_075.png');

v=-40:10:40;
[C,h] = contourf(xi,yi,vN_snap_075_ll(:,:,20)',v);
colorbar; caxis([-40 40]);
xlabel('Longitude'); title('Meridional Velocity, 0.75es0');
ylabel('Latitude');
print('-dpng','vN_snap_075.png');

v=-1.2:0.2:1.2;
[C,h] = contourf(xi,yi,w_snap_100_ll(:,:,11)',v);
colorbar; caxis([-1.2 1.2]);
xlabel('Longitude'); title('Pressure Velocity, 1es0');
ylabel('Latitude');
print('-dpng','w_snap_100.png');

v=-20:10:70;
[C,h] = contourf(xi,yi,uE_snap_100_ll(:,:,20)',v);
colorbar; caxis([-20 70]);
xlabel('Longitude'); title('Zonal Velocity, 1es0');
ylabel('Latitude');
print('-dpng','uE_snap_100.png');

v=-40:10:40;
[C,h] = contourf(xi,yi,vN_snap_100_ll(:,:,20)',v);
colorbar; caxis([-40 40]);
xlabel('Longitude'); title('Meridional Velocity, 1es0');
ylabel('Latitude');
print('-dpng','vN_snap_100.png');
