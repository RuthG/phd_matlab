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

t_000_ll = cube2latlon(xc,yc,t_000,xi,yi);
clear('t_000');
t_000_ll_tav = repmat(mean(t_000_ll,4),[1 1 1 720]);
t_ed_000_ll =  t_000_ll - t_000_ll_tav;
clear('t_000_ll_tav');

t_010_ll = cube2latlon(xc,yc,t_010,xi,yi);
clear('t_010');
t_010_ll_tav = repmat(mean(t_010_ll,4),[1 1 1 720]);
t_ed_010_ll =  t_010_ll - t_010_ll_tav;
clear('t_010_ll_tav');

t_025_ll = cube2latlon(xc,yc,t_025,xi,yi);
clear('t_025');
t_025_ll_tav = repmat(mean(t_025_ll,4),[1 1 1 720]);
t_ed_025_ll =  t_025_ll - t_025_ll_tav;
clear('t_025_ll_tav');

t_050_ll = cube2latlon(xc,yc,t_050,xi,yi);
clear('t_050');
t_050_ll_tav = repmat(mean(t_050_ll,4),[1 1 1 720]);
t_ed_050_ll =  t_050_ll - t_050_ll_tav;
clear('t_050_ll_tav');

t_075_ll = cube2latlon(xc,yc,t_075,xi,yi);
clear('t_075');
t_075_ll_tav = repmat(mean(t_075_ll,4),[1 1 1 720]);
t_ed_075_ll =  t_075_ll - t_075_ll_tav;
clear('t_075_ll_tav');

t_100_ll = cube2latlon(xc,yc,t_100,xi,yi);
clear('t_100');
t_100_ll_tav = repmat(mean(t_100_ll,4),[1 1 1 720]);
t_ed_100_ll =  t_100_ll - t_100_ll_tav;
clear('t_100_ll_tav');

load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')


vN_000_ll = cube2latlon(xc,yc,vN_000,xi,yi);
clear('vN_000');
vN_000_ll_tav = repmat(mean(vN_000_ll,4),[1 1 1 720]);
vN_ed_000_ll =  vN_000_ll - vN_000_ll_tav;
clear('vN_000_ll_tav');

vN_010_ll = cube2latlon(xc,yc,vN_010,xi,yi);
clear('vN_010');
vN_010_ll_tav = repmat(mean(vN_010_ll,4),[1 1 1 720]);
vN_ed_010_ll =  vN_010_ll - vN_010_ll_tav;
clear('vN_010_ll_tav');

vN_025_ll = cube2latlon(xc,yc,vN_025,xi,yi);
clear('vN_025');
vN_025_ll_tav = repmat(mean(vN_025_ll,4),[1 1 1 720]);
vN_ed_025_ll =  vN_025_ll - vN_025_ll_tav;
clear('vN_025_ll_tav');

vN_050_ll = cube2latlon(xc,yc,vN_050,xi,yi);
clear('vN_050');
vN_050_ll_tav = repmat(mean(vN_050_ll,4),[1 1 1 720]);
vN_ed_050_ll =  vN_050_ll - vN_050_ll_tav;
clear('vN_050_ll_tav');

vN_075_ll = cube2latlon(xc,yc,vN_075,xi,yi);
clear('vN_075');
vN_075_ll_tav = repmat(mean(vN_075_ll,4),[1 1 1 720]);
vN_ed_075_ll =  vN_075_ll - vN_075_ll_tav;
clear('vN_075_ll_tav');

vN_100_ll = cube2latlon(xc,yc,vN_100,xi,yi);
clear('vN_100');
vN_100_ll_tav = repmat(mean(vN_100_ll,4),[1 1 1 720]);
vN_ed_100_ll =  vN_100_ll - vN_100_ll_tav;
clear('vN_100_ll_tav');

vNt_ed_000 = vN_ed_000_ll.*t_ed_000_ll;
vNt_ed_010 = vN_ed_010_ll.*t_ed_010_ll;
vNt_ed_025 = vN_ed_025_ll.*t_ed_025_ll;
vNt_ed_050 = vN_ed_050_ll.*t_ed_050_ll;
vNt_ed_075 = vN_ed_075_ll.*t_ed_075_ll;
vNt_ed_100 = vN_ed_100_ll.*t_ed_100_ll;

