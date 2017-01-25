%load up u,v,theta, q time avs for each run 


% choose directory, load grid
rDir='/project/rg312/final_runs/run_000_final/';
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
yi=-89:2:89;
xi = -179:2:179;
A=0.06;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%


u_000 = zeros(192,32,25,360);
v_000 = zeros(192,32,25,360);
q_000 = zeros(192,32,25,360);
theta_000 = zeros(192,32,25,360);

htrt_000 = zeros(192,32,25,360);
difht_000 = zeros(192,32,25,360);
radht_000 = zeros(192,32,25,360);
cndht_000 = zeros(192,32,25,360);
cnvht_000 = zeros(192,32,25,360);

for j=1:10
i=0
for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
u_000(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_000(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_000(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_000(:,:,:,i) = dyn(:,:,:,J);

[dyn,iter,M]=rdmds([rDir,'AtPhDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdTdt'));
htrt_000(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_000(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_000(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_000(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_000(:,:,:,i) = dyn(:,:,:,J);

end %nit loop

u_tav(:,:,:,j) = mean(u_000,4);
v_tav(:,:,:,j) = mean(v_000,4);
q_tav(:,:,:,j) = mean(q_000,4);
theta_tav(:,:,:,j) = mean(theta_000,4);

htrt_tav(:,:,:,j) = mean(htrt_000,4);
radht_tav(:,:,:,j) = mean(radht_000,4);
cndht_tav(:,:,:,j) = mean(cndht_000,4);
cnvht_tav(:,:,:,j) = mean(cnvht_000,4);
difht_tav(:,:,:,j) = mean(difht_000,4);

end

u_tav = mean(u_tav,4);
v_tav = mean(v_tav,4);
q_tav = mean(q_tav,4);
theta_tav = mean(theta_tav,4);

htrt_tav = mean(htrt_tav,4);
radht_tav = mean(radht_tav,4);
cndht_tav = mean(cndht_tav,4);
cnvht_tav = mean(cnvht_tav,4);
difht_tav = mean(difht_tav,4);

[uE_tav,vN_tav] = rotate_uv2uvEN(u_tav,v_tav,AngleCS,AngleSN,Grid);




save('/project/rg312/mat_files/time_mean_data_final/climatology_000.mat', 'uE_tav', 'vN_tav', 'q_tav', 'theta_tav', 'htrt_tav', 'radht_tav', 'cndht_tav', 'cnvht_tav', 'difht_tav')



