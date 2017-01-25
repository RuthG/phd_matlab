%evaluate the advective heat budget terms in our T snapshots

%load T, u, v data
%take dTdx dTdy
%calculate time means and eddies, and dT'/dt 

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


radius = 6371.0e3;
omega = 2.*pi./24./60./60;
f = 2.*omega.*sin(yi.*pi./180);

load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/uE_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/w_snapshots.mat')


%transfer t to ll
xi=-179:2:180;yi=-89:2:90;

w_000_ll = cube2latlon(xc,yc,w_000(:,:,:,360),xi,yi);
w_010_ll = cube2latlon(xc,yc,w_010(:,:,:,360),xi,yi);
w_025_ll = cube2latlon(xc,yc,w_025(:,:,:,360),xi,yi);
w_050_ll = cube2latlon(xc,yc,w_050(:,:,:,360),xi,yi);
w_075_ll = cube2latlon(xc,yc,w_075(:,:,:,360),xi,yi);
w_100_ll = cube2latlon(xc,yc,w_100(:,:,:,360),xi,yi);

w_000_ll_tav = cube2latlon(xc,yc,mean(w_000,4),xi,yi);
w_010_ll_tav = cube2latlon(xc,yc,mean(w_010,4),xi,yi);
w_025_ll_tav = cube2latlon(xc,yc,mean(w_025,4),xi,yi);
w_050_ll_tav = cube2latlon(xc,yc,mean(w_050,4),xi,yi);
w_075_ll_tav = cube2latlon(xc,yc,mean(w_075,4),xi,yi);
w_100_ll_tav = cube2latlon(xc,yc,mean(w_100,4),xi,yi);

w_ed_000_ll = cube2latlon(xc,yc,w_000(:,:,:,360),xi,yi) - w_000_ll_tav;
w_ed_010_ll = cube2latlon(xc,yc,w_010(:,:,:,360),xi,yi) - w_010_ll_tav;
w_ed_025_ll = cube2latlon(xc,yc,w_025(:,:,:,360),xi,yi) - w_025_ll_tav;
w_ed_050_ll = cube2latlon(xc,yc,w_050(:,:,:,360),xi,yi) - w_050_ll_tav;
w_ed_075_ll = cube2latlon(xc,yc,w_075(:,:,:,360),xi,yi) - w_075_ll_tav;
w_ed_100_ll = cube2latlon(xc,yc,w_100(:,:,:,360),xi,yi) - w_100_ll_tav;
clear('w_000','w_010','w_025','w_050','w_075','w_100')

t_000_ll = cube2latlon(xc,yc,t_000(:,:,:,360),xi,yi);
t_010_ll = cube2latlon(xc,yc,t_010(:,:,:,360),xi,yi);
t_025_ll = cube2latlon(xc,yc,t_025(:,:,:,360),xi,yi);
t_050_ll = cube2latlon(xc,yc,t_050(:,:,:,360),xi,yi);
t_075_ll = cube2latlon(xc,yc,t_075(:,:,:,360),xi,yi);
t_100_ll = cube2latlon(xc,yc,t_100(:,:,:,360),xi,yi);

t_000_ll_tav = cube2latlon(xc,yc,mean(t_000,4),xi,yi);
t_010_ll_tav = cube2latlon(xc,yc,mean(t_010,4),xi,yi);
t_025_ll_tav = cube2latlon(xc,yc,mean(t_025,4),xi,yi);
t_050_ll_tav = cube2latlon(xc,yc,mean(t_050,4),xi,yi);
t_075_ll_tav = cube2latlon(xc,yc,mean(t_075,4),xi,yi);
t_100_ll_tav = cube2latlon(xc,yc,mean(t_100,4),xi,yi);

t_ed_000_ll = cube2latlon(xc,yc,t_000(:,:,:,360),xi,yi) - t_000_ll_tav;
t_ed_010_ll = cube2latlon(xc,yc,t_010(:,:,:,360),xi,yi) - t_010_ll_tav;
t_ed_025_ll = cube2latlon(xc,yc,t_025(:,:,:,360),xi,yi) - t_025_ll_tav;
t_ed_050_ll = cube2latlon(xc,yc,t_050(:,:,:,360),xi,yi) - t_050_ll_tav;
t_ed_075_ll = cube2latlon(xc,yc,t_075(:,:,:,360),xi,yi) - t_075_ll_tav;
t_ed_100_ll = cube2latlon(xc,yc,t_100(:,:,:,360),xi,yi) - t_100_ll_tav;

