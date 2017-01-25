rDir='/project/rg312/final_runs/run_000_final_noshallow/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
xi=-179:2:180;
yi=-89:2:90;

for year = 1:10
year
load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/ph_000_' num2str(year)  '.mat']);
ph_000_tav(:,:,:,year) = mean(ph_000,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_010/ph_010_' num2str(year)  '.mat']);
ph_010_tav(:,:,:,year) = mean(ph_010,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_025/ph_025_' num2str(year)  '.mat']);
ph_025_tav(:,:,:,year) = mean(ph_025,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_050/ph_050_' num2str(year)  '.mat']);
ph_050_tav(:,:,:,year) = mean(ph_050,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_075/ph_075_' num2str(year)  '.mat']);
ph_075_tav(:,:,:,year) = mean(ph_075,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_100/ph_100_' num2str(year)  '.mat']);
ph_100_tav(:,:,:,year) = mean(ph_100,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_125/ph_125_' num2str(year)  '.mat']);
ph_125_tav(:,:,:,year) = mean(ph_125,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_150/ph_150_' num2str(year)  '.mat']);
ph_150_tav(:,:,:,year) = mean(ph_150,4);

end

ph_000_tav = mean(ph_000_tav,4);
ph_010_tav = mean(ph_010_tav,4);
ph_025_tav = mean(ph_025_tav,4);
ph_050_tav = mean(ph_050_tav,4);
ph_075_tav = mean(ph_075_tav,4);
ph_100_tav = mean(ph_100_tav,4);
ph_125_tav = mean(ph_125_tav,4);
ph_150_tav = mean(ph_150_tav,4);

ph_ll_tav = cube2latlon(xc,yc,ph_000_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_000_ns/ph_000_timemean.mat','ph_ll_tav');

ph_ll_tav = cube2latlon(xc,yc,ph_010_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_010/ph_010_timemean.mat','ph_ll_tav');

ph_ll_tav = cube2latlon(xc,yc,ph_025_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_025/ph_025_timemean.mat','ph_ll_tav');

ph_ll_tav = cube2latlon(xc,yc,ph_050_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_050/ph_050_timemean.mat','ph_ll_tav');

ph_ll_tav = cube2latlon(xc,yc,ph_075_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_075/ph_075_timemean.mat','ph_ll_tav');

ph_ll_tav = cube2latlon(xc,yc,ph_100_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_100/ph_100_timemean.mat','ph_ll_tav');

ph_ll_tav = cube2latlon(xc,yc,ph_125_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_125/ph_125_timemean.mat','ph_ll_tav');

ph_ll_tav = cube2latlon(xc,yc,ph_150_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_150/ph_150_timemean.mat','ph_ll_tav');
