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

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_000')

t_ll = squeeze(cube2latlon(xc,yc,t_000,xi,yi));
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_000','t_ll')

t_ed_ll_sq = t_ed_ll.^2;
t_ed_mask_neg = +(t_ed_ll < 0);
t_ed_mask_pos = +(t_ed_ll > 0);

t_ll_tneg = t_ed_ll.^2.*t_ed_mask_neg;
t_ll_tpos = t_ed_ll.^2.*t_ed_mask_pos;

t_ll_tzav_000 = sqrt(squeeze(mean(mean(t_ed_ll_sq,1),4)))';
t_ll_tzav_tneg_000 = sqrt(squeeze(nanmean(nanmean(t_ll_tneg,1),4)))';
t_ll_tzav_tpos_000 = sqrt(squeeze(nanmean(nanmean(t_ll_tpos,1),4)))';


save('/project/rg312/mat_files/t_lat_means.mat','t_ll_tzav_000','t_ll_tzav_tneg_000','t_ll_tzav_tpos_000')

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

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_010')

t_ll = squeeze(cube2latlon(xc,yc,t_010,xi,yi));
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_010','t_ll')

t_ed_ll_sq = t_ed_ll.^2;
t_ed_mask_neg = +(t_ed_ll < 0);
t_ed_mask_pos = +(t_ed_ll > 0);

t_ll_tneg = t_ed_ll.^2.*t_ed_mask_neg;
t_ll_tpos = t_ed_ll.^2.*t_ed_mask_pos;

t_ll_tzav_010 = sqrt(squeeze(mean(mean(t_ed_ll_sq,1),4)))';
t_ll_tzav_tneg_010 = sqrt(squeeze(nanmean(nanmean(t_ll_tneg,1),4)))';
t_ll_tzav_tpos_010 = sqrt(squeeze(nanmean(nanmean(t_ll_tpos,1),4)))';


save('/project/rg312/mat_files/t_lat_means.mat','t_ll_tzav_010','t_ll_tzav_tneg_010','t_ll_tzav_tpos_010','-append')

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

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_025')

t_ll = squeeze(cube2latlon(xc,yc,t_025,xi,yi));
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_025','t_ll')

t_ed_ll_sq = t_ed_ll.^2;
t_ed_mask_neg = +(t_ed_ll < 0);
t_ed_mask_pos = +(t_ed_ll > 0);

t_ll_tneg = t_ed_ll.^2.*t_ed_mask_neg;
t_ll_tpos = t_ed_ll.^2.*t_ed_mask_pos;

t_ll_tzav_025 = sqrt(squeeze(mean(mean(t_ed_ll_sq,1),4)))';
t_ll_tzav_tneg_025 = sqrt(squeeze(nanmean(nanmean(t_ll_tneg,1),4)))';
t_ll_tzav_tpos_025 = sqrt(squeeze(nanmean(nanmean(t_ll_tpos,1),4)))';


save('/project/rg312/mat_files/t_lat_means.mat','t_ll_tzav_025','t_ll_tzav_tneg_025','t_ll_tzav_tpos_025','-append')

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

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_050')

t_ll = squeeze(cube2latlon(xc,yc,t_050,xi,yi));
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_050','t_ll')

t_ed_ll_sq = t_ed_ll.^2;
t_ed_mask_neg = +(t_ed_ll < 0);
t_ed_mask_pos = +(t_ed_ll > 0);

t_ll_tneg = t_ed_ll.^2.*t_ed_mask_neg;
t_ll_tpos = t_ed_ll.^2.*t_ed_mask_pos;

t_ll_tzav_050 = sqrt(squeeze(mean(mean(t_ed_ll_sq,1),4)))';
t_ll_tzav_tneg_050 = sqrt(squeeze(nanmean(nanmean(t_ll_tneg,1),4)))';
t_ll_tzav_tpos_050 = sqrt(squeeze(nanmean(nanmean(t_ll_tpos,1),4)))';


save('/project/rg312/mat_files/t_lat_means.mat','t_ll_tzav_050','t_ll_tzav_tneg_050','t_ll_tzav_tpos_050','-append')

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

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_075')

