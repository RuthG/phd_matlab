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

load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/t_000_' num2str(year) '.mat']);
t_000_tav(:,:,:,year) = mean(t_000,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_125/t_125_' num2str(year) '.mat']);
t_125_tav(:,:,:,year) = mean(t_125,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_150/t_150_' num2str(year) '.mat']);
t_150_tav(:,:,:,year) = mean(t_150,4);

end

t_000_tav = mean(t_000_tav,4);
t_125_tav = mean(t_125_tav,4);
t_150_tav = mean(t_150_tav,4);


t_ll_tav = cube2latlon(xc,yc,t_000_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_000_ns/t_000_timemean.mat','t_ll_tav');


t_ll_tav = cube2latlon(xc,yc,t_125_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_125/t_125_timemean.mat','t_ll_tav');


t_ll_tav = cube2latlon(xc,yc,t_150_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_150/t_150_timemean.mat','t_ll_tav');

