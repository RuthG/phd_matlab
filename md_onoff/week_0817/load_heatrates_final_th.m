%load in vtheta, v, theta



% choose directory, load grid
rDir='/project/rg312/final_runs/run_050_final_tropheat/';
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


for j=10
i=0
htrt_th = zeros(192,32,25,360);
radht_th = zeros(192,32,25,360);
difht_th = zeros(192,32,25,360);
cnvht_th = zeros(192,32,25,360);
cndht_th = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdTdt'));
htrt_th(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_th(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_th(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_th(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_th(:,:,:,i) = snap(:,:,:,J);

end %nit loop


name=['/project/rg312/mat_files/snapshot_data_final/run_th/htrt_th_' num2str(j) '.mat'];
save(name,'htrt_th')

name=['/project/rg312/mat_files/snapshot_data_final/run_th/radht_th_' num2str(j) '.mat'];
save(name,'radht_th')

name=['/project/rg312/mat_files/snapshot_data_final/run_th/difht_th_' num2str(j) '.mat'];
save(name,'difht_th')

name=['/project/rg312/mat_files/snapshot_data_final/run_th/cnvht_th_' num2str(j) '.mat'];
save(name,'cnvht_th')

name=['/project/rg312/mat_files/snapshot_data_final/run_th/cndht_th_' num2str(j) '.mat'];
save(name,'cndht_th')

end  %j loop
