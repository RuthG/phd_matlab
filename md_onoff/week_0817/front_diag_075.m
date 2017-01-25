% choose directory, load grid
rDir='/project/rg312/final_runs/run_075_final/';
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

name=['/project/rg312/mat_files/snapshot_data_final/run_075/vort_075_' num2str(j) '.mat'];
load(name)
name=['/project/rg312/mat_files/snapshot_data_final/run_075/t_075_' num2str(j) '.mat'];
load(name)

xi=-179:2:180;yi=-89:2:90;

t_075_ll(:,:,:) = cube2latlon(xc,yc,t_075(:,:,1,:),xi,yi);
clear('t_075')
vort_075_ll(:,:,:) = cube2latlon(xg,yg,vort_075(:,:,1,:),xi,yi);
clear('vort_075')

radius = 6371.0e3;
f = 10^-4; 

[dTdy_075,dTdx_075] = gradient(t_075_ll,pi./90);
dTdy_075 = dTdy_075./radius;


for i=1:90
dTdx_075(:,i,:) = dTdx_075(:,i,:)./cos(yi(i).*pi./180)./radius;
end

dTgrad_075 = sqrt(dTdy_075.^2 + dTdx_075.^2);
arnaud_diag_075 = dTgrad_075.*vort_075_ll./(f./100./1000);
arnaud_diag_075(:,1:45,:) = -1.*arnaud_diag_075(:,1:45,:);


name=['/project/rg312/mat_files/snapshot_data_final/run_075/arnaud_diag_075_' num2str(j) '.mat'];
save(name,'arnaud_diag_075')

end
