
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


load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_025')
load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_025')
load('/project/rg312/mat_files/heat_rates_best.mat','htrt_025','radht_025','difht_025','cndht_025','cnvht_025')
htrt_ll_025 = squeeze(cube2latlon(xc,yc,htrt_025(:,:,5,1:719),xi,yi)).*86400;
htrt_ll_tav_025 = repmat(mean(htrt_ll_025,3),[1 1 719]);
htrt_ed_ll_025 = htrt_ll_025 - htrt_ll_tav_025;
radht_ll_025 = squeeze(cube2latlon(xc,yc,radht_025(:,:,5,1:719),xi,yi)).*86400;
radht_ll_tav_025 = repmat(mean(radht_ll_025,3),[1 1 719]);
radht_ed_ll_025 = radht_ll_025 - radht_ll_tav_025;
difht_ll_025 = squeeze(cube2latlon(xc,yc,difht_025(:,:,5,1:719),xi,yi)).*86400;
difht_ll_tav_025 = repmat(mean(difht_ll_025,3),[1 1 719]);
difht_ed_ll_025 = difht_ll_025 - difht_ll_tav_025;
cndht_ll_025 = squeeze(cube2latlon(xc,yc,cndht_025(:,:,5,1:719),xi,yi)).*86400;
cndht_ll_tav_025 = repmat(mean(cndht_ll_025,3),[1 1 719]);
cndht_ed_ll_025 = cndht_ll_025 - cndht_ll_tav_025;
cnvht_ll_025 = squeeze(cube2latlon(xc,yc,cnvht_025(:,:,5,1:719),xi,yi)).*86400;
cnvht_ll_tav_025 = repmat(mean(cnvht_ll_025,3),[1 1 719]);
cnvht_ed_ll_025 = cnvht_ll_025 - cnvht_ll_tav_025;

cvdfht_ed_ll_025 = cnvht_ed_ll_025 + difht_ed_ll_025;

t_ll_025 = squeeze(cube2latlon(xc,yc,t_025(:,:,5,1:719),xi,yi));
t_ll_tav_025 = repmat(mean(t_ll_025,3),[1 1 719]);
t_ed_ll_025 = t_ll_025 - t_ll_tav_025;

vN_ll_025 = squeeze(cube2latlon(xc,yc,vN_025(:,:,5,1:719),xi,yi));
vN_ll_tav_025 = repmat(mean(vN_ll_025,3),[1 1 719]);
vN_ed_ll_025 = vN_ll_025 - vN_ll_tav_025;

vt_ed_ll_025 = t_ed_ll_025.*vN_ed_ll_025;
vt_ed_ll_025(:,1:45,:) = -1.*vt_ed_ll_025(:,1:45,:);
vt_ed_series_thresh = reshape(vt_ed_ll_025,[numel(vt_ed_ll_025),1]);
[vt_dist,vt_val] = hist(vt_ed_series_thresh,100);
vt_sum = cumsum(vt_dist)./sum(vt_dist);
vt_thresh_025 = vt_val(min(find(vt_sum>=0.95)));

for i=1:90
clear X

t_ed_series_025 = reshape(t_ed_ll_025(:,i,:),[numel(t_ed_ll_025(:,i,:)),1]);
vt_ed_series_025 = reshape(vt_ed_ll_025(:,i,:),[numel(vt_ed_ll_025(:,i,:)),1]);
htrt_ed_series_025 = reshape(htrt_ed_ll_025(:,i,:),[numel(htrt_ed_ll_025(:,i,:)),1]);
cnvht_ed_series_025 = reshape(cnvht_ed_ll_025(:,i,:),[numel(cnvht_ed_ll_025(:,i,:)),1]);
cndht_ed_series_025 = reshape(cndht_ed_ll_025(:,i,:),[numel(cndht_ed_ll_025(:,i,:)),1]);
radht_ed_series_025 = reshape(radht_ed_ll_025(:,i,:),[numel(radht_ed_ll_025(:,i,:)),1]);
difht_ed_series_025 = reshape(difht_ed_ll_025(:,i,:),[numel(difht_ed_ll_025(:,i,:)),1]);
cvdfht_ed_series_025 = reshape(cvdfht_ed_ll_025(:,i,:),[numel(cvdfht_ed_ll_025(:,i,:)),1]);

vt_mask_025 = +(vt_ed_series_025 > vt_thresh_025);

t_ed_series_025_masked = vt_mask_025.*t_ed_series_025; 
t_ed_series_025_masked(vt_mask_025==0) = [];
htrt_ed_series_025_masked = vt_mask_025.*htrt_ed_series_025; 
htrt_ed_series_025_masked(vt_mask_025==0) = [];
cnvht_ed_series_025_masked = vt_mask_025.*cnvht_ed_series_025; 
cnvht_ed_series_025_masked(vt_mask_025==0) = [];
cndht_ed_series_025_masked = vt_mask_025.*cndht_ed_series_025; 
cndht_ed_series_025_masked(vt_mask_025==0) = [];
difht_ed_series_025_masked = vt_mask_025.*difht_ed_series_025; 
difht_ed_series_025_masked(vt_mask_025==0) = [];
radht_ed_series_025_masked = vt_mask_025.*radht_ed_series_025; 
radht_ed_series_025_masked(vt_mask_025==0) = [];
cvdfht_ed_series_025_masked = vt_mask_025.*cvdfht_ed_series_025; 
cvdfht_ed_series_025_masked(vt_mask_025==0) = [];

xbins{1} = -30:0.1:30;
xbins{2} = -30:0.1:30;
X(:,1) = t_ed_series_025_masked;
X(:,2) = htrt_ed_series_025_masked;
[thtrt_dist_weighted(i,:,:),C] = hist3(X,xbins);
thtrt_dist_weighted(i,:,:) = thtrt_dist_weighted(i,:,:).*cos(yi(i).*pi./180);

