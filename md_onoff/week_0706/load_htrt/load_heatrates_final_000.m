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
htrt_000 = zeros(192,32,25,360);
radht_000 = zeros(192,32,25,360);
difht_000 = zeros(192,32,25,360);
cnvht_000 = zeros(192,32,25,360);
cndht_000 = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdTdt'));
htrt_000(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_000(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_000(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_000(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_000(:,:,:,i) = snap(:,:,:,J);

end %nit loop


name=['/project/rg312/mat_files/snapshot_data_final/run_000_ns/htrt_000_' num2str(j) '.mat'];
save(name,'htrt_000')

name=['/project/rg312/mat_files/snapshot_data_final/run_000_ns/radht_000_' num2str(j) '.mat'];
save(name,'radht_000')

name=['/project/rg312/mat_files/snapshot_data_final/run_000_ns/difht_000_' num2str(j) '.mat'];
save(name,'difht_000')

name=['/project/rg312/mat_files/snapshot_data_final/run_000_ns/cnvht_000_' num2str(j) '.mat'];
save(name,'cnvht_000')

name=['/project/rg312/mat_files/snapshot_data_final/run_000_ns/cndht_000_' num2str(j) '.mat'];
save(name,'cndht_000')

end  %j loop
