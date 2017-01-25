function [vth_ed,dthdy,wth_ed,dthdp,qth_ed,th_var] = var_eq_fun(run)

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
yi=-89:2:89;
xi = -179:2:179;

theta_var = ['theta_' run];
theta_cs = load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat',theta_var);
theta_cs = theta_cs.(theta_var);
theta_ll = squeeze(cube2latlon(xc,yc,theta_cs,xi,yi));
theta_ll_tav = repmat(mean(theta_ll,4),[1 1 1 720]);
theta_ed_ll = theta_ll - theta_ll_tav;
clear('theta_cs','theta_ll')
theta_ll_tav = theta_ll_tav(:,:,:,1);
theta_ll_tzav = squeeze(mean(theta_ll_tav,1));
clear('theta_ll_tav');

vN_var = ['vN_' run];
vN_cs = load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat',vN_var);
vN_cs = vN_cs.(vN_var);
vN_ll = squeeze(cube2latlon(xc,yc,vN_cs,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_cs','vN_ll','vN_ll_tav')

w_var = ['w_' run];
w_cs = load('/project/rg312/mat_files/snapshot_data/w_snapshots_best.mat',w_var);
w_cs = w_cs.(w_var);
w_cs_half = zeros(192,32,26,720);
w_cs_half(:,:,1:25,:) = w_cs;
rC_half = (100000:-4000:0)';
w_cs_plev = zeros(192,32,25,720);
w_cs_plev = shiftdim(interp1(rC_half,shiftdim(w_cs_half,2),rC),2);
clear('w_cs','w_cs_half')
w_ll = zeros(180,90,25,720);
w_ll = cube2latlon(xc,yc,w_cs_plev,xi,yi);
w_ll_tav = repmat(mean(w_ll,4),[1 1 1 720]);
w_ed_ll = w_ll - w_ll_tav;
clear('w_ll','w_ll_tav','w_cs_plev')


htrt_var = ['htrt_' run];
htrt_cs = load('/project/rg312/mat_files/heat_rates_best.mat',htrt_var);
htrt_cs = htrt_cs.(htrt_var);
htrt_ll = squeeze(cube2latlon(xc,yc,htrt_cs,xi,yi));
htrt_ll_tav = repmat(mean(htrt_ll,4),[1 1 1 719]);
htrt_ed_ll = htrt_ll(:,:,:,1:719) - htrt_ll_tav;
clear('htrt_cs','htrt_ll')

th_var = squeeze(mean(mean(theta_ed_ll(:,:,:,1:719).*theta_ed_ll(:,:,:,1:719),4),1));
qth_ed = squeeze(mean(mean(theta_ed_ll(:,:,:,1:719).*htrt_ed_ll(:,:,:,1:719),4),1));
wth_ed = squeeze(mean(mean(theta_ed_ll(:,:,:,1:719).*w_ed_ll(:,:,:,1:719),4),1));
vth_ed = squeeze(mean(mean(theta_ed_ll(:,:,:,1:719).*vN_ed_ll(:,:,:,1:719),4),1));

radius = 6371.0e3;
[dthdp,dthdy] = gradient(theta_ll_tzav,-4000,pi./90);

dthdy = dthdy./radius;


save(['/project/rg312/mat_files/var_eq_' run '.mat'],'vth_ed', 'dthdy', 'wth_ed', 'dthdp', 'qth_ed','th_var')





