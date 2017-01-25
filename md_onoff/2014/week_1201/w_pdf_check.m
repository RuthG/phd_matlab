%load w snapshots, make pdf of values in region used for composites

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

load('/project/rg312/mat_files/snapshot_data/vt_extreme_data.mat')
load('/project/rg312/mat_files/vt_lats.mat')
load('/project/rg312/mat_files/snapshot_data/w_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/vt_ed_data.mat')

%transfer w to ll
xi=-179:2:180;yi=-89:2:90;
w_000_ll = cube2latlon(xc,yc,w_000,xi,yi);
w_010_ll = cube2latlon(xc,yc,w_010,xi,yi);
w_025_ll = cube2latlon(xc,yc,w_025,xi,yi);
w_050_ll = cube2latlon(xc,yc,w_050,xi,yi);
w_075_ll = cube2latlon(xc,yc,w_075,xi,yi);
w_100_ll = cube2latlon(xc,yc,w_100,xi,yi);

%locate region of interest
w_000_n = squeeze(w_000_ll(:,x000n-7:x000n+7,:,:));
w_010_n = squeeze(w_010_ll(:,x010n-7:x010n+7,:,:));
w_025_n = squeeze(w_025_ll(:,x025n-7:x025n+7,:,:));
w_050_n = squeeze(w_050_ll(:,x050n-7:x050n+7,:,:));
w_075_n = squeeze(w_075_ll(:,x075n-7:x075n+7,:,:));
w_100_n = squeeze(w_100_ll(:,x100n-7:x100n+7,:,:));

w_000_s = squeeze(w_000_ll(:,x000s-7:x000s+7,:,:));
w_010_s = squeeze(w_010_ll(:,x010s-7:x010s+7,:,:));
w_025_s = squeeze(w_025_ll(:,x025s-7:x025s+7,:,:));
w_050_s = squeeze(w_050_ll(:,x050s-7:x050s+7,:,:));
w_075_s = squeeze(w_075_ll(:,x075s-7:x075s+7,:,:));
w_100_s = squeeze(w_100_ll(:,x100s-7:x100s+7,:,:));

w_mean_000_n = mean(w_000_n(:,:,4,:),4);
w_mean_000_s = mean(w_000_s(:,:,4,:),4);
w_mean_010_n = mean(w_010_n(:,:,4,:),4);
w_mean_010_s = mean(w_010_s(:,:,4,:),4);
w_mean_025_n = mean(w_025_n(:,:,4,:),4);
w_mean_025_s = mean(w_025_s(:,:,4,:),4);
w_mean_050_n = mean(w_050_n(:,:,4,:),4);
w_mean_050_s = mean(w_050_s(:,:,4,:),4);
w_mean_075_n = mean(w_075_n(:,:,4,:),4);
w_mean_075_s = mean(w_075_s(:,:,4,:),4);
w_mean_100_n = mean(w_100_n(:,:,4,:),4);
w_mean_100_s = mean(w_100_s(:,:,4,:),4);


for j=1:720
w_ed_000_n(:,:,j) = w_000_n(:,:,4,j) - w_mean_000_n;
w_ed_000_s(:,:,j) = w_000_s(:,:,4,j) - w_mean_000_s;
w_ed_010_n(:,:,j) = w_010_n(:,:,4,j) - w_mean_010_n;
w_ed_010_s(:,:,j) = w_010_s(:,:,4,j) - w_mean_010_s;
w_ed_025_n(:,:,j) = w_025_n(:,:,4,j) - w_mean_025_n;
w_ed_025_s(:,:,j) = w_025_s(:,:,4,j) - w_mean_025_s;
w_ed_050_n(:,:,j) = w_050_n(:,:,4,j) - w_mean_050_n;
w_ed_050_s(:,:,j) = w_050_s(:,:,4,j) - w_mean_050_s;
w_ed_075_n(:,:,j) = w_075_n(:,:,4,j) - w_mean_075_n;
w_ed_075_s(:,:,j) = w_075_s(:,:,4,j) - w_mean_075_s;
w_ed_100_n(:,:,j) = w_100_n(:,:,4,j) - w_mean_100_n;
w_ed_100_s(:,:,j) = w_100_s(:,:,4,j) - w_mean_100_s;
end


%choose bins

