%load('/project/rg312/mat_files/snapshot_data_final/run_100/ph_100_5.mat')

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
yi=-89:2:89;
xi = -179:2:179;

%ph_ll = squeeze(cube2latlon(xc,yc,ph_100,xi,yi));

nit = 950640;

rDir='/project/MITgcm/MITgcm_150518/verification/atm_gray_ruth/run/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'PHIHYDcR'));
phcr = dyn(:,:,:,J);
phcr_ll = squeeze(cube2latlon(xc,yc,phcr,xi,yi));

nit = 172800;
rDir='/project/rg312/final_runs/run_100_final/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'PHIHYD  '));
ph = dyn(:,:,:,J);
ph_ll = squeeze(cube2latlon(xc,yc,ph,xi,yi));

