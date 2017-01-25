%load w, plot snapshots on cs grid


% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_doshallower00/';
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%

nit = 259200;

rDir='/project/rg312/wv_on_rad_off/run_doshallower00/';
w_00=rdmds([rDir,'W'],nit);

rDir='/project/rg312/wv_on_rad_off/run_doshallower01/';
w_01=rdmds([rDir,'W'],nit);

rDir='/project/rg312/wv_on_rad_off/run_doshallower025/';
w_025=rdmds([rDir,'W'],nit);

rDir='/project/rg312/wv_on_rad_off/run_doshallower05/';
w_05=rdmds([rDir,'W'],nit);

rDir='/project/rg312/wv_on_rad_off/run_doshallower75/';
w_75=rdmds([rDir,'W'],nit);

rDir='/project/rg312/wv_on_rad_off/run_doshallower10/';
w_10=rdmds([rDir,'W'],nit);


xi=-179:2:180;yi=-89:2:90;
w_00_ll = cube2latlon(xc,yc,w_00,xi,yi);
w_01_ll = cube2latlon(xc,yc,w_01,xi,yi);
w_025_ll = cube2latlon(xc,yc,w_025,xi,yi);
w_05_ll = cube2latlon(xc,yc,w_05,xi,yi);
w_75_ll = cube2latlon(xc,yc,w_75,xi,yi);
w_10_ll = cube2latlon(xc,yc,w_10,xi,yi);

k=8;
figure(1);clf;
ccB=[0 0];
AxBx=[-180 180 -90 90];
kEnv=0; shift=-1; cbV=1;
grph_CS(w_00(:,:,11),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
caxis([-0.8 0.8])
print('-dpng','w_000_snapshot.png')

v=-0.8:0.1:0.8;
[C,h] = contourf(xi,yi,w_00_ll(:,:,11)',v);
colorbar
caxis([-0.8 0.8])
print('-dpng','w_000_snapshot_ll.png');

grph_CS(w_01(:,:,11),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
caxis([-0.8 0.8])
print('-dpng','w_001_snapshot.png')

[C,h] = contourf(xi,yi,w_01_ll(:,:,11)',v);
colorbar
caxis([-0.8 0.8])
print('-dpng','w_001_snapshot_ll.png');

grph_CS(w_025(:,:,11),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
caxis([-0.8 0.8])
print('-dpng','w_025_snapshot.png')

[C,h] = contourf(xi,yi,w_025_ll(:,:,11)',v);
colorbar
caxis([-0.8 0.8])
print('-dpng','w_025_snapshot_ll.png');

grph_CS(w_05(:,:,11),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
caxis([-0.8 0.8])
print('-dpng','w_050_snapshot.png')

[C,h] = contourf(xi,yi,w_05_ll(:,:,11)',v);
colorbar
caxis([-0.8 0.8])
print('-dpng','w_050_snapshot_ll.png');

grph_CS(w_75(:,:,11),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
caxis([-0.8 0.8])
print('-dpng','w_075_snapshot.png')

[C,h] = contourf(xi,yi,w_75_ll(:,:,11)',v);
colorbar
caxis([-0.8 0.8])
print('-dpng','w_075_snapshot_ll.png');

grph_CS(w_10(:,:,11),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
caxis([-0.8 0.8])
print('-dpng','w_100_snapshot.png')

[C,h] = contourf(xi,yi,w_10_ll(:,:,11)',v);
colorbar
caxis([-0.8 0.8])
print('-dpng','w_100_snapshot_ll.png');


v=-1.5:0.5:0.5:1.5;
[C,h] = contourf(xi,yi,w_00_ll(:,:,11)',v);
colorbar
caxis([-1.5 1.5])
print('-dpng','w_000_snapshot_ll.png');
