%load up u,v,theta, q time avs for each run 


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
yi=-89:2:89;
xi = -179:2:179;
A=0.06;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%


u_100 = zeros(192,32,25,360);
v_100 = zeros(192,32,25,360);
q_100 = zeros(192,32,25,360);
theta_100 = zeros(192,32,25,360);

htrt_100 = zeros(192,32,25,360);
difht_100 = zeros(192,32,25,360);
radht_100 = zeros(192,32,25,360);
cndht_100 = zeros(192,32,25,360);
cnvht_100 = zeros(192,32,25,360);

for j=1:10
i=0
for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
u_100(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_100(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_100(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_100(:,:,:,i) = dyn(:,:,:,J);

[dyn,iter,M]=rdmds([rDir,'AtPhDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdTdt'));
htrt_100(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_100(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_100(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_100(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_100(:,:,:,i) = dyn(:,:,:,J);

end %nit loop

u_tav(:,:,:,j) = mean(u_100,4);
v_tav(:,:,:,j) = mean(v_100,4);
q_tav(:,:,:,j) = mean(q_100,4);
theta_tav(:,:,:,j) = mean(theta_100,4);

htrt_tav(:,:,:,j) = mean(htrt_100,4);
radht_tav(:,:,:,j) = mean(radht_100,4);
cndht_tav(:,:,:,j) = mean(cndht_100,4);
cnvht_tav(:,:,:,j) = mean(cnvht_100,4);
difht_tav(:,:,:,j) = mean(difht_100,4);

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




save('/project/rg312/mat_files/time_mean_data_final/climatology_100.mat', 'uE_tav', 'vN_tav', 'q_tav', 'theta_tav', 'htrt_tav', 'radht_tav', 'cndht_tav', 'cnvht_tav', 'difht_tav')



