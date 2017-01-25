%load in vtheta, v, theta



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

u_100(:,:,:,i)=rdmds([rDir,'U'],nit);
v_100(:,:,:,i)=rdmds([rDir,'V'],nit);
theta_100(:,:,:,i)=rdmds([rDir,'T'],nit);
q_100(:,:,:,i)=rdmds([rDir,'S'],nit);
w_100(:,:,:,i)=rdmds([rDir,'W'],nit);

end %nit loop


[uE_100,vN_100] = rotate_uv2uvEN(u_100,v_100,AngleCS,AngleSN,Grid);


convthetatoT=(rC/100000.0).^(2./7.);
for k=1:size(rC)
t_100(:,:,k,:)=theta_100(:,:,k,:).*convthetatoT(k,1);
end

name=['/project/rg312/mat_files/snapshot_data_final/run_100/t_100_' num2str(j) '.mat'];
save(name,'t_100')

name=['/project/rg312/mat_files/snapshot_data_final/run_100/q_100_' num2str(j) '.mat'];
save(name,'q_100')

name=['/project/rg312/mat_files/snapshot_data_final/run_100/theta_100_' num2str(j) '.mat'];
save(name,'theta_100')

name=['/project/rg312/mat_files/snapshot_data_final/run_100/uE_100_' num2str(j) '.mat'];
save(name,'uE_100')

name=['/project/rg312/mat_files/snapshot_data_final/run_100/vN_100_' num2str(j) '.mat'];
save(name,'vN_100')

name=['/project/rg312/mat_files/snapshot_data_final/run_100/w_100_' num2str(j) '.mat'];
save(name,'w_100')


end  %j loop
