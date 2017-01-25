%load and save the vorticity fields for each run



% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_doshallower10/';
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




vort_000 = zeros(192,32,25,720);
vort_010 = zeros(192,32,25,720);
vort_025 = zeros(192,32,25,720);
vort_050 = zeros(192,32,25,720);
vort_075 = zeros(192,32,25,720);
vort_100 = zeros(192,32,25,720);
vort_th  = zeros(192,32,25,720);

i=0
for nit = 86640:240:259200;
i=i+1

rDir = '/project/rg312/wv_on_rad_off/run_doshallower00/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'momVort3'));
vort_000(:,:,:,i) = dyn(:,:,:,J);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower01/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'momVort3'));
vort_010(:,:,:,i) = dyn(:,:,:,J);


rDir = '/project/rg312/wv_on_rad_off/run_doshallower025/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'momVort3'));
vort_025(:,:,:,i) = dyn(:,:,:,J);


rDir = '/project/rg312/wv_on_rad_off/run_doshallower05/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'momVort3'));
vort_050(:,:,:,i) = dyn(:,:,:,J);


rDir = '/project/rg312/wv_on_rad_off/run_doshallower75/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'momVort3'));
vort_075(:,:,:,i) = dyn(:,:,:,J);


rDir = '/project/rg312/wv_on_rad_off/run_doshallower10/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'momVort3'));
vort_100(:,:,:,i) = dyn(:,:,:,J);

rDir = '/project/rg312/wv_on_rad_off/run_doshallowerth/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'momVort3'));
vort_th(:,:,:,i) = dyn(:,:,:,J);

end

save('/project/rg312/mat_files/vorticity_data.mat')
