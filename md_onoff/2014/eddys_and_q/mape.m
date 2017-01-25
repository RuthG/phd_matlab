%calculate the MAPE integrated over the storm track as defined in O'Gorman and Schneider 2008

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';
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
ny=90;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Load data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=system('find mape_data.mat');

if a > 0

i=0;
for nit = 259200:86400:604800;
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_f(:,:,:,i) = dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i) = dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_d(:,:,:,i) = dyn(:,:,:,J);

end

save('mape_data.mat')
else
load('mape_data.mat')
end

%%% Take zonal average theta to calculate eddy theta^2 and dthetadp

[theta_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_d,ny,yc,ar,hc);
[theta_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_h,ny,yc,ar,hc);
[theta_f_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_f,ny,yc,ar,hc);

%time mean of zon av theta 
theta_d_tzav = mean(theta_d_zav,3);
theta_h_tzav = mean(theta_h_zav,3);
theta_f_tzav = mean(theta_f_zav,3);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_d_tzav(:,j)=theta_d_tzav(:,j).*convthetatoT(j,1);
temp_h_tzav(:,j)=theta_h_tzav(:,j).*convthetatoT(j,1);
temp_f_tzav(:,j)=theta_f_tzav(:,j).*convthetatoT(j,1);
end

%square of tzav theta
thsq_d_zav = theta_d_tzav.^2;
thsq_h_zav = theta_h_tzav.^2;
thsq_f_zav = theta_f_tzav.^2;

%load up details of baroclinic zones
load('bc_box.mat')

% identify edges of baroclinic zone
if(mod(barzon_lats_d(1),2)==0)
min_no_d = find(abs(ylat) == barzon_lats_d(1)-1);
max_no_d = find(abs(ylat) == barzon_lats_d(2)+1);
else
min_no_d = find(abs(ylat) == barzon_lats_d(1));
max_no_d = find(abs(ylat) == barzon_lats_d(2));
end

if(mod(barzon_lats_h(1),2)==0)
min_no_h = find(abs(ylat) == barzon_lats_h(1)-1);
max_no_h = find(abs(ylat) == barzon_lats_h(2)+1);
else
min_no_h = find(abs(ylat) == barzon_lats_h(1));
max_no_h = find(abs(ylat) == barzon_lats_h(2));
end

if(mod(barzon_lats_f(1),2)==0)
min_no_f = find(abs(ylat) == barzon_lats_f(1)-1);
max_no_f = find(abs(ylat) == barzon_lats_f(2)+1);
else
min_no_f = find(abs(ylat) == barzon_lats_f(1));
max_no_f = find(abs(ylat) == barzon_lats_f(2));
end

%average theta^2 and theta over baroclinic zone

thsq_d_bzav = (mean(thsq_d_zav(max_no_d(1):min_no_d(1),:),1) + mean(thsq_d_zav(min_no_d(2):max_no_d(2),:),1))./2;
thsq_h_bzav = (mean(thsq_h_zav(max_no_h(1):min_no_h(1),:),1) + mean(thsq_h_zav(min_no_h(2):max_no_h(2),:),1))./2;
thsq_f_bzav = (mean(thsq_f_zav(max_no_f(1):min_no_f(1),:),1) + mean(thsq_f_zav(min_no_f(2):max_no_f(2),:),1))./2;

theta_d_bzav = (mean(theta_d_tzav(max_no_d(1):min_no_d(1),:),1) + mean(theta_d_tzav(min_no_d(2):max_no_d(2),:),1))./2;
theta_h_bzav = (mean(theta_h_tzav(max_no_h(1):min_no_h(1),:),1) + mean(theta_h_tzav(min_no_h(2):max_no_h(2),:),1))./2;
theta_f_bzav = (mean(theta_f_tzav(max_no_f(1):min_no_f(1),:),1) + mean(theta_f_tzav(min_no_f(2):max_no_f(2),:),1))./2;

theta_d_bzavsq = theta_d_bzav.^2;
theta_h_bzavsq = theta_h_bzav.^2;
theta_f_bzavsq = theta_f_bzav.^2;

%calculate variance of thetasq around average over baroclinic zone
thsq_d_ed = thsq_d_bzav - theta_d_bzavsq;
thsq_h_ed = thsq_h_bzav - theta_h_bzavsq;
thsq_f_ed = thsq_f_bzav - theta_f_bzavsq;

