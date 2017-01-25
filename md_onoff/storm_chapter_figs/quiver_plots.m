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

load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/uE_000_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/vN_000_5.mat')
uE_ll=cube2latlon(xc,yc,uE_000,xi,yi);
vN_ll=cube2latlon(xc,yc,vN_000,xi,yi);
figure
quiver(xi(46:135),yi(46:90),uE_ll(46:135,46:90,20,180)',vN_ll(46:135,46:90,20,180)','k');
print('-dpng','quiver_000.png')

load('/project/rg312/mat_files/snapshot_data_final/run_010/uE_010_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_010/vN_010_5.mat')
uE_ll=cube2latlon(xc,yc,uE_010,xi,yi);
vN_ll=cube2latlon(xc,yc,vN_010,xi,yi);
figure
quiver(xi(46:135),yi(46:90),uE_ll(46:135,46:90,20,180)',vN_ll(46:135,46:90,20,180)','k');
print('-dpng','quiver_010.png')


load('/project/rg312/mat_files/snapshot_data_final/run_025/uE_025_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_025/vN_025_5.mat')
uE_ll=cube2latlon(xc,yc,uE_025,xi,yi);
vN_ll=cube2latlon(xc,yc,vN_025,xi,yi);
figure
quiver(xi(46:135),yi(46:90),uE_ll(46:135,46:90,20,180)',vN_ll(46:135,46:90,20,180)','k');
print('-dpng','quiver_025.png')


load('/project/rg312/mat_files/snapshot_data_final/run_050/uE_050_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_050/vN_050_5.mat')
uE_ll=cube2latlon(xc,yc,uE_050,xi,yi);
vN_ll=cube2latlon(xc,yc,vN_050,xi,yi);
figure
quiver(xi(46:135),yi(46:90),uE_ll(46:135,46:90,20,180)',vN_ll(46:135,46:90,20,180)','k');
print('-dpng','quiver_050.png')


load('/project/rg312/mat_files/snapshot_data_final/run_075/uE_075_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_075/vN_075_5.mat')
uE_ll=cube2latlon(xc,yc,uE_075,xi,yi);
vN_ll=cube2latlon(xc,yc,vN_075,xi,yi);
figure
quiver(xi(46:135),yi(46:90),uE_ll(46:135,46:90,20,180)',vN_ll(46:135,46:90,20,180)','k');
print('-dpng','quiver_075.png')


load('/project/rg312/mat_files/snapshot_data_final/run_100/uE_100_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_100/vN_100_5.mat')
uE_ll=cube2latlon(xc,yc,uE_100,xi,yi);
vN_ll=cube2latlon(xc,yc,vN_100,xi,yi);
figure
quiver(xi(46:135),yi(46:90),uE_ll(46:135,46:90,20,180)',vN_ll(46:135,46:90,20,180)','k');
print('-dpng','quiver_100.png')



load('/project/rg312/mat_files/snapshot_data_final/run_125/uE_125_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_125/vN_125_5.mat')
uE_ll=cube2latlon(xc,yc,uE_125,xi,yi);
vN_ll=cube2latlon(xc,yc,vN_125,xi,yi);
figure
quiver(xi(46:135),yi(46:90),uE_ll(46:135,46:90,20,180)',vN_ll(46:135,46:90,20,180)','k');
print('-dpng','quiver_125.png')



load('/project/rg312/mat_files/snapshot_data_final/run_150/uE_150_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_150/vN_150_5.mat')
uE_ll=cube2latlon(xc,yc,uE_150,xi,yi);
vN_ll=cube2latlon(xc,yc,vN_150,xi,yi);
figure
quiver(xi(46:135),yi(46:90),uE_ll(46:135,46:90,20,180)',vN_ll(46:135,46:90,20,180)','k');
print('-dpng','quiver_150.png')



