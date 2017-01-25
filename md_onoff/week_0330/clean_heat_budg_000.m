%calculate advective heat transport terms carefully on the lat-lon grid


% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_100_best/';
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

radius = 6371.0e3;

load('/project/rg312/mat_files/totttend_100_best.mat','totttend_snap_100')
totttend_snap_100_ll = cube2latlon(xc,yc,totttend_snap_100(:,:,:,360),xi,yi);
totttend_snap_100_ll_tav = cube2latlon(xc,yc,mean(totttend_snap_100,4),xi,yi);
totttend_snap_ed_100_ll = totttend_snap_100_ll - totttend_snap_100_ll_tav;
clear('totttend_snap_100')

load('/project/rg312/mat_files/heat_rates_best.mat','htrt_100')
htrt_100_ll = cube2latlon(xc,yc,htrt_100(:,:,:,360),xi,yi).*86400;
htrt_100_ll_tav = cube2latlon(xc,yc,mean(htrt_100,4),xi,yi).*86400;
htrt_ed_100_ll = htrt_100_ll - htrt_100_ll_tav;
clear('htrt_100')

load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat','theta_100')
theta_100_ll = cube2latlon(xc,yc,theta_100(:,:,:,360),xi,yi);
theta_100_ll_tav = cube2latlon(xc,yc,mean(theta_100,4),xi,yi);
theta_ed_100_ll = theta_100_ll - theta_100_ll_tav;
clear('theta_100')

load('/project/rg312/mat_files/snapshot_data/uE_snapshots_best.mat','uE_100')
uE_100_ll = cube2latlon(xc,yc,uE_100(:,:,:,360),xi,yi);
uE_100_ll_tav = cube2latlon(xc,yc,mean(uE_100,4),xi,yi);
uE_ed_100_ll = uE_100_ll - uE_100_ll_tav;
clear('uE_100')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_100')
vN_100_ll = cube2latlon(xc,yc,vN_100(:,:,:,360),xi,yi);
vN_100_ll_tav = cube2latlon(xc,yc,mean(vN_100,4),xi,yi);
vN_ed_100_ll = vN_100_ll - vN_100_ll_tav;
clear('vN_100')

load('/project/rg312/mat_files/snapshot_data/w_snapshots_best.mat','w_100')
w_100_ll_half = zeros(180,90,26); w_100_ll_tav_half = zeros(180,90,26);
w_100_ll_half(:,:,1:25) = cube2latlon(xc,yc,w_100(:,:,:,360),xi,yi);
w_100_ll_tav_half(:,:,1:25) = cube2latlon(xc,yc,mean(w_100,4),xi,yi);
w_ed_100_ll_half = w_100_ll_half - w_100_ll_tav_half;
clear('w_100')

rC_half = (100000:-4000:0)';
w_ed_100_ll = shiftdim(interp1(rC_half,shiftdim(w_ed_100_ll_half,2),rC),1);
w_100_ll_tav = shiftdim(interp1(rC_half,shiftdim(w_100_ll_tav_half,2),rC),1);
w_100_ll = shiftdim(interp1(rC_half,shiftdim(w_100_ll_half,2),rC),1);




[dtheta_ed_dy_100,dtheta_ed_dx_100,dtheta_ed_dp_100] = gradient(theta_ed_100_ll,pi./90,pi./90,-4000);
dtheta_ed_dy_100 = dtheta_ed_dy_100./radius;

[dthetady_100_tav,dthetadx_100_tav,dthetadp_100_tav] = gradient(theta_100_ll_tav,pi./90,pi./90,-4000);
dthetady_100_tav = dthetady_100_tav./radius;

for i=1:90
dtheta_ed_dx_100(:,i,:) = dtheta_ed_dx_100(:,i,:)./cos(yi(i).*pi./180)./radius;
dthetadx_100_tav(:,i,:) = dthetadx_100_tav(:,i,:)./cos(yi(i).*pi./180)./radius;
end

udtheta_ed_dx_100 = -uE_100_ll_tav.*dtheta_ed_dx_100.*86400;
vdtheta_ed_dy_100 = -vN_100_ll_tav.*dtheta_ed_dx_100.*86400;
wdtheta_ed_dp_100 = -w_100_ll_tav.*dtheta_ed_dp_100.*86400;

u_ed_dthetadx_100 = -uE_ed_100_ll.*dthetadx_100_tav.*86400;
v_ed_dthetady_100 = -vN_ed_100_ll.*dthetady_100_tav.*86400;
w_ed_dthetadp_100 = -w_ed_100_ll.*dthetadp_100_tav.*86400;

total_ed_ttend_guess = htrt_ed_100_ll + udtheta_ed_dx_100 + vdtheta_ed_dy_100 + wdtheta_ed_dp_100 + u_ed_dthetadx_100 + v_ed_dthetady_100 + w_ed_dthetadp_100;








