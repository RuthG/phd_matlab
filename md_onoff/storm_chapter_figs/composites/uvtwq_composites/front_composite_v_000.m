%load arnaud diag and htrts for 000 run and start thinking about how to handle composite

rDir='/project/rg312/final_runs/run_000_final/';
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
load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/arnaud_diag_000_' num2str(year) '.mat'])

front_diag_strack(:,:,1:360) = arnaud_diag_000(:,x000n-7:x000n+7,:);
front_diag_strack(:,:,361:720) = arnaud_diag_000(:,x000s-7:x000s+7,:);

front_diag_thresh = reshape(front_diag_strack,[numel(front_diag_strack),1]);

[fd_dist,fd_val] = hist(front_diag_thresh,100);
fd_sum = cumsum(fd_dist)./sum(fd_dist);
fd_thresh_000 = fd_val(min(find(fd_sum>=0.95)));

for i=1:15
  for j=1:360
  %locate peaks in front diag

  [a_000n,b_000n] = findpeak_prom(arnaud_diag_000(:,x000n-8+i,j),fd_thresh_000./2);
  [a_000s,b_000s] = findpeak_prom(arnaud_diag_000(:,x000s-8+i,j),fd_thresh_000./2);

  %save peak magnitudes and locations in a cell array
  peaks_000{i,j,1} = a_000n;
  peaks_000{i,j,2} = b_000n;
  peaks_000{i,j,3} = a_000s;
  peaks_000{i,j,4} = b_000s;
  end
end

load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/vN_000_' num2str(year) '.mat'],'vN_000')
vN_ll_000 = cube2latlon(xc,yc,vN_000,xi,yi);
v_n = vN_ll_000(:,x000n-7:x000n+7,:,:);
v_s = -1.*vN_ll_000(:,x000s-7:x000s+7,:,:);
clear('vN_ll_000')
[vN_comp,check0] = composite_fun_timelag(peaks_000,fd_thresh_000,v_n,v_s,0,['/project/rg312/mat_files/storm_chapter_data/run_000/vN_000_comp_' num2str(year) '.mat']);

end



