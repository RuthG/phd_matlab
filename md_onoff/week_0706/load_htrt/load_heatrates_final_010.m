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
htrt_010 = zeros(192,32,25,360);
radht_010 = zeros(192,32,25,360);
difht_010 = zeros(192,32,25,360);
cnvht_010 = zeros(192,32,25,360);
cndht_010 = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdTdt'));
htrt_010(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_010(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_010(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_010(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_010(:,:,:,i) = snap(:,:,:,J);

end %nit loop


name=['/project/rg312/mat_files/snapshot_data_final/run_010/htrt_010_' num2str(j) '.mat'];
save(name,'htrt_010')

name=['/project/rg312/mat_files/snapshot_data_final/run_010/radht_010_' num2str(j) '.mat'];
save(name,'radht_010')

name=['/project/rg312/mat_files/snapshot_data_final/run_010/difht_010_' num2str(j) '.mat'];
save(name,'difht_010')

name=['/project/rg312/mat_files/snapshot_data_final/run_010/cnvht_010_' num2str(j) '.mat'];
save(name,'cnvht_010')

name=['/project/rg312/mat_files/snapshot_data_final/run_010/cndht_010_' num2str(j) '.mat'];
save(name,'cndht_010')

end  %j loop
