
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


load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat','vN_000')
load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat','t_000')
load('/project/rg312/mat_files/heat_rates.mat','htrt_000')
htrt_ll_000 = squeeze(cube2latlon(xc,yc,htrt_000(:,:,5,:),xi,yi)).*86400;
htrt_ll_tav_000 = repmat(mean(htrt_ll_000,3),[1 1 720]);
htrt_ed_ll_000 = htrt_ll_000 - htrt_ll_tav_000;


t_ll_000 = squeeze(cube2latlon(xc,yc,t_000(:,:,5,:),xi,yi));
t_ll_tav_000 = repmat(mean(t_ll_000,3),[1 1 720]);
t_ed_ll_000 = t_ll_000 - t_ll_tav_000;

vN_ll_000 = squeeze(cube2latlon(xc,yc,vN_000(:,:,5,:),xi,yi));
vN_ll_tav_000 = repmat(mean(vN_ll_000,3),[1 1 720]);
vN_ed_ll_000 = vN_ll_000 - vN_ll_tav_000;

vt_ed_ll_000 = t_ed_ll_000.*vN_ed_ll_000;
vt_ed_ll_000(:,1:45,:) = -1.*vt_ed_ll_000(:,1:45,:);
vt_ed_series_thresh = reshape(vt_ed_ll_000,[numel(vt_ed_ll_000),1]);
[vt_dist,vt_val] = hist(vt_ed_series_thresh,100);
vt_sum = cumsum(vt_dist)./sum(vt_dist);
vt_thresh_000 = vt_val(min(find(vt_sum>=0.95)));

for i=1:90
clear X

t_ed_series_000 = reshape(t_ed_ll_000(:,i,:),[numel(t_ed_ll_000(:,i,:)),1]);
vt_ed_series_000 = reshape(vt_ed_ll_000(:,i,:),[numel(vt_ed_ll_000(:,i,:)),1]);
htrt_ed_series_000 = reshape(htrt_ed_ll_000(:,i,:),[numel(htrt_ed_ll_000(:,i,:)),1]);

vt_mask_000 = +(vt_ed_series_000 > vt_thresh_000);

t_ed_series_000_masked = vt_mask_000.*t_ed_series_000; 
t_ed_series_000_masked(vt_mask_000==0) = [];
htrt_ed_series_000_masked = vt_mask_000.*htrt_ed_series_000; 
htrt_ed_series_000_masked(vt_mask_000==0) = [];


xbins{1} = -30:0.1:30;
xbins{2} = -30:0.1:30;
X(:,1) = t_ed_series_000_masked;
X(:,2) = htrt_ed_series_000_masked;
[thtrt_dist_weighted(i,:,:),C] = hist3(X,xbins);
thtrt_dist_weighted(i,:,:) = thtrt_dist_weighted(i,:,:).*cos(yi(i).*pi./180);

end

thtrt_dist = squeeze(sum(thtrt_dist_weighted,1));
load('/project/rg312/mat_files/thtrt_regress_grad_000.mat')

figure
h=pcolor(C{1},C{2},thtrt_dist'./sum(sum(thtrt_dist)));
set(h,'EdgeColor','none')
set(gca,'FontSize',15)
colorbar
colormap(flipud(hot))
ylim([-8 8])
xlim([-15 15])
hold on
plot([-15, 0],[-15,0].*m_neg,'k')
plot([0, 15],[0,15]*m_pos,'k')
caxis([0 16e-4])
xlabel('T'', K')
ylabel('Total eddy diabatic heating, K/day')
title('0es0')
print('-dpng','t_htrt_hist3_000_masked_regress.png')
