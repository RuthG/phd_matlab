%plot up mass transport streamfunction in pressure coordinates

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Ctrl %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%load in output from daily_data.m which reads in MITgcm output for V
'Loading MITgcm data'
load('daily_data_V_ctrl.mat')

%Read in pressure levels
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_2yeardaily_pert/';
rC=squeeze(rdmds([rDir,'RC']));

%Define constants
g=9.80;					%gravity
rad=6371.0e3;				%radius of earth
dtr=pi/180;				%conversion from deg to radians
xi=-179:2:180;
yi=-89:2:90;

deltap = 4000;
deltalam = 2.*pi./180.

integrand = zeros(size(vNll_ctrl));

'Calculating integrand: v.a.cos(phi)/g'
for i=1:90
integrand(:,i,:,:) = rad.*vNll_ctrl(:,i,:,:).*cos(yi(i).*dtr)./g;
end

%'integrate over pressure from p to p_surf'
%integral_p = -1*cumsum(integrand.*deltap,3);

'integrate over pressure from 0 to p'
integral_p = flipdim(cumsum(flipdim(integrand,3).*deltap,3),3);

'integrate over longitude from 0 to 2*pi'
integral_lam(:,:,:) = sum(integral_p.*deltalam,1);

'Take time average'
psi_ctrl = mean(integral_lam,3);

for i=1:45
psi_ctrl_hzav(46-i,:) = (-1*psi_ctrl(i,:) + psi_ctrl(91-i,:))./2;
end

conts = -200:20:200;
contourf(yi,rC,psi_ctrl'./1e9,conts) 
set(gca,'YDir','reverse')
colorbar 
print('psi_ctrl.png','-dpng')
save('daily_data_psi_pressurecoords_ctrl.mat','psi_ctrl_hzav')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Pert %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%load in output from daily_data.m which reads in MITgcm output for V
rDir='./';
'Loading MITgcm data'
load('daily_data_V_pert.mat')

%Read in pressure levels
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_2yeardaily_pert/';
rC=squeeze(rdmds([rDir,'RC']));

%Define constants
g=9.80;					%gravity
rad=6371.0e3;				%radius of earth
dtr=pi/180;				%conversion from deg to radians
xi=-179:2:180;
yi=-89:2:90;

deltap = 4000;
deltalam = 2.*pi./180.

integrand = zeros(size(vNll_pert));

'Calculating integrand: v.a.cos(phi)/g'
for i=1:90
integrand(:,i,:,:) = rad.*vNll_pert(:,i,:,:).*cos(yi(i).*dtr)./g;
end

%'integrate over pressure from p to p_surf'
%integral_p = -1*cumsum(integrand.*deltap,3);

'integrate over pressure from 0 to p'
integral_p = flipdim(cumsum(flipdim(integrand,3).*deltap,3),3);

'integrate over longitude from 0 to 2*pi'
integral_lam(:,:,:) = sum(integral_p.*deltalam,1);

'Take time average'
psi_pert = mean(integral_lam,3);

for i=1:45
psi_pert_hzav(46-i,:) = (-1*psi_pert(i,:) + psi_pert(91-i))./2;
end

conts = -200:20:200;
contourf(yi,rC,psi_pert'./1e9,conts) 
set(gca,'YDir','reverse')
colorbar 
print('psi_pert.png','-dpng')
save('daily_data_psi_pressurecoords_pert.mat','psi_pert_hzav')

return



%define pressure layers to interpolate onto
rC_h=single(98000.:-deltap:2000.);

'Calculating deltax'
deltax=single(2.*pi*rad*cos(yi*dtr)/size(xi,2));

vNll(isnan(vNll))=0.;

%Shift dimensions of vNll for interpolation
vNll=shiftdim(vNll,2);

'Interpolating Velocity field'
vNll_h=single(zeros(size(rC_h,2),360,180,90));		%zonal av merid vel (fine res)
vNll_h = interp1(rC,vNll,rC_h);
clear vNll

%Shift interpolated arrays back to normal (long, lat, press, time)
vNll_h=shiftdim(vNll_h,2);

'Calculating deltam'
%Calculate delta m at each point on high res grid
deltam=single(zeros(size(vNll_h)));
%calculate dpdx/g = -rho dxdz
pxg=single(deltap*deltax/g);
%multiply vNll_h by rhodxdz to get delta m
deltam=bsxfun(@times,vNll_h,pxg);

clear vNll_h

%Sum deltam over longitude and average over time to get 2D matrix in lat and pressure
m_in_p(:,:)=mean(sum(deltam,1),4);


'Integrating to give meridional mass transport'
psi=zeros(size(m_in_p));
psi(:,:)=cumsum(m_in_p,2).*deltap;

[C,h]=contourf(yi,rC_h,psi',30);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
colorbar
hold on

'Saving output...'
save('daily_data_psi_pressurecoords.mat','psi')

