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

%load('/project/rg312/mat_files/vq_lats_best.mat')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_000')
load('/project/rg312/mat_files/snapshot_data/q_snapshots_best.mat','q_000')

q_ll = squeeze(cube2latlon(xc,yc,q_000,xi,yi));
q_ll_tav = repmat(mean(q_ll,4),[1 1 1 720]);
q_ed_ll = q_ll - q_ll_tav;
clear('q_000','q_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_000,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_000','vN_ll')

vNq_ed_ll = vN_ed_ll.*q_ed_ll;

q_ed_mask_neg = +(q_ed_ll < 0);
q_ed_mask_pos = +(q_ed_ll > 0);

vNq_ll_tneg = vNq_ed_ll.*q_ed_mask_neg;
vNq_ll_tpos = vNq_ed_ll.*q_ed_mask_pos;

vNq_ll_tzav_000 = squeeze(mean(mean(vNq_ed_ll,1),4))';
vNq_ll_tzav_tneg_000 = squeeze(nanmean(nanmean(vNq_ll_tneg,1),4))';
vNq_ll_tzav_tpos_000 = squeeze(nanmean(nanmean(vNq_ll_tpos,1),4))';


save('/project/rg312/mat_files/vq_lat_means.mat','vNq_ll_tzav_000','vNq_ll_tzav_tneg_000','vNq_ll_tzav_tpos_000')

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

load('/project/rg312/mat_files/vq_lats_best.mat')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_010')
load('/project/rg312/mat_files/snapshot_data/q_snapshots_best.mat','q_010')

q_ll = squeeze(cube2latlon(xc,yc,q_010,xi,yi));
q_ll_tav = repmat(mean(q_ll,4),[1 1 1 720]);
q_ed_ll = q_ll - q_ll_tav;
clear('q_010','q_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_010,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_010','vN_ll')

vNq_ed_ll = vN_ed_ll.*q_ed_ll;

q_ed_mask_neg = +(q_ed_ll < 0);
q_ed_mask_pos = +(q_ed_ll > 0);

vNq_ll_tneg = vNq_ed_ll.*q_ed_mask_neg;
vNq_ll_tpos = vNq_ed_ll.*q_ed_mask_pos;

vNq_ll_tzav_010 = squeeze(mean(mean(vNq_ed_ll,1),4))';
vNq_ll_tzav_tneg_010 = squeeze(nanmean(nanmean(vNq_ll_tneg,1),4))';
vNq_ll_tzav_tpos_010 = squeeze(nanmean(nanmean(vNq_ll_tpos,1),4))';


save('/project/rg312/mat_files/vq_lat_means.mat','vNq_ll_tzav_010','vNq_ll_tzav_tneg_010','vNq_ll_tzav_tpos_010','-append')


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

load('/project/rg312/mat_files/vq_lats_best.mat')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_025')
load('/project/rg312/mat_files/snapshot_data/q_snapshots_best.mat','q_025')

q_ll = squeeze(cube2latlon(xc,yc,q_025,xi,yi));
q_ll_tav = repmat(mean(q_ll,4),[1 1 1 720]);
q_ed_ll = q_ll - q_ll_tav;
clear('q_025','q_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_025,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_025','vN_ll')

vNq_ed_ll = vN_ed_ll.*q_ed_ll;

q_ed_mask_neg = +(q_ed_ll < 0);
q_ed_mask_pos = +(q_ed_ll > 0);

vNq_ll_tneg = vNq_ed_ll.*q_ed_mask_neg;
vNq_ll_tpos = vNq_ed_ll.*q_ed_mask_pos;

vNq_ll_tzav_025 = squeeze(mean(mean(vNq_ed_ll,1),4))';
vNq_ll_tzav_tneg_025 = squeeze(nanmean(nanmean(vNq_ll_tneg,1),4))';
vNq_ll_tzav_tpos_025 = squeeze(nanmean(nanmean(vNq_ll_tpos,1),4))';


save('/project/rg312/mat_files/vq_lat_means.mat','vNq_ll_tzav_025','vNq_ll_tzav_tneg_025','vNq_ll_tzav_tpos_025','-append')




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

load('/project/rg312/mat_files/vq_lats_best.mat')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_050')
load('/project/rg312/mat_files/snapshot_data/q_snapshots_best.mat','q_050')

q_ll = squeeze(cube2latlon(xc,yc,q_050,xi,yi));
q_ll_tav = repmat(mean(q_ll,4),[1 1 1 720]);
q_ed_ll = q_ll - q_ll_tav;
clear('q_050','q_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_050,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_050','vN_ll')

vNq_ed_ll = vN_ed_ll.*q_ed_ll;

q_ed_mask_neg = +(q_ed_ll < 0);
q_ed_mask_pos = +(q_ed_ll > 0);

vNq_ll_tneg = vNq_ed_ll.*q_ed_mask_neg;
vNq_ll_tpos = vNq_ed_ll.*q_ed_mask_pos;

vNq_ll_tzav_050 = squeeze(mean(mean(vNq_ed_ll,1),4))';
vNq_ll_tzav_tneg_050 = squeeze(nanmean(nanmean(vNq_ll_tneg,1),4))';
vNq_ll_tzav_tpos_050 = squeeze(nanmean(nanmean(vNq_ll_tpos,1),4))';


save('/project/rg312/mat_files/vq_lat_means.mat','vNq_ll_tzav_050','vNq_ll_tzav_tneg_050','vNq_ll_tzav_tpos_050','-append')



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

