%load in vt data etc and use to get composites out

%load in data

load('/project/rg312/mat_files/vt_extreme_data.mat')
load('/project/rg312/mat_files/vt_lats.mat')
load('/project/rg312/mat_files/thetaq.mat')


%transfer w to ll
xi=-179:2:180;yi=-89:2:90;
theta_000_ll = cube2latlon(xc,yc,theta_000,xi,yi);
'll theta000 done'
theta_010_ll = cube2latlon(xc,yc,theta_010,xi,yi);
'll theta010 done'
theta_025_ll = cube2latlon(xc,yc,theta_025,xi,yi);
'll theta025 done'
theta_050_ll = cube2latlon(xc,yc,theta_050,xi,yi);
'll theta050 done'
theta_075_ll = cube2latlon(xc,yc,theta_075,xi,yi);
'll theta075 done'
theta_100_ll = cube2latlon(xc,yc,theta_100,xi,yi);

'll theta done'

for i=1:720
th_ed_000_ll(:,:,:,i) = theta_000_ll(:,:,:,i) - mean(theta_000_ll,4);
th_ed_010_ll(:,:,:,i) = theta_010_ll(:,:,:,i) - mean(theta_010_ll,4);
th_ed_025_ll(:,:,:,i) = theta_025_ll(:,:,:,i) - mean(theta_025_ll,4);
th_ed_050_ll(:,:,:,i) = theta_050_ll(:,:,:,i) - mean(theta_050_ll,4);
th_ed_075_ll(:,:,:,i) = theta_075_ll(:,:,:,i) - mean(theta_075_ll,4);
th_ed_100_ll(:,:,:,i) = theta_100_ll(:,:,:,i) - mean(theta_100_ll,4);
end

%locate region of interest
th_ed_000_lev = squeeze(th_ed_000_ll(:,x000-7:x000+7,:,:));
th_ed_010_lev = squeeze(th_ed_010_ll(:,x010-7:x010+7,:,:));
th_ed_025_lev = squeeze(th_ed_025_ll(:,x025-7:x025+7,:,:));
th_ed_050_lev = squeeze(th_ed_050_ll(:,x050-7:x050+7,:,:));
th_ed_075_lev = squeeze(th_ed_075_ll(:,x075-7:x075+7,:,:));
th_ed_100_lev = squeeze(th_ed_100_ll(:,x100-7:x100+7,:,:));

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

'll q done'

for i=1:720
q_ed_000_ll(:,:,:,i) = q_000_ll(:,:,:,i) - mean(q_000_ll,4);
q_ed_010_ll(:,:,:,i) = q_010_ll(:,:,:,i) - mean(q_010_ll,4);
q_ed_025_ll(:,:,:,i) = q_025_ll(:,:,:,i) - mean(q_025_ll,4);
q_ed_050_ll(:,:,:,i) = q_050_ll(:,:,:,i) - mean(q_050_ll,4);
q_ed_075_ll(:,:,:,i) = q_075_ll(:,:,:,i) - mean(q_075_ll,4);
q_ed_100_ll(:,:,:,i) = q_100_ll(:,:,:,i) - mean(q_100_ll,4);
end

%locate region of interest
q_ed_000_lev = squeeze(q_ed_000_ll(:,x000-7:x000+7,:,:));
q_ed_010_lev = squeeze(q_ed_010_ll(:,x010-7:x010+7,:,:));
q_ed_025_lev = squeeze(q_ed_025_ll(:,x025-7:x025+7,:,:));
q_ed_050_lev = squeeze(q_ed_050_ll(:,x050-7:x050+7,:,:));
q_ed_075_lev = squeeze(q_ed_075_ll(:,x075-7:x075+7,:,:));
q_ed_100_lev = squeeze(q_ed_100_ll(:,x100-7:x100+7,:,:));

%clear large matrices
clear('q_000_ll','q_010_ll','q_025_ll','q_050_ll','q_075_ll','q_100_ll','q_000','q_010','q_025','q_050','q_075','q_100')


comp_th_ed_000 = composite_fun(peaks_000,vt_thresh_000,th_ed_000_lev,'/project/rg312/mat_files/th_ed_compdata_000.mat');
comp_th_ed_010 = composite_fun(peaks_010,vt_thresh_010,th_ed_010_lev,'/project/rg312/mat_files/th_ed_compdata_010.mat');
comp_th_ed_025 = composite_fun(peaks_025,vt_thresh_025,th_ed_025_lev,'/project/rg312/mat_files/th_ed_compdata_025.mat');
comp_th_ed_050 = composite_fun(peaks_050,vt_thresh_050,th_ed_050_lev,'/project/rg312/mat_files/th_ed_compdata_050.mat');
comp_th_ed_075 = composite_fun(peaks_075,vt_thresh_075,th_ed_075_lev,'/project/rg312/mat_files/th_ed_compdata_075.mat');
comp_th_ed_100 = composite_fun(peaks_100,vt_thresh_100,th_ed_100_lev,'/project/rg312/mat_files/th_ed_compdata_100.mat');


comp_q_ed_000 = composite_fun(peaks_000,vt_thresh_000,q_ed_000_lev,'/project/rg312/mat_files/q_ed_compdata_000.mat');
comp_q_ed_010 = composite_fun(peaks_010,vt_thresh_010,q_ed_010_lev,'/project/rg312/mat_files/q_ed_compdata_010.mat');
comp_q_ed_025 = composite_fun(peaks_025,vt_thresh_025,q_ed_025_lev,'/project/rg312/mat_files/q_ed_compdata_025.mat');
comp_q_ed_050 = composite_fun(peaks_050,vt_thresh_050,q_ed_050_lev,'/project/rg312/mat_files/q_ed_compdata_050.mat');
comp_q_ed_075 = composite_fun(peaks_075,vt_thresh_075,q_ed_075_lev,'/project/rg312/mat_files/q_ed_compdata_075.mat');
comp_q_ed_100 = composite_fun(peaks_100,vt_thresh_100,q_ed_100_lev,'/project/rg312/mat_files/q_ed_compdata_100.mat');

