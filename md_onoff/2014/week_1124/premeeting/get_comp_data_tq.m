%load in vt data etc and use to get composites out

%load in data

load('/project/rg312/mat_files/vt_extreme_data.mat')
load('/project/rg312/mat_files/vt_lats.mat')
load('/project/rg312/mat_files/thetaq.mat')


%transfer w to ll
xi=-179:2:180;yi=-89:2:90;
theta_000_ll = cube2latlon(xc,yc,theta_000,xi,yi);
theta_010_ll = cube2latlon(xc,yc,theta_010,xi,yi);
theta_025_ll = cube2latlon(xc,yc,theta_025,xi,yi);
theta_050_ll = cube2latlon(xc,yc,theta_050,xi,yi);
theta_075_ll = cube2latlon(xc,yc,theta_075,xi,yi);
theta_100_ll = cube2latlon(xc,yc,theta_100,xi,yi);

%locate region of interest
theta_000_lev = squeeze(theta_000_ll(:,x000-7:x000+7,:,:));
theta_010_lev = squeeze(theta_010_ll(:,x010-7:x010+7,:,:));
theta_025_lev = squeeze(theta_025_ll(:,x025-7:x025+7,:,:));
theta_050_lev = squeeze(theta_050_ll(:,x050-7:x050+7,:,:));
theta_075_lev = squeeze(theta_075_ll(:,x075-7:x075+7,:,:));
theta_100_lev = squeeze(theta_100_ll(:,x100-7:x100+7,:,:));

%clear large matrices
clear('theta_000_ll','theta_010_ll','theta_025_ll','theta_050_ll','theta_075_ll','theta_100_ll'...
,'theta_000','theta_010','theta_025','theta_050','theta_075','theta_100')

%transfer w to ll
xi=-179:2:180;yi=-89:2:90;
q_000_ll = cube2latlon(xc,yc,q_000,xi,yi);
q_010_ll = cube2latlon(xc,yc,q_010,xi,yi);
q_025_ll = cube2latlon(xc,yc,q_025,xi,yi);
q_050_ll = cube2latlon(xc,yc,q_050,xi,yi);
q_075_ll = cube2latlon(xc,yc,q_075,xi,yi);
q_100_ll = cube2latlon(xc,yc,q_100,xi,yi);

%locate region of interest
q_000_lev = squeeze(q_000_ll(:,x000-7:x000+7,:,:));
q_010_lev = squeeze(q_010_ll(:,x010-7:x010+7,:,:));
q_025_lev = squeeze(q_025_ll(:,x025-7:x025+7,:,:));
q_050_lev = squeeze(q_050_ll(:,x050-7:x050+7,:,:));
q_075_lev = squeeze(q_075_ll(:,x075-7:x075+7,:,:));
q_100_lev = squeeze(q_100_ll(:,x100-7:x100+7,:,:));

%clear large matrices
clear('q_000_ll','q_010_ll','q_025_ll','q_050_ll','q_075_ll','q_100_ll','q_000','q_010','q_025','q_050','q_075','q_100')


comp_theta_000 = composite_fun(peaks_000,vt_thresh_000,theta_000_lev,'/project/rg312/mat_files/theta_compdata_000.mat');
comp_theta_010 = composite_fun(peaks_010,vt_thresh_010,theta_010_lev,'/project/rg312/mat_files/theta_compdata_010.mat');
comp_theta_025 = composite_fun(peaks_025,vt_thresh_025,theta_025_lev,'/project/rg312/mat_files/theta_compdata_025.mat');
comp_theta_050 = composite_fun(peaks_050,vt_thresh_050,theta_050_lev,'/project/rg312/mat_files/theta_compdata_050.mat');
comp_theta_075 = composite_fun(peaks_075,vt_thresh_075,theta_075_lev,'/project/rg312/mat_files/theta_compdata_075.mat');
comp_theta_100 = composite_fun(peaks_100,vt_thresh_100,theta_100_lev,'/project/rg312/mat_files/theta_compdata_100.mat');


comp_q_000 = composite_fun(peaks_000,vt_thresh_000,q_000_lev,'/project/rg312/mat_files/q_compdata_000.mat');
comp_q_010 = composite_fun(peaks_010,vt_thresh_010,q_010_lev,'/project/rg312/mat_files/q_compdata_010.mat');
comp_q_025 = composite_fun(peaks_025,vt_thresh_025,q_025_lev,'/project/rg312/mat_files/q_compdata_025.mat');
comp_q_050 = composite_fun(peaks_050,vt_thresh_050,q_050_lev,'/project/rg312/mat_files/q_compdata_050.mat');
comp_q_075 = composite_fun(peaks_075,vt_thresh_075,q_075_lev,'/project/rg312/mat_files/q_compdata_075.mat');
comp_q_100 = composite_fun(peaks_100,vt_thresh_100,q_100_lev,'/project/rg312/mat_files/q_compdata_100.mat');

