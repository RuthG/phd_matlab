%plot climatology variables for poster

load('/project/rg312/mat_files/climatology_vars.mat')
load('/project/rg312/mat_files/climatology_vars_th.mat')

for i=1:45
uE_000_hzav(i,:) = (uE_000_zav(45+i,:) + uE_000_zav(46-i,:))./2;
uE_050_hzav(i,:) = (uE_050_zav(45+i,:) + uE_050_zav(46-i,:))./2;
uE_100_hzav(i,:) = (uE_100_zav(45+i,:) + uE_100_zav(46-i,:))./2;
uE_th_hzav(i,:) = (uE_th_zav(45+i,:) + uE_th_zav(46-i,:))./2;
theta_000_hzav(i,:) = (theta_000_zav(45+i,:) + theta_000_zav(46-i,:))./2;
theta_050_hzav(i,:) = (theta_050_zav(45+i,:) + theta_050_zav(46-i,:))./2;
theta_100_hzav(i,:) = (theta_100_zav(45+i,:) + theta_100_zav(46-i,:))./2;
theta_th_hzav(i,:) = (theta_th_zav(45+i,:) + theta_th_zav(46-i,:))./2;
end

yi = 1:2:89;
rC = 980:-40:20;

figure
v = -25:5:40;
[C,h] = contourf(yi,rC,uE_000_hzav',v,'k');
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-25,40));
set(h,'LineColor','none')
hold on
v = -100:100:100;
[C,h] = contour(yi,rC,uE_000_hzav',v,'Color',[0.6 0.6 0.6],'LineWidth',2);
v=250:25:700;
[C,h] = contour(yi,rC,theta_000_hzav',v,'k','LineWidth',2);
v=250:50:700;
clabel(C,h,v,'FontSize',12);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('e_{s0} = 0.0 Pa')
print('-dpng','theta_u_000.png')

figure
v = -25:5:40;
[C,h] = contourf(yi,rC,uE_050_hzav',v,'k');
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-25,40));
set(h,'LineColor','none')
hold on
v = -100:100:100;
[C,h] = contour(yi,rC,uE_050_hzav',v,'Color',[0.6 0.6 0.6],'LineWidth',2);
v=250:25:700;
[C,h] = contour(yi,rC,theta_050_hzav',v,'k','LineWidth',2);
v=250:50:700;
clabel(C,h,v,'FontSize',12);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('e_{s0} = 305.39 Pa')
print('-dpng','theta_u_050.png')

figure
v = -25:5:40;
[C,h] = contourf(yi,rC,uE_100_hzav',v,'k');
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-25,40));
set(h,'LineColor','none')
hold on
v = -100:100:100;
[C,h] = contour(yi,rC,uE_100_hzav',v,'Color',[0.6 0.6 0.6],'LineWidth',2);
v=250:25:700;
[C,h] = contour(yi,rC,theta_100_hzav',v,'k','LineWidth',2);
v=250:50:700;
clabel(C,h,v,'FontSize',12);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('e_{s0} = 610.78 Pa')
print('-dpng','theta_u_100.png')



figure
v = -25:5:40;
[C,h] = contourf(yi,rC,uE_th_hzav',v,'k');
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-25,40));
set(h,'LineColor','none')
hold on
v = -100:100:100;
[C,h] = contour(yi,rC,uE_th_hzav',v,'Color',[0.6 0.6 0.6],'LineWidth',2);
v=250:25:700;
[C,h] = contour(yi,rC,theta_th_hzav',v,'k','LineWidth',2);
v=250:50:700;
clabel(C,h,v,'FontSize',12);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('e_{s0} = 305.39 Pa + 5K Tropical SST Increase')
print('-dpng','theta_u_th.png')


clear


% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_doshallower10/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';


load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat')

xi=-179:2:180;yi=-89:2:90;
vN_snap_000_ll = cube2latlon(xc,yc,vN_000(:,:,:,100),xi,yi);
t_snap_000_ll = cube2latlon(xc,yc,t_000(:,:,:,100),xi,yi);
vN_snap_100_ll = cube2latlon(xc,yc,vN_100(:,:,:,100),xi,yi);
t_snap_100_ll = cube2latlon(xc,yc,t_100(:,:,:,100),xi,yi);

vNt_snap_000_ll = vN_snap_000_ll.*t_snap_000_ll;
vNt_snap_100_ll = vN_snap_100_ll.*t_snap_100_ll;

figure
v=-40:10:40;
[C,h] = contourf(xi,yi,vN_snap_000_ll(:,:,20)',v);
colorbar; colormap(b2r(-40,40));
set(h,'LineColor','none')
hold on
v = -1000:1000:1000;
[C,h] = contour(xi,yi,vN_snap_000_ll(:,:,20)',v,'Color',[0.6 0.6 0.6]);
set(gca,'FontSize',15);
xlabel('Longitude'); 
ylabel('Latitude');
title('e_{s0} = 0.0 Pa')
print('-dpng','vN_snap_000.png');

figure
v=-40:10:40;
[C,h] = contourf(xi,yi,vN_snap_100_ll(:,:,20)',v);
colorbar; colormap(b2r(-40,40));
set(h,'LineColor','none')
hold on
v = -1000:1000:1000;
[C,h] = contour(xi,yi,vN_snap_100_ll(:,:,20)',v,'Color',[0.6 0.6 0.6]);
set(gca,'FontSize',15);
xlabel('Longitude'); 
ylabel('Latitude');
title('e_{s0} = 610.78 Pa')
print('-dpng','vN_snap_100.png');


figure
v=-40:10:40;
[C,h] = contourf(xi,yi,vNt_snap_000_ll(:,:,20)',v);
colorbar; colormap(b2r(-40,40));
set(gca,'FontSize',15);
xlabel('Longitude'); 
ylabel('Latitude');
title('e_{s0} = 0.0 Pa')
print('-dpng','vNt_snap_000.png');

figure
v=-40:10:40;
[C,h] = contourf(xi,yi,vNt_snap_100_ll(:,:,20)',v);
colorbar; colormap(b2r(-40,40));
set(gca,'FontSize',15);
xlabel('Longitude'); 
ylabel('Latitude');
title('e_{s0} = 610.78 Pa')
print('-dpng','vNt_snap_100.png');

