%load in vt data etc and use to get composites out

%load in data

load('/project/rg312/mat_files/vt_extreme_data.mat')
load('/project/rg312/mat_files/vt_lats.mat')
load('/project/rg312/mat_files/vt_ed_data.mat')


comp_vt_000 = composite_fun(peaks_000,vt_thresh_000,vt_ed_000,'/project/rg312/mat_files/vt_compdata_000.mat');
comp_vt_010 = composite_fun(peaks_010,vt_thresh_010,vt_ed_010,'/project/rg312/mat_files/vt_compdata_010.mat');
comp_vt_025 = composite_fun(peaks_025,vt_thresh_025,vt_ed_025,'/project/rg312/mat_files/vt_compdata_025.mat');
comp_vt_050 = composite_fun(peaks_050,vt_thresh_050,vt_ed_050,'/project/rg312/mat_files/vt_compdata_050.mat');
comp_vt_075 = composite_fun(peaks_075,vt_thresh_075,vt_ed_075,'/project/rg312/mat_files/vt_compdata_075.mat');
comp_vt_100 = composite_fun(peaks_100,vt_thresh_100,vt_ed_100,'/project/rg312/mat_files/vt_compdata_100.mat');

