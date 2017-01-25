%load in vtheta, v, theta



% choose directory, load grid
rDir='/project/rg312/final_runs/run_050_final/';
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
htrt_050 = zeros(192,32,25,360);
radht_050 = zeros(192,32,25,360);
difht_050 = zeros(192,32,25,360);
cnvht_050 = zeros(192,32,25,360);
cndht_050 = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdTdt'));
htrt_050(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_050(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_050(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_050(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_050(:,:,:,i) = snap(:,:,:,J);

end %nit loop


name=['/project/rg312/mat_files/snapshot_data_final/run_050/htrt_050_' num2str(j) '.mat'];
save(name,'htrt_050')

name=['/project/rg312/mat_files/snapshot_data_final/run_050/radht_050_' num2str(j) '.mat'];
save(name,'radht_050')

name=['/project/rg312/mat_files/snapshot_data_final/run_050/difht_050_' num2str(j) '.mat'];
save(name,'difht_050')

name=['/project/rg312/mat_files/snapshot_data_final/run_050/cnvht_050_' num2str(j) '.mat'];
save(name,'cnvht_050')

name=['/project/rg312/mat_files/snapshot_data_final/run_050/cndht_050_' num2str(j) '.mat'];
save(name,'cndht_050')

end  %j loop
