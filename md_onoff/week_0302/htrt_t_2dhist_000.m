
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
load('/project/rg312/mat_files/heat_rates.mat','htrt_000','radht_000','difht_000','cndht_000','cnvht_000')
htrt_ll_000 = squeeze(cube2latlon(xc,yc,htrt_000(:,:,5,:),xi,yi)).*86400;
htrt_ll_tav_000 = repmat(mean(htrt_ll_000,3),[1 1 720]);
htrt_ed_ll_000 = htrt_ll_000 - htrt_ll_tav_000;
radht_ll_000 = squeeze(cube2latlon(xc,yc,radht_000(:,:,5,:),xi,yi)).*86400;
radht_ll_tav_000 = repmat(mean(radht_ll_000,3),[1 1 720]);
radht_ed_ll_000 = radht_ll_000 - radht_ll_tav_000;
difht_ll_000 = squeeze(cube2latlon(xc,yc,difht_000(:,:,5,:),xi,yi)).*86400;
difht_ll_tav_000 = repmat(mean(difht_ll_000,3),[1 1 720]);
difht_ed_ll_000 = difht_ll_000 - difht_ll_tav_000;
cndht_ll_000 = squeeze(cube2latlon(xc,yc,cndht_000(:,:,5,:),xi,yi)).*86400;
cndht_ll_tav_000 = repmat(mean(cndht_ll_000,3),[1 1 720]);
cndht_ed_ll_000 = cndht_ll_000 - cndht_ll_tav_000;
cnvht_ll_000 = squeeze(cube2latlon(xc,yc,cnvht_000(:,:,5,:),xi,yi)).*86400;
cnvht_ll_tav_000 = repmat(mean(cnvht_ll_000,3),[1 1 720]);
cnvht_ed_ll_000 = cnvht_ll_000 - cnvht_ll_tav_000;

t_ll_000 = squeeze(cube2latlon(xc,yc,t_000(:,:,5,:),xi,yi));
t_ll_tav_000 = repmat(mean(t_ll_000,3),[1 1 720]);
t_ed_ll_000 = t_ll_000 - t_ll_tav_000;

vN_ll_000 = squeeze(cube2latlon(xc,yc,vN_000(:,:,5,:),xi,yi));
vN_ll_tav_000 = repmat(mean(vN_ll_000,3),[1 1 720]);
vN_ed_ll_000 = vN_ll_000 - vN_ll_tav_000;

vt_ed_ll_000 = t_ed_ll_000.*vN_ed_ll_000;
vt_ed_ll_000(:,1:45,:) = -1.*vt_ed_ll_000(:,1:45,:);

t_ed_series_000 = reshape(t_ed_ll_000,[numel(t_ed_ll_000),1]);
vt_ed_series_000 = reshape(vt_ed_ll_000,[numel(vt_ed_ll_000),1]);
htrt_ed_series_000 = reshape(htrt_ed_ll_000,[numel(htrt_ed_ll_000),1]);
cnvht_ed_series_000 = reshape(cnvht_ed_ll_000,[numel(cnvht_ed_ll_000),1]);
cndht_ed_series_000 = reshape(cndht_ed_ll_000,[numel(cndht_ed_ll_000),1]);
radht_ed_series_000 = reshape(radht_ed_ll_000,[numel(radht_ed_ll_000),1]);
difht_ed_series_000 = reshape(difht_ed_ll_000,[numel(difht_ed_ll_000),1]);

xbins{1} = -30:0.1:30;
xbins{2} = -30:0.1:30;
X(:,1) = t_ed_series_000;

figure
X(:,2) = htrt_ed_series_000;
[N,C] = hist3(X,xbins);
h=pcolor(C{1},C{2},N./sum(sum(N)));
set(h,'EdgeColor','none')
set(gca,'FontSize',15)
colorbar
colormap(flipud(hot))
xlim([-8 8])
ylim([-15 15])
caxis([0 16e-4])
xlabel('T'', K')
ylabel('Total eddy diabatic heating, K/day')
title('0es0')
print('-dpng','t_htrt_hist3_000.png')

figure
X(:,2) = cnvht_ed_series_000;
[N,C] = hist3(X,xbins);
h=pcolor(C{1},C{2},N./sum(sum(N)));
set(h,'EdgeColor','none')
set(gca,'FontSize',15)
colorbar
colormap(flipud(hot))
xlim([-8 8])
ylim([-15 15])
caxis([0 0.01])
xlabel('T'', K')
ylabel('Total eddy convective heating, K/day')
title('0es0')
print('-dpng','t_cnvht_hist3_000.png')

figure
X(:,2) = cndht_ed_series_000;
[N,C] = hist3(X,xbins);
h=pcolor(C{1},C{2},N./sum(sum(N)));
set(h,'EdgeColor','none')
set(gca,'FontSize',15)
colorbar
colormap(flipud(hot))
xlim([-8 8])
ylim([-15 15])
caxis([0 0.005])
xlabel('T'', K')
ylabel('Total eddy largescale heating, K/day')
title('0es0')
print('-dpng','t_cndht_hist3_000.png')

