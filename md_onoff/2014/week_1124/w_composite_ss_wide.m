
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
load('/project/rg312/mat_files/snapshot_data/w_snapshots.mat')


%transfer w to ll
xi=-179:2:180;yi=-89:2:90;
w_000_ll = cube2latlon(xc,yc,w_000,xi,yi);
w_010_ll = cube2latlon(xc,yc,w_010,xi,yi);
w_025_ll = cube2latlon(xc,yc,w_025,xi,yi);
w_050_ll = cube2latlon(xc,yc,w_050,xi,yi);
w_075_ll = cube2latlon(xc,yc,w_075,xi,yi);
w_100_ll = cube2latlon(xc,yc,w_100,xi,yi);

%locate region of interest
w_000_n = squeeze(w_000_ll(:,x000n-7:x000n+7,:,:));
w_010_n = squeeze(w_010_ll(:,x010n-7:x010n+7,:,:));
w_025_n = squeeze(w_025_ll(:,x025n-7:x025n+7,:,:));
w_050_n = squeeze(w_050_ll(:,x050n-7:x050n+7,:,:));
w_075_n = squeeze(w_075_ll(:,x075n-7:x075n+7,:,:));
w_100_n = squeeze(w_100_ll(:,x100n-7:x100n+7,:,:));

w_000_s = squeeze(w_000_ll(:,x000s-7:x000s+7,:,:));
w_010_s = squeeze(w_010_ll(:,x010s-7:x010s+7,:,:));
w_025_s = squeeze(w_025_ll(:,x025s-7:x025s+7,:,:));
w_050_s = squeeze(w_050_ll(:,x050s-7:x050s+7,:,:));
w_075_s = squeeze(w_075_ll(:,x075s-7:x075s+7,:,:));
w_100_s = squeeze(w_100_ll(:,x100s-7:x100s+7,:,:));

%clear large matrices
clear('w_000_ll','w_010_ll','w_025_ll','w_050_ll','w_075_ll','w_100_ll','w_000','w_010','w_025','w_050','w_075','w_100')


comp_w_000 = composite_fun_wider(peaks_000,vt_thresh_000,w_000_n,w_000_s,'/project/rg312/mat_files/composite_data_ssw/w_compdata_000.mat');
comp_w_010 = composite_fun_wider(peaks_010,vt_thresh_010,w_010_n,w_000_s,'/project/rg312/mat_files/composite_data_ssw/w_compdata_010.mat');
comp_w_025 = composite_fun_wider(peaks_025,vt_thresh_025,w_025_n,w_000_s,'/project/rg312/mat_files/composite_data_ssw/w_compdata_025.mat');
comp_w_050 = composite_fun_wider(peaks_050,vt_thresh_050,w_050_n,w_000_s,'/project/rg312/mat_files/composite_data_ssw/w_compdata_050.mat');
comp_w_075 = composite_fun_wider(peaks_075,vt_thresh_075,w_075_n,w_000_s,'/project/rg312/mat_files/composite_data_ssw/w_compdata_075.mat');
comp_w_100 = composite_fun_wider(peaks_100,vt_thresh_100,w_100_n,w_000_s,'/project/rg312/mat_files/composite_data_ssw/w_compdata_100.mat');


