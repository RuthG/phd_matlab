% choose directory, load grid
rDir='/project/rg312/final_runs/run_150_final/';
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

name=['/project/rg312/mat_files/snapshot_data_final/run_150/vort_150_' num2str(j) '.mat'];
load(name)
name=['/project/rg312/mat_files/snapshot_data_final/run_150/t_150_' num2str(j) '.mat'];
load(name)

xi=-179:2:180;yi=-89:2:90;

t_150_ll(:,:,:) = cube2latlon(xc,yc,t_150(:,:,1,:),xi,yi);
clear('t_150')
vort_150_ll(:,:,:) = cube2latlon(xg,yg,vort_150(:,:,1,:),xi,yi);
clear('vort_150')

radius = 6371.0e3;
f = 10^-4; 

[dTdy_150,dTdx_150] = gradient(t_150_ll,pi./90);
dTdy_150 = dTdy_150./radius;


for i=1:90
dTdx_150(:,i,:) = dTdx_150(:,i,:)./cos(yi(i).*pi./180)./radius;
end

dTgrad_150 = sqrt(dTdy_150.^2 + dTdx_150.^2);
arnaud_diag_150 = dTgrad_150.*vort_150_ll./(f./100./1000);
arnaud_diag_150(:,1:45,:) = -1.*arnaud_diag_150(:,1:45,:);


name=['/project/rg312/mat_files/snapshot_data_final/run_150/arnaud_diag_150_' num2str(j) '.mat'];
save(name,'arnaud_diag_150')

end