% differentiate theta w r t p
[dthetadp_d,junk] = gradient(theta_d_tzav,-4000.);
[dthetadp_h,junk] = gradient(theta_h_tzav,-4000.);
[dthetadp_f,junk] = gradient(theta_f_tzav,-4000.);

% average this over baroclinic zone too
dthetadp_d_bzav = (mean(dthetadp_d(max_no_d(1):min_no_d(1),:),1) + mean(dthetadp_d(min_no_d(2):max_no_d(2),:),1))./2;
dthetadp_h_bzav = (mean(dthetadp_h(max_no_h(1):min_no_h(1),:),1) + mean(dthetadp_h(min_no_h(2):max_no_h(2),:),1))./2;
dthetadp_f_bzav = (mean(dthetadp_f(max_no_f(1):min_no_f(1),:),1) + mean(dthetadp_f(min_no_f(2):max_no_f(2),:),1))./2;

% use to calculate gamma factor, see O'Gorman 2008
gamma_d = -2./(7.*rC.*dthetadp_d_bzav');
gamma_h = -2./(7.*rC.*dthetadp_h_bzav');
gamma_f = -2./(7.*rC.*dthetadp_f_bzav');

%calculate integrand for MAPE calculation
integrand_d = gamma_d.*(rC./10^5).^(2./7).*thsq_d_ed';
integrand_h = gamma_h.*(rC./10^5).^(2./7).*thsq_h_ed';
integrand_f = gamma_f.*(rC./10^5).^(2./7).*thsq_f_ed';

%calculate constants for MAPE calculation
cp = 1004;
g = 9.81;
a = 6371.0e3;
prefactor = cp.*10^5./(2.*9.81); 
dsigma = 4000/101325.0;

%MAPE!!!!!!! YAY!!!!!
mape_d = sum(integrand_d(3:level_d)).*dsigma.*prefactor;
mape_h = sum(integrand_h(3:level_h)).*dsigma.*prefactor;
mape_f = sum(integrand_f(3:level_f)).*dsigma.*prefactor;


%Also calculate 'approx MAPE'

prefac2 = cp.*10^5./(24.*g);
sigma_diff_d = 0.9 - rC(level_d)./101325.0;
sigma_diff_h = 0.9 - rC(level_h)./101325.0;
sigma_diff_f = 0.9 - rC(level_f)./101325.0;

gamma_d_vav = mean(gamma_d(3:level_d));
gamma_h_vav = mean(gamma_h(3:level_h));
gamma_f_vav = mean(gamma_f(3:level_f));

%calc meridional width of baroclinic region in km
merid_width = a.*((ylat(min_no_d(1)) - ylat(max_no_d(1))).*pi./180);

[junk,dtempdy_d] = gradient(temp_d_tzav,a.*pi./90);
[junk,dtempdy_h] = gradient(temp_h_tzav,a.*pi./90);
[junk,dtempdy_f] = gradient(temp_f_tzav,a.*pi./90);

dtempdy_d_bzav = (mean(-dtempdy_d(max_no_d(1):min_no_d(1),:),1) + mean(dtempdy_d(min_no_d(2):max_no_d(2),:),1))./2;
dtempdy_h_bzav = (mean(-dtempdy_h(max_no_h(1):min_no_h(1),:),1) + mean(dtempdy_h(min_no_h(2):max_no_h(2),:),1))./2;
dtempdy_f_bzav = (mean(-dtempdy_f(max_no_f(1):min_no_f(1),:),1) + mean(dtempdy_f(min_no_f(2):max_no_f(2),:),1))./2;

dtempdy_d_bvav = mean(dtempdy_d_bzav(3:level_d));
dtempdy_h_bvav = mean(dtempdy_h_bzav(3:level_h));
dtempdy_f_bvav = mean(dtempdy_f_bzav(3:level_f));

approx_mape_d = prefac2.*sigma_diff_d.*merid_width.^2.*gamma_d_vav.*dtempdy_d_bvav.^2;
approx_mape_h = prefac2.*sigma_diff_h.*merid_width.^2.*gamma_h_vav.*dtempdy_h_bvav.^2;
approx_mape_f = prefac2.*sigma_diff_f.*merid_width.^2.*gamma_f_vav.*dtempdy_f_bvav.^2;

save('mape_data.mat')
v1 = [mape_d, mape_h, mape_f];
v2 = [approx_mape_d, approx_mape_h, approx_mape_f];