w_bins = -1.5: 0.01 : 1.5;
w_bins_c = -1.495: 0.01 : 1.495;

peak_dist_000 = zeros(300,1);
peak_dist_010 = zeros(300,1);
peak_dist_025 = zeros(300,1);
peak_dist_050 = zeros(300,1);
peak_dist_075 = zeros(300,1);
peak_dist_100 = zeros(300,1);

peak_dist_000_vt = zeros(300,1);
peak_dist_010_vt = zeros(300,1);
peak_dist_025_vt = zeros(300,1);
peak_dist_050_vt = zeros(300,1);
peak_dist_075_vt = zeros(300,1);
peak_dist_100_vt = zeros(300,1);

peak_dist_ed_000 = zeros(300,1);
peak_dist_ed_010 = zeros(300,1);
peak_dist_ed_025 = zeros(300,1);
peak_dist_ed_050 = zeros(300,1);
peak_dist_ed_075 = zeros(300,1);
peak_dist_ed_100 = zeros(300,1);

peak_dist_000_ed_vt = zeros(300,1);
peak_dist_010_ed_vt = zeros(300,1);
peak_dist_025_ed_vt = zeros(300,1);
peak_dist_050_ed_vt = zeros(300,1);
peak_dist_075_ed_vt = zeros(300,1);
peak_dist_100_ed_vt = zeros(300,1);


  %go through and add counts of vt values to the bins
  for k=1:300
