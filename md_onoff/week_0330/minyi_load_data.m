%calculate advective heat transport terms carefully on the lat-lon grid


% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_100_best/';
xc=rdmds([rDir,'XC']); %cube-sphere grid lon coords
yc=rdmds([rDir,'YC']); %cube-sphere grid lat coords
rC=squeeze(rdmds([rDir,'RC'])); %pressure levels in Pa

Grid='C';
yi = -89:2:89; %lat coordinates transfered to
xi = -179:2:179; %lon coordinates transfered to


%load in total diabatic heat rate (dthetadt) and transfer to lat-lon coords

load('/project/rg312/mat_files/heat_rates_best.mat','htrt_100')
htrt_100_ll = cube2latlon(xc,yc,htrt_100,xi,yi);
clear('htrt_100')

% ditto theta
load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat','theta_100')
theta_100_ll = cube2latlon(xc,yc,theta_100,xi,yi);
clear('theta_100')

% ditto t
load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_100')
t_100_ll = cube2latlon(xc,yc,t_100,xi,yi);
clear('t_100')

% ditto u
load('/project/rg312/mat_files/snapshot_data/uE_snapshots_best.mat','uE_100')
uE_100_ll = cube2latlon(xc,yc,uE_100,xi,yi);
clear('uE_100')

% ditto v
load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_100')
vN_100_ll = cube2latlon(xc,yc,vN_100,xi,yi);
clear('vN_100')

% load up w; this is not at pressure level centres. Use boundary condition (no normal flow at surface) to get the 26th level when reading
load('/project/rg312/mat_files/snapshot_data/w_snapshots_best.mat','w_100')
w_100_ll_half = zeros(180,90,26); w_100_ll_tav_half = zeros(180,90,26);
w_100_ll_half(:,:,1:25) = cube2latlon(xc,yc,w_100,xi,yi);
clear('w_100')

%interpolate to the same levels as u and v
rC_half = (100000:-4000:0)';
w_100_ll = shiftdim(interp1(rC_half,shiftdim(w_100_ll_half,2),rC),1);


%should now have t, theta, u, v, w, and diabatic heating all colocated on a lat-lon grid :)
