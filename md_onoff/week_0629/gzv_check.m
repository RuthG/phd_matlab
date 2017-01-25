%load up geopotential and check magnitude of contribution to this when not integrated over whole atmosphere

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
L = 2.500e6;
cp = 287.04./(2./7.);

run = '100';
year = 5;

t_var = ['t_' run];
q_var = ['q_' run];
ph_var = ['ph_' run];
vN_var = ['vN_' run];

load(['/project/rg312/mat_files/snapshot_data_final/run_' run '/vN_' run '_timemean.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_' run '/t_' run '_timemean.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_' run '/q_' run '_timemean.mat']);

vN_cs = load(['/project/rg312/mat_files/snapshot_data_final/run_' run '/vN_' run '_' num2str(year) '.mat'],vN_var);
vN_cs = vN_cs.(vN_var);
vN_ll = squeeze(cube2latlon(xc,yc,vN_cs,xi,yi));
vN_ed = vN_ll - repmat(vN_ll_tav,[1 1 1 360]);
%clear('vN_ll')

t_cs = load(['/project/rg312/mat_files/snapshot_data_final/run_' run '/t_' run '_' num2str(year) '.mat'],t_var);
t_cs = t_cs.(t_var);
t_ll = squeeze(cube2latlon(xc,yc,t_cs,xi,yi));
t_ed = t_ll - repmat(t_ll_tav,[1 1 1 360]);
%clear('t_ll')

q_cs = load(['/project/rg312/mat_files/snapshot_data_final/run_' run '/q_' run '_' num2str(year) '.mat'],q_var);
q_cs = q_cs.(q_var);
q_ll = squeeze(cube2latlon(xc,yc,q_cs,xi,yi));
q_ed = q_ll - repmat(q_ll_tav,[1 1 1 360]);
%clear('q_ll')

ph_cs = load(['/project/rg312/mat_files/snapshot_data_final/run_' run '/ph_' run '_' num2str(year) '.mat'],ph_var);
ph_cs = ph_cs.(ph_var);
ph_ll = squeeze(cube2latlon(xc,yc,ph_cs,xi,yi));
ph_ed = ph_ll - repmat(mean(ph_ll,4),[1 1 1 360]);
%clear('ph_ll')




