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
htrt_075 = zeros(192,32,25,360);
radht_075 = zeros(192,32,25,360);
difht_075 = zeros(192,32,25,360);
cnvht_075 = zeros(192,32,25,360);
cndht_075 = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdTdt'));
htrt_075(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_075(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_075(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_075(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_075(:,:,:,i) = snap(:,:,:,J);

end %nit loop


name=['/project/rg312/mat_files/snapshot_data_final/run_075/htrt_075_' num2str(j) '.mat'];
save(name,'htrt_075')

name=['/project/rg312/mat_files/snapshot_data_final/run_075/radht_075_' num2str(j) '.mat'];
save(name,'radht_075')

name=['/project/rg312/mat_files/snapshot_data_final/run_075/difht_075_' num2str(j) '.mat'];
save(name,'difht_075')

name=['/project/rg312/mat_files/snapshot_data_final/run_075/cnvht_075_' num2str(j) '.mat'];
save(name,'cnvht_075')

name=['/project/rg312/mat_files/snapshot_data_final/run_075/cndht_075_' num2str(j) '.mat'];
save(name,'cndht_075')

end  %j loop
