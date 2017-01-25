%load arnaud diag and v't' for 000 run and start thinking about how to handle composite

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



load('/project/rg312/mat_files/snapshot_data/w_snapshots_best.mat','w_025')
w_ll_025 = cube2latlon(xc,yc,w_025,xi,yi);
w_ll_tav_025 = repmat(mean(w_ll_025,4),[1 1 1 720]);
w_ed_ll_025 = w_ll_025 - w_ll_tav_025;
w_n = w_ll_025(:,x025n-7:x025n+7,:,:);
w_s = w_ll_025(:,x025s-7:x025s+7,:,:);
w_ed_n = w_ed_ll_025(:,x025n-7:x025n+7,:,:);
w_ed_s = w_ed_ll_025(:,x025s-7:x025s+7,:,:);
clear('w_ll_025','w_ll_tav_025','w_ed_ll_025')
[w_comp,check0] = composite_fun_timelag(peaks_025,fd_thresh_025,w_n,w_s,0,'/project/rg312/mat_files/front_diag_composite_data/w_025_best.mat');
[w_ed_comp,check0] = composite_fun_timelag(peaks_025,fd_thresh_025,w_ed_n,w_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/w_ed_025_best.mat');

x=-34:2:34;
figure
v=-0.3:0.02:0.08;
[C,h] = contourf(x,rC./100,nanmean(w_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.3,0.08));
hold on
[C,h] = contour(x,rC./100,nanmean(w_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.25e_{s0}')
print('-dpng','w_025.png')
hold off

clear w_comp

figure
v=-0.3:0.02:0.08;
[C,h] = contourf(x,rC./100,nanmean(w_ed_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.3,0.08));
hold on
[C,h] = contour(x,rC./100,nanmean(w_ed_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.25e_{s0}')
print('-dpng','w_ed_025.png')
hold off

clear w_ed_comp




load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_025')
t_ll_025 = cube2latlon(xc,yc,t_025,xi,yi);
t_ll_tav_025 = repmat(mean(t_ll_025,4),[1 1 1 720]);
t_ed_ll_025 = t_ll_025 - t_ll_tav_025;
t_n = t_ll_025(:,x025n-7:x025n+7,:,:);
t_s = t_ll_025(:,x025s-7:x025s+7,:,:);
t_ed_n = t_ed_ll_025(:,x025n-7:x025n+7,:,:);
t_ed_s = t_ed_ll_025(:,x025s-7:x025s+7,:,:);
clear('t_ll_025','t_ll_tav_025')
[t_comp,check0] = composite_fun_timelag(peaks_025,fd_thresh_025,t_n,t_s,0,'/project/rg312/mat_files/front_diag_composite_data/t_025_best.mat');
[t_ed_comp,check0] = composite_fun_timelag(peaks_025,fd_thresh_025,t_ed_n,t_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/t_ed_025_best.mat');

x=-34:2:34;
figure
v=200:10:280;
[C,h] = contourf(x,rC./100,nanmean(t_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([200 280])
hold on
[C,h] = contour(x,rC./100,nanmean(t_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.25e_{s0}')
print('-dpng','t_025.png')
hold off

clear t_comp

figure
v=-5:1:5;
[C,h] = contourf(x,rC./100,nanmean(t_ed_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-5,5));
hold on
[C,h] = contour(x,rC./100,nanmean(t_ed_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.25e_{s0}')
print('-dpng','t_ed_025.png')
hold off

clear t_ed_comp



load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_025')
vN_ll_025 = cube2latlon(xc,yc,vN_025,xi,yi);
vN_ll_tav_025 = repmat(mean(vN_ll_025,4),[1 1 1 720]);
vN_ed_ll_025 = vN_ll_025 - vN_ll_tav_025;
vNt_ed_ll_025 = vN_ed_ll_025.*t_ed_ll_025;
vN_n = vN_ll_025(:,x025n-7:x025n+7,:,:);
vN_s = -1.*vN_ll_025(:,x025s-7:x025s+7,:,:);
vN_ed_n = vN_ed_ll_025(:,x025n-7:x025n+7,:,:);
vN_ed_s = -1.*vN_ed_ll_025(:,x025s-7:x025s+7,:,:);
vNt_ed_n = vNt_ed_ll_025(:,x025n-7:x025n+7,:,:);
vNt_ed_s = -1.*vNt_ed_ll_025(:,x025s-7:x025s+7,:,:);
clear('vN_ll_025','vN_ll_tav_025','vN_ed_ll_025','t_ed_ll_025')
[vN_comp,check0] = composite_fun_timelag(peaks_025,fd_thresh_025,vN_n,vN_s,0,'/project/rg312/mat_files/front_diag_composite_data/vN_025_best.mat');
[vN_ed_comp,check0] = composite_fun_timelag(peaks_025,fd_thresh_025,vN_ed_n,vN_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/vN_ed_025_best.mat');
[vNt_ed_comp,check0] = composite_fun_timelag(peaks_025,fd_thresh_025,vNt_ed_n,vNt_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/vNt_ed_025_best.mat');

x=-34:2:34;
figure
v=-16:2:16;
[C,h] = contourf(x,rC./100,nanmean(vN_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-16,16));
hold on
[C,h] = contour(x,rC./100,nanmean(vN_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.25e_{s0}')
print('-dpng','vN_025.png')
hold off

clear vN_comp

figure
v=-16:2:16;
[C,h] = contourf(x,rC./100,nanmean(vN_ed_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-16,16));
hold on
[C,h] = contour(x,rC./100,nanmean(vN_ed_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.25e_{s0}')
print('-dpng','vN_ed_025.png')
hold off

clear vN_ed_comp

figure
v=-20:5:50;
[C,h] = contourf(x,rC./100,nanmean(vNt_ed_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-20,50));
hold on
[C,h] = contour(x,rC./100,nanmean(vNt_ed_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.25e_{s0}')
print('-dpng','vNt_ed_025.png')
hold off

clear vNt_ed_comp




load('/project/rg312/mat_files/snapshot_data/q_snapshots_best.mat','q_025')
q_ll_025 = cube2latlon(xc,yc,q_025,xi,yi);
q_ll_tav_025 = repmat(mean(q_ll_025,4),[1 1 1 720]);
q_ed_ll_025 = q_ll_025 - q_ll_tav_025;
q_n = q_ll_025(:,x025n-7:x025n+7,:,:);
q_s = q_ll_025(:,x025s-7:x025s+7,:,:);
q_ed_n = q_ed_ll_025(:,x025n-7:x025n+7,:,:);
q_ed_s = q_ed_ll_025(:,x025s-7:x025s+7,:,:);
clear('q_ll_025','q_ll_tav_025','q_ed_ll_025')
[q_comp,check0] = composite_fun_timelag(peaks_025,fd_thresh_025,q_n,q_s,0,'/project/rg312/mat_files/front_diag_composite_data/q_025_best.mat');
[q_ed_comp,check0] = composite_fun_timelag(peaks_025,fd_thresh_025,q_ed_n,q_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/q_ed_025_best.mat');

x=-34:2:34;
figure
v=0:0.0005:0.007;
[C,h] = contourf(x,rC./100,nanmean(q_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([0 0.007]);
hold on
[C,h] = contour(x,rC./100,nanmean(q_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.25e_{s0}')
print('-dpng','q_025.png')
hold off

clear q_comp

figure
v=-0.001:0.0005:0.01;
[C,h] = contourf(x,rC./100,nanmean(q_ed_comp,3)','LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.001,0.01));
hold on
[C,h] = contour(x,rC./100,nanmean(q_ed_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.25e_{s0}')
print('-dpng','q_ed_025.png')
hold off

clear q_ed_comp



load('/project/rg312/mat_files/snapshot_data/uE_snapshots_best.mat','uE_025')
uE_ll_025 = cube2latlon(xc,yc,uE_025,xi,yi);
uE_ll_tav_025 = repmat(mean(uE_ll_025,4),[1 1 1 720]);
uE_ed_ll_025 = uE_ll_025 - uE_ll_tav_025;
uE_n = uE_ll_025(:,x025n-7:x025n+7,:,:);
uE_s = uE_ll_025(:,x025s-7:x025s+7,:,:);
uE_ed_n = uE_ed_ll_025(:,x025n-7:x025n+7,:,:);
uE_ed_s = uE_ed_ll_025(:,x025s-7:x025s+7,:,:);
clear('uE_ll_025','uE_ll_tav_025','uE_ed_ll_025')
[uE_comp,check0] = composite_fun_timelag(peaks_025,fd_thresh_025,uE_n,uE_s,0,'/project/rg312/mat_files/front_diag_composite_data/uE_025_best.mat');
[uE_ed_comp,check0] = composite_fun_timelag(peaks_025,fd_thresh_025,uE_ed_n,uE_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/uE_ed_025_best.mat');

x=-34:2:34;
figure
v=-5:5:30;
[C,h] = contourf(x,rC./100,nanmean(uE_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([-5 30])
hold on
[C,h] = contour(x,rC./100,nanmean(uE_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.25e_{s0}')
print('-dpng','uE_025.png')
hold off

clear uE_comp

figure
v=-6:0.5:6;
[C,h] = contourf(x,rC./100,nanmean(uE_ed_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-6,6));
hold on
[C,h] = contour(x,rC./100,nanmean(uE_ed_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.25e_{s0}')
print('-dpng','uE_ed_025.png')
hold off

clear uE_ed_comp



load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat','theta_025')
theta_ll_025 = cube2latlon(xc,yc,theta_025,xi,yi);
theta_ll_tav_025 = repmat(mean(theta_ll_025,4),[1 1 1 720]);
theta_ed_ll_025 = theta_ll_025 - theta_ll_tav_025;
theta_n = theta_ll_025(:,x025n-7:x025n+7,:,:);
theta_s = theta_ll_025(:,x025s-7:x025s+7,:,:);
theta_ed_n = theta_ed_ll_025(:,x025n-7:x025n+7,:,:);
theta_ed_s = theta_ed_ll_025(:,x025s-7:x025s+7,:,:);
clear('theta_ll_025','theta_ll_tav_025','theta_ed_ll_025')
[theta_comp,check0] = composite_fun_timelag(peaks_025,fd_thresh_025,theta_n,theta_s,0,'/project/rg312/mat_files/front_diag_composite_data/theta_025_best.mat');
[theta_ed_comp,check0] = composite_fun_timelag(peaks_025,fd_thresh_025,theta_ed_n,theta_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/theta_ed_025_best.mat');

x=-34:2:34;
figure
v=270:30:700;
[C,h] = contourf(x,rC./100,nanmean(theta_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
caxis([270 700])
hold on
[C,h] = contour(x,rC./100,nanmean(theta_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.25e_{s0}')
print('-dpng','theta_025.png')
hold off

clear theta_comp

figure
v=-7:1:7;
[C,h] = contourf(x,rC./100,nanmean(theta_ed_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-7,7));
hold on
[C,h] = contour(x,rC./100,nanmean(theta_ed_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.25e_{s0}')
print('-dpng','theta_ed_025.png')
hold off

clear theta_ed_comp




