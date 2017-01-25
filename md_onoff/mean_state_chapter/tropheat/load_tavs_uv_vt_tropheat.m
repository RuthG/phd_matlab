%load up u, v theta, and q for the rad on run and save time means somewhere obvious!

% choose directory, load grid
rDir='/project/rg312/final_runs/run_050_final_tropheat/';
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
vth = zeros(192,32,25,360);
uth  = zeros(192,32,25,360);
wth  = zeros(192,32,25,360);
uv  = zeros(192,32,25,360);
usq  = zeros(192,32,25,360);
vsq  = zeros(192,32,25,360);
wsq  = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVELTH  '));
uth(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vth(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVELTH  '));
wth(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UV_VEL_C'));
uv(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELSQ  '));
usq(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSQ  '));
vsq(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVELSQ  '));
wsq(:,:,:,i) = dyn(:,:,:,J);

end %nit loop

uth_tava(:,:,:,j) = mean(uth,4);
vth_tava(:,:,:,j)  = mean(vth,4);
wth_tava(:,:,:,j)  = mean(wth,4);
uv_tava(:,:,:,j)  = mean(uv,4);
usq_tava(:,:,:,j) = mean(usq,4);
vsq_tava(:,:,:,j)  = mean(vsq,4);
wsq_tava(:,:,:,j)  = mean(wsq,4);

end

uth_tav = mean(uth_tava,4);
vth_tav = mean(vth_tava,4);
wth_tav = mean(wth_tava,4);
uv_tav = mean(uv_tava,4);
usq_tav = mean(usq_tava,4);
vsq_tav = mean(vsq_tava,4);
wsq_tav = mean(wsq_tava,4);

[uEth_tav,vNth_tav] = rotate_uv2uvEN(uth_tav,vth_tav,AngleCS,AngleSN,Grid);

save('/project/rg312/mat_files/chapter2_variables/epvars_tav_050_tropheat.mat','uv_tav','vNth_tav','uEth_tav','wth_tav','usq_tav','vsq_tav','wsq_tav')


