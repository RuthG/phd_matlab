%load w, rotate to lat-lon
%exclude tropics, look at distribution, maybe use pdf


% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_doshallower00/';
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

load('~/md_onoff/week_1027/PREMEETING/w_snapshots_saved.mat')

xi=-179:2:180;yi=-89:2:90;
w_000_ll = cube2latlon(xc,yc,w_000,xi,yi);
w_010_ll = cube2latlon(xc,yc,w_010,xi,yi);
w_025_ll = cube2latlon(xc,yc,w_025,xi,yi);
w_050_ll = cube2latlon(xc,yc,w_050,xi,yi);
w_075_ll = cube2latlon(xc,yc,w_075,xi,yi);
w_100_ll = cube2latlon(xc,yc,w_100,xi,yi);

%start by just selecting the 29 lat circle to look at, yi(60) and yi(31)


w_000_29(:,1:720) = squeeze(w_000_ll(:,60,11,:));
w_000_29(:,721:1440) = -squeeze(w_000_ll(:,31,11,:));

w_010_29(:,1:720) = squeeze(w_010_ll(:,60,11,:));
w_010_29(:,721:1440) = -squeeze(w_010_ll(:,31,11,:));

w_025_29(:,1:720) = squeeze(w_025_ll(:,60,11,:));
w_025_29(:,721:1440) = -squeeze(w_025_ll(:,31,11,:));

w_050_29(:,1:720) = squeeze(w_050_ll(:,60,11,:));
w_050_29(:,721:1440) = -squeeze(w_050_ll(:,31,11,:));

w_075_29(:,1:720) = squeeze(w_075_ll(:,60,11,:));
w_075_29(:,721:1440) = -squeeze(w_075_ll(:,31,11,:));

w_100_29(:,1:720) = squeeze(w_100_ll(:,60,11,:));
w_100_29(:,721:1440) = -squeeze(w_100_ll(:,31,11,:));


%search for peaks instead of just high values

w_bins = -1.5:0.01:0;
w_bins_c = -1.495:0.01:0;
peak_dist_000 = zeros(150,1);
peak_dist_010 = zeros(150,1);
peak_dist_025 = zeros(150,1);
peak_dist_050 = zeros(150,1);
peak_dist_075 = zeros(150,1);
peak_dist_100 = zeros(150,1);

for i=1:1440
[a_000,b_000] = findpeaks(-w_000_29(:,i));
[a_010,b_010] = findpeaks(-w_010_29(:,i));
[a_025,b_025] = findpeaks(-w_025_29(:,i));
[a_050,b_050] = findpeaks(-w_050_29(:,i));
[a_075,b_075] = findpeaks(-w_075_29(:,i));
[a_100,b_100] = findpeaks(-w_100_29(:,i));

  for j=1:150
  peak_dist_000(j) = peak_dist_000(j) + sum( -a_000 >= w_bins(j) & -a_000 < w_bins(j+1));
  peak_dist_010(j) = peak_dist_010(j) + sum( -a_010 >= w_bins(j) & -a_010 < w_bins(j+1));
  peak_dist_025(j) = peak_dist_025(j) + sum( -a_025 >= w_bins(j) & -a_025 < w_bins(j+1));
  peak_dist_050(j) = peak_dist_050(j) + sum( -a_050 >= w_bins(j) & -a_050 < w_bins(j+1));
  peak_dist_075(j) = peak_dist_075(j) + sum( -a_075 >= w_bins(j) & -a_075 < w_bins(j+1));
  peak_dist_100(j) = peak_dist_100(j) + sum( -a_100 >= w_bins(j) & -a_100 < w_bins(j+1));
  end

end


%THINK ABOUT THIS METHOD

peak_dist_cumsum_000 = cumsum(peak_dist_000(1:150)./sum(peak_dist_000));
peak_dist_cumsum_010 = cumsum(peak_dist_010(1:150)./sum(peak_dist_010));
peak_dist_cumsum_025 = cumsum(peak_dist_025(1:150)./sum(peak_dist_025));
peak_dist_cumsum_050 = cumsum(peak_dist_050(1:150)./sum(peak_dist_050));
peak_dist_cumsum_075 = cumsum(peak_dist_075(1:150)./sum(peak_dist_075));
peak_dist_cumsum_100 = cumsum(peak_dist_100(1:150)./sum(peak_dist_100));

w_thresh_000 = w_bins_c(max(find(peak_dist_cumsum_000<0.05)));
w_thresh_010 = w_bins_c(max(find(peak_dist_cumsum_010<0.05)));
w_thresh_025 = w_bins_c(max(find(peak_dist_cumsum_025<0.05)));
w_thresh_050 = w_bins_c(max(find(peak_dist_cumsum_050<0.05)));
w_thresh_075 = w_bins_c(max(find(peak_dist_cumsum_075<0.05)));
w_thresh_100 = w_bins_c(max(find(peak_dist_cumsum_100<0.05)));

