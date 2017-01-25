
rDir='/net/spat-nas/project/rg312/final_runs/run_000_final_noshallow/';
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

load('/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_000_ns/t_000_5.mat')
load('/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_000_ns/t_tzmean.mat');
t_ll_000(:,:,:) = cube2latlon(xc,yc,t_000(:,:,5,:),xi,yi);
clear('t_000')
t_ed_000 = t_ll_000 - repmat(t_ll_ztav(:,:,5),[1 1 360]);
clear('t_ll_000')

load('/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_100/t_100_5.mat')
load('/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_100/t_tzmean.mat');
t_ll_100(:,:,:) = cube2latlon(xc,yc,t_100(:,:,5,:),xi,yi);
clear('t_100')
t_ed_100 = t_ll_100 - repmat(t_ll_ztav(:,:,5),[1 1 360]);
clear('t_ll_100','t_ll_tav')


load('/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_000_ns/vN_000_5.mat')
load('/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_000_ns/vN_tzmean.mat');
vN_ll_000(:,:,:) = cube2latlon(xc,yc,vN_000(:,:,5,:),xi,yi);
clear('vN_000')
vN_ed_000 = vN_ll_000 - repmat(vN_ll_ztav(:,:,5),[1 1 360]);
clear('vN_ll_000')

load('/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_100/vN_100_5.mat')
load('/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_100/vN_tzmean.mat');
vN_ll_100(:,:,:) = cube2latlon(xc,yc,vN_100(:,:,5,:),xi,yi);
clear('vN_100')
vN_ed_100 = vN_ll_100 - repmat(vN_ll_ztav(:,:,5),[1 1 360]);
clear('vN_ll_100','vN_ll_tav')

vNt_ed_000 = vN_ed_000.*t_ed_000;
vNt_ed_100 = vN_ed_100.*t_ed_100;

save('/project/rg312/mat_files/snapshot_data_final/fig2data.mat','vNt_ed_000', 'vNt_ed_100', 't_ed_000', 't_ed_100','vN_ed_000', 'vN_ed_100')


