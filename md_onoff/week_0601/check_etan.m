

% choose directory, load grid
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
yi = -89:2:89;
xi=-179:2:179;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%


j=1
i=0

eta_100 = zeros(192,32,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

eta_100(:,:,i)=rdmds([rDir,'Eta'],nit);

end %nit loop

eta_100_tav = mean(eta_100,3);

eta_100_ll = cube2latlon(xc,yc,eta_100_tav,xi,yi);

name=['/project/rg312/mat_files/snapshot_data_final/run_100/ph_100_1.mat'];
load(name)


ph_100_tav = mean(ph_100,3);

ph_100_ll = cube2latlon(xc,yc,ph_100_tav,xi,yi);

