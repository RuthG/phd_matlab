%load up u and v for a snapshot for each experiment and plot quiver plots in jet

rDir='/project/rg312/final_runs/run_000_final_noshallow/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
drC=squeeze(rdmds([rDir,'DRC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
xi=-179:2:179;
yi=-89:2:89;


day000 = 1;
day100 = 61;

load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/uE_000_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/vN_000_5.mat')
uE_000_ll=cube2latlon(xc,yc,uE_000(:,:,:,day000),xi,yi);
vN_000_ll=cube2latlon(xc,yc,vN_000(:,:,:,day000),xi,yi);

load('/project/rg312/mat_files/snapshot_data_final/run_010/uE_010_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_010/vN_010_5.mat')
uE_010_ll=cube2latlon(xc,yc,uE_010(:,:,:,day000),xi,yi);
vN_010_ll=cube2latlon(xc,yc,vN_010(:,:,:,day000),xi,yi);

load('/project/rg312/mat_files/snapshot_data_final/run_025/uE_025_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_025/vN_025_5.mat')
uE_025_ll=cube2latlon(xc,yc,uE_025(:,:,:,day000),xi,yi);
vN_025_ll=cube2latlon(xc,yc,vN_025(:,:,:,day000),xi,yi);

load('/project/rg312/mat_files/snapshot_data_final/run_050/uE_050_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_050/vN_050_5.mat')
uE_050_ll=cube2latlon(xc,yc,uE_050(:,:,:,day000),xi,yi);
vN_050_ll=cube2latlon(xc,yc,vN_050(:,:,:,day000),xi,yi);

load('/project/rg312/mat_files/snapshot_data_final/run_075/uE_075_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_075/vN_075_5.mat')
uE_075_ll=cube2latlon(xc,yc,uE_075(:,:,:,day000),xi,yi);
vN_075_ll=cube2latlon(xc,yc,vN_075(:,:,:,day000),xi,yi);

load('/project/rg312/mat_files/snapshot_data_final/run_100/uE_100_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_100/vN_100_5.mat')
uE_100_ll=cube2latlon(xc,yc,uE_100(:,:,:,day100),xi,yi);
vN_100_ll=cube2latlon(xc,yc,vN_100(:,:,:,day100),xi,yi);

load('/project/rg312/mat_files/snapshot_data_final/run_125/uE_125_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_125/vN_125_5.mat')
uE_125_ll=cube2latlon(xc,yc,uE_125(:,:,:,day000),xi,yi);
vN_125_ll=cube2latlon(xc,yc,vN_125(:,:,:,day000),xi,yi);

load('/project/rg312/mat_files/snapshot_data_final/run_150/uE_150_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_150/vN_150_5.mat')
uE_150_ll=cube2latlon(xc,yc,uE_150(:,:,:,day000),xi,yi);
vN_150_ll=cube2latlon(xc,yc,vN_150(:,:,:,day000),xi,yi);




