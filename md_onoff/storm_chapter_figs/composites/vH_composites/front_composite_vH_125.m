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
L = 2.500e6;
cp = 287.04./(2./7.);

for year=1:10
year

load('/project/rg312/mat_files/vt_lats_final.mat')
load('/project/rg312/mat_files/front_diag_full_125_best.mat')
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
load(['/project/rg312/mat_files/snapshot_data_final/run_125/vN_125_timemean.mat'])
vN_ll_125 = cube2latlon(xc,yc,vN_125,xi,yi);
vN_ll_tav_125 = repmat(mean(vN_ll_tav,4),[1 1 1 360]);
vN_ed_ll_125 = vN_ll_125 - vN_ll_tav_125;
vN_ed_n = vN_ed_ll_125(:,x125n-7:x125n+7,:,:);
vN_ed_s = -1.*vN_ed_ll_125(:,x125s-7:x125s+7,:,:);
clear('vN_ll_125','vN_ll_tav_125','vN_ed_ll_125')

load(['/project/rg312/mat_files/snapshot_data_final/run_125/t_125_' num2str(year) '.mat'],'t_125')
load(['/project/rg312/mat_files/snapshot_data_final/run_125/t_125_timemean.mat'])
t_ll_125 = cube2latlon(xc,yc,t_125,xi,yi);
t_ll_tav_125 = repmat(mean(t_ll_tav,4),[1 1 1 360]);
t_ed_ll_125 = t_ll_125 - t_ll_tav_125;
t_ed_n = t_ed_ll_125(:,x125n-7:x125n+7,:,:);
t_ed_s = t_ed_ll_125(:,x125s-7:x125s+7,:,:);
clear('t_ll_125','t_ll_tav_125','t_ed_ll_125')

load(['/project/rg312/mat_files/snapshot_data_final/run_125/q_125_' num2str(year) '.mat'],'q_125')
load(['/project/rg312/mat_files/snapshot_data_final/run_125/q_125_timemean.mat'])
q_ll_125 = cube2latlon(xc,yc,q_125,xi,yi);
q_ll_tav_125 = repmat(mean(q_ll_tav,4),[1 1 1 360]);
q_ed_ll_125 = q_ll_125 - q_ll_tav_125;
q_ed_n = q_ed_ll_125(:,x125n-7:x125n+7,:,:);
q_ed_s = q_ed_ll_125(:,x125s-7:x125s+7,:,:);
clear('q_ll_125','q_ll_tav_125','q_ed_ll_125')

load(['/project/rg312/mat_files/snapshot_data_final/run_125/ph_adj_125_' num2str(year) '.mat'],'ph_adj_125')
load(['/project/rg312/mat_files/snapshot_data_final/run_125/ph_adj_125_timemean.mat'])
ph_adj_ll_125 = cube2latlon(xc,yc,ph_adj_125,xi,yi);
ph_adj_ll_tav_125 = repmat(mean(ph_adj_ll_tav,4),[1 1 1 360]);
ph_adj_ed_ll_125 = ph_adj_ll_125 - ph_adj_ll_tav_125;
ph_adj_ed_n = ph_adj_ed_ll_125(:,x125n-7:x125n+7,:,:);
ph_adj_ed_s = ph_adj_ed_ll_125(:,x125s-7:x125s+7,:,:);
clear('ph_adj_ll_125','ph_adj_ll_tav_125','ph_adj_ed_ll_125')

vNH_ed_n = vN_ed_n.*(t_ed_n.*cp + q_ed_n.*L + ph_adj_ed_n);
vNH_ed_s = vN_ed_s.*(t_ed_s.*cp + q_ed_s.*L + ph_adj_ed_s);

[vNH_comp,check0] = composite_fun_timelag(peaks_125,fd_thresh_125,vNH_ed_n,vNH_ed_s,0,['/project/rg312/mat_files/storm_chapter_data/run_125/vNH_125_comp_' num2str(year) '.mat']);

clear vNH_comp

end


return

