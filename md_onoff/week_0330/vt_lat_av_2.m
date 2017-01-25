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

t_ll = squeeze(cube2latlon(xc,yc,t_000,xi,yi));
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_000','t_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_000,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_000','vN_ll')

vNt_ed_ll = vN_ed_ll.*t_ed_ll;

t_ed_mask_neg = +(t_ed_ll < 0);
t_ed_mask_pos = +(t_ed_ll > 0);

vNt_ll_tneg = vNt_ed_ll.*t_ed_mask_neg;
vNt_ll_tpos = vNt_ed_ll.*t_ed_mask_pos;

vNt_ll_tzav_000 = squeeze(mean(mean(vNt_ed_ll,1),4))';
vNt_ll_tzav_tneg_000 = squeeze(nanmean(nanmean(vNt_ll_tneg,1),4))';
vNt_ll_tzav_tpos_000 = squeeze(nanmean(nanmean(vNt_ll_tpos,1),4))';


save('/project/rg312/mat_files/vt_lat_means_2.mat','vNt_ll_tzav_000','vNt_ll_tzav_tneg_000','vNt_ll_tzav_tpos_000')

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

t_ll = squeeze(cube2latlon(xc,yc,t_010,xi,yi));
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_010','t_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_010,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_010','vN_ll')

vNt_ed_ll = vN_ed_ll.*t_ed_ll;

t_ed_mask_neg = +(t_ed_ll < 0);
t_ed_mask_pos = +(t_ed_ll > 0);

vNt_ll_tneg = vNt_ed_ll.*t_ed_mask_neg;
vNt_ll_tpos = vNt_ed_ll.*t_ed_mask_pos;

vNt_ll_tzav_010 = squeeze(mean(mean(vNt_ed_ll,1),4))';
vNt_ll_tzav_tneg_010 = squeeze(nanmean(nanmean(vNt_ll_tneg,1),4))';
vNt_ll_tzav_tpos_010 = squeeze(nanmean(nanmean(vNt_ll_tpos,1),4))';


save('/project/rg312/mat_files/vt_lat_means_2.mat','vNt_ll_tzav_010','vNt_ll_tzav_tneg_010','vNt_ll_tzav_tpos_010','-append')


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

t_ll = squeeze(cube2latlon(xc,yc,t_025,xi,yi));
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_025','t_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_025,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_025','vN_ll')

vNt_ed_ll = vN_ed_ll.*t_ed_ll;

t_ed_mask_neg = +(t_ed_ll < 0);
t_ed_mask_pos = +(t_ed_ll > 0);

vNt_ll_tneg = vNt_ed_ll.*t_ed_mask_neg;
vNt_ll_tpos = vNt_ed_ll.*t_ed_mask_pos;

vNt_ll_tzav_025 = squeeze(mean(mean(vNt_ed_ll,1),4))';
vNt_ll_tzav_tneg_025 = squeeze(nanmean(nanmean(vNt_ll_tneg,1),4))';
vNt_ll_tzav_tpos_025 = squeeze(nanmean(nanmean(vNt_ll_tpos,1),4))';


save('/project/rg312/mat_files/vt_lat_means_2.mat','vNt_ll_tzav_025','vNt_ll_tzav_tneg_025','vNt_ll_tzav_tpos_025','-append')




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

t_ll = squeeze(cube2latlon(xc,yc,t_050,xi,yi));
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_050','t_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_050,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_050','vN_ll')

vNt_ed_ll = vN_ed_ll.*t_ed_ll;

t_ed_mask_neg = +(t_ed_ll < 0);
t_ed_mask_pos = +(t_ed_ll > 0);

vNt_ll_tneg = vNt_ed_ll.*t_ed_mask_neg;
vNt_ll_tpos = vNt_ed_ll.*t_ed_mask_pos;

vNt_ll_tzav_050 = squeeze(mean(mean(vNt_ed_ll,1),4))';
vNt_ll_tzav_tneg_050 = squeeze(nanmean(nanmean(vNt_ll_tneg,1),4))';
vNt_ll_tzav_tpos_050 = squeeze(nanmean(nanmean(vNt_ll_tpos,1),4))';


save('/project/rg312/mat_files/vt_lat_means_2.mat','vNt_ll_tzav_050','vNt_ll_tzav_tneg_050','vNt_ll_tzav_tpos_050','-append')



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

