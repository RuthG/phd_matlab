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
%load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/cnvht_000_' num2str(year) '.mat']);
%cnvht_000_tav(:,:,:,year) = mean(cnvht_000,4);

%load(['/project/rg312/mat_files/snapshot_data_final/run_010/cnvht_010_' num2str(year)  '.mat']);
%cnvht_010_tav(:,:,:,year) = mean(cnvht_010,4);

%load(['/project/rg312/mat_files/snapshot_data_final/run_025/cnvht_025_' num2str(year)  '.mat']);
%cnvht_025_tav(:,:,:,year) = mean(cnvht_025,4);

%load(['/project/rg312/mat_files/snapshot_data_final/run_050/cnvht_050_' num2str(year)  '.mat']);
%cnvht_050_tav(:,:,:,year) = mean(cnvht_050,4);

%load(['/project/rg312/mat_files/snapshot_data_final/run_075/cnvht_075_' num2str(year)  '.mat']);
%cnvht_075_tav(:,:,:,year) = mean(cnvht_075,4);

%load(['/project/rg312/mat_files/snapshot_data_final/run_100/cnvht_100_' num2str(year)  '.mat']);
%cnvht_100_tav(:,:,:,year) = mean(cnvht_100,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_125/cnvht_125_' num2str(year)  '.mat']);
cnvht_125_tav(:,:,:,year) = mean(cnvht_125,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_150/cnvht_150_' num2str(year)  '.mat']);
cnvht_150_tav(:,:,:,year) = mean(cnvht_150,4);

end

%cnvht_000_tav = mean(cnvht_000_tav,4);
%cnvht_010_tav = mean(cnvht_010_tav,4);
%cnvht_025_tav = mean(cnvht_025_tav,4);
%cnvht_050_tav = mean(cnvht_050_tav,4);
%cnvht_075_tav = mean(cnvht_075_tav,4);
%cnvht_100_tav = mean(cnvht_100_tav,4);
cnvht_125_tav = mean(cnvht_125_tav,4);
cnvht_150_tav = mean(cnvht_150_tav,4);

%cnvht_ll_tav = cube2latlon(xc,yc,cnvht_000_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_000/cnvht_000_timemean.mat','cnvht_ll_tav');

%cnvht_ll_tav = cube2latlon(xc,yc,cnvht_010_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_010/cnvht_010_timemean.mat','cnvht_ll_tav');

%cnvht_ll_tav = cube2latlon(xc,yc,cnvht_025_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_025/cnvht_025_timemean.mat','cnvht_ll_tav');

%cnvht_ll_tav = cube2latlon(xc,yc,cnvht_050_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_050/cnvht_050_timemean.mat','cnvht_ll_tav');

%cnvht_ll_tav = cube2latlon(xc,yc,cnvht_075_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_075/cnvht_075_timemean.mat','cnvht_ll_tav');

%cnvht_ll_tav = cube2latlon(xc,yc,cnvht_100_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_100/cnvht_100_timemean.mat','cnvht_ll_tav');

cnvht_ll_tav = cube2latlon(xc,yc,cnvht_125_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_125/cnvht_125_timemean.mat','cnvht_ll_tav');

cnvht_ll_tav = cube2latlon(xc,yc,cnvht_150_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_150/cnvht_150_timemean.mat','cnvht_ll_tav');
