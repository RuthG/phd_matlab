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
clear('vN_000','vN_010','vN_025','vN_050','vN_075','vN_100','t_000','t_010','t_025','t_050','t_075','t_100')

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

vt_ed_000n(:,:,:,i) = squeeze((v_000_ll(:,x000n-7:x000n+7,:,i) - v_000_tav(:,x000n-7:x000n+7,:)) .* (t_000_ll(:,x000n-7:x000n+7,:,i) - t_000_tav(:,x000n-7:x000n+7,:)));
vt_ed_010n(:,:,:,i) = squeeze((v_010_ll(:,x010n-7:x010n+7,:,i) - v_010_tav(:,x010n-7:x010n+7,:)) .* (t_010_ll(:,x010n-7:x010n+7,:,i) - t_010_tav(:,x010n-7:x010n+7,:)));
vt_ed_025n(:,:,:,i) = squeeze((v_025_ll(:,x025n-7:x025n+7,:,i) - v_025_tav(:,x025n-7:x025n+7,:)) .* (t_025_ll(:,x025n-7:x025n+7,:,i) - t_025_tav(:,x025n-7:x025n+7,:)));
vt_ed_050n(:,:,:,i) = squeeze((v_050_ll(:,x050n-7:x050n+7,:,i) - v_050_tav(:,x050n-7:x050n+7,:)) .* (t_050_ll(:,x050n-7:x050n+7,:,i) - t_050_tav(:,x050n-7:x050n+7,:)));
vt_ed_075n(:,:,:,i) = squeeze((v_075_ll(:,x075n-7:x075n+7,:,i) - v_075_tav(:,x075n-7:x075n+7,:)) .* (t_075_ll(:,x075n-7:x075n+7,:,i) - t_075_tav(:,x075n-7:x075n+7,:)));
vt_ed_100n(:,:,:,i) = squeeze((v_100_ll(:,x100n-7:x100n+7,:,i) - v_100_tav(:,x100n-7:x100n+7,:)) .* (t_100_ll(:,x100n-7:x100n+7,:,i) - t_100_tav(:,x100n-7:x100n+7,:)));

vt_ed_000s(:,:,:,i) = -squeeze((v_000_ll(:,x000s-7:x000s+7,:,i) - v_000_tav(:,x000s-7:x000s+7,:)) .* (t_000_ll(:,x000s-7:x000s+7,:,i) - t_000_tav(:,x000s-7:x000s+7,:)));
vt_ed_010s(:,:,:,i) = -squeeze((v_010_ll(:,x010s-7:x010s+7,:,i) - v_010_tav(:,x010s-7:x010s+7,:)) .* (t_010_ll(:,x010s-7:x010s+7,:,i) - t_010_tav(:,x010s-7:x010s+7,:)));
vt_ed_025s(:,:,:,i) = -squeeze((v_025_ll(:,x025s-7:x025s+7,:,i) - v_025_tav(:,x025s-7:x025s+7,:)) .* (t_025_ll(:,x025s-7:x025s+7,:,i) - t_025_tav(:,x025s-7:x025s+7,:)));
vt_ed_050s(:,:,:,i) = -squeeze((v_050_ll(:,x050s-7:x050s+7,:,i) - v_050_tav(:,x050s-7:x050s+7,:)) .* (t_050_ll(:,x050s-7:x050s+7,:,i) - t_050_tav(:,x050s-7:x050s+7,:)));
vt_ed_075s(:,:,:,i) = -squeeze((v_075_ll(:,x075s-7:x075s+7,:,i) - v_075_tav(:,x075s-7:x075s+7,:)) .* (t_075_ll(:,x075s-7:x075s+7,:,i) - t_075_tav(:,x075s-7:x075s+7,:)));
vt_ed_100s(:,:,:,i) = -squeeze((v_100_ll(:,x100s-7:x100s+7,:,i) - v_100_tav(:,x100s-7:x100s+7,:)) .* (t_100_ll(:,x100s-7:x100s+7,:,i) - t_100_tav(:,x100s-7:x100s+7,:)));

