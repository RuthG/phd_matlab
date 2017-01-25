%load in heatrates for runs to plot composites of these.



% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_150_best/';
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



htrt_125 = zeros(192,32,25,720);
htrt_150 = zeros(192,32,25,720);
radht_125 = zeros(192,32,25,720);
radht_150 = zeros(192,32,25,720);
cnvht_125 = zeros(192,32,25,720);
cnvht_150 = zeros(192,32,25,720);
cndht_125 = zeros(192,32,25,720);
cndht_150 = zeros(192,32,25,720);
difht_125 = zeros(192,32,25,720);
difht_150 = zeros(192,32,25,720);


i=0
for nit = 86640:240:258960;
i=i+1

rDir = '/project/rg312/wv_on_rad_off/run_125_best/';
[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_125(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_125(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_125(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_125(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_125(:,:,:,i) = snap(:,:,:,J);

rDir = '/project/rg312/wv_on_rad_off/run_150_best/';
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

end

save('/project/rg312/mat_files/heat_rates_best.mat','-append')
