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

load('/project/rg312/mat_files/vt_lats.mat')
load('/project/rg312/mat_files/front_diag_full_050.mat')

front_diag_strack(:,:,1:720) = arnaud_diag_050(:,x050n-7:x050n+7,:);
front_diag_strack(:,:,721:1440) = arnaud_diag_050(:,x050s-7:x050s+7,:);

front_diag_thresh = reshape(front_diag_strack,[numel(front_diag_strack),1]);

[fd_dist,fd_val] = hist(front_diag_thresh,100);
fd_sum = cumsum(fd_dist)./sum(fd_dist);
fd_thresh_050 = fd_val(min(find(fd_sum>=0.95)));

for i=1:15
  for j=1:720
  %locate peaks in front diag

  [a_050n,b_050n] = findpeak_prom(arnaud_diag_050(:,x050n-8+i,j),fd_thresh_050./2);
  [a_050s,b_050s] = findpeak_prom(arnaud_diag_050(:,x050s-8+i,j),fd_thresh_050./2);

  %save peak magnitudes and locations in a cell array
  peaks_050{i,j,1} = a_050n;
  peaks_050{i,j,2} = b_050n;
  peaks_050{i,j,3} = a_050s;
  peaks_050{i,j,4} = b_050s;
  end
end



load('/project/rg312/mat_files/heat_rates.mat','htrt_050')
htrt_ll_050 = cube2latlon(xc,yc,htrt_050,xi,yi).*86400;
htrt_ll_tav_050 = repmat(mean(htrt_ll_050,4),[1 1 1 720]);
htrt_ed_ll_050 = htrt_ll_050 - htrt_ll_tav_050;
htrt_ed_n = htrt_ed_ll_050(:,x050n-7:x050n+7,:,:);
htrt_ed_s = htrt_ed_ll_050(:,x050s-7:x050s+7,:,:);
clear('htrt_ll_050','htrt_ll_tav_050','htrt_ed_ll_050')
[htrt_comp,check0] = composite_fun_timelag(peaks_050,fd_thresh_050,htrt_ed_n,htrt_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/htrt_050.mat');
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
title('0.5e_{s0}')
print('-dpng','htrt_050.png')
hold off

clear htrt_comp


load('/project/rg312/mat_files/heat_rates.mat','radht_050')
radht_ll_050 = cube2latlon(xc,yc,radht_050,xi,yi).*86400;
radht_ll_tav_050 = repmat(mean(radht_ll_050,4),[1 1 1 720]);
radht_ed_ll_050 = radht_ll_050 - radht_ll_tav_050;
radht_ed_n = radht_ed_ll_050(:,x050n-7:x050n+7,:,:);
radht_ed_s = radht_ed_ll_050(:,x050s-7:x050s+7,:,:);
clear('radht_ll_050','radht_ll_tav_050','radht_ed_ll_050')
[radht_comp,check0] = composite_fun_timelag(peaks_050,fd_thresh_050,radht_ed_n,radht_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/radht_050.mat');

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
title('0.5e_{s0}')
print('-dpng','radht_050.png')
hold off

clear radht_comp


load('/project/rg312/mat_files/heat_rates.mat','cndht_050')
cndht_ll_050 = cube2latlon(xc,yc,cndht_050,xi,yi).*86400;
cndht_ll_tav_050 = repmat(mean(cndht_ll_050,4),[1 1 1 720]);
cndht_ed_ll_050 = cndht_ll_050 - cndht_ll_tav_050;
cndht_ed_n = cndht_ed_ll_050(:,x050n-7:x050n+7,:,:);
cndht_ed_s = cndht_ed_ll_050(:,x050s-7:x050s+7,:,:);
clear('cndht_ll_050','cndht_ll_tav_050','cndht_ed_ll_050')
[cndht_comp,check0] = composite_fun_timelag(peaks_050,fd_thresh_050,cndht_ed_n,cndht_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/cndht_050.mat');

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
title('0.5e_{s0}')
print('-dpng','cndht_050.png')
hold off

clear cndht_comp


load('/project/rg312/mat_files/heat_rates.mat','cnvht_050')
cnvht_ll_050 = cube2latlon(xc,yc,cnvht_050,xi,yi).*86400;
cnvht_ll_tav_050 = repmat(mean(cnvht_ll_050,4),[1 1 1 720]);
cnvht_ed_ll_050 = cnvht_ll_050 - cnvht_ll_tav_050;
cnvht_ed_n = cnvht_ed_ll_050(:,x050n-7:x050n+7,:,:);
cnvht_ed_s = cnvht_ed_ll_050(:,x050s-7:x050s+7,:,:);
clear('cnvht_ll_050','cnvht_ll_tav_050','cnvht_ed_ll_050')
[cnvht_comp,check0] = composite_fun_timelag(peaks_050,fd_thresh_050,cnvht_ed_n,cnvht_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/cnvht_050.mat');

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
title('0.5e_{s0}')
print('-dpng','cnvht_050.png')
hold off

clear cnvht_comp

load('/project/rg312/mat_files/heat_rates.mat','difht_050')
difht_ll_050 = cube2latlon(xc,yc,difht_050,xi,yi).*86400;
difht_ll_tav_050 = repmat(mean(difht_ll_050,4),[1 1 1 720]);
difht_ed_ll_050 = difht_ll_050 - difht_ll_tav_050;
difht_ed_n = difht_ed_ll_050(:,x050n-7:x050n+7,:,:);
difht_ed_s = difht_ed_ll_050(:,x050s-7:x050s+7,:,:);
clear('difht_ll_050','difht_ll_tav_050','difht_ed_ll_050')
[difht_comp,check0] = composite_fun_timelag(peaks_050,fd_thresh_050,difht_ed_n,difht_ed_s,0,'/project/rg312/mat_files/front_diag_composite_data/difht_050.mat');

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
title('0.5e_{s0}')
print('-dpng','difht_050.png')
hold off

clear difht_comp

