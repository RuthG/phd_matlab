%load in vtheta, v, theta



% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_doshallowerth/';
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



v_th = zeros(192,32,25,720);
u_th = zeros(192,32,25,720);
w_th = zeros(192,32,25,720);
theta_th = zeros(192,32,25,720);
q_th = zeros(192,32,25,720);


i=0
for nit = 86640:240:259200;
i=i+1

rDir = '/project/rg312/wv_on_rad_off/run_doshallowerth/';
u_th(:,:,:,i)=rdmds([rDir,'U'],nit);
v_th(:,:,:,i)=rdmds([rDir,'V'],nit);
theta_th(:,:,:,i)=rdmds([rDir,'T'],nit);
q_th(:,:,:,i)=rdmds([rDir,'S'],nit);
w_th(:,:,:,i)=rdmds([rDir,'W'],nit);

end

[uE_th,vN_th] = rotate_uv2uvEN(u_th,v_th,AngleCS,AngleSN,Grid);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
t_th(:,:,j,:)=theta_th(:,:,j,:).*convthetatoT(j,1);
end



save('/project/rg312/mat_files/snapshot_data/t_snapshots_th.mat','t_th')

save('/project/rg312/mat_files/snapshot_data/theta_snapshots_th.mat','theta_th')

save('/project/rg312/mat_files/snapshot_data/vN_snapshots_th.mat','vN_th')

save('/project/rg312/mat_files/snapshot_data/uE_snapshots_th.mat','uE_th')

save('/project/rg312/mat_files/snapshot_data/q_snapshots_th.mat','q_th')

save('/project/rg312/mat_files/snapshot_data/w_snapshots_th.mat','w_th')


