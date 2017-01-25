%load in vt data etc and use to get composites out

%load in data

load('/project/rg312/mat_files/vt_extreme_data.mat')
load('/project/rg312/mat_files/vt_lats.mat')
load('/project/rg312/mat_files/heat_rates.mat')


%transfer to ll

xi=-179:2:180;yi=-89:2:90;
latht_000_ll = cube2latlon(xc,yc,cndht_000,xi,yi) + cube2latlon(xc,yc,cnvht_000,xi,yi);
latht_010_ll = cube2latlon(xc,yc,cndht_010,xi,yi) + cube2latlon(xc,yc,cnvht_010,xi,yi);
latht_025_ll = cube2latlon(xc,yc,cndht_025,xi,yi) + cube2latlon(xc,yc,cnvht_025,xi,yi);
latht_050_ll = cube2latlon(xc,yc,cndht_050,xi,yi) + cube2latlon(xc,yc,cnvht_050,xi,yi);
latht_075_ll = cube2latlon(xc,yc,cndht_075,xi,yi) + cube2latlon(xc,yc,cnvht_075,xi,yi);
latht_100_ll = cube2latlon(xc,yc,cndht_100,xi,yi) + cube2latlon(xc,yc,cnvht_100,xi,yi);

%locate region of interest
latht_000_lev = squeeze(latht_000_ll(:,x000-7:x000+7,:,:));
latht_010_lev = squeeze(latht_010_ll(:,x010-7:x010+7,:,:));
latht_025_lev = squeeze(latht_025_ll(:,x025-7:x025+7,:,:));
latht_050_lev = squeeze(latht_050_ll(:,x050-7:x050+7,:,:));
latht_075_lev = squeeze(latht_075_ll(:,x075-7:x075+7,:,:));
latht_100_lev = squeeze(latht_100_ll(:,x100-7:x100+7,:,:));

%clear large matrices
clear('latht_000_ll','latht_010_ll','latht_025_ll','latht_050_ll','latht_075_ll','latht_100_ll'...
,'cndht_000','cndht_010','cndht_025','cndht_050','cndht_075','cndht_100'...
,'cnvht_000','cnvht_010','cnvht_025','cnvht_050','cnvht_075','cnvht_100')


xi=-179:2:180;yi=-89:2:90;
htrt_000_ll = cube2latlon(xc,yc,htrt_000,xi,yi);
htrt_010_ll = cube2latlon(xc,yc,htrt_010,xi,yi);
htrt_025_ll = cube2latlon(xc,yc,htrt_025,xi,yi);
htrt_050_ll = cube2latlon(xc,yc,htrt_050,xi,yi);
htrt_075_ll = cube2latlon(xc,yc,htrt_075,xi,yi);
htrt_100_ll = cube2latlon(xc,yc,htrt_100,xi,yi);

%locate region of interest
htrt_000_lev = squeeze(htrt_000_ll(:,x000-7:x000+7,:,:));
htrt_010_lev = squeeze(htrt_010_ll(:,x010-7:x010+7,:,:));
htrt_025_lev = squeeze(htrt_025_ll(:,x025-7:x025+7,:,:));
htrt_050_lev = squeeze(htrt_050_ll(:,x050-7:x050+7,:,:));
htrt_075_lev = squeeze(htrt_075_ll(:,x075-7:x075+7,:,:));
htrt_100_lev = squeeze(htrt_100_ll(:,x100-7:x100+7,:,:));

%clear large matrices
clear('htrt_000_ll','htrt_010_ll','htrt_025_ll','htrt_050_ll','htrt_075_ll','htrt_100_ll'...
,'htrt_000','htrt_010','htrt_025','htrt_050','htrt_075','htrt_100')

xi=-179:2:180;yi=-89:2:90;
radht_000_ll = cube2latlon(xc,yc,radht_000,xi,yi);
radht_010_ll = cube2latlon(xc,yc,radht_010,xi,yi);
radht_025_ll = cube2latlon(xc,yc,radht_025,xi,yi);
radht_050_ll = cube2latlon(xc,yc,radht_050,xi,yi);
radht_075_ll = cube2latlon(xc,yc,radht_075,xi,yi);
radht_100_ll = cube2latlon(xc,yc,radht_100,xi,yi);

%locate region of interest
radht_000_lev = squeeze(radht_000_ll(:,x000-7:x000+7,:,:));
radht_010_lev = squeeze(radht_010_ll(:,x010-7:x010+7,:,:));
radht_025_lev = squeeze(radht_025_ll(:,x025-7:x025+7,:,:));
radht_050_lev = squeeze(radht_050_ll(:,x050-7:x050+7,:,:));
radht_075_lev = squeeze(radht_075_ll(:,x075-7:x075+7,:,:));
radht_100_lev = squeeze(radht_100_ll(:,x100-7:x100+7,:,:));

%clear large matrices
clear('radht_000_ll','radht_010_ll','radht_025_ll','radht_050_ll','radht_075_ll','radht_100_ll'...
,'radht_000','radht_010','radht_025','radht_050','radht_075','radht_100')