end
'eddies done'
clear('v_000_ll','v_010_ll','v_025_ll','v_050_ll','v_075_ll','v_100_ll','t_000_ll','t_010_ll','t_025_ll','t_050_ll','t_075_ll','t_100_ll')


%save('/project/rg312/mat_files/snapshot_data/vt_ed_data.mat','vt_ed_000n','vt_ed_010n','vt_ed_025n','vt_ed_050n','vt_ed_075n','vt_ed_100n'...
%,'vt_ed_000s','vt_ed_010s','vt_ed_025s','vt_ed_050s','vt_ed_075s','vt_ed_100s')

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

%for i=1:15
%  for j=1:720
  
  %go through and add counts of vt values to the bins
  for k=1:600
  peak_dist_000(k) = peak_dist_000(k) + sum(sum(sum( vt_ed_000n(:,:,4,:) >= vt_bins(k) & vt_ed_000n(:,:,4,:) < vt_bins(k+1) ,4),2),1);
  peak_dist_000(k) = peak_dist_000(k) + sum(sum(sum( vt_ed_000s(:,:,4,:) >= vt_bins(k) & vt_ed_000s(:,:,4,:) < vt_bins(k+1) ,4),2),1);
  peak_dist_010(k) = peak_dist_010(k) + sum(sum(sum( vt_ed_010n(:,:,4,:) >= vt_bins(k) & vt_ed_010n(:,:,4,:) < vt_bins(k+1) ,4),2),1);
  peak_dist_010(k) = peak_dist_010(k) + sum(sum(sum( vt_ed_010s(:,:,4,:) >= vt_bins(k) & vt_ed_010s(:,:,4,:) < vt_bins(k+1) ,4),2),1);
  peak_dist_025(k) = peak_dist_025(k) + sum(sum(sum( vt_ed_025n(:,:,4,:) >= vt_bins(k) & vt_ed_025n(:,:,4,:) < vt_bins(k+1) ,4),2),1);
  peak_dist_025(k) = peak_dist_025(k) + sum(sum(sum( vt_ed_025s(:,:,4,:) >= vt_bins(k) & vt_ed_025s(:,:,4,:) < vt_bins(k+1) ,4),2),1);
  peak_dist_050(k) = peak_dist_050(k) + sum(sum(sum( vt_ed_050n(:,:,4,:) >= vt_bins(k) & vt_ed_050n(:,:,4,:) < vt_bins(k+1) ,4),2),1);
  peak_dist_050(k) = peak_dist_050(k) + sum(sum(sum( vt_ed_050s(:,:,4,:) >= vt_bins(k) & vt_ed_050s(:,:,4,:) < vt_bins(k+1) ,4),2),1);
  peak_dist_075(k) = peak_dist_075(k) + sum(sum(sum( vt_ed_075n(:,:,4,:) >= vt_bins(k) & vt_ed_075n(:,:,4,:) < vt_bins(k+1) ,4),2),1);
  peak_dist_075(k) = peak_dist_075(k) + sum(sum(sum( vt_ed_075s(:,:,4,:) >= vt_bins(k) & vt_ed_075s(:,:,4,:) < vt_bins(k+1) ,4),2),1);
  peak_dist_100(k) = peak_dist_100(k) + sum(sum(sum( vt_ed_100n(:,:,4,:) >= vt_bins(k) & vt_ed_100n(:,:,4,:) < vt_bins(k+1) ,4),2),1);
  peak_dist_100(k) = peak_dist_100(k) + sum(sum(sum( vt_ed_100s(:,:,4,:) >= vt_bins(k) & vt_ed_100s(:,:,4,:) < vt_bins(k+1) ,4),2),1);
  end
  
%  end
%end


peak_dist_cumsum_000 = cumsum(peak_dist_000./sum(peak_dist_000));
peak_dist_cumsum_010 = cumsum(peak_dist_010./sum(peak_dist_010));
peak_dist_cumsum_025 = cumsum(peak_dist_025./sum(peak_dist_025));
peak_dist_cumsum_050 = cumsum(peak_dist_050./sum(peak_dist_050));
peak_dist_cumsum_075 = cumsum(peak_dist_075./sum(peak_dist_075));
peak_dist_cumsum_100 = cumsum(peak_dist_100./sum(peak_dist_100));