k
  peak_dist_000(k) = peak_dist_000(k) + sum(sum(sum( w_000_n(:,:,4,:) >= w_bins(k) & w_000_n(:,:,4,:) < w_bins(k+1))));
  peak_dist_000(k) = peak_dist_000(k) + sum(sum(sum( w_000_s(:,:,4,:) >= w_bins(k) & w_000_s(:,:,4,:) < w_bins(k+1))));
  peak_dist_010(k) = peak_dist_010(k) + sum(sum(sum( w_010_n(:,:,4,:) >= w_bins(k) & w_010_n(:,:,4,:) < w_bins(k+1))));
  peak_dist_010(k) = peak_dist_010(k) + sum(sum(sum( w_010_s(:,:,4,:) >= w_bins(k) & w_010_s(:,:,4,:) < w_bins(k+1))));
  peak_dist_025(k) = peak_dist_025(k) + sum(sum(sum( w_025_n(:,:,4,:) >= w_bins(k) & w_025_n(:,:,4,:) < w_bins(k+1))));
  peak_dist_025(k) = peak_dist_025(k) + sum(sum(sum( w_025_s(:,:,4,:) >= w_bins(k) & w_025_s(:,:,4,:) < w_bins(k+1))));
  peak_dist_050(k) = peak_dist_050(k) + sum(sum(sum( w_050_n(:,:,4,:) >= w_bins(k) & w_050_n(:,:,4,:) < w_bins(k+1))));
  peak_dist_050(k) = peak_dist_050(k) + sum(sum(sum( w_050_s(:,:,4,:) >= w_bins(k) & w_050_s(:,:,4,:) < w_bins(k+1))));
  peak_dist_075(k) = peak_dist_075(k) + sum(sum(sum( w_075_n(:,:,4,:) >= w_bins(k) & w_075_n(:,:,4,:) < w_bins(k+1))));
  peak_dist_075(k) = peak_dist_075(k) + sum(sum(sum( w_075_s(:,:,4,:) >= w_bins(k) & w_075_s(:,:,4,:) < w_bins(k+1))));
  peak_dist_100(k) = peak_dist_100(k) + sum(sum(sum( w_100_n(:,:,4,:) >= w_bins(k) & w_100_n(:,:,4,:) < w_bins(k+1))));
  peak_dist_100(k) = peak_dist_100(k) + sum(sum(sum( w_100_s(:,:,4,:) >= w_bins(k) & w_100_s(:,:,4,:) < w_bins(k+1))));

  peak_dist_000_vt(k) = peak_dist_000_vt(k) + sum(sum(sum( w_000_n(:,:,4,:) >= w_bins(k) & w_000_n(:,:,4,:) < w_bins(k+1) & vt_ed_000n(:,:,4,:) >= vt_thresh_000)));
  peak_dist_000_vt(k) = peak_dist_000_vt(k) + sum(sum(sum( w_000_s(:,:,4,:) >= w_bins(k) & w_000_s(:,:,4,:) < w_bins(k+1) & vt_ed_000s(:,:,4,:) >= vt_thresh_000)));
  peak_dist_010_vt(k) = peak_dist_010_vt(k) + sum(sum(sum( w_010_n(:,:,4,:) >= w_bins(k) & w_010_n(:,:,4,:) < w_bins(k+1) & vt_ed_010n(:,:,4,:) >= vt_thresh_010)));
  peak_dist_010_vt(k) = peak_dist_010_vt(k) + sum(sum(sum( w_010_s(:,:,4,:) >= w_bins(k) & w_010_s(:,:,4,:) < w_bins(k+1) & vt_ed_010s(:,:,4,:) >= vt_thresh_010)));
  peak_dist_025_vt(k) = peak_dist_025_vt(k) + sum(sum(sum( w_025_n(:,:,4,:) >= w_bins(k) & w_025_n(:,:,4,:) < w_bins(k+1) & vt_ed_025n(:,:,4,:) >= vt_thresh_025)));
  peak_dist_025_vt(k) = peak_dist_025_vt(k) + sum(sum(sum( w_025_s(:,:,4,:) >= w_bins(k) & w_025_s(:,:,4,:) < w_bins(k+1) & vt_ed_025s(:,:,4,:) >= vt_thresh_025)));
  peak_dist_050_vt(k) = peak_dist_050_vt(k) + sum(sum(sum( w_050_n(:,:,4,:) >= w_bins(k) & w_050_n(:,:,4,:) < w_bins(k+1) & vt_ed_050n(:,:,4,:) >= vt_thresh_050)));
  peak_dist_050_vt(k) = peak_dist_050_vt(k) + sum(sum(sum( w_050_s(:,:,4,:) >= w_bins(k) & w_050_s(:,:,4,:) < w_bins(k+1) & vt_ed_050s(:,:,4,:) >= vt_thresh_050)));
  peak_dist_075_vt(k) = peak_dist_075_vt(k) + sum(sum(sum( w_075_n(:,:,4,:) >= w_bins(k) & w_075_n(:,:,4,:) < w_bins(k+1) & vt_ed_075n(:,:,4,:) >= vt_thresh_075)));
  peak_dist_075_vt(k) = peak_dist_075_vt(k) + sum(sum(sum( w_075_s(:,:,4,:) >= w_bins(k) & w_075_s(:,:,4,:) < w_bins(k+1) & vt_ed_075s(:,:,4,:) >= vt_thresh_075)));
  peak_dist_100_vt(k) = peak_dist_100_vt(k) + sum(sum(sum( w_100_n(:,:,4,:) >= w_bins(k) & w_100_n(:,:,4,:) < w_bins(k+1) & vt_ed_100n(:,:,4,:) >= vt_thresh_100)));
  peak_dist_100_vt(k) = peak_dist_100_vt(k) + sum(sum(sum( w_100_s(:,:,4,:) >= w_bins(k) & w_100_s(:,:,4,:) < w_bins(k+1) & vt_ed_100s(:,:,4,:) >= vt_thresh_100)));

  peak_dist_ed_000(k) = peak_dist_ed_000(k) + sum(sum(sum( w_ed_000_n >= w_bins(k) & w_ed_000_n < w_bins(k+1))));
  peak_dist_ed_000(k) = peak_dist_ed_000(k) + sum(sum(sum( w_ed_000_s >= w_bins(k) & w_ed_000_s < w_bins(k+1))));
  peak_dist_ed_010(k) = peak_dist_ed_010(k) + sum(sum(sum( w_ed_010_n >= w_bins(k) & w_ed_010_n < w_bins(k+1))));
  peak_dist_ed_010(k) = peak_dist_ed_010(k) + sum(sum(sum( w_ed_010_s >= w_bins(k) & w_ed_010_s < w_bins(k+1))));
  peak_dist_ed_025(k) = peak_dist_ed_025(k) + sum(sum(sum( w_ed_025_n >= w_bins(k) & w_ed_025_n < w_bins(k+1))));
  peak_dist_ed_025(k) = peak_dist_ed_025(k) + sum(sum(sum( w_ed_025_s >= w_bins(k) & w_ed_025_s < w_bins(k+1))));
  peak_dist_ed_050(k) = peak_dist_ed_050(k) + sum(sum(sum( w_ed_050_n >= w_bins(k) & w_ed_050_n < w_bins(k+1))));
  peak_dist_ed_050(k) = peak_dist_ed_050(k) + sum(sum(sum( w_ed_050_s >= w_bins(k) & w_ed_050_s < w_bins(k+1))));
  peak_dist_ed_075(k) = peak_dist_ed_075(k) + sum(sum(sum( w_ed_075_n >= w_bins(k) & w_ed_075_n < w_bins(k+1))));
  peak_dist_ed_075(k) = peak_dist_ed_075(k) + sum(sum(sum( w_ed_075_s >= w_bins(k) & w_ed_075_s < w_bins(k+1))));
  peak_dist_ed_100(k) = peak_dist_ed_100(k) + sum(sum(sum( w_ed_100_n >= w_bins(k) & w_ed_100_n < w_bins(k+1))));
  peak_dist_ed_100(k) = peak_dist_ed_100(k) + sum(sum(sum( w_ed_100_s >= w_bins(k) & w_ed_100_s < w_bins(k+1))));

  peak_dist_000_ed_vt(k) = peak_dist_000_ed_vt(k) + sum(sum(sum( w_ed_000_n >= w_bins(k) & w_ed_000_n < w_bins(k+1) & squeeze(vt_ed_000n(:,:,4,:) >= vt_thresh_000))));
  peak_dist_000_ed_vt(k) = peak_dist_000_ed_vt(k) + sum(sum(sum( w_ed_000_s >= w_bins(k) & w_ed_000_s < w_bins(k+1) & squeeze(vt_ed_000s(:,:,4,:) >= vt_thresh_000))));
  peak_dist_010_ed_vt(k) = peak_dist_010_ed_vt(k) + sum(sum(sum( w_ed_010_n >= w_bins(k) & w_ed_010_n < w_bins(k+1) & squeeze(vt_ed_010n(:,:,4,:) >= vt_thresh_010))));
  peak_dist_010_ed_vt(k) = peak_dist_010_ed_vt(k) + sum(sum(sum( w_ed_010_s >= w_bins(k) & w_ed_010_s < w_bins(k+1) & squeeze(vt_ed_010s(:,:,4,:) >= vt_thresh_010))));
  peak_dist_025_ed_vt(k) = peak_dist_025_ed_vt(k) + sum(sum(sum( w_ed_025_n >= w_bins(k) & w_ed_025_n < w_bins(k+1) & squeeze(vt_ed_025n(:,:,4,:) >= vt_thresh_025))));
  peak_dist_025_ed_vt(k) = peak_dist_025_ed_vt(k) + sum(sum(sum( w_ed_025_s >= w_bins(k) & w_ed_025_s < w_bins(k+1) & squeeze(vt_ed_025s(:,:,4,:) >= vt_thresh_025))));
  peak_dist_050_ed_vt(k) = peak_dist_050_ed_vt(k) + sum(sum(sum( w_ed_050_n >= w_bins(k) & w_ed_050_n < w_bins(k+1) & squeeze(vt_ed_050n(:,:,4,:) >= vt_thresh_050))));
  peak_dist_050_ed_vt(k) = peak_dist_050_ed_vt(k) + sum(sum(sum( w_ed_050_s >= w_bins(k) & w_ed_050_s < w_bins(k+1) & squeeze(vt_ed_050s(:,:,4,:) >= vt_thresh_050))));
  peak_dist_075_ed_vt(k) = peak_dist_075_ed_vt(k) + sum(sum(sum( w_ed_075_n >= w_bins(k) & w_ed_075_n < w_bins(k+1) & squeeze(vt_ed_075n(:,:,4,:) >= vt_thresh_075))));
  peak_dist_075_ed_vt(k) = peak_dist_075_ed_vt(k) + sum(sum(sum( w_ed_075_s >= w_bins(k) & w_ed_075_s < w_bins(k+1) & squeeze(vt_ed_075s(:,:,4,:) >= vt_thresh_075))));
  peak_dist_100_ed_vt(k) = peak_dist_100_ed_vt(k) + sum(sum(sum( w_ed_100_n >= w_bins(k) & w_ed_100_n < w_bins(k+1) & squeeze(vt_ed_100n(:,:,4,:) >= vt_thresh_100))));
  peak_dist_100_ed_vt(k) = peak_dist_100_ed_vt(k) + sum(sum(sum( w_ed_100_s >= w_bins(k) & w_ed_100_s < w_bins(k+1) & squeeze(vt_ed_100s(:,:,4,:) >= vt_thresh_100))));

  end


