%load arnaud diag and v't' for 000 run and start thinking about how to handle composite

rDir='/project/rg312/wv_on_rad_off/run_025_best/';
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
load('/project/rg312/mat_files/front_diag_full_025_best.mat')

front_diag_strack(:,:,1:720) = arnaud_diag_025(:,x025n-7:x025n+7,:);
front_diag_strack(:,:,721:1440) = arnaud_diag_025(:,x025s-7:x025s+7,:);

front_diag_thresh = reshape(front_diag_strack,[numel(front_diag_strack),1]);

[fd_dist,fd_val] = hist(front_diag_thresh,100);
fd_sum = cumsum(fd_dist)./sum(fd_dist);
fd_thresh_025 = fd_val(min(find(fd_sum>=0.95)));

for i=1:15
  for j=1:720
  %locate peaks in front diag

  [a_025n,b_025n] = findpeak_prom(arnaud_diag_025(:,x025n-8+i,j),fd_thresh_025./2);
  [a_025s,b_025s] = findpeak_prom(arnaud_diag_025(:,x025s-8+i,j),fd_thresh_025./2);

  %save peak magnitudes and locations in a cell array
  peaks_025{i,j,1} = a_025n;
  peaks_025{i,j,2} = b_025n;
  peaks_025{i,j,3} = a_025s;
  peaks_025{i,j,4} = b_025s;
  end
end


load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat','theta_025')

theta_ll_025 = cube2latlon(xc,yc,theta_025,xi,yi);
dthetadp_ll_025 = shiftdim(gradient(shiftdim(theta_ll_025,1),-4000),3);

dthetadp_ll_tav_025 = repmat(mean(dthetadp_ll_025,4),[1 1 1 720]);

dthetadp_n = dthetadp_ll_025(:,x025n-7:x025n+7,:,:);
dthetadp_s = dthetadp_ll_025(:,x025s-7:x025s+7,:,:);

clear('theta_ll_025','dthetadp_ll_025','dthetadp_ll_tav_025')
[dthetadp_comp,check0] = composite_fun_timelag(peaks_025,fd_thresh_025,dthetadp_n,dthetadp_s,0,'/project/rg312/mat_files/front_diag_composite_data/dthetadp_025_best.mat');



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
title('0.25e_{s0}')
print('-dpng','dthetadp_025.png')
hold off

clear dthetadp_comp



load('/project/rg312/mat_files/snapshot_data/mtheta_snapshots_best.mat','moisttheta_025')

moisttheta_ll_025 = cube2latlon(xc,yc,moisttheta_025,xi,yi);
dmoistthetadp_ll_025 = shiftdim(gradient(shiftdim(moisttheta_ll_025,1),-4000),3);

dmoistthetadp_ll_tav_025 = repmat(mean(dmoistthetadp_ll_025,4),[1 1 1 720]);

dmoistthetadp_n = dmoistthetadp_ll_025(:,x025n-7:x025n+7,:,:);
dmoistthetadp_s = dmoistthetadp_ll_025(:,x025s-7:x025s+7,:,:);

clear('moisttheta_ll_025','dmoistthetadp_ll_025','dmoistthetadp_ll_tav_025')
[dmoistthetadp_comp,check0] = composite_fun_timelag(peaks_025,fd_thresh_025,dmoistthetadp_n,dmoistthetadp_s,0,'/project/rg312/mat_files/front_diag_composite_data/dmoistthetadp_025_best.mat');



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
title('0.25e_{s0}')
print('-dpng','dmoistthetadp_025.png')
hold off

%clear dmoistthetadp_comp

