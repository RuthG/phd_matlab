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
radius=6371.0e3;


for year=1:10
year

load('/project/rg312/mat_files/vt_lats_final.mat')
load(['/project/rg312/mat_files/snapshot_data_final/run_010/arnaud_diag_010_' num2str(year) '.mat'])
load(['/project/rg312/mat_files/snapshot_data_final/run_010/vN_010_timemean.mat'])

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

load(['/project/rg312/mat_files/snapshot_data_final/run_010/vN_010_' num2str(year) '.mat'],'vN_010')
vN_ll_010 = cube2latlon(xc,yc,vN_010,xi,yi);
vN_ll_tav_010 = repmat(mean(vN_ll_tav,4),[1 1 1 360]);
vN_ed_ll_010 = vN_ll_010 - vN_ll_tav_010;

for i=1:15
ved_n(:,i,:,:) = vN_ed_ll_010(:,x010n-8+i,:,:).*cot( yi(x010n - 8 + i).*pi./180 )./radius;
ved_s(:,i,:,:) = vN_ed_ll_010(:,x010s-8+i,:,:).*cot( yi(x010s - 8 + i).*pi./180 )./radius;;
end

clear('vN_ll_010','vN_ed_ll_010')
[wsv_comp,check0] = composite_fun_timelag(peaks_010,fd_thresh_010,ved_n,ved_s,0,['/project/rg312/mat_files/storm_chapter_data/run_010/wsv_010_comp_' num2str(year) '.mat']);

end



