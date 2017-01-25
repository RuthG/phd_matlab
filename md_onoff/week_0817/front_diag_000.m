% choose directory, load grid
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
yi = -89:2:89;

for j=1:10

name=['/project/rg312/mat_files/snapshot_data_final/run_000_ns/vort_000_' num2str(j) '.mat'];
load(name)
name=['/project/rg312/mat_files/snapshot_data_final/run_000_ns/t_000_' num2str(j) '.mat'];
load(name)

xi=-179:2:180;yi=-89:2:90;

t_000_ll(:,:,:) = cube2latlon(xc,yc,t_000(:,:,1,:),xi,yi);
clear('t_000')
vort_000_ll(:,:,:) = cube2latlon(xg,yg,vort_000(:,:,1,:),xi,yi);
clear('vort_000')

radius = 6371.0e3;
f = 10^-4; 

[dTdy_000,dTdx_000] = gradient(t_000_ll,pi./90);
dTdy_000 = dTdy_000./radius;


for i=1:90
dTdx_000(:,i,:) = dTdx_000(:,i,:)./cos(yi(i).*pi./180)./radius;
end

dTgrad_000 = sqrt(dTdy_000.^2 + dTdx_000.^2);
arnaud_diag_000 = dTgrad_000.*vort_000_ll./(f./100./1000);
arnaud_diag_000(:,1:45,:) = -1.*arnaud_diag_000(:,1:45,:);


name=['/project/rg312/mat_files/snapshot_data_final/run_000_ns/arnaud_diag_000_' num2str(j) '.mat'];
save(name,'arnaud_diag_000')

end
