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

load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/uE_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')

xi=-179:2:180;yi=-89:2:90;
u_000_ll = cube2latlon(xc,yc,uE_000(:,:,:,360),xi,yi);
%u_010_ll = cube2latlon(xc,yc,uE_010(:,:,:,360),xi,yi);
%u_025_ll = cube2latlon(xc,yc,uE_025(:,:,:,360),xi,yi);
%u_050_ll = cube2latlon(xc,yc,uE_050(:,:,:,360),xi,yi);
%u_075_ll = cube2latlon(xc,yc,uE_075(:,:,:,360),xi,yi);
u_100_ll = cube2latlon(xc,yc,uE_100(:,:,:,360),xi,yi);
clear('uE_000','uE_010','uE_025','uE_050','uE_075','uE_100')

v_000_ll = cube2latlon(xc,yc,vN_000(:,:,:,360),xi,yi);
%v_010_ll = cube2latlon(xc,yc,vN_010(:,:,:,360),xi,yi);
%v_025_ll = cube2latlon(xc,yc,vN_025(:,:,:,360),xi,yi);
%v_050_ll = cube2latlon(xc,yc,vN_050(:,:,:,360),xi,yi);
%v_075_ll = cube2latlon(xc,yc,vN_075(:,:,:,360),xi,yi);
v_100_ll = cube2latlon(xc,yc,vN_100(:,:,:,360),xi,yi);
clear('vN_000','vN_010','vN_025','vN_050','vN_075','vN_100')

t_000_ll = cube2latlon(xc,yc,t_000(:,:,:,360),xi,yi);
%t_010_ll = cube2latlon(xc,yc,t_010(:,:,:,360),xi,yi);
%t_025_ll = cube2latlon(xc,yc,t_025(:,:,:,360),xi,yi);
%t_050_ll = cube2latlon(xc,yc,t_050(:,:,:,360),xi,yi);
%t_075_ll = cube2latlon(xc,yc,t_075(:,:,:,360),xi,yi);
t_100_ll = cube2latlon(xc,yc,t_100(:,:,:,360),xi,yi);
clear('t_000','t_010','t_025','t_050','t_075','t_100')



figure
h = quiver(xi,yi,u_000_ll(:,:,5)',v_000_ll(:,:,5)','k');
hold on
v = 260:5:290;
[C,h] = contour(xi,yi,t_000_ll(:,:,5)',v);
caxis([260 290])
xlim([-180 180])
ylim([-90 90])
print('-dpng','uvtheta_000.png')


figure
h = quiver(xi,yi,u_100_ll(:,:,5)',v_100_ll(:,:,5)','k');
hold on
v = 260:5:290;
[C,h] = contour(xi,yi,t_100_ll(:,:,5)',v);
caxis([260 290])
xlim([-180 180])
ylim([-90 90])
print('-dpng','uvtheta_100.png')

