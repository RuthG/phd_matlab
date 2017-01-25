%load up phihyd, t, eta, and calculate a eta adjusted phi

Ra=287.04;

for j=1:10
j
name=['/project/rg312/mat_files/snapshot_data_final/run_075/eta_075_' num2str(j) '.mat'];
load(name);

name=['/project/rg312/mat_files/snapshot_data_final/run_075/t_075_' num2str(j) '.mat'];
load(name);

name=['/project/rg312/mat_files/snapshot_data_final/run_075/ph_075_' num2str(j) '.mat'];
load(name);

rho_075(:,:,:) = 98000./(Ra.*t_075(:,:,1,:));

ph_surf = eta_075./rho_075;

for i=1:25

ph_adj_075(:,:,i,:) = squeeze(ph_075(:,:,i,:)) + ph_surf(:,:,:);

end

name=['/project/rg312/mat_files/snapshot_data_final/run_075/ph_adj_075_' num2str(j) '.mat'];
save(name,'ph_adj_075');

end
