%load up phihyd, t, eta, and calculate a eta adjusted phi

Ra=287.04;

for j=1:10
j
name=['/project/rg312/mat_files/snapshot_data_final/run_150/eta_150_' num2str(j) '.mat'];
load(name);

name=['/project/rg312/mat_files/snapshot_data_final/run_150/t_150_' num2str(j) '.mat'];
load(name);

name=['/project/rg312/mat_files/snapshot_data_final/run_150/ph_150_' num2str(j) '.mat'];
load(name);

rho_150(:,:,:) = 98000./(Ra.*t_150(:,:,1,:));

ph_surf = eta_150./rho_150;

for i=1:25

ph_adj_150(:,:,i,:) = squeeze(ph_150(:,:,i,:)) + ph_surf(:,:,:);

end

name=['/project/rg312/mat_files/snapshot_data_final/run_150/ph_adj_150_' num2str(j) '.mat'];
save(name,'ph_adj_150');

end
