%load and save the vorticity fields for each run



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



vort_125 = zeros(192,32,25,720);
vort_150 = zeros(192,32,25,720);

i=0
for nit = 86640:240:258960;
i=i+1

rDir = '/project/rg312/wv_on_rad_off/run_125_best/';
[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'momVort3'));
vort_125(:,:,:,i) = snap(:,:,:,J);

rDir = '/project/rg312/wv_on_rad_off/run_150_best/';
[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'momVort3'));
vort_150(:,:,:,i) = snap(:,:,:,J);

end

save('/project/rg312/mat_files/vorticity_data_best.mat','-append')
