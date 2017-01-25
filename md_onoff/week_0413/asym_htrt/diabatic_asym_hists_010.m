%load up diabatic heating rates and produce histograms filtered for T' ranges


rDir='/project/rg312/wv_on_rad_off/run_010_best/';
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

%load up 000 snapshots and calculate eddy quantities

load('/project/rg312/mat_files/heat_rates_best.mat','htrt_010')
htrt_010_ll = squeeze(cube2latlon(xc,yc,htrt_010(:,:,5,1:719),xi,yi)).*86400;
htrt_010_ll_tav = repmat(mean(htrt_010_ll,3),[1 1 719]);
htrt_ed_010_ll = htrt_010_ll - htrt_010_ll_tav;
clear('htrt_010')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_010')
t_010_ll = squeeze(cube2latlon(xc,yc,t_010(:,:,5,1:719),xi,yi));
t_010_ll_tav = repmat(mean(t_010_ll,3),[1 1 719]);
t_ed_010_ll = t_010_ll - t_010_ll_tav;
clear('t_010')

htrt_010_skew = skewness(reshape(htrt_ed_010_ll,[numel(htrt_ed_010_ll),1]));

for i=1:90
%include lat weighting too
i
xbins = -45:0.2:45;

htrt_ed_010_counts = hist(reshape(htrt_ed_010_ll,[numel(htrt_ed_010_ll),1]),xbins);
htrt_ed_010_counts_cos(i,:) = htrt_ed_010_counts.*cos(yi(i).*pi./180);

end

htrt_hist = sum(htrt_ed_010_counts_cos,1)./sum(sum(htrt_ed_010_counts_cos));

for i=1:max(size(htrt_hist))
htrt_hist_sym(i) = ( htrt_hist(i) + htrt_hist(max(size(htrt_hist))+1 - i)  )./2;
end

htrt_hist_asym = htrt_hist - htrt_hist_sym;

save('/project/rg312/mat_files/htrt_hists_asym_010.mat')

