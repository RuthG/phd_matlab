%load arnaud diag and v't' for 075 run and start thinking about how to handle composite

rDir='/project/rg312/wv_on_rad_off/run_075_best/';
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
xi = -179:2:179;

load('/project/rg312/mat_files/vt_lats_best.mat')
load('/project/rg312/mat_files/front_diag_full_075_best.mat')

front_diag_strack(:,:,1:720) = arnaud_diag_075(:,x075n-7:x075n+7,:);
front_diag_strack(:,:,721:1440) = arnaud_diag_075(:,x075s-7:x075s+7,:);

front_diag_thresh = reshape(front_diag_strack,[numel(front_diag_strack),1]);

[fd_dist,fd_val] = hist(front_diag_thresh,100);
fd_sum = cumsum(fd_dist)./sum(fd_dist);
fd_thresh_075 = fd_val(min(find(fd_sum>=0.95)));

for i=1:15
  for j=1:720
  %locate peaks in front diag

  [a_075n,b_075n] = findpeak_prom(arnaud_diag_075(:,x075n-8+i,j),fd_thresh_075./2);
  [a_075s,b_075s] = findpeak_prom(arnaud_diag_075(:,x075s-8+i,j),fd_thresh_075./2);

  %save peak magnitudes and locations in a cell array
  peaks_075{i,j,1} = a_075n;
  peaks_075{i,j,2} = b_075n;
  peaks_075{i,j,3} = a_075s;
  peaks_075{i,j,4} = b_075s;
  end
end



load('/project/rg312/mat_files/heat_rates_best.mat','htrt_075')
htrt_ll_075 = cube2latlon(xc,yc,htrt_075,xi,yi);
htrt_ll_tav_075 = repmat(mean(htrt_ll_075,4),[1 1 1 720]);
htrt_ed_ll_075 = htrt_ll_075 - htrt_ll_tav_075;
htrt_ed_n = htrt_ed_ll_075(:,x075n-7:x075n+7,:,:);
htrt_ed_s = htrt_ed_ll_075(:,x075s-7:x075s+7,:,:);
clear('htrt_ll_075','htrt_ll_tav_075','htrt_ed_ll_075')

load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat','theta_075')
theta_ll_075 = cube2latlon(xc,yc,theta_075,xi,yi);
theta_ll_tav_075 = repmat(mean(theta_ll_075,4),[1 1 1 720]);
theta_ed_ll_075 = theta_ll_075 - theta_ll_tav_075;
theta_ed_n = theta_ed_ll_075(:,x075n-7:x075n+7,:,:);
theta_ed_s = theta_ed_ll_075(:,x075s-7:x075s+7,:,:);
clear('theta_ll_075','theta_ll_tav_075','theta_ed_ll_075')

htrtt_ed_n = htrt_ed_n.*theta_ed_n;
htrtt_ed_s = htrt_ed_s.*theta_ed_s;


[htrtt_comp,check0] = composite_fun_timelag(peaks_075,fd_thresh_075,htrtt_ed_n,htrtt_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/htrtt_075.mat');
x=-34:2:34;

figure
v=-1e-4:1e-5:2e-4;
[C,h] = contourf(x,rC./100,nanmean(htrtt_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-1e-4,2e-4));
hold on
[C,h] = contour(x,rC./100,nanmean(htrtt_comp,3)',[-1075:1075:1075],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.75e_{s0}')
print('-dpng','htrtt_075.png')
hold off

%clear htrtt_comp