vN_ed_000_h(:,:,1:720) = vN_ed_000_ll(:,46:90,5,:);
vN_ed_000_h(:,:,721:1440) = -flipdim(vN_ed_000_ll(:,1:45,5,:),2);
clear vN_ed_000_ll;
vNt_ed_000_h(:,:,1:720) = vNt_ed_000(:,46:90,5,:);
vNt_ed_000_h(:,:,721:1440) = -flipdim(vNt_ed_000(:,1:45,5,:),2);
clear vNt_ed_000;
t_ed_000_h(:,:,1:720) = t_ed_000_ll(:,46:90,5,:);
t_ed_000_h(:,:,721:1440) = flipdim(t_ed_000_ll(:,1:45,5,:),2);
clear t_ed_000_ll;

vN_ed_010_h(:,:,1:720) = vN_ed_010_ll(:,46:90,5,:);
vN_ed_010_h(:,:,721:1440) = -flipdim(vN_ed_010_ll(:,1:45,5,:),2);
clear vN_ed_010_ll;
vNt_ed_010_h(:,:,1:720) = vNt_ed_010(:,46:90,5,:);
vNt_ed_010_h(:,:,721:1440) = -flipdim(vNt_ed_010(:,1:45,5,:),2);
clear vNt_ed_010;
t_ed_010_h(:,:,1:720) = t_ed_010_ll(:,46:90,5,:);
t_ed_010_h(:,:,721:1440) = flipdim(t_ed_010_ll(:,1:45,5,:),2);
clear t_ed_010_ll;

vN_ed_025_h(:,:,1:720) = vN_ed_025_ll(:,46:90,5,:);
vN_ed_025_h(:,:,721:1440) = -flipdim(vN_ed_025_ll(:,1:45,5,:),2);
clear vN_ed_025_ll;
vNt_ed_025_h(:,:,1:720) = vNt_ed_025(:,46:90,5,:);
vNt_ed_025_h(:,:,721:1440) = -flipdim(vNt_ed_025(:,1:45,5,:),2);
clear vNt_ed_025;
t_ed_025_h(:,:,1:720) = t_ed_025_ll(:,46:90,5,:);
t_ed_025_h(:,:,721:1440) = flipdim(t_ed_025_ll(:,1:45,5,:),2);
clear t_ed_025_ll;

vN_ed_050_h(:,:,1:720) = vN_ed_050_ll(:,46:90,5,:);
vN_ed_050_h(:,:,721:1440) = -flipdim(vN_ed_050_ll(:,1:45,5,:),2);
clear vN_ed_050_ll;
vNt_ed_050_h(:,:,1:720) = vNt_ed_050(:,46:90,5,:);
vNt_ed_050_h(:,:,721:1440) = -flipdim(vNt_ed_050(:,1:45,5,:),2);
clear vNt_ed_050;
t_ed_050_h(:,:,1:720) = t_ed_050_ll(:,46:90,5,:);
t_ed_050_h(:,:,721:1440) = flipdim(t_ed_050_ll(:,1:45,5,:),2);
clear t_ed_050_ll;

vN_ed_075_h(:,:,1:720) = vN_ed_075_ll(:,46:90,5,:);
vN_ed_075_h(:,:,721:1440) = -flipdim(vN_ed_075_ll(:,1:45,5,:),2);
clear vN_ed_075_ll;
vNt_ed_075_h(:,:,1:720) = vNt_ed_075(:,46:90,5,:);
vNt_ed_075_h(:,:,721:1440) = -flipdim(vNt_ed_075(:,1:45,5,:),2);
clear vNt_ed_075;
t_ed_075_h(:,:,1:720) = t_ed_075_ll(:,46:90,5,:);
t_ed_075_h(:,:,721:1440) = flipdim(t_ed_075_ll(:,1:45,5,:),2);
clear t_ed_075_ll;

vN_ed_100_h(:,:,1:720) = vN_ed_100_ll(:,46:90,5,:);
vN_ed_100_h(:,:,721:1440) = -flipdim(vN_ed_100_ll(:,1:45,5,:),2);
clear vN_ed_100_ll;
vNt_ed_100_h(:,:,1:720) = vNt_ed_100(:,46:90,5,:);
vNt_ed_100_h(:,:,721:1440) = -flipdim(vNt_ed_100(:,1:45,5,:),2);
clear vNt_ed_100;
t_ed_100_h(:,:,1:720) = t_ed_100_ll(:,46:90,5,:);
t_ed_100_h(:,:,721:1440) = flipdim(t_ed_100_ll(:,1:45,5,:),2);
clear t_ed_100_ll;


