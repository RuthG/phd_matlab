%load up u, v theta, and q for the rad on run and save time means somewhere obvious!

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
v_100 = zeros(192,32,25,360);
u_100 = zeros(192,32,25,360);
w_100 = zeros(192,32,25,360);
theta_100 = zeros(192,32,25,360);
q_100 = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
u(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVEL    '));
w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i) = dyn(:,:,:,J);

end %nit loop

u_tava(:,:,:,j) = mean(u,4);
v_tava(:,:,:,j)  = mean(v,4);
theta_tava(:,:,:,j)  = mean(theta,4);
q_tava(:,:,:,j)  = mean(q,4);
w_tava(:,:,:,j)  = mean(w,4);

end

u_tav = mean(u_tava,4);
v_tav = mean(v_tava,4);
w_tav = mean(w_tava,4);
q_tav = mean(q_tava,4);
theta_tav = mean(theta_tava,4);

[uE_tav,vN_tav] = rotate_uv2uvEN(u_tav,v_tav,AngleCS,AngleSN,Grid);

save('/project/rg312/mat_files/radiation_chapter/uvwqt_tav_radon.mat','uE_tav','vN_tav','w_tav','q_tav','theta_tav')


