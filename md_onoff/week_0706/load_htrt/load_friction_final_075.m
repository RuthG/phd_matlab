%load in vtheta, v, theta



% choose directory, load grid
rDir='/project/rg312/final_runs/run_075_final/';
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
dudt_075 = zeros(192,32,25,360);
dvdt_075 = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdUdt'));
dudt_075(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdVdt'));
dvdt_075(:,:,:,i) = snap(:,:,:,J);


end %nit loop

[duEdt_075,dvNdt_075] = rotate_uv2uvEN(dudt_075,dvdt_075,AngleCS,AngleSN,Grid);

name=['/project/rg312/mat_files/snapshot_data_final/run_075/duEdt_075_' num2str(j) '.mat'];
save(name,'duEdt_075')

name=['/project/rg312/mat_files/snapshot_data_final/run_075/dvNdt_075_' num2str(j) '.mat'];
save(name,'dvNdt_075')


end  %j loop