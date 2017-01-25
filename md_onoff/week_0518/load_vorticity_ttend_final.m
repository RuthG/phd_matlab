%load and save the vorticity fields for each run



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


for j=1:10
i=0
vort_100 = zeros(192,32,25,360);
totttend_100 = zeros(192,32,25,360);
totttend_snap_100 = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'TOTTTEND'));
totttend_100(:,:,:,i) = dyn(:,:,:,J);

[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'TOTTTEND'));
totttend_snap_100(:,:,:,i) = snap(:,:,:,J);
J=find(strcmp(fldList,'momVort3'));
vort_100(:,:,:,i) = snap(:,:,:,J);

end

name=['/project/rg312/mat_files/snapshot_data_final/run_100/vort_100_' num2str(j) '.mat'];
save(name,'vort_100')
name=['/project/rg312/mat_files/snapshot_data_final/run_100/totttend_100_' num2str(j) '.mat'];
save(name,'totttend_100')
name=['/project/rg312/mat_files/snapshot_data_final/run_100/totttend_snap_100_' num2str(j) '.mat'];
save(name,'totttend_snap_100')

end

