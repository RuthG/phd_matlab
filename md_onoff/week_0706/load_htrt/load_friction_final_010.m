%load in vtheta, v, theta



% choose directory, load grid
rDir='/project/rg312/final_runs/run_010_final/';
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%


for j=1:10
i=0
dudt_010 = zeros(192,32,25,360);
dvdt_010 = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdUdt'));
dudt_010(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdVdt'));
dvdt_010(:,:,:,i) = snap(:,:,:,J);


end %nit loop

[duEdt_010,dvNdt_010] = rotate_uv2uvEN(dudt_010,dvdt_010,AngleCS,AngleSN,Grid);

name=['/project/rg312/mat_files/snapshot_data_final/run_010/duEdt_010_' num2str(j) '.mat'];
save(name,'duEdt_010')

name=['/project/rg312/mat_files/snapshot_data_final/run_010/dvNdt_010_' num2str(j) '.mat'];
save(name,'dvNdt_010')


end  %j loop
