%load in vtheta, v, theta



% choose directory, load grid
rDir='/project/rg312/final_runs/run_150_final/';
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
dudt_150 = zeros(192,32,25,360);
dvdt_150 = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdUdt'));
dudt_150(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdVdt'));
dvdt_150(:,:,:,i) = snap(:,:,:,J);


end %nit loop

[duEdt_150,dvNdt_150] = rotate_uv2uvEN(dudt_150,dvdt_150,AngleCS,AngleSN,Grid);

name=['/project/rg312/mat_files/snapshot_data_final/run_150/duEdt_150_' num2str(j) '.mat'];
save(name,'duEdt_150')

name=['/project/rg312/mat_files/snapshot_data_final/run_150/dvNdt_150_' num2str(j) '.mat'];
save(name,'dvNdt_150')


end  %j loop
