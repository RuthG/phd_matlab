%plot up mass transport streamfunction in potential temperature coordinates

rDir='/project/rg312/final_runs/run_000_final_noshallow/';
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


load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/theta_000_1.mat'])
load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/vN_000_1.mat'])
vNll=cube2latlon(xc,yc,vN_000,xi,yi);
thetall=cube2latlon(xc,yc,theta_000,xi,yi);



%Define constants
g=9.80;					%gravity
rad=6371.0e3;				%radius of earth
dtr=pi/180;				%conversion from deg to radians
layers=20.;				%no of theta layers to use
deltap=1000.;				%width of pressure layers to interpolate onto
deltalam = 2.*pi./180.;			%width of xi spacing	
yr=360.;
time=single(1.:360.);
xi=-179:2:180;
yi=-89:2:90;

%define pressure layers to interpolate onto
rC_h=single(98000.:-deltap:2000.);

'Set any nans to 0'
thetall(isnan(thetall))=0.;
vNll(isnan(vNll))=0.;



'Interpolating Velocity field'
vNll=shiftdim(vNll,2);
vNll_h=single(zeros(size(rC_h,2),360,180,90));		%zonal av merid vel (fine res)
vNll_h = interp1(rC,vNll,rC_h);
clear vNll
vNll_h=shiftdim(vNll_h,2);

for i=1:90
integrand(:,i,:,:) = single(vNll_h(:,i,:,:).*rad.*cos(yi(i)*dtr)./g);
end
clear vNll_h

'Interpolating Theta field'
thetall=shiftdim(thetall,2);
thetall_h=single(zeros(size(rC_h,2),360,180,90));	%zonal av theta (fine res)
thetall_h = interp1(rC,thetall,rC_h);
%clear thetall
thetall_h=shiftdim(thetall_h,2);

'Defining potential temperature layers'
mintheta=min(min(min(min(thetall))));
maxtheta=400.;
spacing=single((maxtheta-mintheta)/layers);
%theta_layers=single(mintheta+spacing*(0:layers-1)+spacing/2.);		%centre of theta layers
theta_ranges=single(mintheta+spacing*(0:layers));			%range covered by each theta layer


'Integrate over pressure and longitude where condition on theta is satisfied'
for j=1:layers
j		%show counter to stop yourself going mad

%define a mask that identifies positions where theta is in a given range
  mask=(thetall_h>=theta_ranges(j) & thetall_h<theta_ranges(j+1));
  h=single(mask);

%allocate matrix for mass trans in theta layers
m_in_t=single(zeros(90,layers,360));

%This line:
%1) multiplies integrand by a logic mask to identify where theta is in the range we want to sum over
%2) integrates over longitude
%3) sums contributions at each pressure level, weighted with the pressure level width
  m_in_t(:,j,:)=sum(sum(integrand.*h,1),3).*deltap.*deltalam;
end

%identify mean theta at the surface at each latitude. 
ground=mean(mean(thetall_h(:,:,1,:),1),4);

'Cumulatively sum over theta to give meridional mass transport'
psi=zeros(90,size(theta_ranges,2),360);
psi(:,:)=cumsum(m_in_t,2);
'take time average'
psi_mean = mean(psi,3);
