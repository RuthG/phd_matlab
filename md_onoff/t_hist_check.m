%try to check Brian's point
%load up a year of data of t and v, for dry and wet, plot histograms for 820hPa and v'T max lat


rDir='/project/rg312/final_runs/run_000_final_noshallow/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
drC=squeeze(rdmds([rDir,'DRC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
xi=-179:2:179;
yi=-89:2:89;

load('/project/rg312/mat_files/vt_lats_final.mat')

t_ed_000 = zeros(180,90,360);
t_ed_100 = zeros(180,90,360);

vN_ed_000 = zeros(180,90,360);
vN_ed_100 = zeros(180,90,360);

load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/t_000_5.mat')
t_ll=cube2latlon(xc,yc,t_000(:,:,5,:),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/t_000_timemean.mat')

load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/vN_000_5.mat')
vN_ll=cube2latlon(xc,yc,vN_000(:,:,5,:),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/vN_000_timemean.mat')

for i=1:360
t_ed_000(:,:,i) = t_ll(:,:,1,i) - t_ll_tav(:,:,5);
vN_ed_000(:,:,i) = vN_ll(:,:,1,i) - vN_ll_tav(:,:,5);
end

load('/project/rg312/mat_files/snapshot_data_final/run_100/t_100_5.mat')
t_ll=cube2latlon(xc,yc,t_100(:,:,5,:),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_100/t_100_timemean.mat')

load('/project/rg312/mat_files/snapshot_data_final/run_100/vN_100_5.mat')
vN_ll=cube2latlon(xc,yc,vN_100(:,:,5,:),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_100/vN_100_timemean.mat')

for i=1:360
t_ed_100(:,:,i) = t_ll(:,:,1,i) - t_ll_tav(:,:,5);
vN_ed_100(:,:,i) = vN_ll(:,:,1,i) - vN_ll_tav(:,:,5);
end


xbins = -40:0.2:40;

t_hist_data_000  = hist(reshape(t_ed_000(:,x000n,:),[numel(t_ed_000(:,x000n,:)),1]),xbins);

t_hist_data_100  = hist(reshape(t_ed_100(:,x100n,:),[numel(t_ed_100(:,x100n,:)),1]),xbins);

xbins = -70:0.5:70;

vN_hist_data_000  = hist(reshape(vN_ed_000(:,x000n,:),[numel(vN_ed_000(:,x000n,:)),1]),xbins);

vN_hist_data_100  = hist(reshape(vN_ed_100(:,x100n,:),[numel(vN_ed_100(:,x100n,:)),1]),xbins);