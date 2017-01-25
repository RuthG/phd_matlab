%load arnaud diag and htrts for 050 run and start thinking about how to handle composite

rDir='/project/rg312/final_runs/run_050_final/';
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
load(['/project/rg312/mat_files/snapshot_data_final/run_050/arnaud_diag_050_' num2str(year) '.mat'])

front_diag_strack(:,:,1:360) = arnaud_diag_050(:,x050n-7:x050n+7,:);
front_diag_strack(:,:,361:720) = arnaud_diag_050(:,x050s-7:x050s+7,:);

front_diag_thresh = reshape(front_diag_strack,[numel(front_diag_strack),1]);

[fd_dist,fd_val] = hist(front_diag_thresh,100);
fd_sum = cumsum(fd_dist)./sum(fd_dist);
fd_thresh_050 = fd_val(min(find(fd_sum>=0.95)));

for i=1:15
  for j=1:360
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

load(['/project/rg312/mat_files/snapshot_data_final/run_050/w_050_' num2str(year) '.mat'],'w_050')
w_ll_050 = cube2latlon(xc,yc,w_050,xi,yi);
w_n = w_ll_050(:,x050n-7:x050n+7,:,:);
w_s = w_ll_050(:,x050s-7:x050s+7,:,:);
clear('w_ll_050')
[w_comp,check0] = composite_fun_timelag(peaks_050,fd_thresh_050,w_n,w_s,0,['/project/rg312/mat_files/storm_chapter_data/run_050/w_050_comp_' num2str(year) '.mat']);

end



