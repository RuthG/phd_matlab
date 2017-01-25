

rDir = '/project/rg312/final_runs/run_050_final_tropheat/';
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

name=['/project/rg312/mat_files/snapshot_data_final/run_th/ph_adj_th_' num2str(10) '.mat'];
load(name,'ph_adj_th');
ph_adj_th_ll = cube2latlon(xc,yc,ph_adj_th,xi,yi);

nit = 950400;

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'PHIHYDcR'));
phcr = dyn(:,:,:,J);
phcr_ll = cube2latlon(xc,yc,phcr,xi,yi);
