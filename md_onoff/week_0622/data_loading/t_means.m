rDir='/project/rg312/final_runs/run_000_final/';
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

load(['/project/rg312/mat_files/snapshot_data_final/run_000/t_000_' num2str(year) '.mat']);
t_000_tav(:,:,:,year) = mean(t_000,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_010/t_010_' num2str(year)  '.mat']);
t_010_tav(:,:,:,year) = mean(t_010,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_025/t_025_' num2str(year)  '.mat']);
t_025_tav(:,:,:,year) = mean(t_025,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_050/t_050_' num2str(year)  '.mat']);
t_050_tav(:,:,:,year) = mean(t_050,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_075/t_075_' num2str(year)  '.mat']);
t_075_tav(:,:,:,year) = mean(t_075,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_100/t_100_' num2str(year)  '.mat']);
t_100_tav(:,:,:,year) = mean(t_100,4);

end

t_000_tav = mean(t_000_tav,4);
t_010_tav = mean(t_010_tav,4);
t_025_tav = mean(t_025_tav,4);
t_050_tav = mean(t_050_tav,4);
t_075_tav = mean(t_075_tav,4);
t_100_tav = mean(t_100_tav,4);

t_ll_tav = cube2latlon(xc,yc,t_000_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_000/t_000_timemean.mat','t_ll_tav');

t_ll_tav = cube2latlon(xc,yc,t_010_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_010/t_010_timemean.mat','t_ll_tav');

t_ll_tav = cube2latlon(xc,yc,t_025_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_025/t_025_timemean.mat','t_ll_tav');

t_ll_tav = cube2latlon(xc,yc,t_050_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_050/t_050_timemean.mat','t_ll_tav');

t_ll_tav = cube2latlon(xc,yc,t_075_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_075/t_075_timemean.mat','t_ll_tav');

t_ll_tav = cube2latlon(xc,yc,t_100_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_100/t_100_timemean.mat','t_ll_tav');


