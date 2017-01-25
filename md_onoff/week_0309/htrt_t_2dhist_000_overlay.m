
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


load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat','vN_000','vN_100')
load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat','t_000','t_100')
load('/project/rg312/mat_files/heat_rates.mat','htrt_000','htrt_100')
htrt_ll_000 = squeeze(cube2latlon(xc,yc,htrt_000(:,:,5,:),xi,yi)).*86400;
htrt_ll_tav_000 = repmat(mean(htrt_ll_000,3),[1 1 720]);
htrt_ed_ll_000 = htrt_ll_000 - htrt_ll_tav_000;
htrt_ll_100 = squeeze(cube2latlon(xc,yc,htrt_100(:,:,5,:),xi,yi)).*86400;
htrt_ll_tav_100 = repmat(mean(htrt_ll_100,3),[1 1 720]);
htrt_ed_ll_100 = htrt_ll_100 - htrt_ll_tav_100;

t_ll_000 = squeeze(cube2latlon(xc,yc,t_000(:,:,5,:),xi,yi));
t_ll_tav_000 = repmat(mean(t_ll_000,3),[1 1 720]);
t_ed_ll_000 = t_ll_000 - t_ll_tav_000;
t_ll_100 = squeeze(cube2latlon(xc,yc,t_100(:,:,5,:),xi,yi));
t_ll_tav_100 = repmat(mean(t_ll_100,3),[1 1 720]);
t_ed_ll_100 = t_ll_100 - t_ll_tav_100;

vN_ll_000 = squeeze(cube2latlon(xc,yc,vN_000(:,:,5,:),xi,yi));
vN_ll_tav_000 = repmat(mean(vN_ll_000,3),[1 1 720]);
vN_ed_ll_000 = vN_ll_000 - vN_ll_tav_000;
vN_ll_100 = squeeze(cube2latlon(xc,yc,vN_100(:,:,5,:),xi,yi));
vN_ll_tav_100 = repmat(mean(vN_ll_100,3),[1 1 720]);
vN_ed_ll_100 = vN_ll_100 - vN_ll_tav_100;

vt_ed_ll_000 = t_ed_ll_000.*vN_ed_ll_000;
vt_ed_ll_000(:,1:45,:) = -1.*vt_ed_ll_000(:,1:45,:);
vt_ed_series_thresh_000 = reshape(vt_ed_ll_000,[numel(vt_ed_ll_000),1]);
[vt_dist_000,vt_val_000] = hist(vt_ed_series_thresh_000,100);
vt_sum_000 = cumsum(vt_dist_000)./sum(vt_dist_000);
vt_thresh_000 = vt_val_000(min(find(vt_sum_000>=0.95)));

vt_ed_ll_100 = t_ed_ll_100.*vN_ed_ll_100;
vt_ed_ll_100(:,1:45,:) = -1.*vt_ed_ll_100(:,1:45,:);
vt_ed_series_thresh_100 = reshape(vt_ed_ll_100,[numel(vt_ed_ll_100),1]);
[vt_dist_100,vt_val_100] = hist(vt_ed_series_thresh_100,100);
vt_sum_100 = cumsum(vt_dist_100)./sum(vt_dist_100);
vt_thresh_100 = vt_val_100(min(find(vt_sum_100>=0.95)));

for i=1:90
clear X_000
clear X_100

t_ed_series_000 = reshape(t_ed_ll_000(:,i,:),[numel(t_ed_ll_000(:,i,:)),1]);
vt_ed_series_000 = reshape(vt_ed_ll_000(:,i,:),[numel(vt_ed_ll_000(:,i,:)),1]);
htrt_ed_series_000 = reshape(htrt_ed_ll_000(:,i,:),[numel(htrt_ed_ll_000(:,i,:)),1]);

t_ed_series_100 = reshape(t_ed_ll_100(:,i,:),[numel(t_ed_ll_100(:,i,:)),1]);
vt_ed_series_100 = reshape(vt_ed_ll_100(:,i,:),[numel(vt_ed_ll_100(:,i,:)),1]);
htrt_ed_series_100 = reshape(htrt_ed_ll_100(:,i,:),[numel(htrt_ed_ll_100(:,i,:)),1]);

