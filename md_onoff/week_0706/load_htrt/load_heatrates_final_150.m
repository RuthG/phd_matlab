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
htrt_150 = zeros(192,32,25,360);
radht_150 = zeros(192,32,25,360);
difht_150 = zeros(192,32,25,360);
cnvht_150 = zeros(192,32,25,360);
cndht_150 = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdTdt'));
htrt_150(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_150(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_150(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_150(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_150(:,:,:,i) = snap(:,:,:,J);

end %nit loop


name=['/project/rg312/mat_files/snapshot_data_final/run_150/htrt_150_' num2str(j) '.mat'];
save(name,'htrt_150')

name=['/project/rg312/mat_files/snapshot_data_final/run_150/radht_150_' num2str(j) '.mat'];
save(name,'radht_150')

name=['/project/rg312/mat_files/snapshot_data_final/run_150/difht_150_' num2str(j) '.mat'];
save(name,'difht_150')

name=['/project/rg312/mat_files/snapshot_data_final/run_150/cnvht_150_' num2str(j) '.mat'];
save(name,'cnvht_150')

name=['/project/rg312/mat_files/snapshot_data_final/run_150/cndht_150_' num2str(j) '.mat'];
save(name,'cndht_150')

end  %j loop
