%load in vtheta, v, theta



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
zpbl_025 = zeros(192,32,360);
rich_025 = zeros(192,32,25,360);


for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhzpbl'));
zpbl_025(:,:,i) = surf(:,:,J);

[atph,iter,M]=rdmds([rDir,'AtPhDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhrich'));
rich_025(:,:,:,i) = atph(:,:,:,J);

end %nit loop


name=['/project/rg312/mat_files/snapshot_data_final/run_025/rich_025_' num2str(j) '.mat'];
save(name,'rich_025')

name=['/project/rg312/mat_files/snapshot_data_final/run_025/zpbl_025_' num2str(j) '.mat'];
save(name,'zpbl_025')


end  %j loop
