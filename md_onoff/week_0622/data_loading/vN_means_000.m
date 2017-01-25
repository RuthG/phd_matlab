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

load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/vN_000_' num2str(year)  '.mat']);
vN_000_tav(:,:,:,year) = mean(vN_000,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_125/vN_125_' num2str(year)  '.mat']);
vN_125_tav(:,:,:,year) = mean(vN_125,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_150/vN_150_' num2str(year)  '.mat']);
vN_150_tav(:,:,:,year) = mean(vN_150,4);

end

vN_000_tav = mean(vN_000_tav,4);
vN_125_tav = mean(vN_125_tav,4);
vN_150_tav = mean(vN_150_tav,4);

vN_ll_tav = cube2latlon(xc,yc,vN_000_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_000_ns/vN_000_timemean.mat','vN_ll_tav');


vN_ll_tav = cube2latlon(xc,yc,vN_125_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_125/vN_125_timemean.mat','vN_ll_tav');


vN_ll_tav = cube2latlon(xc,yc,vN_150_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_150/vN_150_timemean.mat','vN_ll_tav');