figure
plot(w_bins_c, peak_dist_000./sum(peak_dist_000),'r')
xlim([-1 1])
set(gca,'FontSize',15);
hold on
plot(w_bins_c, peak_dist_010./sum(peak_dist_010),'c')
plot(w_bins_c, peak_dist_025./sum(peak_dist_025),'m')
plot(w_bins_c, peak_dist_050./sum(peak_dist_050),'g')
plot(w_bins_c, peak_dist_075./sum(peak_dist_075),'b')
plot(w_bins_c, peak_dist_100./sum(peak_dist_100),'k')
xlabel('w bin, Pa/s','FontSize',15)
ylabel('Probability','FontSize',15)
title('PDF of w values','FontSize',15)
legend('0.0es_{0}','0.1es_{0}','0.25es_{0}','0.5es_{0}','0.75es_{0}','1.0es_{0}')
print('-dpng','wpdf.png')

figure
plot(w_bins_c, peak_dist_000_vt./sum(peak_dist_000_vt),'r')
xlim([-1 1])
set(gca,'FontSize',15);
hold on
plot(w_bins_c, peak_dist_010_vt./sum(peak_dist_010_vt),'c')
plot(w_bins_c, peak_dist_025_vt./sum(peak_dist_025_vt),'m')
plot(w_bins_c, peak_dist_050_vt./sum(peak_dist_050_vt),'g')
plot(w_bins_c, peak_dist_075_vt./sum(peak_dist_075_vt),'b')
plot(w_bins_c, peak_dist_100_vt./sum(peak_dist_100_vt),'k')
xlabel('w bin, Pa/s','FontSize',15)
ylabel('Probability','FontSize',15)
title('PDF of w values','FontSize',15)
legend('0.0es_{0}','0.1es_{0}','0.25es_{0}','0.5es_{0}','0.75es_{0}','1.0es_{0}')
print('-dpng','wvtpdf.png')




