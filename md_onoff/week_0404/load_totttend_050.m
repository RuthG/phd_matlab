%load in heatrates for runs to plot composites of these.



% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_050_best_totttend/';
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


totttend_050 = zeros(192,32,25,720);
totttend_snap_050 = zeros(192,32,25,720);



i=0
for nit = 86640:240:259200;
i=i+1

rDir = '/project/rg312/wv_on_rad_off/run_050_best_totttend/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'TOTTTEND'));
totttend_050(:,:,:,i) = dyn(:,:,:,J);

rDir = '/project/rg312/wv_on_rad_off/run_050_best_totttend/';
[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'TOTTTEND'));
totttend_snap_050(:,:,:,i) = snap(:,:,:,J);

end

save('/project/rg312/mat_files/totttend_050_best.mat')
