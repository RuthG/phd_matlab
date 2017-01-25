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

load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat','vN_075')
load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat','t_075')
load('/project/rg312/mat_files/heat_rates.mat','htrt_075','radht_075','difht_075','cndht_075','cnvht_075')
htrt_ll = squeeze(cube2latlon(xc,yc,htrt_075(:,:,5,:),xi,yi)).*86400;
htrt_ll_tav = repmat(mean(htrt_ll,3),[1 1 720]);
htrt_ed_ll = htrt_ll - htrt_ll_tav;
radht_ll = squeeze(cube2latlon(xc,yc,radht_075(:,:,5,:),xi,yi)).*86400;
radht_ll_tav = repmat(mean(radht_ll,3),[1 1 720]);
radht_ed_ll = radht_ll - radht_ll_tav;
difht_ll = squeeze(cube2latlon(xc,yc,difht_075(:,:,5,:),xi,yi)).*86400;
difht_ll_tav = repmat(mean(difht_ll,3),[1 1 720]);
difht_ed_ll = difht_ll - difht_ll_tav;
cndht_ll = squeeze(cube2latlon(xc,yc,cndht_075(:,:,5,:),xi,yi)).*86400;
cndht_ll_tav = repmat(mean(cndht_ll,3),[1 1 720]);
cndht_ed_ll = cndht_ll - cndht_ll_tav;
cnvht_ll = squeeze(cube2latlon(xc,yc,cnvht_075(:,:,5,:),xi,yi)).*86400;
cnvht_ll_tav = repmat(mean(cnvht_ll,3),[1 1 720]);
cnvht_ed_ll = cnvht_ll - cnvht_ll_tav;

t_ll = squeeze(cube2latlon(xc,yc,t_075(:,:,5,:),xi,yi));
t_ll_tav = repmat(mean(t_ll,3),[1 1 720]);
t_ed_ll = t_ll - t_ll_tav;

vN_ll = squeeze(cube2latlon(xc,yc,vN_075(:,:,5,:),xi,yi));
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
radht_ed_series = reshape(radht_ed_ll,[numel(radht_ed_ll),1]);
cndht_ed_series = reshape(cndht_ed_ll,[numel(cndht_ed_ll),1]);
cnvht_ed_series = reshape(cnvht_ed_ll,[numel(cnvht_ed_ll),1]);
difht_ed_series = reshape(difht_ed_ll,[numel(difht_ed_ll),1]);


%mask series to remove low v't' points (trying to select storms)
vt_mask = +(vt_ed_series_thresh > vt_thresh);
t_neg_mask = +(t_ed_series < 0);
t_pos_mask = +(t_ed_series > 0);

t_ed_series_masked = vt_mask.*t_ed_series;
t_ed_series_masked(vt_mask==0) = [];
htrt_ed_series_masked = vt_mask.*htrt_ed_series;
htrt_ed_series_masked(vt_mask==0) = [];
radht_ed_series_masked = vt_mask.*radht_ed_series;
radht_ed_series_masked(vt_mask==0) = [];
cndht_ed_series_masked = vt_mask.*cndht_ed_series;
cndht_ed_series_masked(vt_mask==0) = [];
cnvht_ed_series_masked = vt_mask.*cnvht_ed_series;
cnvht_ed_series_masked(vt_mask==0) = [];
difht_ed_series_masked = vt_mask.*difht_ed_series;
difht_ed_series_masked(vt_mask==0) = [];
cos_series_masked = vt_mask.*cos_series;
cos_series_masked(vt_mask==0) = [];

t_ed_series_masked_pos = t_pos_mask.*vt_mask.*t_ed_series;
t_ed_series_masked_pos(t_pos_mask.*vt_mask==0) = [];
htrt_ed_series_masked_pos = t_pos_mask.*vt_mask.*htrt_ed_series;
htrt_ed_series_masked_pos(t_pos_mask.*vt_mask==0) = [];
radht_ed_series_masked_pos = t_pos_mask.*vt_mask.*radht_ed_series;
radht_ed_series_masked_pos(t_pos_mask.*vt_mask==0) = [];
cndht_ed_series_masked_pos = t_pos_mask.*vt_mask.*cndht_ed_series;
cndht_ed_series_masked_pos(t_pos_mask.*vt_mask==0) = [];
cnvht_ed_series_masked_pos = t_pos_mask.*vt_mask.*cnvht_ed_series;
cnvht_ed_series_masked_pos(t_pos_mask.*vt_mask==0) = [];
difht_ed_series_masked_pos = t_pos_mask.*vt_mask.*difht_ed_series;
difht_ed_series_masked_pos(t_pos_mask.*vt_mask==0) = [];
cos_series_masked_pos = t_pos_mask.*vt_mask.*cos_series;
cos_series_masked_pos(t_pos_mask.*vt_mask==0) = [];

t_ed_series_masked_neg = t_neg_mask.*vt_mask.*t_ed_series;
t_ed_series_masked_neg(t_neg_mask.*vt_mask==0) = [];
htrt_ed_series_masked_neg = t_neg_mask.*vt_mask.*htrt_ed_series;
htrt_ed_series_masked_neg(t_neg_mask.*vt_mask==0) = [];
radht_ed_series_masked_neg = t_neg_mask.*vt_mask.*radht_ed_series;
radht_ed_series_masked_neg(t_neg_mask.*vt_mask==0) = [];
cndht_ed_series_masked_neg = t_neg_mask.*vt_mask.*cndht_ed_series;
cndht_ed_series_masked_neg(t_neg_mask.*vt_mask==0) = [];
cnvht_ed_series_masked_neg = t_neg_mask.*vt_mask.*cnvht_ed_series;
cnvht_ed_series_masked_neg(t_neg_mask.*vt_mask==0) = [];
difht_ed_series_masked_neg = t_neg_mask.*vt_mask.*difht_ed_series;
difht_ed_series_masked_neg(t_neg_mask.*vt_mask==0) = [];
cos_series_masked_neg = t_neg_mask.*vt_mask.*cos_series;
cos_series_masked_neg(t_neg_mask.*vt_mask==0) = [];

