%step 1 of evaluating cross isentropic wind, take theta snapshots and diabatic heating averages and look at difference. 

%also need to work out how to calculate the gradient of theta over that day in a useful way.... might need to code the model to evaluate this stuff somehow; discuss w Arnaud?

load('/project/rg312/mat_files/snapshot_data/theta_snapshots.mat')
load('/project/rg312/mat_files/heat_rates.mat')

clear('radht_000','radht_010','radht_025','radht_050','radht_075','radht_100',...
'difht_000','difht_010','difht_025','difht_050','difht_075','difht_100',...
'cndht_000','cndht_010','cndht_025','cndht_050','cndht_075','cndht_100',...
'cnvht_000','cnvht_010','cnvht_025','cnvht_050','cnvht_075','cnvht_100')

for i = 1:719
dthetadt_000(:,:,:,i) = theta_000(:,:,:,i+1) - theta_000(:,:,:,i);
dthetadt_010(:,:,:,i) = theta_010(:,:,:,i+1) - theta_010(:,:,:,i);
dthetadt_025(:,:,:,i) = theta_025(:,:,:,i+1) - theta_025(:,:,:,i);
dthetadt_050(:,:,:,i) = theta_050(:,:,:,i+1) - theta_050(:,:,:,i);
dthetadt_075(:,:,:,i) = theta_075(:,:,:,i+1) - theta_075(:,:,:,i);
dthetadt_100(:,:,:,i) = theta_100(:,:,:,i+1) - theta_100(:,:,:,i);
end

htrt_000 = htrt_000.*86400;
htrt_010 = htrt_010.*86400;
htrt_025 = htrt_025.*86400;
htrt_050 = htrt_050.*86400;
htrt_075 = htrt_075.*86400;
htrt_100 = htrt_100.*86400;

xi = -179:2:179;
yi = -89:2:89;
dthetadt_000_ll = cube2latlon(xc,yc,dthetadt_000,xi,yi);
dthetadt_010_ll = cube2latlon(xc,yc,dthetadt_010,xi,yi);
dthetadt_025_ll = cube2latlon(xc,yc,dthetadt_025,xi,yi);
dthetadt_050_ll = cube2latlon(xc,yc,dthetadt_050,xi,yi);
dthetadt_075_ll = cube2latlon(xc,yc,dthetadt_075,xi,yi);
dthetadt_100_ll = cube2latlon(xc,yc,dthetadt_100,xi,yi);

htrt_000_ll = cube2latlon(xc,yc,htrt_000,xi,yi);
htrt_010_ll = cube2latlon(xc,yc,htrt_010,xi,yi);
htrt_025_ll = cube2latlon(xc,yc,htrt_025,xi,yi);
htrt_050_ll = cube2latlon(xc,yc,htrt_050,xi,yi);
htrt_075_ll = cube2latlon(xc,yc,htrt_075,xi,yi);
htrt_100_ll = cube2latlon(xc,yc,htrt_100,xi,yi);

heatdiff_000 = htrt_000_ll(:,:,:,2:720) - dthetadt_000_ll;
heatdiff_010 = htrt_010_ll(:,:,:,2:720) - dthetadt_010_ll;
heatdiff_025 = htrt_025_ll(:,:,:,2:720) - dthetadt_025_ll;
heatdiff_050 = htrt_050_ll(:,:,:,2:720) - dthetadt_050_ll;
heatdiff_075 = htrt_075_ll(:,:,:,2:720) - dthetadt_075_ll;
heatdiff_100 = htrt_100_ll(:,:,:,2:720) - dthetadt_100_ll;


