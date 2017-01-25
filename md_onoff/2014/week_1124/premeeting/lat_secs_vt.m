%locate peaks that are in centre of latitude band (i.e. at max v'T') and produce latitude cross sections for these


%load in data

load('/project/rg312/mat_files/vt_extreme_data.mat')
load('/project/rg312/mat_files/vt_lats.mat')
load('/project/rg312/mat_files/vt_ed_data.mat')


comp_vt_000 = lat_composite_fun(peaks_000,vt_thresh_000,vt_ed_000,'/project/rg312/mat_files/vt_compdatalat_000.mat');
comp_vt_010 = lat_composite_fun(peaks_010,vt_thresh_010,vt_ed_010,'/project/rg312/mat_files/vt_compdatalat_010.mat');
comp_vt_025 = lat_composite_fun(peaks_025,vt_thresh_025,vt_ed_025,'/project/rg312/mat_files/vt_compdatalat_025.mat');
comp_vt_050 = lat_composite_fun(peaks_050,vt_thresh_050,vt_ed_050,'/project/rg312/mat_files/vt_compdatalat_050.mat');
comp_vt_075 = lat_composite_fun(peaks_075,vt_thresh_075,vt_ed_075,'/project/rg312/mat_files/vt_compdatalat_075.mat');
comp_vt_100 = lat_composite_fun(peaks_100,vt_thresh_100,vt_ed_100,'/project/rg312/mat_files/vt_compdatalat_100.mat');