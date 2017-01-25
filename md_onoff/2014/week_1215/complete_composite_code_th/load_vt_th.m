%load in vtheta, v, theta



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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%


vth_th = zeros(192,32,25,720);
uth_th = zeros(192,32,25,720);
v_th = zeros(192,32,25,720);
theta_th = zeros(192,32,25,720);


i=0
for nit = 86640:240:259200;
i=i+1

rDir = '/project/rg312/wv_on_rad_off/run_doshallower00/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVELTH  '));
uth_th(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vth_th(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
u_th(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_th(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_th(:,:,:,i) = dyn(:,:,:,J);

end


[uEth_th,vNth_th] = rotate_uv2uvEN(uth_th,vth_th,AngleCS,AngleSN,Grid);


[uE_th,vN_th] = rotate_uv2uvEN(u_th,v_th,AngleCS,AngleSN,Grid);


convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
vNt_th(:,:,j,:)=vNth_th(:,:,j,:).*convthetatoT(j,1);

t_th(:,:,j,:)=theta_th(:,:,j,:).*convthetatoT(j,1);

end


save('/project/rg312/mat_files/vNt_tseries_th.mat','vNt_th')

save('/project/rg312/mat_files/t_tseries_th.mat','t_th')

save('/project/rg312/mat_files/vN_tseries_th.mat','vN_th')