xi=-179:2:180;yi=-89:2:90;
difht_000_ll = cube2latlon(xc,yc,difht_000,xi,yi);
difht_010_ll = cube2latlon(xc,yc,difht_010,xi,yi);
difht_025_ll = cube2latlon(xc,yc,difht_025,xi,yi);
difht_050_ll = cube2latlon(xc,yc,difht_050,xi,yi);
difht_075_ll = cube2latlon(xc,yc,difht_075,xi,yi);
difht_100_ll = cube2latlon(xc,yc,difht_100,xi,yi);

%locate region of interest
difht_000_lev = squeeze(difht_000_ll(:,x000-7:x000+7,:,:));
difht_010_lev = squeeze(difht_010_ll(:,x010-7:x010+7,:,:));
difht_025_lev = squeeze(difht_025_ll(:,x025-7:x025+7,:,:));
difht_050_lev = squeeze(difht_050_ll(:,x050-7:x050+7,:,:));
difht_075_lev = squeeze(difht_075_ll(:,x075-7:x075+7,:,:));
difht_100_lev = squeeze(difht_100_ll(:,x100-7:x100+7,:,:));

%clear large matrices
clear('difht_000_ll','difht_010_ll','difht_025_ll','difht_050_ll','difht_075_ll','difht_100_ll'...
,'difht_000','difht_010','difht_025','difht_050','difht_075','difht_100')





comp_htrt_000 = composite_fun(peaks_000,vt_thresh_000,htrt_000_lev,'/project/rg312/mat_files/htrt_compdata_000.mat');
comp_htrt_010 = composite_fun(peaks_010,vt_thresh_010,htrt_010_lev,'/project/rg312/mat_files/htrt_compdata_010.mat');
comp_htrt_025 = composite_fun(peaks_025,vt_thresh_025,htrt_025_lev,'/project/rg312/mat_files/htrt_compdata_025.mat');
comp_htrt_050 = composite_fun(peaks_050,vt_thresh_050,htrt_050_lev,'/project/rg312/mat_files/htrt_compdata_050.mat');
comp_htrt_075 = composite_fun(peaks_075,vt_thresh_075,htrt_075_lev,'/project/rg312/mat_files/htrt_compdata_075.mat');
comp_htrt_100 = composite_fun(peaks_100,vt_thresh_100,htrt_100_lev,'/project/rg312/mat_files/htrt_compdata_100.mat');

comp_radht_000 = composite_fun(peaks_000,vt_thresh_000,radht_000_lev,'/project/rg312/mat_files/radht_compdata_000.mat');
comp_radht_010 = composite_fun(peaks_010,vt_thresh_010,radht_010_lev,'/project/rg312/mat_files/radht_compdata_010.mat');
comp_radht_025 = composite_fun(peaks_025,vt_thresh_025,radht_025_lev,'/project/rg312/mat_files/radht_compdata_025.mat');
comp_radht_050 = composite_fun(peaks_050,vt_thresh_050,radht_050_lev,'/project/rg312/mat_files/radht_compdata_050.mat');
comp_radht_075 = composite_fun(peaks_075,vt_thresh_075,radht_075_lev,'/project/rg312/mat_files/radht_compdata_075.mat');
comp_radht_100 = composite_fun(peaks_100,vt_thresh_100,radht_100_lev,'/project/rg312/mat_files/radht_compdata_100.mat');

comp_latht_000 = composite_fun(peaks_000,vt_thresh_000,latht_000_lev,'/project/rg312/mat_files/latht_compdata_000.mat');
comp_latht_010 = composite_fun(peaks_010,vt_thresh_010,latht_010_lev,'/project/rg312/mat_files/latht_compdata_010.mat');
comp_latht_025 = composite_fun(peaks_025,vt_thresh_025,latht_025_lev,'/project/rg312/mat_files/latht_compdata_025.mat');
comp_latht_050 = composite_fun(peaks_050,vt_thresh_050,latht_050_lev,'/project/rg312/mat_files/latht_compdata_050.mat');
comp_latht_075 = composite_fun(peaks_075,vt_thresh_075,latht_075_lev,'/project/rg312/mat_files/latht_compdata_075.mat');
comp_latht_100 = composite_fun(peaks_100,vt_thresh_100,latht_100_lev,'/project/rg312/mat_files/latht_compdata_100.mat');

comp_difht_000 = composite_fun(peaks_000,vt_thresh_000,difht_000_lev,'/project/rg312/mat_files/difht_compdata_000.mat');
comp_difht_010 = composite_fun(peaks_010,vt_thresh_010,difht_010_lev,'/project/rg312/mat_files/difht_compdata_010.mat');
comp_difht_025 = composite_fun(peaks_025,vt_thresh_025,difht_025_lev,'/project/rg312/mat_files/difht_compdata_025.mat');
comp_difht_050 = composite_fun(peaks_050,vt_thresh_050,difht_050_lev,'/project/rg312/mat_files/difht_compdata_050.mat');
comp_difht_075 = composite_fun(peaks_075,vt_thresh_075,difht_075_lev,'/project/rg312/mat_files/difht_compdata_075.mat');
comp_difht_100 = composite_fun(peaks_100,vt_thresh_100,difht_100_lev,'/project/rg312/mat_files/difht_compdata_100.mat');

