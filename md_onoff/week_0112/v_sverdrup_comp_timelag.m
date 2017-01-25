%plot v composites with time lag to see if 100 run develops differently?


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

radius=6371.0e3;

load('/project/rg312/mat_files/snapshot_data/vt_extreme_data.mat')
load('/project/rg312/mat_files/vt_lats.mat')
load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')


%transfer v to ll
xi=-179:2:180;yi=-89:2:90;
v_000_ll = cube2latlon(xc,yc,vN_000,xi,yi);
v_010_ll = cube2latlon(xc,yc,vN_010,xi,yi);
v_025_ll = cube2latlon(xc,yc,vN_025,xi,yi);
v_050_ll = cube2latlon(xc,yc,vN_050,xi,yi);
v_075_ll = cube2latlon(xc,yc,vN_075,xi,yi);
v_100_ll = cube2latlon(xc,yc,vN_100,xi,yi);

v_000_tav = mean(v_000_ll,4);
v_010_tav = mean(v_010_ll,4);
v_025_tav = mean(v_025_ll,4);
v_050_tav = mean(v_050_ll,4);
v_075_tav = mean(v_075_ll,4);
v_100_tav = mean(v_100_ll,4);

%locate region of interest

for i=1:720

v_ed_000_n(:,:,:,i) = squeeze(v_000_ll(:,x000n-7:x000n+7,:,i) - v_000_tav(:,x000n-7:x000n+7,:) );
v_ed_010_n(:,:,:,i) = squeeze(v_010_ll(:,x010n-7:x010n+7,:,i) - v_010_tav(:,x010n-7:x010n+7,:) );
v_ed_025_n(:,:,:,i) = squeeze(v_025_ll(:,x025n-7:x025n+7,:,i) - v_025_tav(:,x025n-7:x025n+7,:) );
v_ed_050_n(:,:,:,i) = squeeze(v_050_ll(:,x050n-7:x050n+7,:,i) - v_050_tav(:,x050n-7:x050n+7,:) );
v_ed_075_n(:,:,:,i) = squeeze(v_075_ll(:,x075n-7:x075n+7,:,i) - v_075_tav(:,x075n-7:x075n+7,:) );
v_ed_100_n(:,:,:,i) = squeeze(v_100_ll(:,x100n-7:x100n+7,:,i) - v_100_tav(:,x100n-7:x100n+7,:) );

v_ed_000_s(:,:,:,i) = squeeze(v_000_ll(:,x000s-7:x000s+7,:,i) - v_000_tav(:,x000s-7:x000s+7,:) );
v_ed_010_s(:,:,:,i) = squeeze(v_010_ll(:,x010s-7:x010s+7,:,i) - v_010_tav(:,x010s-7:x010s+7,:) );
v_ed_025_s(:,:,:,i) = squeeze(v_025_ll(:,x025s-7:x025s+7,:,i) - v_025_tav(:,x025s-7:x025s+7,:) );
v_ed_050_s(:,:,:,i) = squeeze(v_050_ll(:,x050s-7:x050s+7,:,i) - v_050_tav(:,x050s-7:x050s+7,:) );
v_ed_075_s(:,:,:,i) = squeeze(v_075_ll(:,x075s-7:x075s+7,:,i) - v_075_tav(:,x075s-7:x075s+7,:) );
v_ed_100_s(:,:,:,i) = squeeze(v_100_ll(:,x100s-7:x100s+7,:,i) - v_100_tav(:,x100s-7:x100s+7,:) );

end

for i=1:15

v_fb_000_n(:,i,:,:) = v_ed_000_n(:,i,:,:).*cot( yi(x000n - 8 + i).*pi./180 )./radius;
v_fb_010_n(:,i,:,:) = v_ed_010_n(:,i,:,:).*cot( yi(x010n - 8 + i).*pi./180 )./radius;
v_fb_025_n(:,i,:,:) = v_ed_025_n(:,i,:,:).*cot( yi(x025n - 8 + i).*pi./180 )./radius;
v_fb_050_n(:,i,:,:) = v_ed_050_n(:,i,:,:).*cot( yi(x050n - 8 + i).*pi./180 )./radius;
v_fb_075_n(:,i,:,:) = v_ed_075_n(:,i,:,:).*cot( yi(x075n - 8 + i).*pi./180 )./radius;
v_fb_100_n(:,i,:,:) = v_ed_100_n(:,i,:,:).*cot( yi(x100n - 8 + i).*pi./180 )./radius;