w_mask_000 = w_000_29<w_thresh_000;
w_mask_010 = w_010_29<w_thresh_010;
w_mask_025 = w_025_29<w_thresh_025;
w_mask_050 = w_050_29<w_thresh_050;
w_mask_075 = w_075_29<w_thresh_075;
w_mask_100 = w_100_29<w_thresh_100;

save('w_masks.mat','w_mask_000','w_mask_010','w_mask_025','w_mask_050','w_mask_075','w_mask_100');

return


n_bins = size(w_bins,2)-1;

%find where w lies in a given bin at each timestep

w_binned_000 = single(zeros(180,1440,n_bins));
w_binned_010 = single(zeros(180,1440,n_bins));
w_binned_050 = single(zeros(180,1440,n_bins));
w_binned_075 = single(zeros(180,1440,n_bins));
w_binned_100 = single(zeros(180,1440,n_bins));
'w bin matrices allocated'

for i=1:n_bins
i
w_binned_000(:,:,i) = (w_000_29 >= w_bins(i) & w_000_29 < w_bins(i+1));
w_binned_010(:,:,i) = (w_010_29 >= w_bins(i) & w_010_29 < w_bins(i+1));
w_binned_025(:,:,i) = (w_025_29 >= w_bins(i) & w_025_29 < w_bins(i+1));
w_binned_050(:,:,i) = (w_050_29 >= w_bins(i) & w_050_29 < w_bins(i+1));
w_binned_075(:,:,i) = (w_075_29 >= w_bins(i) & w_075_29 < w_bins(i+1));
w_binned_100(:,:,i) = (w_100_29 >= w_bins(i) & w_100_29 < w_bins(i+1));

end

w_count_000 = squeeze(sum(sum(w_binned_000,1),2));
w_count_010 = squeeze(sum(sum(w_binned_010,1),2));
w_count_025 = squeeze(sum(sum(w_binned_025,1),2));
w_count_050 = squeeze(sum(sum(w_binned_050,1),2));
w_count_075 = squeeze(sum(sum(w_binned_075,1),2));
w_count_100 = squeeze(sum(sum(w_binned_100,1),2));

w_cumsum_000 = cumsum(w_count_000./sum(w_count_000));  
w_cumsum_010 = cumsum(w_count_010./sum(w_count_010));  
w_cumsum_025 = cumsum(w_count_025./sum(w_count_025));  
w_cumsum_050 = cumsum(w_count_050./sum(w_count_050));  
w_cumsum_075 = cumsum(w_count_075./sum(w_count_075));  
w_cumsum_100 = cumsum(w_count_100./sum(w_count_100));  

w_thresh_000 = w_bins_c(max(find(w_cumsum_000<0.05)));
w_thresh_010 = w_bins_c(max(find(w_cumsum_010<0.05)));
w_thresh_025 = w_bins_c(max(find(w_cumsum_025<0.05)));
w_thresh_050 = w_bins_c(max(find(w_cumsum_050<0.05)));
w_thresh_075 = w_bins_c(max(find(w_cumsum_075<0.05)));
w_thresh_100 = w_bins_c(max(find(w_cumsum_100<0.05)));


w_mask_000 = w_000_29<w_thresh_000;
w_mask_010 = w_010_29<w_thresh_010;
w_mask_025 = w_025_29<w_thresh_025;
w_mask_050 = w_050_29<w_thresh_050;
w_mask_075 = w_075_29<w_thresh_075;
w_mask_100 = w_100_29<w_thresh_100;

save('w_masks.mat','w_mask_000','w_mask_010','w_mask_025','w_mask_050','w_mask_075','w_mask_100');




w_thresh_000_desc = w_bins_c(min(find(w_cumsum_000>0.95)));
w_thresh_010_desc = w_bins_c(min(find(w_cumsum_010>0.95)));
w_thresh_025_desc = w_bins_c(min(find(w_cumsum_025>0.95)));
w_thresh_050_desc = w_bins_c(min(find(w_cumsum_050>0.95)));
w_thresh_075_desc = w_bins_c(min(find(w_cumsum_075>0.95)));
w_thresh_100_desc = w_bins_c(min(find(w_cumsum_100>0.95)));


w_mask_000_desc = w_000_29>w_thresh_000_desc;
w_mask_010_desc = w_010_29>w_thresh_010_desc;
w_mask_025_desc = w_025_29>w_thresh_025_desc;
w_mask_050_desc = w_050_29>w_thresh_050_desc;
w_mask_075_desc = w_075_29>w_thresh_075_desc;
w_mask_100_desc = w_100_29>w_thresh_100_desc;

save('w_masks_desc.mat','w_mask_000_desc','w_mask_010_desc','w_mask_025_desc','w_mask_050_desc','w_mask_075_desc','w_mask_100_desc');




