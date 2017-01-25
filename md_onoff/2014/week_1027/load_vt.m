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


vth_000 = zeros(192,32,25,720);
vth_010 = zeros(192,32,25,720);
vth_025 = zeros(192,32,25,720);
vth_050 = zeros(192,32,25,720);
vth_075 = zeros(192,32,25,720);
vth_100 = zeros(192,32,25,720);
uth_000 = zeros(192,32,25,720);
uth_010 = zeros(192,32,25,720);
uth_025 = zeros(192,32,25,720);
uth_050 = zeros(192,32,25,720);
uth_075 = zeros(192,32,25,720);
uth_100 = zeros(192,32,25,720);

v_000 = zeros(192,32,25,720);
v_010 = zeros(192,32,25,720);
v_025 = zeros(192,32,25,720);
v_050 = zeros(192,32,25,720);
v_075 = zeros(192,32,25,720);
v_100 = zeros(192,32,25,720);
u_000 = zeros(192,32,25,720);
u_010 = zeros(192,32,25,720);
u_025 = zeros(192,32,25,720);
u_050 = zeros(192,32,25,720);
u_075 = zeros(192,32,25,720);
u_100 = zeros(192,32,25,720);

i=0
for nit = 86640:240:259200;
i=i+1

rDir = '/project/rg312/wv_on_rad_off/run_doshallower00/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVELTH  '));
uth_000(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vth_000(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
u_000(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_000(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_000(:,:,:,i) = dyn(:,:,:,J);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower01/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVELTH  '));
uth_010(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vth_010(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
u_010(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_010(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_010(:,:,:,i) = dyn(:,:,:,J);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower025/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVELTH  '));
uth_025(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vth_025(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
u_025(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_025(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_025(:,:,:,i) = dyn(:,:,:,J);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower05/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVELTH  '));
uth_050(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vth_050(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
u_050(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_050(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_050(:,:,:,i) = dyn(:,:,:,J);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower75/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVELTH  '));
uth_075(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vth_075(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
u_075(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_075(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_075(:,:,:,i) = dyn(:,:,:,J);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower10/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVELTH  '));
uth_100(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vth_100(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
u_100(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_100(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_100(:,:,:,i) = dyn(:,:,:,J);

end


[uEth_000,vNth_000] = rotate_uv2uvEN(uth_000,vth_000,AngleCS,AngleSN,Grid);
[uEth_010,vNth_010] = rotate_uv2uvEN(uth_010,vth_010,AngleCS,AngleSN,Grid);
[uEth_025,vNth_025] = rotate_uv2uvEN(uth_025,vth_025,AngleCS,AngleSN,Grid);
[uEth_050,vNth_050] = rotate_uv2uvEN(uth_050,vth_050,AngleCS,AngleSN,Grid);
[uEth_075,vNth_075] = rotate_uv2uvEN(uth_075,vth_075,AngleCS,AngleSN,Grid);
[uEth_100,vNth_100] = rotate_uv2uvEN(uth_100,vth_100,AngleCS,AngleSN,Grid);

[uE_000,vN_000] = rotate_uv2uvEN(u_000,v_000,AngleCS,AngleSN,Grid);
[uE_010,vN_010] = rotate_uv2uvEN(u_010,v_010,AngleCS,AngleSN,Grid);
[uE_025,vN_025] = rotate_uv2uvEN(u_025,v_025,AngleCS,AngleSN,Grid);
[uE_050,vN_050] = rotate_uv2uvEN(u_050,v_050,AngleCS,AngleSN,Grid);
[uE_075,vN_075] = rotate_uv2uvEN(u_075,v_075,AngleCS,AngleSN,Grid);
[uE_100,vN_100] = rotate_uv2uvEN(u_100,v_100,AngleCS,AngleSN,Grid);


convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
vNt_000(:,:,j,:)=vNth_000(:,:,j,:).*convthetatoT(j,1);
vNt_010(:,:,j,:)=vNth_010(:,:,j,:).*convthetatoT(j,1);
vNt_025(:,:,j,:)=vNth_025(:,:,j,:).*convthetatoT(j,1);
vNt_050(:,:,j,:)=vNth_050(:,:,j,:).*convthetatoT(j,1);
vNt_075(:,:,j,:)=vNth_075(:,:,j,:).*convthetatoT(j,1);
vNt_100(:,:,j,:)=vNth_100(:,:,j,:).*convthetatoT(j,1);
t_000(:,:,j,:)=theta_000(:,:,j,:).*convthetatoT(j,1);
t_010(:,:,j,:)=theta_010(:,:,j,:).*convthetatoT(j,1);
t_025(:,:,j,:)=theta_025(:,:,j,:).*convthetatoT(j,1);
t_050(:,:,j,:)=theta_050(:,:,j,:).*convthetatoT(j,1);
t_075(:,:,j,:)=theta_075(:,:,j,:).*convthetatoT(j,1);
t_100(:,:,j,:)=theta_100(:,:,j,:).*convthetatoT(j,1);
end


save('/project/rg312/mat_files/vNt_tseries.mat','vNt_000','vNt_010','vNt_025','vNt_050','vNt_075','vNt_100')

save('/project/rg312/mat_files/t_tseries.mat','t_000','t_010','t_025','t_050','t_075','t_100')

save('/project/rg312/mat_files/vN_tseries.mat','vN_000','vN_010','vN_025','vN_050','vN_075','vN_100')



