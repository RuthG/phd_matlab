%load up totttend daily means and check they match theta snapshots


% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_100_best_totttend/';
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

load('/project/rg312/mat_files/totttend_100_best.mat','totttend_100')

load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat','theta_100')

theta_100_ll_1 = cube2latlon(xc,yc,theta_100(:,:,5,360),xi,yi);
theta_100_ll_2 = cube2latlon(xc,yc,theta_100(:,:,5,361),xi,yi);
theta_100_ll_3 = cube2latlon(xc,yc,theta_100(:,:,5,362),xi,yi);

theta_diff_1 = theta_100_ll_2 - theta_100_ll_1;
theta_diff_2 = theta_100_ll_3 - theta_100_ll_2;

totttend_100_ll = cube2latlon(xc,yc,totttend_100(:,:,5,361),xi,yi);

totttend_100_ll_tav = cube2latlon(xc,yc,mean(totttend_100,4),xi,yi);
totttend_100_ll_tzav = squeeze(mean(totttend_100_ll_tav,1));

figure
[C,h] = contourf(yi,rC,totttend_100_ll_tzav');
set(gca,'YDir','reverse')
colorbar
xlabel('Longitude')
ylabel('Latitude')
title('TOTTTEND, time and zonal mean, K/day')
print('-dpng','tend_check_totttend_tzav.png')


v=-12:2:12;
figure
[C,h] = contourf(xi,yi,totttend_100_ll',v);
colorbar
xlabel('Longitude')
ylabel('Latitude')
title('TOTTTEND, K/day')
print('-dpng','tend_check_totttend.png')

figure
[C,h] = contourf(xi,yi,theta_diff_1',v);
colorbar
xlabel('Longitude')
ylabel('Latitude')
title('Change in \Theta between 2 successive days')
print('-dpng','tend_check_dtheta.png')



return
figure
contourf(theta_diff_2')
colorbar