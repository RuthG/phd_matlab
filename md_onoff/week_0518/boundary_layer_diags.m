% choose directory, load grid
rDir='/project/MITgcm/MITgcm_150518/verification/atm_gray_ruth/run/';
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
xi=-179:2:180;yi=-89:2:90;


zpbl_000_tav = 0;
zpbl_100_tav = 0;
rich_000_tav = 0;
rich_100_tav = 0;

for j=1:10

load(['/project/rg312/mat_files/snapshot_data_final/run_000/zpbl_000_' num2str(j) '.mat'])
zpbl_000_tav = zpbl_000_tav + mean(zpbl_000,3)./10;

load(['/project/rg312/mat_files/snapshot_data_final/run_000/rich_000_' num2str(j) '.mat'])
rich_000_tav = rich_000_tav + mean(rich_000,4)./10;


load(['/project/rg312/mat_files/snapshot_data_final/run_100/zpbl_100_' num2str(j) '.mat'])
zpbl_100_tav = zpbl_100_tav + mean(zpbl_100,3)./10;

load(['/project/rg312/mat_files/snapshot_data_final/run_100/rich_100_' num2str(j) '.mat'])
rich_100_tav = rich_100_tav + mean(rich_100,4)./10;

end

zpbl_000_ll = cube2latlon(xc,yc,zpbl_000_tav,xi,yi);
zpbl_100_ll = cube2latlon(xc,yc,zpbl_100_tav,xi,yi);

rich_000_ll = cube2latlon(xc,yc,rich_000_tav,xi,yi);
rich_100_ll = cube2latlon(xc,yc,rich_100_tav,xi,yi);
