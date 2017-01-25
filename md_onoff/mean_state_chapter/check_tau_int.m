%check the surface stress integrates to zero globally

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

load('/project/rg312/mat_files/chapter2_variables/mombudg_tav_000.mat','tauE')
tauE_ll=cube2latlon(xc,yc,tauE,xi,yi);
tau_mean_000 = sum(sum(tauE.*ar))./sum(sum(ar))

load('/project/rg312/mat_files/chapter2_variables/mombudg_tav_050.mat','tauE')
tauE_ll=cube2latlon(xc,yc,tauE,xi,yi);
tau_mean_050 = sum(sum(tauE.*ar))./sum(sum(ar))


load('/project/rg312/mat_files/chapter2_variables/mombudg_tav_100.mat','tauE')
tauE_ll=cube2latlon(xc,yc,tauE,xi,yi);
tau_mean_100 = sum(sum(tauE.*ar))./sum(sum(ar))

