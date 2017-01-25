
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


load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_125')
load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_125')
load('/project/rg312/mat_files/heat_rates_best.mat','htrt_125','radht_125','difht_125','cndht_125','cnvht_125')
htrt_ll_125 = squeeze(cube2latlon(xc,yc,htrt_125(:,:,5,1:719),xi,yi)).*86400;
htrt_ll_tav_125 = repmat(mean(htrt_ll_125,3),[1 1 719]);
htrt_ed_ll_125 = htrt_ll_125 - htrt_ll_tav_125;
radht_ll_125 = squeeze(cube2latlon(xc,yc,radht_125(:,:,5,1:719),xi,yi)).*86400;
radht_ll_tav_125 = repmat(mean(radht_ll_125,3),[1 1 719]);
radht_ed_ll_125 = radht_ll_125 - radht_ll_tav_125;
difht_ll_125 = squeeze(cube2latlon(xc,yc,difht_125(:,:,5,1:719),xi,yi)).*86400;
difht_ll_tav_125 = repmat(mean(difht_ll_125,3),[1 1 719]);
difht_ed_ll_125 = difht_ll_125 - difht_ll_tav_125;
cndht_ll_125 = squeeze(cube2latlon(xc,yc,cndht_125(:,:,5,1:719),xi,yi)).*86400;
cndht_ll_tav_125 = repmat(mean(cndht_ll_125,3),[1 1 719]);
cndht_ed_ll_125 = cndht_ll_125 - cndht_ll_tav_125;
cnvht_ll_125 = squeeze(cube2latlon(xc,yc,cnvht_125(:,:,5,1:719),xi,yi)).*86400;
cnvht_ll_tav_125 = repmat(mean(cnvht_ll_125,3),[1 1 719]);
cnvht_ed_ll_125 = cnvht_ll_125 - cnvht_ll_tav_125;

t_ll_125 = squeeze(cube2latlon(xc,yc,t_125(:,:,5,1:719),xi,yi));
t_ll_tav_125 = repmat(mean(t_ll_125,3),[1 1 719]);
t_ed_ll_125 = t_ll_125 - t_ll_tav_125;

vN_ll_125 = squeeze(cube2latlon(xc,yc,vN_125(:,:,5,1:719),xi,yi));
vN_ll_tav_125 = repmat(mean(vN_ll_125,3),[1 1 719]);
vN_ed_ll_125 = vN_ll_125 - vN_ll_tav_125;

vt_ed_ll_125 = t_ed_ll_125.*vN_ed_ll_125;
vt_ed_ll_125(:,1:45,:) = -1.*vt_ed_ll_125(:,1:45,:);
vt_ed_series_thresh = reshape(vt_ed_ll_125,[numel(vt_ed_ll_125),1]);
[vt_dist,vt_val] = hist(vt_ed_series_thresh,100);
vt_sum = cumsum(vt_dist)./sum(vt_dist);
vt_thresh_125 = vt_val(min(find(vt_sum>=0.95)));

for i=1:90
clear X

t_ed_series_125 = reshape(t_ed_ll_125(:,i,:),[numel(t_ed_ll_125(:,i,:)),1]);
vt_ed_series_125 = reshape(vt_ed_ll_125(:,i,:),[numel(vt_ed_ll_125(:,i,:)),1]);
htrt_ed_series_125 = reshape(htrt_ed_ll_125(:,i,:),[numel(htrt_ed_ll_125(:,i,:)),1]);
cnvht_ed_series_125 = reshape(cnvht_ed_ll_125(:,i,:),[numel(cnvht_ed_ll_125(:,i,:)),1]);
cndht_ed_series_125 = reshape(cndht_ed_ll_125(:,i,:),[numel(cndht_ed_ll_125(:,i,:)),1]);
radht_ed_series_125 = reshape(radht_ed_ll_125(:,i,:),[numel(radht_ed_ll_125(:,i,:)),1]);
difht_ed_series_125 = reshape(difht_ed_ll_125(:,i,:),[numel(difht_ed_ll_125(:,i,:)),1]);

vt_mask_125 = +(vt_ed_series_125 > vt_thresh_125);

