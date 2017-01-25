%load arnaud diag and htrts for 010 run and start thinking about how to handle composite

rDir='/project/rg312/final_runs/run_010_final/';
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

for year=1:10
year

load('/project/rg312/mat_files/vt_lats_final.mat')
load('/project/rg312/mat_files/front_diag_full_010_best.mat')
load(['/project/rg312/mat_files/snapshot_data_final/run_010/arnaud_diag_010_' num2str(year) '.mat'])

front_diag_strack(:,:,1:360) = arnaud_diag_010(:,x010n-7:x010n+7,:);
front_diag_strack(:,:,361:720) = arnaud_diag_010(:,x010s-7:x010s+7,:);

front_diag_thresh = reshape(front_diag_strack,[numel(front_diag_strack),1]);

[fd_dist,fd_val] = hist(front_diag_thresh,100);
fd_sum = cumsum(fd_dist)./sum(fd_dist);
fd_thresh_010 = fd_val(min(find(fd_sum>=0.95)));

for i=1:15
  for j=1:360
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

load(['/project/rg312/mat_files/snapshot_data_final/run_010/htrt_010_' num2str(year) '.mat'],'htrt_010')
htrt_ll_010 = cube2latlon(xc,yc,htrt_010,xi,yi).*86400;
htrt_n = htrt_ll_010(:,x010n-7:x010n+7,:,:);
htrt_s = htrt_ll_010(:,x010s-7:x010s+7,:,:);
clear('htrt_ll_010')
[htrt_comp,check0] = composite_fun_timelag(peaks_010,fd_thresh_010,htrt_n,htrt_s,0,['/project/rg312/mat_files/storm_chapter_data/run_010/htrt_010_comp_' num2str(year) '.mat']);
x=-34:2:34;

end


return

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
title('1.0e_{s0}')
print('-dpng',['htrt_100_' num2str(year) '.png'])
hold off

clear htrt_comp




return

load('/project/rg312/mat_files/heat_rates_best.mat','radht_100')
radht_ll_100 = cube2latlon(xc,yc,radht_100,xi,yi).*86400;
radht_ll_tav_100 = repmat(mean(radht_ll_100,4),[1 1 1 720]);
radht_ed_ll_100 = radht_ll_100 - radht_ll_tav_100;
radht_ed_n = radht_ed_ll_100(:,x100n-7:x100n+7,:,:);
radht_ed_s = radht_ed_ll_100(:,x100s-7:x100s+7,:,:);
clear('radht_ll_100','radht_ll_tav_100','radht_ed_ll_100')
[radht_comp,check0] = composite_fun_timelag(peaks_100,fd_thresh_100,radht_ed_n,radht_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/radht_100.mat');

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
title('0.0e_{s0}')
print('-dpng','radht_100.png')
hold off

clear radht_comp


load('/project/rg312/mat_files/heat_rates_best.mat','cndht_100')
cndht_ll_100 = cube2latlon(xc,yc,cndht_100,xi,yi).*86400;
cndht_ll_tav_100 = repmat(mean(cndht_ll_100,4),[1 1 1 720]);
cndht_ed_ll_100 = cndht_ll_100 - cndht_ll_tav_100;
cndht_ed_n = cndht_ed_ll_100(:,x100n-7:x100n+7,:,:);
cndht_ed_s = cndht_ed_ll_100(:,x100s-7:x100s+7,:,:);
clear('cndht_ll_100','cndht_ll_tav_100','cndht_ed_ll_100')
[cndht_comp,check0] = composite_fun_timelag(peaks_100,fd_thresh_100,cndht_ed_n,cndht_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/cndht_100.mat');

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
title('0.0e_{s0}')
print('-dpng','cndht_100.png')
hold off

clear cndht_comp


load('/project/rg312/mat_files/heat_rates_best.mat','cnvht_100')
cnvht_ll_100 = cube2latlon(xc,yc,cnvht_100,xi,yi).*86400;
cnvht_ll_tav_100 = repmat(mean(cnvht_ll_100,4),[1 1 1 720]);
cnvht_ed_ll_100 = cnvht_ll_100 - cnvht_ll_tav_100;
cnvht_ed_n = cnvht_ed_ll_100(:,x100n-7:x100n+7,:,:);
cnvht_ed_s = cnvht_ed_ll_100(:,x100s-7:x100s+7,:,:);
clear('cnvht_ll_100','cnvht_ll_tav_100','cnvht_ed_ll_100')
[cnvht_comp,check0] = composite_fun_timelag(peaks_100,fd_thresh_100,cnvht_ed_n,cnvht_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/cnvht_100.mat');

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
title('0.0e_{s0}')
print('-dpng','cnvht_100.png')
hold off

clear cnvht_comp

load('/project/rg312/mat_files/heat_rates_best.mat','difht_100')
difht_ll_100 = cube2latlon(xc,yc,difht_100,xi,yi).*86400;
difht_ll_tav_100 = repmat(mean(difht_ll_100,4),[1 1 1 720]);
difht_ed_ll_100 = difht_ll_100 - difht_ll_tav_100;
difht_ed_n = difht_ed_ll_100(:,x100n-7:x100n+7,:,:);
difht_ed_s = difht_ed_ll_100(:,x100s-7:x100s+7,:,:);
clear('difht_ll_100','difht_ll_tav_100','difht_ed_ll_100')
[difht_comp,check0] = composite_fun_timelag(peaks_100,fd_thresh_100,difht_ed_n,difht_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/difht_100.mat');

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
title('0.0e_{s0}')
print('-dpng','difht_100.png')
hold off

clear difht_comp

