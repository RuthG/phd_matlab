%look at w'theta' correlation between runs



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
xi = -179:2:179;

radius = 6371.0e3;

%load heat rates

load('/project/rg312/mat_files/snapshot_data/theta_snapshots.mat','theta_000')
theta_000_ll = cube2latlon(xc,yc,theta_000,xi,yi);
clear('theta_000');
theta_000_ll_tav = repmat(mean(theta_000_ll,4),[1 1 1 720]);
theta_ed_000_ll =  theta_000_ll - theta_000_ll_tav;
clear('theta_000_ll_tav','theta_000_ll');
'theta loaded'

load('/project/rg312/mat_files/snapshot_data/w_snapshots.mat','w_000')
w_000_ll = cube2latlon(xc,yc,w_000,xi,yi);
clear('w_000');
w_000_ll_tav = repmat(mean(w_000_ll,4),[1 1 1 720]);
w_ed_000_ll_half = zeros(180,90,26,720);
w_ed_000_ll = zeros(180,90,25,720);
w_ed_000_ll_half(:,:,1:25,:) =  w_000_ll - w_000_ll_tav;
clear('w_000_ll_tav','w_000_ll');
'w loaded, interpolating'
rC_half = (100000:-4000:0)';
w_ed_000_ll = shiftdim(interp1(rC_half,shiftdim(w_ed_000_ll_half,2),rC),2);



