%load up phihyd, t, eta, and calculate a eta adjusted phi

Ra=287.04;

for j=1:10
j
name=['/project/rg312/mat_files/snapshot_data_final/run_025/eta_025_' num2str(j) '.mat'];
load(name);

name=['/project/rg312/mat_files/snapshot_data_final/run_025/t_025_' num2str(j) '.mat'];
load(name);

name=['/project/rg312/mat_files/snapshot_data_final/run_025/ph_025_' num2str(j) '.mat'];
load(name);

rho_025(:,:,:) = 98000./(Ra.*t_025(:,:,1,:));

ph_surf = eta_025./rho_025;

for i=1:25

ph_adj_025(:,:,i,:) = squeeze(ph_025(:,:,i,:)) + ph_surf(:,:,:);

end

name=['/project/rg312/mat_files/snapshot_data_final/run_025/ph_adj_025_' num2str(j) '.mat'];
save(name,'ph_adj_025');

end
