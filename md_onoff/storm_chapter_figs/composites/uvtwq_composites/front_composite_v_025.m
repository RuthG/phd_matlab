%load arnaud diag and htrts for 025 run and start thinking about how to handle composite

rDir='/project/rg312/final_runs/run_025_final/';
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
load(['/project/rg312/mat_files/snapshot_data_final/run_025/arnaud_diag_025_' num2str(year) '.mat'])

front_diag_strack(:,:,1:360) = arnaud_diag_025(:,x025n-7:x025n+7,:);
front_diag_strack(:,:,361:720) = arnaud_diag_025(:,x025s-7:x025s+7,:);

front_diag_thresh = reshape(front_diag_strack,[numel(front_diag_strack),1]);

[fd_dist,fd_val] = hist(front_diag_thresh,100);
fd_sum = cumsum(fd_dist)./sum(fd_dist);
fd_thresh_025 = fd_val(min(find(fd_sum>=0.95)));

for i=1:15
  for j=1:360
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

load(['/project/rg312/mat_files/snapshot_data_final/run_025/vN_025_' num2str(year) '.mat'],'vN_025')
vN_ll_025 = cube2latlon(xc,yc,vN_025,xi,yi);
v_n = vN_ll_025(:,x025n-7:x025n+7,:,:);
v_s = -1.*vN_ll_025(:,x025s-7:x025s+7,:,:);
clear('vN_ll_025')
[vN_comp,check0] = composite_fun_timelag(peaks_025,fd_thresh_025,v_n,v_s,0,['/project/rg312/mat_files/storm_chapter_data/run_025/vN_025_comp_' num2str(year) '.mat']);

end



