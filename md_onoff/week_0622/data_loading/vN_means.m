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

load(['/project/rg312/mat_files/snapshot_data_final/run_000/vN_000_' num2str(year)  '.mat']);
vN_000_tav(:,:,:,year) = mean(vN_000,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_010/vN_010_' num2str(year)  '.mat']);
vN_010_tav(:,:,:,year) = mean(vN_010,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_025/vN_025_' num2str(year)  '.mat']);
vN_025_tav(:,:,:,year) = mean(vN_025,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_050/vN_050_' num2str(year)  '.mat']);
vN_050_tav(:,:,:,year) = mean(vN_050,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_075/vN_075_' num2str(year)  '.mat']);
vN_075_tav(:,:,:,year) = mean(vN_075,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_100/vN_100_' num2str(year)  '.mat']);
vN_100_tav(:,:,:,year) = mean(vN_100,4);

end

vN_000_tav = mean(vN_000_tav,4);
vN_010_tav = mean(vN_010_tav,4);
vN_025_tav = mean(vN_025_tav,4);
vN_050_tav = mean(vN_050_tav,4);
vN_075_tav = mean(vN_075_tav,4);
vN_100_tav = mean(vN_100_tav,4);

vN_ll_tav = cube2latlon(xc,yc,vN_000_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_000/vN_000_timemean.mat','vN_ll_tav');

vN_ll_tav = cube2latlon(xc,yc,vN_010_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_010/vN_010_timemean.mat','vN_ll_tav');

vN_ll_tav = cube2latlon(xc,yc,vN_025_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_025/vN_025_timemean.mat','vN_ll_tav');

vN_ll_tav = cube2latlon(xc,yc,vN_050_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_050/vN_050_timemean.mat','vN_ll_tav');

vN_ll_tav = cube2latlon(xc,yc,vN_075_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_075/vN_075_timemean.mat','vN_ll_tav');

vN_ll_tav = cube2latlon(xc,yc,vN_100_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_100/vN_100_timemean.mat','vN_ll_tav');


