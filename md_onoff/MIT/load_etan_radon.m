%load in eta



% choose directory, load grid
rDir='/project/rg312/final_runs/run_100_rad_on/';
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
eta_100 = zeros(192,32,360);
%sens_100 = zeros(192,32,360);
%evap_100 = zeros(192,32,360);
%insr_100 = zeros(192,32,360);
%ntsr_100 = zeros(192,32,360);
%olr_100 = zeros(192,32,360);
%dssr_100 = zeros(192,32,360);
%nssr_100 = zeros(192,32,360);
%dslr_100 = zeros(192,32,360);
%uslr_100 = zeros(192,32,360);
%cnvp_100 = zeros(192,32,360);
%lscp_100 = zeros(192,32,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

rDir='/project/rg312/final_runs/run_100_final/';
eta_100(:,:,i)=rdmds([rDir,'Eta'],nit);

%[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
%eval(M);
%J=find(strcmp(fldList,'AtPhSens'));
%sens_100(:,:,i) = surf(:,:,J);
%J=find(strcmp(fldList,'AtPhEvap'));
%evap_100(:,:,i) = surf(:,:,J);
%J=find(strcmp(fldList,'AtPhInSR'));
%insr_100(:,:,i) = surf(:,:,J);
%J=find(strcmp(fldList,'AtPhNTSR'));
%ntsr_100(:,:,i) = surf(:,:,J);
%J=find(strcmp(fldList,'AtPhOLR '));
%olr_100(:,:,i) = surf(:,:,J);
%J=find(strcmp(fldList,'AtPhDSSR'));
%dssr_100(:,:,i) = surf(:,:,J);
%J=find(strcmp(fldList,'AtPhNSSR'));
%nssr_100(:,:,i) = surf(:,:,J);
%J=find(strcmp(fldList,'AtPhDSLR'));
%dslr_100(:,:,i) = surf(:,:,J);
%J=find(strcmp(fldList,'AtPhUSLR'));
%uslr_100(:,:,i) = surf(:,:,J);
%J=find(strcmp(fldList,'AtPhCnvP'));
%cnvp_100(:,:,i) = surf(:,:,J);
%J=find(strcmp(fldList,'AtPhLscP'));
%lscp_100(:,:,i) = surf(:,:,J);

end %nit loop


name=['/project/rg312/mat_files/snapshot_data_final/run_100_ro/eta_100_' num2str(j) '.mat'];
save(name,'eta_100')

end %j loop




return


name=['/project/rg312/mat_files/snapshot_data_final/run_100_ro/sens_100_' num2str(j) '.mat'];
save(name,'sens_100')

name=['/project/rg312/mat_files/snapshot_data_final/run_100_ro/evap_100_' num2str(j) '.mat'];
save(name,'evap_100')

name=['/project/rg312/mat_files/snapshot_data_final/run_100_ro/insr_100_' num2str(j) '.mat'];
save(name,'insr_100')

name=['/project/rg312/mat_files/snapshot_data_final/run_100_ro/ntsr_100_' num2str(j) '.mat'];
save(name,'ntsr_100')

name=['/project/rg312/mat_files/snapshot_data_final/run_100_ro/olr_100_' num2str(j) '.mat'];
save(name,'olr_100')

name=['/project/rg312/mat_files/snapshot_data_final/run_100_ro/dssr_100_' num2str(j) '.mat'];
save(name,'dssr_100')

name=['/project/rg312/mat_files/snapshot_data_final/run_100_ro/nssr_100_' num2str(j) '.mat'];
save(name,'nssr_100')

name=['/project/rg312/mat_files/snapshot_data_final/run_100_ro/dslr_100_' num2str(j) '.mat'];
save(name,'dslr_100')

name=['/project/rg312/mat_files/snapshot_data_final/run_100_ro/uslr_100_' num2str(j) '.mat'];
save(name,'uslr_100')

name=['/project/rg312/mat_files/snapshot_data_final/run_100_ro/cnvp_100_' num2str(j) '.mat'];
save(name,'cnvp_100')

name=['/project/rg312/mat_files/snapshot_data_final/run_100_ro/lscp_100_' num2str(j) '.mat'];
save(name,'lscp_100')

%end  %j loop
