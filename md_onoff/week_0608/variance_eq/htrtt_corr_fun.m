function [corr,htrtt_ed,th_sd,htrt_sd] = htrtt_corr_fun(htrt,th)

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
yi = -89:2:89;
xi = -179:2:179;


htrt_cs = load('/project/rg312/mat_files/heat_rates_best.mat',htrt);
htrt_cs = htrt_cs.(htrt);
htrt_ll = squeeze(cube2latlon(xc,yc,htrt_cs(:,:,:,1:719),xi,yi));
htrt_ll_tav = repmat(mean(htrt_ll,4),[1 1 1 719]);
htrt_ed_ll = htrt_ll - htrt_ll_tav;
clear('htrt_cs','htrt_ll')

th_cs = load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat',th);
th_cs = th_cs.(th);
th_ll = squeeze(cube2latlon(xc,yc,th_cs(:,:,:,1:719),xi,yi));
th_ll_tav = repmat(mean(th_ll,4),[1 1 1 719]);
th_ed_ll = th_ll - th_ll_tav;
clear('th_cs','th_ll')


htrt_sd = sqrt(squeeze(mean(mean(htrt_ed_ll.^2,1),4)));
th_sd = sqrt(squeeze(mean(mean(th_ed_ll.^2,1),4)));
htrtt_ed = squeeze(mean(mean(htrt_ed_ll.*th_ed_ll,1),4));

corr = htrtt_ed./th_sd./htrt_sd;

end
