%load up phihyd, t, eta, and calculate a eta adjusted phi

Ra=287.04;

for j=1:10
j
name=['/project/rg312/mat_files/snapshot_data_final/run_100_ro/eta_100_' num2str(j) '.mat'];
load(name);

name=['/project/rg312/mat_files/snapshot_data_final/run_100_ro/t_100_ro_' num2str(j) '.mat'];
load(name);

name=['/project/rg312/mat_files/snapshot_data_final/run_100_ro/ph_100_ro_' num2str(j) '.mat'];
load(name);

rho_100(:,:,:) = 98000./(Ra.*t_100(:,:,1,:));

ph_surf = eta_100./rho_100;

for i=1:25

ph_adj_100(:,:,i,:) = squeeze(ph_100(:,:,i,:)) + ph_surf(:,:,:);

end

name=['/project/rg312/mat_files/snapshot_data_final/run_100_ro/ph_adj_100_ro_' num2str(j) '.mat'];
save(name,'ph_adj_100');

end
