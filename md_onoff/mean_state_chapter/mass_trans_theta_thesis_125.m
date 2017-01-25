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

%Define constants
g=9.80;	%gravity
rad=6371.0e3; %radius of earth
dtr=pi/180; %conversion from deg to radians
layers=100.; %no of theta layers to use
deltalam = 2.*pi./180.;	%width of xi spacing	

mintheta = 265;
maxtheta=400.;
spacing=single((maxtheta-mintheta)/layers);
theta_layers=mintheta+spacing*(0:layers-1)+spacing/2.;	%centre of theta layers
theta_ranges=mintheta+spacing*(0:layers); %range covered by each theta layer

for modelyear = 1:10
modelyear 

load(['/project/rg312/mat_files/snapshot_data_final/run_125/vN_125_' num2str(modelyear) '.mat'])
vNll=cube2latlon(xc,yc,vN_125,xi,yi);

for i=1:90
integrand(:,i,:,:) = vNll(:,i,:,:).*rad.*cos(yi(i)*dtr)./g.*4000.*deltalam;
end

load(['/project/rg312/mat_files/snapshot_data_final/run_125/theta_125_' num2str(modelyear) '.mat'])
thetall=cube2latlon(xc,yc,theta_125,xi,yi);

%allocate matrix for mass trans in theta layers
m_in_t=single(zeros(180,90,layers,360));

for dayno = 1:360
[modelyear, dayno]

for j=1:layers
%j %show counter to stop yourself going mad

%define a mask that identifies positions where theta is in a given range
  mask=+(thetall(:,:,:,dayno)>=theta_ranges(j) & thetall(:,:,:,dayno)<theta_ranges(j+1));

%This line:
%1) multiplies integrand by a logic mask to identify where theta is in the range we want to sum over
%2) sums contributions at each pressure level, weighted with the pressure level width
  m_in_t(:,:,j,dayno)=sum(integrand(:,:,:,dayno).*mask,3);

end
end

psi = cumsum(m_in_t,3);
psi_mean(:,:,modelyear) = squeeze(mean(sum(psi,1),4));

end

psi_mean = mean(psi_mean,3);

save('/project/rg312/mat_files/chapter2_variables/psi_theta_125.mat','psi_mean')