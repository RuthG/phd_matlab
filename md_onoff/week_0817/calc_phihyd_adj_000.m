%load up phihyd, t, eta, and calculate a eta adjusted phi

Ra=287.04;

for j=1:10
j
name=['/project/rg312/mat_files/snapshot_data_final/run_000_ns/eta_000_' num2str(j) '.mat'];
load(name);

name=['/project/rg312/mat_files/snapshot_data_final/run_000_ns/t_000_' num2str(j) '.mat'];
load(name);

name=['/project/rg312/mat_files/snapshot_data_final/run_000_ns/ph_000_' num2str(j) '.mat'];
load(name);

rho_000(:,:,:) = 98000./(Ra.*t_000(:,:,1,:));

ph_surf = eta_000./rho_000;

for i=1:25

ph_adj_000(:,:,i,:) = squeeze(ph_000(:,:,i,:)) + ph_surf(:,:,:);

end

name=['/project/rg312/mat_files/snapshot_data_final/run_000_ns/ph_adj_000_' num2str(j) '.mat'];
save(name,'ph_adj_000');

end
