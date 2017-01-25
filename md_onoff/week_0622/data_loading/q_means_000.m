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

load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/q_000_' num2str(year)  '.mat']);
q_000_tav(:,:,:,year) = mean(q_000,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_125/q_125_' num2str(year)  '.mat']);
q_125_tav(:,:,:,year) = mean(q_125,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_150/q_150_' num2str(year)  '.mat']);
q_150_tav(:,:,:,year) = mean(q_150,4);


end

q_000_tav = mean(q_000_tav,4);
q_125_tav = mean(q_125_tav,4);
q_150_tav = mean(q_150_tav,4);

q_ll_tav = cube2latlon(xc,yc,q_000_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_000_ns/q_000_timemean.mat','q_ll_tav');

q_ll_tav = cube2latlon(xc,yc,q_125_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_125/q_125_timemean.mat','q_ll_tav');

q_ll_tav = cube2latlon(xc,yc,q_150_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_150/q_150_timemean.mat','q_ll_tav');


