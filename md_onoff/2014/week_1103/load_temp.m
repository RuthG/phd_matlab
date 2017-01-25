%load in temperature, q for runs to plot composites of these.



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




theta_000 = zeros(192,32,25,720);
theta_010 = zeros(192,32,25,720);
theta_025 = zeros(192,32,25,720);
theta_050 = zeros(192,32,25,720);
theta_075 = zeros(192,32,25,720);
theta_100 = zeros(192,32,25,720);
q_000 = zeros(192,32,25,720);
q_010 = zeros(192,32,25,720);
q_025 = zeros(192,32,25,720);
q_050 = zeros(192,32,25,720);
q_075 = zeros(192,32,25,720);
q_100 = zeros(192,32,25,720);


i=0
for nit = 86640:240:259200;
i=i+1

rDir = '/project/rg312/wv_on_rad_off/run_doshallower00/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_000(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_000(:,:,:,i) = dyn(:,:,:,J);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower01/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_010(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_010(:,:,:,i) = dyn(:,:,:,J);


rDir = '/project/rg312/wv_on_rad_off/run_doshallower025/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_025(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_025(:,:,:,i) = dyn(:,:,:,J);


rDir = '/project/rg312/wv_on_rad_off/run_doshallower05/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_050(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_050(:,:,:,i) = dyn(:,:,:,J);


rDir = '/project/rg312/wv_on_rad_off/run_doshallower75/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_075(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_075(:,:,:,i) = dyn(:,:,:,J);


rDir = '/project/rg312/wv_on_rad_off/run_doshallower10/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_100(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_100(:,:,:,i) = dyn(:,:,:,J);


end

save('thetaq.mat')
