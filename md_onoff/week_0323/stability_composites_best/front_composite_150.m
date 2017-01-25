%load arnaud diag and v't' for 000 run and start thinking about how to handle composite

rDir='/project/rg312/wv_on_rad_off/run_150_best/';
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
load('/project/rg312/mat_files/front_diag_full_150_best.mat')

front_diag_strack(:,:,1:720) = arnaud_diag_150(:,x150n-7:x150n+7,:);
front_diag_strack(:,:,721:1440) = arnaud_diag_150(:,x150s-7:x150s+7,:);

front_diag_thresh = reshape(front_diag_strack,[numel(front_diag_strack),1]);

[fd_dist,fd_val] = hist(front_diag_thresh,100);
fd_sum = cumsum(fd_dist)./sum(fd_dist);
fd_thresh_150 = fd_val(min(find(fd_sum>=0.95)));

for i=1:15
  for j=1:720
  %locate peaks in front diag

  [a_150n,b_150n] = findpeak_prom(arnaud_diag_150(:,x150n-8+i,j),fd_thresh_150./2);
  [a_150s,b_150s] = findpeak_prom(arnaud_diag_150(:,x150s-8+i,j),fd_thresh_150./2);

  %save peak magnitudes and locations in a cell array
  peaks_150{i,j,1} = a_150n;
  peaks_150{i,j,2} = b_150n;
  peaks_150{i,j,3} = a_150s;
  peaks_150{i,j,4} = b_150s;
  end
end


load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat','theta_150')

theta_ll_150 = cube2latlon(xc,yc,theta_150,xi,yi);
dthetadp_ll_150 = shiftdim(gradient(shiftdim(theta_ll_150,1),-4000),3);

dthetadp_ll_tav_150 = repmat(mean(dthetadp_ll_150,4),[1 1 1 720]);

dthetadp_n = dthetadp_ll_150(:,x150n-7:x150n+7,:,:);
dthetadp_s = dthetadp_ll_150(:,x150s-7:x150s+7,:,:);

clear('theta_ll_150','dthetadp_ll_150','dthetadp_ll_tav_150')
[dthetadp_comp,check0] = composite_fun_timelag(peaks_150,fd_thresh_150,dthetadp_n,dthetadp_s,0,'/project/rg312/mat_files/front_diag_composite_data/dthetadp_150_best.mat');



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
title('1.5e_{s0}')
print('-dpng','dthetadp_150.png')
hold off

clear dthetadp_comp



load('/project/rg312/mat_files/snapshot_data/mtheta_snapshots_best.mat','moisttheta_150')

moisttheta_ll_150 = cube2latlon(xc,yc,moisttheta_150,xi,yi);
dmoistthetadp_ll_150 = shiftdim(gradient(shiftdim(moisttheta_ll_150,1),-4000),3);

dmoistthetadp_ll_tav_150 = repmat(mean(dmoistthetadp_ll_150,4),[1 1 1 720]);

dmoistthetadp_n = dmoistthetadp_ll_150(:,x150n-7:x150n+7,:,:);
dmoistthetadp_s = dmoistthetadp_ll_150(:,x150s-7:x150s+7,:,:);

clear('moisttheta_ll_150','dmoistthetadp_ll_150','dmoistthetadp_ll_tav_150')
[dmoistthetadp_comp,check0] = composite_fun_timelag(peaks_150,fd_thresh_150,dmoistthetadp_n,dmoistthetadp_s,0,'/project/rg312/mat_files/front_diag_composite_data/dmoistthetadp_150_best.mat');



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
title('1.5e_{s0}')
print('-dpng','dmoistthetadp_150.png')
hold off

%clear dmoistthetadp_comp

