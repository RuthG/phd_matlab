
for year=1:10
load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/theta_000_' num2str(year) '.mat']);
theta_ll_tav_lats_000(:,:,:,i) = mean(cube2latlon(xc,yc,theta_000,xi,yi),4);

load(['/project/rg312/mat_files/snapshot_data_final/run_100/theta_100_' num2str(year) '.mat']);
theta_ll_tav_lats_100(:,:,:,i) = mean(cube2latlon(xc,yc,theta_100,xi,yi),4);
end

theta_ll_tav_lats = mean(theta_ll_tav_lats_000,4);
save(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/theta_000_timemean.mat']);


theta_ll_tav_lats = mean(theta_ll_tav_lats_100,4);
save(['/project/rg312/mat_files/snapshot_data_final/run_100/theta_100_timemean.mat']);