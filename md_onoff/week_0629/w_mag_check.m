%load up w data and check approx that this is small in the boundary layer is ok

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
yi=-89:2:89;
xi = -179:2:179;
a = 6371.0e3;

load('/project/rg312/mat_files/snapshot_data_final/run_000/t_000_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_100/t_100_5.mat')

t_000_ll = cube2latlon(xc,yc,t_000,xi,yi);
t_100_ll = cube2latlon(xc,yc,t_100,xi,yi);

[dTdx_000,dTdy_000,dTdp_000,c] = gradient(t_000_ll,pi./90,pi./90,-4000,1);
[dTdx_100,dTdy_100,dTdp_100,c] = gradient(t_100_ll,pi./90,pi./90,-4000,1);

dTdy_000 = dTdy_000./a; dTdy_100 = dTdy_100./a;


load('/project/rg312/mat_files/snapshot_data_final/run_000/w_000_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_100/w_100_5.mat')

w_000_ll = cube2latlon(xc,yc,w_000,xi,yi);
w_100_ll = cube2latlon(xc,yc,w_100,xi,yi);
w_000_ed = w_000_ll - repmat(mean(w_000_ll,4),[1 1 1 360]);
w_100_ed = w_100_ll - repmat(mean(w_100_ll,4),[1 1 1 360]);

load('/project/rg312/mat_files/snapshot_data_final/run_000/vN_000_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_100/vN_100_5.mat')

vN_000_ll = cube2latlon(xc,yc,vN_000,xi,yi);
vN_100_ll = cube2latlon(xc,yc,vN_100,xi,yi);
vN_000_ed = vN_000_ll - repmat(mean(vN_000_ll,4),[1 1 1 360]);
vN_100_ed = vN_100_ll - repmat(mean(vN_100_ll,4),[1 1 1 360]);

