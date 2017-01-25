%load in heatrates for runs to plot composites of these.



% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_000_best/';
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




htrt_000 = zeros(192,32,25,720);
htrt_010 = zeros(192,32,25,720);
htrt_025 = zeros(192,32,25,720);
htrt_050 = zeros(192,32,25,720);
htrt_075 = zeros(192,32,25,720);
htrt_100 = zeros(192,32,25,720);
radht_000 = zeros(192,32,25,720);
radht_010 = zeros(192,32,25,720);
radht_025 = zeros(192,32,25,720);
radht_050 = zeros(192,32,25,720);
radht_075 = zeros(192,32,25,720);
radht_100 = zeros(192,32,25,720);
cnvht_000 = zeros(192,32,25,720);
cnvht_010 = zeros(192,32,25,720);
cnvht_025 = zeros(192,32,25,720);
cnvht_050 = zeros(192,32,25,720);
cnvht_075 = zeros(192,32,25,720);
cnvht_100 = zeros(192,32,25,720);
cndht_000 = zeros(192,32,25,720);
cndht_010 = zeros(192,32,25,720);
cndht_025 = zeros(192,32,25,720);
cndht_050 = zeros(192,32,25,720);
cndht_075 = zeros(192,32,25,720);
cndht_100 = zeros(192,32,25,720);
difht_000 = zeros(192,32,25,720);
difht_010 = zeros(192,32,25,720);
difht_025 = zeros(192,32,25,720);
difht_050 = zeros(192,32,25,720);
difht_075 = zeros(192,32,25,720);
difht_100 = zeros(192,32,25,720);


i=0
for nit = 86640:240:258960;
i=i+1

rDir = '/project/rg312/wv_on_rad_off/run_000_best/';
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

rDir = '/project/rg312/wv_on_rad_off/run_010_best/';
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

rDir = '/project/rg312/wv_on_rad_off/run_025_best/';
[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_025(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_025(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_025(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_025(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_025(:,:,:,i) = snap(:,:,:,J);

rDir = '/project/rg312/wv_on_rad_off/run_050_best/';
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

rDir = '/project/rg312/wv_on_rad_off/run_075_best/';
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


rDir = '/project/rg312/wv_on_rad_off/run_100_best/';
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

end

save('/project/rg312/mat_files/heat_rates_best.mat')
