%plot map of theta with a u-v quiver over the top; how does amount of horizontal wind crossing isentropes change w wv?


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
xi=-179:2:179;

load('/project/rg312/mat_files/snapshot_data/theta_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/uE_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/w_snapshots.mat')
load('/project/rg312/mat_files/vt_lats.mat')

xi=-179:2:180;yi=-89:2:90;
u_000_ll = cube2latlon(xc,yc,uE_000,xi,yi);
%u_010_ll = cube2latlon(xc,yc,uE_010,xi,yi);
%u_025_ll = cube2latlon(xc,yc,uE_025,xi,yi);
%u_050_ll = cube2latlon(xc,yc,uE_050,xi,yi);
%u_075_ll = cube2latlon(xc,yc,uE_075,xi,yi);
u_100_ll = cube2latlon(xc,yc,uE_100,xi,yi);

v_000_ll = cube2latlon(xc,yc,vN_000,xi,yi);
%v_010_ll = cube2latlon(xc,yc,vN_010,xi,yi);
%v_025_ll = cube2latlon(xc,yc,vN_025,xi,yi);
%v_050_ll = cube2latlon(xc,yc,vN_050,xi,yi);
%v_075_ll = cube2latlon(xc,yc,vN_075,xi,yi);
v_100_ll = cube2latlon(xc,yc,vN_100,xi,yi);

w_000_ll = cube2latlon(xc,yc,w_000,xi,yi);
%w_010_ll = cube2latlon(xc,yc,w_010,xi,yi);
%w_025_ll = cube2latlon(xc,yc,w_025,xi,yi);
%w_050_ll = cube2latlon(xc,yc,w_050,xi,yi);
%w_075_ll = cube2latlon(xc,yc,w_075,xi,yi);
w_100_ll = cube2latlon(xc,yc,w_100,xi,yi);

theta_000_ll = cube2latlon(xc,yc,theta_000,xi,yi);
%theta_010_ll = cube2latlon(xc,yc,theta_010,xi,yi);
%theta_025_ll = cube2latlon(xc,yc,theta_025,xi,yi);
%theta_050_ll = cube2latlon(xc,yc,theta_050,xi,yi);
%theta_075_ll = cube2latlon(xc,yc,theta_075,xi,yi);
theta_100_ll = cube2latlon(xc,yc,theta_100,xi,yi);


figure
[C,h] = contourf(xi,rC,squeeze(w_000_ll(:,x000n,:,40))');
hold on
contour(xi,rC,squeeze(theta_000_ll(:,x000n,:,40))',[260:2:350],'k');
caxis([-0.4 0.4])

xlim([-180 180])
%ylim([30 100])
set(gca,'YDir','reverse')


figure
h = quiver(xi,rC,squeeze(u_000_ll(:,x000n,:,40))',squeeze(w_000_ll(:,x000n,:,40))','k');
hold on
[C,h] = contour(xi,rC,squeeze(theta_000_ll(:,x000n,:,40))',[260:2:350]);
xlim([-180 180])
ylim([30000 100000])
set(gca,'YDir','reverse')


figure
h = quiver(xi,rC,squeeze(u_100_ll(:,x100n,:,40))',squeeze(w_100_ll(:,x100n,:,40))','k');
hold on
[C,h] = contour(xi,rC,squeeze(theta_100_ll(:,x100n,:,40))',[260:2:350]);
xlim([-180 180])
%ylim([30 100])
set(gca,'YDir','reverse')

figure
h = quiver(yi,rC./1000,squeeze(v_000_ll(90,:,:,40))',squeeze(w_000_ll(90,:,:,40).*100)','k');
hold on
[C,h] = contour(yi,rC./1000,squeeze(theta_000_ll(90,:,:,40))',[260:1:350]);
xlim([-90 90])
ylim([30 100])
set(gca,'YDir','reverse')

figure
h = quiver(yi,rC./1000,squeeze(v_100_ll(90,:,:,40))',squeeze(w_100_ll(90,:,:,40).*100)','k');
hold on
[C,h] = contour(yi,rC./1000,squeeze(theta_100_ll(90,:,:,40))',[260:1:350]);
xlim([-90 90])
ylim([30 100])
set(gca,'YDir','reverse')



figure
h = quiver(xi,yi,u_000_ll(:,:,4,40)',v_000_ll(:,:,4,40)','k');
hold on
[C,h] = contour(xi,yi,theta_000_ll(:,:,4,40)');
xlim([-180 180])
ylim([-90 90])
print('-dpng','uvtheta_000.png')

figure
h = quiver(xi,yi,u_010_ll(:,:,4,40)',v_010_ll(:,:,4,40)','k');
hold on
[C,h] = contour(xi,yi,theta_010_ll(:,:,4,40)');
xlim([-180 180])
ylim([-90 90])
print('-dpng','uvtheta_010.png')

figure
h = quiver(xi,yi,u_025_ll(:,:,4,40)',v_025_ll(:,:,4,40)','k');
hold on
[C,h] = contour(xi,yi,theta_025_ll(:,:,4,40)');
xlim([-180 180])
ylim([-90 90])
print('-dpng','uvtheta_025.png')

figure
h = quiver(xi,yi,u_050_ll(:,:,4,40)',v_050_ll(:,:,4,40)','k');
hold on
[C,h] = contour(xi,yi,theta_050_ll(:,:,4,40)');
xlim([-180 180])
ylim([-90 90])
print('-dpng','uvtheta_050.png')

figure
h = quiver(xi,yi,u_075_ll(:,:,4,40)',v_075_ll(:,:,4,40)','k');
hold on
[C,h] = contour(xi,yi,theta_075_ll(:,:,4,40)');
xlim([-180 180])
ylim([-90 90])
print('-dpng','uvtheta_075.png')

figure
h = quiver(xi,yi,u_100_ll(:,:,4,40)',v_100_ll(:,:,4,40)','k');
hold on
[C,h] = contour(xi,yi,theta_100_ll(:,:,4,40)');
xlim([-180 180])
ylim([-90 90])
print('-dpng','uvtheta_100.png')