load('/project/rg312/mat_files/vq_lats_best.mat')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_075')
load('/project/rg312/mat_files/snapshot_data/q_snapshots_best.mat','q_075')

q_ll = squeeze(cube2latlon(xc,yc,q_075,xi,yi));
q_ll_tav = repmat(mean(q_ll,4),[1 1 1 720]);
q_ed_ll = q_ll - q_ll_tav;
clear('q_075','q_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_075,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_075','vN_ll')

vNq_ed_ll = vN_ed_ll.*q_ed_ll;

q_ed_mask_neg = +(q_ed_ll < 0);
q_ed_mask_pos = +(q_ed_ll > 0);

vNq_ll_tneg = vNq_ed_ll.*q_ed_mask_neg;
vNq_ll_tpos = vNq_ed_ll.*q_ed_mask_pos;

vNq_ll_tzav_075 = squeeze(mean(mean(vNq_ed_ll,1),4))';
vNq_ll_tzav_tneg_075 = squeeze(nanmean(nanmean(vNq_ll_tneg,1),4))';
vNq_ll_tzav_tpos_075 = squeeze(nanmean(nanmean(vNq_ll_tpos,1),4))';


save('/project/rg312/mat_files/vq_lat_means.mat','vNq_ll_tzav_075','vNq_ll_tzav_tneg_075','vNq_ll_tzav_tpos_075','-append')




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

load('/project/rg312/mat_files/vq_lats_best.mat')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_100')
load('/project/rg312/mat_files/snapshot_data/q_snapshots_best.mat','q_100')

q_ll = squeeze(cube2latlon(xc,yc,q_100,xi,yi));
q_ll_tav = repmat(mean(q_ll,4),[1 1 1 720]);
q_ed_ll = q_ll - q_ll_tav;
clear('q_100','q_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_100,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_100','vN_ll')

vNq_ed_ll = vN_ed_ll.*q_ed_ll;

q_ed_mask_neg = +(q_ed_ll < 0);
q_ed_mask_pos = +(q_ed_ll > 0);

vNq_ll_tneg = vNq_ed_ll.*q_ed_mask_neg;
vNq_ll_tpos = vNq_ed_ll.*q_ed_mask_pos;

vNq_ll_tzav_100 = squeeze(mean(mean(vNq_ed_ll,1),4))';
vNq_ll_tzav_tneg_100 = squeeze(nanmean(nanmean(vNq_ll_tneg,1),4))';
vNq_ll_tzav_tpos_100 = squeeze(nanmean(nanmean(vNq_ll_tpos,1),4))';


save('/project/rg312/mat_files/vq_lat_means.mat','vNq_ll_tzav_100','vNq_ll_tzav_tneg_100','vNq_ll_tzav_tpos_100','-append')







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

load('/project/rg312/mat_files/vq_lats_best.mat')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_125')
load('/project/rg312/mat_files/snapshot_data/q_snapshots_best.mat','q_125')

q_ll = squeeze(cube2latlon(xc,yc,q_125,xi,yi));
q_ll_tav = repmat(mean(q_ll,4),[1 1 1 720]);
q_ed_ll = q_ll - q_ll_tav;
clear('q_125','q_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_125,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_125','vN_ll')

vNq_ed_ll = vN_ed_ll.*q_ed_ll;

q_ed_mask_neg = +(q_ed_ll < 0);
q_ed_mask_pos = +(q_ed_ll > 0);

vNq_ll_tneg = vNq_ed_ll.*q_ed_mask_neg;
vNq_ll_tpos = vNq_ed_ll.*q_ed_mask_pos;

vNq_ll_tzav_125 = squeeze(mean(mean(vNq_ed_ll,1),4))';
vNq_ll_tzav_tneg_125 = squeeze(nanmean(nanmean(vNq_ll_tneg,1),4))';
vNq_ll_tzav_tpos_125 = squeeze(nanmean(nanmean(vNq_ll_tpos,1),4))';


save('/project/rg312/mat_files/vq_lat_means.mat','vNq_ll_tzav_125','vNq_ll_tzav_tneg_125','vNq_ll_tzav_tpos_125','-append')








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

load('/project/rg312/mat_files/vq_lats_best.mat')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_150')
load('/project/rg312/mat_files/snapshot_data/q_snapshots_best.mat','q_150')

q_ll = squeeze(cube2latlon(xc,yc,q_150,xi,yi));
q_ll_tav = repmat(mean(q_ll,4),[1 1 1 720]);
q_ed_ll = q_ll - q_ll_tav;
clear('q_150','q_ll')

vN_ll = squeeze(cube2latlon(xc,yc,vN_150,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_150','vN_ll')

vNq_ed_ll = vN_ed_ll.*q_ed_ll;

q_ed_mask_neg = +(q_ed_ll < 0);
q_ed_mask_pos = +(q_ed_ll > 0);

vNq_ll_tneg = vNq_ed_ll.*q_ed_mask_neg;
vNq_ll_tpos = vNq_ed_ll.*q_ed_mask_pos;

vNq_ll_tzav_150 = squeeze(mean(mean(vNq_ed_ll,1),4))';
vNq_ll_tzav_tneg_150 = squeeze(nanmean(nanmean(vNq_ll_tneg,1),4))';
vNq_ll_tzav_tpos_150 = squeeze(nanmean(nanmean(vNq_ll_tpos,1),4))';


save('/project/rg312/mat_files/vq_lat_means.mat','vNq_ll_tzav_150','vNq_ll_tzav_tneg_150','vNq_ll_tzav_tpos_150','-append')




