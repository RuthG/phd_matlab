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
%load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/difht_000_' num2str(year) '.mat']);
%difht_000_tav(:,:,:,year) = mean(difht_000,4);

%load(['/project/rg312/mat_files/snapshot_data_final/run_010/difht_010_' num2str(year)  '.mat']);
%difht_010_tav(:,:,:,year) = mean(difht_010,4);

%load(['/project/rg312/mat_files/snapshot_data_final/run_025/difht_025_' num2str(year)  '.mat']);
%difht_025_tav(:,:,:,year) = mean(difht_025,4);

%load(['/project/rg312/mat_files/snapshot_data_final/run_050/difht_050_' num2str(year)  '.mat']);
%difht_050_tav(:,:,:,year) = mean(difht_050,4);

%load(['/project/rg312/mat_files/snapshot_data_final/run_075/difht_075_' num2str(year)  '.mat']);
%difht_075_tav(:,:,:,year) = mean(difht_075,4);

%load(['/project/rg312/mat_files/snapshot_data_final/run_100/difht_100_' num2str(year)  '.mat']);
%difht_100_tav(:,:,:,year) = mean(difht_100,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_125/difht_125_' num2str(year)  '.mat']);
difht_125_tav(:,:,:,year) = mean(difht_125,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_150/difht_150_' num2str(year)  '.mat']);
difht_150_tav(:,:,:,year) = mean(difht_150,4);

end

%difht_000_tav = mean(difht_000_tav,4);
%difht_010_tav = mean(difht_010_tav,4);
%difht_025_tav = mean(difht_025_tav,4);
%difht_050_tav = mean(difht_050_tav,4);
%difht_075_tav = mean(difht_075_tav,4);
%difht_100_tav = mean(difht_100_tav,4);
difht_125_tav = mean(difht_125_tav,4);
difht_150_tav = mean(difht_150_tav,4);

%difht_ll_tav = cube2latlon(xc,yc,difht_000_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_000/difht_000_timemean.mat','difht_ll_tav');

%difht_ll_tav = cube2latlon(xc,yc,difht_010_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_010/difht_010_timemean.mat','difht_ll_tav');

%difht_ll_tav = cube2latlon(xc,yc,difht_025_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_025/difht_025_timemean.mat','difht_ll_tav');

%difht_ll_tav = cube2latlon(xc,yc,difht_050_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_050/difht_050_timemean.mat','difht_ll_tav');

%difht_ll_tav = cube2latlon(xc,yc,difht_075_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_075/difht_075_timemean.mat','difht_ll_tav');

%difht_ll_tav = cube2latlon(xc,yc,difht_100_tav,xi,yi);
%save('/project/rg312/mat_files/snapshot_data_final/run_100/difht_100_timemean.mat','difht_ll_tav');

difht_ll_tav = cube2latlon(xc,yc,difht_125_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_125/difht_125_timemean.mat','difht_ll_tav');

difht_ll_tav = cube2latlon(xc,yc,difht_150_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_150/difht_150_timemean.mat','difht_ll_tav');
