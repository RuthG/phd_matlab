%load in q, t, ph and compute H for the rad on run at levels 860hPa and 300hPa poleward of 30 degrees

rDir='/project/rg312/final_runs/run_100_rad_on/';
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
ny=90;
xi=-179:2:179;yi=-89:2:90;
L = 2.500e6;
cp = 287.04./(2./7.);

H_ll_860_n = zeros(180,30,3600);
H_ll_860_s = zeros(180,30,3600);
H_ll_300_n = zeros(180,30,3600);
H_ll_300_s = zeros(180,30,3600);

for i=1:10
i

load(['/project/rg312/mat_files/snapshot_data_final/run_100_ro/t_100_ro_' num2str(i) '.mat'])
load(['/project/rg312/mat_files/snapshot_data_final/run_100_ro/q_100_ro_' num2str(i) '.mat'])
load(['/project/rg312/mat_files/snapshot_data_final/run_100_ro/ph_adj_100_ro_' num2str(i) '.mat'])

H = cp.*t_100 + L.*q_100 + ph_adj_100;

H_ll = cube2latlon(xc,yc,H,xi,yi);
H_ll_860_n(:,:, i.*360-359:i.*360) = squeeze(H_ll(:,61:90,4,:));
H_ll_860_s(:,:, i.*360-359:i.*360) = squeeze(H_ll(:,1:30,4,:));
H_ll_300_n(:,:, i.*360-359:i.*360) = squeeze(H_ll(:,61:90,18,:));
H_ll_300_s(:,:, i.*360-359:i.*360) = squeeze(H_ll(:,1:30,18,:));

end

save('/project/rg312/gabriele/H_ll.mat', 'H_ll_860_n', 'H_ll_860_s', 'H_ll_300_n', 'H_ll_300_s')
