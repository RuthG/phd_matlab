%do front plots of q snapshots too


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
yi = -89:2:89;
xi = -179:2:179;

load('/project/rg312/mat_files/snapshot_data/q_snapshots.mat')
load('/project/rg312/mat_files/front_diag.mat')

q_000_ll = cube2latlon(xc,yc,q_000(:,:,:,360),xi,yi);
q_010_ll = cube2latlon(xc,yc,q_010(:,:,:,360),xi,yi);
q_025_ll = cube2latlon(xc,yc,q_025(:,:,:,360),xi,yi);
q_050_ll = cube2latlon(xc,yc,q_050(:,:,:,360),xi,yi);
q_075_ll = cube2latlon(xc,yc,q_075(:,:,:,360),xi,yi);
q_100_ll = cube2latlon(xc,yc,q_100(:,:,:,360),xi,yi);

clear('q_000','q_010','q_025','q_050','q_075','q_100')

load('/project/rg312/mat_files/front_diag.mat')

figure
v=0:0.5e-3:15e-3;
[C,h] = contourf(xi,yi,q_000_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([0 15e-3]);
colorbar
title('Front diag, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','q_000.png')


figure
v=0:0.5e-3:15e-3;
[C,h] = contourf(xi,yi,q_010_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([0 15e-3]);
colorbar
title('Front diag, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','q_010.png')


figure
v=0:0.5e-3:15e-3;
[C,h] = contourf(xi,yi,q_025_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([0 15e-3]);
colorbar
title('Front diag, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','q_025.png')


figure
v=0:0.5e-3:15e-3;
[C,h] = contourf(xi,yi,q_050_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([0 15e-3]);
colorbar
title('Front diag, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','q_050.png')


figure
v=0:0.5e-3:15e-3;
[C,h] = contourf(xi,yi,q_075_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([0 15e-3]);
colorbar
title('Front diag, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','q_075.png')


figure
v=0:0.5e-3:15e-3;
[C,h] = contourf(xi,yi,q_100_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([0 15e-3]);
colorbar
title('Front diag, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','q_100.png')




