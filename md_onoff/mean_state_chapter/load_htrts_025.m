%load up u, v theta, and q for the rad on run and save time means somewhere obvious!

% choose directory, load grid
rDir='/project/rg312/final_runs/run_025_final/';
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
htrt = zeros(192,32,25,360);
difht = zeros(192,32,25,360);
cndht = zeros(192,32,25,360);
cnvht = zeros(192,32,25,360);
radht = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[dyn,iter,M]=rdmds([rDir,'AtPhDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht(:,:,:,i) = dyn(:,:,:,J);

end %nit loop

htrt_tava(:,:,:,j) = mean(htrt,4);
difht_tava(:,:,:,j)  = mean(difht,4);
cndht_tava(:,:,:,j)  = mean(cndht,4);
cnvht_tava(:,:,:,j)  = mean(cnvht,4);
radht_tava(:,:,:,j)  = mean(radht,4);

end

htrt_tav = mean(htrt_tava,4);
difht_tav = mean(difht_tava,4);
cndht_tav = mean(cndht_tava,4);
cnvht_tav = mean(cnvht_tava,4);
radht_tav = mean(radht_tava,4);


save('/project/rg312/mat_files/chapter2_variables/htrts_tav_025.mat','htrt_tav','difht_tav','cndht_tav','cnvht_tav','radht_tav')


