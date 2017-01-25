%load arnaud diag and vNs for 100 run and start thinking about how to handle composite

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
L = 2.500e6;
cp = 287.04./(2./7.);

for year=1:10
year

load('/project/rg312/mat_files/vt_lats_final.mat')
load('/project/rg312/mat_files/front_diag_full_100_best.mat')
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



load(['/project/rg312/mat_files/snapshot_data_final/run_100/t_100_' num2str(year) '.mat'],'t_100')
load(['/project/rg312/mat_files/snapshot_data_final/run_100/t_100_timemean.mat'])
t_ll_100 = cube2latlon(xc,yc,t_100,xi,yi);
t_ll_tav_100 = repmat(mean(t_ll_tav,4),[1 1 1 360]);
t_ed_ll_100 = t_ll_100 - t_ll_tav_100;
t_ed_n = t_ed_ll_100(:,x100n-7:x100n+7,:,:);
t_ed_s = t_ed_ll_100(:,x100s-7:x100s+7,:,:);
clear('t_ll_100','t_ll_tav_100','t_ed_ll_100')

load(['/project/rg312/mat_files/snapshot_data_final/run_100/q_100_' num2str(year) '.mat'],'q_100')
load(['/project/rg312/mat_files/snapshot_data_final/run_100/q_100_timemean.mat'])
q_ll_100 = cube2latlon(xc,yc,q_100,xi,yi);
q_ll_tav_100 = repmat(mean(q_ll_tav,4),[1 1 1 360]);
q_ed_ll_100 = q_ll_100 - q_ll_tav_100;
q_ed_n = q_ed_ll_100(:,x100n-7:x100n+7,:,:);
q_ed_s = q_ed_ll_100(:,x100s-7:x100s+7,:,:);
clear('q_ll_100','q_ll_tav_100','q_ed_ll_100')

load(['/project/rg312/mat_files/snapshot_data_final/run_100/ph_adj_100_' num2str(year) '.mat'],'ph_adj_100')
load(['/project/rg312/mat_files/snapshot_data_final/run_100/ph_adj_100_timemean.mat'])
ph_adj_ll_100 = cube2latlon(xc,yc,ph_adj_100,xi,yi);
ph_adj_ll_tav_100 = repmat(mean(ph_adj_ll_tav,4),[1 1 1 360]);
ph_adj_ed_ll_100 = ph_adj_ll_100 - ph_adj_ll_tav_100;
ph_adj_ed_n = ph_adj_ed_ll_100(:,x100n-7:x100n+7,:,:);
ph_adj_ed_s = ph_adj_ed_ll_100(:,x100s-7:x100s+7,:,:);
clear('ph_adj_ll_100','ph_adj_ll_tav_100','ph_adj_ed_ll_100')

H_ed_n = t_ed_n.*cp + q_ed_n.*L + ph_adj_ed_n;
H_ed_s = t_ed_s.*cp + q_ed_s.*L + ph_adj_ed_s;


[H_comp,check0] = composite_fun_timelag(peaks_100,fd_thresh_100,H_ed_n,H_ed_s,0,['/project/rg312/mat_files/storm_chapter_data/run_100/H_100_comp_' num2str(year) '.mat']);


clear H_comp


end


return