t_ll = squeeze(cube2latlon(xc,yc,t_075,xi,yi));
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_075','t_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_075,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_075','vN_ll')

vNt_ed_ll = vN_ed_ll.*t_ed_ll;

t_ed_mask_neg = +(t_ed_ll < 0);
t_ed_mask_pos = +(t_ed_ll > 0);

vNt_ll_tneg = vNt_ed_ll.*t_ed_mask_neg;
vNt_ll_tpos = vNt_ed_ll.*t_ed_mask_pos;

vNt_ll_tzav_075 = squeeze(mean(mean(vNt_ed_ll,1),4))';
vNt_ll_tzav_tneg_075 = squeeze(nanmean(nanmean(vNt_ll_tneg,1),4))';
vNt_ll_tzav_tpos_075 = squeeze(nanmean(nanmean(vNt_ll_tpos,1),4))';


save('/project/rg312/mat_files/vt_lat_means_2.mat','vNt_ll_tzav_075','vNt_ll_tzav_tneg_075','vNt_ll_tzav_tpos_075','-append')




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

t_ll = squeeze(cube2latlon(xc,yc,t_100,xi,yi));
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_100','t_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_100,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_100','vN_ll')

vNt_ed_ll = vN_ed_ll.*t_ed_ll;

t_ed_mask_neg = +(t_ed_ll < 0);
t_ed_mask_pos = +(t_ed_ll > 0);

vNt_ll_tneg = vNt_ed_ll.*t_ed_mask_neg;
vNt_ll_tpos = vNt_ed_ll.*t_ed_mask_pos;

vNt_ll_tzav_100 = squeeze(mean(mean(vNt_ed_ll,1),4))';
vNt_ll_tzav_tneg_100 = squeeze(nanmean(nanmean(vNt_ll_tneg,1),4))';
vNt_ll_tzav_tpos_100 = squeeze(nanmean(nanmean(vNt_ll_tpos,1),4))';


save('/project/rg312/mat_files/vt_lat_means_2.mat','vNt_ll_tzav_100','vNt_ll_tzav_tneg_100','vNt_ll_tzav_tpos_100','-append')







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

t_ll = squeeze(cube2latlon(xc,yc,t_125,xi,yi));
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_125','t_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_125,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_125','vN_ll')

vNt_ed_ll = vN_ed_ll.*t_ed_ll;

t_ed_mask_neg = +(t_ed_ll < 0);
t_ed_mask_pos = +(t_ed_ll > 0);

vNt_ll_tneg = vNt_ed_ll.*t_ed_mask_neg;
vNt_ll_tpos = vNt_ed_ll.*t_ed_mask_pos;

vNt_ll_tzav_125 = squeeze(mean(mean(vNt_ed_ll,1),4))';
vNt_ll_tzav_tneg_125 = squeeze(nanmean(nanmean(vNt_ll_tneg,1),4))';
vNt_ll_tzav_tpos_125 = squeeze(nanmean(nanmean(vNt_ll_tpos,1),4))';


save('/project/rg312/mat_files/vt_lat_means_2.mat','vNt_ll_tzav_125','vNt_ll_tzav_tneg_125','vNt_ll_tzav_tpos_125','-append')








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

t_ll = squeeze(cube2latlon(xc,yc,t_150,xi,yi));
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_150','t_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_150,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_150','vN_ll')

vNt_ed_ll = vN_ed_ll.*t_ed_ll;

t_ed_mask_neg = +(t_ed_ll < 0);
t_ed_mask_pos = +(t_ed_ll > 0);

vNt_ll_tneg = vNt_ed_ll.*t_ed_mask_neg;
vNt_ll_tpos = vNt_ed_ll.*t_ed_mask_pos;

vNt_ll_tzav_150 = squeeze(mean(mean(vNt_ed_ll,1),4))';
vNt_ll_tzav_tneg_150 = squeeze(nanmean(nanmean(vNt_ll_tneg,1),4))';
vNt_ll_tzav_tpos_150 = squeeze(nanmean(nanmean(vNt_ll_tpos,1),4))';


save('/project/rg312/mat_files/vt_lat_means_2.mat','vNt_ll_tzav_150','vNt_ll_tzav_tneg_150','vNt_ll_tzav_tpos_150','-append')




