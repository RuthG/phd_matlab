%load in eta



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
eta_000 = zeros(192,32,360);
eta_010 = zeros(192,32,360);
eta_025 = zeros(192,32,360);
eta_050 = zeros(192,32,360);
eta_th = zeros(192,32,360);
eta_075 = zeros(192,32,360);
eta_100 = zeros(192,32,360);
eta_125 = zeros(192,32,360);
eta_150 = zeros(192,32,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

rDir='/project/rg312/final_runs/run_000_final_noshallow/';
eta_000(:,:,i)=rdmds([rDir,'Eta'],nit);

rDir='/project/rg312/final_runs/run_010_final/';
eta_010(:,:,i)=rdmds([rDir,'Eta'],nit);

rDir='/project/rg312/final_runs/run_025_final/';
eta_025(:,:,i)=rdmds([rDir,'Eta'],nit);

rDir='/project/rg312/final_runs/run_050_final/';
eta_050(:,:,i)=rdmds([rDir,'Eta'],nit);

rDir='/project/rg312/final_runs/run_050_final_tropheat/';
eta_th(:,:,i)=rdmds([rDir,'Eta'],nit);

rDir='/project/rg312/final_runs/run_075_final/';
eta_075(:,:,i)=rdmds([rDir,'Eta'],nit);

rDir='/project/rg312/final_runs/run_100_final/';
eta_100(:,:,i)=rdmds([rDir,'Eta'],nit);

rDir='/project/rg312/final_runs/run_125_final/';
eta_125(:,:,i)=rdmds([rDir,'Eta'],nit);

rDir='/project/rg312/final_runs/run_150_final/';
eta_150(:,:,i)=rdmds([rDir,'Eta'],nit);

end %nit loop

name=['/project/rg312/mat_files/snapshot_data_final/run_000_ns/eta_000_' num2str(j) '.mat'];
save(name,'eta_000')

name=['/project/rg312/mat_files/snapshot_data_final/run_010/eta_010_' num2str(j) '.mat'];
save(name,'eta_010')

name=['/project/rg312/mat_files/snapshot_data_final/run_025/eta_025_' num2str(j) '.mat'];
save(name,'eta_025')

name=['/project/rg312/mat_files/snapshot_data_final/run_050/eta_050_' num2str(j) '.mat'];
save(name,'eta_050')

name=['/project/rg312/mat_files/snapshot_data_final/run_th/eta_th_' num2str(j) '.mat'];
save(name,'eta_th')

name=['/project/rg312/mat_files/snapshot_data_final/run_075/eta_075_' num2str(j) '.mat'];
save(name,'eta_075')

name=['/project/rg312/mat_files/snapshot_data_final/run_100/eta_100_' num2str(j) '.mat'];
save(name,'eta_100')

name=['/project/rg312/mat_files/snapshot_data_final/run_125/eta_125_' num2str(j) '.mat'];
save(name,'eta_125')

name=['/project/rg312/mat_files/snapshot_data_final/run_150/eta_150_' num2str(j) '.mat'];
save(name,'eta_150')



end  %j loop
