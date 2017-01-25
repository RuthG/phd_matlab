
rDir='/project/rg312/wv_on_rad_off/run_doshallower00/';
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

load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat','t_010')
load('/project/rg312/mat_files/heat_rates.mat','htrt_010','radht_010','difht_010','cndht_010','cnvht_010')
htrt_ll_010 = squeeze(cube2latlon(xc,yc,htrt_010(:,:,5,:),xi,yi)).*86400;
htrt_ll_tav_010 = repmat(mean(htrt_ll_010,3),[1 1 720]);
htrt_ed_ll_010 = htrt_ll_010 - htrt_ll_tav_010;
radht_ll_010 = squeeze(cube2latlon(xc,yc,radht_010(:,:,5,:),xi,yi)).*86400;
radht_ll_tav_010 = repmat(mean(radht_ll_010,3),[1 1 720]);
radht_ed_ll_010 = radht_ll_010 - radht_ll_tav_010;
difht_ll_010 = squeeze(cube2latlon(xc,yc,difht_010(:,:,5,:),xi,yi)).*86400;
difht_ll_tav_010 = repmat(mean(difht_ll_010,3),[1 1 720]);
difht_ed_ll_010 = difht_ll_010 - difht_ll_tav_010;
cndht_ll_010 = squeeze(cube2latlon(xc,yc,cndht_010(:,:,5,:),xi,yi)).*86400;
cndht_ll_tav_010 = repmat(mean(cndht_ll_010,3),[1 1 720]);
cndht_ed_ll_010 = cndht_ll_010 - cndht_ll_tav_010;
cnvht_ll_010 = squeeze(cube2latlon(xc,yc,cnvht_010(:,:,5,:),xi,yi)).*86400;
cnvht_ll_tav_010 = repmat(mean(cnvht_ll_010,3),[1 1 720]);
cnvht_ed_ll_010 = cnvht_ll_010 - cnvht_ll_tav_010;

t_ll_010 = squeeze(cube2latlon(xc,yc,t_010(:,:,5,:),xi,yi));
t_ll_tav_010 = repmat(mean(t_ll_010,3),[1 1 720]);
t_ed_ll_010 = t_ll_010 - t_ll_tav_010;

t_ed_series_thresh = reshape(t_ed_ll_010,[numel(t_ed_ll_010),1]);
[t_dist,t_val] = hist(t_ed_series_thresh,100);
t_sum = cumsum(t_dist)./sum(t_dist);
t_thresh_010_pos = t_val(min(find(t_sum>=0.95)));
t_thresh_010_neg = t_val(max(find(t_sum<=0.05)));

for i=1:90
clear X

t_ed_series_010 = reshape(t_ed_ll_010(:,i,:),[numel(t_ed_ll_010(:,i,:)),1]);
htrt_ed_series_010 = reshape(htrt_ed_ll_010(:,i,:),[numel(htrt_ed_ll_010(:,i,:)),1]);
cnvht_ed_series_010 = reshape(cnvht_ed_ll_010(:,i,:),[numel(cnvht_ed_ll_010(:,i,:)),1]);
cndht_ed_series_010 = reshape(cndht_ed_ll_010(:,i,:),[numel(cndht_ed_ll_010(:,i,:)),1]);
radht_ed_series_010 = reshape(radht_ed_ll_010(:,i,:),[numel(radht_ed_ll_010(:,i,:)),1]);
difht_ed_series_010 = reshape(difht_ed_ll_010(:,i,:),[numel(difht_ed_ll_010(:,i,:)),1]);

t_mask_010 = +(t_ed_series_010 > t_thresh_010_pos | t_ed_series_010 < t_thresh_010_neg);

t_ed_series_010_masked = t_mask_010.*t_ed_series_010; 
t_ed_series_010_masked(t_mask_010==0) = [];
htrt_ed_series_010_masked = t_mask_010.*htrt_ed_series_010; 
htrt_ed_series_010_masked(t_mask_010==0) = [];
cnvht_ed_series_010_masked = t_mask_010.*cnvht_ed_series_010; 
cnvht_ed_series_010_masked(t_mask_010==0) = [];
cndht_ed_series_010_masked = t_mask_010.*cndht_ed_series_010; 
cndht_ed_series_010_masked(t_mask_010==0) = [];
difht_ed_series_010_masked = t_mask_010.*difht_ed_series_010; 
difht_ed_series_010_masked(t_mask_010==0) = [];
radht_ed_series_010_masked = t_mask_010.*radht_ed_series_010; 
radht_ed_series_010_masked(t_mask_010==0) = [];

