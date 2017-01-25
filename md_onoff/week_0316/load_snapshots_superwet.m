%load in vtheta, v, theta



% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_125_best/';
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



v_125 = zeros(192,32,25,720);
v_150 = zeros(192,32,25,720);
u_125 = zeros(192,32,25,720);
u_150 = zeros(192,32,25,720);
w_125 = zeros(192,32,25,720);
w_150 = zeros(192,32,25,720);

theta_125 = zeros(192,32,25,720);
theta_150 = zeros(192,32,25,720);
q_125 = zeros(192,32,25,720);
q_150 = zeros(192,32,25,720);


i=0
for nit = 86640:240:259200;
i=i+1

rDir = '/project/rg312/wv_on_rad_off/run_125_best/';
u_125(:,:,:,i)=rdmds([rDir,'U'],nit);
v_125(:,:,:,i)=rdmds([rDir,'V'],nit);
theta_125(:,:,:,i)=rdmds([rDir,'T'],nit);
q_125(:,:,:,i)=rdmds([rDir,'S'],nit);
w_125(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir = '/project/rg312/wv_on_rad_off/run_150_best/';
u_150(:,:,:,i)=rdmds([rDir,'U'],nit);
v_150(:,:,:,i)=rdmds([rDir,'V'],nit);
theta_150(:,:,:,i)=rdmds([rDir,'T'],nit);
q_150(:,:,:,i)=rdmds([rDir,'S'],nit);
w_150(:,:,:,i)=rdmds([rDir,'W'],nit);

end

[uE_125,vN_125] = rotate_uv2uvEN(u_125,v_125,AngleCS,AngleSN,Grid);
[uE_150,vN_150] = rotate_uv2uvEN(u_150,v_150,AngleCS,AngleSN,Grid);


convthetatoT=(rC/100000.0).^(2./7.);
for j=1:size(rC)

t_125(:,:,j,:)=theta_125(:,:,j,:).*convthetatoT(j,1);
t_150(:,:,j,:)=theta_150(:,:,j,:).*convthetatoT(j,1);

end



save('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_125','t_150','-append')

save('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat','theta_125','theta_150','-append')

save('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_125','vN_150','-append')

save('/project/rg312/mat_files/snapshot_data/uE_snapshots_best.mat','uE_125','uE_150','-append')

save('/project/rg312/mat_files/snapshot_data/q_snapshots_best.mat','q_125','q_150','-append')

save('/project/rg312/mat_files/snapshot_data/w_snapshots_best.mat','w_125','w_150','-append')
