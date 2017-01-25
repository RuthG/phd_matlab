%load arnaud diag and vNs for 050 run and start thinking about how to handle composite

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
L = 2.500e6;
cp = 287.04./(2./7.);

for year=1:10
year

load('/project/rg312/mat_files/vt_lats_final.mat')
load('/project/rg312/mat_files/front_diag_full_050_best.mat')
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



load(['/project/rg312/mat_files/snapshot_data_final/run_050/t_050_' num2str(year) '.mat'],'t_050')
load(['/project/rg312/mat_files/snapshot_data_final/run_050/t_050_timemean.mat'])
t_ll_050 = cube2latlon(xc,yc,t_050,xi,yi);
t_ll_tav_050 = repmat(mean(t_ll_tav,4),[1 1 1 360]);
t_ed_ll_050 = t_ll_050 - t_ll_tav_050;
t_ed_n = t_ed_ll_050(:,x050n-7:x050n+7,:,:);
t_ed_s = t_ed_ll_050(:,x050s-7:x050s+7,:,:);
clear('t_ll_050','t_ll_tav_050','t_ed_ll_050')

load(['/project/rg312/mat_files/snapshot_data_final/run_050/q_050_' num2str(year) '.mat'],'q_050')
load(['/project/rg312/mat_files/snapshot_data_final/run_050/q_050_timemean.mat'])
q_ll_050 = cube2latlon(xc,yc,q_050,xi,yi);
q_ll_tav_050 = repmat(mean(q_ll_tav,4),[1 1 1 360]);
q_ed_ll_050 = q_ll_050 - q_ll_tav_050;
q_ed_n = q_ed_ll_050(:,x050n-7:x050n+7,:,:);
q_ed_s = q_ed_ll_050(:,x050s-7:x050s+7,:,:);
clear('q_ll_050','q_ll_tav_050','q_ed_ll_050')

load(['/project/rg312/mat_files/snapshot_data_final/run_050/ph_adj_050_' num2str(year) '.mat'],'ph_adj_050')
load(['/project/rg312/mat_files/snapshot_data_final/run_050/ph_adj_050_timemean.mat'])
ph_adj_ll_050 = cube2latlon(xc,yc,ph_adj_050,xi,yi);
ph_adj_ll_tav_050 = repmat(mean(ph_adj_ll_tav,4),[1 1 1 360]);
ph_adj_ed_ll_050 = ph_adj_ll_050 - ph_adj_ll_tav_050;
ph_adj_ed_n = ph_adj_ed_ll_050(:,x050n-7:x050n+7,:,:);
ph_adj_ed_s = ph_adj_ed_ll_050(:,x050s-7:x050s+7,:,:);
clear('ph_adj_ll_050','ph_adj_ll_tav_050','ph_adj_ed_ll_050')

H_ed_n = t_ed_n.*cp + q_ed_n.*L + ph_adj_ed_n;
H_ed_s = t_ed_s.*cp + q_ed_s.*L + ph_adj_ed_s;


[H_comp,check0] = composite_fun_timelag(peaks_050,fd_thresh_050,H_ed_n,H_ed_s,0,['/project/rg312/mat_files/storm_chapter_data/run_050/H_050_comp_' num2str(year) '.mat']);


clear H_comp


end


return

