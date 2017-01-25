%load in terms for toa and surface heat budget

% choose directory, load grid
rDir='/project/rg312/final_runs/run_000_final_noshallow/';
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


for j=1
i=0



for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhSens'));
sens_000(:,:,i) = surf(:,:,J);
J=find(strcmp(fldList,'AtPhEvap'));
evap_000(:,:,i) = surf(:,:,J);
J=find(strcmp(fldList,'AtPhNSSR'));
nssr_000(:,:,i) = surf(:,:,J);
J=find(strcmp(fldList,'AtPhDSLR'));
dslr_000(:,:,i) = surf(:,:,J);
J=find(strcmp(fldList,'AtPhUSLR'));
uslr_000(:,:,i) = surf(:,:,J);
J=find(strcmp(fldList,'AtPhOLR '));
olr_000(:,:,i) = surf(:,:,J);
J=find(strcmp(fldList,'AtPhInSR'));
insr_000(:,:,i) = surf(:,:,J);


end %nit loop


name=['/project/rg312/mat_files/snapshot_data_final/run_000_ns/toa_surf_heat.mat'];
save(name,'sens_000','evap_000','nssr_000','dslr_000','uslr_000','olr_000','insr_000')


end  %j loop
