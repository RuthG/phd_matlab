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
%load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/radht_000_' num2str(year) '.mat']);
%radht_000_tav(:,:,:,year) = mean(radht_000,4);

%load(['/project/rg312/mat_files/snapshot_data_final/run_010/radht_010_' num2str(year)  '.mat']);
%radht_010_tav(:,:,:,year) = mean(radht_010,4);

%load(['/project/rg312/mat_files/snapshot_data_final/run_025/radht_025_' num2str(year)  '.mat']);
%radht_025_tav(:,:,:,year) = mean(radht_025,4);

%load(['/project/rg312/mat_files/snapshot_data_final/run_050/radht_050_' num2str(year)  '.mat']);
%radht_050_tav(:,:,:,year) = mean(radht_050,4);

%load(['/project/rg312/mat_files/snapshot_data_final/run_075/radht_075_' num2str(year)  '.mat']);
%radht_075_tav(:,:,:,year) = mean(radht_075,4);

%load(['/project/rg312/mat_files/snapshot_data_final/run_100/radht_100_' num2str(year)  '.mat']);
%radht_100_tav(:,:,:,year) = mean(radht_100,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_125/radht_125_' num2str(year)  '.mat']);
radht_125_tav(:,:,:,year) = mean(radht_125,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_150/radht_150_' num2str(year)  '.mat']);
radht_150_tav(:,:,:,year) = mean(radht_150,4);

end

%radht_000_tav = mean(radht_000_tav,4);
%radht_010_tav = mean(radht_010_tav,4);
%radht_025_tav = mean(radht_025_tav,4);
%radht_050_tav = mean(radht_050_tav,4);
%radht_075_tav = mean(radht_075_tav,4);
%radht_100_tav = mean(radht_100_tav,4);
radht_125_tav = mean(radht_125_tav,4);
radht_150_tav = mean(radht_150_tav,4);

%radht_ll_tav = cube2latlon(xc,yc,radht_000_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_000/radht_000_timemean.mat','radht_ll_tav');

%radht_ll_tav = cube2latlon(xc,yc,radht_010_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_010/radht_010_timemean.mat','radht_ll_tav');

%radht_ll_tav = cube2latlon(xc,yc,radht_025_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_025/radht_025_timemean.mat','radht_ll_tav');

%radht_ll_tav = cube2latlon(xc,yc,radht_050_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_050/radht_050_timemean.mat','radht_ll_tav');

%radht_ll_tav = cube2latlon(xc,yc,radht_075_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_075/radht_075_timemean.mat','radht_ll_tav');

%radht_ll_tav = cube2latlon(xc,yc,radht_100_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_100/radht_100_timemean.mat','radht_ll_tav');

radht_ll_tav = cube2latlon(xc,yc,radht_125_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_125/radht_125_timemean.mat','radht_ll_tav');

radht_ll_tav = cube2latlon(xc,yc,radht_150_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_150/radht_150_timemean.mat','radht_ll_tav');