t_000_ll_m = cube2latlon(xc,yc,t_000(:,:,:,359),xi,yi);
t_010_ll_m = cube2latlon(xc,yc,t_010(:,:,:,359),xi,yi);
t_025_ll_m = cube2latlon(xc,yc,t_025(:,:,:,359),xi,yi);
t_050_ll_m = cube2latlon(xc,yc,t_050(:,:,:,359),xi,yi);
t_075_ll_m = cube2latlon(xc,yc,t_075(:,:,:,359),xi,yi);
t_100_ll_m = cube2latlon(xc,yc,t_100(:,:,:,359),xi,yi);

t_000_ll_p = cube2latlon(xc,yc,t_000(:,:,:,361),xi,yi);
t_010_ll_p = cube2latlon(xc,yc,t_010(:,:,:,361),xi,yi);
t_025_ll_p = cube2latlon(xc,yc,t_025(:,:,:,361),xi,yi);
t_050_ll_p = cube2latlon(xc,yc,t_050(:,:,:,361),xi,yi);
t_075_ll_p = cube2latlon(xc,yc,t_075(:,:,:,361),xi,yi);
t_100_ll_p = cube2latlon(xc,yc,t_100(:,:,:,361),xi,yi);


clear('t_000','t_010','t_025','t_050','t_075','t_100')

uE_000_ll = cube2latlon(xc,yc,uE_000(:,:,:,360),xi,yi);
uE_010_ll = cube2latlon(xc,yc,uE_010(:,:,:,360),xi,yi);
uE_025_ll = cube2latlon(xc,yc,uE_025(:,:,:,360),xi,yi);
uE_050_ll = cube2latlon(xc,yc,uE_050(:,:,:,360),xi,yi);
uE_075_ll = cube2latlon(xc,yc,uE_075(:,:,:,360),xi,yi);
uE_100_ll = cube2latlon(xc,yc,uE_100(:,:,:,360),xi,yi);

uE_000_ll_tav = cube2latlon(xc,yc,mean(uE_000,4),xi,yi);
uE_010_ll_tav = cube2latlon(xc,yc,mean(uE_010,4),xi,yi);
uE_025_ll_tav = cube2latlon(xc,yc,mean(uE_025,4),xi,yi);
uE_050_ll_tav = cube2latlon(xc,yc,mean(uE_050,4),xi,yi);
uE_075_ll_tav = cube2latlon(xc,yc,mean(uE_075,4),xi,yi);
uE_100_ll_tav = cube2latlon(xc,yc,mean(uE_100,4),xi,yi);

uE_ed_000_ll = cube2latlon(xc,yc,uE_000(:,:,:,360),xi,yi) - uE_000_ll_tav;
uE_ed_010_ll = cube2latlon(xc,yc,uE_010(:,:,:,360),xi,yi) - uE_010_ll_tav;
uE_ed_025_ll = cube2latlon(xc,yc,uE_025(:,:,:,360),xi,yi) - uE_025_ll_tav;
uE_ed_050_ll = cube2latlon(xc,yc,uE_050(:,:,:,360),xi,yi) - uE_050_ll_tav;
uE_ed_075_ll = cube2latlon(xc,yc,uE_075(:,:,:,360),xi,yi) - uE_075_ll_tav;
uE_ed_100_ll = cube2latlon(xc,yc,uE_100(:,:,:,360),xi,yi) - uE_100_ll_tav;
clear('uE_000','uE_010','uE_025','uE_050','uE_075','uE_100')

vN_000_ll = cube2latlon(xc,yc,vN_000(:,:,:,360),xi,yi);
vN_010_ll = cube2latlon(xc,yc,vN_010(:,:,:,360),xi,yi);
vN_025_ll = cube2latlon(xc,yc,vN_025(:,:,:,360),xi,yi);
vN_050_ll = cube2latlon(xc,yc,vN_050(:,:,:,360),xi,yi);
vN_075_ll = cube2latlon(xc,yc,vN_075(:,:,:,360),xi,yi);
vN_100_ll = cube2latlon(xc,yc,vN_100(:,:,:,360),xi,yi);

