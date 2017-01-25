%evaluate differences between successive days: is our heat budget screwed?


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
xi=-179:2:179;

radius = 6371.0e3;
omega = 2.*pi./24./60./60;
f = 2.*omega.*sin(yi.*pi./180);

load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat')

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
