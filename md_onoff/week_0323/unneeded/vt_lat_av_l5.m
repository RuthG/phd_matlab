%take average v't' around latitude circle at peak for each run
%also calculate average associated with cold sector only



% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_000_best/';
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
ny=90;
xi=-179:2:180;yi=-89:2:90;

load('/project/rg312/mat_files/vt_lats_best.mat')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_000')
load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_000')

t_ll = squeeze(cube2latlon(xc,yc,t_000(:,:,5,:),xi,yi));
t_ll_tav = repmat(mean(t_ll,3),[1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_000','t_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_000(:,:,5,:),xi,yi));
vN_ll_tav = repmat(mean(vN_ll,3),[1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_000','vN_ll')

vt_ed_ll(:,1:720) = squeeze(t_ed_ll(:,x000n,:).*vN_ed_ll(:,x000n,:));
vt_ed_ll(:,721:1440) = squeeze(-t_ed_ll(:,x000s,:).*vN_ed_ll(:,x000s,:));

t_ed_lin(:,1:720) = squeeze(t_ed_ll(:,x000n,:));
t_ed_lin(:,721:1440) = squeeze(t_ed_ll(:,x000s,:));

t_ed_mask_neg = +(t_ed_lin < 0);
t_ed_mask_pos = +(t_ed_lin > 0);

vt_ed_ll_masked = vt_ed_ll.*t_ed_mask_neg;
vt_ed_ll_masked_series = vt_ed_ll_masked;
vt_ed_ll_masked_series(vt_ed_ll_masked==0) = [];

vt_ed_ll_masked_pos = vt_ed_ll.*t_ed_mask_pos;
vt_ed_ll_masked_series_pos = vt_ed_ll_masked_pos;
vt_ed_ll_masked_series_pos(vt_ed_ll_masked_pos==0) = [];

vt_mean_000 = mean(mean(vt_ed_ll));
vt_mean_neg_000 = sum(vt_ed_ll_masked_series)./numel(vt_ed_ll);
vt_mean_pos_000 = sum(vt_ed_ll_masked_series_pos)./numel(vt_ed_ll);

save('vt_means.mat','vt_mean_000','vt_mean_neg_000','vt_mean_pos_000')

clear





% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_010_best/';
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
ny=90;
xi=-179:2:180;yi=-89:2:90;

load('/project/rg312/mat_files/vt_lats_best.mat')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_010')
load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_010')

t_ll = squeeze(cube2latlon(xc,yc,t_010(:,:,5,:),xi,yi));
t_ll_tav = repmat(mean(t_ll,3),[1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_010','t_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_010(:,:,5,:),xi,yi));
vN_ll_tav = repmat(mean(vN_ll,3),[1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_010','vN_ll')

vt_ed_ll(:,1:720) = squeeze(t_ed_ll(:,x010n,:).*vN_ed_ll(:,x010n,:));
vt_ed_ll(:,721:1440) = squeeze(-t_ed_ll(:,x010s,:).*vN_ed_ll(:,x010s,:));

t_ed_lin(:,1:720) = squeeze(t_ed_ll(:,x010n,:));
t_ed_lin(:,721:1440) = squeeze(t_ed_ll(:,x010s,:));

t_ed_mask_neg = +(t_ed_lin < 0);
t_ed_mask_pos = +(t_ed_lin > 0);
vt_ed_mask_neg = +(vt_ed_ll < 0);
vt_ed_mask_pos = +(vt_ed_ll > 0);

vt_ed_ll_masked = vt_ed_ll.*t_ed_mask_neg;
vt_ed_ll_masked_series = vt_ed_ll_masked;
vt_ed_ll_masked_series(vt_ed_ll_masked==0) = [];

vt_ed_ll_masked_pos = vt_ed_ll.*t_ed_mask_pos;
vt_ed_ll_masked_series_pos = vt_ed_ll_masked_pos;
vt_ed_ll_masked_series_pos(vt_ed_ll_masked_pos==0) = [];

vt_mean_010 = mean(mean(vt_ed_ll));
vt_mean_neg_010 = sum(vt_ed_ll_masked_series)./numel(vt_ed_ll);
vt_mean_pos_010 = sum(vt_ed_ll_masked_series_pos)./numel(vt_ed_ll);

save('vt_means.mat','vt_mean_010','vt_mean_neg_010','vt_mean_pos_010','-append')



clear






% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_025_best/';
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
ny=90;
xi=-179:2:180;yi=-89:2:90;

load('/project/rg312/mat_files/vt_lats_best.mat')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_025')
load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_025')

t_ll = squeeze(cube2latlon(xc,yc,t_025(:,:,5,:),xi,yi));
t_ll_tav = repmat(mean(t_ll,3),[1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_025','t_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_025(:,:,5,:),xi,yi));
vN_ll_tav = repmat(mean(vN_ll,3),[1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_025','vN_ll')

vt_ed_ll(:,1:720) = squeeze(t_ed_ll(:,x025n,:).*vN_ed_ll(:,x025n,:));
vt_ed_ll(:,721:1440) = squeeze(-t_ed_ll(:,x025s,:).*vN_ed_ll(:,x025s,:));

t_ed_lin(:,1:720) = squeeze(t_ed_ll(:,x025n,:));
t_ed_lin(:,721:1440) = squeeze(t_ed_ll(:,x025s,:));

t_ed_mask_neg = +(t_ed_lin < 0);
t_ed_mask_pos = +(t_ed_lin > 0);
vt_ed_mask_neg = +(vt_ed_ll < 0);
vt_ed_mask_pos = +(vt_ed_ll > 0);

vt_ed_ll_masked = vt_ed_ll.*t_ed_mask_neg;
vt_ed_ll_masked_series = vt_ed_ll_masked;
vt_ed_ll_masked_series(vt_ed_ll_masked==0) = [];

vt_ed_ll_masked_pos = vt_ed_ll.*t_ed_mask_pos;
vt_ed_ll_masked_series_pos = vt_ed_ll_masked_pos;
vt_ed_ll_masked_series_pos(vt_ed_ll_masked_pos==0) = [];

vt_mean_025 = mean(mean(vt_ed_ll));
vt_mean_neg_025 = sum(vt_ed_ll_masked_series)./numel(vt_ed_ll);
vt_mean_pos_025 = sum(vt_ed_ll_masked_series_pos)./numel(vt_ed_ll);

save('vt_means.mat','vt_mean_025','vt_mean_neg_025','vt_mean_pos_025','-append')




clear






% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_050_best/';
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
ny=90;
xi=-179:2:180;yi=-89:2:90;

load('/project/rg312/mat_files/vt_lats_best.mat')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_050')
load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_050')

t_ll = squeeze(cube2latlon(xc,yc,t_050(:,:,5,:),xi,yi));
t_ll_tav = repmat(mean(t_ll,3),[1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_050','t_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_050(:,:,5,:),xi,yi));
vN_ll_tav = repmat(mean(vN_ll,3),[1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_050','vN_ll')

vt_ed_ll(:,1:720) = squeeze(t_ed_ll(:,x050n,:).*vN_ed_ll(:,x050n,:));
vt_ed_ll(:,721:1440) = squeeze(-t_ed_ll(:,x050s,:).*vN_ed_ll(:,x050s,:));

t_ed_lin(:,1:720) = squeeze(t_ed_ll(:,x050n,:));
t_ed_lin(:,721:1440) = squeeze(t_ed_ll(:,x050s,:));

t_ed_mask_neg = +(t_ed_lin < 0);
t_ed_mask_pos = +(t_ed_lin > 0);
vt_ed_mask_neg = +(vt_ed_ll < 0);
vt_ed_mask_pos = +(vt_ed_ll > 0);

vt_ed_ll_masked = vt_ed_ll.*t_ed_mask_neg;
vt_ed_ll_masked_series = vt_ed_ll_masked;
vt_ed_ll_masked_series(vt_ed_ll_masked==0) = [];

vt_ed_ll_masked_pos = vt_ed_ll.*t_ed_mask_pos;
vt_ed_ll_masked_series_pos = vt_ed_ll_masked_pos;
vt_ed_ll_masked_series_pos(vt_ed_ll_masked_pos==0) = [];

vt_mean_050 = mean(mean(vt_ed_ll));
vt_mean_neg_050 = sum(vt_ed_ll_masked_series)./numel(vt_ed_ll);
vt_mean_pos_050 = sum(vt_ed_ll_masked_series_pos)./numel(vt_ed_ll);

save('vt_means.mat','vt_mean_050','vt_mean_neg_050','vt_mean_pos_050','-append')




clear






% choose directory, load grid
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
ny=90;
xi=-179:2:180;yi=-89:2:90;

load('/project/rg312/mat_files/vt_lats_best.mat')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_075')
load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_075')

t_ll = squeeze(cube2latlon(xc,yc,t_075(:,:,5,:),xi,yi));
t_ll_tav = repmat(mean(t_ll,3),[1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_075','t_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_075(:,:,5,:),xi,yi));
vN_ll_tav = repmat(mean(vN_ll,3),[1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_075','vN_ll')

vt_ed_ll(:,1:720) = squeeze(t_ed_ll(:,x075n,:).*vN_ed_ll(:,x075n,:));
vt_ed_ll(:,721:1440) = squeeze(-t_ed_ll(:,x075s,:).*vN_ed_ll(:,x075s,:));

t_ed_lin(:,1:720) = squeeze(t_ed_ll(:,x075n,:));
t_ed_lin(:,721:1440) = squeeze(t_ed_ll(:,x075s,:));

t_ed_mask_neg = +(t_ed_lin < 0);
t_ed_mask_pos = +(t_ed_lin > 0);
vt_ed_mask_neg = +(vt_ed_ll < 0);
vt_ed_mask_pos = +(vt_ed_ll > 0);

vt_ed_ll_masked = vt_ed_ll.*t_ed_mask_neg;
vt_ed_ll_masked_series = vt_ed_ll_masked;
vt_ed_ll_masked_series(vt_ed_ll_masked==0) = [];

vt_ed_ll_masked_pos = vt_ed_ll.*t_ed_mask_pos;
vt_ed_ll_masked_series_pos = vt_ed_ll_masked_pos;
vt_ed_ll_masked_series_pos(vt_ed_ll_masked_pos==0) = [];

vt_mean_075 = mean(mean(vt_ed_ll));
vt_mean_neg_075 = sum(vt_ed_ll_masked_series)./numel(vt_ed_ll);
vt_mean_pos_075 = sum(vt_ed_ll_masked_series_pos)./numel(vt_ed_ll);

save('vt_means.mat','vt_mean_075','vt_mean_neg_075','vt_mean_pos_075','-append')




clear






% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_100_best/';
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
ny=90;
xi=-179:2:180;yi=-89:2:90;

load('/project/rg312/mat_files/vt_lats_best.mat')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_100')
load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_100')

t_ll = squeeze(cube2latlon(xc,yc,t_100(:,:,5,:),xi,yi));
t_ll_tav = repmat(mean(t_ll,3),[1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_100','t_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_100(:,:,5,:),xi,yi));
vN_ll_tav = repmat(mean(vN_ll,3),[1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_100','vN_ll')

vt_ed_ll(:,1:720) = squeeze(t_ed_ll(:,x100n,:).*vN_ed_ll(:,x100n,:));
vt_ed_ll(:,721:1440) = squeeze(-t_ed_ll(:,x100s,:).*vN_ed_ll(:,x100s,:));

t_ed_lin(:,1:720) = squeeze(t_ed_ll(:,x100n,:));
t_ed_lin(:,721:1440) = squeeze(t_ed_ll(:,x100s,:));

t_ed_mask_neg = +(t_ed_lin < 0);
t_ed_mask_pos = +(t_ed_lin > 0);
vt_ed_mask_neg = +(vt_ed_ll < 0);
vt_ed_mask_pos = +(vt_ed_ll > 0);

vt_ed_ll_masked = vt_ed_ll.*t_ed_mask_neg;
vt_ed_ll_masked_series = vt_ed_ll_masked;
vt_ed_ll_masked_series(vt_ed_ll_masked==0) = [];

vt_ed_ll_masked_pos = vt_ed_ll.*t_ed_mask_pos;
vt_ed_ll_masked_series_pos = vt_ed_ll_masked_pos;
vt_ed_ll_masked_series_pos(vt_ed_ll_masked_pos==0) = [];

vt_mean_100 = mean(mean(vt_ed_ll));
vt_mean_neg_100 = sum(vt_ed_ll_masked_series)./numel(vt_ed_ll);
vt_mean_pos_100 = sum(vt_ed_ll_masked_series_pos)./numel(vt_ed_ll);

save('vt_means.mat','vt_mean_100','vt_mean_neg_100','vt_mean_pos_100','-append')







% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_125_best/';
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
ny=90;
xi=-179:2:180;yi=-89:2:90;

load('/project/rg312/mat_files/vt_lats_best.mat')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_125')
load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_125')

t_ll = squeeze(cube2latlon(xc,yc,t_125(:,:,5,:),xi,yi));
t_ll_tav = repmat(mean(t_ll,3),[1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_125','t_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_125(:,:,5,:),xi,yi));
vN_ll_tav = repmat(mean(vN_ll,3),[1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_125','vN_ll')

vt_ed_ll(:,1:720) = squeeze(t_ed_ll(:,x100n,:).*vN_ed_ll(:,x100n,:));
vt_ed_ll(:,721:1440) = squeeze(-t_ed_ll(:,x100s,:).*vN_ed_ll(:,x100s,:));

t_ed_lin(:,1:720) = squeeze(t_ed_ll(:,x100n,:));
t_ed_lin(:,721:1440) = squeeze(t_ed_ll(:,x100s,:));

t_ed_mask_neg = +(t_ed_lin < 0);
t_ed_mask_pos = +(t_ed_lin > 0);
vt_ed_mask_neg = +(vt_ed_ll < 0);
vt_ed_mask_pos = +(vt_ed_ll > 0);

vt_ed_ll_masked = vt_ed_ll.*t_ed_mask_neg;
vt_ed_ll_masked_series = vt_ed_ll_masked;
vt_ed_ll_masked_series(vt_ed_ll_masked==0) = [];

vt_ed_ll_masked_pos = vt_ed_ll.*t_ed_mask_pos;
vt_ed_ll_masked_series_pos = vt_ed_ll_masked_pos;
vt_ed_ll_masked_series_pos(vt_ed_ll_masked_pos==0) = [];

vt_mean_125 = mean(mean(vt_ed_ll));
vt_mean_neg_125 = sum(vt_ed_ll_masked_series)./numel(vt_ed_ll);
vt_mean_pos_125 = sum(vt_ed_ll_masked_series_pos)./numel(vt_ed_ll);

save('vt_means.mat','vt_mean_125','vt_mean_neg_125','vt_mean_pos_125','-append')








% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_150_best/';
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
ny=90;
xi=-179:2:180;yi=-89:2:90;

load('/project/rg312/mat_files/vt_lats_best.mat')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_150')
load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_150')

t_ll = squeeze(cube2latlon(xc,yc,t_150(:,:,5,:),xi,yi));
t_ll_tav = repmat(mean(t_ll,3),[1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_150','t_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_150(:,:,5,:),xi,yi));
vN_ll_tav = repmat(mean(vN_ll,3),[1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_150','vN_ll')

vt_ed_ll(:,1:720) = squeeze(t_ed_ll(:,x100n,:).*vN_ed_ll(:,x100n,:));
vt_ed_ll(:,721:1440) = squeeze(-t_ed_ll(:,x100s,:).*vN_ed_ll(:,x100s,:));

t_ed_lin(:,1:720) = squeeze(t_ed_ll(:,x100n,:));
t_ed_lin(:,721:1440) = squeeze(t_ed_ll(:,x100s,:));

t_ed_mask_neg = +(t_ed_lin < 0);
t_ed_mask_pos = +(t_ed_lin > 0);
vt_ed_mask_neg = +(vt_ed_ll < 0);
vt_ed_mask_pos = +(vt_ed_ll > 0);

vt_ed_ll_masked = vt_ed_ll.*t_ed_mask_neg;
vt_ed_ll_masked_series = vt_ed_ll_masked;
vt_ed_ll_masked_series(vt_ed_ll_masked==0) = [];

vt_ed_ll_masked_pos = vt_ed_ll.*t_ed_mask_pos;
vt_ed_ll_masked_series_pos = vt_ed_ll_masked_pos;
vt_ed_ll_masked_series_pos(vt_ed_ll_masked_pos==0) = [];

vt_mean_150 = mean(mean(vt_ed_ll));
vt_mean_neg_150 = sum(vt_ed_ll_masked_series)./numel(vt_ed_ll);
vt_mean_pos_150 = sum(vt_ed_ll_masked_series_pos)./numel(vt_ed_ll);

save('vt_means.mat','vt_mean_150','vt_mean_neg_150','vt_mean_pos_150','-append')




load('vt_means.mat')
vt_mean(1) = vt_mean_000;
vt_mean_neg(1) = vt_mean_neg_000;
vt_mean_pos(1) = vt_mean_pos_000;
vt_mean(2) = vt_mean_010;
vt_mean_neg(2) = vt_mean_neg_010;
vt_mean_pos(2) = vt_mean_pos_010;
vt_mean(3) = vt_mean_025;
vt_mean_neg(3) = vt_mean_neg_025;
vt_mean_pos(3) = vt_mean_pos_025;
vt_mean(4) = vt_mean_050;
vt_mean_neg(4) = vt_mean_neg_050;
vt_mean_pos(4) = vt_mean_pos_050;
vt_mean(5) = vt_mean_075;
vt_mean_neg(5) = vt_mean_neg_075;
vt_mean_pos(5) = vt_mean_pos_075;
vt_mean(6) = vt_mean_100;
vt_mean_neg(6) = vt_mean_neg_100;
vt_mean_pos(6) = vt_mean_pos_100;
vt_mean(7) = vt_mean_125;
vt_mean_neg(7) = vt_mean_neg_125;
vt_mean_pos(7) = vt_mean_pos_125;
vt_mean(8) = vt_mean_150;
vt_mean_neg(8) = vt_mean_neg_150;
vt_mean_pos(8) = vt_mean_pos_150;



es0 = [0,0.1,0.25,0.5,0.75,1.0,1.25,1.5];

figure
plot(es0, vt_mean - vt_mean(1),'b') 
hold on
plot(es0, vt_mean_pos - vt_mean_pos(1),'g')  
plot(es0, vt_mean_neg - vt_mean_neg(1),'r')
ylabel('v''T'', Km/s, zonal, time, pressure average, dry values subtracted')
xlabel('Reference saturation vapour pressure fraction')
print('-dpng','vt_ed_change_maxlat.png')

figure
plot(es0, vt_mean,'b') 
hold on
plot(es0, vt_mean_pos,'g')  
plot(es0, vt_mean_neg,'r')
ylabel('v''T'', Km/s, zonal, time, pressure average')
xlabel('Reference saturation vapour pressure fraction')
print('-dpng','vt_ed_totandpn_maxlat.png')

figure
plot(es0, vt_mean_pos./vt_mean,'g')  
hold on
plot(es0, vt_mean_neg./vt_mean,'r')
ylabel('v''T'', +T and -T contributions normalised by total')
xlabel('Reference saturation vapour pressure fraction')
print('-dpng','vt_ed_pnovertot_maxlat.png')

figure
plot(es0, vt_mean_neg./vt_mean_pos)
ylabel('v''T'' (-T)/v''T'' (+T)')
xlabel('Reference saturation vapour pressure fraction')
print('-dpng','vt_ed_noverp_maxlat.png')

