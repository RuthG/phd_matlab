%load in v't' data
%find 95th percentile
%plot histograms of associated t' and htrt'

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

%load up 000 snapshots and calculate eddy quantities

load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat','vN_025')
load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat','t_025')
load('/project/rg312/mat_files/heat_rates.mat','htrt_025','radht_025','difht_025','cndht_025','cnvht_025')
htrt_ll = squeeze(cube2latlon(xc,yc,htrt_025(:,:,5,:),xi,yi)).*86400;
htrt_ll_tav = repmat(mean(htrt_ll,3),[1 1 720]);
htrt_ed_ll = htrt_ll - htrt_ll_tav;
radht_ll = squeeze(cube2latlon(xc,yc,radht_025(:,:,5,:),xi,yi)).*86400;
radht_ll_tav = repmat(mean(radht_ll,3),[1 1 720]);
radht_ed_ll = radht_ll - radht_ll_tav;
difht_ll = squeeze(cube2latlon(xc,yc,difht_025(:,:,5,:),xi,yi)).*86400;
difht_ll_tav = repmat(mean(difht_ll,3),[1 1 720]);
difht_ed_ll = difht_ll - difht_ll_tav;
cndht_ll = squeeze(cube2latlon(xc,yc,cndht_025(:,:,5,:),xi,yi)).*86400;
cndht_ll_tav = repmat(mean(cndht_ll,3),[1 1 720]);
cndht_ed_ll = cndht_ll - cndht_ll_tav;
cnvht_ll = squeeze(cube2latlon(xc,yc,cnvht_025(:,:,5,:),xi,yi)).*86400;
cnvht_ll_tav = repmat(mean(cnvht_ll,3),[1 1 720]);
cnvht_ed_ll = cnvht_ll - cnvht_ll_tav;

t_ll = squeeze(cube2latlon(xc,yc,t_025(:,:,5,:),xi,yi));
t_ll_tav = repmat(mean(t_ll,3),[1 1 720]);
t_ed_ll = t_ll - t_ll_tav;

