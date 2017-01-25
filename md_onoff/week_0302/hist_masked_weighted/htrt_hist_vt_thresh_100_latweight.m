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

load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat','vN_100')
load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat','t_100')
load('/project/rg312/mat_files/heat_rates.mat','htrt_100','radht_100','difht_100','cndht_100','cnvht_100')
htrt_ll = squeeze(cube2latlon(xc,yc,htrt_100(:,:,5,:),xi,yi)).*86400;
htrt_ll_tav = repmat(mean(htrt_ll,3),[1 1 720]);
htrt_ed_ll = htrt_ll - htrt_ll_tav;
radht_ll = squeeze(cube2latlon(xc,yc,radht_100(:,:,5,:),xi,yi)).*86400;
radht_ll_tav = repmat(mean(radht_ll,3),[1 1 720]);
radht_ed_ll = radht_ll - radht_ll_tav;
difht_ll = squeeze(cube2latlon(xc,yc,difht_100(:,:,5,:),xi,yi)).*86400;
difht_ll_tav = repmat(mean(difht_ll,3),[1 1 720]);
difht_ed_ll = difht_ll - difht_ll_tav;
cndht_ll = squeeze(cube2latlon(xc,yc,cndht_100(:,:,5,:),xi,yi)).*86400;
cndht_ll_tav = repmat(mean(cndht_ll,3),[1 1 720]);
cndht_ed_ll = cndht_ll - cndht_ll_tav;
cnvht_ll = squeeze(cube2latlon(xc,yc,cnvht_100(:,:,5,:),xi,yi)).*86400;
cnvht_ll_tav = repmat(mean(cnvht_ll,3),[1 1 720]);
cnvht_ed_ll = cnvht_ll - cnvht_ll_tav;

t_ll = squeeze(cube2latlon(xc,yc,t_100(:,:,5,:),xi,yi));
t_ll_tav = repmat(mean(t_ll,3),[1 1 720]);
t_ed_ll = t_ll - t_ll_tav;