xbins{1} = -30:0.1:30;
xbins{2} = -30:0.1:30;
X(:,1) = t_ed_series_010_masked;
X(:,2) = htrt_ed_series_010_masked;
[thtrt_dist_weighted(i,:,:),C] = hist3(X,xbins);
thtrt_dist_weighted(i,:,:) = thtrt_dist_weighted(i,:,:).*cos(yi(i).*pi./180);

X(:,2) = cnvht_ed_series_010_masked;
[tcnvht_dist_weighted(i,:,:),C] = hist3(X,xbins);
tcnvht_dist_weighted(i,:,:) = tcnvht_dist_weighted(i,:,:).*cos(yi(i).*pi./180);

X(:,2) = cndht_ed_series_010_masked;
[tcndht_dist_weighted(i,:,:),C] = hist3(X,xbins);
tcndht_dist_weighted(i,:,:) = tcndht_dist_weighted(i,:,:).*cos(yi(i).*pi./180);

X(:,2) = difht_ed_series_010_masked;
[tdifht_dist_weighted(i,:,:),C] = hist3(X,xbins);
tdifht_dist_weighted(i,:,:) = tdifht_dist_weighted(i,:,:).*cos(yi(i).*pi./180);

X(:,2) = radht_ed_series_010_masked;
[tradht_dist_weighted(i,:,:),C] = hist3(X,xbins);
tradht_dist_weighted(i,:,:) = tradht_dist_weighted(i,:,:).*cos(yi(i).*pi./180);

end

thtrt_dist = squeeze(sum(thtrt_dist_weighted,1));
tcnvht_dist = squeeze(sum(tcnvht_dist_weighted,1));
tcndht_dist = squeeze(sum(tcndht_dist_weighted,1));
tdifht_dist = squeeze(sum(tdifht_dist_weighted,1));
tradht_dist = squeeze(sum(tradht_dist_weighted,1));


figure
h=pcolor(C{1},C{2},thtrt_dist'./sum(sum(thtrt_dist)));
set(h,'EdgeColor','none')
set(gca,'FontSize',15)
colorbar
colormap(flipud(hot))
ylim([-8 8])
xlim([-15 15])
caxis([0 16e-4])
xlabel('T'', K')
ylabel('Total eddy diabatic heating, K/day')
title('0.1es0')
print('-dpng','t_htrt_hist3_010_masked.png')

figure
h=pcolor(C{1},C{2},tcnvht_dist'./sum(sum(tcnvht_dist)));
set(h,'EdgeColor','none')
set(gca,'FontSize',15)
colorbar
colormap(flipud(hot))
ylim([-8 8])
xlim([-15 15])
caxis([0 0.01])
xlabel('T'', K')
ylabel('Total eddy convective heating, K/day')
title('0.1es0')
print('-dpng','t_cnvht_hist3_010_masked.png')

figure
h=pcolor(C{1},C{2},tcndht_dist'./sum(sum(tcndht_dist)));
set(h,'EdgeColor','none')
set(gca,'FontSize',15)
colorbar
colormap(flipud(hot))
ylim([-8 8])
xlim([-15 15])
caxis([0 0.005])
xlabel('T'', K')
ylabel('Total eddy largescale heating, K/day')
title('0.1es0')
print('-dpng','t_cndht_hist3_010_masked.png')

figure
h=pcolor(C{1},C{2},tdifht_dist'./sum(sum(tdifht_dist)));
set(h,'EdgeColor','none')
set(gca,'FontSize',15)
colorbar
colormap(flipud(hot))
ylim([-8 8])
xlim([-15 15])
caxis([0 6e-3])
xlabel('T'', K')
ylabel('Total eddy diffusive heating, K/day')
title('0.1es0')
print('-dpng','t_difht_hist3_010_masked.png')

figure
h=pcolor(C{1},C{2},tradht_dist'./sum(sum(tradht_dist)));
set(h,'EdgeColor','none')
set(gca,'FontSize',15)
colorbar
colormap(flipud(hot))
ylim([-8 8])
xlim([-15 15])
caxis([0 0.02])
xlabel('T'', K')
ylabel('Total eddy radiative heating, K/day')
title('0.1es0')
print('-dpng','t_radht_hist3_010_masked.png')


