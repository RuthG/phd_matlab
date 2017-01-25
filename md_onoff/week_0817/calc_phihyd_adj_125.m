%load up phihyd, t, eta, and calculate a eta adjusted phi

Ra=287.04;

for j=1:10
j
name=['/project/rg312/mat_files/snapshot_data_final/run_125/eta_125_' num2str(j) '.mat'];
load(name);

name=['/project/rg312/mat_files/snapshot_data_final/run_125/t_125_' num2str(j) '.mat'];
load(name);

name=['/project/rg312/mat_files/snapshot_data_final/run_125/ph_125_' num2str(j) '.mat'];
load(name);

rho_125(:,:,:) = 98000./(Ra.*t_125(:,:,1,:));

ph_surf = eta_125./rho_125;

for i=1:25

ph_adj_125(:,:,i,:) = squeeze(ph_125(:,:,i,:)) + ph_surf(:,:,:);

end

name=['/project/rg312/mat_files/snapshot_data_final/run_125/ph_adj_125_' num2str(j) '.mat'];
save(name,'ph_adj_125');

end
