%load arnaud diag and v't' for 000 run and start thinking about how to handle composite

rDir='/project/rg312/wv_on_rad_off/run_100_best/';
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
load('/project/rg312/mat_files/front_diag_full_100_best.mat')

front_diag_strack(:,:,1:720) = arnaud_diag_100(:,x100n-7:x100n+7,:);
front_diag_strack(:,:,721:1440) = arnaud_diag_100(:,x100s-7:x100s+7,:);

front_diag_thresh = reshape(front_diag_strack,[numel(front_diag_strack),1]);

[fd_dist,fd_val] = hist(front_diag_thresh,100);
fd_sum = cumsum(fd_dist)./sum(fd_dist);
fd_thresh_100 = fd_val(min(find(fd_sum>=0.95)));

for i=1:15
  for j=1:720
  %locate peaks in front diag

  [a_100n,b_100n] = findpeak_prom(arnaud_diag_100(:,x100n-8+i,j),fd_thresh_100./2);
  [a_100s,b_100s] = findpeak_prom(arnaud_diag_100(:,x100s-8+i,j),fd_thresh_100./2);

  %save peak magnitudes and locations in a cell array
  peaks_100{i,j,1} = a_100n;
  peaks_100{i,j,2} = b_100n;
  peaks_100{i,j,3} = a_100s;
  peaks_100{i,j,4} = b_100s;
  end
end


load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat','theta_100')

theta_ll_100 = cube2latlon(xc,yc,theta_100,xi,yi);
dthetadp_ll_100 = shiftdim(gradient(shiftdim(theta_ll_100,1),-4000),3);

dthetadp_ll_tav_100 = repmat(mean(dthetadp_ll_100,4),[1 1 1 720]);

dthetadp_n = dthetadp_ll_100(:,x100n-7:x100n+7,:,:);
dthetadp_s = dthetadp_ll_100(:,x100s-7:x100s+7,:,:);

clear('theta_ll_100','dthetadp_ll_100','dthetadp_ll_tav_100')
[dthetadp_comp,check0] = composite_fun_timelag(peaks_100,fd_thresh_100,dthetadp_n,dthetadp_s,0,'/project/rg312/mat_files/front_diag_composite_data/dthetadp_100_best.mat');



x=-34:2:34;
figure
v=-0.005:0.0001:0;
[C,h] = contourf(x,rC./100,nanmean(dthetadp_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([-0.005 0])
hold on
[C,h] = contour(x,rC./100,nanmean(dthetadp_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('1.0e_{s0}')
print('-dpng','dthetadp_100.png')
hold off

clear dthetadp_comp



load('/project/rg312/mat_files/snapshot_data/mtheta_snapshots_best.mat','moisttheta_100')

moisttheta_ll_100 = cube2latlon(xc,yc,moisttheta_100,xi,yi);
dmoistthetadp_ll_100 = shiftdim(gradient(shiftdim(moisttheta_ll_100,1),-4000),3);

dmoistthetadp_ll_tav_100 = repmat(mean(dmoistthetadp_ll_100,4),[1 1 1 720]);

dmoistthetadp_n = dmoistthetadp_ll_100(:,x100n-7:x100n+7,:,:);
dmoistthetadp_s = dmoistthetadp_ll_100(:,x100s-7:x100s+7,:,:);

clear('moisttheta_ll_100','dmoistthetadp_ll_100','dmoistthetadp_ll_tav_100')
[dmoistthetadp_comp,check0] = composite_fun_timelag(peaks_100,fd_thresh_100,dmoistthetadp_n,dmoistthetadp_s,0,'/project/rg312/mat_files/front_diag_composite_data/dmoistthetadp_100_best.mat');



x=-34:2:34;
figure
v=-0.005:0.0001:0;
[C,h] = contourf(x,rC./100,nanmean(dmoistthetadp_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([-0.005 0])
hold on
[C,h] = contour(x,rC./100,nanmean(dmoistthetadp_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('1.0e_{s0}')
print('-dpng','dmoistthetadp_100.png')
hold off

%clear dmoistthetadp_comp

