
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
load('/project/rg312/mat_files/snapshot_data/q_snapshots.mat')


%transfer q to ll
xi=-179:2:180;yi=-89:2:90;
q_000_ll = cube2latlon(xc,yc,q_000,xi,yi);
q_010_ll = cube2latlon(xc,yc,q_010,xi,yi);
q_025_ll = cube2latlon(xc,yc,q_025,xi,yi);
q_050_ll = cube2latlon(xc,yc,q_050,xi,yi);
q_075_ll = cube2latlon(xc,yc,q_075,xi,yi);
q_100_ll = cube2latlon(xc,yc,q_100,xi,yi);

%locate region of interest
q_000_n = squeeze(q_000_ll(:,x000n-7:x000n+7,:,:));
q_010_n = squeeze(q_010_ll(:,x010n-7:x010n+7,:,:));
q_025_n = squeeze(q_025_ll(:,x025n-7:x025n+7,:,:));
q_050_n = squeeze(q_050_ll(:,x050n-7:x050n+7,:,:));
q_075_n = squeeze(q_075_ll(:,x075n-7:x075n+7,:,:));
q_100_n = squeeze(q_100_ll(:,x100n-7:x100n+7,:,:));

q_000_s = squeeze(q_000_ll(:,x000s-7:x000s+7,:,:));
q_010_s = squeeze(q_010_ll(:,x010s-7:x010s+7,:,:));
q_025_s = squeeze(q_025_ll(:,x025s-7:x025s+7,:,:));
q_050_s = squeeze(q_050_ll(:,x050s-7:x050s+7,:,:));
q_075_s = squeeze(q_075_ll(:,x075s-7:x075s+7,:,:));
q_100_s = squeeze(q_100_ll(:,x100s-7:x100s+7,:,:));

%clear large matrices
clear('q_000_ll','q_010_ll','q_025_ll','q_050_ll','q_075_ll','q_100_ll','q_000','q_010','q_025','q_050','q_075','q_100')

for i=1:720

q_ed_000_n(:,:,:,i) = q_000_n(:,:,:,i) - mean(q_000_n,4);
q_ed_010_n(:,:,:,i) = q_010_n(:,:,:,i) - mean(q_010_n,4);
q_ed_025_n(:,:,:,i) = q_025_n(:,:,:,i) - mean(q_025_n,4);
q_ed_050_n(:,:,:,i) = q_050_n(:,:,:,i) - mean(q_050_n,4);
q_ed_075_n(:,:,:,i) = q_075_n(:,:,:,i) - mean(q_075_n,4);
q_ed_100_n(:,:,:,i) = q_100_n(:,:,:,i) - mean(q_100_n,4);

q_ed_000_s(:,:,:,i) = q_000_s(:,:,:,i) - mean(q_000_s,4);
q_ed_010_s(:,:,:,i) = q_010_s(:,:,:,i) - mean(q_010_s,4);
q_ed_025_s(:,:,:,i) = q_025_s(:,:,:,i) - mean(q_025_s,4);
q_ed_050_s(:,:,:,i) = q_050_s(:,:,:,i) - mean(q_050_s,4);
q_ed_075_s(:,:,:,i) = q_075_s(:,:,:,i) - mean(q_075_s,4);
q_ed_100_s(:,:,:,i) = q_100_s(:,:,:,i) - mean(q_100_s,4);


end


comp_q_000 = composite_fun(peaks_000,vt_thresh_000,q_000_n,q_000_s,'/project/rg312/mat_files/composite_data_ss/q_compdata_000.mat');
comp_q_010 = composite_fun(peaks_010,vt_thresh_010,q_010_n,q_010_s,'/project/rg312/mat_files/composite_data_ss/q_compdata_010.mat');
comp_q_025 = composite_fun(peaks_025,vt_thresh_025,q_025_n,q_025_s,'/project/rg312/mat_files/composite_data_ss/q_compdata_025.mat');
comp_q_050 = composite_fun(peaks_050,vt_thresh_050,q_050_n,q_050_s,'/project/rg312/mat_files/composite_data_ss/q_compdata_050.mat');
comp_q_075 = composite_fun(peaks_075,vt_thresh_075,q_075_n,q_075_s,'/project/rg312/mat_files/composite_data_ss/q_compdata_075.mat');
comp_q_100 = composite_fun(peaks_100,vt_thresh_100,q_100_n,q_100_s,'/project/rg312/mat_files/composite_data_ss/q_compdata_100.mat');

comp_qed_000 = composite_fun(peaks_000,vt_thresh_000,q_ed_000_n,q_ed_000_s,'/project/rg312/mat_files/composite_data_ss/qed_compdata_000.mat');
comp_qed_010 = composite_fun(peaks_010,vt_thresh_010,q_ed_010_n,q_ed_010_s,'/project/rg312/mat_files/composite_data_ss/qed_compdata_010.mat');
comp_qed_025 = composite_fun(peaks_025,vt_thresh_025,q_ed_025_n,q_ed_025_s,'/project/rg312/mat_files/composite_data_ss/qed_compdata_025.mat');
comp_qed_050 = composite_fun(peaks_050,vt_thresh_050,q_ed_050_n,q_ed_050_s,'/project/rg312/mat_files/composite_data_ss/qed_compdata_050.mat');
comp_qed_075 = composite_fun(peaks_075,vt_thresh_075,q_ed_075_n,q_ed_075_s,'/project/rg312/mat_files/composite_data_ss/qed_compdata_075.mat');
comp_qed_100 = composite_fun(peaks_100,vt_thresh_100,q_ed_100_n,q_ed_100_s,'/project/rg312/mat_files/composite_data_ss/qed_compdata_100.mat');

