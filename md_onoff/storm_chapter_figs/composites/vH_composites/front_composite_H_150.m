%load arnaud diag and vNs for 150 run and start thinking about how to handle composite

rDir='/project/rg312/final_runs/run_150_final/';
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
load('/project/rg312/mat_files/front_diag_full_150_best.mat')
load(['/project/rg312/mat_files/snapshot_data_final/run_150/arnaud_diag_150_' num2str(year) '.mat'])

front_diag_strack(:,:,1:360) = arnaud_diag_150(:,x150n-7:x150n+7,:);
front_diag_strack(:,:,361:720) = arnaud_diag_150(:,x150s-7:x150s+7,:);

front_diag_thresh = reshape(front_diag_strack,[numel(front_diag_strack),1]);

[fd_dist,fd_val] = hist(front_diag_thresh,100);
fd_sum = cumsum(fd_dist)./sum(fd_dist);
fd_thresh_150 = fd_val(min(find(fd_sum>=0.95)));

for i=1:15
  for j=1:360
  %locate peaks in front diag

  [a_150n,b_150n] = findpeak_prom(arnaud_diag_150(:,x150n-8+i,j),fd_thresh_150./2);
  [a_150s,b_150s] = findpeak_prom(arnaud_diag_150(:,x150s-8+i,j),fd_thresh_150./2);

  %save peak magnitudes and locations in a cell array
  peaks_150{i,j,1} = a_150n;
  peaks_150{i,j,2} = b_150n;
  peaks_150{i,j,3} = a_150s;
  peaks_150{i,j,4} = b_150s;
  end
end



load(['/project/rg312/mat_files/snapshot_data_final/run_150/t_150_' num2str(year) '.mat'],'t_150')
load(['/project/rg312/mat_files/snapshot_data_final/run_150/t_150_timemean.mat'])
t_ll_150 = cube2latlon(xc,yc,t_150,xi,yi);
t_ll_tav_150 = repmat(mean(t_ll_tav,4),[1 1 1 360]);
t_ed_ll_150 = t_ll_150 - t_ll_tav_150;
t_ed_n = t_ed_ll_150(:,x150n-7:x150n+7,:,:);
t_ed_s = t_ed_ll_150(:,x150s-7:x150s+7,:,:);
clear('t_ll_150','t_ll_tav_150','t_ed_ll_150')

load(['/project/rg312/mat_files/snapshot_data_final/run_150/q_150_' num2str(year) '.mat'],'q_150')
load(['/project/rg312/mat_files/snapshot_data_final/run_150/q_150_timemean.mat'])
q_ll_150 = cube2latlon(xc,yc,q_150,xi,yi);
q_ll_tav_150 = repmat(mean(q_ll_tav,4),[1 1 1 360]);
q_ed_ll_150 = q_ll_150 - q_ll_tav_150;
q_ed_n = q_ed_ll_150(:,x150n-7:x150n+7,:,:);
q_ed_s = q_ed_ll_150(:,x150s-7:x150s+7,:,:);
clear('q_ll_150','q_ll_tav_150','q_ed_ll_150')

load(['/project/rg312/mat_files/snapshot_data_final/run_150/ph_adj_150_' num2str(year) '.mat'],'ph_adj_150')
load(['/project/rg312/mat_files/snapshot_data_final/run_150/ph_adj_150_timemean.mat'])
ph_adj_ll_150 = cube2latlon(xc,yc,ph_adj_150,xi,yi);
ph_adj_ll_tav_150 = repmat(mean(ph_adj_ll_tav,4),[1 1 1 360]);
ph_adj_ed_ll_150 = ph_adj_ll_150 - ph_adj_ll_tav_150;
ph_adj_ed_n = ph_adj_ed_ll_150(:,x150n-7:x150n+7,:,:);
ph_adj_ed_s = ph_adj_ed_ll_150(:,x150s-7:x150s+7,:,:);
clear('ph_adj_ll_150','ph_adj_ll_tav_150','ph_adj_ed_ll_150')

H_ed_n = t_ed_n.*cp + q_ed_n.*L + ph_adj_ed_n;
H_ed_s = t_ed_s.*cp + q_ed_s.*L + ph_adj_ed_s;


[H_comp,check0] = composite_fun_timelag(peaks_150,fd_thresh_150,H_ed_n,H_ed_s,0,['/project/rg312/mat_files/storm_chapter_data/run_150/H_150_comp_' num2str(year) '.mat']);


clear H_comp


end


return

