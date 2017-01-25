
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
load('/project/rg312/mat_files/vt_lats.mat')

load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/w_snapshots.mat')


%transfer t to ll
xi=-179:2:180;yi=-89:2:90;

w_000_ll_half = zeros(180,90,26);
w_010_ll_half = zeros(180,90,26);
w_025_ll_half = zeros(180,90,26);
w_050_ll_half = zeros(180,90,26);
w_075_ll_half = zeros(180,90,26);
w_100_ll_half = zeros(180,90,26);

w_000_ll_tav_half = zeros(180,90,26);
w_010_ll_tav_half = zeros(180,90,26);
w_025_ll_tav_half = zeros(180,90,26);
w_050_ll_tav_half = zeros(180,90,26);
w_075_ll_tav_half = zeros(180,90,26);
w_100_ll_tav_half = zeros(180,90,26);

w_000_ll_half(:,:,1:25) = cube2latlon(xc,yc,w_000(:,:,:,360),xi,yi);
w_010_ll_half(:,:,1:25) = cube2latlon(xc,yc,w_010(:,:,:,360),xi,yi);
w_025_ll_half(:,:,1:25) = cube2latlon(xc,yc,w_025(:,:,:,360),xi,yi);
w_050_ll_half(:,:,1:25) = cube2latlon(xc,yc,w_050(:,:,:,360),xi,yi);
w_075_ll_half(:,:,1:25) = cube2latlon(xc,yc,w_075(:,:,:,360),xi,yi);
w_100_ll_half(:,:,1:25) = cube2latlon(xc,yc,w_100(:,:,:,360),xi,yi);

w_000_ll_tav_half(:,:,1:25) = cube2latlon(xc,yc,mean(w_000,4),xi,yi);
w_010_ll_tav_half(:,:,1:25) = cube2latlon(xc,yc,mean(w_010,4),xi,yi);
w_025_ll_tav_half(:,:,1:25) = cube2latlon(xc,yc,mean(w_025,4),xi,yi);
w_050_ll_tav_half(:,:,1:25) = cube2latlon(xc,yc,mean(w_050,4),xi,yi);
w_075_ll_tav_half(:,:,1:25) = cube2latlon(xc,yc,mean(w_075,4),xi,yi);
w_100_ll_tav_half(:,:,1:25) = cube2latlon(xc,yc,mean(w_100,4),xi,yi);


w_ed_000_ll_half = w_000_ll_half - w_000_ll_tav_half;
w_ed_010_ll_half = w_010_ll_half - w_010_ll_tav_half;
w_ed_025_ll_half = w_025_ll_half - w_025_ll_tav_half;
w_ed_050_ll_half = w_050_ll_half - w_050_ll_tav_half;
w_ed_075_ll_half = w_075_ll_half - w_075_ll_tav_half;
w_ed_100_ll_half = w_100_ll_half - w_100_ll_tav_half;

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

t_ed_000_ll = t_000_ll - t_000_ll_tav;
t_ed_010_ll = t_010_ll - t_010_ll_tav;
t_ed_025_ll = t_025_ll - t_025_ll_tav;
t_ed_050_ll = t_050_ll - t_050_ll_tav;
t_ed_075_ll = t_075_ll - t_075_ll_tav;
t_ed_100_ll = t_100_ll - t_100_ll_tav;


clear('t_000','t_010','t_025','t_050','t_075','t_100')


[a,b,dTdp_000] = gradient(t_000_ll_tav,-4000);
[a,b,dTdp_010] = gradient(t_010_ll_tav,-4000);
[a,b,dTdp_025] = gradient(t_025_ll_tav,-4000);
[a,b,dTdp_050] = gradient(t_050_ll_tav,-4000);
[a,b,dTdp_075] = gradient(t_075_ll_tav,-4000);
[a,b,dTdp_100] = gradient(t_100_ll_tav,-4000);

[a,b,dT_ed_dp_000] = gradient(t_ed_000_ll,-4000);
[a,b,dT_ed_dp_010] = gradient(t_ed_010_ll,-4000);
[a,b,dT_ed_dp_025] = gradient(t_ed_025_ll,-4000);
[a,b,dT_ed_dp_050] = gradient(t_ed_050_ll,-4000);
[a,b,dT_ed_dp_075] = gradient(t_ed_075_ll,-4000);
[a,b,dT_ed_dp_100] = gradient(t_ed_100_ll,-4000);

rC_half = 100000:-4000:0;
w_ed_000_ll = shiftdim(interp1(rC_half,shiftdim(w_ed_000_ll_half,2),rC),1);
w_ed_010_ll = shiftdim(interp1(rC_half,shiftdim(w_ed_010_ll_half,2),rC),1);
w_ed_025_ll = shiftdim(interp1(rC_half,shiftdim(w_ed_025_ll_half,2),rC),1);
w_ed_050_ll = shiftdim(interp1(rC_half,shiftdim(w_ed_050_ll_half,2),rC),1);
w_ed_075_ll = shiftdim(interp1(rC_half,shiftdim(w_ed_075_ll_half,2),rC),1);
w_ed_100_ll = shiftdim(interp1(rC_half,shiftdim(w_ed_100_ll_half,2),rC),1);

w_000_ll_tav = shiftdim(interp1(rC_half,shiftdim(w_000_ll_tav_half,2),rC),1);
w_010_ll_tav = shiftdim(interp1(rC_half,shiftdim(w_010_ll_tav_half,2),rC),1);
w_025_ll_tav = shiftdim(interp1(rC_half,shiftdim(w_025_ll_tav_half,2),rC),1);
w_050_ll_tav = shiftdim(interp1(rC_half,shiftdim(w_050_ll_tav_half,2),rC),1);
w_075_ll_tav = shiftdim(interp1(rC_half,shiftdim(w_075_ll_tav_half,2),rC),1);
w_100_ll_tav = shiftdim(interp1(rC_half,shiftdim(w_100_ll_tav_half,2),rC),1);


wdT_ed_dp_000 = -dT_ed_dp_000.*w_000_ll_tav.*86400;
wdT_ed_dp_010 = -dT_ed_dp_010.*w_010_ll_tav.*86400;
wdT_ed_dp_025 = -dT_ed_dp_025.*w_025_ll_tav.*86400;
wdT_ed_dp_050 = -dT_ed_dp_050.*w_050_ll_tav.*86400;
wdT_ed_dp_075 = -dT_ed_dp_075.*w_075_ll_tav.*86400;
wdT_ed_dp_100 = -dT_ed_dp_100.*w_100_ll_tav.*86400;

w_ed_dTdp_000 = -dTdp_000.*w_ed_000_ll.*86400;
w_ed_dTdp_010 = -dTdp_010.*w_ed_010_ll.*86400;
w_ed_dTdp_025 = -dTdp_025.*w_ed_025_ll.*86400;
w_ed_dTdp_050 = -dTdp_050.*w_ed_050_ll.*86400;
w_ed_dTdp_075 = -dTdp_075.*w_ed_075_ll.*86400;
w_ed_dTdp_100 = -dTdp_100.*w_ed_100_ll.*86400;



save('/project/rg312/mat_files/eddy_adiabatic_heating.mat','-append')


