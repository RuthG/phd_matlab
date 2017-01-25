%load up phihyd, t, eta, and calculate a eta adjusted phi

Ra=287.04;

for j=1:10
j
name=['/project/rg312/mat_files/snapshot_data_final/run_050/eta_050_' num2str(j) '.mat'];
load(name);

name=['/project/rg312/mat_files/snapshot_data_final/run_050/t_050_' num2str(j) '.mat'];
load(name);

name=['/project/rg312/mat_files/snapshot_data_final/run_050/ph_050_' num2str(j) '.mat'];
load(name);

rho_050(:,:,:) = 98000./(Ra.*t_050(:,:,1,:));

ph_surf = eta_050./rho_050;

for i=1:25

ph_adj_050(:,:,i,:) = squeeze(ph_050(:,:,i,:)) + ph_surf(:,:,:);

end

name=['/project/rg312/mat_files/snapshot_data_final/run_050/ph_adj_050_' num2str(j) '.mat'];
save(name,'ph_adj_050');

end