vN_000_ll_tav = cube2latlon(xc,yc,mean(vN_000,4),xi,yi);
vN_010_ll_tav = cube2latlon(xc,yc,mean(vN_010,4),xi,yi);
vN_025_ll_tav = cube2latlon(xc,yc,mean(vN_025,4),xi,yi);
vN_050_ll_tav = cube2latlon(xc,yc,mean(vN_050,4),xi,yi);
vN_075_ll_tav = cube2latlon(xc,yc,mean(vN_075,4),xi,yi);
vN_100_ll_tav = cube2latlon(xc,yc,mean(vN_100,4),xi,yi);

vN_ed_000_ll = cube2latlon(xc,yc,vN_000(:,:,:,360),xi,yi) - vN_000_ll_tav;
vN_ed_010_ll = cube2latlon(xc,yc,vN_010(:,:,:,360),xi,yi) - vN_010_ll_tav;
vN_ed_025_ll = cube2latlon(xc,yc,vN_025(:,:,:,360),xi,yi) - vN_025_ll_tav;
vN_ed_050_ll = cube2latlon(xc,yc,vN_050(:,:,:,360),xi,yi) - vN_050_ll_tav;
vN_ed_075_ll = cube2latlon(xc,yc,vN_075(:,:,:,360),xi,yi) - vN_075_ll_tav;
vN_ed_100_ll = cube2latlon(xc,yc,vN_100(:,:,:,360),xi,yi) - vN_100_ll_tav;
clear('vN_000','vN_010','vN_025','vN_050','vN_075','vN_100')



[dTdy_000,dTdx_000] = gradient(t_000_ll_tav(:,:,5),pi./90);
dTdy_000 = dTdy_000./radius;
[dTdy_010,dTdx_010] = gradient(t_010_ll_tav(:,:,5),pi./90);
dTdy_010 = dTdy_010./radius;
[dTdy_025,dTdx_025] = gradient(t_025_ll_tav(:,:,5),pi./90);
dTdy_025 = dTdy_025./radius;
[dTdy_050,dTdx_050] = gradient(t_050_ll_tav(:,:,5),pi./90);
dTdy_050 = dTdy_050./radius;
[dTdy_075,dTdx_075] = gradient(t_075_ll_tav(:,:,5),pi./90);
dTdy_075 = dTdy_075./radius;
[dTdy_100,dTdx_100] = gradient(t_100_ll_tav(:,:,5),pi./90);
dTdy_100 = dTdy_100./radius;

[dT_ed_dy_000,dT_ed_dx_000] = gradient(t_ed_000_ll(:,:,5),pi./90);
dT_ed_dy_000 = dT_ed_dy_000./radius;
[dT_ed_dy_010,dT_ed_dx_010] = gradient(t_ed_010_ll(:,:,5),pi./90);
dT_ed_dy_010 = dT_ed_dy_010./radius;
[dT_ed_dy_025,dT_ed_dx_025] = gradient(t_ed_025_ll(:,:,5),pi./90);
dT_ed_dy_025 = dT_ed_dy_025./radius;
[dT_ed_dy_050,dT_ed_dx_050] = gradient(t_ed_050_ll(:,:,5),pi./90);
dT_ed_dy_050 = dT_ed_dy_050./radius;
[dT_ed_dy_075,dT_ed_dx_075] = gradient(t_ed_075_ll(:,:,5),pi./90);
dT_ed_dy_075 = dT_ed_dy_075./radius;
[dT_ed_dy_100,dT_ed_dx_100] = gradient(t_ed_100_ll(:,:,5),pi./90);
dT_ed_dy_100 = dT_ed_dy_100./radius;

for i=1:90
dT_ed_dx_000(:,i) = dT_ed_dx_000(:,i)./cos(yi(i).*pi./180)./radius;
dT_ed_dx_010(:,i) = dT_ed_dx_010(:,i)./cos(yi(i).*pi./180)./radius;
dT_ed_dx_025(:,i) = dT_ed_dx_025(:,i)./cos(yi(i).*pi./180)./radius;
dT_ed_dx_050(:,i) = dT_ed_dx_050(:,i)./cos(yi(i).*pi./180)./radius;
dT_ed_dx_075(:,i) = dT_ed_dx_075(:,i)./cos(yi(i).*pi./180)./radius;
dT_ed_dx_100(:,i) = dT_ed_dx_100(:,i)./cos(yi(i).*pi./180)./radius;

