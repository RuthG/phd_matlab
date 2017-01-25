%load up data for 10 year ensemble
%want: ensemble members as single hemisphere 10 day avs (ie 90x25x6x10 (or 9 for w) arrays) and ensemble means (90x25x6)

%Read in iteration number, directory, MITgcm output and grid details

rDir='/disk1/MITgcm/verification/atm_gray_ruth/ensemble_control/';

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


%load up 10 members of ensemble
for j=0:9
i=0;
j
% label for particular day
for nit = 605040+j*14400:240:619200+j*14400; 
i=i+1
%label for particular run
nitstart = 604800+j*14400;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Tropheat 10 run%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rDir=['/disk1/MITgcm/verification/atm_gray_ruth/ensemble_doubleth/run_start_' num2str(nitstart) '/'];


[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_thd(:,:,:,i,j+1) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_thd(:,:,:,i,j+1) = dyn(:,:,:,J);
[uE_thd(:,:,:,i,j+1),vN_thd(:,:,:,i,j+1)] = rotate_uv2uvEN(ucs_thd(:,:,:,i,j+1),vcs_thd(:,:,:,i,j+1),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_thd(:,:,:,i,j+1) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
temp_thd(:,:,k,i,j+1)=theta_thd(:,:,k,i,j+1).*convthetatoT(k,1);
end

J=find(strcmp(fldList,'UV_VEL_C'));
uv_thd(:,:,:,i,j+1) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_thd(:,:,:,i,j+1) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_thd(:,:,:,i,j+1) = dyn(:,:,:,J);
[uEt_av_thd(:,:,:,i,j+1),vNt_av_thd(:,:,:,i,j+1)] = rotate_uv2uvEN(ut_av_thd(:,:,:,i,j+1),vt_av_thd(:,:,:,i,j+1),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'VVELSQ  '));
vsq_av_thd(:,:,:,i,j+1) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELSQ  '));
usq_av_thd(:,:,:,i,j+1) = dyn(:,:,:,J);

tothke_thd(:,:,:,i,j+1) = vsq_av_thd(:,:,:,i,j+1) + usq_av_thd(:,:,:,i,j+1);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_in_thd=dyn(:,:,:,J);
htrt_theta_thd(:,:,:,i,j+1)=htrt_in_thd*86400.;

end
end

'variables loaded'

%Now we have 5D arrays for U, V, theta, temp, uv, vt, ut, vsq, usq, total ke, htrt
%Need to use these to get: U, theta, EP flux/divergence, qgref, psi, eke, htrt

'calculating psi'
%%%%%%%%%%%%%%%%%%%%%%%%%% Psi  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Define constants
g=9.80;					%gravity
rad=6371.0e3;				%radius of earth
dtr=pi/180;				%conversion from deg to radians
xi=-179:2:180;
yi=-89:2:90;

deltap = 4000;
deltalam = 2.*pi./180.;

integrand = zeros(size(vN_thd));

for j=1:10
for i=1:60
for k=1:25
integrand_thd(:,:,k,i,j) = rad.*vN_thd(:,:,k,i,j).*cos(yg.*dtr)./g;
end
end
end



integral_p_thd = flipdim(cumsum(flipdim(integrand_thd,3).*deltap,3),3);

[integral_lam,mskzon,ylat,areazon]=calcZonalAvgCube(integral_p_thd,ny,yc,ar,hc);
integral_lam_thd = integral_lam.*pi.*2;

%psi_thd = mean(integral_lam,3);

'psi calculated, starting zonal averaging'

%%%%%%%%%%%%%%%%%%%%%%% zavs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[uE_thd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_thd,ny,yc,ar,hc);
[vN_thd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_thd,ny,yc,ar,hc);
[theta_thd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_thd,ny,yc,ar,hc);
[temp_thd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_thd,ny,yc,ar,hc);
[uv_thd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_thd,ny,yc,ar,hc);
[vt_thd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_thd,ny,yc,ar,hc);
[htrt_theta_thd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_theta_thd,ny,yc,ar,hc);
[tothke_thd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tothke_thd,ny,yc,ar,hc);
vt_ed_thd_zav = vt_thd_zav - vN_thd_zav.*theta_thd_zav;
uv_ed_thd_zav = uv_thd_zav - uE_thd_zav.*vN_thd_zav;
eke_thd_zav = (tothke_thd_zav - uE_thd_zav.*uE_thd_zav - vN_thd_zav.*vN_thd_zav)./2;

'zonal averaging done, starting ten day averaging'
%take time averages for all fields

for i=1:6
uE_thd_tzav(:,:,i,:) = mean(uE_thd_zav(:,:,10*i-9:10*i,:),3);
theta_thd_tzav(:,:,i,:) = mean(theta_thd_zav(:,:,10*i-9:10*i,:),3);
temp_thd_tzav(:,:,i,:) = mean(temp_thd_zav(:,:,10*i-9:10*i,:),3);
vN_thd_tzav(:,:,i,:) = mean(vN_thd_zav(:,:,10*i-9:10*i,:),3);
htrt_thd_tzav(:,:,i,:) = mean(htrt_theta_thd_zav(:,:,10*i-9:10*i,:),3);
vt_ed_thd_tzav(:,:,i,:) = mean(vt_ed_thd_zav(:,:,10*i-9:10*i,:),3);
uv_ed_thd_tzav(:,:,i,:) = mean(uv_ed_thd_zav(:,:,10*i-9:10*i,:),3);
eke_thd_tzav(:,:,i,:) =  mean(eke_thd_zav(:,:,10*i-9:10*i,:),3);
psi_thd(:,:,i,:) = mean(integral_lam_thd(:,:,10*i-9:10*i,:),3);
end


'ten day avs done, starting EP flux calculation'
%%%%%%%%%%%%%%%%%%%%%%% EP fluxes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dthetadp_thd = gradient(theta_thd_tzav,-4000.);

ylat_radians = ylat.*pi./180;

costhi = cos(ylat_radians);
omega = 2*pi/(24*60*60);
f = 2*omega*sin(ylat_radians);
g=9.81;

prefactor = costhi.*2.*pi.*rad.^2./g;

%Calculate fluxes and scaled fluxes (Edmon 1980)
for i=1:90
Fphi_thd(i,:,:,:) = -1.*rad.*costhi(i).*uv_ed_thd_tzav(i,:,:,:);
Fp_thd(i,:,:,:)   = rad.*f(i).*costhi(i).*vt_ed_thd_tzav(i,:,:,:)./dthetadp_thd(i,:,:,:);
Fphi_scaled_thd(i,:,:,:) = Fphi_thd(i,:,:,:).*prefactor(i)./rad;
Fp_scaled_thd(i,:,:,:) = Fp_thd(i,:,:,:).*prefactor(i);

end

fluxdiv_p_thd = gradient(Fp_scaled_thd,-4000);

[fdphi_x,fluxdiv_phi_thd,fdphi_t,fdphi_e] = gradient(Fphi_scaled_thd,2*pi./180.);

fluxdiv_thd = fluxdiv_p_thd + fluxdiv_phi_thd;

'EP done, start qgref calculation'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% QG refractive index %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Constants needed: a, c, k, f/omega, H, R

a = 6371000; % radius of earth
c = 8.0; %phase speed guesstimate for now
k = 7;   %waveno to look at
omeg = 2.*pi./(24.*60.*60);  %rotation rate of earth
f = 2.*omeg.*sin(ylat.*pi./180);
H = 8000 ;   % Density scale height (taken from Isla's thesis)
R = 287.0 ; %gas const for dry air
g=9.81;

ylat_arr = zeros(90,25,6,10);
rC_arr = zeros(90,25,6,10);
f_arr = zeros(90,25,6,10);
for i=1:90
ylat_arr(i,:,:,:) = ylat(i).*pi./180;
f_arr(i,:,:,:) = f(i);
end
for i=1:25
rC_arr(:,i,:,:) = rC(i);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Next evaluate dq/dphi. Need du/dp, dtheta/dp

% 2*omega*cos(lat)
term1_thd = 2.*omeg.*cos(ylat_arr);

% d( d(ucos(lat)dlat)/acos(lat)) dlat
[b,top_thd,moo,min] = gradient(uE_thd_tzav.*cos(ylat_arr),pi./90);
bottom = a.*cos(ylat_arr);


frac = top_thd./bottom;
[b,term2_thd,moo,min] = gradient(frac,pi./90);


% af^2/R * d(ptheta/T * dudp/dthetadp)dp
dudp_thd = gradient(uE_thd_tzav,-4000);


prod_thd = rC_arr.*theta_thd_tzav./temp_thd_tzav.*dudp_thd./dthetadp_thd;


diff_thd = gradient(prod_thd,-4000);


term3_thd=  a.*f_arr.^2./R.*diff_thd;


dqdphi_thd = term1_thd - term2_thd + term3_thd;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Also evaluate N = sqrt (g/theta dtheta/dz)

Nsq_thd = -(g.^2.*rC_arr)./(R.*temp_thd_tzav.*theta_thd_tzav) .* dthetadp_thd;
N_thd = sqrt(Nsq_thd);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%qg ref index!

bit1_thd = dqdphi_thd./(a.*(uE_thd_tzav-c));
bit2_thd = (k./(a.*cos(ylat_arr))).^2 ;
bit3_thd = (f_arr./(2.*N_thd.*H)).^2 ;

qgref_thd = (bit1_thd - bit2_thd - bit3_thd).*a.^2;


%%%%%%%%%%%%%%%%%%%%%%%% e-av%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%make matrix of ensemble members for each variable, including each hemisphere separately
'all variables complete, filling ensemble member arrays'
for j=1:10

uE_thd_ens(:,:,:,j*2-1) = uE_thd_tzav(46:90,:,:,j);
uE_thd_ens(:,:,:,j*2) = flipdim(uE_thd_tzav(1:45,:,:,j),1);
theta_thd_ens(:,:,:,j*2-1) = theta_thd_tzav(46:90,:,:,j);
theta_thd_ens(:,:,:,j*2) = flipdim(theta_thd_tzav(1:45,:,:,j),1);
temp_thd_ens(:,:,:,j*2-1) = temp_thd_tzav(46:90,:,:,j);
temp_thd_ens(:,:,:,j*2) = flipdim(temp_thd_tzav(1:45,:,:,j),1);
vN_thd_ens(:,:,:,j*2-1) = vN_thd_tzav(46:90,:,:,j);
vN_thd_ens(:,:,:,j*2) = -1*flipdim(vN_thd_tzav(1:45,:,:,j),1);
htrt_thd_ens(:,:,:,j*2-1) = htrt_thd_tzav(46:90,:,:,j);
htrt_thd_ens(:,:,:,j*2) = flipdim(htrt_thd_tzav(1:45,:,:,j),1);
vt_ed_thd_ens(:,:,:,j*2-1) = vt_ed_thd_tzav(46:90,:,:,j);
vt_ed_thd_ens(:,:,:,j*2) = -1*flipdim(vt_ed_thd_tzav(1:45,:,:,j),1);
uv_ed_thd_ens(:,:,:,j*2-1) = uv_ed_thd_tzav(46:90,:,:,j);
uv_ed_thd_ens(:,:,:,j*2) = -1*flipdim(uv_ed_thd_tzav(1:45,:,:,j),1);
Fphi_scaled_thd_ens(:,:,:,j*2-1) = Fphi_scaled_thd(46:90,:,:,j);
Fphi_scaled_thd_ens(:,:,:,j*2) = -1*flipdim(Fphi_scaled_thd(1:45,:,:,j),1);
Fp_scaled_thd_ens(:,:,:,j*2-1) = Fp_scaled_thd(46:90,:,:,j);
Fp_scaled_thd_ens(:,:,:,j*2) = flipdim(Fp_scaled_thd(1:45,:,:,j),1);
fluxdiv_thd_ens(:,:,:,j*2-1) = fluxdiv_thd(46:90,:,:,j);
fluxdiv_thd_ens(:,:,:,j*2) = flipdim(fluxdiv_thd(1:45,:,:,j),1);
eke_thd_ens(:,:,:,j*2-1) = eke_thd_tzav(46:90,:,:,j);
eke_thd_ens(:,:,:,j*2) = flipdim(eke_thd_tzav(1:45,:,:,j),1);
qgref_thd_ens(:,:,:,j*2-1) = qgref_thd(46:90,:,:,j);
qgref_thd_ens(:,:,:,j*2) = flipdim(qgref_thd(1:45,:,:,j),1);
psi_thd_ens(:,:,:,j*2-1) = psi_thd(46:90,:,:,j);
psi_thd_ens(:,:,:,j*2) = -1*flipdim(psi_thd(1:45,:,:,j),1);

end

'calculating ensemble means'
psi_thd_ezav = mean(psi_thd_ens,4);
uE_thd_ezav = mean(uE_thd_ens,4);
theta_thd_ezav = mean(theta_thd_ens,4);
htrt_thd_ezav = mean(htrt_thd_ens,4);
uv_ed_thd_ezav = mean(uv_ed_thd_ens,4);
vt_ed_thd_ezav = mean(vt_ed_thd_ens,4);
Fphi_scaled_thd_ezav = mean(Fphi_scaled_thd_ens,4);
Fp_scaled_thd_ezav = mean(Fp_scaled_thd_ens,4);
fluxdiv_thd_ezav = mean(fluxdiv_thd_ens,4);
eke_thd_ezav = mean(eke_thd_ens,4);
qgref_thd_ezav = mean(qgref_thd_ens,4);


'saving ezav_thd'
save('ezav_thd.mat', 'psi_thd_ezav', 'uE_thd_ezav', 'theta_thd_ezav', 'htrt_thd_ezav', 'uv_ed_thd_ezav', 'vt_ed_thd_ezav', 'Fphi_scaled_thd_ezav', 'Fp_scaled_thd_ezav', 'fluxdiv_thd_ezav', 'eke_thd_ezav', 'qgref_thd_ezav')

'saving ens_thd'
save('ens_thd.mat', 'psi_thd_ens', 'uE_thd_ens', 'theta_thd_ens', 'htrt_thd_ens', 'uv_ed_thd_ens', 'vt_ed_thd_ens', 'Fphi_scaled_thd_ens', 'Fp_scaled_thd_ens', 'fluxdiv_thd_ens', 'eke_thd_ens', 'qgref_thd_ens')