t_ll = squeeze(cube2latlon(xc,yc,t_075,xi,yi));
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_075','t_ll')

t_ed_ll_sq = t_ed_ll.^2;
t_ed_mask_neg = +(t_ed_ll < 0);
t_ed_mask_pos = +(t_ed_ll > 0);

t_ll_tneg = t_ed_ll.^2.*t_ed_mask_neg;
t_ll_tpos = t_ed_ll.^2.*t_ed_mask_pos;

t_ll_tzav_075 = sqrt(squeeze(mean(mean(t_ed_ll_sq,1),4)))';
t_ll_tzav_tneg_075 = sqrt(squeeze(nanmean(nanmean(t_ll_tneg,1),4)))';
t_ll_tzav_tpos_075 = sqrt(squeeze(nanmean(nanmean(t_ll_tpos,1),4)))';


save('/project/rg312/mat_files/t_lat_means.mat','t_ll_tzav_075','t_ll_tzav_tneg_075','t_ll_tzav_tpos_075','-append')

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

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_100')

t_ll = squeeze(cube2latlon(xc,yc,t_100,xi,yi));
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_100','t_ll')

t_ed_ll_sq = t_ed_ll.^2;
t_ed_mask_neg = +(t_ed_ll < 0);
t_ed_mask_pos = +(t_ed_ll > 0);

t_ll_tneg = t_ed_ll.^2.*t_ed_mask_neg;
t_ll_tpos = t_ed_ll.^2.*t_ed_mask_pos;

t_ll_tzav_100 = sqrt(squeeze(mean(mean(t_ed_ll_sq,1),4)))';
t_ll_tzav_tneg_100 = sqrt(squeeze(nanmean(nanmean(t_ll_tneg,1),4)))';
t_ll_tzav_tpos_100 = sqrt(squeeze(nanmean(nanmean(t_ll_tpos,1),4)))';


save('/project/rg312/mat_files/t_lat_means.mat','t_ll_tzav_100','t_ll_tzav_tneg_100','t_ll_tzav_tpos_100','-append')

clear






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

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_125')

t_ll = squeeze(cube2latlon(xc,yc,t_125,xi,yi));
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_125','t_ll')

t_ed_ll_sq = t_ed_ll.^2;
t_ed_mask_neg = +(t_ed_ll < 0);
t_ed_mask_pos = +(t_ed_ll > 0);

t_ll_tneg = t_ed_ll.^2.*t_ed_mask_neg;
t_ll_tpos = t_ed_ll.^2.*t_ed_mask_pos;

t_ll_tzav_125 = sqrt(squeeze(mean(mean(t_ed_ll_sq,1),4)))';
t_ll_tzav_tneg_125 = sqrt(squeeze(nanmean(nanmean(t_ll_tneg,1),4)))';
t_ll_tzav_tpos_125 = sqrt(squeeze(nanmean(nanmean(t_ll_tpos,1),4)))';


save('/project/rg312/mat_files/t_lat_means.mat','t_ll_tzav_125','t_ll_tzav_tneg_125','t_ll_tzav_tpos_125','-append')

clear








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

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_150')

t_ll = squeeze(cube2latlon(xc,yc,t_150,xi,yi));
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_150','t_ll')

t_ed_ll_sq = t_ed_ll.^2;
t_ed_mask_neg = +(t_ed_ll < 0);
t_ed_mask_pos = +(t_ed_ll > 0);

t_ll_tneg = t_ed_ll.^2.*t_ed_mask_neg;
t_ll_tpos = t_ed_ll.^2.*t_ed_mask_pos;

t_ll_tzav_150 = sqrt(squeeze(mean(mean(t_ed_ll_sq,1),4)))';
t_ll_tzav_tneg_150 = sqrt(squeeze(nanmean(nanmean(t_ll_tneg,1),4)))';
t_ll_tzav_tpos_150 = sqrt(squeeze(nanmean(nanmean(t_ll_tpos,1),4)))';


save('/project/rg312/mat_files/t_lat_means.mat','t_ll_tzav_150','t_ll_tzav_tneg_150','t_ll_tzav_tpos_150','-append')

clear