vN_mask_000 = +(vN_ed_000_h > 0);
vN_mask_010 = +(vN_ed_010_h > 0);
vN_mask_025 = +(vN_ed_025_h > 0);
vN_mask_050 = +(vN_ed_050_h > 0);
vN_mask_075 = +(vN_ed_075_h > 0);
vN_mask_100 = +(vN_ed_100_h > 0);

vt_bins = -400:4:400;
v_bins = -40:0.4:40;
t_bins = -16:0.16:16;

vNt_dist_000 = zeros(200,1);
vNt_dist_010 = zeros(200,1);
vNt_dist_025 = zeros(200,1);
vNt_dist_050 = zeros(200,1);
vNt_dist_075 = zeros(200,1);
vNt_dist_100 = zeros(200,1);

vNt_dist_000_vpos = zeros(200,1);
vNt_dist_010_vpos = zeros(200,1);
vNt_dist_025_vpos = zeros(200,1);
vNt_dist_050_vpos = zeros(200,1);
vNt_dist_075_vpos = zeros(200,1);
vNt_dist_100_vpos = zeros(200,1);

vNt_dist_000_vneg = zeros(200,1);
vNt_dist_010_vneg = zeros(200,1);
vNt_dist_025_vneg = zeros(200,1);
vNt_dist_050_vneg = zeros(200,1);
vNt_dist_075_vneg = zeros(200,1);
vNt_dist_100_vneg = zeros(200,1);


t_dist_000 = zeros(200,1);
t_dist_010 = zeros(200,1);
t_dist_025 = zeros(200,1);
t_dist_050 = zeros(200,1);
t_dist_075 = zeros(200,1);
t_dist_100 = zeros(200,1);

t_dist_000_vpos = zeros(200,1);
t_dist_010_vpos = zeros(200,1);
t_dist_025_vpos = zeros(200,1);
t_dist_050_vpos = zeros(200,1);
t_dist_075_vpos = zeros(200,1);
t_dist_100_vpos = zeros(200,1);

t_dist_000_vneg = zeros(200,1);
t_dist_010_vneg = zeros(200,1);
t_dist_025_vneg = zeros(200,1);
t_dist_050_vneg = zeros(200,1);
t_dist_075_vneg = zeros(200,1);
t_dist_100_vneg = zeros(200,1);


vN_dist_000 = zeros(200,1);
vN_dist_010 = zeros(200,1);
vN_dist_025 = zeros(200,1);
vN_dist_050 = zeros(200,1);
vN_dist_075 = zeros(200,1);
vN_dist_100 = zeros(200,1);

t_vNt_bins_000 = zeros(200,180,45,1440);
t_vNt_bins_010 = zeros(200,180,45,1440);
t_vNt_bins_025 = zeros(200,180,45,1440);
t_vNt_bins_050 = zeros(200,180,45,1440);
t_vNt_bins_075 = zeros(200,180,45,1440);
t_vNt_bins_100 = zeros(200,180,45,1440);

vN_vNt_bins_000 = zeros(200,180,45,1440);
vN_vNt_bins_010 = zeros(200,180,45,1440);
vN_vNt_bins_025 = zeros(200,180,45,1440);
vN_vNt_bins_050 = zeros(200,180,45,1440);
vN_vNt_bins_075 = zeros(200,180,45,1440);
vN_vNt_bins_100 = zeros(200,180,45,1440);

  %go through and add counts of vt values to the bins
  for k=1:200