t_ed_series_125_masked = vt_mask_125.*t_ed_series_125; 
t_ed_series_125_masked(vt_mask_125==0) = [];
htrt_ed_series_125_masked = vt_mask_125.*htrt_ed_series_125; 
htrt_ed_series_125_masked(vt_mask_125==0) = [];
cnvht_ed_series_125_masked = vt_mask_125.*cnvht_ed_series_125; 
cnvht_ed_series_125_masked(vt_mask_125==0) = [];
cndht_ed_series_125_masked = vt_mask_125.*cndht_ed_series_125; 
cndht_ed_series_125_masked(vt_mask_125==0) = [];
difht_ed_series_125_masked = vt_mask_125.*difht_ed_series_125; 
difht_ed_series_125_masked(vt_mask_125==0) = [];
radht_ed_series_125_masked = vt_mask_125.*radht_ed_series_125; 
radht_ed_series_125_masked(vt_mask_125==0) = [];

xbins{1} = -30:0.1:30;
xbins{2} = -30:0.1:30;
X(:,1) = t_ed_series_125_masked;
X(:,2) = htrt_ed_series_125_masked;
[thtrt_dist_weighted(i,:,:),C] = hist3(X,xbins);
thtrt_dist_weighted(i,:,:) = thtrt_dist_weighted(i,:,:).*cos(yi(i).*pi./180);

X(:,2) = cnvht_ed_series_125_masked;
[tcnvht_dist_weighted(i,:,:),C] = hist3(X,xbins);
tcnvht_dist_weighted(i,:,:) = tcnvht_dist_weighted(i,:,:).*cos(yi(i).*pi./180);

X(:,2) = cndht_ed_series_125_masked;
[tcndht_dist_weighted(i,:,:),C] = hist3(X,xbins);
tcndht_dist_weighted(i,:,:) = tcndht_dist_weighted(i,:,:).*cos(yi(i).*pi./180);

X(:,2) = difht_ed_series_125_masked;
[tdifht_dist_weighted(i,:,:),C] = hist3(X,xbins);
tdifht_dist_weighted(i,:,:) = tdifht_dist_weighted(i,:,:).*cos(yi(i).*pi./180);

X(:,2) = radht_ed_series_125_masked;
[tradht_dist_weighted(i,:,:),C] = hist3(X,xbins);
tradht_dist_weighted(i,:,:) = tradht_dist_weighted(i,:,:).*cos(yi(i).*pi./180);

end

thtrt_dist = squeeze(sum(thtrt_dist_weighted,1));
tcnvht_dist = squeeze(sum(tcnvht_dist_weighted,1));
tcndht_dist = squeeze(sum(tcndht_dist_weighted,1));
tdifht_dist = squeeze(sum(tdifht_dist_weighted,1));
tradht_dist = squeeze(sum(tradht_dist_weighted,1));

thtrt_masked(1:300,1:601) = thtrt_dist(1:300,1:601);
thtrt_masked(301:601,1:601) = 0;
[thtrt_maxi,thtrt_maxj] = ind2sub(size(thtrt_dist),find(thtrt_masked ==max(max(thtrt_masked))));

tp=C{1};
htrtp=C{2};

line1x = [tp(thtrt_maxi)-100,tp(thtrt_maxi),tp(thtrt_maxi)+100];
line1y = [htrtp(thtrt_maxj)+200,htrtp(thtrt_maxj),htrtp(thtrt_maxj)-200];

line2x = [tp(thtrt_maxi)-100,tp(thtrt_maxi),tp(thtrt_maxi)+100];
line2y = [htrtp(thtrt_maxj)+400,htrtp(thtrt_maxj),htrtp(thtrt_maxj)-400];

line3x = [tp(thtrt_maxi)-100,tp(thtrt_maxi),tp(thtrt_maxi)+100];
line3y = [htrtp(thtrt_maxj)+800,htrtp(thtrt_maxj),htrtp(thtrt_maxj)-800];

figure
h=pcolor(C{1},C{2},thtrt_dist'./sum(sum(thtrt_dist)));
set(h,'EdgeColor','none')
set(gca,'FontSize',15)
hold on
plot(line1x,line1y,'k--')
plot(line2x,line2y,'k--')
plot(line3x,line3y,'k--')
colorbar
colormap(flipud(hot))
ylim([-8 8])
xlim([-8 10])
caxis([0 16e-4])
xlabel('T'', K')
ylabel('Total eddy diabatic heating, K/day')
title('1.25es0')
print('-dpng','t_htrt_hist3_125_masked.png')


return
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
title('0.0es0')
print('-dpng','t_cnvht_hist3_125_masked.png')

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
title('0.0es0')
print('-dpng','t_cndht_hist3_125_masked.png')

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
title('0.0es0')
print('-dpng','t_difht_hist3_125_masked.png')

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
title('0.0es0')
print('-dpng','t_radht_hist3_125_masked.png')


