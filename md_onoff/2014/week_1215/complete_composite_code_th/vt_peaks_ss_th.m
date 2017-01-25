%use snapshot data to locate strongest vt peaks

%loads data
%regrids
%calculates eddy heat flux
%saves eddy fluxes
%finds the distribution of v'T' and plots this
%cumulative sums over this and finds 95 percentile
%defines threshold, finds peaks over this threshold that are more prominent that half the threshold
%saves threshold and peaks

%load data
load('/project/rg312/mat_files/vt_lats_th.mat')
load('/project/rg312/mat_files/snapshot_data/vN_snapshots_th.mat')
load('/project/rg312/mat_files/snapshot_data/t_snapshots_th.mat')
'data loaded'

rDir='/project/rg312/wv_on_rad_off/run_doshallowerth/';
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
v_th_ll = cube2latlon(xc,yc,vN_th,xi,yi);

t_th_ll = cube2latlon(xc,yc,t_th,xi,yi);

'll done'
clear('vN_th','t_th')

%take time average
v_th_tav = mean(v_th_ll,4);
t_th_tav = mean(t_th_ll,4);
'tavs done'


%calculate (v-[v])(t-[t]) to get transient eddy heat transport 
for i=1:720

vt_ed_thn(:,:,:,i) = squeeze((v_th_ll(:,xthn-7:xthn+7,:,i) - v_th_tav(:,xthn-7:xthn+7,:)) .* (t_th_ll(:,xthn-7:xthn+7,:,i) - t_th_tav(:,xthn-7:xthn+7,:)));

vt_ed_ths(:,:,:,i) = -squeeze((v_th_ll(:,xths-7:xths+7,:,i) - v_th_tav(:,xths-7:xths+7,:)) .* (t_th_ll(:,xths-7:xths+7,:,i) - t_th_tav(:,xths-7:xths+7,:)));

end
'eddies done'
clear('v_th_ll','t_th_ll')


save('/project/rg312/mat_files/snapshot_data/vt_ed_data_th.mat','vt_ed_thn','vt_ed_ths')

%want to: locate peaks
%create distribution of their magnitudes

%choose bins

vt_bins = -1500: 5 : 1500;
vt_bins_c = -1497.5: 5 : 1497.5;

peak_dist_th = zeros(600,1);


  %go through and add counts of vt values to the bins
  for k=1:600
  peak_dist_th(k) = peak_dist_th(k) + sum(sum(sum( vt_ed_thn(:,:,4,:) >= vt_bins(k) & vt_ed_thn(:,:,4,:) < vt_bins(k+1))));
  peak_dist_th(k) = peak_dist_th(k) + sum(sum(sum( vt_ed_ths(:,:,4,:) >= vt_bins(k) & vt_ed_ths(:,:,4,:) < vt_bins(k+1))));
  end
  
peak_dist_cumsum_th = cumsum(peak_dist_th./sum(peak_dist_th));

vt_thresh_th = vt_bins_c(min(find(peak_dist_cumsum_th>0.95)));


%find peaks that have a prominence greater than half the threshold for extremes (this seems to be true for most extreme peaks that are not 'sub peaks'

for i=1:15
  for j=1:720
  %locate peaks in v't'

  [a_thn,b_thn] = findpeak_prom(vt_ed_thn(:,i,4,j),vt_thresh_th./2);
  [a_ths,b_ths] = findpeak_prom(vt_ed_ths(:,i,4,j),vt_thresh_th./2);

  %save peak magnitudes and locations in a cell array
  peaks_th{i,j,1} = a_thn;
  peaks_th{i,j,2} = b_thn;
  peaks_th{i,j,3} = a_ths;
  peaks_th{i,j,4} = b_ths;

  end
end


save('/project/rg312/mat_files/snapshot_data/vt_extreme_data_th.mat','vt_thresh_th','peaks_th')