dTdx_000(:,i) = dTdx_000(:,i)./cos(yi(i).*pi./180)./radius;
dTdx_010(:,i) = dTdx_010(:,i)./cos(yi(i).*pi./180)./radius;
dTdx_025(:,i) = dTdx_025(:,i)./cos(yi(i).*pi./180)./radius;
dTdx_050(:,i) = dTdx_050(:,i)./cos(yi(i).*pi./180)./radius;
dTdx_075(:,i) = dTdx_075(:,i)./cos(yi(i).*pi./180)./radius;
dTdx_100(:,i) = dTdx_100(:,i)./cos(yi(i).*pi./180)./radius;

end



%evaluate horiz advection terms

udT_ed_dx_000 = -dT_ed_dx_000.*uE_000_ll_tav(:,:,5).*86400;
u_ed_dTdx_000 = -dTdx_000.*uE_ed_000_ll(:,:,5).*86400;
vdT_ed_dy_000 = -dT_ed_dx_000.*vN_000_ll_tav(:,:,5).*86400;
v_ed_dTdy_000 = -dTdy_000.*vN_ed_000_ll(:,:,5).*86400;

udT_ed_dx_010 = -dT_ed_dx_010.*uE_010_ll_tav(:,:,5).*86400;
u_ed_dTdx_010 = -dTdx_010.*uE_ed_010_ll(:,:,5).*86400;
vdT_ed_dy_010 = -dT_ed_dx_010.*vN_010_ll_tav(:,:,5).*86400;
v_ed_dTdy_010 = -dTdy_010.*vN_ed_010_ll(:,:,5).*86400;

udT_ed_dx_025 = -dT_ed_dx_025.*uE_025_ll_tav(:,:,5).*86400;
u_ed_dTdx_025 = -dTdx_025.*uE_ed_025_ll(:,:,5).*86400;
vdT_ed_dy_025 = -dT_ed_dx_025.*vN_025_ll_tav(:,:,5).*86400;
v_ed_dTdy_025 = -dTdy_025.*vN_ed_025_ll(:,:,5).*86400;

udT_ed_dx_050 = -dT_ed_dx_050.*uE_050_ll_tav(:,:,5).*86400;
u_ed_dTdx_050 = dTdx_050.*uE_ed_050_ll(:,:,5).*86400;
vdT_ed_dy_050 = -dT_ed_dx_050.*vN_050_ll_tav(:,:,5).*86400;
v_ed_dTdy_050 = -dTdy_050.*vN_ed_050_ll(:,:,5).*86400;

udT_ed_dx_075 = -dT_ed_dx_075.*uE_075_ll_tav(:,:,5).*86400;
u_ed_dTdx_075 = -dTdx_075.*uE_ed_075_ll(:,:,5).*86400;
vdT_ed_dy_075 = -dT_ed_dx_075.*vN_075_ll_tav(:,:,5).*86400;
v_ed_dTdy_075 = -dTdy_075.*vN_ed_075_ll(:,:,5).*86400;

udT_ed_dx_100 = -dT_ed_dx_100.*uE_100_ll_tav(:,:,5).*86400;
u_ed_dTdx_100 = -dTdx_100.*uE_ed_100_ll(:,:,5).*86400;
vdT_ed_dy_100 = -dT_ed_dx_100.*vN_100_ll_tav(:,:,5).*86400;
v_ed_dTdy_100 = -dTdy_100.*vN_ed_100_ll(:,:,5).*86400;

save('/project/rg312/mat_files/eddy_adiabatic_heating.mat')

dTdt_000 = (t_000_ll_p - t_000_ll_m)./2;
dTdt_010 = (t_010_ll_p - t_010_ll_m)./2;
dTdt_025 = (t_025_ll_p - t_025_ll_m)./2;
dTdt_050 = (t_050_ll_p - t_050_ll_m)./2;
dTdt_075 = (t_075_ll_p - t_075_ll_m)./2;
dTdt_100 = (t_100_ll_p - t_100_ll_m)./2;





vNt_ed_000_ll = vN_ed_000_ll.*t_ed_000_ll;
vNt_ed_100_ll = vN_ed_100_ll.*t_ed_100_ll;

load('/project/rg312/mat_files/vt_lats.mat')
load('/project/rg312/mat_files/front_diag.mat')