figure
plot(w_bins_c, peak_dist_ed_000./sum(peak_dist_ed_000),'r')
xlim([-1 1])
set(gca,'FontSize',15);
hold on
plot(w_bins_c, peak_dist_ed_010./sum(peak_dist_ed_010),'c')
plot(w_bins_c, peak_dist_ed_025./sum(peak_dist_ed_025),'m')
plot(w_bins_c, peak_dist_ed_050./sum(peak_dist_ed_050),'g')
plot(w_bins_c, peak_dist_ed_075./sum(peak_dist_ed_075),'b')
plot(w_bins_c, peak_dist_ed_100./sum(peak_dist_ed_100),'k')
xlabel('w bin, Pa/s','FontSize',15)
ylabel('Probability','FontSize',15)
title('PDF of w values','FontSize',15)
legend('0.0es_{0}','0.1es_{0}','0.25es_{0}','0.5es_{0}','0.75es_{0}','1.0es_{0}')
print('-dpng','wedpdf.png')

figure
plot(w_bins_c, peak_dist_000_ed_vt./sum(peak_dist_000_ed_vt),'r')
xlim([-1 1])
set(gca,'FontSize',15);
hold on
plot(w_bins_c, peak_dist_010_ed_vt./sum(peak_dist_010_ed_vt),'c')
plot(w_bins_c, peak_dist_025_ed_vt./sum(peak_dist_025_ed_vt),'m')
plot(w_bins_c, peak_dist_050_ed_vt./sum(peak_dist_050_ed_vt),'g')
plot(w_bins_c, peak_dist_075_ed_vt./sum(peak_dist_075_ed_vt),'b')
plot(w_bins_c, peak_dist_100_ed_vt./sum(peak_dist_100_ed_vt),'k')
xlabel('w bin, Pa/s','FontSize',15)
ylabel('Probability','FontSize',15)
title('PDF of w values','FontSize',15)
legend('0.0es_{0}','0.1es_{0}','0.25es_{0}','0.5es_{0}','0.75es_{0}','1.0es_{0}')
print('-dpng','wedvtpdf.png')


