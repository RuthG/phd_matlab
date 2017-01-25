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

vN_ll = squeeze(cube2latlon(xc,yc,vN_000,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_000','vN_ll')

vN_ed_ll_sq = vN_ed_ll.^2;
vN_ed_mask_neg = +(vN_ed_ll < 0);
vN_ed_mask_pos = +(vN_ed_ll > 0);

vN_ll_tneg = vN_ed_ll.^2.*vN_ed_mask_neg;
vN_ll_tpos = vN_ed_ll.^2.*vN_ed_mask_pos;

vN_ll_tzav_000 = sqrt(squeeze(mean(mean(vN_ed_ll_sq,1),4)))';
vN_ll_tzav_tneg_000 = sqrt(squeeze(nanmean(nanmean(vN_ll_tneg,1),4)))';
vN_ll_tzav_tpos_000 = sqrt(squeeze(nanmean(nanmean(vN_ll_tpos,1),4)))';


save('/project/rg312/mat_files/vN_lat_means.mat','vN_ll_tzav_000','vN_ll_tzav_tneg_000','vN_ll_tzav_tpos_000')

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

vN_ll = squeeze(cube2latlon(xc,yc,vN_010,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_010','vN_ll')

vN_ed_ll_sq = vN_ed_ll.^2;
vN_ed_mask_neg = +(vN_ed_ll < 0);
vN_ed_mask_pos = +(vN_ed_ll > 0);

vN_ll_tneg = vN_ed_ll.^2.*vN_ed_mask_neg;
vN_ll_tpos = vN_ed_ll.^2.*vN_ed_mask_pos;

vN_ll_tzav_010 = sqrt(squeeze(mean(mean(vN_ed_ll_sq,1),4)))';
vN_ll_tzav_tneg_010 = sqrt(squeeze(nanmean(nanmean(vN_ll_tneg,1),4)))';
vN_ll_tzav_tpos_010 = sqrt(squeeze(nanmean(nanmean(vN_ll_tpos,1),4)))';


save('/project/rg312/mat_files/vN_lat_means.mat','vN_ll_tzav_010','vN_ll_tzav_tneg_010','vN_ll_tzav_tpos_010','-append')

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

vN_ll = squeeze(cube2latlon(xc,yc,vN_025,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_025','vN_ll')

vN_ed_ll_sq = vN_ed_ll.^2;
vN_ed_mask_neg = +(vN_ed_ll < 0);
vN_ed_mask_pos = +(vN_ed_ll > 0);

vN_ll_tneg = vN_ed_ll.^2.*vN_ed_mask_neg;
vN_ll_tpos = vN_ed_ll.^2.*vN_ed_mask_pos;

vN_ll_tzav_025 = sqrt(squeeze(mean(mean(vN_ed_ll_sq,1),4)))';
vN_ll_tzav_tneg_025 = sqrt(squeeze(nanmean(nanmean(vN_ll_tneg,1),4)))';
vN_ll_tzav_tpos_025 = sqrt(squeeze(nanmean(nanmean(vN_ll_tpos,1),4)))';


save('/project/rg312/mat_files/vN_lat_means.mat','vN_ll_tzav_025','vN_ll_tzav_tneg_025','vN_ll_tzav_tpos_025','-append')

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

vN_ll = squeeze(cube2latlon(xc,yc,vN_050,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_050','vN_ll')

vN_ed_ll_sq = vN_ed_ll.^2;
vN_ed_mask_neg = +(vN_ed_ll < 0);
vN_ed_mask_pos = +(vN_ed_ll > 0);

vN_ll_tneg = vN_ed_ll.^2.*vN_ed_mask_neg;
vN_ll_tpos = vN_ed_ll.^2.*vN_ed_mask_pos;

vN_ll_tzav_050 = sqrt(squeeze(mean(mean(vN_ed_ll_sq,1),4)))';
vN_ll_tzav_tneg_050 = sqrt(squeeze(nanmean(nanmean(vN_ll_tneg,1),4)))';
vN_ll_tzav_tpos_050 = sqrt(squeeze(nanmean(nanmean(vN_ll_tpos,1),4)))';


save('/project/rg312/mat_files/vN_lat_means.mat','vN_ll_tzav_050','vN_ll_tzav_tneg_050','vN_ll_tzav_tpos_050','-append')

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

vN_ll = squeeze(cube2latlon(xc,yc,vN_075,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_075','vN_ll')

vN_ed_ll_sq = vN_ed_ll.^2;
vN_ed_mask_neg = +(vN_ed_ll < 0);
vN_ed_mask_pos = +(vN_ed_ll > 0);

vN_ll_tneg = vN_ed_ll.^2.*vN_ed_mask_neg;
vN_ll_tpos = vN_ed_ll.^2.*vN_ed_mask_pos;

vN_ll_tzav_075 = sqrt(squeeze(mean(mean(vN_ed_ll_sq,1),4)))';
vN_ll_tzav_tneg_075 = sqrt(squeeze(nanmean(nanmean(vN_ll_tneg,1),4)))';
vN_ll_tzav_tpos_075 = sqrt(squeeze(nanmean(nanmean(vN_ll_tpos,1),4)))';


save('/project/rg312/mat_files/vN_lat_means.mat','vN_ll_tzav_075','vN_ll_tzav_tneg_075','vN_ll_tzav_tpos_075','-append')

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

vN_ll = squeeze(cube2latlon(xc,yc,vN_100,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_100','vN_ll')

vN_ed_ll_sq = vN_ed_ll.^2;
vN_ed_mask_neg = +(vN_ed_ll < 0);
vN_ed_mask_pos = +(vN_ed_ll > 0);

vN_ll_tneg = vN_ed_ll.^2.*vN_ed_mask_neg;
vN_ll_tpos = vN_ed_ll.^2.*vN_ed_mask_pos;

vN_ll_tzav_100 = sqrt(squeeze(mean(mean(vN_ed_ll_sq,1),4)))';
vN_ll_tzav_tneg_100 = sqrt(squeeze(nanmean(nanmean(vN_ll_tneg,1),4)))';
vN_ll_tzav_tpos_100 = sqrt(squeeze(nanmean(nanmean(vN_ll_tpos,1),4)))';


save('/project/rg312/mat_files/vN_lat_means.mat','vN_ll_tzav_100','vN_ll_tzav_tneg_100','vN_ll_tzav_tpos_100','-append')

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

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_125')

vN_ll = squeeze(cube2latlon(xc,yc,vN_125,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_125','vN_ll')

vN_ed_ll_sq = vN_ed_ll.^2;
vN_ed_mask_neg = +(vN_ed_ll < 0);
vN_ed_mask_pos = +(vN_ed_ll > 0);

vN_ll_tneg = vN_ed_ll.^2.*vN_ed_mask_neg;
vN_ll_tpos = vN_ed_ll.^2.*vN_ed_mask_pos;

vN_ll_tzav_125 = sqrt(squeeze(mean(mean(vN_ed_ll_sq,1),4)))';
vN_ll_tzav_tneg_125 = sqrt(squeeze(nanmean(nanmean(vN_ll_tneg,1),4)))';
vN_ll_tzav_tpos_125 = sqrt(squeeze(nanmean(nanmean(vN_ll_tpos,1),4)))';


save('/project/rg312/mat_files/vN_lat_means.mat','vN_ll_tzav_125','vN_ll_tzav_tneg_125','vN_ll_tzav_tpos_125','-append')

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

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_150')

vN_ll = squeeze(cube2latlon(xc,yc,vN_150,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_150','vN_ll')

vN_ed_ll_sq = vN_ed_ll.^2;
vN_ed_mask_neg = +(vN_ed_ll < 0);
vN_ed_mask_pos = +(vN_ed_ll > 0);

vN_ll_tneg = vN_ed_ll.^2.*vN_ed_mask_neg;
vN_ll_tpos = vN_ed_ll.^2.*vN_ed_mask_pos;

vN_ll_tzav_150 = sqrt(squeeze(mean(mean(vN_ed_ll_sq,1),4)))';
vN_ll_tzav_tneg_150 = sqrt(squeeze(nanmean(nanmean(vN_ll_tneg,1),4)))';
vN_ll_tzav_tpos_150 = sqrt(squeeze(nanmean(nanmean(vN_ll_tpos,1),4)))';


save('/project/rg312/mat_files/vN_lat_means.mat','vN_ll_tzav_150','vN_ll_tzav_tneg_150','vN_ll_tzav_tpos_150','-append')

clear

