%load up phihyd, t, eta, and calculate a eta adjusted phi

Ra=287.04;

for j=1:10
j
name=['/project/rg312/mat_files/snapshot_data_final/run_010/eta_010_' num2str(j) '.mat'];
load(name);

name=['/project/rg312/mat_files/snapshot_data_final/run_010/t_010_' num2str(j) '.mat'];
load(name);

name=['/project/rg312/mat_files/snapshot_data_final/run_010/ph_010_' num2str(j) '.mat'];
load(name);

rho_010(:,:,:) = 98000./(Ra.*t_010(:,:,1,:));

ph_surf = eta_010./rho_010;

for i=1:25

ph_adj_010(:,:,i,:) = squeeze(ph_010(:,:,i,:)) + ph_surf(:,:,:);

end

name=['/project/rg312/mat_files/snapshot_data_final/run_010/ph_adj_010_' num2str(j) '.mat'];
save(name,'ph_adj_010');

end
