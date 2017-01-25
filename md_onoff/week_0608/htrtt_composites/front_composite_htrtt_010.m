%load arnaud diag and v't' for 010 run and start thinking about how to handle composite

rDir='/project/rg312/wv_on_rad_off/run_010_best/';
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
load('/project/rg312/mat_files/front_diag_full_010_best.mat')

front_diag_strack(:,:,1:720) = arnaud_diag_010(:,x010n-7:x010n+7,:);
front_diag_strack(:,:,721:1440) = arnaud_diag_010(:,x010s-7:x010s+7,:);

front_diag_thresh = reshape(front_diag_strack,[numel(front_diag_strack),1]);

[fd_dist,fd_val] = hist(front_diag_thresh,100);
fd_sum = cumsum(fd_dist)./sum(fd_dist);
fd_thresh_010 = fd_val(min(find(fd_sum>=0.95)));

for i=1:15
  for j=1:720
  %locate peaks in front diag

  [a_010n,b_010n] = findpeak_prom(arnaud_diag_010(:,x010n-8+i,j),fd_thresh_010./2);
  [a_010s,b_010s] = findpeak_prom(arnaud_diag_010(:,x010s-8+i,j),fd_thresh_010./2);

  %save peak magnitudes and locations in a cell array
  peaks_010{i,j,1} = a_010n;
  peaks_010{i,j,2} = b_010n;
  peaks_010{i,j,3} = a_010s;
  peaks_010{i,j,4} = b_010s;
  end
end



load('/project/rg312/mat_files/heat_rates_best.mat','htrt_010')
htrt_ll_010 = cube2latlon(xc,yc,htrt_010,xi,yi);
htrt_ll_tav_010 = repmat(mean(htrt_ll_010,4),[1 1 1 720]);
htrt_ed_ll_010 = htrt_ll_010 - htrt_ll_tav_010;
htrt_ed_n = htrt_ed_ll_010(:,x010n-7:x010n+7,:,:);
htrt_ed_s = htrt_ed_ll_010(:,x010s-7:x010s+7,:,:);
clear('htrt_ll_010','htrt_ll_tav_010','htrt_ed_ll_010')

load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat','theta_010')
theta_ll_010 = cube2latlon(xc,yc,theta_010,xi,yi);
theta_ll_tav_010 = repmat(mean(theta_ll_010,4),[1 1 1 720]);
theta_ed_ll_010 = theta_ll_010 - theta_ll_tav_010;
theta_ed_n = theta_ed_ll_010(:,x010n-7:x010n+7,:,:);
theta_ed_s = theta_ed_ll_010(:,x010s-7:x010s+7,:,:);
clear('theta_ll_010','theta_ll_tav_010','theta_ed_ll_010')

htrtt_ed_n = htrt_ed_n.*theta_ed_n;
htrtt_ed_s = htrt_ed_s.*theta_ed_s;


[htrtt_comp,check0] = composite_fun_timelag(peaks_010,fd_thresh_010,htrtt_ed_n,htrtt_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/htrtt_010.mat');
x=-34:2:34;

figure
v=-1e-4:1e-5:2e-4;
[C,h] = contourf(x,rC./100,nanmean(htrtt_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-1e-4,2e-4));
hold on
[C,h] = contour(x,rC./100,nanmean(htrtt_comp,3)',[-1010:1010:1010],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.1e_{s0}')
print('-dpng','htrtt_010.png')
hold off

%clear htrtt_comp