v_fb_000_s(:,i,:,:) = v_ed_000_s(:,i,:,:).*cot( yi(x000s - 8 + i).*pi./180 )./radius;
v_fb_010_s(:,i,:,:) = v_ed_010_s(:,i,:,:).*cot( yi(x010s - 8 + i).*pi./180 )./radius;
v_fb_025_s(:,i,:,:) = v_ed_025_s(:,i,:,:).*cot( yi(x025s - 8 + i).*pi./180 )./radius;
v_fb_050_s(:,i,:,:) = v_ed_050_s(:,i,:,:).*cot( yi(x050s - 8 + i).*pi./180 )./radius;
v_fb_075_s(:,i,:,:) = v_ed_075_s(:,i,:,:).*cot( yi(x075s - 8 + i).*pi./180 )./radius;
v_fb_100_s(:,i,:,:) = v_ed_100_s(:,i,:,:).*cot( yi(x100s - 8 + i).*pi./180 )./radius;

v_fb_000_n_100(:,i,:,:) = v_ed_000_n(:,i,:,:).*cot( yi(x100n - 8 + i).*pi./180 )./radius;
v_fb_010_n_100(:,i,:,:) = v_ed_010_n(:,i,:,:).*cot( yi(x100n - 8 + i).*pi./180 )./radius;
v_fb_025_n_100(:,i,:,:) = v_ed_025_n(:,i,:,:).*cot( yi(x100n - 8 + i).*pi./180 )./radius;
v_fb_050_n_100(:,i,:,:) = v_ed_050_n(:,i,:,:).*cot( yi(x100n - 8 + i).*pi./180 )./radius;
v_fb_075_n_100(:,i,:,:) = v_ed_075_n(:,i,:,:).*cot( yi(x100n - 8 + i).*pi./180 )./radius;
v_fb_100_n_100(:,i,:,:) = v_ed_100_n(:,i,:,:).*cot( yi(x100n - 8 + i).*pi./180 )./radius;

v_fb_000_s_100(:,i,:,:) = v_ed_000_s(:,i,:,:).*cot( yi(x100s - 8 + i).*pi./180 )./radius;
v_fb_010_s_100(:,i,:,:) = v_ed_010_s(:,i,:,:).*cot( yi(x100s - 8 + i).*pi./180 )./radius;
v_fb_025_s_100(:,i,:,:) = v_ed_025_s(:,i,:,:).*cot( yi(x100s - 8 + i).*pi./180 )./radius;
v_fb_050_s_100(:,i,:,:) = v_ed_050_s(:,i,:,:).*cot( yi(x100s - 8 + i).*pi./180 )./radius;
v_fb_075_s_100(:,i,:,:) = v_ed_075_s(:,i,:,:).*cot( yi(x100s - 8 + i).*pi./180 )./radius;
v_fb_100_s_100(:,i,:,:) = v_ed_100_s(:,i,:,:).*cot( yi(x100s - 8 + i).*pi./180 )./radius;


v_fb_000_n_000(:,i,:,:) = v_ed_000_n(:,i,:,:).*cot( yi(x000n - 8 + i).*pi./180 )./radius;
v_fb_010_n_000(:,i,:,:) = v_ed_010_n(:,i,:,:).*cot( yi(x000n - 8 + i).*pi./180 )./radius;
v_fb_025_n_000(:,i,:,:) = v_ed_025_n(:,i,:,:).*cot( yi(x000n - 8 + i).*pi./180 )./radius;
v_fb_050_n_000(:,i,:,:) = v_ed_050_n(:,i,:,:).*cot( yi(x000n - 8 + i).*pi./180 )./radius;
v_fb_075_n_000(:,i,:,:) = v_ed_075_n(:,i,:,:).*cot( yi(x000n - 8 + i).*pi./180 )./radius;
v_fb_100_n_000(:,i,:,:) = v_ed_100_n(:,i,:,:).*cot( yi(x000n - 8 + i).*pi./180 )./radius;

