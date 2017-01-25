% choose directory, load grid
rDir = '/project/rg312/final_runs/run_100_rad_on_sens/';
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

trans_lw = zeros(192,32,25);
trans_wi = zeros(192,32,25);
trans_sw = zeros(192,32,25);



i=0
for nit = 172800:86400:259200;
i=i+1

rDir = '/project/rg312/final_runs/run_100_rad_on_sens/';
[dyn,iter,M]=rdmds([rDir,'radDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhTrLW'));
trans_lw = trans_lw + dyn(:,:,:,J)./2;
J=find(strcmp(fldList,'AtPhTrWI'));
trans_wi = trans_wi + dyn(:,:,:,J)./2;
J=find(strcmp(fldList,'AtPhTrSW'));
trans_sw = trans_sw + dyn(:,:,:,J)./2;
end


save('/project/rg312/mat_files/transmittances_final_rev.mat')


