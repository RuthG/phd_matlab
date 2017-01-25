%vtpdf for only the 025 run, see if doing 1 at a time is less anti-social...

%load in v't' and plot pdf of values to see change in distribution as wv increases.
%then look at distribution associated with only negative or positive v' and t' values

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



load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat')

%transfer t to ll
xi=-179:2:180;yi=-89:2:90;

clear('t_000');
clear('t_010');
clear('t_100');
clear('t_050');
clear('t_075');

t_025_ll = cube2latlon(xc,yc,t_025,xi,yi);
clear('t_025');
t_025_ll_tav = repmat(mean(t_025_ll,4),[1 1 1 720]);
t_ed_025_ll =  t_025_ll - t_025_ll_tav;
clear('t_025_ll_tav');

load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')

clear('vN_000');
clear('vN_010');
clear('vN_100');
clear('vN_050');
clear('vN_075');

vN_025_ll = cube2latlon(xc,yc,vN_025,xi,yi);
clear('vN_025');
vN_025_ll_tav = repmat(mean(vN_025_ll,4),[1 1 1 720]);
vN_ed_025_ll =  vN_025_ll - vN_025_ll_tav;
clear('vN_025_ll_tav');

vNt_ed_025 = vN_ed_025_ll.*t_ed_025_ll;
vN_ed_025_h(:,:,1:720) = vN_ed_025_ll(:,46:90,5,:);
vN_ed_025_h(:,:,721:1440) = -flipdim(vN_ed_025_ll(:,1:45,5,:),2);
clear vN_ed_025_ll;
vNt_ed_025_h(:,:,1:720) = vNt_ed_025(:,46:90,5,:);
vNt_ed_025_h(:,:,721:1440) = -flipdim(vNt_ed_025(:,1:45,5,:),2);
clear vNt_ed_025;
t_ed_025_h(:,:,1:720) = t_ed_025_ll(:,46:90,5,:);
t_ed_025_h(:,:,721:1440) = flipdim(t_ed_025_ll(:,1:45,5,:),2);
clear t_ed_025_ll;


vN_mask_025 = +(vN_ed_025_h > 0);

vt_bins = -400:4:400;
v_bins = -40:0.4:40;
t_bins = -16:0.16:16;

vNt_dist_025 = zeros(200,1);
vNt_dist_025_vpos = zeros(200,1);
vNt_dist_025_vneg = zeros(200,1);

t_dist_025 = zeros(200,1);
t_dist_025_vpos = zeros(200,1);
t_dist_025_vneg = zeros(200,1);

vN_dist_025 = zeros(200,1);
t_vNt_bins_025 = zeros(200,180,45,1440);
vN_vNt_bins_025 = zeros(200,180,45,1440);

  %go through and add counts of vt values to the bins
  for k=1:200
k

  vNt_binned_025 = +(vNt_ed_025_h >= vt_bins(k) & vNt_ed_025_h < vt_bins(k+1));
  t_vNt_bins_025(k,:,:,:) = t_ed_025_h.*vNt_binned_025;
  vN_vNt_bins_025(k,:,:,:) = vN_ed_025_h.*vNt_binned_025;


  vN_binned_025 = +(vN_ed_025_h >= vt_bins(k) & vN_ed_025_h < vt_bins(k+1));
  t_binned_025 = +(t_ed_025_h >= vt_bins(k) & t_ed_025_h < vt_bins(k+1));

  vNt_dist_025(k) = vNt_dist_025(k) + sum(sum(sum( vNt_binned_025 )));
  vN_dist_025(k) = vN_dist_025(k) + sum(sum(sum( vN_binned_025 )));
  t_dist_025(k) = t_dist_025(k) + sum(sum(sum( t_binned_025 )));

  vNt_dist_025_vpos(k) = vNt_dist_025_vpos(k) + sum(sum(sum( vNt_binned_025.*vN_mask_025 )));
  vNt_dist_025_vneg(k) = vNt_dist_025_vneg(k) + sum(sum(sum( vNt_binned_025.*(1-vN_mask_025) )));

  t_dist_025_vpos(k) = t_dist_025_vpos(k) + sum(sum(sum( t_binned_025.*vN_mask_025 )));
  t_dist_025_vneg(k) = t_dist_025_vneg(k) + sum(sum(sum( t_binned_025.*(1-vN_mask_025) )));



  end
  

vNt_dist_025_cs = cumsum(vNt_dist_025)./sum(vNt_dist_025);

vNt_025_thresh = min(find(vNt_dist_025_cs>0.95));

t_reduced = t_vNt_bins_025(vNt_025_thresh:200,:,:,:);
t_extvNt_025 = t_reduced(t_reduced~=0);
clear t_reduced

vN_reduced = vN_vNt_bins_025(vNt_025_thresh:200,:,:,:);
vN_extvNt_025 = vN_reduced(vN_reduced~=0);
clear vN_reduced

save('/project/rg312/mat_files/vNt_scatter_025.mat','vN_extvNt_025','t_extvNt_025')

