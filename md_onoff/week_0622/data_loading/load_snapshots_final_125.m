%load in vtheta, v, theta



% choose directory, load grid
rDir='/project/rg312/final_runs/run_125_final/';
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
v_125 = zeros(192,32,25,360);
u_125 = zeros(192,32,25,360);
w_125 = zeros(192,32,25,360);
theta_125 = zeros(192,32,25,360);
q_125 = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

u_125(:,:,:,i)=rdmds([rDir,'U'],nit);
v_125(:,:,:,i)=rdmds([rDir,'V'],nit);
theta_125(:,:,:,i)=rdmds([rDir,'T'],nit);
q_125(:,:,:,i)=rdmds([rDir,'S'],nit);
w_125(:,:,:,i)=rdmds([rDir,'W'],nit);

end %nit loop


[uE_125,vN_125] = rotate_uv2uvEN(u_125,v_125,AngleCS,AngleSN,Grid);


convthetatoT=(rC/100000.0).^(2./7.);
for k=1:size(rC)
t_125(:,:,k,:)=theta_125(:,:,k,:).*convthetatoT(k,1);
end

name=['/project/rg312/mat_files/snapshot_data_final/run_125/t_125_' num2str(j) '.mat'];
save(name,'t_125')

name=['/project/rg312/mat_files/snapshot_data_final/run_125/q_125_' num2str(j) '.mat'];
save(name,'q_125')

name=['/project/rg312/mat_files/snapshot_data_final/run_125/theta_125_' num2str(j) '.mat'];
save(name,'theta_125')

name=['/project/rg312/mat_files/snapshot_data_final/run_125/uE_125_' num2str(j) '.mat'];
save(name,'uE_125')

name=['/project/rg312/mat_files/snapshot_data_final/run_125/vN_125_' num2str(j) '.mat'];
save(name,'vN_125')

name=['/project/rg312/mat_files/snapshot_data_final/run_125/w_125_' num2str(j) '.mat'];
save(name,'w_125')


end  %j loop
