

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


phref_th=rdmds([rDir,'PHrefC']);

for j=1:10
i=0
ph_th = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

ph_th(:,:,:,i)=rdmds([rDir,'PH'],nit);

end %nit loop

for i=1:25

ph_th(:,:,i,:) = ph_th(:,:,i,:) + phref_th(i);

end


name=['/project/rg312/mat_files/snapshot_data_final/run_th/ph_th_' num2str(j) '.mat'];
save(name,'ph_th')

end  %j loop