htrtser = htrt_ed_series_masked_neg;
tser = t_ed_series_masked_neg;
m_neg = polyfit(t_ed_series_masked_neg, htrt_ed_series_masked_neg,1);

htrtser = htrt_ed_series_masked_pos;
tser = t_ed_series_masked_pos;
m_pos = polyfit(t_ed_series_masked_pos, htrt_ed_series_masked_pos,1);

radhtser = radht_ed_series_masked_neg;
tser = t_ed_series_masked_neg;
m_neg_radht = polyfit(t_ed_series_masked_neg, radht_ed_series_masked_neg,1);

radhtser = radht_ed_series_masked_pos;
tser = t_ed_series_masked_pos;
m_pos_radht = polyfit(t_ed_series_masked_pos, radht_ed_series_masked_pos,1);

cndhtser = cndht_ed_series_masked_neg;
tser = t_ed_series_masked_neg;
m_neg_cndht = polyfit(t_ed_series_masked_neg, cndht_ed_series_masked_neg,1);

cndhtser = cndht_ed_series_masked_pos;
tser = t_ed_series_masked_pos;
m_pos_cndht = polyfit(t_ed_series_masked_pos, cndht_ed_series_masked_pos,1);

cnvhtser = cnvht_ed_series_masked_neg;
tser = t_ed_series_masked_neg;
m_neg_cnvht = polyfit(t_ed_series_masked_neg, cnvht_ed_series_masked_neg,1);

cnvhtser = cnvht_ed_series_masked_pos;
tser = t_ed_series_masked_pos;
m_pos_cnvht = polyfit(t_ed_series_masked_pos, cnvht_ed_series_masked_pos,1);

difhtser = difht_ed_series_masked_neg;
tser = t_ed_series_masked_neg;
m_neg_difht =  polyfit(t_ed_series_masked_neg, difht_ed_series_masked_neg,1);

difhtser = difht_ed_series_masked_pos;
tser = t_ed_series_masked_pos;
m_pos_difht = polyfit(t_ed_series_masked_pos, difht_ed_series_masked_pos,1);




figure
plot(t_ed_series_masked_neg,htrt_ed_series_masked_neg,'kx')
hold on
plot([-15, 0],[-15,0].*m_neg(1) + m_neg(2),'r')
plot(t_ed_series_masked_pos,htrt_ed_series_masked_pos,'kx')
plot([0, 15],[0,15]*m_pos(1) + m_pos(2),'g')
xlim([-15 15])
ylim([-8 8])
xlabel('T'', K')
ylabel('Eddy diabatic heating, K/day')
print('-dpng','thtrt_fit_075_pfit.png')

figure
plot(t_ed_series_masked_neg,radht_ed_series_masked_neg,'kx')
hold on
plot([-15, 0],[-15,0].*m_neg_radht(1) + m_neg_radht(2),'r')
plot(t_ed_series_masked_pos,radht_ed_series_masked_pos,'kx')
plot([0, 15],[0,15]*m_pos_radht(1) + m_pos_radht(2),'g')
xlim([-15 15])
ylim([-8 8])
xlabel('T'', K')
ylabel('Eddy radiative heating, K/day')
print('-dpng','tradht_fit_075_pfit.png')

figure
plot(t_ed_series_masked_neg,cndht_ed_series_masked_neg,'kx')
hold on
plot([-15, 0],[-15,0].*m_neg_cndht(1) + m_neg_cndht(2),'r')
plot(t_ed_series_masked_pos,cndht_ed_series_masked_pos,'kx')
plot([0, 15],[0,15]*m_pos_cndht(1) + m_pos_cndht(2),'g')
xlim([-15 15])
ylim([-8 8])
xlabel('T'', K')
ylabel('Eddy large-scale latent heating, K/day')
print('-dpng','tcndht_fit_075_pfit.png')

figure
plot(t_ed_series_masked_neg,cnvht_ed_series_masked_neg,'kx')
hold on
plot([-15, 0],[-15,0].*m_neg_cnvht(1) + m_neg_cnvht(2),'r')
plot(t_ed_series_masked_pos,cnvht_ed_series_masked_pos,'kx')
plot([0, 15],[0,15]*m_pos_cnvht(1) + m_pos_cnvht(2),'g')
xlim([-15 15])
ylim([-8 8])
xlabel('T'', K')
ylabel('Eddy convective heating, K/day')
print('-dpng','tcnvht_fit_075_pfit.png')

figure
plot(t_ed_series_masked_neg,difht_ed_series_masked_neg,'kx')
hold on
plot([-15, 0],[-15,0].*m_neg_difht(1) + m_neg_difht(2),'r')
plot(t_ed_series_masked_pos,difht_ed_series_masked_pos,'kx')
plot([0, 15],[0,15]*m_pos_difht(1) + m_pos_difht(2),'g')
xlim([-15 15])
ylim([-8 8])
xlabel('T'', K')
ylabel('Eddy diffusive heating, K/day')
print('-dpng','tdifht_fit_075_pfit.png')

save('/project/rg312/mat_files/damping_grad_075_pfit.mat','m_neg','m_pos','m_neg_radht','m_pos_radht','m_neg_cndht','m_pos_cndht','m_neg_cnvht','m_pos_cnvht','m_neg_difht','m_pos_difht')