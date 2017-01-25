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
load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/dvNdt_000_' num2str(year) '.mat']);
dvNdt_000_tav(:,:,:,year) = mean(dvNdt_000,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_010/dvNdt_010_' num2str(year)  '.mat']);
dvNdt_010_tav(:,:,:,year) = mean(dvNdt_010,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_025/dvNdt_025_' num2str(year)  '.mat']);
dvNdt_025_tav(:,:,:,year) = mean(dvNdt_025,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_050/dvNdt_050_' num2str(year)  '.mat']);
dvNdt_050_tav(:,:,:,year) = mean(dvNdt_050,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_075/dvNdt_075_' num2str(year)  '.mat']);
dvNdt_075_tav(:,:,:,year) = mean(dvNdt_075,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_100/dvNdt_100_' num2str(year)  '.mat']);
dvNdt_100_tav(:,:,:,year) = mean(dvNdt_100,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_125/dvNdt_125_' num2str(year)  '.mat']);
dvNdt_125_tav(:,:,:,year) = mean(dvNdt_125,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_150/dvNdt_150_' num2str(year)  '.mat']);
dvNdt_150_tav(:,:,:,year) = mean(dvNdt_150,4);

end

dvNdt_000_tav = mean(dvNdt_000_tav,4);
dvNdt_010_tav = mean(dvNdt_010_tav,4);
dvNdt_025_tav = mean(dvNdt_025_tav,4);
dvNdt_050_tav = mean(dvNdt_050_tav,4);
dvNdt_075_tav = mean(dvNdt_075_tav,4);
dvNdt_100_tav = mean(dvNdt_100_tav,4);
dvNdt_125_tav = mean(dvNdt_125_tav,4);
dvNdt_150_tav = mean(dvNdt_150_tav,4);

dvNdt_ll_tav = cube2latlon(xc,yc,dvNdt_000_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_000/dvNdt_000_timemean.mat','dvNdt_ll_tav');

dvNdt_ll_tav = cube2latlon(xc,yc,dvNdt_010_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_010/dvNdt_010_timemean.mat','dvNdt_ll_tav');

dvNdt_ll_tav = cube2latlon(xc,yc,dvNdt_025_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_025/dvNdt_025_timemean.mat','dvNdt_ll_tav');

dvNdt_ll_tav = cube2latlon(xc,yc,dvNdt_050_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_050/dvNdt_050_timemean.mat','dvNdt_ll_tav');

dvNdt_ll_tav = cube2latlon(xc,yc,dvNdt_075_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_075/dvNdt_075_timemean.mat','dvNdt_ll_tav');

dvNdt_ll_tav = cube2latlon(xc,yc,dvNdt_100_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_100/dvNdt_100_timemean.mat','dvNdt_ll_tav');

dvNdt_ll_tav = cube2latlon(xc,yc,dvNdt_125_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_125/dvNdt_125_timemean.mat','dvNdt_ll_tav');

dvNdt_ll_tav = cube2latlon(xc,yc,dvNdt_150_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_150/dvNdt_150_timemean.mat','dvNdt_ll_tav');
