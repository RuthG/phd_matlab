%load in vtheta, v, theta



% choose directory, load grid
rDir='/project/rg312/final_runs/run_000_final_noshallow/';
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
dudt_000 = zeros(192,32,25,360);
dvdt_000 = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdUdt'));
dudt_000(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdVdt'));
dvdt_000(:,:,:,i) = snap(:,:,:,J);


end %nit loop

[duEdt_000,dvNdt_000] = rotate_uv2uvEN(dudt_000,dvdt_000,AngleCS,AngleSN,Grid);

name=['/project/rg312/mat_files/snapshot_data_final/run_000_ns/duEdt_000_' num2str(j) '.mat'];
save(name,'duEdt_000')

name=['/project/rg312/mat_files/snapshot_data_final/run_000_ns/dvNdt_000_' num2str(j) '.mat'];
save(name,'dvNdt_000')


end  %j loop
