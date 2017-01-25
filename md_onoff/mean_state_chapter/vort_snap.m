%load in relative vorticity and plot f+zeta snapshots for each run


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


load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/vort_000_5.mat')
vort_000_ll=cube2latlon(xc,yc,vort_000(:,:,:,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_010/vort_010_5.mat')
vort_010_ll=cube2latlon(xc,yc,vort_010(:,:,:,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_025/vort_025_5.mat')
vort_025_ll=cube2latlon(xc,yc,vort_025(:,:,:,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_050/vort_050_5.mat')
vort_050_ll=cube2latlon(xc,yc,vort_050(:,:,:,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_075/vort_075_5.mat')
vort_075_ll=cube2latlon(xc,yc,vort_075(:,:,:,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_100/vort_100_5.mat')
vort_100_ll=cube2latlon(xc,yc,vort_100(:,:,:,day100),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_125/vort_125_5.mat')
vort_125_ll=cube2latlon(xc,yc,vort_125(:,:,:,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_150/vort_150_5.mat')
vort_150_ll=cube2latlon(xc,yc,vort_150(:,:,:,day000),xi,yi);


f = zeros(180,90,25);
omega = 2.*pi./(24.*60.*60);

for i=1:90
f(:,i,:) = 2.*omega.*sin(yi(i).*pi./180);
end