X(:,2) = cnvht_ed_series_025_masked;
[tcnvht_dist_weighted(i,:,:),C] = hist3(X,xbins);
tcnvht_dist_weighted(i,:,:) = tcnvht_dist_weighted(i,:,:).*cos(yi(i).*pi./180);

X(:,2) = cndht_ed_series_025_masked;
[tcndht_dist_weighted(i,:,:),C] = hist3(X,xbins);
tcndht_dist_weighted(i,:,:) = tcndht_dist_weighted(i,:,:).*cos(yi(i).*pi./180);

X(:,2) = difht_ed_series_025_masked;
[tdifht_dist_weighted(i,:,:),C] = hist3(X,xbins);
tdifht_dist_weighted(i,:,:) = tdifht_dist_weighted(i,:,:).*cos(yi(i).*pi./180);

X(:,2) = radht_ed_series_025_masked;
[tradht_dist_weighted(i,:,:),C] = hist3(X,xbins);
tradht_dist_weighted(i,:,:) = tradht_dist_weighted(i,:,:).*cos(yi(i).*pi./180);

X(:,2) = cvdfht_ed_series_025_masked;
[tcvdfht_dist_weighted(i,:,:),C] = hist3(X,xbins);
tcvdfht_dist_weighted(i,:,:) = tcvdfht_dist_weighted(i,:,:).*cos(yi(i).*pi./180);

end

thtrt_dist = squeeze(sum(thtrt_dist_weighted,1));
tcnvht_dist = squeeze(sum(tcnvht_dist_weighted,1));
tcndht_dist = squeeze(sum(tcndht_dist_weighted,1));
tdifht_dist = squeeze(sum(tdifht_dist_weighted,1));
tradht_dist = squeeze(sum(tradht_dist_weighted,1));
tcvdfht_dist = squeeze(sum(tcvdfht_dist_weighted,1));

load('/project/rg312/mat_files/damping_grad_025_0intregress_best.mat')

figure
h=pcolor(C{1},C{2},thtrt_dist'./sum(sum(thtrt_dist)));
set(h,'EdgeColor','none')
set(gca,'FontSize',15)
hold on
plot([-15, 0],[-15,0].*m_neg,'k')
plot([0, 15],[0,15]*m_pos,'k')
colorbar
colormap(flipud(hot))
ylim([-8 8])
xlim([-15 15])
caxis([0 16e-4])
xlabel('T'', K')
ylabel('Total eddy diabatic heating, K/day')
title('0.25es0')
print('-dpng','t_htrt_hist3_025_masked.png')

figure
h=pcolor(C{1},C{2},tcnvht_dist'./sum(sum(tcnvht_dist)));
set(h,'EdgeColor','none')
set(gca,'FontSize',15)
hold on
plot([-15, 0],[-15,0].*m_neg_cnvht,'k')
plot([0, 15],[0,15]*m_pos_cnvht,'k')
colorbar
colormap(flipud(hot))
ylim([-8 8])
xlim([-15 15])
caxis([0 0.01])
xlabel('T'', K')
ylabel('Total eddy convective heating, K/day')
title('0.25es0')
print('-dpng','t_cnvht_hist3_025_masked.png')

figure
h=pcolor(C{1},C{2},tcndht_dist'./sum(sum(tcndht_dist)));
set(h,'EdgeColor','none')
set(gca,'FontSize',15)
hold on
plot([-15, 0],[-15,0].*m_neg_cndht,'k')
plot([0, 15],[0,15]*m_pos_cndht,'k')
colorbar
colormap(flipud(hot))
ylim([-8 8])
xlim([-15 15])
caxis([0 0.005])
xlabel('T'', K')
ylabel('Total eddy largescale heating, K/day')
title('0.25es0')
print('-dpng','t_cndht_hist3_025_masked.png')

figure
h=pcolor(C{1},C{2},tdifht_dist'./sum(sum(tdifht_dist)));
set(h,'EdgeColor','none')
set(gca,'FontSize',15)
hold on
plot([-15, 0],[-15,0].*m_neg_difht,'k')
plot([0, 15],[0,15]*m_pos_difht,'k')
colorbar
colormap(flipud(hot))
ylim([-8 8])
xlim([-15 15])
caxis([0 6e-3])
xlabel('T'', K')
ylabel('Total eddy diffusive heating, K/day')
title('0.25es0')
print('-dpng','t_difht_hist3_025_masked.png')

figure
h=pcolor(C{1},C{2},tradht_dist'./sum(sum(tradht_dist)));
set(h,'EdgeColor','none')
set(gca,'FontSize',15)
hold on
plot([-15, 0],[-15,0].*m_neg_radht,'k')
plot([0, 15],[0,15]*m_pos_radht,'k')
colorbar
colormap(flipud(hot))
ylim([-8 8])
xlim([-15 15])
caxis([0 0.02])
xlabel('T'', K')
ylabel('Total eddy radiative heating, K/day')
title('0.25es0')
print('-dpng','t_radht_hist3_025_masked.png')


figure
h=pcolor(C{1},C{2},tcvdfht_dist'./sum(sum(tcvdfht_dist)));
set(h,'EdgeColor','none')
set(gca,'FontSize',15)
hold on
plot([-15, 0],[-15,0].*m_neg_cvdfht,'k')
plot([0, 15],[0,15]*m_pos_cvdfht,'k')
colorbar
colormap(flipud(hot))
ylim([-8 8])
xlim([-15 15])
caxis([0 0.002])
xlabel('T'', K')
ylabel('Total eddy diffusive + convective heating, K/day')
title('0.25es0')
print('-dpng','t_cvdfht_hist3_025_masked.png')
