%load up vort

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

load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat')

t_000_ll = cube2latlon(xc,yc,t_000(:,:,:,360),xi,yi);
t_010_ll = cube2latlon(xc,yc,t_010(:,:,:,360),xi,yi);
t_025_ll = cube2latlon(xc,yc,t_025(:,:,:,360),xi,yi);
t_050_ll = cube2latlon(xc,yc,t_050(:,:,:,360),xi,yi);
t_075_ll = cube2latlon(xc,yc,t_075(:,:,:,360),xi,yi);
t_100_ll = cube2latlon(xc,yc,t_100(:,:,:,360),xi,yi);

clear('t_000','t_010','t_025','t_050','t_075','t_100')

Ra = 287.04;

for i=1:25
rho_000_ll(:,:,i) = rC(i)./Ra./t_000_ll(:,:,i);
rho_010_ll(:,:,i) = rC(i)./Ra./t_010_ll(:,:,i);
rho_025_ll(:,:,i) = rC(i)./Ra./t_025_ll(:,:,i);
rho_050_ll(:,:,i) = rC(i)./Ra./t_050_ll(:,:,i);
rho_075_ll(:,:,i) = rC(i)./Ra./t_075_ll(:,:,i);
rho_100_ll(:,:,i) = rC(i)./Ra./t_100_ll(:,:,i);
end

load('/project/rg312/mat_files/snapshot_data/theta_snapshots.mat')

theta_000_ll = cube2latlon(xc,yc,theta_000(:,:,:,360),xi,yi);
theta_010_ll = cube2latlon(xc,yc,theta_010(:,:,:,360),xi,yi);
theta_025_ll = cube2latlon(xc,yc,theta_025(:,:,:,360),xi,yi);
theta_050_ll = cube2latlon(xc,yc,theta_050(:,:,:,360),xi,yi);
theta_075_ll = cube2latlon(xc,yc,theta_075(:,:,:,360),xi,yi);
theta_100_ll = cube2latlon(xc,yc,theta_100(:,:,:,360),xi,yi);

clear('theta_000','theta_010','theta_025','theta_050','theta_075','theta_100')


load('/project/rg312/mat_files/vorticity_data.mat')

vort_000_ll = cube2latlon(xg,yg,vort_000(:,:,:,360),xi,yi);
vort_010_ll = cube2latlon(xg,yg,vort_010(:,:,:,360),xi,yi);
vort_025_ll = cube2latlon(xg,yg,vort_025(:,:,:,360),xi,yi);
vort_050_ll = cube2latlon(xg,yg,vort_050(:,:,:,360),xi,yi);
vort_075_ll = cube2latlon(xg,yg,vort_075(:,:,:,360),xi,yi);
vort_100_ll = cube2latlon(xg,yg,vort_100(:,:,:,360),xi,yi);

clear('vort_000','vort_010','vort_025','vort_050','vort_075','vort_100')

[dthetady_000,dthetadx_000,dthetadp_000] = gradient(theta_000_ll,-4000);
clear('dthetady_000','dthetadx_000')
[dthetady_010,dthetadx_010,dthetadp_010] = gradient(theta_010_ll,-4010);
clear('dthetady_010','dthetadx_010')
[dthetady_025,dthetadx_025,dthetadp_025] = gradient(theta_025_ll,-4025);
clear('dthetady_025','dthetadx_025')
[dthetady_050,dthetadx_050,dthetadp_050] = gradient(theta_050_ll,-4050);
clear('dthetady_050','dthetadx_050')
[dthetady_075,dthetadx_075,dthetadp_075] = gradient(theta_075_ll,-4075);
clear('dthetady_075','dthetadx_075')
[dthetady_100,dthetadx_100,dthetadp_100] = gradient(theta_100_ll,-4100);
clear('dthetady_100','dthetadx_100')

omega = 2.*pi./24./60./60;

f_lin = 2.*omega.*sin(yi.*pi./180);
f = repmat(f_lin,[180,1,25]);

pv_000_ll = (f + vort_000_ll).*dthetadp_000./rho_000_ll;
pv_010_ll = (f + vort_010_ll).*dthetadp_010./rho_010_ll;
pv_025_ll = (f + vort_025_ll).*dthetadp_025./rho_025_ll;
pv_050_ll = (f + vort_050_ll).*dthetadp_050./rho_050_ll;
pv_075_ll = (f + vort_075_ll).*dthetadp_075./rho_075_ll;
pv_100_ll = (f + vort_100_ll).*dthetadp_100./rho_100_ll;

load('/project/rg312/mat_files/front_diag.mat')

figure
v=-12e-8:0.5e-8:12e-8;
[C,h] = contourf(xi,yi,pv_000_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-12e-8 12e-8]);
colorbar
title('Front diag, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','pv_000.png')

figure
v=-12e-8:0.5e-8:12e-8;
[C,h] = contourf(xi,yi,pv_010_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-12e-8 12e-8]);
colorbar
title('Front diag, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','pv_010.png')

figure
v=-12e-8:0.5e-8:12e-8;
[C,h] = contourf(xi,yi,pv_025_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-12e-8 12e-8]);
colorbar
title('Front diag, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','pv_025.png')

figure
v=-12e-8:0.5e-8:12e-8;
[C,h] = contourf(xi,yi,pv_050_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-12e-8 12e-8]);
colorbar
title('Front diag, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','pv_050.png')

figure
v=-12e-8:0.5e-8:12e-8;
[C,h] = contourf(xi,yi,pv_075_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-12e-8 12e-8]);
colorbar
title('Front diag, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','pv_075.png')

figure
v=-12e-8:0.5e-8:12e-8;
[C,h] = contourf(xi,yi,pv_100_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-12e-8 12e-8]);
colorbar
title('Front diag, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','pv_100.png')



figure
v=-12e-4:1e-4:1e-4;
[C,h] = contourf(xi,yi,dthetadp_000(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-12e-4 1e-4]);
colorbar
title('Front diag, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthetadp_000.png')

figure
v=-12e-4:1e-4:1e-4;
[C,h] = contourf(xi,yi,dthetadp_010(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-12e-4 1e-4]);
colorbar
title('Front diag, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthetadp_010.png')

figure
v=-12e-4:1e-4:1e-4;
[C,h] = contourf(xi,yi,dthetadp_025(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-12e-4 1e-4]);
colorbar
title('Front diag, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthetadp_025.png')

figure
v=-12e-4:1e-4:1e-4;
[C,h] = contourf(xi,yi,dthetadp_050(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-12e-4 1e-4]);
colorbar
title('Front diag, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthetadp_050.png')

figure
v=-12e-4:1e-4:1e-4;
[C,h] = contourf(xi,yi,dthetadp_075(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-12e-4 1e-4]);
colorbar
title('Front diag, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthetadp_075.png')

figure
v=-12e-4:1e-4:1e-4;
[C,h] = contourf(xi,yi,dthetadp_100(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-12e-4 1e-4]);
colorbar
title('Front diag, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthetadp_100.png')


