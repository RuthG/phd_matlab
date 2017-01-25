%load arnaud diag and htrts for 100 run and start thinking about how to handle composite

rDir='/project/rg312/final_runs/run_100_final/';
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
load(['/project/rg312/mat_files/snapshot_data_final/run_100/arnaud_diag_100_' num2str(year) '.mat'])

front_diag_strack(:,:,1:360) = arnaud_diag_100(:,x100n-7:x100n+7,:);
front_diag_strack(:,:,361:720) = arnaud_diag_100(:,x100s-7:x100s+7,:);

front_diag_thresh = reshape(front_diag_strack,[numel(front_diag_strack),1]);

[fd_dist,fd_val] = hist(front_diag_thresh,100);
fd_sum = cumsum(fd_dist)./sum(fd_dist);
fd_thresh_100 = fd_val(min(find(fd_sum>=0.95)));

for i=1:15
  for j=1:360
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

load(['/project/rg312/mat_files/snapshot_data_final/run_100/cndht_100_' num2str(year) '.mat'],'cndht_100')
cndht_ll_100 = cube2latlon(xc,yc,cndht_100,xi,yi).*86400;
cndht_n = cndht_ll_100(:,x100n-7:x100n+7,:,:);
cndht_s = cndht_ll_100(:,x100s-7:x100s+7,:,:);
clear('cndht_ll_100')
[cndht_comp,check0] = composite_fun_timelag(peaks_100,fd_thresh_100,cndht_n,cndht_s,0,['/project/rg312/mat_files/storm_chapter_data/run_100/cndht_100_comp_' num2str(year) '.mat']);
clear cndht_comp

load(['/project/rg312/mat_files/snapshot_data_final/run_100/cnvht_100_' num2str(year) '.mat'],'cnvht_100')
cnvht_ll_100 = cube2latlon(xc,yc,cnvht_100,xi,yi).*86400;
cnvht_n = cnvht_ll_100(:,x100n-7:x100n+7,:,:);
cnvht_s = cnvht_ll_100(:,x100s-7:x100s+7,:,:);
clear('cnvht_ll_100')
[cnvht_comp,check0] = composite_fun_timelag(peaks_100,fd_thresh_100,cnvht_n,cnvht_s,0,['/project/rg312/mat_files/storm_chapter_data/run_100/cnvht_100_comp_' num2str(year) '.mat']);
clear cnvht_comp

load(['/project/rg312/mat_files/snapshot_data_final/run_100/difht_100_' num2str(year) '.mat'],'difht_100')
difht_ll_100 = cube2latlon(xc,yc,difht_100,xi,yi).*86400;
difht_n = difht_ll_100(:,x100n-7:x100n+7,:,:);
difht_s = difht_ll_100(:,x100s-7:x100s+7,:,:);
clear('difht_ll_100')
[difht_comp,check0] = composite_fun_timelag(peaks_100,fd_thresh_100,difht_n,difht_s,0,['/project/rg312/mat_files/storm_chapter_data/run_100/difht_100_comp_' num2str(year) '.mat']);
clear difht_comp

load(['/project/rg312/mat_files/snapshot_data_final/run_100/radht_100_' num2str(year) '.mat'],'radht_100')
radht_ll_100 = cube2latlon(xc,yc,radht_100,xi,yi).*86400;
radht_n = radht_ll_100(:,x100n-7:x100n+7,:,:);
radht_s = radht_ll_100(:,x100s-7:x100s+7,:,:);
clear('radht_ll_100')
[radht_comp,check0] = composite_fun_timelag(peaks_100,fd_thresh_100,radht_n,radht_s,0,['/project/rg312/mat_files/storm_chapter_data/run_100/radht_100_comp_' num2str(year) '.mat']);
clear radht_comp

end


