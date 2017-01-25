%load in v't' data, evaluate how much of the heat transport is driven by percentiles 2, 5, 10



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
ny=90;
xi=-179:2:180;yi=-89:2:90;

load('/project/rg312/mat_files/vt_lats_best.mat')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_100')
load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_100')

t_ll = squeeze(cube2latlon(xc,yc,t_100,xi,yi));
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_100','t_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_100,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_100','vN_ll')

vNt_ed_ll = squeeze(vN_ed_ll(:,:,5,:).*t_ed_ll(:,:,5,:));
vNt_ed_ll(:,1:45,:) = -vNt_ed_ll(:,1:45,:);

clear('vN_ed_ll','t_ed_ll','vN_ll_tav','t_ll_tav');


for i=1:90
%include lat weighting too
i
xbins = -300:5:400;
vNt_ed_counts = hist(reshape(vNt_ed_ll,[numel(vNt_ed_ll),1]),xbins);
vNt_ed_counts_cos(i,:) = vNt_ed_counts.*cos(yi(i).*pi./180);

end

vNt_ed_hist = sum(vNt_ed_counts_cos,1)./sum(sum(vNt_ed_counts_cos));

vNt_curve = cumsum(vNt_ed_hist);

vNt_2per = xbins(min(find(vNt_curve > 0.98)));
vNt_5per = xbins(min(find(vNt_curve > 0.95)));
vNt_10per = xbins(min(find(vNt_curve > 0.9)));

%based on thresholds calculate fraction of total and of poleward transport that is due to each of these

vNt_ed_ll_2per_mask = vNt_ed_ll .* +(vNt_ed_ll >= vNt_2per);
vNt_ed_ll_5per_mask = vNt_ed_ll .* +(vNt_ed_ll >= vNt_5per);
vNt_ed_ll_10per_mask = vNt_ed_ll .* +(vNt_ed_ll >= vNt_10per);
vNt_ed_ll_pos_mask = vNt_ed_ll .* +(vNt_ed_ll > 0);

for i=1:90
i
vNt_ed_ll_2per_int(i,:) = nansum(nansum( vNt_ed_ll_2per_mask(:,i,:) .* cos(yi(i).*pi./180)));
vNt_ed_ll_5per_int(i,:) = nansum(nansum( vNt_ed_ll_5per_mask(:,i,:) .* cos(yi(i).*pi./180)));
vNt_ed_ll_10per_int(i,:) = nansum(nansum( vNt_ed_ll_10per_mask(:,i,:) .* cos(yi(i).*pi./180)));
vNt_ed_ll_pos_int(i,:) = nansum(nansum( vNt_ed_ll_pos_mask(:,i,:) .* cos(yi(i).*pi./180)));
vNt_ed_ll_int(i,:) = nansum(nansum( vNt_ed_ll(:,i,:) .* cos(yi(i).*pi./180)));

end

vNt_ed_ll_2per_tot = nansum(vNt_ed_ll_2per_int);
vNt_ed_ll_5per_tot = nansum(vNt_ed_ll_5per_int);
vNt_ed_ll_10per_tot = nansum(vNt_ed_ll_10per_int);
vNt_ed_ll_pos_tot = nansum(vNt_ed_ll_pos_int);
vNt_ed_ll_tot = nansum(vNt_ed_ll_int);

vNt_2perfrac_whole = vNt_ed_ll_2per_tot./vNt_ed_ll_tot;
vNt_5perfrac_whole = vNt_ed_ll_5per_tot./vNt_ed_ll_tot;
vNt_10perfrac_whole = vNt_ed_ll_10per_tot./vNt_ed_ll_tot;

vNt_2perfrac_pos = vNt_ed_ll_2per_tot./vNt_ed_ll_pos_tot;
vNt_5perfrac_pos = vNt_ed_ll_5per_tot./vNt_ed_ll_pos_tot;
vNt_10perfrac_pos = vNt_ed_ll_10per_tot./vNt_ed_ll_pos_tot;

save('/project/rg312/mat_files/vt_frac_100.mat')
