

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


phref_100=rdmds([rDir,'PHrefC']);

for j=1:10
i=0
ph_000 = zeros(192,32,25,360);
ph_100 = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

ph_100(:,:,:,i)=rdmds([rDir,'PH'],nit);

end %nit loop

for i=1:25

ph_100(:,:,i,:) = ph_100(:,:,i,:) + phref_100(i);

end


name=['/project/rg312/mat_files/snapshot_data_final/run_100/ph_100_' num2str(j) '.mat'];
save(name,'ph_100')

end  %j loop


