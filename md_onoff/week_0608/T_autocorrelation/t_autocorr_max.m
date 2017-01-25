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
yi=-89:2:89;
xi = -179:2:179;

load('/project/rg312/mat_files/t_ac_l13_000.mat')
t_ac_max_000 = squeeze(max(max(t_ac)));

load('/project/rg312/mat_files/t_ac_l13_010.mat')
t_ac_max_010 = squeeze(max(max(t_ac)));

load('/project/rg312/mat_files/t_ac_l13_025.mat')
t_ac_max_025 = squeeze(max(max(t_ac)));

load('/project/rg312/mat_files/t_ac_l13_050.mat')
t_ac_max_050 = squeeze(max(max(t_ac)));

load('/project/rg312/mat_files/t_ac_l13_075.mat')
t_ac_max_075 = squeeze(max(max(t_ac)));

load('/project/rg312/mat_files/t_ac_l13_100.mat')
t_ac_max_100 = squeeze(max(max(t_ac)));
