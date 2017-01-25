%load in vtheta, v, theta



% choose directory, load grid
rDir='/project/rg312/final_runs/run_000_final_noshallow/';
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
v_000 = zeros(192,32,25,360);
u_000 = zeros(192,32,25,360);
w_000 = zeros(192,32,25,360);
theta_000 = zeros(192,32,25,360);
q_000 = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

u_000(:,:,:,i)=rdmds([rDir,'U'],nit);
v_000(:,:,:,i)=rdmds([rDir,'V'],nit);
theta_000(:,:,:,i)=rdmds([rDir,'T'],nit);
q_000(:,:,:,i)=rdmds([rDir,'S'],nit);
w_000(:,:,:,i)=rdmds([rDir,'W'],nit);

end %nit loop


[uE_000,vN_000] = rotate_uv2uvEN(u_000,v_000,AngleCS,AngleSN,Grid);


convthetatoT=(rC/100000.0).^(2./7.);
for k=1:size(rC)
t_000(:,:,k,:)=theta_000(:,:,k,:).*convthetatoT(k,1);
end

name=['/project/rg312/mat_files/snapshot_data_final/run_000_ns/t_000_' num2str(j) '.mat'];
save(name,'t_000')

name=['/project/rg312/mat_files/snapshot_data_final/run_000_ns/q_000_' num2str(j) '.mat'];
save(name,'q_000')

name=['/project/rg312/mat_files/snapshot_data_final/run_000_ns/theta_000_' num2str(j) '.mat'];
save(name,'theta_000')

name=['/project/rg312/mat_files/snapshot_data_final/run_000_ns/uE_000_' num2str(j) '.mat'];
save(name,'uE_000')

name=['/project/rg312/mat_files/snapshot_data_final/run_000_ns/vN_000_' num2str(j) '.mat'];
save(name,'vN_000')

name=['/project/rg312/mat_files/snapshot_data_final/run_000_ns/w_000_' num2str(j) '.mat'];
save(name,'w_000')


end  %j loop
