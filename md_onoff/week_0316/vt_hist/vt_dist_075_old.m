%plot up histogram of v't' values, and overplot lines of those associated with negative and positive t'


rDir='/project/rg312/wv_on_rad_off/run_075_best/';
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

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_075')
load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_075')

t_ll = squeeze(cube2latlon(xc,yc,t_075(:,:,5,:),xi,yi));
t_ll_tav = repmat(mean(t_ll,3),[1 1 720]);
t_ed_ll = t_ll - t_ll_tav;

vN_ll = squeeze(cube2latlon(xc,yc,vN_075(:,:,5,:),xi,yi));
vN_ll_tav = repmat(mean(vN_ll,3),[1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;

vt_ed_ll = t_ed_ll.*vN_ed_ll;
vt_ed_ll(:,1:45,:) = -1.*vt_ed_ll(:,1:45,:);
vt_ed_series = reshape(vt_ed_ll,[numel(vt_ed_ll),1]);
t_ed_series = reshape(t_ed_ll,[numel(t_ed_ll),1]);

xbins = -300:5:400;
[vt_dist,vt_val] = hist(vt_ed_series,xbins);
vt_sum = cumsum(vt_dist)./sum(vt_dist);
thresh_loc = min(find(vt_sum>=0.95));
vt_thresh = vt_val(thresh_loc);


t_neg_mask = +(t_ed_series < 0);
t_pos_mask = +(t_ed_series > 0);

vt_ed_series_masked_neg = t_neg_mask.*vt_ed_series; 
vt_ed_series_masked_neg(t_neg_mask==0) = [];
[vt_dist_neg,vt_val_neg] = hist(vt_ed_series_masked_neg,xbins);

vt_ed_series_masked_pos = t_pos_mask.*vt_ed_series; 
vt_ed_series_masked_pos(t_pos_mask==0) = [];
[vt_dist_pos,vt_val_pos] = hist(vt_ed_series_masked_pos,xbins);


figure
plot(vt_val,vt_dist./sum(vt_dist));
set(gca,'FontSize',15)
hold on
plot(vt_val_neg,vt_dist_neg./sum(vt_dist),'r');
plot(vt_val_pos,vt_dist_pos./sum(vt_dist),'g');
xlabel('v''T'', Km/s')
ylabel('Probability')
ylim([0 0.7])
xlim([-100 200])
title('v''T'' distribution')
print('-dpng','vt_dist_075.png')


figure
plot(vt_val,vt_dist./sum(vt_dist));
set(gca,'FontSize',15)
hold on
plot(vt_val_neg,vt_dist_neg./sum(vt_dist),'r');
plot(vt_val_pos,vt_dist_pos./sum(vt_dist),'g');
plot([vt_thresh,vt_thresh],[0,0.025],'k--')
xlabel('v''T'', Km/s')
ylabel('Probability')
ylim([0 0.025])
xlim([0 200])
title('v''T'' distribution')
print('-dpng','vt_dist_075_thresh.png')