vt_thresh_000 = vt_bins_c(max(find(peak_dist_cumsum_000<0.05)));
vt_thresh_010 = vt_bins_c(max(find(peak_dist_cumsum_010<0.05)));
vt_thresh_025 = vt_bins_c(max(find(peak_dist_cumsum_025<0.05)));
vt_thresh_050 = vt_bins_c(max(find(peak_dist_cumsum_050<0.05)));
vt_thresh_075 = vt_bins_c(max(find(peak_dist_cumsum_075<0.05)));
vt_thresh_100 = vt_bins_c(max(find(peak_dist_cumsum_100<0.05)));


%find peaks that have a prominence greater than half the threshold for extremes (this seems to be true for most extreme peaks that are not 'sub peaks'

for i=1:15
  for j=1:720
  %locate peaks in v't'

  [a_000n,b_000n] = findpeak_prom(-vt_ed_000n(:,i,4,j),-vt_thresh_000./2);
  [a_000s,b_000s] = findpeak_prom(-vt_ed_000s(:,i,4,j),-vt_thresh_000./2);
  [a_010n,b_010n] = findpeak_prom(-vt_ed_010n(:,i,4,j),-vt_thresh_010./2);
  [a_010s,b_010s] = findpeak_prom(-vt_ed_010s(:,i,4,j),-vt_thresh_010./2);
  [a_025n,b_025n] = findpeak_prom(-vt_ed_025n(:,i,4,j),-vt_thresh_025./2);
  [a_025s,b_025s] = findpeak_prom(-vt_ed_025s(:,i,4,j),-vt_thresh_025./2);
  [a_050n,b_050n] = findpeak_prom(-vt_ed_050n(:,i,4,j),-vt_thresh_050./2);
  [a_050s,b_050s] = findpeak_prom(-vt_ed_050s(:,i,4,j),-vt_thresh_050./2);
  [a_075n,b_075n] = findpeak_prom(-vt_ed_075n(:,i,4,j),-vt_thresh_075./2);
  [a_075s,b_075s] = findpeak_prom(-vt_ed_075s(:,i,4,j),-vt_thresh_075./2);
  [a_100n,b_100n] = findpeak_prom(-vt_ed_100n(:,i,4,j),-vt_thresh_100./2);
  [a_100s,b_100s] = findpeak_prom(-vt_ed_100s(:,i,4,j),-vt_thresh_100./2);
  
  %save peak magnitudes and locations in a cell array
  peaks_000{i,j,1} = a_000n;
  peaks_000{i,j,2} = b_000n;
  peaks_000{i,j,3} = a_000s;
  peaks_000{i,j,4} = b_000s;
  peaks_010{i,j,1} = a_010n;
  peaks_010{i,j,2} = b_010n;
  peaks_010{i,j,3} = a_010s;
  peaks_010{i,j,4} = b_010s;
  peaks_025{i,j,1} = a_025n;
  peaks_025{i,j,2} = b_025n;
  peaks_025{i,j,3} = a_025s;
  peaks_025{i,j,4} = b_025s;
  peaks_050{i,j,1} = a_050n;
  peaks_050{i,j,2} = b_050n;
  peaks_050{i,j,3} = a_050s;
  peaks_050{i,j,4} = b_050s;
  peaks_075{i,j,1} = a_075n;
  peaks_075{i,j,2} = b_075n;
  peaks_075{i,j,3} = a_075s;
  peaks_075{i,j,4} = b_075s;
  peaks_100{i,j,1} = a_100n;
  peaks_100{i,j,2} = b_100n;
  peaks_100{i,j,3} = a_100s;
  peaks_100{i,j,4} = b_100s;

  end
end


save('/project/rg312/mat_files/snapshot_data/vt_extreme_data_desc.mat','vt_thresh_000','vt_thresh_010','vt_thresh_025','vt_thresh_050','vt_thresh_075','vt_thresh_100' ...
,'peaks_000','peaks_010','peaks_025','peaks_050','peaks_075','peaks_100')



