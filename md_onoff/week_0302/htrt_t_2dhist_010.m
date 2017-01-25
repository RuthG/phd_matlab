
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


load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat','vN_010')
load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat','t_010')
load('/project/rg312/mat_files/heat_rates.mat','htrt_010','radht_010','difht_010','cndht_010','cnvht_010')
htrt_ll_010 = squeeze(cube2latlon(xc,yc,htrt_010(:,:,5,:),xi,yi)).*86400;
htrt_ll_tav_010 = repmat(mean(htrt_ll_010,3),[1 1 720]);
htrt_ed_ll_010 = htrt_ll_010 - htrt_ll_tav_010;
radht_ll_010 = squeeze(cube2latlon(xc,yc,radht_010(:,:,5,:),xi,yi)).*86400;
radht_ll_tav_010 = repmat(mean(radht_ll_010,3),[1 1 720]);
radht_ed_ll_010 = radht_ll_010 - radht_ll_tav_010;
difht_ll_010 = squeeze(cube2latlon(xc,yc,difht_010(:,:,5,:),xi,yi)).*86400;
difht_ll_tav_010 = repmat(mean(difht_ll_010,3),[1 1 720]);
difht_ed_ll_010 = difht_ll_010 - difht_ll_tav_010;
cndht_ll_010 = squeeze(cube2latlon(xc,yc,cndht_010(:,:,5,:),xi,yi)).*86400;
cndht_ll_tav_010 = repmat(mean(cndht_ll_010,3),[1 1 720]);
cndht_ed_ll_010 = cndht_ll_010 - cndht_ll_tav_010;
cnvht_ll_010 = squeeze(cube2latlon(xc,yc,cnvht_010(:,:,5,:),xi,yi)).*86400;
cnvht_ll_tav_010 = repmat(mean(cnvht_ll_010,3),[1 1 720]);
cnvht_ed_ll_010 = cnvht_ll_010 - cnvht_ll_tav_010;

t_ll_010 = squeeze(cube2latlon(xc,yc,t_010(:,:,5,:),xi,yi));
t_ll_tav_010 = repmat(mean(t_ll_010,3),[1 1 720]);
t_ed_ll_010 = t_ll_010 - t_ll_tav_010;

vN_ll_010 = squeeze(cube2latlon(xc,yc,vN_010(:,:,5,:),xi,yi));
vN_ll_tav_010 = repmat(mean(vN_ll_010,3),[1 1 720]);
vN_ed_ll_010 = vN_ll_010 - vN_ll_tav_010;

vt_ed_ll_010 = t_ed_ll_010.*vN_ed_ll_010;
vt_ed_ll_010(:,1:45,:) = -1.*vt_ed_ll_010(:,1:45,:);

t_ed_series_010 = reshape(t_ed_ll_010,[numel(t_ed_ll_010),1]);
vt_ed_series_010 = reshape(vt_ed_ll_010,[numel(vt_ed_ll_010),1]);
htrt_ed_series_010 = reshape(htrt_ed_ll_010,[numel(htrt_ed_ll_010),1]);
cnvht_ed_series_010 = reshape(cnvht_ed_ll_010,[numel(cnvht_ed_ll_010),1]);
cndht_ed_series_010 = reshape(cndht_ed_ll_010,[numel(cndht_ed_ll_010),1]);
radht_ed_series_010 = reshape(radht_ed_ll_010,[numel(radht_ed_ll_010),1]);
difht_ed_series_010 = reshape(difht_ed_ll_010,[numel(difht_ed_ll_010),1]);

xbins{1} = -30:0.1:30;
xbins{2} = -30:0.1:30;
X(:,1) = t_ed_series_010;

figure
X(:,2) = htrt_ed_series_010;
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
title('0.1es0')
print('-dpng','t_htrt_hist3_010.png')

figure
X(:,2) = cnvht_ed_series_010;
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
title('0.1es0')
print('-dpng','t_cnvht_hist3_010.png')

figure
X(:,2) = cndht_ed_series_010;
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
title('0.1es0')
print('-dpng','t_cndht_hist3_010.png')

figure
X(:,2) = difht_ed_series_010;
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
title('0.1es0')
print('-dpng','t_difht_hist3_010.png')

figure
X(:,2) = radht_ed_series_010;
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
title('0.1es0')
print('-dpng','t_radht_hist3_010.png')

clear X 


[vt_dist_010,vt_val_010] = hist(vt_ed_series_010,100);
vt_sum_010 = cumsum(vt_dist_010)./sum(vt_dist_010);
vt_thresh_010 = vt_val_010(min(find(vt_sum_010>=0.95)));
vt_mask_010 = +(vt_ed_series_010 > vt_thresh_010);

t_ed_series_010_masked = vt_mask_010.*t_ed_series_010; 
t_ed_series_010_masked(vt_mask_010==0) = [];
htrt_ed_series_010_masked = vt_mask_010.*htrt_ed_series_010; 
htrt_ed_series_010_masked(vt_mask_010==0) = [];
cnvht_ed_series_010_masked = vt_mask_010.*cnvht_ed_series_010; 
cnvht_ed_series_010_masked(vt_mask_010==0) = [];
cndht_ed_series_010_masked = vt_mask_010.*cndht_ed_series_010; 
cndht_ed_series_010_masked(vt_mask_010==0) = [];
difht_ed_series_010_masked = vt_mask_010.*difht_ed_series_010; 
difht_ed_series_010_masked(vt_mask_010==0) = [];
radht_ed_series_010_masked = vt_mask_010.*radht_ed_series_010; 
radht_ed_series_010_masked(vt_mask_010==0) = [];

xbins{1} = -30:0.1:30;
xbins{2} = -30:0.1:30;
X(:,1) = t_ed_series_010_masked;

figure
X(:,2) = htrt_ed_series_010_masked;
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
title('0.1es0')
print('-dpng','t_htrt_hist3_010_masked.png')

figure
X(:,2) = cnvht_ed_series_010_masked;
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
title('0.1es0')
print('-dpng','t_cnvht_hist3_010_masked.png')

figure
X(:,2) = cndht_ed_series_010_masked;
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
title('0.1es0')
print('-dpng','t_cndht_hist3_010_masked.png')

figure
X(:,2) = difht_ed_series_010_masked;
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
title('0.1es0')
print('-dpng','t_difht_hist3_010_masked.png')

figure
X(:,2) = radht_ed_series_010_masked;
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
title('0.1es0')
print('-dpng','t_radht_hist3_010_masked.png')

clear X 