vN_ll = squeeze(cube2latlon(xc,yc,vN_100(:,:,5,:),xi,yi));
vN_ll_tav = repmat(mean(vN_ll,3),[1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;

vt_ed_ll = t_ed_ll.*vN_ed_ll;
vt_ed_ll(:,1:45,:) = -1.*vt_ed_ll(:,1:45,:);
vt_ed_series_thresh = reshape(vt_ed_ll,[numel(vt_ed_ll),1]);
[vt_dist,vt_val] = hist(vt_ed_series_thresh,100);
vt_sum = cumsum(vt_dist)./sum(vt_dist);
vt_thresh = vt_val(min(find(vt_sum>=0.95)));

for i=1:90

t_ed_series = reshape(t_ed_ll(:,i,:),[numel(t_ed_ll(:,i,:)),1]);
vt_ed_series = reshape(vt_ed_ll(:,i,:),[numel(vt_ed_ll(:,i,:)),1]);
htrt_ed_series = reshape(htrt_ed_ll(:,i,:),[numel(htrt_ed_ll(:,i,:)),1]);
cnvht_ed_series = reshape(cnvht_ed_ll(:,i,:),[numel(cnvht_ed_ll(:,i,:)),1]);
cndht_ed_series = reshape(cndht_ed_ll(:,i,:),[numel(cndht_ed_ll(:,i,:)),1]);
radht_ed_series = reshape(radht_ed_ll(:,i,:),[numel(radht_ed_ll(:,i,:)),1]);
difht_ed_series = reshape(difht_ed_ll(:,i,:),[numel(difht_ed_ll(:,i,:)),1]);

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
[htrt_dist_weight(i,:),htrt_val] = hist(htrt_ed_series_masked,xbins);
[t_dist_weight(i,:),t_val] = hist(t_ed_series_masked,xbins);
[radht_dist_weight(i,:),radht_val] = hist(radht_ed_series_masked,xbins);
[difht_dist_weight(i,:),difht_val] = hist(difht_ed_series_masked,xbins);
[cndht_dist_weight(i,:),cndht_val] = hist(cndht_ed_series_masked,xbins);
[cnvht_dist_weight(i,:),cnvht_val] = hist(cnvht_ed_series_masked,xbins);

htrt_dist_weight(i,:) = htrt_dist_weight(i,:).*cos(yi(i).*pi./180);
t_dist_weight(i,:) = t_dist_weight(i,:).*cos(yi(i).*pi./180);
radht_dist_weight(i,:) = radht_dist_weight(i,:).*cos(yi(i).*pi./180);
difht_dist_weight(i,:) = difht_dist_weight(i,:).*cos(yi(i).*pi./180);
cndht_dist_weight(i,:) = cndht_dist_weight(i,:).*cos(yi(i).*pi./180);
cnvht_dist_weight(i,:) = cnvht_dist_weight(i,:).*cos(yi(i).*pi./180);

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

[htrt_dist_weight_neg(i,:),htrt_val_neg] = hist(htrt_ed_series_masked_neg,xbins);
[t_dist_weight_neg(i,:),t_val_neg] = hist(t_ed_series_masked_neg,xbins);
[radht_dist_weight_neg(i,:),radht_val_neg] = hist(radht_ed_series_masked_neg,xbins);
[difht_dist_weight_neg(i,:),difht_val_neg] = hist(difht_ed_series_masked_neg,xbins);
[cndht_dist_weight_neg(i,:),cndht_val_neg] = hist(cndht_ed_series_masked_neg,xbins);
[cnvht_dist_weight_neg(i,:),cnvht_val_neg] = hist(cnvht_ed_series_masked_neg,xbins);

htrt_dist_weight_neg(i,:) = htrt_dist_weight_neg(i,:).*cos(yi(i).*pi./180);
t_dist_weight_neg(i,:) = t_dist_weight_neg(i,:).*cos(yi(i).*pi./180);
radht_dist_weight_neg(i,:) = radht_dist_weight_neg(i,:).*cos(yi(i).*pi./180);
difht_dist_weight_neg(i,:) = difht_dist_weight_neg(i,:).*cos(yi(i).*pi./180);
cndht_dist_weight_neg(i,:) = cndht_dist_weight_neg(i,:).*cos(yi(i).*pi./180);
cnvht_dist_weight_neg(i,:) = cnvht_dist_weight_neg(i,:).*cos(yi(i).*pi./180);

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

[htrt_dist_weight_pos(i,:),htrt_val_pos] = hist(htrt_ed_series_masked_pos,xbins);
[t_dist_weight_pos(i,:),t_val_pos] = hist(t_ed_series_masked_pos,xbins);
[radht_dist_weight_pos(i,:),radht_val_pos] = hist(radht_ed_series_masked_pos,xbins);
[difht_dist_weight_pos(i,:),difht_val_pos] = hist(difht_ed_series_masked_pos,xbins);
[cndht_dist_weight_pos(i,:),cndht_val_pos] = hist(cndht_ed_series_masked_pos,xbins);
[cnvht_dist_weight_pos(i,:),cnvht_val_pos] = hist(cnvht_ed_series_masked_pos,xbins);

htrt_dist_weight_pos(i,:) = htrt_dist_weight_pos(i,:).*cos(yi(i).*pi./180);
t_dist_weight_pos(i,:) = t_dist_weight_pos(i,:).*cos(yi(i).*pi./180);
radht_dist_weight_pos(i,:) = radht_dist_weight_pos(i,:).*cos(yi(i).*pi./180);
difht_dist_weight_pos(i,:) = difht_dist_weight_pos(i,:).*cos(yi(i).*pi./180);
cndht_dist_weight_pos(i,:) = cndht_dist_weight_pos(i,:).*cos(yi(i).*pi./180);
cnvht_dist_weight_pos(i,:) = cnvht_dist_weight_pos(i,:).*cos(yi(i).*pi./180);

end


htrt_dist = sum(htrt_dist_weight,1);
t_dist = sum(t_dist_weight,1);
radht_dist = sum(radht_dist_weight,1);
difht_dist = sum(difht_dist_weight,1);
cndht_dist = sum(cndht_dist_weight,1);
cnvht_dist = sum(cnvht_dist_weight,1);

htrt_dist_neg = sum(htrt_dist_weight_neg,1);
t_dist_neg = sum(t_dist_weight_neg,1);
radht_dist_neg = sum(radht_dist_weight_neg,1);
difht_dist_neg = sum(difht_dist_weight_neg,1);
cndht_dist_neg = sum(cndht_dist_weight_neg,1);
cnvht_dist_neg = sum(cnvht_dist_weight_neg,1);

htrt_dist_pos = sum(htrt_dist_weight_pos,1);
t_dist_pos = sum(t_dist_weight_pos,1);
radht_dist_pos = sum(radht_dist_weight_pos,1);
difht_dist_pos = sum(difht_dist_weight_pos,1);
cndht_dist_pos = sum(cndht_dist_weight_pos,1);
cnvht_dist_pos = sum(cnvht_dist_weight_pos,1);


figure
plot(t_val,t_dist./sum(t_dist));
set(gca,'FontSize',15)
xlabel('T'', K')
ylabel('Probability')
ylim([0 0.04])
xlim([-20 20])
title('Total T'' distribution')
print('-dpng','t_dist_weight_100.png')

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
print('-dpng','htrt_dist_weight_100.png')

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
print('-dpng','difht_dist_weight_100.png')

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
print('-dpng','cnvht_dist_weight_100.png')

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
print('-dpng','cndht_dist_weight_100.png')

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
print('-dpng','radht_dist_weight_100.png')
