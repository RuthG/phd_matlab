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



load('/project/rg312/mat_files/snapshot_data/w_snapshots_best.mat','w_150')
w_ll_150 = cube2latlon(xc,yc,w_150,xi,yi);
w_ll_tav_150 = repmat(mean(w_ll_150,4),[1 1 1 720]);
w_ed_ll_150 = w_ll_150 - w_ll_tav_150;
w_n = w_ll_150(:,x150n-7:x150n+7,:,:);
w_s = w_ll_150(:,x150s-7:x150s+7,:,:);
w_ed_n = w_ed_ll_150(:,x150n-7:x150n+7,:,:);
w_ed_s = w_ed_ll_150(:,x150s-7:x150s+7,:,:);
clear('w_ll_150','w_ll_tav_150','w_ed_ll_150')
[w_comp,check0] = composite_fun_timelag(peaks_150,fd_thresh_150,w_n,w_s,0,'/project/rg312/mat_files/front_diag_composite_data/w_150_best.mat');
[w_ed_comp,check0] = composite_fun_timelag(peaks_150,fd_thresh_150,w_ed_n,w_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/w_ed_150_best.mat');

x=-34:2:34;
figure
v=-0.3:0.02:0.06;
[C,h] = contourf(x,rC./100,nanmean(w_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.3,0.06));
hold on
[C,h] = contour(x,rC./100,nanmean(w_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('1.5e_{s0}')
print('-dpng','w_150.png')
hold off

clear w_comp

figure
v=-0.3:0.02:0.06;
[C,h] = contourf(x,rC./100,nanmean(w_ed_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-0.3,0.06));
hold on
[C,h] = contour(x,rC./100,nanmean(w_ed_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('1.5e_{s0}')
print('-dpng','w_ed_150.png')
hold off

clear w_ed_comp




load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_150')
t_ll_150 = cube2latlon(xc,yc,t_150,xi,yi);
t_ll_tav_150 = repmat(mean(t_ll_150,4),[1 1 1 720]);
t_ed_ll_150 = t_ll_150 - t_ll_tav_150;
t_n = t_ll_150(:,x150n-7:x150n+7,:,:);
t_s = t_ll_150(:,x150s-7:x150s+7,:,:);
t_ed_n = t_ed_ll_150(:,x150n-7:x150n+7,:,:);
t_ed_s = t_ed_ll_150(:,x150s-7:x150s+7,:,:);
clear('t_ll_150','t_ll_tav_150')
[t_comp,check0] = composite_fun_timelag(peaks_150,fd_thresh_150,t_n,t_s,0,'/project/rg312/mat_files/front_diag_composite_data/t_150_best.mat');
[t_ed_comp,check0] = composite_fun_timelag(peaks_150,fd_thresh_150,t_ed_n,t_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/t_ed_150_best.mat');

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
title('1.5e_{s0}')
print('-dpng','t_150.png')
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
title('1.5e_{s0}')
print('-dpng','t_ed_150.png')
hold off

clear t_ed_comp



load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_150')
vN_ll_150 = cube2latlon(xc,yc,vN_150,xi,yi);
vN_ll_tav_150 = repmat(mean(vN_ll_150,4),[1 1 1 720]);
vN_ed_ll_150 = vN_ll_150 - vN_ll_tav_150;
vNt_ed_ll_150 = vN_ed_ll_150.*t_ed_ll_150;
vN_n = vN_ll_150(:,x150n-7:x150n+7,:,:);
vN_s = -1.*vN_ll_150(:,x150s-7:x150s+7,:,:);
vN_ed_n = vN_ed_ll_150(:,x150n-7:x150n+7,:,:);
vN_ed_s = -1.*vN_ed_ll_150(:,x150s-7:x150s+7,:,:);
vNt_ed_n = vNt_ed_ll_150(:,x150n-7:x150n+7,:,:);
vNt_ed_s = -1.*vNt_ed_ll_150(:,x150s-7:x150s+7,:,:);
clear('vN_ll_150','vN_ll_tav_150','vN_ed_ll_150','t_ed_ll_150')
[vN_comp,check0] = composite_fun_timelag(peaks_150,fd_thresh_150,vN_n,vN_s,0,'/project/rg312/mat_files/front_diag_composite_data/vN_150_best.mat');
[vN_ed_comp,check0] = composite_fun_timelag(peaks_150,fd_thresh_150,vN_ed_n,vN_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/vN_ed_150_best.mat');
[vNt_ed_comp,check0] = composite_fun_timelag(peaks_150,fd_thresh_150,vNt_ed_n,vNt_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/vNt_ed_150_best.mat');

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
title('1.5e_{s0}')
print('-dpng','vN_150.png')
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
title('1.5e_{s0}')
print('-dpng','vN_ed_150.png')
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
title('1.5e_{s0}')
print('-dpng','vNt_ed_150.png')
hold off

clear vNt_ed_comp




load('/project/rg312/mat_files/snapshot_data/q_snapshots_best.mat','q_150')
q_ll_150 = cube2latlon(xc,yc,q_150,xi,yi);
q_ll_tav_150 = repmat(mean(q_ll_150,4),[1 1 1 720]);
q_ed_ll_150 = q_ll_150 - q_ll_tav_150;
q_n = q_ll_150(:,x150n-7:x150n+7,:,:);
q_s = q_ll_150(:,x150s-7:x150s+7,:,:);
q_ed_n = q_ed_ll_150(:,x150n-7:x150n+7,:,:);
q_ed_s = q_ed_ll_150(:,x150s-7:x150s+7,:,:);
clear('q_ll_150','q_ll_tav_150','q_ed_ll_150')
[q_comp,check0] = composite_fun_timelag(peaks_150,fd_thresh_150,q_n,q_s,0,'/project/rg312/mat_files/front_diag_composite_data/q_150_best.mat');
[q_ed_comp,check0] = composite_fun_timelag(peaks_150,fd_thresh_150,q_ed_n,q_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/q_ed_150_best.mat');

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
title('1.5e_{s0}')
print('-dpng','q_150.png')
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
title('1.5e_{s0}')
print('-dpng','q_ed_150.png')
hold off

clear q_ed_comp



load('/project/rg312/mat_files/snapshot_data/uE_snapshots_best.mat','uE_150')
uE_ll_150 = cube2latlon(xc,yc,uE_150,xi,yi);
uE_ll_tav_150 = repmat(mean(uE_ll_150,4),[1 1 1 720]);
uE_ed_ll_150 = uE_ll_150 - uE_ll_tav_150;
uE_n = uE_ll_150(:,x150n-7:x150n+7,:,:);
uE_s = uE_ll_150(:,x150s-7:x150s+7,:,:);
uE_ed_n = uE_ed_ll_150(:,x150n-7:x150n+7,:,:);
uE_ed_s = uE_ed_ll_150(:,x150s-7:x150s+7,:,:);
clear('uE_ll_150','uE_ll_tav_150','uE_ed_ll_150')
[uE_comp,check0] = composite_fun_timelag(peaks_150,fd_thresh_150,uE_n,uE_s,0,'/project/rg312/mat_files/front_diag_composite_data/uE_150_best.mat');
[uE_ed_comp,check0] = composite_fun_timelag(peaks_150,fd_thresh_150,uE_ed_n,uE_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/uE_ed_150_best.mat');

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
title('1.5e_{s0}')
print('-dpng','uE_150.png')
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
title('1.5e_{s0}')
print('-dpng','uE_ed_150.png')
hold off

clear uE_ed_comp




load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat','theta_150')
theta_ll_150 = cube2latlon(xc,yc,theta_150,xi,yi);
theta_ll_tav_150 = repmat(mean(theta_ll_150,4),[1 1 1 720]);
theta_ed_ll_150 = theta_ll_150 - theta_ll_tav_150;
theta_n = theta_ll_150(:,x150n-7:x150n+7,:,:);
theta_s = theta_ll_150(:,x150s-7:x150s+7,:,:);
theta_ed_n = theta_ed_ll_150(:,x150n-7:x150n+7,:,:);
theta_ed_s = theta_ed_ll_150(:,x150s-7:x150s+7,:,:);
clear('theta_ll_150','theta_ll_tav_150','theta_ed_ll_150')
[theta_comp,check0] = composite_fun_timelag(peaks_150,fd_thresh_150,theta_n,theta_s,0,'/project/rg312/mat_files/front_diag_composite_data/theta_150_best.mat');
[theta_ed_comp,check0] = composite_fun_timelag(peaks_150,fd_thresh_150,theta_ed_n,theta_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/theta_ed_150_best.mat');

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
title('1.5e_{s0}')
print('-dpng','theta_150.png')
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
title('1.5e_{s0}')
print('-dpng','theta_ed_150.png')
hold off

clear theta_ed_comp


