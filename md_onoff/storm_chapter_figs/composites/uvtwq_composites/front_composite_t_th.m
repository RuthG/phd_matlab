%load arnaud diag and htrts for th run and start thinking about how to handle composite

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

load(['/project/rg312/mat_files/snapshot_data_final/run_th/t_th_timemean.mat'])

for year=1:10
year

load('/project/rg312/mat_files/vt_lats_final.mat')
load(['/project/rg312/mat_files/snapshot_data_final/run_th/arnaud_diag_th_' num2str(year) '.mat'])

front_diag_strack(:,:,1:360) = arnaud_diag_th(:,xthn-7:xthn+7,:);
front_diag_strack(:,:,361:720) = arnaud_diag_th(:,xths-7:xths+7,:);

front_diag_thresh = reshape(front_diag_strack,[numel(front_diag_strack),1]);

[fd_dist,fd_val] = hist(front_diag_thresh,100);
fd_sum = cumsum(fd_dist)./sum(fd_dist);
fd_thresh_th = fd_val(min(find(fd_sum>=0.95)));

for i=1:15
  for j=1:360
  %locate peaks in front diag

  [a_thn,b_thn] = findpeak_prom(arnaud_diag_th(:,xthn-8+i,j),fd_thresh_th./2);
  [a_ths,b_ths] = findpeak_prom(arnaud_diag_th(:,xths-8+i,j),fd_thresh_th./2);

  %save peak magnitudes and locations in a cell array
  peaks_th{i,j,1} = a_thn;
  peaks_th{i,j,2} = b_thn;
  peaks_th{i,j,3} = a_ths;
  peaks_th{i,j,4} = b_ths;
  end
end

load(['/project/rg312/mat_files/snapshot_data_final/run_th/t_th_' num2str(year) '.mat'],'t_th')
t_ll_th = cube2latlon(xc,yc,t_th,xi,yi);
t_ll_tav_th = repmat(mean(t_ll_tav,4),[1 1 1 360]);
t_ed_ll_th = t_ll_th - t_ll_tav_th;
t_ed_n = t_ed_ll_th(:,xthn-7:xthn+7,:,:);
t_ed_s = t_ed_ll_th(:,xths-7:xths+7,:,:);
clear('t_ll_th','t_ll_tav_th','t_ed_ll_th')
[t_ed_comp,check0] = composite_fun_timelag(peaks_th,fd_thresh_th,t_ed_n,t_ed_s,0,['/project/rg312/mat_files/storm_chapter_data/run_th/t_ed_th_comp_' num2str(year) '.mat']);


end



