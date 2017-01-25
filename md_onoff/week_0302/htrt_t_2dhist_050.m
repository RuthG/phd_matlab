
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


load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat','vN_050')
load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat','t_050')
load('/project/rg312/mat_files/heat_rates.mat','htrt_050','radht_050','difht_050','cndht_050','cnvht_050')
htrt_ll_050 = squeeze(cube2latlon(xc,yc,htrt_050(:,:,5,:),xi,yi)).*86400;
htrt_ll_tav_050 = repmat(mean(htrt_ll_050,3),[1 1 720]);
htrt_ed_ll_050 = htrt_ll_050 - htrt_ll_tav_050;
radht_ll_050 = squeeze(cube2latlon(xc,yc,radht_050(:,:,5,:),xi,yi)).*86400;
radht_ll_tav_050 = repmat(mean(radht_ll_050,3),[1 1 720]);
radht_ed_ll_050 = radht_ll_050 - radht_ll_tav_050;
difht_ll_050 = squeeze(cube2latlon(xc,yc,difht_050(:,:,5,:),xi,yi)).*86400;
difht_ll_tav_050 = repmat(mean(difht_ll_050,3),[1 1 720]);
difht_ed_ll_050 = difht_ll_050 - difht_ll_tav_050;
cndht_ll_050 = squeeze(cube2latlon(xc,yc,cndht_050(:,:,5,:),xi,yi)).*86400;
cndht_ll_tav_050 = repmat(mean(cndht_ll_050,3),[1 1 720]);
cndht_ed_ll_050 = cndht_ll_050 - cndht_ll_tav_050;
cnvht_ll_050 = squeeze(cube2latlon(xc,yc,cnvht_050(:,:,5,:),xi,yi)).*86400;
cnvht_ll_tav_050 = repmat(mean(cnvht_ll_050,3),[1 1 720]);
cnvht_ed_ll_050 = cnvht_ll_050 - cnvht_ll_tav_050;

t_ll_050 = squeeze(cube2latlon(xc,yc,t_050(:,:,5,:),xi,yi));
t_ll_tav_050 = repmat(mean(t_ll_050,3),[1 1 720]);
t_ed_ll_050 = t_ll_050 - t_ll_tav_050;

vN_ll_050 = squeeze(cube2latlon(xc,yc,vN_050(:,:,5,:),xi,yi));
vN_ll_tav_050 = repmat(mean(vN_ll_050,3),[1 1 720]);
vN_ed_ll_050 = vN_ll_050 - vN_ll_tav_050;

vt_ed_ll_050 = t_ed_ll_050.*vN_ed_ll_050;
vt_ed_ll_050(:,1:45,:) = -1.*vt_ed_ll_050(:,1:45,:);

t_ed_series_050 = reshape(t_ed_ll_050,[numel(t_ed_ll_050),1]);
vt_ed_series_050 = reshape(vt_ed_ll_050,[numel(vt_ed_ll_050),1]);
htrt_ed_series_050 = reshape(htrt_ed_ll_050,[numel(htrt_ed_ll_050),1]);
cnvht_ed_series_050 = reshape(cnvht_ed_ll_050,[numel(cnvht_ed_ll_050),1]);
cndht_ed_series_050 = reshape(cndht_ed_ll_050,[numel(cndht_ed_ll_050),1]);
radht_ed_series_050 = reshape(radht_ed_ll_050,[numel(radht_ed_ll_050),1]);
difht_ed_series_050 = reshape(difht_ed_ll_050,[numel(difht_ed_ll_050),1]);

xbins{1} = -30:0.1:30;
xbins{2} = -30:0.1:30;
X(:,1) = t_ed_series_050;

figure
X(:,2) = htrt_ed_series_050;
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
title('0.5es0')
print('-dpng','t_htrt_hist3_050.png')

figure
X(:,2) = cnvht_ed_series_050;
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
title('0.5es0')
print('-dpng','t_cnvht_hist3_050.png')

figure
X(:,2) = cndht_ed_series_050;
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
title('0.5es0')
print('-dpng','t_cndht_hist3_050.png')

figure
X(:,2) = difht_ed_series_050;
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
title('0.5es0')
print('-dpng','t_difht_hist3_050.png')

figure
X(:,2) = radht_ed_series_050;
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
title('0.5es0')
print('-dpng','t_radht_hist3_050.png')

clear X 


[vt_dist_050,vt_val_050] = hist(vt_ed_series_050,100);
vt_sum_050 = cumsum(vt_dist_050)./sum(vt_dist_050);
vt_thresh_050 = vt_val_050(min(find(vt_sum_050>=0.95)));
vt_mask_050 = +(vt_ed_series_050 > vt_thresh_050);

t_ed_series_050_masked = vt_mask_050.*t_ed_series_050; 
t_ed_series_050_masked(vt_mask_050==0) = [];
htrt_ed_series_050_masked = vt_mask_050.*htrt_ed_series_050; 
htrt_ed_series_050_masked(vt_mask_050==0) = [];
cnvht_ed_series_050_masked = vt_mask_050.*cnvht_ed_series_050; 
cnvht_ed_series_050_masked(vt_mask_050==0) = [];
cndht_ed_series_050_masked = vt_mask_050.*cndht_ed_series_050; 
cndht_ed_series_050_masked(vt_mask_050==0) = [];
difht_ed_series_050_masked = vt_mask_050.*difht_ed_series_050; 
difht_ed_series_050_masked(vt_mask_050==0) = [];
radht_ed_series_050_masked = vt_mask_050.*radht_ed_series_050; 
radht_ed_series_050_masked(vt_mask_050==0) = [];

xbins{1} = -30:0.1:30;
xbins{2} = -30:0.1:30;
X(:,1) = t_ed_series_050_masked;

figure
X(:,2) = htrt_ed_series_050_masked;
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
title('0.5es0')
print('-dpng','t_htrt_hist3_050_masked.png')

figure
X(:,2) = cnvht_ed_series_050_masked;
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
title('0.5es0')
print('-dpng','t_cnvht_hist3_050_masked.png')

figure
X(:,2) = cndht_ed_series_050_masked;
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
title('0.5es0')
print('-dpng','t_cndht_hist3_050_masked.png')

figure
X(:,2) = difht_ed_series_050_masked;
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
title('0.5es0')
print('-dpng','t_difht_hist3_050_masked.png')

figure
X(:,2) = radht_ed_series_050_masked;
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
title('0.5es0')
print('-dpng','t_radht_hist3_050_masked.png')

clear X 