figure
v=-150:25:150;
[C,h] = contourf(xi,yi,vNt_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-150 150]);
colorbar
plot([-180 180],[yi(x000n) yi(x000n)],'k--')
title('Front diag, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vt_latmark_000.png')


figure
v=-150:25:150;
[C,h] = contourf(xi,yi,vNt_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-150 150]);
colorbar
plot([-180 180],[yi(x100n) yi(x100n)],'k--')
title('Front diag, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vt_latmark_100.png')




return



figure
v=-20:2:20;
[C,h] = contourf(xi,yi,udT_ed_dx_000',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('udT''dx, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','udtpdx_000.png')

figure
v=-20:2:20;
[C,h] = contourf(xi,yi,udT_ed_dx_010',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('udT''dx, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','udtpdx_010.png')

figure
v=-20:2:20;
[C,h] = contourf(xi,yi,udT_ed_dx_025',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('udT''dx, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','udtpdx_025.png')

figure
v=-20:2:20;
[C,h] = contourf(xi,yi,udT_ed_dx_050',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('udT''dx, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','udtpdx_050.png')

figure
v=-20:2:20;
[C,h] = contourf(xi,yi,udT_ed_dx_075',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('udT''dx, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','udtpdx_075.png')

figure
v=-20:2:20;
[C,h] = contourf(xi,yi,udT_ed_dx_100',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('udT''dx, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','udtpdx_100.png')






figure
v=-20:2:20;
[C,h] = contourf(xi,yi,u_ed_dTdx_000',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('u''dTdx, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dupdtdx_000.png')

figure
v=-20:2:20;
[C,h] = contourf(xi,yi,u_ed_dTdx_010',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('u''dTdx, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dupdtdx_010.png')

figure
v=-20:2:20;
[C,h] = contourf(xi,yi,u_ed_dTdx_025',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('u''dTdx, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dupdtdx_025.png')

figure
v=-20:2:20;
[C,h] = contourf(xi,yi,u_ed_dTdx_050',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('u''dTdx, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dupdtdx_050.png')

figure
v=-20:2:20;
[C,h] = contourf(xi,yi,u_ed_dTdx_075',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('u''dTdx, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dupdtdx_075.png')

figure
v=-20:2:20;
[C,h] = contourf(xi,yi,u_ed_dTdx_100',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('u''dTdx, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dupdtdx_100.png')






figure
v=-20:2:20;
[C,h] = contourf(xi,yi,vdT_ed_dy_000',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('vdT''dy, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vdtpdy_000.png')

figure
v=-20:2:20;
[C,h] = contourf(xi,yi,vdT_ed_dy_010',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('vdT''dy, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vdtpdy_010.png')

figure
v=-20:2:20;
[C,h] = contourf(xi,yi,vdT_ed_dy_025',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('vdT''dy, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vdtpdy_025.png')

figure
v=-20:2:20;
[C,h] = contourf(xi,yi,vdT_ed_dy_050',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('vdT''dy, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vdtpdy_050.png')

figure
v=-20:2:20;
[C,h] = contourf(xi,yi,vdT_ed_dy_075',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('vdT''dy, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vdtpdy_075.png')

figure
v=-20:2:20;
[C,h] = contourf(xi,yi,vdT_ed_dy_100',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('vdT''dy, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vdtpdy_100.png')






figure
v=-20:2:20;
[C,h] = contourf(xi,yi,v_ed_dTdy_000',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('v''dTdy, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vpdtdy_000.png')

figure
v=-20:2:20;
[C,h] = contourf(xi,yi,v_ed_dTdy_010',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('v''dTdy, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vpdtdy_010.png')

figure
v=-20:2:20;
[C,h] = contourf(xi,yi,v_ed_dTdy_025',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('v''dTdy, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vpdtdy_025.png')

figure
v=-20:2:20;
[C,h] = contourf(xi,yi,v_ed_dTdy_050',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('v''dTdy, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vpdtdy_050.png')

figure
v=-20:2:20;
[C,h] = contourf(xi,yi,v_ed_dTdy_075',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('v''dTdy, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vpdtdy_075.png')

figure
v=-20:2:20;
[C,h] = contourf(xi,yi,v_ed_dTdy_100',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('v''dTdy, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vpdtdy_100.png')






