%load arnaud diag and htrts for 125 run and start thinking about how to handle composite

rDir='/project/rg312/final_runs/run_125_final/';
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
load(['/project/rg312/mat_files/snapshot_data_final/run_125/arnaud_diag_125_' num2str(year) '.mat'])

front_diag_strack(:,:,1:360) = arnaud_diag_125(:,x125n-7:x125n+7,:);
front_diag_strack(:,:,361:720) = arnaud_diag_125(:,x125s-7:x125s+7,:);

front_diag_thresh = reshape(front_diag_strack,[numel(front_diag_strack),1]);

[fd_dist,fd_val] = hist(front_diag_thresh,100);
fd_sum = cumsum(fd_dist)./sum(fd_dist);
fd_thresh_125 = fd_val(min(find(fd_sum>=0.95)));

for i=1:15
  for j=1:360
  %locate peaks in front diag

  [a_125n,b_125n] = findpeak_prom(arnaud_diag_125(:,x125n-8+i,j),fd_thresh_125./2);
  [a_125s,b_125s] = findpeak_prom(arnaud_diag_125(:,x125s-8+i,j),fd_thresh_125./2);

  %save peak magnitudes and locations in a cell array
  peaks_125{i,j,1} = a_125n;
  peaks_125{i,j,2} = b_125n;
  peaks_125{i,j,3} = a_125s;
  peaks_125{i,j,4} = b_125s;
  end
end

load(['/project/rg312/mat_files/snapshot_data_final/run_125/vN_125_' num2str(year) '.mat'],'vN_125')
vN_ll_125 = cube2latlon(xc,yc,vN_125,xi,yi);
v_n = vN_ll_125(:,x125n-7:x125n+7,:,:);
v_s = -1.*vN_ll_125(:,x125s-7:x125s+7,:,:);
clear('vN_ll_125')
[vN_comp,check0] = composite_fun_timelag(peaks_125,fd_thresh_125,v_n,v_s,0,['/project/rg312/mat_files/storm_chapter_data/run_125/vN_125_comp_' num2str(year) '.mat']);

end



