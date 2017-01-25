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
w_000 = zeros(192,32,25,720);
w_010 = zeros(192,32,25,720);
w_025 = zeros(192,32,25,720);
w_050 = zeros(192,32,25,720);
w_075 = zeros(192,32,25,720);
w_100 = zeros(192,32,25,720);

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
u_000(:,:,:,i)=rdmds([rDir,'U'],nit);
v_000(:,:,:,i)=rdmds([rDir,'V'],nit);
%theta_000(:,:,:,i)=rdmds([rDir,'T'],nit);
%q_000(:,:,:,i)=rdmds([rDir,'S'],nit);
%w_000(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower01/';
u_010(:,:,:,i)=rdmds([rDir,'U'],nit);
v_010(:,:,:,i)=rdmds([rDir,'V'],nit);
%theta_010(:,:,:,i)=rdmds([rDir,'T'],nit);
%q_010(:,:,:,i)=rdmds([rDir,'S'],nit);
%w_010(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower025/';
u_025(:,:,:,i)=rdmds([rDir,'U'],nit);
v_025(:,:,:,i)=rdmds([rDir,'V'],nit);
%theta_025(:,:,:,i)=rdmds([rDir,'T'],nit);
%q_025(:,:,:,i)=rdmds([rDir,'S'],nit);
%w_025(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower05/';
u_050(:,:,:,i)=rdmds([rDir,'U'],nit);
v_050(:,:,:,i)=rdmds([rDir,'V'],nit);
%theta_050(:,:,:,i)=rdmds([rDir,'T'],nit);
%q_050(:,:,:,i)=rdmds([rDir,'S'],nit);
%w_050(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower75/';
u_075(:,:,:,i)=rdmds([rDir,'U'],nit);
v_075(:,:,:,i)=rdmds([rDir,'V'],nit);
%theta_075(:,:,:,i)=rdmds([rDir,'T'],nit);
%q_075(:,:,:,i)=rdmds([rDir,'S'],nit);
%w_075(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower10/';
u_100(:,:,:,i)=rdmds([rDir,'U'],nit);
v_100(:,:,:,i)=rdmds([rDir,'V'],nit);
%theta_100(:,:,:,i)=rdmds([rDir,'T'],nit);
%q_100(:,:,:,i)=rdmds([rDir,'S'],nit);
%w_100(:,:,:,i)=rdmds([rDir,'W'],nit);

end


[uE_000,vN_000] = rotate_uv2uvEN(u_000,v_000,AngleCS,AngleSN,Grid);
[uE_010,vN_010] = rotate_uv2uvEN(u_010,v_010,AngleCS,AngleSN,Grid);
[uE_025,vN_025] = rotate_uv2uvEN(u_025,v_025,AngleCS,AngleSN,Grid);
[uE_050,vN_050] = rotate_uv2uvEN(u_050,v_050,AngleCS,AngleSN,Grid);
[uE_075,vN_075] = rotate_uv2uvEN(u_075,v_075,AngleCS,AngleSN,Grid);
[uE_100,vN_100] = rotate_uv2uvEN(u_100,v_100,AngleCS,AngleSN,Grid);


convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
t_000(:,:,j,:)=theta_000(:,:,j,:).*convthetatoT(j,1);
t_010(:,:,j,:)=theta_010(:,:,j,:).*convthetatoT(j,1);
t_025(:,:,j,:)=theta_025(:,:,j,:).*convthetatoT(j,1);
t_050(:,:,j,:)=theta_050(:,:,j,:).*convthetatoT(j,1);
t_075(:,:,j,:)=theta_075(:,:,j,:).*convthetatoT(j,1);
t_100(:,:,j,:)=theta_100(:,:,j,:).*convthetatoT(j,1);
end



%save('/project/rg312/mat_files/snapshot_data/t_snapshots.mat','t_000','t_010','t_025','t_050','t_075','t_100')

%save('/project/rg312/mat_files/snapshot_data/theta_snapshots.mat','theta_000','theta_010','theta_025','theta_050','theta_075','theta_100')

save('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat','vN_000','vN_010','vN_025','vN_050','vN_075','vN_100')

save('/project/rg312/mat_files/snapshot_data/uE_snapshots.mat','uE_000','uE_010','uE_025','uE_050','uE_075','uE_100')

%save('/project/rg312/mat_files/snapshot_data/q_snapshots.mat','q_000','q_010','q_025','q_050','q_075','q_100')

%save('/project/rg312/mat_files/snapshot_data/w_snapshots.mat','w_000','w_010','w_025','w_050','w_075','w_100')
