%load up theta profiles and check how laplacian of these compare to difht profiles



rDir='/project/rg312/wv_on_rad_off/run_000_best/';
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

Rd = 287.04;
g = 9.81;

load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat','theta_000')
theta_000_ll = squeeze(cube2latlon(xc,yc,theta_000(:,:,:,360),xi,yi));
clear('theta_000')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_000')
t_000_ll = squeeze(cube2latlon(xc,yc,t_000(:,:,:,360),xi,yi));
clear('t_000')

load('/project/rg312/mat_files/heat_rates_best.mat','difht_000')
difht_000_ll = squeeze(cube2latlon(xc,yc,difht_000(:,:,:,360),xi,yi)).*86400;
clear('difht_000')

load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat','theta_100')
theta_100_ll = squeeze(cube2latlon(xc,yc,theta_100(:,:,:,360),xi,yi));
clear('theta_100')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_100')
t_100_ll = squeeze(cube2latlon(xc,yc,t_100(:,:,:,360),xi,yi));
clear('t_100')

load('/project/rg312/mat_files/heat_rates_best.mat','difht_100')
difht_100_ll = squeeze(cube2latlon(xc,yc,difht_100(:,:,:,360),xi,yi)).*86400;
clear('difht_100')



rDir='/project/rg312/wv_on_rad_off/run_000_best/';
nit = 172800;
[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhDifT'));
dift_000 = snap(:,:,:,J);
dift_000_ll = squeeze(cube2latlon(xc,yc,dift_000,xi,yi));

rDir='/project/rg312/wv_on_rad_off/run_100_best/';
nit = 172800;
[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhDifT'));
dift_100 = snap(:,:,:,J);
dift_100_ll = squeeze(cube2latlon(xc,yc,dift_100,xi,yi));


for i=1:25
rho_000(:,:,i) = rC(i)./Rd./t_000_ll(:,:,i);
rho_100(:,:,i) = rC(i)./Rd./t_100_ll(:,:,i);
end

[a,b,dthetadp_000] = gradient(theta_000_ll,-4000);
diftdthetadz_000 = -dift_000_ll.*rho_000.*g.*dthetadp_000;
[a,b,d2thetadzdp_000] = gradient(diftdthetadz_000,-4000);
difht_calc_000 = -rho_000.*g.*d2thetadzdp_000;

[a,b,dthetadp_100] = gradient(theta_100_ll,-4000);
diftdthetadz_100 = -dift_100_ll.*rho_100.*g.*dthetadp_100;
[a,b,d2thetadzdp_100] = gradient(diftdthetadz_100,-4000);
difht_calc_100 = -rho_100.*g.*d2thetadzdp_100;


dthetadz_000 = -rho_000.*g.*dthetadp_000;
[a,b,d2thetadzdp_000] = gradient(dthetadz_000,-4000);
d2thetadz2_000 = -rho_000.*g.*d2thetadzdp_000;

dthetadz_100 = -rho_100.*g.*dthetadp_100;
[a,b,d2thetadzdp_100] = gradient(dthetadz_100,-4000);
d2thetadz2_100 = -rho_100.*g.*d2thetadzdp_100;

[a,b,ddiftdp_000] = gradient(dift_000_ll,-4000);
ddiftdz_000 = -rho_000.*g.*ddiftdp_000;

[a,b,ddiftdp_100] = gradient(dift_100_ll,-4000);
ddiftdz_100 = -rho_000.*g.*ddiftdp_100;


v=-10:1:10;
figure
[C,h] = contourf(xi,yi,difht_calc_000(:,:,2)'.*86400,v);
caxis([-10 10])
colorbar
xlabel('Longitude')
ylabel('Latitude')
title('Difht calculated from dift and theta, 0es0')
print('-dpng','difht_calc_000_l2.png')

figure
[C,h] = contourf(xi,yi,difht_000_ll(:,:,2)',v);
caxis([-10 10])
colorbar
xlabel('Longitude')
ylabel('Latitude')
title('Difht, 0es0')
print('-dpng','difht_000_l2.png')


figure
[C,h] = contourf(xi,yi,difht_calc_100(:,:,2)'.*86400,v);
caxis([-10 10])
colorbar
xlabel('Longitude')
ylabel('Latitude')
title('Difht calculated from dift and theta, 1es0')
print('-dpng','difht_calc_100_l2.png')

figure
[C,h] = contourf(xi,yi,difht_100_ll(:,:,2)',v);
caxis([-10 10])
colorbar
xlabel('Longitude')
ylabel('Latitude')
title('Difht, 1es0')
print('-dpng','difht_100_l2.png')

v=-0.2:0.2:2;
figure
[C,h] = contourf(xi,yi,ddiftdz_000(:,:,2)',v);
colorbar
caxis([-0.2 2])
xlabel('Longitude')
ylabel('Latitude')
title('dKdz, 0es0')
print('-dpng','ddiftdz_000_l2.png')

figure
[C,h] = contourf(xi,yi,ddiftdz_100(:,:,2)',v);
colorbar
caxis([-0.2 2])
xlabel('Longitude')
ylabel('Latitude')
title('dKdz, 1es0')
print('-dpng','ddiftdz_100_l2.png')

v=-8e-6:1e-6:14e-6;
figure
[C,h] = contourf(xi,yi,d2thetadz2_000(:,:,2)',v);
colorbar
caxis([-8e-6 14e-6])
xlabel('Longitude')
ylabel('Latitude')
title('d2thetadz2, 0es0')
print('-dpng','d2thetadz2_000_l2.png')

figure
[C,h] = contourf(xi,yi,d2thetadz2_100(:,:,2)',v);
colorbar
caxis([-8e-6 14e-6])
xlabel('Longitude')
ylabel('Latitude')
title('d2thetadz2, 1es0')
print('-dpng','d2thetadz2_100_l2.png')


%%%%%%%%%%%%%%%%%%%%%%%%%%% level 5 


v=-10:1:10;
figure
[C,h] = contourf(xi,yi,difht_calc_000(:,:,5)'.*86400,v);
caxis([-10 10])
colorbar
xlabel('Longitude')
ylabel('Latitude')
title('Difht calculated from dift and theta, 0es0')
print('-dpng','difht_calc_000_l5.png')

figure
[C,h] = contourf(xi,yi,difht_000_ll(:,:,5)',v);
caxis([-10 10])
colorbar
xlabel('Longitude')
ylabel('Latitude')
title('Difht, 0es0')
print('-dpng','difht_000_l5.png')


figure
[C,h] = contourf(xi,yi,difht_calc_100(:,:,5)'.*86400,v);
caxis([-10 10])
colorbar
xlabel('Longitude')
ylabel('Latitude')
title('Difht calculated from dift and theta, 1es0')
print('-dpng','difht_calc_100_l5.png')

figure
[C,h] = contourf(xi,yi,difht_100_ll(:,:,5)',v);
caxis([-10 10])
colorbar
xlabel('Longitude')
ylabel('Latitude')
title('Difht, 1es0')
print('-dpng','difht_100_l5.png')

v=-0.6:0.1:0.4;
figure
[C,h] = contourf(xi,yi,ddiftdz_000(:,:,5)',v);
colorbar
caxis([-0.6 0.4])
xlabel('Longitude')
ylabel('Latitude')
title('dKdz, 0es0')
print('-dpng','ddiftdz_000_l5.png')

figure
[C,h] = contourf(xi,yi,ddiftdz_100(:,:,5)',v);
colorbar
caxis([-0.6 0.4])
xlabel('Longitude')
ylabel('Latitude')
title('dKdz, 1es0')
print('-dpng','ddiftdz_100_l5.png')

v=-14e-6:1e-6:6e-6;
figure
[C,h] = contourf(xi,yi,d2thetadz2_000(:,:,5)',v);
colorbar
caxis([-14e-6 6e-6])
xlabel('Longitude')
ylabel('Latitude')
title('d2thetadz2, 0es0')
print('-dpng','d2thetadz2_000_l5.png')

figure
[C,h] = contourf(xi,yi,d2thetadz2_100(:,:,5)',v);
colorbar
caxis([-14e-6 6e-6])
xlabel('Longitude')
ylabel('Latitude')
title('d2thetadz2, 1es0')
print('-dpng','d2thetadz2_100_l5.png')


%%%%%%%%%%%%%%%%%%%%%%% zonal mean


figure
[C,h] = contourf(yi,rC./100,squeeze(mean(dift_000_ll,1))');
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
colorbar
print('-dpng','dift_000_zav.png')


figure
[C,h] = contourf(yi,rC./100,squeeze(mean(dift_100_ll,1))');
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
colorbar
print('-dpng','dift_100_zav.png')


return

