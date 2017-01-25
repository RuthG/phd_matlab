%load etan for all runs


% choose directory, load grid
rDir='/project/rg312/final_runs/run_150_final/';
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
lwn = zeros(192,32,25,360);
lwd = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[atph,iter,M]=rdmds([rDir,'AtPhDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhLWN '));
lwn(:,:,:,i) = atph(:,:,:,J);

J=find(strcmp(fldList,'AtPhLWD '));
lwd(:,:,:,i) = atph(:,:,:,J);

end %nit loop

lwn_tava(:,:,:,j) = mean(lwn,4);
lwd_tava(:,:,:,j) = mean(lwd,4);

end

lwn_tav = mean(lwn_tava,4);
lwd_tav = mean(lwd_tava,4);


save('/project/rg312/mat_files/chapter2_variables/lw_tav_150.mat','lwn_tav','lwd_tav')


