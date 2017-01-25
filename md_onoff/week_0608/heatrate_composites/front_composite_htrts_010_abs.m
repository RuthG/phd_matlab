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
htrt_ll_010 = cube2latlon(xc,yc,htrt_010,xi,yi).*86400;
htrt_n = htrt_ll_010(:,x010n-7:x010n+7,:,:);
htrt_s = htrt_ll_010(:,x010s-7:x010s+7,:,:);
clear('htrt_ll_010','htrt_ll_tav_010')
[htrt_comp,check0] = composite_fun_timelag(peaks_010,fd_thresh_010,htrt_n,htrt_s,0,'/project/rg312/mat_files/front_diag_composite_data/htrt_abs_010.mat');
x=-34:2:34;

figure
v=-4:0.2:4;
[C,h] = contourf(x,rC./100,nanmean(htrt_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-4,4));
hold on
[C,h] = contour(x,rC./100,nanmean(htrt_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.1e_{s0}')
print('-dpng','htrt_abs_010.png')
hold off

clear htrt_comp


load('/project/rg312/mat_files/heat_rates_best.mat','radht_010')
radht_ll_010 = cube2latlon(xc,yc,radht_010,xi,yi).*86400;
radht_n = radht_ll_010(:,x010n-7:x010n+7,:,:);
radht_s = radht_ll_010(:,x010s-7:x010s+7,:,:);
clear('radht_ll_010','radht_ll_tav_010')
[radht_comp,check0] = composite_fun_timelag(peaks_010,fd_thresh_010,radht_n,radht_s,0,'/project/rg312/mat_files/front_diag_composite_data/radht_abs_010.mat');

figure
v=-4:0.2:4;
[C,h] = contourf(x,rC./100,nanmean(radht_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-4,4));
hold on
[C,h] = contour(x,rC./100,nanmean(radht_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.1e_{s0}')
print('-dpng','radht_abs_010.png')
hold off

clear radht_comp


load('/project/rg312/mat_files/heat_rates_best.mat','cndht_010')
cndht_ll_010 = cube2latlon(xc,yc,cndht_010,xi,yi).*86400;
cndht_n = cndht_ll_010(:,x010n-7:x010n+7,:,:);
cndht_s = cndht_ll_010(:,x010s-7:x010s+7,:,:);
clear('cndht_ll_010','cndht_ll_tav_010')
[cndht_comp,check0] = composite_fun_timelag(peaks_010,fd_thresh_010,cndht_n,cndht_s,0,'/project/rg312/mat_files/front_diag_composite_data/cndht_abs_010.mat');

figure
v=-4:0.2:4;
[C,h] = contourf(x,rC./100,nanmean(cndht_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-4,4));
hold on
[C,h] = contour(x,rC./100,nanmean(cndht_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.1e_{s0}')
print('-dpng','cndht_abs_010.png')
hold off

clear cndht_comp


load('/project/rg312/mat_files/heat_rates_best.mat','cnvht_010')
cnvht_ll_010 = cube2latlon(xc,yc,cnvht_010,xi,yi).*86400;
cnvht_n = cnvht_ll_010(:,x010n-7:x010n+7,:,:);
cnvht_s = cnvht_ll_010(:,x010s-7:x010s+7,:,:);
clear('cnvht_ll_010','cnvht_ll_tav_010')
[cnvht_comp,check0] = composite_fun_timelag(peaks_010,fd_thresh_010,cnvht_n,cnvht_s,0,'/project/rg312/mat_files/front_diag_composite_data/cnvht_abs_010.mat');

figure
v=-4:0.2:4;
[C,h] = contourf(x,rC./100,nanmean(cnvht_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-4,4));
hold on
[C,h] = contour(x,rC./100,nanmean(cnvht_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.1e_{s0}')
print('-dpng','cnvht_abs_010.png')
hold off

clear cnvht_comp

load('/project/rg312/mat_files/heat_rates_best.mat','difht_010')
difht_ll_010 = cube2latlon(xc,yc,difht_010,xi,yi).*86400;
difht_n = difht_ll_010(:,x010n-7:x010n+7,:,:);
difht_s = difht_ll_010(:,x010s-7:x010s+7,:,:);
clear('difht_ll_010','difht_ll_tav_010')
[difht_comp,check0] = composite_fun_timelag(peaks_010,fd_thresh_010,difht_n,difht_s,0,'/project/rg312/mat_files/front_diag_composite_data/difht_abs_010.mat');

figure
v=-4:0.2:4;
[C,h] = contourf(x,rC./100,nanmean(difht_comp,3)',v,'LineWidth',2);
set(gca,'YDir','reverse'); set(gca,'FontSize',15);
colorbar('FontSize',15)
colormap(b2r(-4,4));
hold on
[C,h] = contour(x,rC./100,nanmean(difht_comp,3)',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('0.1e_{s0}')
print('-dpng','difht_abs_010.png')
hold off

clear difht_comp

