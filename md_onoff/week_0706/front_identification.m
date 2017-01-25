%load in snapshots of temperature and relative vorticity. 
%calculate the magnitiude of the temperature gradient and multiply with vorticity, see if we see fronts..


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
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
yi=-89:2:89;
xi = -179:2:179;

load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/t_000_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_100/t_100_5.mat')

load('/project/rg312/mat_files/snapshot_data_final/vorticity_data.mat')


%transfer t to ll
xi=-179:2:180;yi=-89:2:90;

t_000_ll(:,:,:) = cube2latlon(xc,yc,t_000(:,:,1,:),xi,yi);
t_100_ll(:,:,:) = cube2latlon(xc,yc,t_100(:,:,1,:),xi,yi);
clear('t_000','t_100')

vort_000_ll(:,:,:) = cube2latlon(xg,yg,vort_000(:,:,1,:),xi,yi);
vort_100_ll(:,:,:) = cube2latlon(xg,yg,vort_100(:,:,1,:),xi,yi);
clear('vort_000','vort_100')


radius = 6371.0e3;
f = 10^-4; 

[dTdy_000,dTdx_000] = gradient(t_000_ll,pi./90);
dTdy_000 = dTdy_000./radius;
[dTdy_100,dTdx_100] = gradient(t_100_ll,pi./90);
dTdy_100 = dTdy_100./radius;

for i=1:90
dTdx_000(:,i,:) = dTdx_000(:,i,:)./cos(yi(i).*pi./180)./radius;
dTdx_100(:,i,:) = dTdx_100(:,i,:)./cos(yi(i).*pi./180)./radius;
end

dTgrad_000 = sqrt(dTdy_000.^2 + dTdx_000.^2);
dTgrad_100 = sqrt(dTdy_100.^2 + dTdx_100.^2);

arnaud_diag_000 = dTgrad_000.*vort_000_ll./(f./100./1000);
arnaud_diag_100 = dTgrad_100.*vort_100_ll./(f./100./1000);

arnaud_diag_000(:,1:45,:) = -1.*arnaud_diag_000(:,1:45,:);
arnaud_diag_100(:,1:45,:) = -1.*arnaud_diag_100(:,1:45,:);


save('/project/rg312/mat_files/snapshot_data_final/front_diag.mat', 'arnaud_diag_000', 'arnaud_diag_100')
