%load in vtheta, v, theta



% choose directory, load grid
rDir='/project/rg312/final_runs/run_150_final/';
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
v_150 = zeros(192,32,25,360);
u_150 = zeros(192,32,25,360);
w_150 = zeros(192,32,25,360);
theta_150 = zeros(192,32,25,360);
q_150 = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

u_150(:,:,:,i)=rdmds([rDir,'U'],nit);
v_150(:,:,:,i)=rdmds([rDir,'V'],nit);
theta_150(:,:,:,i)=rdmds([rDir,'T'],nit);
q_150(:,:,:,i)=rdmds([rDir,'S'],nit);
w_150(:,:,:,i)=rdmds([rDir,'W'],nit);

end %nit loop


[uE_150,vN_150] = rotate_uv2uvEN(u_150,v_150,AngleCS,AngleSN,Grid);


convthetatoT=(rC/100000.0).^(2./7.);
for k=1:size(rC)
t_150(:,:,k,:)=theta_150(:,:,k,:).*convthetatoT(k,1);
end

name=['/project/rg312/mat_files/snapshot_data_final/run_150/t_150_' num2str(j) '.mat'];
save(name,'t_150')

name=['/project/rg312/mat_files/snapshot_data_final/run_150/q_150_' num2str(j) '.mat'];
save(name,'q_150')

name=['/project/rg312/mat_files/snapshot_data_final/run_150/theta_150_' num2str(j) '.mat'];
save(name,'theta_150')

name=['/project/rg312/mat_files/snapshot_data_final/run_150/uE_150_' num2str(j) '.mat'];
save(name,'uE_150')

name=['/project/rg312/mat_files/snapshot_data_final/run_150/vN_150_' num2str(j) '.mat'];
save(name,'vN_150')

name=['/project/rg312/mat_files/snapshot_data_final/run_150/w_150_' num2str(j) '.mat'];
save(name,'w_150')


end  %j loop
