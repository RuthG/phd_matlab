%load in vtheta, v, theta



% choose directory, load grid
rDir='/project/rg312/final_runs/run_050_final_tropheat/';
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
v_th = zeros(192,32,25,360);
u_th = zeros(192,32,25,360);
w_th = zeros(192,32,25,360);
theta_th = zeros(192,32,25,360);
q_th = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

u_th(:,:,:,i)=rdmds([rDir,'U'],nit);
v_th(:,:,:,i)=rdmds([rDir,'V'],nit);
theta_th(:,:,:,i)=rdmds([rDir,'T'],nit);
q_th(:,:,:,i)=rdmds([rDir,'S'],nit);
w_th(:,:,:,i)=rdmds([rDir,'W'],nit);

end %nit loop


[uE_th,vN_th] = rotate_uv2uvEN(u_th,v_th,AngleCS,AngleSN,Grid);


convthetatoT=(rC/100000.0).^(2./7.);
for k=1:size(rC)
t_th(:,:,k,:)=theta_th(:,:,k,:).*convthetatoT(k,1);
end

name=['/project/rg312/mat_files/snapshot_data_final/run_th/t_th_' num2str(j) '.mat'];
save(name,'t_th')

name=['/project/rg312/mat_files/snapshot_data_final/run_th/q_th_' num2str(j) '.mat'];
save(name,'q_th')

name=['/project/rg312/mat_files/snapshot_data_final/run_th/theta_th_' num2str(j) '.mat'];
save(name,'theta_th')

name=['/project/rg312/mat_files/snapshot_data_final/run_th/uE_th_' num2str(j) '.mat'];
save(name,'uE_th')

name=['/project/rg312/mat_files/snapshot_data_final/run_th/vN_th_' num2str(j) '.mat'];
save(name,'vN_th')

name=['/project/rg312/mat_files/snapshot_data_final/run_th/w_th_' num2str(j) '.mat'];
save(name,'w_th')


end  %j loop
