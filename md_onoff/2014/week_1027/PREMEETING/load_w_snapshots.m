%load and save the snapshots of w so don't have to keep doing it!


% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_doshallower10/';
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


w_000 = zeros(192,32,25,720);
w_010 = zeros(192,32,25,720);
w_025 = zeros(192,32,25,720);
w_050 = zeros(192,32,25,720);
w_075 = zeros(192,32,25,720);
w_100 = zeros(192,32,25,720);

i=0
for nit = 86640:240:259200;
i=i+1

rDir = '/project/rg312/wv_on_rad_off/run_doshallower00/';
w_000(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower01/';
w_010(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower025/';
w_025(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower05/';
w_050(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower75/';
w_075(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower10/';
w_100(:,:,:,i)=rdmds([rDir,'W'],nit);

end

save('w_snapshots_saved.mat')

