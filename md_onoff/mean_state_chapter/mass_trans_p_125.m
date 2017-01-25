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
drC=squeeze(rdmds([rDir,'DRC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
xi=-179:2:179;
yi=-89:2:89;

for j=1:10
j

load(['/project/rg312/mat_files/snapshot_data_final/run_125/vN_125_' num2str(j) '.mat'])
vN_ll=cube2latlon(xc,yc,vN_125,xi,yi);

g=9.80;					%gravity
rad=6371.0e3;				%radius of earth
dtr=pi/180;				%conversion from deg to radians
xi=-179:2:180;
yi=-89:2:90;

deltap = 4000;
deltalam = 2.*pi./180.;


integrand = zeros(size(vN_ll));

'Calculating integrand: v.a.cos(phi)/g'
for i=1:90
integrand(:,i,:,:) = rad.*vN_ll(:,i,:,:).*cos(yi(i).*dtr)./g;
end

%'integrate over pressure from p to p_surf'
%integral_p = -1*cumsum(integrand.*deltap,3);

'integrate over pressure from 0 to p'
integral_p = flipdim(cumsum(flipdim(integrand,3).*deltap,3),3);

'integrate over longitude from 0 to 2*pi'
integral_lam(:,:,:) = sum(integral_p.*deltalam,1);

'Take time average'
psi_125(:,:,j) = mean(integral_lam,3);

end

psi_125 = mean(psi_125,3);

for i=1:45
psi_125_hzav(46-i,:) = (-1*psi_125(i,:) + psi_125(91-i,:))./2;
end

save('/project/rg312/mat_files/chapter2_variables/psi_tav_125.mat','psi_125','psi_125_hzav')
