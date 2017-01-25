
%load in data
% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_doshallower10/';
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

load('/project/rg312/mat_files/snapshot_data/vt_extreme_data.mat')
load('/project/rg312/mat_files/vt_lats.mat')
load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat')


%transfer t to ll
xi=-179:2:180;yi=-89:2:90;
t_000_ll = cube2latlon(xc,yc,t_000,xi,yi);
t_010_ll = cube2latlon(xc,yc,t_010,xi,yi);
t_025_ll = cube2latlon(xc,yc,t_025,xi,yi);
t_050_ll = cube2latlon(xc,yc,t_050,xi,yi);
t_075_ll = cube2latlon(xc,yc,t_075,xi,yi);
t_100_ll = cube2latlon(xc,yc,t_100,xi,yi);

%locate region of interest
t_000_n = squeeze(t_000_ll(:,x000n-7:x000n+7,:,:));
t_010_n = squeeze(t_010_ll(:,x010n-7:x010n+7,:,:));
t_025_n = squeeze(t_025_ll(:,x025n-7:x025n+7,:,:));
t_050_n = squeeze(t_050_ll(:,x050n-7:x050n+7,:,:));
t_075_n = squeeze(t_075_ll(:,x075n-7:x075n+7,:,:));
t_100_n = squeeze(t_100_ll(:,x100n-7:x100n+7,:,:));

t_000_s = squeeze(t_000_ll(:,x000s-7:x000s+7,:,:));
t_010_s = squeeze(t_010_ll(:,x010s-7:x010s+7,:,:));
t_025_s = squeeze(t_025_ll(:,x025s-7:x025s+7,:,:));
t_050_s = squeeze(t_050_ll(:,x050s-7:x050s+7,:,:));
t_075_s = squeeze(t_075_ll(:,x075s-7:x075s+7,:,:));
t_100_s = squeeze(t_100_ll(:,x100s-7:x100s+7,:,:));

%clear large matrices
clear('t_000_ll','t_010_ll','t_025_ll','t_050_ll','t_075_ll','t_100_ll','t_000','t_010','t_025','t_050','t_075','t_100')


for i=1:720

t_ed_000_n(:,:,:,i) = t_000_n(:,:,:,i) - mean(t_000_n,4);
t_ed_010_n(:,:,:,i) = t_010_n(:,:,:,i) - mean(t_010_n,4);
t_ed_025_n(:,:,:,i) = t_025_n(:,:,:,i) - mean(t_025_n,4);
t_ed_050_n(:,:,:,i) = t_050_n(:,:,:,i) - mean(t_050_n,4);
t_ed_075_n(:,:,:,i) = t_075_n(:,:,:,i) - mean(t_075_n,4);
t_ed_100_n(:,:,:,i) = t_100_n(:,:,:,i) - mean(t_100_n,4);

t_ed_000_s(:,:,:,i) = t_000_s(:,:,:,i) - mean(t_000_s,4);
t_ed_010_s(:,:,:,i) = t_010_s(:,:,:,i) - mean(t_010_s,4);
t_ed_025_s(:,:,:,i) = t_025_s(:,:,:,i) - mean(t_025_s,4);
t_ed_050_s(:,:,:,i) = t_050_s(:,:,:,i) - mean(t_050_s,4);
t_ed_075_s(:,:,:,i) = t_075_s(:,:,:,i) - mean(t_075_s,4);
t_ed_100_s(:,:,:,i) = t_100_s(:,:,:,i) - mean(t_100_s,4);


end

comp_t_000 = composite_fun(peaks_000,vt_thresh_000,t_000_n,t_000_s,'/project/rg312/mat_files/composite_data_ss/t_compdata_000.mat');
comp_t_010 = composite_fun(peaks_010,vt_thresh_010,t_010_n,t_010_s,'/project/rg312/mat_files/composite_data_ss/t_compdata_010.mat');
comp_t_025 = composite_fun(peaks_025,vt_thresh_025,t_025_n,t_025_s,'/project/rg312/mat_files/composite_data_ss/t_compdata_025.mat');
comp_t_050 = composite_fun(peaks_050,vt_thresh_050,t_050_n,t_050_s,'/project/rg312/mat_files/composite_data_ss/t_compdata_050.mat');
comp_t_075 = composite_fun(peaks_075,vt_thresh_075,t_075_n,t_075_s,'/project/rg312/mat_files/composite_data_ss/t_compdata_075.mat');
comp_t_100 = composite_fun(peaks_100,vt_thresh_100,t_100_n,t_100_s,'/project/rg312/mat_files/composite_data_ss/t_compdata_100.mat');


comp_ted_000 = composite_fun(peaks_000,vt_thresh_000,t_ed_000_n,t_ed_000_s,'/project/rg312/mat_files/composite_data_ss/ted_compdata_000.mat');
comp_ted_010 = composite_fun(peaks_010,vt_thresh_010,t_ed_010_n,t_ed_010_s,'/project/rg312/mat_files/composite_data_ss/ted_compdata_010.mat');
comp_ted_025 = composite_fun(peaks_025,vt_thresh_025,t_ed_025_n,t_ed_025_s,'/project/rg312/mat_files/composite_data_ss/ted_compdata_025.mat');
comp_ted_050 = composite_fun(peaks_050,vt_thresh_050,t_ed_050_n,t_ed_050_s,'/project/rg312/mat_files/composite_data_ss/ted_compdata_050.mat');
comp_ted_075 = composite_fun(peaks_075,vt_thresh_075,t_ed_075_n,t_ed_075_s,'/project/rg312/mat_files/composite_data_ss/ted_compdata_075.mat');
comp_ted_100 = composite_fun(peaks_100,vt_thresh_100,t_ed_100_n,t_ed_100_s,'/project/rg312/mat_files/composite_data_ss/ted_compdata_100.mat');

