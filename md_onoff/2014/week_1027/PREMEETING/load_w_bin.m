%use w_dists_fn to load up and save w binning

rDir='/project/rg312/wv_on_rad_off/run_doshallower00/';
w_area_dist_000 = w_dists_fn(rDir);
save('w_area_dists.mat','w_area_dist_000')
clear w_area_dist_000

rDir='/project/rg312/wv_on_rad_off/run_doshallower01/';
w_area_dist_001 = w_dists_fn(rDir);
save('w_area_dists.mat','w_area_dist_001','-append')
clear w_area_dist_001

rDir='/project/rg312/wv_on_rad_off/run_doshallower025/';
w_area_dist_025 = w_dists_fn(rDir);
save('w_area_dists.mat','w_area_dist_025','-append')
clear w_area_dist_025

rDir='/project/rg312/wv_on_rad_off/run_doshallower05/';
w_area_dist_050 = w_dists_fn(rDir);
save('w_area_dists.mat','w_area_dist_050','-append')
clear w_area_dist_050

rDir='/project/rg312/wv_on_rad_off/run_doshallower75/';
w_area_dist_075 = w_dists_fn(rDir);
save('w_area_dists.mat','w_area_dist_075','-append')
clear w_area_dist_075

rDir='/project/rg312/wv_on_rad_off/run_doshallower10/';
w_area_dist_100 = w_dists_fn(rDir);
save('w_area_dists.mat','w_area_dist_100','-append')
clear w_area_dist_100
