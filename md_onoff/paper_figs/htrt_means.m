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
load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/htrt_000_' num2str(year) '.mat']);
htrt_000_tav(:,:,:,year) = mean(htrt_000,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_010/htrt_010_' num2str(year)  '.mat']);
htrt_010_tav(:,:,:,year) = mean(htrt_010,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_025/htrt_025_' num2str(year)  '.mat']);
htrt_025_tav(:,:,:,year) = mean(htrt_025,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_050/htrt_050_' num2str(year)  '.mat']);
htrt_050_tav(:,:,:,year) = mean(htrt_050,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_075/htrt_075_' num2str(year)  '.mat']);
htrt_075_tav(:,:,:,year) = mean(htrt_075,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_100/htrt_100_' num2str(year)  '.mat']);
htrt_100_tav(:,:,:,year) = mean(htrt_100,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_125/htrt_125_' num2str(year)  '.mat']);
htrt_125_tav(:,:,:,year) = mean(htrt_125,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_150/htrt_150_' num2str(year)  '.mat']);
htrt_150_tav(:,:,:,year) = mean(htrt_150,4);

end

htrt_000_tav = mean(htrt_000_tav,4);
htrt_010_tav = mean(htrt_010_tav,4);
htrt_025_tav = mean(htrt_025_tav,4);
htrt_050_tav = mean(htrt_050_tav,4);
htrt_075_tav = mean(htrt_075_tav,4);
htrt_100_tav = mean(htrt_100_tav,4);
htrt_125_tav = mean(htrt_125_tav,4);
htrt_150_tav = mean(htrt_150_tav,4);

htrt_ll_tav = cube2latlon(xc,yc,htrt_000_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_000/htrt_000_timemean.mat','htrt_ll_tav');

htrt_ll_tav = cube2latlon(xc,yc,htrt_010_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_010/htrt_010_timemean.mat','htrt_ll_tav');

htrt_ll_tav = cube2latlon(xc,yc,htrt_025_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_025/htrt_025_timemean.mat','htrt_ll_tav');

htrt_ll_tav = cube2latlon(xc,yc,htrt_050_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_050/htrt_050_timemean.mat','htrt_ll_tav');

htrt_ll_tav = cube2latlon(xc,yc,htrt_075_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_075/htrt_075_timemean.mat','htrt_ll_tav');

htrt_ll_tav = cube2latlon(xc,yc,htrt_100_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_100/htrt_100_timemean.mat','htrt_ll_tav');

htrt_ll_tav = cube2latlon(xc,yc,htrt_125_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_125/htrt_125_timemean.mat','htrt_ll_tav');

htrt_ll_tav = cube2latlon(xc,yc,htrt_150_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_150/htrt_150_timemean.mat','htrt_ll_tav');
