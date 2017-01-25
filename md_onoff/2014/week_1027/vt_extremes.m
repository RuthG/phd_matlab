%load vt, rotate to lat-lon
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

load('vNt_tseries.mat')


xi=-179:2:180;yi=-89:2:90;
vt_000_ll = cube2latlon(xc,yc,vNt_000,xi,yi);
vt_010_ll = cube2latlon(xc,yc,vNt_010,xi,yi);
vt_025_ll = cube2latlon(xc,yc,vNt_025,xi,yi);
vt_050_ll = cube2latlon(xc,yc,vNt_050,xi,yi);
vt_075_ll = cube2latlon(xc,yc,vNt_075,xi,yi);
vt_100_ll = cube2latlon(xc,yc,vNt_100,xi,yi);


%start by just selecting the 29 lat circle to look at, yi(60) and yi(31)

vt_000_29(:,1:720) = squeeze(vt_000_ll(:,60,11,:));
vt_000_29(:,721:1440) = -squeeze(vt_000_ll(:,31,11,:));

vt_010_29(:,1:720) = squeeze(vt_010_ll(:,60,11,:));
vt_010_29(:,721:1440) = -squeeze(vt_010_ll(:,31,11,:));

vt_025_29(:,1:720) = squeeze(vt_025_ll(:,60,11,:));
vt_025_29(:,721:1440) = -squeeze(vt_025_ll(:,31,11,:));

vt_050_29(:,1:720) = squeeze(vt_050_ll(:,60,11,:));
vt_050_29(:,721:1440) = -squeeze(vt_050_ll(:,31,11,:));

vt_075_29(:,1:720) = squeeze(vt_075_ll(:,60,11,:));
vt_075_29(:,721:1440) = -squeeze(vt_075_ll(:,31,11,:));

vt_100_29(:,1:720) = squeeze(vt_100_ll(:,60,11,:));
vt_100_29(:,721:1440) = -squeeze(vt_100_ll(:,31,11,:));

%Try bins beween +-9000 to start

vt_bins = -9000: 60 :9000;
vt_bins_c = -8970:60:8970;

n_bins = size(vt_bins,2)-1;

%find where w lies in a given bin at each timestep

vt_binned_000 = single(zeros(180,1440,n_bins));
vt_binned_010 = single(zeros(180,1440,n_bins));
vt_binned_050 = single(zeros(180,1440,n_bins));
vt_binned_075 = single(zeros(180,1440,n_bins));
vt_binned_100 = single(zeros(180,1440,n_bins));
'vt bin matrices allocated'

for i=1:n_bins
i
vt_binned_000(:,:,i) = (vt_000_29 >= vt_bins(i) & vt_000_29 < vt_bins(i+1));
vt_binned_010(:,:,i) = (vt_010_29 >= vt_bins(i) & vt_010_29 < vt_bins(i+1));
vt_binned_025(:,:,i) = (vt_025_29 >= vt_bins(i) & vt_025_29 < vt_bins(i+1));
vt_binned_050(:,:,i) = (vt_050_29 >= vt_bins(i) & vt_050_29 < vt_bins(i+1));
vt_binned_075(:,:,i) = (vt_075_29 >= vt_bins(i) & vt_075_29 < vt_bins(i+1));
vt_binned_100(:,:,i) = (vt_100_29 >= vt_bins(i) & vt_100_29 < vt_bins(i+1));

end

vt_count_000 = squeeze(sum(sum(vt_binned_000,1),2));
vt_count_010 = squeeze(sum(sum(vt_binned_010,1),2));
vt_count_025 = squeeze(sum(sum(vt_binned_025,1),2));
vt_count_050 = squeeze(sum(sum(vt_binned_050,1),2));
vt_count_075 = squeeze(sum(sum(vt_binned_075,1),2));
vt_count_100 = squeeze(sum(sum(vt_binned_100,1),2));

vt_cumsum_000 = cumsum(vt_count_000./sum(vt_count_000));  
vt_cumsum_010 = cumsum(vt_count_010./sum(vt_count_010));  
vt_cumsum_025 = cumsum(vt_count_025./sum(vt_count_025));  
vt_cumsum_050 = cumsum(vt_count_050./sum(vt_count_050));  
vt_cumsum_075 = cumsum(vt_count_075./sum(vt_count_075));  
vt_cumsum_100 = cumsum(vt_count_100./sum(vt_count_100));  

vt_thresh_000 = vt_bins_c(min(find(vt_cumsum_000>0.95)));
vt_thresh_010 = vt_bins_c(min(find(vt_cumsum_010>0.95)));
vt_thresh_025 = vt_bins_c(min(find(vt_cumsum_025>0.95)));
vt_thresh_050 = vt_bins_c(min(find(vt_cumsum_050>0.95)));
vt_thresh_075 = vt_bins_c(min(find(vt_cumsum_075>0.95)));
vt_thresh_100 = vt_bins_c(min(find(vt_cumsum_100>0.95)));


vt_mask_000 = vt_000_29>vt_thresh_000;
vt_mask_010 = vt_010_29>vt_thresh_010;
vt_mask_025 = vt_025_29>vt_thresh_025;
vt_mask_050 = vt_050_29>vt_thresh_050;
vt_mask_075 = vt_075_29>vt_thresh_075;
vt_mask_100 = vt_100_29>vt_thresh_100;

save('vt_masks.mat','vt_mask_000','vt_mask_010','vt_mask_025','vt_mask_050','vt_mask_075','vt_mask_100');




