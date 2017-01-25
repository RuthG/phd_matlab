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
%load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/cndht_000_' num2str(year) '.mat']);
%cndht_000_tav(:,:,:,year) = mean(cndht_000,4);

%load(['/project/rg312/mat_files/snapshot_data_final/run_010/cndht_010_' num2str(year)  '.mat']);
%cndht_010_tav(:,:,:,year) = mean(cndht_010,4);

%load(['/project/rg312/mat_files/snapshot_data_final/run_025/cndht_025_' num2str(year)  '.mat']);
%cndht_025_tav(:,:,:,year) = mean(cndht_025,4);

%load(['/project/rg312/mat_files/snapshot_data_final/run_050/cndht_050_' num2str(year)  '.mat']);
%cndht_050_tav(:,:,:,year) = mean(cndht_050,4);

%load(['/project/rg312/mat_files/snapshot_data_final/run_075/cndht_075_' num2str(year)  '.mat']);
%cndht_075_tav(:,:,:,year) = mean(cndht_075,4);

%load(['/project/rg312/mat_files/snapshot_data_final/run_100/cndht_100_' num2str(year)  '.mat']);
%cndht_100_tav(:,:,:,year) = mean(cndht_100,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_125/cndht_125_' num2str(year)  '.mat']);
cndht_125_tav(:,:,:,year) = mean(cndht_125,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_150/cndht_150_' num2str(year)  '.mat']);
cndht_150_tav(:,:,:,year) = mean(cndht_150,4);

end

%cndht_000_tav = mean(cndht_000_tav,4);
%cndht_010_tav = mean(cndht_010_tav,4);
%cndht_025_tav = mean(cndht_025_tav,4);
%cndht_050_tav = mean(cndht_050_tav,4);
%cndht_075_tav = mean(cndht_075_tav,4);
%cndht_100_tav = mean(cndht_100_tav,4);
cndht_125_tav = mean(cndht_125_tav,4);
cndht_150_tav = mean(cndht_150_tav,4);

%cndht_ll_tav = cube2latlon(xc,yc,cndht_000_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_000/cndht_000_timemean.mat','cndht_ll_tav');

%cndht_ll_tav = cube2latlon(xc,yc,cndht_010_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_010/cndht_010_timemean.mat','cndht_ll_tav');

%cndht_ll_tav = cube2latlon(xc,yc,cndht_025_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_025/cndht_025_timemean.mat','cndht_ll_tav');

%cndht_ll_tav = cube2latlon(xc,yc,cndht_050_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_050/cndht_050_timemean.mat','cndht_ll_tav');

%cndht_ll_tav = cube2latlon(xc,yc,cndht_075_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_075/cndht_075_timemean.mat','cndht_ll_tav');

%cndht_ll_tav = cube2latlon(xc,yc,cndht_100_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_100/cndht_100_timemean.mat','cndht_ll_tav');

cndht_ll_tav = cube2latlon(xc,yc,cndht_125_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_125/cndht_125_timemean.mat','cndht_ll_tav');

cndht_ll_tav = cube2latlon(xc,yc,cndht_150_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_150/cndht_150_timemean.mat','cndht_ll_tav');
