%check u and v look ok in wet run

% choose directory, load grid
rDir='/project/rg312/final_runs/run_100_final/';
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
yi = -89:2:89;
xi=-179:2:179;

name=['/project/rg312/mat_files/snapshot_data_final/run_100/uE_100_10.mat'];
load(name,'uE_100')

name=['/project/rg312/mat_files/snapshot_data_final/run_100/vN_100_10.mat'];
load(name,'vN_100')

uE_100_tav = mean(uE_100,4);
vN_100_tav = mean(vN_100,4);

uE_ll = squeeze(cube2latlon(xc,yc,uE_100_tav,xi,yi));
vN_ll = squeeze(cube2latlon(xc,yc,vN_100_tav,xi,yi));
