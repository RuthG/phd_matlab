%plot snapshots of u, v, w 

load('/project/rg312/mat_files/climatology_vars_th.mat');

yi = -89:2:89;
xi = -179:2:179;


figure
v=-1.2:0.2:1.2;
[C,h] = contourf(xi,yi,w_snap_th_ll(:,:,11)',v);
colorbar; caxis([-1.2 1.2]);
xlabel('Longitude'); title('Pressure Velocity, 0.5es0, tropical heating');
ylabel('Latitude');
print('-dpng','w_snap_th.png');

v=-20:10:70;
[C,h] = contourf(xi,yi,uE_snap_th_ll(:,:,20)',v);
colorbar; caxis([-20 70]);
xlabel('Longitude'); title('Zonal Velocity, 0.5es0, tropical heating');
ylabel('Latitude');
print('-dpng','uE_snap_th.png');

v=-40:10:40;
[C,h] = contourf(xi,yi,vN_snap_th_ll(:,:,20)',v);
colorbar; caxis([-40 40]);
xlabel('Longitude'); title('Meridional Velocity, 0.5es0, tropical heating');
ylabel('Latitude');
print('-dpng','vN_snap_th.png');


