% choose directory, load grid
rDir='/project/rg312/final_runs/run_125_final/';
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

name=['/project/rg312/mat_files/snapshot_data_final/run_125/vort_125_' num2str(j) '.mat'];
load(name)
name=['/project/rg312/mat_files/snapshot_data_final/run_125/t_125_' num2str(j) '.mat'];
load(name)

xi=-179:2:180;yi=-89:2:90;

t_125_ll(:,:,:) = cube2latlon(xc,yc,t_125(:,:,1,:),xi,yi);
clear('t_125')
vort_125_ll(:,:,:) = cube2latlon(xg,yg,vort_125(:,:,1,:),xi,yi);
clear('vort_125')

radius = 6371.0e3;
f = 10^-4; 

[dTdy_125,dTdx_125] = gradient(t_125_ll,pi./90);
dTdy_125 = dTdy_125./radius;


for i=1:90
dTdx_125(:,i,:) = dTdx_125(:,i,:)./cos(yi(i).*pi./180)./radius;
end

dTgrad_125 = sqrt(dTdy_125.^2 + dTdx_125.^2);
arnaud_diag_125 = dTgrad_125.*vort_125_ll./(f./100./1000);
arnaud_diag_125(:,1:45,:) = -1.*arnaud_diag_125(:,1:45,:);


name=['/project/rg312/mat_files/snapshot_data_final/run_125/arnaud_diag_125_' num2str(j) '.mat'];
save(name,'arnaud_diag_125')

end