v_fb_000_s_000(:,i,:,:) = v_ed_000_s(:,i,:,:).*cot( yi(x000s - 8 + i).*pi./180 )./radius;
v_fb_010_s_000(:,i,:,:) = v_ed_010_s(:,i,:,:).*cot( yi(x000s - 8 + i).*pi./180 )./radius;
v_fb_025_s_000(:,i,:,:) = v_ed_025_s(:,i,:,:).*cot( yi(x000s - 8 + i).*pi./180 )./radius;
v_fb_050_s_000(:,i,:,:) = v_ed_050_s(:,i,:,:).*cot( yi(x000s - 8 + i).*pi./180 )./radius;
v_fb_075_s_000(:,i,:,:) = v_ed_075_s(:,i,:,:).*cot( yi(x000s - 8 + i).*pi./180 )./radius;
v_fb_100_s_000(:,i,:,:) = v_ed_100_s(:,i,:,:).*cot( yi(x000s - 8 + i).*pi./180 )./radius;
end

%clear large matrices
clear('v_000_ll','v_010_ll','v_025_ll','v_050_ll','v_075_ll','v_100_ll','vN_000','vN_010','vN_025','vN_050','vN_075','vN_100')

%[comp_v_fb_000_m2,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,v_fb_000_n,v_fb_000_s,-2,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_000m2.mat');
%[comp_v_fb_000_m1,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,v_fb_000_n,v_fb_000_s,-1,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_000m1.mat');
[comp_v_fb_000_0,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,v_fb_000_n,v_fb_000_s,0,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_000.mat');
%[comp_v_fb_000_p1,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,v_fb_000_n,v_fb_000_s,1,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_000p1.mat');
%[comp_v_fb_000_p2,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,v_fb_000_n,v_fb_000_s,2,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_000p2.mat');

%[comp_v_fb_010_m2,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,v_fb_010_n,v_fb_010_s,-2,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_010m2.mat');
%[comp_v_fb_010_m1,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,v_fb_010_n,v_fb_010_s,-1,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_010m1.mat');
[comp_v_fb_010_0,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,v_fb_010_n,v_fb_010_s,0,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_010.mat');
%[comp_v_fb_010_p1,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,v_fb_010_n,v_fb_010_s,1,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_010p1.mat');
%[comp_v_fb_010_p2,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,v_fb_010_n,v_fb_010_s,2,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_010p2.mat');

%[comp_v_fb_025_m2,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,v_fb_025_n,v_fb_025_s,-2,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_025m2.mat');
%[comp_v_fb_025_m1,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,v_fb_025_n,v_fb_025_s,-1,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_025m1.mat');
[comp_v_fb_025_0,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,v_fb_025_n,v_fb_025_s,0,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_025.mat');
%[comp_v_fb_025_p1,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,v_fb_025_n,v_fb_025_s,1,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_025p1.mat');
%[comp_v_fb_025_p2,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,v_fb_025_n,v_fb_025_s,2,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_025p2.mat');

%[comp_v_fb_050_m2,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,v_fb_050_n,v_fb_050_s,-2,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_050m2.mat');
%[comp_v_fb_050_m1,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,v_fb_050_n,v_fb_050_s,-1,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_050m1.mat');
[comp_v_fb_050_0,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,v_fb_050_n,v_fb_050_s,0,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_050.mat');
%[comp_v_fb_050_p1,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,v_fb_050_n,v_fb_050_s,1,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_050p1.mat');
%[comp_v_fb_050_p2,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,v_fb_050_n,v_fb_050_s,2,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_050p2.mat');

%[comp_v_fb_075_m2,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,v_fb_075_n,v_fb_075_s,-2,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_075m2.mat');
%[comp_v_fb_075_m1,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,v_fb_075_n,v_fb_075_s,-1,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_075m1.mat');
[comp_v_fb_075_0,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,v_fb_075_n,v_fb_075_s,0,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_075.mat');
%[comp_v_fb_075_p1,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,v_fb_075_n,v_fb_075_s,1,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_075p1.mat');
%[comp_v_fb_075_p2,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,v_fb_075_n,v_fb_075_s,2,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_075p2.mat');

%[comp_v_fb_100_m2,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,v_fb_100_n,v_fb_100_s,-2,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_100m2.mat');
%[comp_v_fb_100_m1,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,v_fb_100_n,v_fb_100_s,-1,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_100m1.mat');
[comp_v_fb_100_0,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,v_fb_100_n,v_fb_100_s,0,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_100.mat');
%[comp_v_fb_100_p1,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,v_fb_100_n,v_fb_100_s,1,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_100p1.mat');
%[comp_v_fb_100_p2,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,v_fb_100_n,v_fb_100_s,2,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_100p2.mat');

[comp_v_fb_000_000,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,v_fb_000_n_000,v_fb_000_s_000,0,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_000_000.mat');
[comp_v_fb_010_000,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,v_fb_010_n_000,v_fb_010_s_000,0,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_010_000.mat');
[comp_v_fb_025_000,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,v_fb_025_n_000,v_fb_025_s_000,0,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_025_000.mat');
[comp_v_fb_050_000,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,v_fb_050_n_000,v_fb_050_s_000,0,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_050_000.mat');
[comp_v_fb_075_000,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,v_fb_075_n_000,v_fb_075_s_000,0,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_075_000.mat');
[comp_v_fb_100_000,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,v_fb_100_n_000,v_fb_100_s_000,0,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_100_000.mat');


[comp_v_fb_000_100,check0] = composite_fun_timelag(peaks_000,vt_thresh_000,v_fb_000_n_100,v_fb_000_s_100,0,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_000_100.mat');
[comp_v_fb_010_100,check0] = composite_fun_timelag(peaks_010,vt_thresh_010,v_fb_010_n_100,v_fb_010_s_100,0,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_010_100.mat');
[comp_v_fb_025_100,check0] = composite_fun_timelag(peaks_025,vt_thresh_025,v_fb_025_n_100,v_fb_025_s_100,0,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_025_100.mat');
[comp_v_fb_050_100,check0] = composite_fun_timelag(peaks_050,vt_thresh_050,v_fb_050_n_100,v_fb_050_s_100,0,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_050_100.mat');
[comp_v_fb_075_100,check0] = composite_fun_timelag(peaks_075,vt_thresh_075,v_fb_075_n_100,v_fb_075_s_100,0,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_075_100.mat');
[comp_v_fb_100_100,check0] = composite_fun_timelag(peaks_100,vt_thresh_100,v_fb_100_n_100,v_fb_100_s_100,0,'/project/rg312/mat_files/composite_data_tlag/v_fb_compdata_100_100.mat');


v_fb_comp_000 = nanmean(comp_v_fb_000_0,3);
v_fb_comp_010 = nanmean(comp_v_fb_010_0,3);
v_fb_comp_025 = nanmean(comp_v_fb_025_0,3);
v_fb_comp_050 = nanmean(comp_v_fb_050_0,3);
v_fb_comp_075 = nanmean(comp_v_fb_075_0,3);
v_fb_comp_100 = nanmean(comp_v_fb_100_0,3);

v_fb_comp_000_000 = nanmean(comp_v_fb_000_000,3);
v_fb_comp_010_000 = nanmean(comp_v_fb_010_000,3);
v_fb_comp_025_000 = nanmean(comp_v_fb_025_000,3);
v_fb_comp_050_000 = nanmean(comp_v_fb_050_000,3);
v_fb_comp_075_000 = nanmean(comp_v_fb_075_000,3);
v_fb_comp_100_000 = nanmean(comp_v_fb_100_000,3);

v_fb_comp_000_100 = nanmean(comp_v_fb_000_100,3);
v_fb_comp_010_100 = nanmean(comp_v_fb_010_100,3);
v_fb_comp_025_100 = nanmean(comp_v_fb_025_100,3);
v_fb_comp_050_100 = nanmean(comp_v_fb_050_100,3);
v_fb_comp_075_100 = nanmean(comp_v_fb_075_100,3);
v_fb_comp_100_100 = nanmean(comp_v_fb_100_100,3);


w_fb_half_000(:,26) = zeros(35,1)
w_fb_half_010(:,26) = zeros(35,1)
w_fb_half_025(:,26) = zeros(35,1)
w_fb_half_050(:,26) = zeros(35,1)
w_fb_half_075(:,26) = zeros(35,1)
w_fb_half_100(:,26) = zeros(35,1)

w_fb_half_000_000(:,26) = zeros(35,1)
w_fb_half_010_000(:,26) = zeros(35,1)
w_fb_half_025_000(:,26) = zeros(35,1)
w_fb_half_050_000(:,26) = zeros(35,1)
w_fb_half_075_000(:,26) = zeros(35,1)
w_fb_half_100_000(:,26) = zeros(35,1)

w_fb_half_000_100(:,26) = zeros(35,1)
w_fb_half_010_100(:,26) = zeros(35,1)
w_fb_half_025_100(:,26) = zeros(35,1)
w_fb_half_050_100(:,26) = zeros(35,1)
w_fb_half_075_100(:,26) = zeros(35,1)
w_fb_half_100_100(:,26) = zeros(35,1)

w_fb_half_000(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_000,2),2).*-4000,2);
w_fb_half_010(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_010,2),2).*-4000,2);
w_fb_half_025(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_025,2),2).*-4000,2);
w_fb_half_050(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_050,2),2).*-4000,2);
w_fb_half_075(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_075,2),2).*-4000,2);
w_fb_half_100(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_100,2),2).*-4000,2);

w_fb_half_000_000(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_000_000,2),2).*-4000,2);
w_fb_half_010_000(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_010_000,2),2).*-4000,2);
w_fb_half_025_000(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_025_000,2),2).*-4000,2);
w_fb_half_050_000(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_050_000,2),2).*-4000,2);
w_fb_half_075_000(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_075_000,2),2).*-4000,2);
w_fb_half_100_000(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_100_000,2),2).*-4000,2);

w_fb_half_000_100(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_000_100,2),2).*-4000,2);
w_fb_half_010_100(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_010_100,2),2).*-4000,2);
w_fb_half_025_100(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_025_100,2),2).*-4000,2);
w_fb_half_050_100(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_050_100,2),2).*-4000,2);
w_fb_half_075_100(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_075_100,2),2).*-4000,2);
w_fb_half_100_100(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_100_100,2),2).*-4000,2);

%w_fb_half_000(:,26) = zeros(35,1)
%w_fb_half_010(:,26) = zeros(35,1)
%w_fb_half_025(:,26) = zeros(35,1)
%w_fb_half_050(:,26) = zeros(35,1)
%w_fb_half_075(:,26) = zeros(35,1)
%w_fb_half_100(:,26) = zeros(35,1)

%w_fb_half_000(:,1:25) = cumsum(v_fb_comp_000,2).*-4000;
%w_fb_half_010(:,1:25) = cumsum(v_fb_comp_010,2).*-4000;
%w_fb_half_025(:,1:25) = cumsum(v_fb_comp_025,2).*-4000;
%w_fb_half_050(:,1:25) = cumsum(v_fb_comp_050,2).*-4000;
%w_fb_half_075(:,1:25) = cumsum(v_fb_comp_075,2).*-4000;
%w_fb_half_100(:,1:25) = cumsum(v_fb_comp_100,2).*-4000;

rC_half = (100000:-4000:0)';

w_fb_000 = interp1(rC_half,w_fb_half_000',rC)';
w_fb_010 = interp1(rC_half,w_fb_half_010',rC)';
w_fb_025 = interp1(rC_half,w_fb_half_025',rC)';
w_fb_050 = interp1(rC_half,w_fb_half_050',rC)';
w_fb_075 = interp1(rC_half,w_fb_half_075',rC)';
w_fb_100 = interp1(rC_half,w_fb_half_100',rC)';

w_fb_000_000 = interp1(rC_half,w_fb_half_000_000',rC)';
w_fb_010_000 = interp1(rC_half,w_fb_half_010_000',rC)';
w_fb_025_000 = interp1(rC_half,w_fb_half_025_000',rC)';
w_fb_050_000 = interp1(rC_half,w_fb_half_050_000',rC)';
w_fb_075_000 = interp1(rC_half,w_fb_half_075_000',rC)';
w_fb_100_000 = interp1(rC_half,w_fb_half_100_000',rC)';

w_fb_000_100 = interp1(rC_half,w_fb_half_000_100',rC)';
w_fb_010_100 = interp1(rC_half,w_fb_half_010_100',rC)';
w_fb_025_100 = interp1(rC_half,w_fb_half_025_100',rC)';
w_fb_050_100 = interp1(rC_half,w_fb_half_050_100',rC)';
w_fb_075_100 = interp1(rC_half,w_fb_half_075_100',rC)';
w_fb_100_100 = interp1(rC_half,w_fb_half_100_100',rC)';

x=-34:2:34;
v = -0.25:0.01:0.16;

 contourf(x,rC./100,w_fb_000',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
[C,h] = contour(x,rC./100,w_fb_000',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.0es0','FontSize',15)
print('-dpng','w_fb_tlag_plots/w_000_0.png')
hold off


 contourf(x,rC./100,w_fb_010',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
[C,h] = contour(x,rC./100,w_fb_010',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.1es0','FontSize',15)
print('-dpng','w_fb_tlag_plots/w_010_0.png')
hold off

 contourf(x,rC./100,w_fb_025',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
[C,h] = contour(x,rC./100,w_fb_025',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.25es0','FontSize',15)
print('-dpng','w_fb_tlag_plots/w_025_0.png')
hold off

 contourf(x,rC./100,w_fb_050',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
[C,h] = contour(x,rC./100,w_fb_050',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.5es0','FontSize',15)
print('-dpng','w_fb_tlag_plots/w_050_0.png')
hold off

 contourf(x,rC./100,w_fb_075',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
[C,h] = contour(x,rC./100,w_fb_075',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.75es0','FontSize',15)
print('-dpng','w_fb_tlag_plots/w_075_0.png')
hold off

 contourf(x,rC./100,w_fb_100',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
[C,h] = contour(x,rC./100,w_fb_100',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 1.0es0','FontSize',15)
print('-dpng','w_fb_tlag_plots/w_100_0.png')
hold off





x=-34:2:34;
v = -0.25:0.01:0.16;

 contourf(x,rC./100,w_fb_000_000',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
[C,h] = contour(x,rC./100,w_fb_000_000',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.0es0','FontSize',15)
print('-dpng','w_fb_tlag_plots/w_000_000.png')
hold off


 contourf(x,rC./100,w_fb_010_000',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
[C,h] = contour(x,rC./100,w_fb_010_000',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.1es0','FontSize',15)
print('-dpng','w_fb_tlag_plots/w_010_000.png')
hold off

 contourf(x,rC./100,w_fb_025_000',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
[C,h] = contour(x,rC./100,w_fb_025_000',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.25es0','FontSize',15)
print('-dpng','w_fb_tlag_plots/w_025_000.png')
hold off

 contourf(x,rC./100,w_fb_050_000',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
[C,h] = contour(x,rC./100,w_fb_050_000',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.5es0','FontSize',15)
print('-dpng','w_fb_tlag_plots/w_050_000.png')
hold off

 contourf(x,rC./100,w_fb_075_000',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
[C,h] = contour(x,rC./100,w_fb_075_000',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.75es0','FontSize',15)
print('-dpng','w_fb_tlag_plots/w_075_000.png')
hold off

 contourf(x,rC./100,w_fb_100_000',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
[C,h] = contour(x,rC./100,w_fb_100_000',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 1.0es0','FontSize',15)
print('-dpng','w_fb_tlag_plots/w_100_000.png')
hold off





x=-34:2:34;
v = -0.25:0.01:0.16;

 contourf(x,rC./100,w_fb_000_100',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
[C,h] = contour(x,rC./100,w_fb_000_100',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.0es0','FontSize',15)
print('-dpng','w_fb_tlag_plots/w_000_100.png')
hold off

 contourf(x,rC./100,w_fb_010_100',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
[C,h] = contour(x,rC./100,w_fb_010_100',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.1es0','FontSize',15)
print('-dpng','w_fb_tlag_plots/w_010_100.png')
hold off

 contourf(x,rC./100,w_fb_025_100',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
[C,h] = contour(x,rC./100,w_fb_025_100',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.25es0','FontSize',15)
print('-dpng','w_fb_tlag_plots/w_025_100.png')
hold off

 contourf(x,rC./100,w_fb_050_100',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
[C,h] = contour(x,rC./100,w_fb_050_100',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.5es0','FontSize',15)
print('-dpng','w_fb_tlag_plots/w_050_100.png')
hold off

 contourf(x,rC./100,w_fb_075_100',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
[C,h] = contour(x,rC./100,w_fb_075_100',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 0.75es0','FontSize',15)
print('-dpng','w_fb_tlag_plots/w_075_100.png')
hold off

 contourf(x,rC./100,w_fb_100_100',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.25,0.16));
hold on
[C,h] = contour(x,rC./100,w_fb_100_100',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('w composite, 1.0es0','FontSize',15)
print('-dpng','w_fb_tlag_plots/w_100_100.png')
hold off




return

x=-34:2:34;
v = -20:2:20;
figure
 contourf(x,rC./100,nanmean(comp_v_fb_000_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_000_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.0es0, lag -2','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_000_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_000_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_000_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.0es0, lag -1','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_000_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_000_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_000_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.0es0','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_000_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_000_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_000_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.0es0, lag 1','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_000_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_000_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_000_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.0es0, lag 2','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_000_p2.png')
hold off



figure
 contourf(x,rC./100,nanmean(comp_v_fb_010_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_010_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.1es0, lag -2','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_010_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_010_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_010_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.1es0, lag -1','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_010_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_010_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_010_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.1es0','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_010_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_010_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_010_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.1es0, lag 1','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_010_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_010_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_010_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.1es0, lag 2','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_010_p2.png')
hold off



figure
 contourf(x,rC./100,nanmean(comp_v_fb_025_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_025_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.25es0, lag -2','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_025_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_025_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_025_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.25es0, lag -1','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_025_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_025_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_025_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.25es0','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_025_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_025_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_025_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.25es0, lag 1','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_025_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_025_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_025_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.25es0, lag 2','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_025_p2.png')
hold off



figure
 contourf(x,rC./100,nanmean(comp_v_fb_050_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_050_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.5es0, lag -2','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_050_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_050_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_050_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.5es0, lag -1','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_050_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_050_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_050_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.5es0','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_050_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_050_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_050_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.5es0, lag 1','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_050_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_050_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_050_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.5es0, lag 2','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_050_p2.png')
hold off




figure
 contourf(x,rC./100,nanmean(comp_v_fb_075_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_075_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.75es0, lag -2','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_075_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_075_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_075_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.75es0, lag -1','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_075_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_075_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_075_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.75es0','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_075_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_075_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_075_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.75es0, lag 1','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_075_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_075_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_075_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 0.75es0, lag 2','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_075_p2.png')
hold off




figure
 contourf(x,rC./100,nanmean(comp_v_fb_100_m2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_100_m2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 1.0es0, lag -2','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_100_m2.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_100_m1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_100_m1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 1.0es0, lag -1','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_100_m1.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_100_0,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_100_0,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 1.0es0','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_100_0.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_100_p1,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_100_p1,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 1.0es0, lag 1','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_100_p1.png')
hold off

 contourf(x,rC./100,nanmean(comp_v_fb_100_p2,3)',v)
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,20));
hold on
[C,h] = contour(x,rC./100,nanmean(comp_v_fb_100_p2,3)',[-1000:1000:1000],'k','LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v composite, 1.0es0, lag 2','FontSize',15)
print('-dpng','v_fb_tlag_plots/v_fb_100_p2.png')
hold off




