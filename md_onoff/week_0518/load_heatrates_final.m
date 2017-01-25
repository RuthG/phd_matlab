%load in vtheta, v, theta



% choose directory, load grid
rDir='/project/rg312/final_runs/run_100_final/';
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
htrt_100 = zeros(192,32,25,360);
radht_100 = zeros(192,32,25,360);
difht_100 = zeros(192,32,25,360);
cnvht_100 = zeros(192,32,25,360);
cndht_100 = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdTdt'));
htrt_100(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_100(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_100(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_100(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_100(:,:,:,i) = snap(:,:,:,J);

end %nit loop


name=['/project/rg312/mat_files/snapshot_data_final/run_100/htrt_100_' num2str(j) '.mat'];
save(name,'htrt_100')

name=['/project/rg312/mat_files/snapshot_data_final/run_100/radht_100_' num2str(j) '.mat'];
save(name,'radht_100')

name=['/project/rg312/mat_files/snapshot_data_final/run_100/difht_100_' num2str(j) '.mat'];
save(name,'difht_100')

name=['/project/rg312/mat_files/snapshot_data_final/run_100/cnvht_100_' num2str(j) '.mat'];
save(name,'cnvht_100')

name=['/project/rg312/mat_files/snapshot_data_final/run_100/cndht_100_' num2str(j) '.mat'];
save(name,'cndht_100')

end  %j loop
