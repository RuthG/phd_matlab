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

load(['/project/rg312/mat_files/snapshot_data_final/run_000/q_000_' num2str(year)  '.mat']);
q_000_tav(:,:,:,year) = mean(q_000,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_010/q_010_' num2str(year)  '.mat']);
q_010_tav(:,:,:,year) = mean(q_010,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_025/q_025_' num2str(year)  '.mat']);
q_025_tav(:,:,:,year) = mean(q_025,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_050/q_050_' num2str(year)  '.mat']);
q_050_tav(:,:,:,year) = mean(q_050,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_075/q_075_' num2str(year)  '.mat']);
q_075_tav(:,:,:,year) = mean(q_075,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_100/q_100_' num2str(year)  '.mat']);
q_100_tav(:,:,:,year) = mean(q_100,4);

end

q_000_tav = mean(q_000_tav,4);
q_010_tav = mean(q_010_tav,4);
q_025_tav = mean(q_025_tav,4);
q_050_tav = mean(q_050_tav,4);
q_075_tav = mean(q_075_tav,4);
q_100_tav = mean(q_100_tav,4);

q_ll_tav = cube2latlon(xc,yc,q_000_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_000/q_000_timemean.mat','q_ll_tav');

q_ll_tav = cube2latlon(xc,yc,q_010_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_010/q_010_timemean.mat','q_ll_tav');

q_ll_tav = cube2latlon(xc,yc,q_025_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_025/q_025_timemean.mat','q_ll_tav');

q_ll_tav = cube2latlon(xc,yc,q_050_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_050/q_050_timemean.mat','q_ll_tav');

q_ll_tav = cube2latlon(xc,yc,q_075_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_075/q_075_timemean.mat','q_ll_tav');

q_ll_tav = cube2latlon(xc,yc,q_100_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_100/q_100_timemean.mat','q_ll_tav');


