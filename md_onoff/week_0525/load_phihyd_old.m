%load ph from older runs

% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_000_best/';
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

rDir='/project/rg312/wv_on_rad_off/run_000_best/';
phref=rdmds([rDir,'PHrefC']);


i=0
ph_000 = zeros(192,32,25,720);
ph_010 = zeros(192,32,25,720);
ph_025 = zeros(192,32,25,720);
ph_050 = zeros(192,32,25,720);
ph_075 = zeros(192,32,25,720);
ph_100 = zeros(192,32,25,720);

for nit = 86640:240:259200;
i=i+1
rDir='/project/rg312/wv_on_rad_off/run_000_best/';
ph_000(:,:,:,i)=rdmds([rDir,'PH'],nit);

rDir='/project/rg312/wv_on_rad_off/run_010_best/';
ph_010(:,:,:,i)=rdmds([rDir,'PH'],nit);

rDir='/project/rg312/wv_on_rad_off/run_025_best/';
ph_025(:,:,:,i)=rdmds([rDir,'PH'],nit);

rDir='/project/rg312/wv_on_rad_off/run_050_best/';
ph_050(:,:,:,i)=rdmds([rDir,'PH'],nit);

rDir='/project/rg312/wv_on_rad_off/run_075_best/';
ph_075(:,:,:,i)=rdmds([rDir,'PH'],nit);

rDir='/project/rg312/wv_on_rad_off/run_100_best/';
ph_100(:,:,:,i)=rdmds([rDir,'PH'],nit);

end %nit loop

for i=1:25

ph_000(:,:,i,:) = ph_000(:,:,i,:) + phref(i);
ph_010(:,:,i,:) = ph_010(:,:,i,:) + phref(i);
ph_025(:,:,i,:) = ph_025(:,:,i,:) + phref(i);
ph_050(:,:,i,:) = ph_050(:,:,i,:) + phref(i);
ph_075(:,:,i,:) = ph_075(:,:,i,:) + phref(i);
ph_100(:,:,i,:) = ph_100(:,:,i,:) + phref(i);

end


name=['/project/rg312/mat_files/snapshot_data/ph_snapshots_best.mat'];
save(name,'ph_000','ph_010','ph_025','ph_050','ph_075','ph_100')


