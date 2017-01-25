% choose directory, load grid
rDir='/project/rg312/final_runs/run_010_final/';
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

name=['/project/rg312/mat_files/snapshot_data_final/run_010/vort_010_' num2str(j) '.mat'];
load(name)
name=['/project/rg312/mat_files/snapshot_data_final/run_010/t_010_' num2str(j) '.mat'];
load(name)

xi=-179:2:180;yi=-89:2:90;

t_010_ll(:,:,:) = cube2latlon(xc,yc,t_010(:,:,1,:),xi,yi);
clear('t_010')
vort_010_ll(:,:,:) = cube2latlon(xg,yg,vort_010(:,:,1,:),xi,yi);
clear('vort_010')

radius = 6371.0e3;
f = 10^-4; 

[dTdy_010,dTdx_010] = gradient(t_010_ll,pi./90);
dTdy_010 = dTdy_010./radius;


for i=1:90
dTdx_010(:,i,:) = dTdx_010(:,i,:)./cos(yi(i).*pi./180)./radius;
end

dTgrad_010 = sqrt(dTdy_010.^2 + dTdx_010.^2);
arnaud_diag_010 = dTgrad_010.*vort_010_ll./(f./100./1000);
arnaud_diag_010(:,1:45,:) = -1.*arnaud_diag_010(:,1:45,:);


name=['/project/rg312/mat_files/snapshot_data_final/run_010/arnaud_diag_010_' num2str(j) '.mat'];
save(name,'arnaud_diag_010')

end