k
  vNt_binned_000 = +(vNt_ed_000_h >= vt_bins(k) & vNt_ed_000_h < vt_bins(k+1));
  vNt_binned_010 = +(vNt_ed_010_h >= vt_bins(k) & vNt_ed_010_h < vt_bins(k+1));
  vNt_binned_025 = +(vNt_ed_025_h >= vt_bins(k) & vNt_ed_025_h < vt_bins(k+1));
  vNt_binned_050 = +(vNt_ed_050_h >= vt_bins(k) & vNt_ed_050_h < vt_bins(k+1));
  vNt_binned_075 = +(vNt_ed_075_h >= vt_bins(k) & vNt_ed_075_h < vt_bins(k+1));
  vNt_binned_100 = +(vNt_ed_100_h >= vt_bins(k) & vNt_ed_100_h < vt_bins(k+1));

  t_vNt_bins_000(k,:,:,:) = t_ed_000_h.*vNt_binned_000;
  t_vNt_bins_010(k,:,:,:) = t_ed_010_h.*vNt_binned_010;
  t_vNt_bins_025(k,:,:,:) = t_ed_025_h.*vNt_binned_025;
  t_vNt_bins_050(k,:,:,:) = t_ed_050_h.*vNt_binned_050;
  t_vNt_bins_075(k,:,:,:) = t_ed_075_h.*vNt_binned_075;
  t_vNt_bins_100(k,:,:,:) = t_ed_100_h.*vNt_binned_100;

  vN_vNt_bins_000(k,:,:,:) = vN_ed_000_h.*vNt_binned_000;
  vN_vNt_bins_010(k,:,:,:) = vN_ed_010_h.*vNt_binned_010;
  vN_vNt_bins_025(k,:,:,:) = vN_ed_025_h.*vNt_binned_025;
  vN_vNt_bins_050(k,:,:,:) = vN_ed_050_h.*vNt_binned_050;
  vN_vNt_bins_075(k,:,:,:) = vN_ed_075_h.*vNt_binned_075;
  vN_vNt_bins_100(k,:,:,:) = vN_ed_100_h.*vNt_binned_100;

  vN_binned_000 = +(vN_ed_000_h >= vt_bins(k) & vN_ed_000_h < vt_bins(k+1));
  vN_binned_010 = +(vN_ed_010_h >= vt_bins(k) & vN_ed_010_h < vt_bins(k+1));
  vN_binned_025 = +(vN_ed_025_h >= vt_bins(k) & vN_ed_025_h < vt_bins(k+1));
  vN_binned_050 = +(vN_ed_050_h >= vt_bins(k) & vN_ed_050_h < vt_bins(k+1));
  vN_binned_075 = +(vN_ed_075_h >= vt_bins(k) & vN_ed_075_h < vt_bins(k+1));
  vN_binned_100 = +(vN_ed_100_h >= vt_bins(k) & vN_ed_100_h < vt_bins(k+1));

  t_binned_000 = +(t_ed_000_h >= vt_bins(k) & t_ed_000_h < vt_bins(k+1));
  t_binned_010 = +(t_ed_010_h >= vt_bins(k) & t_ed_010_h < vt_bins(k+1));
  t_binned_025 = +(t_ed_025_h >= vt_bins(k) & t_ed_025_h < vt_bins(k+1));
  t_binned_050 = +(t_ed_050_h >= vt_bins(k) & t_ed_050_h < vt_bins(k+1));
  t_binned_075 = +(t_ed_075_h >= vt_bins(k) & t_ed_075_h < vt_bins(k+1));
  t_binned_100 = +(t_ed_100_h >= vt_bins(k) & t_ed_100_h < vt_bins(k+1));


  vNt_dist_000(k) = vNt_dist_000(k) + sum(sum(sum( vNt_binned_000 )));
  vNt_dist_010(k) = vNt_dist_010(k) + sum(sum(sum( vNt_binned_010 )));
  vNt_dist_025(k) = vNt_dist_025(k) + sum(sum(sum( vNt_binned_025 )));
  vNt_dist_050(k) = vNt_dist_050(k) + sum(sum(sum( vNt_binned_050 )));
  vNt_dist_075(k) = vNt_dist_075(k) + sum(sum(sum( vNt_binned_075 )));
  vNt_dist_100(k) = vNt_dist_100(k) + sum(sum(sum( vNt_binned_100 )));


  vN_dist_000(k) = vN_dist_000(k) + sum(sum(sum( vN_binned_000 )));
  vN_dist_010(k) = vN_dist_010(k) + sum(sum(sum( vN_binned_010 )));
  vN_dist_025(k) = vN_dist_025(k) + sum(sum(sum( vN_binned_025 )));
  vN_dist_050(k) = vN_dist_050(k) + sum(sum(sum( vN_binned_050 )));
  vN_dist_075(k) = vN_dist_075(k) + sum(sum(sum( vN_binned_075 )));
  vN_dist_100(k) = vN_dist_100(k) + sum(sum(sum( vN_binned_100 )));


  t_dist_000(k) = t_dist_000(k) + sum(sum(sum( t_binned_000 )));
  t_dist_010(k) = t_dist_010(k) + sum(sum(sum( t_binned_010 )));
  t_dist_025(k) = t_dist_025(k) + sum(sum(sum( t_binned_025 )));
  t_dist_050(k) = t_dist_050(k) + sum(sum(sum( t_binned_050 )));
  t_dist_075(k) = t_dist_075(k) + sum(sum(sum( t_binned_075 )));
  t_dist_100(k) = t_dist_100(k) + sum(sum(sum( t_binned_100 )));


  vNt_dist_000_vpos(k) = vNt_dist_000_vpos(k) + sum(sum(sum( vNt_binned_000.*vN_mask_000 )));
  vNt_dist_010_vpos(k) = vNt_dist_010_vpos(k) + sum(sum(sum( vNt_binned_010.*vN_mask_010 )));
  vNt_dist_025_vpos(k) = vNt_dist_025_vpos(k) + sum(sum(sum( vNt_binned_025.*vN_mask_025 )));
  vNt_dist_050_vpos(k) = vNt_dist_050_vpos(k) + sum(sum(sum( vNt_binned_050.*vN_mask_050 )));
  vNt_dist_075_vpos(k) = vNt_dist_075_vpos(k) + sum(sum(sum( vNt_binned_075.*vN_mask_075 )));
  vNt_dist_100_vpos(k) = vNt_dist_100_vpos(k) + sum(sum(sum( vNt_binned_100.*vN_mask_100 )));


  vNt_dist_000_vneg(k) = vNt_dist_000_vneg(k) + sum(sum(sum( vNt_binned_000.*(1-vN_mask_000) )));
  vNt_dist_010_vneg(k) = vNt_dist_010_vneg(k) + sum(sum(sum( vNt_binned_010.*(1-vN_mask_010) )));
  vNt_dist_025_vneg(k) = vNt_dist_025_vneg(k) + sum(sum(sum( vNt_binned_025.*(1-vN_mask_025) )));
  vNt_dist_050_vneg(k) = vNt_dist_050_vneg(k) + sum(sum(sum( vNt_binned_050.*(1-vN_mask_050) )));
  vNt_dist_075_vneg(k) = vNt_dist_075_vneg(k) + sum(sum(sum( vNt_binned_075.*(1-vN_mask_075) )));
  vNt_dist_100_vneg(k) = vNt_dist_100_vneg(k) + sum(sum(sum( vNt_binned_100.*(1-vN_mask_100) )));


  t_dist_000_vpos(k) = t_dist_000_vpos(k) + sum(sum(sum( t_binned_000.*vN_mask_000 )));
  t_dist_010_vpos(k) = t_dist_010_vpos(k) + sum(sum(sum( t_binned_010.*vN_mask_010 )));
  t_dist_025_vpos(k) = t_dist_025_vpos(k) + sum(sum(sum( t_binned_025.*vN_mask_025 )));
  t_dist_050_vpos(k) = t_dist_050_vpos(k) + sum(sum(sum( t_binned_050.*vN_mask_050 )));
  t_dist_075_vpos(k) = t_dist_075_vpos(k) + sum(sum(sum( t_binned_075.*vN_mask_075 )));
  t_dist_100_vpos(k) = t_dist_100_vpos(k) + sum(sum(sum( t_binned_100.*vN_mask_100 )));


  t_dist_000_vneg(k) = t_dist_000_vneg(k) + sum(sum(sum( t_binned_000.*(1-vN_mask_000) )));
  t_dist_010_vneg(k) = t_dist_010_vneg(k) + sum(sum(sum( t_binned_010.*(1-vN_mask_010) )));
  t_dist_025_vneg(k) = t_dist_025_vneg(k) + sum(sum(sum( t_binned_025.*(1-vN_mask_025) )));
  t_dist_050_vneg(k) = t_dist_050_vneg(k) + sum(sum(sum( t_binned_050.*(1-vN_mask_050) )));
  t_dist_075_vneg(k) = t_dist_075_vneg(k) + sum(sum(sum( t_binned_075.*(1-vN_mask_075) )));
  t_dist_100_vneg(k) = t_dist_100_vneg(k) + sum(sum(sum( t_binned_100.*(1-vN_mask_100) )));



  end
  


