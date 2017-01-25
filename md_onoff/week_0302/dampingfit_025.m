%load in 000 htrt and t data, apply v't' mask, and fit lines to positive and negative regions to get damping coeff
%attempt a weighted version...

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

%find 95% threshold for v't'
vt_ed_ll = t_ed_ll.*vN_ed_ll;
vt_ed_ll(:,1:45,:) = -1.*vt_ed_ll(:,1:45,:);
vt_ed_series_thresh = reshape(vt_ed_ll,[numel(vt_ed_ll),1]);
[vt_dist,vt_val] = hist(vt_ed_series_thresh,100);
vt_sum = cumsum(vt_dist)./sum(vt_dist);
vt_thresh = vt_val(min(find(vt_sum>=0.95)));

%make t and htrt into vectors
t_ed_series = reshape(t_ed_ll,[numel(t_ed_ll),1]);
htrt_ed_series = reshape(htrt_ed_ll,[numel(htrt_ed_ll),1]);

%mask series to remove low v't' points (trying to select storms)
vt_mask = +(vt_ed_series_thresh > vt_thresh);
t_neg_mask = +(t_ed_series < 0);
t_pos_mask = +(t_ed_series > 0);

t_ed_series_masked = vt_mask.*t_ed_series;
t_ed_series_masked(vt_mask==0) = [];
htrt_ed_series_masked = vt_mask.*htrt_ed_series;
htrt_ed_series_masked(vt_mask==0) = [];

t_ed_series_masked_pos = t_pos_mask.*vt_mask.*t_ed_series;
t_ed_series_masked_pos(t_pos_mask.*vt_mask==0) = [];
htrt_ed_series_masked_pos = t_pos_mask.*vt_mask.*htrt_ed_series;
htrt_ed_series_masked_pos(t_pos_mask.*vt_mask==0) = [];

t_ed_series_masked_neg = t_neg_mask.*vt_mask.*t_ed_series;
t_ed_series_masked_neg(t_neg_mask.*vt_mask==0) = [];
htrt_ed_series_masked_neg = t_neg_mask.*vt_mask.*htrt_ed_series;
htrt_ed_series_masked_neg(t_neg_mask.*vt_mask==0) = [];

%use polyfit both ways to get coefficients, try to pick better fit...

thtrt_fit_pos = polyfit(t_ed_series_masked_pos,htrt_ed_series_masked_pos,1);
thtrt_fit_neg = polyfit(t_ed_series_masked_neg,htrt_ed_series_masked_neg,1);

htrtt_fit_pos = polyfit(htrt_ed_series_masked_pos,t_ed_series_masked_pos,1);
htrtt_fit_neg = polyfit(htrt_ed_series_masked_neg,t_ed_series_masked_neg,1);

thtrt_fit_pos_inv(1) = 1./htrtt_fit_pos(1);
thtrt_fit_pos_inv(2) = -htrtt_fit_pos(2)./htrtt_fit_pos(1);

thtrt_fit_neg_inv(1) = 1./htrtt_fit_neg(1);
thtrt_fit_neg_inv(2) = -htrtt_fit_neg(2)./htrtt_fit_neg(1);

figure
plot(t_ed_series_masked,htrt_ed_series_masked,'x')
hold on
plot(t_ed_series_masked_neg,t_ed_series_masked_neg.*thtrt_fit_neg(1) + thtrt_fit_neg(2),'r')
plot(t_ed_series_masked_pos,t_ed_series_masked_pos.*thtrt_fit_pos(1) + thtrt_fit_pos(2),'r')
plot(t_ed_series_masked_neg,t_ed_series_masked_neg.*thtrt_fit_neg_inv(1) + thtrt_fit_neg_inv(2),'g')
plot(t_ed_series_masked_pos,t_ed_series_masked_pos.*thtrt_fit_pos_inv(1) + thtrt_fit_pos_inv(2),'g')
xlim([-15 15])
ylim([-8 8])

save('/project/rg312/mat_files/thtrt_fits_025.mat','thtrt_fit_neg','thtrt_fit_pos','thtrt_fit_neg_inv','thtrt_fit_pos_inv')