vN_ll = squeeze(cube2latlon(xc,yc,vN_025(:,:,5,:),xi,yi));
vN_ll_tav = repmat(mean(vN_ll,3),[1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;


vt_ed_ll = t_ed_ll.*vN_ed_ll;
vt_ed_ll(:,1:45,:) = -1.*vt_ed_ll(:,1:45,:);
X = reshape(vt_ed_ll, [1,numel(vt_ed_ll)]);

t_ed_series = reshape(t_ed_ll,[numel(t_ed_ll),1]);
vt_ed_series = reshape(vt_ed_ll,[numel(vt_ed_ll),1]);
htrt_ed_series = reshape(htrt_ed_ll,[numel(htrt_ed_ll),1]);
cnvht_ed_series = reshape(cnvht_ed_ll,[numel(cnvht_ed_ll),1]);
cndht_ed_series = reshape(cndht_ed_ll,[numel(cndht_ed_ll),1]);
radht_ed_series = reshape(radht_ed_ll,[numel(radht_ed_ll),1]);
difht_ed_series = reshape(difht_ed_ll,[numel(difht_ed_ll),1]);

[vt_dist,vt_val] = hist(vt_ed_series,100);
vt_sum = cumsum(vt_dist)./sum(vt_dist);
vt_thresh = vt_val(min(find(vt_sum>=0.95)));
vt_mask = +(vt_ed_series > vt_thresh);

t_neg_mask = +(t_ed_series < 0);
t_pos_mask = +(t_ed_series > 0);

t_ed_series_masked = vt_mask.*t_ed_series; 
t_ed_series_masked(vt_mask==0) = [];
htrt_ed_series_masked = vt_mask.*htrt_ed_series;
htrt_ed_series_masked(vt_mask==0) = [];
cnvht_ed_series_masked = vt_mask.*cnvht_ed_series; 
cnvht_ed_series_masked(vt_mask==0) = [];
cndht_ed_series_masked = vt_mask.*cndht_ed_series; 
cndht_ed_series_masked(vt_mask==0) = [];
radht_ed_series_masked = vt_mask.*radht_ed_series; 
radht_ed_series_masked(vt_mask==0) = [];
difht_ed_series_masked = vt_mask.*difht_ed_series; 
difht_ed_series_masked(vt_mask==0) = [];

xbins = -30:0.1:30;
[htrt_dist,htrt_val] = hist(htrt_ed_series_masked,xbins);
[t_dist,t_val] = hist(t_ed_series_masked,xbins);
[radht_dist,radht_val] = hist(radht_ed_series_masked,xbins);
[difht_dist,difht_val] = hist(difht_ed_series_masked,xbins);
[cndht_dist,cndht_val] = hist(cndht_ed_series_masked,xbins);
[cnvht_dist,cnvht_val] = hist(cnvht_ed_series_masked,xbins);


t_ed_series_masked_neg = vt_mask.*t_ed_series.*t_neg_mask;
t_ed_series_masked_neg(vt_mask.*t_neg_mask==0) = [];
htrt_ed_series_masked_neg = vt_mask.*htrt_ed_series.*t_neg_mask;
htrt_ed_series_masked_neg(vt_mask.*t_neg_mask==0) = [];
cnvht_ed_series_masked_neg = vt_mask.*cnvht_ed_series.*t_neg_mask;
cnvht_ed_series_masked_neg(vt_mask.*t_neg_mask==0) = [];
cndht_ed_series_masked_neg = vt_mask.*cndht_ed_series.*t_neg_mask;
cndht_ed_series_masked_neg(vt_mask.*t_neg_mask==0) = [];
radht_ed_series_masked_neg = vt_mask.*radht_ed_series.*t_neg_mask;
radht_ed_series_masked_neg(vt_mask.*t_neg_mask==0) = [];
difht_ed_series_masked_neg = vt_mask.*difht_ed_series.*t_neg_mask;
difht_ed_series_masked_neg(vt_mask.*t_neg_mask==0) = [];

[htrt_dist_neg,htrt_val_neg] = hist(htrt_ed_series_masked_neg,xbins);
[t_dist_neg,t_val_neg] = hist(t_ed_series_masked_neg,xbins);
[radht_dist_neg,radht_val_neg] = hist(radht_ed_series_masked_neg,xbins);
[difht_dist_neg,difht_val_neg] = hist(difht_ed_series_masked_neg,xbins);
[cndht_dist_neg,cndht_val_neg] = hist(cndht_ed_series_masked_neg,xbins);
[cnvht_dist_neg,cnvht_val_neg] = hist(cnvht_ed_series_masked_neg,xbins);


t_ed_series_masked_pos = vt_mask.*t_ed_series.*t_pos_mask;
t_ed_series_masked_pos(vt_mask.*t_pos_mask==0) = [];
htrt_ed_series_masked_pos = vt_mask.*htrt_ed_series.*t_pos_mask;
htrt_ed_series_masked_pos(vt_mask.*t_pos_mask==0) = [];
cnvht_ed_series_masked_pos = vt_mask.*cnvht_ed_series.*t_pos_mask;
cnvht_ed_series_masked_pos(vt_mask.*t_pos_mask==0) = [];
cndht_ed_series_masked_pos = vt_mask.*cndht_ed_series.*t_pos_mask;
cndht_ed_series_masked_pos(vt_mask.*t_pos_mask==0) = [];
radht_ed_series_masked_pos = vt_mask.*radht_ed_series.*t_pos_mask;
radht_ed_series_masked_pos(vt_mask.*t_pos_mask==0) = [];
difht_ed_series_masked_pos = vt_mask.*difht_ed_series.*t_pos_mask;
difht_ed_series_masked_pos(vt_mask.*t_pos_mask==0) = [];

[htrt_dist_pos,htrt_val_pos] = hist(htrt_ed_series_masked_pos,xbins);
[t_dist_pos,t_val_pos] = hist(t_ed_series_masked_pos,xbins);
[radht_dist_pos,radht_val_pos] = hist(radht_ed_series_masked_pos,xbins);
[difht_dist_pos,difht_val_pos] = hist(difht_ed_series_masked_pos,xbins);
[cndht_dist_pos,cndht_val_pos] = hist(cndht_ed_series_masked_pos,xbins);
[cnvht_dist_pos,cnvht_val_pos] = hist(cnvht_ed_series_masked_pos,xbins);

figure
plot(t_val,t_dist./sum(t_dist));
set(gca,'FontSize',15)
xlabel('T'', K')
ylabel('Probability')
ylim([0 0.04])
xlim([-20 20])
title('Total T'' distribution')
print('-dpng','t_dist_025.png')

figure
plot(htrt_val,htrt_dist./sum(htrt_dist));
set(gca,'FontSize',15)
hold on
plot(htrt_val_neg,htrt_dist_neg./sum(htrt_dist),'r');
plot(htrt_val_pos,htrt_dist_pos./sum(htrt_dist),'g');
xlabel('Heating rate, K/day')
ylabel('Probability')
ylim([0 0.045])
xlim([-20 20])
title('Total diabatic heating distribution')
print('-dpng','htrt_dist_025.png')

figure
plot(difht_val,difht_dist./sum(difht_dist));
set(gca,'FontSize',15)
hold on
plot(difht_val_neg,difht_dist_neg./sum(difht_dist),'r');
plot(difht_val_pos,difht_dist_pos./sum(difht_dist),'g');
xlabel('Heating rate, K/day')
ylabel('Probability')
ylim([0 0.25])
xlim([-20 10])
title('Diffusive heating distribution')
print('-dpng','difht_dist_025.png')

figure
plot(cnvht_val,cnvht_dist./sum(cnvht_dist));
set(gca,'FontSize',15)
hold on
plot(cnvht_val_neg,cnvht_dist_neg./sum(cnvht_dist),'r');
plot(cnvht_val_pos,cnvht_dist_pos./sum(cnvht_dist),'g');
xlabel('Heating rate, K/day')
ylabel('Probability')
ylim([0 0.25])
xlim([-5 15])
title('Convective heating distribution')
print('-dpng','cnvht_dist_025.png')

figure
plot(cndht_val,cndht_dist./sum(cndht_dist));
set(gca,'FontSize',15)
hold on
plot(cndht_val_neg,cndht_dist_neg./sum(cndht_dist),'r');
plot(cndht_val_pos,cndht_dist_pos./sum(cndht_dist),'g');
xlabel('Heating rate, K/day')
ylabel('Probability')
ylim([0 0.12])
xlim([-5 20])
title('Largescale heating distribution')
print('-dpng','cndht_dist_025.png')

figure
plot(radht_val,radht_dist./sum(radht_dist));
set(gca,'FontSize',15)
hold on
plot(radht_val_neg,radht_dist_neg./sum(radht_dist),'r');
plot(radht_val_pos,radht_dist_pos./sum(radht_dist),'g');
xlabel('Heating rate, K/day')
ylabel('Probability')
ylim([0 0.25])
xlim([-5 5])
title('Radiative heating distribution')
print('-dpng','radht_dist_025.png')
