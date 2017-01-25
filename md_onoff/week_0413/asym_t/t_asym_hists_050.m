%load up diabatic heating rates and produce histograms filtered for T' ranges


rDir='/project/rg312/wv_on_rad_off/run_050_best/';
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


load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_050')
t_050_ll = squeeze(cube2latlon(xc,yc,t_050(:,:,5,1:719),xi,yi));
t_050_ll_tav = repmat(mean(t_050_ll,3),[1 1 719]);
t_ed_050_ll = t_050_ll - t_050_ll_tav;
clear('t_050')

t_050_skew = skewness(reshape(t_ed_050_ll,[numel(t_ed_050_ll),1]));

for i=1:90
%include lat weighting too
i
xbins = -45:0.2:45;

t_ed_050_counts = hist(reshape(t_ed_050_ll,[numel(t_ed_050_ll),1]),xbins);
t_ed_050_counts_cos(i,:) = t_ed_050_counts.*cos(yi(i).*pi./180);

end

t_hist = sum(t_ed_050_counts_cos,1)./sum(sum(t_ed_050_counts_cos));

for i=1:max(size(t_hist))
t_hist_sym(i) = ( t_hist(i) + t_hist(max(size(t_hist))+1 - i)  )./2;
end

t_hist_asym = t_hist - t_hist_sym;

save('/project/rg312/mat_files/t_hists_asym_050.mat')

