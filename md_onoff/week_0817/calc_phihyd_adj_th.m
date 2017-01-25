%load up phihyd, t, eta, and calculate a eta adjusted phi

Ra=287.04;

for j=1:10
j
name=['/project/rg312/mat_files/snapshot_data_final/run_th/eta_th_' num2str(j) '.mat'];
load(name);

name=['/project/rg312/mat_files/snapshot_data_final/run_th/t_th_' num2str(j) '.mat'];
load(name);

name=['/project/rg312/mat_files/snapshot_data_final/run_th/ph_th_' num2str(j) '.mat'];
load(name);

rho_th(:,:,:) = 98000./(Ra.*t_th(:,:,1,:));

ph_surf = eta_th./rho_th;

for i=1:25

ph_adj_th(:,:,i,:) = squeeze(ph_th(:,:,i,:)) + ph_surf(:,:,:);

end

name=['/project/rg312/mat_files/snapshot_data_final/run_th/ph_adj_th_' num2str(j) '.mat'];
save(name,'ph_adj_th');

end
