
function [htrt_hist_data_pos, htrt_hist_data_neg] = htrt_hist_fun(run,year,lev)

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
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
yi = -89:2:89;
xi = -179:2:179;

%load heat rates
t_var = ['t_' run];
htrt_var = ['htrt_' run];

dir = run;
if run == '000'
dir = '000_ns';
end

t_cs = load(['/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_' dir '/t_' run '_' num2str(year) '.mat'],t_var);
t_cs = t_cs.(t_var);
t_ll = cube2latlon(xc,yc,t_cs,xi,yi);
clear('t_cs')
load(['/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_' dir '/t_' run '_timemean.mat']);
t_ed = t_ll - repmat(t_ll_tav,[1 1 1 360]);
clear('t_ll')
t_filter_pos = +(t_ed(:,:,lev,:) > 1);
t_filter_neg = +(t_ed(:,:,lev,:) < -1);
clear('t_ed')

htrt_cs = load(['/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_' dir '/htrt_' run '_' num2str(year) '.mat'],htrt_var);
htrt_cs = htrt_cs.(htrt_var);
htrt_ll = cube2latlon(xc,yc,htrt_cs,xi,yi);
clear('htrt_cs')
load(['/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_' dir '/htrt_' run '_timemean.mat']);
htrt_ed = htrt_ll - repmat(htrt_ll_tav,[1 1 1 360]);
clear('htrt_ll')

htrt_hist_in_pos(:,:,:) = t_filter_pos.*htrt_ed(:,:,lev,:);
htrt_hist_in_neg(:,:,:) = t_filter_neg.*htrt_ed(:,:,lev,:);

for i=1:90
%include lat weighting too

xbins = -40:0.2:40;

htrt_ed_counts_pos = hist(reshape(htrt_hist_in_pos(:,i,:),[numel(htrt_hist_in_pos(:,i,:)),1]),xbins);
htrt_ed_counts_cos_pos(i,:) = htrt_ed_counts_pos.*cos(yi(i).*pi./180);

htrt_ed_counts_neg = hist(reshape(htrt_hist_in_neg(:,i,:),[numel(htrt_hist_in_neg(:,i,:)),1]),xbins);
htrt_ed_counts_cos_neg(i,:) = htrt_ed_counts_neg.*cos(yi(i).*pi./180);

end

htrt_hist_data_pos = sum(htrt_ed_counts_cos_pos,1);
htrt_hist_data_neg = sum(htrt_ed_counts_cos_neg,1);