vt_mask_000 = +(vt_ed_series_000 > vt_thresh_000);
vt_mask_100 = +(vt_ed_series_100 > vt_thresh_100);

t_ed_series_000_masked = vt_mask_000.*t_ed_series_000; 
t_ed_series_000_masked(vt_mask_000==0) = [];
htrt_ed_series_000_masked = vt_mask_000.*htrt_ed_series_000; 
htrt_ed_series_000_masked(vt_mask_000==0) = [];

t_ed_series_100_masked = vt_mask_100.*t_ed_series_100; 
t_ed_series_100_masked(vt_mask_100==0) = [];
htrt_ed_series_100_masked = vt_mask_100.*htrt_ed_series_100; 
htrt_ed_series_100_masked(vt_mask_100==0) = [];


xbins{1} = -30:0.1:30;
xbins{2} = -30:0.1:30;
X_000(:,1) = t_ed_series_000_masked;
X_000(:,2) = htrt_ed_series_000_masked;
[thtrt_dist_weighted_000(i,:,:),C] = hist3(X_000,xbins);
thtrt_dist_weighted_000(i,:,:) = thtrt_dist_weighted_000(i,:,:).*cos(yi(i).*pi./180);

X_100(:,1) = t_ed_series_100_masked;
X_100(:,2) = htrt_ed_series_100_masked;
[thtrt_dist_weighted_100(i,:,:),C] = hist3(X_100,xbins);
thtrt_dist_weighted_100(i,:,:) = thtrt_dist_weighted_100(i,:,:).*cos(yi(i).*pi./180);

end

thtrt_dist_000 = squeeze(sum(thtrt_dist_weighted_000,1));
thtrt_dist_100 = squeeze(sum(thtrt_dist_weighted_100,1));

thtrt_dist_000_mask = +0.5.*(thtrt_dist_000 ~= 0);
thtrt_dist_100_mask = +0.5.*(thtrt_dist_100 ~= 0);

%figure
%h=pcolor(C{1},C{2},thtrt_dist_100'./sum(sum(thtrt_dist_100)));
%set(h,'EdgeColor','none')  
%colorbar
%colormap(flipud(hot))
%caxis([0 16e-4])
%hold on
%[Co,h]=contour(C{1},C{2},thtrt_dist_100'./sum(sum(thtrt_dist_100)),'Color',[0.6 0.6 0.6]);
%[Co,h]=contour(C{1},C{2},thtrt_dist_000'./sum(sum(thtrt_dist_000)),'k');
%ylim([-8 8])
%xlim([-15 15])
%set(gca,'FontSize',15)
%xlabel('T'', K')
%ylabel('Total eddy diabatic heating, K/day')
%title('0es0')
%print('-dpng','t_htrt_hist3_100_masked.png')
%hold on
%plot([-15, 0],[-15,0].*m_neg,'k')
%plot([0, 15],[0,15]*m_pos,'k')


figure
h=pcolor(C{1},C{2},thtrt_dist_000'./sum(sum(thtrt_dist_000)));
set(h,'EdgeColor','none')  ;
colorbar; colormap(flipud(hot)); caxis([0 16e-4]);
hold on
h=pcolor(C{1},C{2},thtrt_dist_100'./sum(sum(thtrt_dist_100)));
set(h,'EdgeColor','none')  ; alpha(0.5)
ylim([-8 8])
xlim([-15 15])
set(gca,'FontSize',15)
xlabel('T'', K')
ylabel('Total eddy diabatic heating, K/day')
print('-dpng','drywet_thist_overlay_hot.png')

figure
h=pcolor(C{1},C{2},-thtrt_dist_000'./sum(sum(thtrt_dist_000)));
set(h,'EdgeColor','none')  ;
colorbar; colormap(b2r(-16e-4,16e-4));
hold on
h=pcolor(C{1},C{2},thtrt_dist_100'./sum(sum(thtrt_dist_100)));
set(h,'EdgeColor','none')  ; alpha(0.5)
ylim([-8 8])
xlim([-15 15])
set(gca,'FontSize',15)
xlabel('T'', K')
ylabel('Total eddy diabatic heating, K/day')
print('-dpng','drywet_thist_overlay_rb.png')

