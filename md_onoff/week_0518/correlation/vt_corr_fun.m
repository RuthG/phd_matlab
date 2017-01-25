function [corr,vt_ed,t_sd,vN_sd] = vt_corr_fun(v,t)

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


vN_cs = load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best',v);
vN_cs = vN_cs.(v);
vN_ll = squeeze(cube2latlon(xc,yc,vN_cs(:,:,:,1:719),xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 719]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_cs','vN_ll')

t_cs = load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat',t);
t_cs = t_cs.(t);
t_ll = squeeze(cube2latlon(xc,yc,t_cs(:,:,:,1:719),xi,yi));
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 719]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_cs','t_ll')

vN_sd = sqrt(squeeze(mean(mean(vN_ed_ll.^2,1),4)));
t_sd = sqrt(squeeze(mean(mean(t_ed_ll.^2,1),4)));
vt_ed = squeeze(mean(mean(vN_ed_ll.*t_ed_ll,1),4));

corr = vt_ed./t_sd./vN_sd;

end
