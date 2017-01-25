% choose directory, load grid
rDir='/project/rg312/final_runs/run_050_final_tropheat/';
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

name=['/project/rg312/mat_files/snapshot_data_final/run_th/vort_th_' num2str(j) '.mat'];
load(name)
name=['/project/rg312/mat_files/snapshot_data_final/run_th/t_th_' num2str(j) '.mat'];
load(name)

xi=-179:2:180;yi=-89:2:90;

t_th_ll(:,:,:) = cube2latlon(xc,yc,t_th(:,:,1,:),xi,yi);
clear('t_th')
vort_th_ll(:,:,:) = cube2latlon(xg,yg,vort_th(:,:,1,:),xi,yi);
clear('vort_th')

radius = 6371.0e3;
f = 10^-4; 

[dTdy_th,dTdx_th] = gradient(t_th_ll,pi./90);
dTdy_th = dTdy_th./radius;


for i=1:90
dTdx_th(:,i,:) = dTdx_th(:,i,:)./cos(yi(i).*pi./180)./radius;
end

dTgrad_th = sqrt(dTdy_th.^2 + dTdx_th.^2);
arnaud_diag_th = dTgrad_th.*vort_th_ll./(f./100./1000);
arnaud_diag_th(:,1:45,:) = -1.*arnaud_diag_th(:,1:45,:);


name=['/project/rg312/mat_files/snapshot_data_final/run_th/arnaud_diag_th_' num2str(j) '.mat'];
save(name,'arnaud_diag_th')

end
