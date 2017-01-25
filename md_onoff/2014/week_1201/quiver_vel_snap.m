%load in velocity snapshots and produce a quick quiver plot of these at level 20

load('/project/rg312/mat_files/snapshot_data/uE_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat')

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


u_000_ll = cube2latlon(xc,yc,uE_000(:,:,20,1),xi,yi);
v_000_ll = cube2latlon(xc,yc,vN_000(:,:,20,1),xi,yi);
t_000_ll = cube2latlon(xc,yc,t_000(:,:,20,1),xi,yi) - cube2latlon(xc,yc,mean(t_000(:,:,20,:),4),xi,yi);

u_050_ll = cube2latlon(xc,yc,uE_050(:,:,20,1),xi,yi);
v_050_ll = cube2latlon(xc,yc,vN_050(:,:,20,1),xi,yi);
t_050_ll = cube2latlon(xc,yc,t_050(:,:,20,1),xi,yi) - cube2latlon(xc,yc,mean(t_050(:,:,20,:),4),xi,yi);

u_100_ll_50 = cube2latlon(xc,yc,uE_100(:,:,13,1),xi,yi);
v_100_ll_50 = cube2latlon(xc,yc,vN_100(:,:,13,1),xi,yi);
t_100_ll_50 = cube2latlon(xc,yc,t_100(:,:,13,1),xi,yi); %- cube2latlon(xc,yc,mean(t_100(:,:,13,:),4),xi,yi);

u_100_ll_100 = cube2latlon(xc,yc,uE_100(:,:,2,1),xi,yi);
v_100_ll_100 = cube2latlon(xc,yc,vN_100(:,:,2,1),xi,yi);
t_100_ll_100 = cube2latlon(xc,yc,t_100(:,:,2,1),xi,yi); %- cube2latlon(xc,yc,mean(t_100(:,:,2,:),4),xi,yi);

figure
quiver(u_000_ll',v_000_ll')
figure
quiver(u_050_ll',v_050_ll')
figure
quiver(u_100_ll_50',v_100_ll_50')
figure
quiver(u_100_ll_100',v_100_ll_100')
