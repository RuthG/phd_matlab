%use snapshot data to locate strongest vt peaks

%load data
load('/project/rg312/mat_files/vt_lats.mat')
load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat')
'data loaded'

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

%transfer to lat lon grid
xi=-179:2:180;yi=-89:2:90;
v_000_ll = cube2latlon(xc,yc,vN_000,xi,yi);
v_010_ll = cube2latlon(xc,yc,vN_010,xi,yi);
v_025_ll = cube2latlon(xc,yc,vN_025,xi,yi);
v_050_ll = cube2latlon(xc,yc,vN_050,xi,yi);
v_075_ll = cube2latlon(xc,yc,vN_075,xi,yi);
v_100_ll = cube2latlon(xc,yc,vN_100,xi,yi);
t_000_ll = cube2latlon(xc,yc,t_000,xi,yi);
t_010_ll = cube2latlon(xc,yc,t_010,xi,yi);
t_025_ll = cube2latlon(xc,yc,t_025,xi,yi);
t_050_ll = cube2latlon(xc,yc,t_050,xi,yi);
t_075_ll = cube2latlon(xc,yc,t_075,xi,yi);
t_100_ll = cube2latlon(xc,yc,t_100,xi,yi);
'll done'

%take time average
v_000_tav = mean(v_000_ll,4);
v_010_tav = mean(v_010_ll,4);
v_025_tav = mean(v_025_ll,4);
v_050_tav = mean(v_050_ll,4);
v_075_tav = mean(v_075_ll,4);
v_100_tav = mean(v_100_ll,4);
t_000_tav = mean(t_000_ll,4);
t_010_tav = mean(t_010_ll,4);
t_025_tav = mean(t_025_ll,4);
t_050_tav = mean(t_050_ll,4);
t_075_tav = mean(t_075_ll,4);
t_100_tav = mean(t_100_ll,4);
'tavs done'

%calculate (v-[v])(t-[t]) to get transient eddy heat transport 
for i=1:720

vt_ed_000(:,:,:,i) = squeeze((v_000_ll(:,x000-7:x000+7,:,i) - v_000_tav(:,x000-7:x000+7,:)) .* (t_000_ll(:,x000-7:x000+7,:,i) - t_000_tav(:,x000-7:x000+7,:)));
vt_ed_010(:,:,:,i) = squeeze((v_010_ll(:,x010-7:x010+7,:,i) - v_010_tav(:,x010-7:x010+7,:)) .* (t_010_ll(:,x010-7:x010+7,:,i) - t_010_tav(:,x010-7:x010+7,:)));
vt_ed_025(:,:,:,i) = squeeze((v_025_ll(:,x025-7:x025+7,:,i) - v_025_tav(:,x025-7:x025+7,:)) .* (t_025_ll(:,x025-7:x025+7,:,i) - t_025_tav(:,x025-7:x025+7,:)));
vt_ed_050(:,:,:,i) = squeeze((v_050_ll(:,x050-7:x050+7,:,i) - v_050_tav(:,x050-7:x050+7,:)) .* (t_050_ll(:,x050-7:x050+7,:,i) - t_050_tav(:,x050-7:x050+7,:)));
vt_ed_075(:,:,:,i) = squeeze((v_075_ll(:,x075-7:x075+7,:,i) - v_075_tav(:,x075-7:x075+7,:)) .* (t_075_ll(:,x075-7:x075+7,:,i) - t_075_tav(:,x075-7:x075+7,:)));
vt_ed_100(:,:,:,i) = squeeze((v_100_ll(:,x100-7:x100+7,:,i) - v_100_tav(:,x100-7:x100+7,:)) .* (t_100_ll(:,x100-7:x100+7,:,i) - t_100_tav(:,x100-7:x100+7,:)));

end
'eddies done'

%want to: locate peaks
%create distribution of their magnitudes

%choose bins

vt_bins = -1500: 5 : 1500;
vt_bins_c = -1497.5: 5 : 1497.5;

peak_dist_000 = zeros(600,1);
peak_dist_010 = zeros(600,1);
peak_dist_025 = zeros(600,1);
peak_dist_050 = zeros(600,1);
peak_dist_075 = zeros(600,1);
peak_dist_100 = zeros(600,1);

