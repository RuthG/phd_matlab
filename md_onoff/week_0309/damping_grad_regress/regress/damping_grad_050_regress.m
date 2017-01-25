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

load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat','vN_050')
load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat','t_050')
load('/project/rg312/mat_files/heat_rates.mat','htrt_050','radht_050','difht_050','cndht_050','cnvht_050')
htrt_ll = squeeze(cube2latlon(xc,yc,htrt_050(:,:,5,:),xi,yi)).*86400;
htrt_ll_tav = repmat(mean(htrt_ll,3),[1 1 720]);
htrt_ed_ll = htrt_ll - htrt_ll_tav;
radht_ll = squeeze(cube2latlon(xc,yc,radht_050(:,:,5,:),xi,yi)).*86400;
radht_ll_tav = repmat(mean(radht_ll,3),[1 1 720]);
radht_ed_ll = radht_ll - radht_ll_tav;
difht_ll = squeeze(cube2latlon(xc,yc,difht_050(:,:,5,:),xi,yi)).*86400;
difht_ll_tav = repmat(mean(difht_ll,3),[1 1 720]);
difht_ed_ll = difht_ll - difht_ll_tav;
cndht_ll = squeeze(cube2latlon(xc,yc,cndht_050(:,:,5,:),xi,yi)).*86400;
cndht_ll_tav = repmat(mean(cndht_ll,3),[1 1 720]);
cndht_ed_ll = cndht_ll - cndht_ll_tav;
cnvht_ll = squeeze(cube2latlon(xc,yc,cnvht_050(:,:,5,:),xi,yi)).*86400;
cnvht_ll_tav = repmat(mean(cnvht_ll,3),[1 1 720]);
cnvht_ed_ll = cnvht_ll - cnvht_ll_tav;

t_ll = squeeze(cube2latlon(xc,yc,t_050(:,:,5,:),xi,yi));
t_ll_tav = repmat(mean(t_ll,3),[1 1 720]);
t_ed_ll = t_ll - t_ll_tav;

vN_ll = squeeze(cube2latlon(xc,yc,vN_050(:,:,5,:),xi,yi));
vN_ll_tav = repmat(mean(vN_ll,3),[1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;

%find 95% threshold for v't'
vt_ed_ll = t_ed_ll.*vN_ed_ll;
vt_ed_ll(:,1:45,:) = -1.*vt_ed_ll(:,1:45,:);
vt_ed_series_thresh = reshape(vt_ed_ll,[numel(vt_ed_ll),1]);
[vt_dist,vt_val] = hist(vt_ed_series_thresh,100);
vt_sum = cumsum(vt_dist)./sum(vt_dist);
vt_thresh = vt_val(min(find(vt_sum>=0.95)));

cos_ll = repmat(cos(yi.*pi./180),[180,1,720]);

%make t and htrt into vectors
cos_series = reshape(cos_ll,[numel(cos_ll),1]);
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
cos_series_masked = vt_mask.*cos_series;
cos_series_masked(vt_mask==0) = [];

t_ed_series_masked_pos = t_pos_mask.*vt_mask.*t_ed_series;
t_ed_series_masked_pos(t_pos_mask.*vt_mask==0) = [];
htrt_ed_series_masked_pos = t_pos_mask.*vt_mask.*htrt_ed_series;
htrt_ed_series_masked_pos(t_pos_mask.*vt_mask==0) = [];
cos_series_masked_pos = t_pos_mask.*vt_mask.*cos_series;
cos_series_masked_pos(t_pos_mask.*vt_mask==0) = [];

t_ed_series_masked_neg = t_neg_mask.*vt_mask.*t_ed_series;
t_ed_series_masked_neg(t_neg_mask.*vt_mask==0) = [];
htrt_ed_series_masked_neg = t_neg_mask.*vt_mask.*htrt_ed_series;
htrt_ed_series_masked_neg(t_neg_mask.*vt_mask==0) = [];
cos_series_masked_neg = t_neg_mask.*vt_mask.*cos_series;
cos_series_masked_neg(t_neg_mask.*vt_mask==0) = [];

htrtser = htrt_ed_series_masked_neg;
tser = t_ed_series_masked_neg;
m_neg = regress(htrtser,tser)

%m_neg = fminsearch(@(m_neg) damping_tscale_fun(m_neg,tser,htrtser),[-20,-100])

htrtser = htrt_ed_series_masked_pos;
tser = t_ed_series_masked_pos;
m_pos = regress(htrtser,tser)

%m_pos = fminsearch(@(m_pos) damping_tscale_fun(m_pos,tser,htrtser),[-20,-100])


figure
plot(t_ed_series_masked_neg,htrt_ed_series_masked_neg,'kx')
hold on
plot([-15, 0],[-15,0].*m_neg,'r')
plot(t_ed_series_masked_pos,htrt_ed_series_masked_pos,'kx')
plot([0, 15],[0,15]*m_pos,'g')
xlim([-15 15])
ylim([-8 8])
xlabel('T'', K')
ylabel('Eddy diabatic heating, K/day')
print('-dpng','thtrt_fit_050_regress.png')

save('/project/rg312/mat_files/thtrt_regress_grad_050.mat','m_neg','m_pos')
