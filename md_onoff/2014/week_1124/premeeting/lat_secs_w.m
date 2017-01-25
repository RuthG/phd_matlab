%locate peaks that are in centre of latitude band (i.e. at max v'T') and produce latitude cross sections for these


%load in data

load('/project/rg312/mat_files/vt_extreme_data.mat')
load('/project/rg312/mat_files/vt_lats.mat')
load('/project/rg312/mat_files/w_snapshots_saved.mat')

%transfer w to ll
xi=-179:2:180;yi=-89:2:90;
w_000_ll = cube2latlon(xc,yc,w_000,xi,yi);
w_010_ll = cube2latlon(xc,yc,w_010,xi,yi);
w_025_ll = cube2latlon(xc,yc,w_025,xi,yi);
w_050_ll = cube2latlon(xc,yc,w_050,xi,yi);
w_075_ll = cube2latlon(xc,yc,w_075,xi,yi);
w_100_ll = cube2latlon(xc,yc,w_100,xi,yi);

%locate region of interest
w_000_lev = squeeze(w_000_ll(:,x000-7:x000+7,:,:));
w_010_lev = squeeze(w_010_ll(:,x010-7:x010+7,:,:));
w_025_lev = squeeze(w_025_ll(:,x025-7:x025+7,:,:));
w_050_lev = squeeze(w_050_ll(:,x050-7:x050+7,:,:));
w_075_lev = squeeze(w_075_ll(:,x075-7:x075+7,:,:));
w_100_lev = squeeze(w_100_ll(:,x100-7:x100+7,:,:));

%clear large matrices
clear('w_000_ll','w_010_ll','w_025_ll','w_050_ll','w_075_ll','w_100_ll','w_000','w_010','w_025','w_050','w_075','w_100')

comp_w_000 = lat_composite_fun(peaks_000,vt_thresh_000,w_000_lev,'/project/rg312/mat_files/w_compdatalat_000.mat');
comp_w_010 = lat_composite_fun(peaks_010,vt_thresh_010,w_010_lev,'/project/rg312/mat_files/w_compdatalat_010.mat');
comp_w_025 = lat_composite_fun(peaks_025,vt_thresh_025,w_025_lev,'/project/rg312/mat_files/w_compdatalat_025.mat');
comp_w_050 = lat_composite_fun(peaks_050,vt_thresh_050,w_050_lev,'/project/rg312/mat_files/w_compdatalat_050.mat');
comp_w_075 = lat_composite_fun(peaks_075,vt_thresh_075,w_075_lev,'/project/rg312/mat_files/w_compdatalat_075.mat');
comp_w_100 = lat_composite_fun(peaks_100,vt_thresh_100,w_100_lev,'/project/rg312/mat_files/w_compdatalat_100.mat');