v = -14:2:14;
figure
[C,h] = contourf(xi,yi,heatdiff_000(:,:,4,40)',v);
hold on
[C,h] = contour(xi,yi,heatdiff_000(:,:,4,40)',[-1000:1000:1000],'k','LineWidth',2);
hold off
xlabel('Longitude')
ylabel('Latitude')
colorbar
colormap(b2r(-14,14));
title('Diabatic heating - d\Theta dt, K/day, 0es0')
print('-dpng','heatdiff_000.png')

figure
[C,h] = contourf(xi,yi,heatdiff_010(:,:,4,40)',v);
hold on
[C,h] = contour(xi,yi,heatdiff_010(:,:,4,40)',[-1000:1000:1000],'k','LineWidth',2);
hold off
xlabel('Longitude')
ylabel('Latitude')
colorbar
colormap(b2r(-14,14));
title('Diabatic heating - d\Theta dt, K/day, 0.1es0')
print('-dpng','heatdiff_010.png')

figure
[C,h] = contourf(xi,yi,heatdiff_025(:,:,4,40)',v);
hold on
[C,h] = contour(xi,yi,heatdiff_025(:,:,4,40)',[-1000:1000:1000],'k','LineWidth',2);
hold off
xlabel('Longitude')
ylabel('Latitude')
colorbar
colormap(b2r(-14,14));
title('Diabatic heating - d\Theta dt, K/day, 0.25es0')
print('-dpng','heatdiff_025.png')

figure
[C,h] = contourf(xi,yi,heatdiff_050(:,:,4,40)',v);
hold on
[C,h] = contour(xi,yi,heatdiff_050(:,:,4,40)',[-1000:1000:1000],'k','LineWidth',2);
hold off
xlabel('Longitude')
ylabel('Latitude')
colorbar
colormap(b2r(-14,14));
title('Diabatic heating - d\Theta dt, K/day, 0.5es0')
print('-dpng','heatdiff_050.png')

figure
[C,h] = contourf(xi,yi,heatdiff_075(:,:,4,40)',v);
hold on
[C,h] = contour(xi,yi,heatdiff_075(:,:,4,40)',[-1000:1000:1000],'k','LineWidth',2);
hold off
xlabel('Longitude')
ylabel('Latitude')
colorbar
colormap(b2r(-14,14));
title('Diabatic heating - d\Theta dt, K/day, 0.75es0')
print('-dpng','heatdiff_075.png')

figure
[C,h] = contourf(xi,yi,heatdiff_100(:,:,4,40)',v);
hold on
[C,h] = contour(xi,yi,heatdiff_100(:,:,4,40)',[-1000:1000:1000],'k','LineWidth',2);
hold off
xlabel('Longitude')
ylabel('Latitude')
colorbar
colormap(b2r(-14,14));
title('Diabatic heating - d\Theta dt, K/day, 1es0')
print('-dpng','heatdiff_100.png')




figure
[C,h] = contourf(xi,yi,htrt_000_ll(:,:,4,41)',v);
hold on
[C,h] = contour(xi,yi,htrt_000_ll(:,:,4,41)',[-1000:1000:1000],'k','LineWidth',2);
hold off
xlabel('Longitude')
ylabel('Latitude')
colorbar
colormap(b2r(-14,14));
title('Diabatic heating, K/day, 0es0')
print('-dpng','htrt_000.png')

figure
[C,h] = contourf(xi,yi,htrt_010_ll(:,:,4,41)',v);
hold on
[C,h] = contour(xi,yi,htrt_010_ll(:,:,4,41)',[-1000:1000:1000],'k','LineWidth',2);
hold off
xlabel('Longitude')
ylabel('Latitude')
colorbar
colormap(b2r(-14,14));
title('Diabatic heating, K/day, 0.1es0')
print('-dpng','htrt_010.png')

figure
[C,h] = contourf(xi,yi,htrt_025_ll(:,:,4,41)',v);
hold on
[C,h] = contour(xi,yi,htrt_025_ll(:,:,4,41)',[-1000:1000:1000],'k','LineWidth',2);
hold off
xlabel('Longitude')
ylabel('Latitude')
colorbar
colormap(b2r(-14,14));
title('Diabatic heating, K/day, 0.25es0')
print('-dpng','htrt_025.png')

figure
[C,h] = contourf(xi,yi,htrt_050_ll(:,:,4,41)',v);
hold on
[C,h] = contour(xi,yi,htrt_050_ll(:,:,4,41)',[-1000:1000:1000],'k','LineWidth',2);
hold off
xlabel('Longitude')
ylabel('Latitude')
colorbar
colormap(b2r(-14,14));
title('Diabatic heating, K/day, 0.5es0')
print('-dpng','htrt_050.png')

figure
[C,h] = contourf(xi,yi,htrt_075_ll(:,:,4,41)',v);
hold on
[C,h] = contour(xi,yi,htrt_075_ll(:,:,4,41)',[-1000:1000:1000],'k','LineWidth',2);
hold off
xlabel('Longitude')
ylabel('Latitude')
colorbar
colormap(b2r(-14,14));
title('Diabatic heating, K/day, 0.75es0')
print('-dpng','htrt_075.png')

figure
[C,h] = contourf(xi,yi,htrt_100_ll(:,:,4,41)',v);
hold on
[C,h] = contour(xi,yi,htrt_100_ll(:,:,4,41)',[-1000:1000:1000],'k','LineWidth',2);
hold off
xlabel('Longitude')
ylabel('Latitude')
colorbar
colormap(b2r(-14,14));
title('Diabatic heating, K/day, 1es0')
print('-dpng','htrt_100.png')




figure
[C,h] = contourf(xi,yi,dthetadt_000_ll(:,:,4,40)',v);
hold on
[C,h] = contour(xi,yi,dthetadt_000_ll(:,:,4,40)',[-1000:1000:1000],'k','LineWidth',2);
hold off
xlabel('Longitude')
ylabel('Latitude')
colorbar
colormap(b2r(-14,14));
title('d\Theta dt, K/day, 0es0')
print('-dpng','dthetadt_000.png')

figure
[C,h] = contourf(xi,yi,dthetadt_010_ll(:,:,4,40)',v);
hold on
[C,h] = contour(xi,yi,dthetadt_010_ll(:,:,4,40)',[-1000:1000:1000],'k','LineWidth',2);
hold off
xlabel('Longitude')
ylabel('Latitude')
colorbar
colormap(b2r(-14,14));
title('d\Theta dt, K/day, 0.1es0')
print('-dpng','dthetadt_010.png')

figure
[C,h] = contourf(xi,yi,dthetadt_025_ll(:,:,4,40)',v);
hold on
[C,h] = contour(xi,yi,dthetadt_025_ll(:,:,4,40)',[-1000:1000:1000],'k','LineWidth',2);
hold off
xlabel('Longitude')
ylabel('Latitude')
colorbar
colormap(b2r(-14,14));
title('d\Theta dt, K/day, 0.25es0')
print('-dpng','dthetadt_025.png')

figure
[C,h] = contourf(xi,yi,dthetadt_050_ll(:,:,4,40)',v);
hold on
[C,h] = contour(xi,yi,dthetadt_050_ll(:,:,4,40)',[-1000:1000:1000],'k','LineWidth',2);
hold off
xlabel('Longitude')
ylabel('Latitude')
colorbar
colormap(b2r(-14,14));
title('d\Theta dt, K/day, 0.5es0')
print('-dpng','dthetadt_050.png')

figure
[C,h] = contourf(xi,yi,dthetadt_075_ll(:,:,4,40)',v);
hold on
[C,h] = contour(xi,yi,dthetadt_075_ll(:,:,4,40)',[-1000:1000:1000],'k','LineWidth',2);
hold off
xlabel('Longitude')
ylabel('Latitude')
colorbar
colormap(b2r(-14,14));
title('d\Theta dt, K/day, 0.75es0')
print('-dpng','dthetadt_075.png')

figure
[C,h] = contourf(xi,yi,dthetadt_100_ll(:,:,4,40)',v);
hold on
[C,h] = contour(xi,yi,dthetadt_100_ll(:,:,4,40)',[-1000:1000:1000],'k','LineWidth',2);
hold off
xlabel('Longitude')
ylabel('Latitude')
colorbar
colormap(b2r(-14,14));
title('d\Theta dt, K/day, 1es0')
print('-dpng','dthetadt_100.png')
