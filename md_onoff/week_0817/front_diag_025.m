% choose directory, load grid
rDir='/project/rg312/final_runs/run_025_final/';
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

name=['/project/rg312/mat_files/snapshot_data_final/run_025/vort_025_' num2str(j) '.mat'];
load(name)
name=['/project/rg312/mat_files/snapshot_data_final/run_025/t_025_' num2str(j) '.mat'];
load(name)

xi=-179:2:180;yi=-89:2:90;

t_025_ll(:,:,:) = cube2latlon(xc,yc,t_025(:,:,1,:),xi,yi);
clear('t_025')
vort_025_ll(:,:,:) = cube2latlon(xg,yg,vort_025(:,:,1,:),xi,yi);
clear('vort_025')

radius = 6371.0e3;
f = 10^-4; 

[dTdy_025,dTdx_025] = gradient(t_025_ll,pi./90);
dTdy_025 = dTdy_025./radius;


for i=1:90
dTdx_025(:,i,:) = dTdx_025(:,i,:)./cos(yi(i).*pi./180)./radius;
end

dTgrad_025 = sqrt(dTdy_025.^2 + dTdx_025.^2);
arnaud_diag_025 = dTgrad_025.*vort_025_ll./(f./100./1000);
arnaud_diag_025(:,1:45,:) = -1.*arnaud_diag_025(:,1:45,:);


name=['/project/rg312/mat_files/snapshot_data_final/run_025/arnaud_diag_025_' num2str(j) '.mat'];
save(name,'arnaud_diag_025')

end