figure
X(:,2) = difht_ed_series_000;
[N,C] = hist3(X,xbins);
h=pcolor(C{1},C{2},N./sum(sum(N)));
set(h,'EdgeColor','none')
set(gca,'FontSize',15)
colorbar
colormap(flipud(hot))
xlim([-8 8])
ylim([-15 15])
caxis([0 6e-3])
xlabel('T'', K')
ylabel('Total eddy diffusive heating, K/day')
title('0es0')
print('-dpng','t_difht_hist3_000.png')

figure
X(:,2) = radht_ed_series_000;
[N,C] = hist3(X,xbins);
h=pcolor(C{1},C{2},N./sum(sum(N)));
set(h,'EdgeColor','none')
set(gca,'FontSize',15)
colorbar
colormap(flipud(hot))
xlim([-8 8])
ylim([-15 15])
caxis([0 0.02])
xlabel('T'', K')
ylabel('Total eddy radiative heating, K/day')
title('0es0')
print('-dpng','t_radht_hist3_000.png')

clear X 


[vt_dist_000,vt_val_000] = hist(vt_ed_series_000,100);
vt_sum_000 = cumsum(vt_dist_000)./sum(vt_dist_000);
vt_thresh_000 = vt_val_000(min(find(vt_sum_000>=0.95)));
vt_mask_000 = +(vt_ed_series_000 > vt_thresh_000);

t_ed_series_000_masked = vt_mask_000.*t_ed_series_000; 
t_ed_series_000_masked(vt_mask_000==0) = [];
htrt_ed_series_000_masked = vt_mask_000.*htrt_ed_series_000; 
htrt_ed_series_000_masked(vt_mask_000==0) = [];
cnvht_ed_series_000_masked = vt_mask_000.*cnvht_ed_series_000; 
cnvht_ed_series_000_masked(vt_mask_000==0) = [];
cndht_ed_series_000_masked = vt_mask_000.*cndht_ed_series_000; 
cndht_ed_series_000_masked(vt_mask_000==0) = [];
difht_ed_series_000_masked = vt_mask_000.*difht_ed_series_000; 
difht_ed_series_000_masked(vt_mask_000==0) = [];
radht_ed_series_000_masked = vt_mask_000.*radht_ed_series_000; 
radht_ed_series_000_masked(vt_mask_000==0) = [];

xbins{1} = -30:0.1:30;
xbins{2} = -30:0.1:30;
X(:,1) = t_ed_series_000_masked;

figure
X(:,2) = htrt_ed_series_000_masked;
[N,C] = hist3(X,xbins);
h=pcolor(C{1},C{2},N./sum(sum(N)));
set(h,'EdgeColor','none')
set(gca,'FontSize',15)
colorbar
colormap(flipud(hot))
xlim([-8 8])
ylim([-15 15])
caxis([0 16e-4])
xlabel('T'', K')
ylabel('Total eddy diabatic heating, K/day')
title('0es0')
print('-dpng','t_htrt_hist3_000_masked.png')

figure
X(:,2) = cnvht_ed_series_000_masked;
[N,C] = hist3(X,xbins);
h=pcolor(C{1},C{2},N./sum(sum(N)));
set(h,'EdgeColor','none')
set(gca,'FontSize',15)
colorbar
colormap(flipud(hot))
xlim([-8 8])
ylim([-15 15])
caxis([0 0.01])
xlabel('T'', K')
ylabel('Total eddy convective heating, K/day')
title('0es0')
print('-dpng','t_cnvht_hist3_000_masked.png')

figure
X(:,2) = cndht_ed_series_000_masked;
[N,C] = hist3(X,xbins);
h=pcolor(C{1},C{2},N./sum(sum(N)));
set(h,'EdgeColor','none')
set(gca,'FontSize',15)
colorbar
colormap(flipud(hot))
xlim([-8 8])
ylim([-15 15])
caxis([0 0.005])
xlabel('T'', K')
ylabel('Total eddy largescale heating, K/day')
title('0es0')
print('-dpng','t_cndht_hist3_000_masked.png')

figure
X(:,2) = difht_ed_series_000_masked;
[N,C] = hist3(X,xbins);
h=pcolor(C{1},C{2},N./sum(sum(N)));
set(h,'EdgeColor','none')
set(gca,'FontSize',15)
colorbar
colormap(flipud(hot))
xlim([-8 8])
ylim([-15 15])
caxis([0 6e-3])
xlabel('T'', K')
ylabel('Total eddy diffusive heating, K/day')
title('0es0')
print('-dpng','t_difht_hist3_000_masked.png')

figure
X(:,2) = radht_ed_series_000_masked;
[N,C] = hist3(X,xbins);
h=pcolor(C{1},C{2},N./sum(sum(N)));
set(h,'EdgeColor','none')
set(gca,'FontSize',15)
colorbar
colormap(flipud(hot))
xlim([-8 8])
ylim([-15 15])
caxis([0 0.02])
xlabel('T'', K')
ylabel('Total eddy radiative heating, K/day')
title('0es0')
print('-dpng','t_radht_hist3_000_masked.png')

clear X 


