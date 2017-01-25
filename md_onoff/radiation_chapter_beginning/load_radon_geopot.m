for i=1:10

load(['/project/rg312/mat_files/snapshot_data_final/run_100_ro/ph_100_ro_' num2str(i) '.mat'])

ph(:,:,:,i) = mean(ph_100,4);

end

ph_tav = mean(ph,4);

save('/project/rg312/mat_files/radiation_chapter/geopot.mat')
