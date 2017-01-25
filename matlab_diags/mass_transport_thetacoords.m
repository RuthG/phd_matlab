%plot up mass transport streamfunction in potential temperature coordinates

%load in output from daily_data.m which reads in MITgcm output for theta and V
load('daily_data_T.mat')
load('daily_data_V.mat')

rDir='./';
%Read in pressure levels
rC=squeeze(rdmds([rDir,'RC']));

%Define constants
g=9.80;					%gravity
rad=6371.0e3;				%radius of earth
dtr=pi/180;				%conversion from deg to radians
layers=200.;				%no of theta layers to use
deltap=1000.;				%width of pressure layers to interpolate onto
yr=360.;
time=single(1.:360.);
xi=-179:2:180;
yi=-89:2:90;

%define pressure layers to interpolate onto
rC_h=single(98000.:-deltap:2000.);

'Calculating deltax'
deltax=single(2.*pi*rad*cos(yi*dtr)/size(xi,2));


'Defining potential temperature layers'
mintheta=min(min(min(min(thetall))));
maxtheta=400.;       %max(max(max(max(thetall))));
spacing=single((maxtheta-mintheta)/layers);
theta_layers=single(mintheta+spacing*(0:layers-1)+spacing/2.);		%centre of theta layers
theta_ranges=single(mintheta+spacing*(0:layers));			%range covered by each theta layer

'Set any nans to 0'
thetall(isnan(thetall))=0.;
vNll(isnan(vNll))=0.;

%Shift dimensions of thetall for interpolation
thetall=shiftdim(thetall,2);
vNll=shiftdim(vNll,2);

'Interpolating Theta field'
thetall_h=single(zeros(size(rC_h,2),360,180,90));	%zonal av theta (fine res)
thetall_h = interp1(rC,thetall,rC_h);
clear thetall

'Interpolating Velocity field'
vNll_h=single(zeros(size(rC_h,2),360,180,90));		%zonal av merid vel (fine res)
vNll_h = interp1(rC,vNll,rC_h);
clear vNll

%Shift interpolated arrays back to normal (long, lat, press, time)
thetall_h=shiftdim(thetall_h,2);
vNll_h=shiftdim(vNll_h,2);

'Calculating deltam'
%Calculate delta m at each point on high res grid
deltam=single(zeros(size(vNll_h)));
%calculate dpdx/g = -rho dxdz
pxg=single(deltap*deltax/g);
%multiply vNll_h by rhodxdz to get delta m
deltam=bsxfun(@times,vNll_h,pxg);

clear vNll_h

%allocate matrix for mass trans in theta layers
m_in_t=single(zeros(90,layers));

'deltam calculated, start mask loop w counter j'

for j=1:layers
j		%show counter to stop yourself going mad

%define a mask that identifies positions in m_in_t where theta is in a given range
  mask=(thetall_h>=theta_ranges(j) & thetall_h<theta_ranges(j+1));
  h=single(mask);

%This line:
%1) multiplies deltam by a logic mask to identify where theta is in the range we want to sum over
%2) sums over longitude
%3) sums over pressure levels
%4) averages over time 
%which gives the total time average deltam = V rho dxdz on each theta layer

  m_in_t(:,j)=mean(sum(sum(deltam.*h,1),3),4);
end

%identify mean theta at the surface at each latitude. 
ground=mean(mean(thetall_h(:,:,1,:),1),4);

'Integrating to give meridional mass transport'
psi=zeros(90,size(theta_ranges,2));
psi(:,2:201)=cumsum(m_in_t,2)*spacing;


[C,h]=contourf(yi,theta_ranges,psi',30);
xlabel('Latitude')
ylabel('Potential Temperature, K')
colorbar
hold on
plot(yi, ground, 'LineWidth',2) 

'Saving output...'
save('daily_data_psi.mat','psi')

