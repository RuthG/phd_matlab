%load v as for H

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

vN_ll_860_n = zeros(180,30,3600);
vN_ll_860_s = zeros(180,30,3600);
vN_ll_300_n = zeros(180,30,3600);
vN_ll_300_s = zeros(180,30,3600);

for i=1:10
i

load(['/project/rg312/mat_files/snapshot_data_final/run_100_ro/vN_100_ro_' num2str(i) '.mat'])

vN_ll = cube2latlon(xc,yc,vN_100,xi,yi);
vN_ll_860_n(:,:, i.*360-359:i.*360) = squeeze(vN_ll(:,61:90,4,:));
vN_ll_860_s(:,:, i.*360-359:i.*360) = squeeze(vN_ll(:,1:30,4,:));
vN_ll_300_n(:,:, i.*360-359:i.*360) = squeeze(vN_ll(:,61:90,18,:));
vN_ll_300_s(:,:, i.*360-359:i.*360) = squeeze(vN_ll(:,1:30,18,:));

end

save('/project/rg312/gabriele/vN_ll.mat', 'vN_ll_860_n', 'vN_ll_860_s', 'vN_ll_300_n', 'vN_ll_300_s')
