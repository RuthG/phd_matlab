% choose directory, load grid
rDir='/project/rg312/final_runs/run_100_final/';
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

name=['/project/rg312/mat_files/snapshot_data_final/run_100/vort_100_' num2str(j) '.mat'];
load(name)
name=['/project/rg312/mat_files/snapshot_data_final/run_100/t_100_' num2str(j) '.mat'];
load(name)

xi=-179:2:180;yi=-89:2:90;

t_100_ll(:,:,:) = cube2latlon(xc,yc,t_100(:,:,1,:),xi,yi);
clear('t_100')
vort_100_ll(:,:,:) = cube2latlon(xg,yg,vort_100(:,:,1,:),xi,yi);
clear('vort_100')

radius = 6371.0e3;
f = 10^-4; 

[dTdy_100,dTdx_100] = gradient(t_100_ll,pi./90);
dTdy_100 = dTdy_100./radius;


for i=1:90
dTdx_100(:,i,:) = dTdx_100(:,i,:)./cos(yi(i).*pi./180)./radius;
end

dTgrad_100 = sqrt(dTdy_100.^2 + dTdx_100.^2);
arnaud_diag_100 = dTgrad_100.*vort_100_ll./(f./100./1000);
arnaud_diag_100(:,1:45,:) = -1.*arnaud_diag_100(:,1:45,:);


name=['/project/rg312/mat_files/snapshot_data_final/run_100/arnaud_diag_100_' num2str(j) '.mat'];
save(name,'arnaud_diag_100')

end
