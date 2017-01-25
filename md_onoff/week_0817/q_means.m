rDir='/project/rg312/final_runs/run_050_final_tropheat/';
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

load(['/project/rg312/mat_files/snapshot_data_final/run_th/q_th_' num2str(year)  '.mat']);
q_th_tav(:,:,:,year) = mean(q_th,4);

end

q_th_tav = mean(q_th_tav,4);

q_ll_tav = cube2latlon(xc,yc,q_th_tav,xi,yi);
save('/project/rg312/mat_files/snapshot_data_final/run_th/q_th_timemean.mat','q_ll_tav');



