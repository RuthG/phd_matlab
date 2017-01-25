% choose directory, load grid
rDir='/project/rg312/final_runs/run_050_final/';
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

name=['/project/rg312/mat_files/snapshot_data_final/run_050/vort_050_' num2str(j) '.mat'];
load(name)
name=['/project/rg312/mat_files/snapshot_data_final/run_050/t_050_' num2str(j) '.mat'];
load(name)

xi=-179:2:180;yi=-89:2:90;

t_050_ll(:,:,:) = cube2latlon(xc,yc,t_050(:,:,1,:),xi,yi);
clear('t_050')
vort_050_ll(:,:,:) = cube2latlon(xg,yg,vort_050(:,:,1,:),xi,yi);
clear('vort_050')

radius = 6371.0e3;
f = 10^-4; 

[dTdy_050,dTdx_050] = gradient(t_050_ll,pi./90);
dTdy_050 = dTdy_050./radius;


for i=1:90
dTdx_050(:,i,:) = dTdx_050(:,i,:)./cos(yi(i).*pi./180)./radius;
end

dTgrad_050 = sqrt(dTdy_050.^2 + dTdx_050.^2);
arnaud_diag_050 = dTgrad_050.*vort_050_ll./(f./100./1000);
arnaud_diag_050(:,1:45,:) = -1.*arnaud_diag_050(:,1:45,:);


name=['/project/rg312/mat_files/snapshot_data_final/run_050/arnaud_diag_050_' num2str(j) '.mat'];
save(name,'arnaud_diag_050')

end