for i=1:15
  for j=1:720
  
  %locate peaks in v't'

  [a_000,b_000] = findpeaks(vt_ed_000(:,i,4,j));
  [a_010,b_010] = findpeaks(vt_ed_010(:,i,4,j));
  [a_025,b_025] = findpeaks(vt_ed_025(:,i,4,j));
  [a_050,b_050] = findpeaks(vt_ed_050(:,i,4,j));
  [a_075,b_075] = findpeaks(vt_ed_075(:,i,4,j));
  [a_100,b_100] = findpeaks(vt_ed_100(:,i,4,j));
  
  %save peak magnitudes and locations in a cell array
  peaks_000{i,j,1} = a_000;
  peaks_000{i,j,2} = b_000;
  peaks_010{i,j,1} = a_010;
  peaks_010{i,j,2} = b_010;
  peaks_025{i,j,1} = a_025;
  peaks_025{i,j,2} = b_025;
  peaks_050{i,j,1} = a_050;
  peaks_050{i,j,2} = b_050;
  peaks_075{i,j,1} = a_075;
  peaks_075{i,j,2} = b_075;
  peaks_100{i,j,1} = a_100;
  peaks_100{i,j,2} = b_100;

  %go through and add counts of vt values to the bins
  for k=1:600
  peak_dist_000(k) = peak_dist_000(k) + sum( vt_ed_000(:,i,4,j) >= vt_bins(k) & vt_ed_000(:,i,4,j) < vt_bins(k+1));
  peak_dist_010(k) = peak_dist_010(k) + sum( vt_ed_010(:,i,4,j) >= vt_bins(k) & vt_ed_010(:,i,4,j) < vt_bins(k+1));
  peak_dist_025(k) = peak_dist_025(k) + sum( vt_ed_025(:,i,4,j) >= vt_bins(k) & vt_ed_025(:,i,4,j) < vt_bins(k+1));
  peak_dist_050(k) = peak_dist_050(k) + sum( vt_ed_050(:,i,4,j) >= vt_bins(k) & vt_ed_050(:,i,4,j) < vt_bins(k+1));
  peak_dist_075(k) = peak_dist_075(k) + sum( vt_ed_075(:,i,4,j) >= vt_bins(k) & vt_ed_075(:,i,4,j) < vt_bins(k+1));
  peak_dist_100(k) = peak_dist_100(k) + sum( vt_ed_100(:,i,4,j) >= vt_bins(k) & vt_ed_100(:,i,4,j) < vt_bins(k+1));
  end
  
  end
end


peak_dist_cumsum_000 = cumsum(peak_dist_000./sum(peak_dist_000));
peak_dist_cumsum_010 = cumsum(peak_dist_010./sum(peak_dist_010));
peak_dist_cumsum_025 = cumsum(peak_dist_025./sum(peak_dist_025));
peak_dist_cumsum_050 = cumsum(peak_dist_050./sum(peak_dist_050));
peak_dist_cumsum_075 = cumsum(peak_dist_075./sum(peak_dist_075));
peak_dist_cumsum_100 = cumsum(peak_dist_100./sum(peak_dist_100));

vt_thresh_000 = vt_bins_c(min(find(peak_dist_cumsum_000>0.95)));
vt_thresh_010 = vt_bins_c(min(find(peak_dist_cumsum_010>0.95)));
vt_thresh_025 = vt_bins_c(min(find(peak_dist_cumsum_025>0.95)));
vt_thresh_050 = vt_bins_c(min(find(peak_dist_cumsum_050>0.95)));
vt_thresh_075 = vt_bins_c(min(find(peak_dist_cumsum_075>0.95)));
vt_thresh_100 = vt_bins_c(min(find(peak_dist_cumsum_100>0.95)));

%want to find the data in our cell array where a > vt_thresh, and then use the corresponding b value to locate the peak and make a mask


save('/project/rg312/mat_files/snapshot_data/vt_extreme_data.mat','vt_thresh_000','vt_thresh_010','vt_thresh_025','vt_thresh_050','vt_thresh_075','vt_thresh_100' ...
,'peaks_000','peaks_010','peaks_025','peaks_050','peaks_075','peaks_100')


save('/project/rg312/mat_files/snapshot_data/vt_ed_data.mat','vt_ed_000','vt_ed_010','vt_ed_025','vt_ed_050','vt_ed_075','vt_ed_100')
