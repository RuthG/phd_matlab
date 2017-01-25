
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
load('/project/rg312/mat_files/snapshot_data/theta_snapshots.mat')


%transfer theta to ll
xi=-179:2:180;yi=-89:2:90;
theta_000_ll = cube2latlon(xc,yc,theta_000,xi,yi);
theta_010_ll = cube2latlon(xc,yc,theta_010,xi,yi);
theta_025_ll = cube2latlon(xc,yc,theta_025,xi,yi);
theta_050_ll = cube2latlon(xc,yc,theta_050,xi,yi);
theta_075_ll = cube2latlon(xc,yc,theta_075,xi,yi);
theta_100_ll = cube2latlon(xc,yc,theta_100,xi,yi);

%locate region of interest
theta_000_n = squeeze(theta_000_ll(:,x000n-7:x000n+7,:,:));
theta_010_n = squeeze(theta_010_ll(:,x010n-7:x010n+7,:,:));
theta_025_n = squeeze(theta_025_ll(:,x025n-7:x025n+7,:,:));
theta_050_n = squeeze(theta_050_ll(:,x050n-7:x050n+7,:,:));
theta_075_n = squeeze(theta_075_ll(:,x075n-7:x075n+7,:,:));
theta_100_n = squeeze(theta_100_ll(:,x100n-7:x100n+7,:,:));

theta_000_s = squeeze(theta_000_ll(:,x000s-7:x000s+7,:,:));
theta_010_s = squeeze(theta_010_ll(:,x010s-7:x010s+7,:,:));
theta_025_s = squeeze(theta_025_ll(:,x025s-7:x025s+7,:,:));
theta_050_s = squeeze(theta_050_ll(:,x050s-7:x050s+7,:,:));
theta_075_s = squeeze(theta_075_ll(:,x075s-7:x075s+7,:,:));
theta_100_s = squeeze(theta_100_ll(:,x100s-7:x100s+7,:,:));


%clear large matrices
clear('theta_000_ll','theta_010_ll','theta_025_ll','theta_050_ll','theta_075_ll','theta_100_ll','theta_000','theta_010','theta_025','theta_050','theta_075','theta_100')

for i=1:720

theta_ed_000_n(:,:,:,i) = theta_000_n(:,:,:,i) - mean(theta_000_n,4);
theta_ed_010_n(:,:,:,i) = theta_010_n(:,:,:,i) - mean(theta_010_n,4);
theta_ed_025_n(:,:,:,i) = theta_025_n(:,:,:,i) - mean(theta_025_n,4);
theta_ed_050_n(:,:,:,i) = theta_050_n(:,:,:,i) - mean(theta_050_n,4);
theta_ed_075_n(:,:,:,i) = theta_075_n(:,:,:,i) - mean(theta_075_n,4);
theta_ed_100_n(:,:,:,i) = theta_100_n(:,:,:,i) - mean(theta_100_n,4);

theta_ed_000_s(:,:,:,i) = theta_000_s(:,:,:,i) - mean(theta_000_s,4);
theta_ed_010_s(:,:,:,i) = theta_010_s(:,:,:,i) - mean(theta_010_s,4);
theta_ed_025_s(:,:,:,i) = theta_025_s(:,:,:,i) - mean(theta_025_s,4);
theta_ed_050_s(:,:,:,i) = theta_050_s(:,:,:,i) - mean(theta_050_s,4);
theta_ed_075_s(:,:,:,i) = theta_075_s(:,:,:,i) - mean(theta_075_s,4);
theta_ed_100_s(:,:,:,i) = theta_100_s(:,:,:,i) - mean(theta_100_s,4);

end

comp_theta_000 = composite_fun(peaks_000,vt_thresh_000,theta_000_n,theta_000_s,'/project/rg312/mat_files/composite_data_ss/theta_compdata_000.mat');
comp_theta_010 = composite_fun(peaks_010,vt_thresh_010,theta_010_n,theta_010_s,'/project/rg312/mat_files/composite_data_ss/theta_compdata_010.mat');
comp_theta_025 = composite_fun(peaks_025,vt_thresh_025,theta_025_n,theta_025_s,'/project/rg312/mat_files/composite_data_ss/theta_compdata_025.mat');
comp_theta_050 = composite_fun(peaks_050,vt_thresh_050,theta_050_n,theta_050_s,'/project/rg312/mat_files/composite_data_ss/theta_compdata_050.mat');
comp_theta_075 = composite_fun(peaks_075,vt_thresh_075,theta_075_n,theta_075_s,'/project/rg312/mat_files/composite_data_ss/theta_compdata_075.mat');
comp_theta_100 = composite_fun(peaks_100,vt_thresh_100,theta_100_n,theta_100_s,'/project/rg312/mat_files/composite_data_ss/theta_compdata_100.mat');


comp_thed_000 = composite_fun(peaks_000,vt_thresh_000,theta_ed_000_n,theta_ed_000_s,'/project/rg312/mat_files/composite_data_ss/thed_compdata_000.mat');
comp_thed_010 = composite_fun(peaks_010,vt_thresh_010,theta_ed_010_n,theta_ed_010_s,'/project/rg312/mat_files/composite_data_ss/thed_compdata_010.mat');
comp_thed_025 = composite_fun(peaks_025,vt_thresh_025,theta_ed_025_n,theta_ed_025_s,'/project/rg312/mat_files/composite_data_ss/thed_compdata_025.mat');
comp_thed_050 = composite_fun(peaks_050,vt_thresh_050,theta_ed_050_n,theta_ed_050_s,'/project/rg312/mat_files/composite_data_ss/thed_compdata_050.mat');
comp_thed_075 = composite_fun(peaks_075,vt_thresh_075,theta_ed_075_n,theta_ed_075_s,'/project/rg312/mat_files/composite_data_ss/thed_compdata_075.mat');
comp_thed_100 = composite_fun(peaks_100,vt_thresh_100,theta_ed_100_n,theta_ed_100_s,'/project/rg312/mat_files/composite_data_ss/thed_compdata_100.mat');

