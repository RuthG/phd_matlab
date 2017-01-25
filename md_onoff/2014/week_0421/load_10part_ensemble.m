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
%%%%%%%%%%%%%%%%%%%%%%%% Tropheat run%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rDir=['/disk1/MITgcm/verification/atm_gray_ruth/ensemble/run_start_' num2str(nitstart) '/'];


[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_th(:,:,:,i,j+1) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_th(:,:,:,i,j+1) = dyn(:,:,:,J);
[uE_th(:,:,:,i,j+1),vN_th(:,:,:,i,j+1)] = rotate_uv2uvEN(ucs_th(:,:,:,i,j+1),vcs_th(:,:,:,i,j+1),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_th(:,:,:,i,j+1) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
temp_th(:,:,k,i,j+1)=theta_th(:,:,k,i,j+1).*convthetatoT(k,1);
end

J=find(strcmp(fldList,'UV_VEL_C'));
uv_th(:,:,:,i,j+1) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_th(:,:,:,i,j+1) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_th(:,:,:,i,j+1) = dyn(:,:,:,J);
[uEt_av_th(:,:,:,i,j+1),vNt_av_th(:,:,:,i,j+1)] = rotate_uv2uvEN(ut_av_th(:,:,:,i,j+1),vt_av_th(:,:,:,i,j+1),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'VVELSQ  '));
vsq_av_th(:,:,:,i,j+1) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELSQ  '));
usq_av_th(:,:,:,i,j+1) = dyn(:,:,:,J);

tothke_th(:,:,:,i,j+1) = vsq_av_th(:,:,:,i,j+1) + usq_av_th(:,:,:,i,j+1);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_in_th=dyn(:,:,:,J);
htrt_theta_th(:,:,:,i,j+1)=htrt_in_th*86400.;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Control run%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rDir='/disk1/MITgcm/verification/atm_gray_ruth/ensemble_control/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_c(:,:,:,i,j+1) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_c(:,:,:,i,j+1) = dyn(:,:,:,J);
[uE_c(:,:,:,i,j+1),vN_c(:,:,:,i,j+1)] = rotate_uv2uvEN(ucs_c(:,:,:,i,j+1),vcs_c(:,:,:,i,j+1),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_c(:,:,:,i,j+1) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
temp_c(:,:,k,i,j+1)=theta_c(:,:,k,i,j+1).*convthetatoT(k,1);
end

J=find(strcmp(fldList,'UV_VEL_C'));
uv_c(:,:,:,i,j+1) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_c(:,:,:,i,j+1) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_c(:,:,:,i,j+1) = dyn(:,:,:,J);
[uEt_av_c(:,:,:,i,j+1),vNt_av_c(:,:,:,i,j+1)] = rotate_uv2uvEN(ut_av_c(:,:,:,i,j+1),vt_av_c(:,:,:,i,j+1),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'VVELSQ  '));
vsq_av_c(:,:,:,i,j+1) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELSQ  '));
usq_av_c(:,:,:,i,j+1) = dyn(:,:,:,J);

tothke_c(:,:,:,i,j+1) = vsq_av_c(:,:,:,i,j+1) + usq_av_c(:,:,:,i,j+1);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_in_c=dyn(:,:,:,J);
htrt_theta_c(:,:,:,i,j+1)=htrt_in_c*86400.;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Wet run%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rDir=['/disk1/MITgcm/verification/atm_gray_ruth/ensemble_wet/run_start_' num2str(nitstart) '/'];

%ignore run that failed for wet spin-up
if nitstart < 662400
counter = j+1;
elseif nitstart > 662400
counter = j;
end

if nitstart ~= 662400
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i,counter) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i,counter) = dyn(:,:,:,J);
[uE_w(:,:,:,i,counter),vN_w(:,:,:,i,counter)] = rotate_uv2uvEN(ucs_w(:,:,:,i,counter),vcs_w(:,:,:,i,counter),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i,counter) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
temp_w(:,:,k,i,counter)=theta_w(:,:,k,i,counter).*convthetatoT(k,1);
end

J=find(strcmp(fldList,'UV_VEL_C'));
uv_w(:,:,:,i,counter) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_w(:,:,:,i,counter) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_w(:,:,:,i,counter) = dyn(:,:,:,J);
[uEt_av_w(:,:,:,i,counter),vNt_av_w(:,:,:,i,counter)] = rotate_uv2uvEN(ut_av_w(:,:,:,i,counter),vt_av_w(:,:,:,i,counter),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'VVELSQ  '));
vsq_av_w(:,:,:,i,counter) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELSQ  '));
usq_av_w(:,:,:,i,counter) = dyn(:,:,:,J);

tothke_w(:,:,:,i,counter) = vsq_av_w(:,:,:,i,counter) + usq_av_w(:,:,:,i,counter);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_in_w=dyn(:,:,:,J);
htrt_theta_w(:,:,:,i,counter)=htrt_in_w*86400.;
end

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

integrand = zeros(size(vN_th));

for j=1:10
for i=1:60
for k=1:25
integrand_th(:,:,k,i,j) = rad.*vN_th(:,:,k,i,j).*cos(yg.*dtr)./g;
integrand_c(:,:,k,i,j) = rad.*vN_c(:,:,k,i,j).*cos(yg.*dtr)./g;
end
end
end

for j=1:9
for i=1:60
for k=1:25
integrand_w(:,:,k,i,j) = rad.*vN_w(:,:,k,i,j).*cos(yg.*dtr)./g;
end
end
end


integral_p_th = flipdim(cumsum(flipdim(integrand_th,3).*deltap,3),3);
integral_p_c = flipdim(cumsum(flipdim(integrand_c,3).*deltap,3),3);
integral_p_w = flipdim(cumsum(flipdim(integrand_w,3).*deltap,3),3);

[integral_lam,mskzon,ylat,areazon]=calcZonalAvgCube(integral_p_th,ny,yc,ar,hc);
integral_lam_th = integral_lam.*pi.*2;
[integral_lam,mskzon,ylat,areazon]=calcZonalAvgCube(integral_p_c,ny,yc,ar,hc);
integral_lam_c = integral_lam.*pi.*2;
[integral_lam,mskzon,ylat,areazon]=calcZonalAvgCube(integral_p_w,ny,yc,ar,hc);
integral_lam_w = integral_lam.*pi.*2;

%psi_th = mean(integral_lam,3);

'psi calculated, starting zonal averaging'

%%%%%%%%%%%%%%%%%%%%%%% zavs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[uE_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_th,ny,yc,ar,hc);
[vN_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_th,ny,yc,ar,hc);
[theta_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_th,ny,yc,ar,hc);
[temp_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_th,ny,yc,ar,hc);
[uv_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_th,ny,yc,ar,hc);
[vt_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_th,ny,yc,ar,hc);
[htrt_theta_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_theta_th,ny,yc,ar,hc);
[tothke_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tothke_th,ny,yc,ar,hc);
vt_ed_th_zav = vt_th_zav - vN_th_zav.*theta_th_zav;
uv_ed_th_zav = uv_th_zav - uE_th_zav.*vN_th_zav;
eke_th_zav = (tothke_th_zav - uE_th_zav.*uE_th_zav - vN_th_zav.*vN_th_zav)./2;

[uE_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_c,ny,yc,ar,hc);
[vN_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_c,ny,yc,ar,hc);
[theta_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_c,ny,yc,ar,hc);
[temp_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_c,ny,yc,ar,hc);
[uv_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_c,ny,yc,ar,hc);
[vt_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_c,ny,yc,ar,hc);
[htrt_theta_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_theta_c,ny,yc,ar,hc);
[tothke_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tothke_c,ny,yc,ar,hc);
vt_ed_c_zav = vt_c_zav - vN_c_zav.*theta_c_zav;
uv_ed_c_zav = uv_c_zav - uE_c_zav.*vN_c_zav;
eke_c_zav = (tothke_c_zav - uE_c_zav.*uE_c_zav - vN_c_zav.*vN_c_zav)./2;

[uE_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_w,ny,yc,ar,hc);
[vN_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_w,ny,yc,ar,hc);
[theta_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_w,ny,yc,ar,hc);
[temp_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_w,ny,yc,ar,hc);
[uv_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_w,ny,yc,ar,hc);
[vt_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_w,ny,yc,ar,hc);
[htrt_theta_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_theta_w,ny,yc,ar,hc);
[tothke_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tothke_w,ny,yc,ar,hc);
vt_ed_w_zav = vt_w_zav - vN_w_zav.*theta_w_zav;
uv_ed_w_zav = uv_w_zav - uE_w_zav.*vN_w_zav;
eke_w_zav = (tothke_w_zav - uE_w_zav.*uE_w_zav - vN_w_zav.*vN_w_zav)./2;

'zonal averaging done, starting ten day averaging'
%take time averages for all fields

for i=1:6
uE_th_tzav(:,:,i,:) = mean(uE_th_zav(:,:,10*i-9:10*i,:),3);
theta_th_tzav(:,:,i,:) = mean(theta_th_zav(:,:,10*i-9:10*i,:),3);
temp_th_tzav(:,:,i,:) = mean(temp_th_zav(:,:,10*i-9:10*i,:),3);
vN_th_tzav(:,:,i,:) = mean(vN_th_zav(:,:,10*i-9:10*i,:),3);
htrt_th_tzav(:,:,i,:) = mean(htrt_theta_th_zav(:,:,10*i-9:10*i,:),3);
vt_ed_th_tzav(:,:,i,:) = mean(vt_ed_th_zav(:,:,10*i-9:10*i,:),3);
uv_ed_th_tzav(:,:,i,:) = mean(uv_ed_th_zav(:,:,10*i-9:10*i,:),3);
eke_th_tzav(:,:,i,:) =  mean(eke_th_zav(:,:,10*i-9:10*i,:),3);
psi_th(:,:,i,:) = mean(integral_lam_th(:,:,10*i-9:10*i,:),3);

uE_c_tzav(:,:,i,:) = mean(uE_c_zav(:,:,10*i-9:10*i,:),3);
theta_c_tzav(:,:,i,:) = mean(theta_c_zav(:,:,10*i-9:10*i,:),3);
temp_c_tzav(:,:,i,:) = mean(temp_c_zav(:,:,10*i-9:10*i,:),3);
vN_c_tzav(:,:,i,:) = mean(vN_c_zav(:,:,10*i-9:10*i,:),3);
htrt_c_tzav(:,:,i,:) = mean(htrt_theta_c_zav(:,:,10*i-9:10*i,:),3);
vt_ed_c_tzav(:,:,i,:) = mean(vt_ed_c_zav(:,:,10*i-9:10*i,:),3);
uv_ed_c_tzav(:,:,i,:) = mean(uv_ed_c_zav(:,:,10*i-9:10*i,:),3);
eke_c_tzav(:,:,i,:) =  mean(eke_c_zav(:,:,10*i-9:10*i,:),3);
psi_c(:,:,i,:) = mean(integral_lam_c(:,:,10*i-9:10*i,:),3);

uE_w_tzav(:,:,i,:) = mean(uE_w_zav(:,:,10*i-9:10*i,:),3);
theta_w_tzav(:,:,i,:) = mean(theta_w_zav(:,:,10*i-9:10*i,:),3);
temp_w_tzav(:,:,i,:) = mean(temp_w_zav(:,:,10*i-9:10*i,:),3);
vN_w_tzav(:,:,i,:) = mean(vN_w_zav(:,:,10*i-9:10*i,:),3);
htrt_w_tzav(:,:,i,:) = mean(htrt_theta_w_zav(:,:,10*i-9:10*i,:),3);
vt_ed_w_tzav(:,:,i,:) = mean(vt_ed_w_zav(:,:,10*i-9:10*i,:),3);
uv_ed_w_tzav(:,:,i,:) = mean(uv_ed_w_zav(:,:,10*i-9:10*i,:),3);
eke_w_tzav(:,:,i,:) =  mean(eke_w_zav(:,:,10*i-9:10*i,:),3);
psi_w(:,:,i,:) = mean(integral_lam_w(:,:,10*i-9:10*i,:),3);
end


'ten day avs done, starting EP flux calculation'
%%%%%%%%%%%%%%%%%%%%%%% EP fluxes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dthetadp_th = gradient(theta_th_tzav,-4000.);
dthetadp_c = gradient(theta_c_tzav,-4000.);
dthetadp_w = gradient(theta_w_tzav,-4000.);

ylat_radians = ylat.*pi./180;

costhi = cos(ylat_radians);
omega = 2*pi/(24*60*60);
f = 2*omega*sin(ylat_radians);
g=9.81;

prefactor = costhi.*2.*pi.*rad.^2./g;

%Calculate fluxes and scaled fluxes (Edmon 1980)
for i=1:90
Fphi_th(i,:,:,:) = -1.*rad.*costhi(i).*uv_ed_th_tzav(i,:,:,:);
Fp_th(i,:,:,:)   = rad.*f(i).*costhi(i).*vt_ed_th_tzav(i,:,:,:)./dthetadp_th(i,:,:,:);
Fphi_scaled_th(i,:,:,:) = Fphi_th(i,:,:,:).*prefactor(i)./rad;
Fp_scaled_th(i,:,:,:) = Fp_th(i,:,:,:).*prefactor(i);

Fphi_c(i,:,:,:) = -1.*rad.*costhi(i).*uv_ed_c_tzav(i,:,:,:);
Fp_c(i,:,:,:)   = rad.*f(i).*costhi(i).*vt_ed_c_tzav(i,:,:,:)./dthetadp_c(i,:,:,:);
Fphi_scaled_c(i,:,:,:) = Fphi_c(i,:,:,:).*prefactor(i)./rad;
Fp_scaled_c(i,:,:,:) = Fp_c(i,:,:,:).*prefactor(i);

Fphi_w(i,:,:,:) = -1.*rad.*costhi(i).*uv_ed_w_tzav(i,:,:,:);
Fp_w(i,:,:,:)   = rad.*f(i).*costhi(i).*vt_ed_w_tzav(i,:,:,:)./dthetadp_w(i,:,:,:);
Fphi_scaled_w(i,:,:,:) = Fphi_w(i,:,:,:).*prefactor(i)./rad;
Fp_scaled_w(i,:,:,:) = Fp_w(i,:,:,:).*prefactor(i);
end

fluxdiv_p_th = gradient(Fp_scaled_th,-4000);
fluxdiv_p_c = gradient(Fp_scaled_c,-4000);
fluxdiv_p_w = gradient(Fp_scaled_w,-4000);

[fdphi_x,fluxdiv_phi_th,fdphi_t,fdphi_e] = gradient(Fphi_scaled_th,2*pi./180.);
[fdphi_x,fluxdiv_phi_c,fdphi_t,fdphi_e] = gradient(Fphi_scaled_c,2*pi./180.);
[fdphi_x,fluxdiv_phi_w,fdphi_t,fdphi_e] = gradient(Fphi_scaled_w,2*pi./180.);

fluxdiv_th = fluxdiv_p_th + fluxdiv_phi_th;
fluxdiv_c = fluxdiv_p_c + fluxdiv_phi_c;
fluxdiv_w = fluxdiv_p_w + fluxdiv_phi_w;


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
ylat_arr_w = zeros(90,25,6,9);
rC_arr_w = zeros(90,25,6,9);
f_arr_w = zeros(90,25,6,9);

for i=1:90
ylat_arr(i,:,:,:) = ylat(i).*pi./180;
f_arr(i,:,:,:) = f(i);
ylat_arr_w(i,:,:,:) = ylat(i).*pi./180;
f_arr_w(i,:,:,:) = f(i);
end
for i=1:25
rC_arr(:,i,:,:) = rC(i);
rC_arr_w(:,i,:,:) = rC(i);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Next evaluate dq/dphi. Need du/dp, dtheta/dp

% 2*omega*cos(lat)
term1_th = 2.*omeg.*cos(ylat_arr);
term1_w = 2.*omeg.*cos(ylat_arr_w);

% d( d(ucos(lat)dlat)/acos(lat)) dlat
[b,top_th,moo,min] = gradient(uE_th_tzav.*cos(ylat_arr),pi./90);
[b,top_c,moo,min] = gradient(uE_c_tzav.*cos(ylat_arr),pi./90);
[b,top_w,moo,min] = gradient(uE_w_tzav.*cos(ylat_arr_w),pi./90);
bottom = a.*cos(ylat_arr);
bottom_w = a.*cos(ylat_arr_w);

frac = top_th./bottom;
[b,term2_th,moo,min] = gradient(frac,pi./90);
frac = top_c./bottom;
[b,term2_c,moo,min] = gradient(frac,pi./90);
frac = top_w./bottom_w;
[b,term2_w,moo,min] = gradient(frac,pi./90);


% af^2/R * d(ptheta/T * dudp/dthetadp)dp
dudp_th = gradient(uE_th_tzav,-4000);
dudp_c = gradient(uE_c_tzav,-4000);
dudp_w = gradient(uE_w_tzav,-4000);

prod_th = rC_arr.*theta_th_tzav./temp_th_tzav.*dudp_th./dthetadp_th;
prod_c = rC_arr.*theta_c_tzav./temp_c_tzav.*dudp_c./dthetadp_c;
prod_w = rC_arr_w.*theta_w_tzav./temp_w_tzav.*dudp_w./dthetadp_w;

diff_th = gradient(prod_th,-4000);
diff_c = gradient(prod_c,-4000);
diff_w = gradient(prod_w,-4000);

term3_th=  a.*f_arr.^2./R.*diff_th;
term3_c=  a.*f_arr.^2./R.*diff_c;
term3_w=  a.*f_arr_w.^2./R.*diff_w;

dqdphi_th = term1_th - term2_th + term3_th;
dqdphi_c = term1_th - term2_c + term3_c;
dqdphi_w = term1_w - term2_w + term3_w;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Also evaluate N = sqrt (g/theta dtheta/dz)

Nsq_th = -(g.^2.*rC_arr)./(R.*temp_th_tzav.*theta_th_tzav) .* dthetadp_th;
N_th = sqrt(Nsq_th);
Nsq_c = -(g.^2.*rC_arr)./(R.*temp_c_tzav.*theta_c_tzav) .* dthetadp_c;
N_c = sqrt(Nsq_c);
Nsq_w = -(g.^2.*rC_arr_w)./(R.*temp_w_tzav.*theta_w_tzav) .* dthetadp_w;
N_w = sqrt(Nsq_w);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%qg ref index!

bit1_th = dqdphi_th./(a.*(uE_th_tzav-c));
bit2_th = (k./(a.*cos(ylat_arr))).^2 ;
bit3_th = (f_arr./(2.*N_th.*H)).^2 ;

bit1_c = dqdphi_c./(a.*(uE_c_tzav-c));
bit3_c = (f_arr./(2.*N_c.*H)).^2 ;

bit1_w = dqdphi_w./(a.*(uE_w_tzav-c));
bit2_w = (k./(a.*cos(ylat_arr_w))).^2 ;
bit3_w = (f_arr_w./(2.*N_w.*H)).^2 ;

qgref_th = (bit1_th - bit2_th - bit3_th).*a.^2;
qgref_c =  (bit1_c - bit2_th - bit3_c).*a.^2;
qgref_w =  (bit1_w - bit2_w - bit3_w).*a.^2;

%%%%%%%%%%%%%%%%%%%%%%%% e-av%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%make matrix of ensemble members for each variable, including each hemisphere separately
'all variables complete, filling ensemble member arrays'
for j=1:10

uE_th_ens(:,:,:,j*2-1) = uE_th_tzav(46:90,:,:,j);
uE_th_ens(:,:,:,j*2) = flipdim(uE_th_tzav(1:45,:,:,j),1);
theta_th_ens(:,:,:,j*2-1) = theta_th_tzav(46:90,:,:,j);
theta_th_ens(:,:,:,j*2) = flipdim(theta_th_tzav(1:45,:,:,j),1);
temp_th_ens(:,:,:,j*2-1) = temp_th_tzav(46:90,:,:,j);
temp_th_ens(:,:,:,j*2) = flipdim(temp_th_tzav(1:45,:,:,j),1);
vN_th_ens(:,:,:,j*2-1) = vN_th_tzav(46:90,:,:,j);
vN_th_ens(:,:,:,j*2) = -1*flipdim(vN_th_tzav(1:45,:,:,j),1);
htrt_th_ens(:,:,:,j*2-1) = htrt_th_tzav(46:90,:,:,j);
htrt_th_ens(:,:,:,j*2) = flipdim(htrt_th_tzav(1:45,:,:,j),1);
vt_ed_th_ens(:,:,:,j*2-1) = vt_ed_th_tzav(46:90,:,:,j);
vt_ed_th_ens(:,:,:,j*2) = -1*flipdim(vt_ed_th_tzav(1:45,:,:,j),1);
uv_ed_th_ens(:,:,:,j*2-1) = uv_ed_th_tzav(46:90,:,:,j);
uv_ed_th_ens(:,:,:,j*2) = -1*flipdim(uv_ed_th_tzav(1:45,:,:,j),1);
Fphi_scaled_th_ens(:,:,:,j*2-1) = Fphi_scaled_th(46:90,:,:,j);
Fphi_scaled_th_ens(:,:,:,j*2) = -1*flipdim(Fphi_scaled_th(1:45,:,:,j),1);
Fp_scaled_th_ens(:,:,:,j*2-1) = Fp_scaled_th(46:90,:,:,j);
Fp_scaled_th_ens(:,:,:,j*2) = flipdim(Fp_scaled_th(1:45,:,:,j),1);
fluxdiv_th_ens(:,:,:,j*2-1) = fluxdiv_th(46:90,:,:,j);
fluxdiv_th_ens(:,:,:,j*2) = flipdim(fluxdiv_th(1:45,:,:,j),1);
eke_th_ens(:,:,:,j*2-1) = eke_th_tzav(46:90,:,:,j);
eke_th_ens(:,:,:,j*2) = flipdim(eke_th_tzav(1:45,:,:,j),1);
qgref_th_ens(:,:,:,j*2-1) = qgref_th(46:90,:,:,j);
qgref_th_ens(:,:,:,j*2) = flipdim(qgref_th(1:45,:,:,j),1);
psi_th_ens(:,:,:,j*2-1) = psi_th(46:90,:,:,j);
psi_th_ens(:,:,:,j*2) = -1*flipdim(psi_th(1:45,:,:,j),1);

uE_c_ens(:,:,:,j*2-1) = uE_c_tzav(46:90,:,:,j);
uE_c_ens(:,:,:,j*2) = flipdim(uE_c_tzav(1:45,:,:,j),1);
theta_c_ens(:,:,:,j*2-1) = theta_c_tzav(46:90,:,:,j);
theta_c_ens(:,:,:,j*2) = flipdim(theta_c_tzav(1:45,:,:,j),1);
temp_c_ens(:,:,:,j*2-1) = temp_c_tzav(46:90,:,:,j);
temp_c_ens(:,:,:,j*2) = flipdim(temp_c_tzav(1:45,:,:,j),1);
vN_c_ens(:,:,:,j*2-1) = vN_c_tzav(46:90,:,:,j);
vN_c_ens(:,:,:,j*2) = -1*flipdim(vN_c_tzav(1:45,:,:,j),1);
htrt_c_ens(:,:,:,j*2-1) = htrt_c_tzav(46:90,:,:,j);
htrt_c_ens(:,:,:,j*2) = flipdim(htrt_c_tzav(1:45,:,:,j),1);
vt_ed_c_ens(:,:,:,j*2-1) = vt_ed_c_tzav(46:90,:,:,j);
vt_ed_c_ens(:,:,:,j*2) = -1*flipdim(vt_ed_c_tzav(1:45,:,:,j),1);
uv_ed_c_ens(:,:,:,j*2-1) = uv_ed_c_tzav(46:90,:,:,j);
uv_ed_c_ens(:,:,:,j*2) = -1*flipdim(uv_ed_c_tzav(1:45,:,:,j),1);
Fphi_scaled_c_ens(:,:,:,j*2-1) = Fphi_scaled_c(46:90,:,:,j);
Fphi_scaled_c_ens(:,:,:,j*2) = -1*flipdim(Fphi_scaled_c(1:45,:,:,j),1);
Fp_scaled_c_ens(:,:,:,j*2-1) = Fp_scaled_c(46:90,:,:,j);
Fp_scaled_c_ens(:,:,:,j*2) = flipdim(Fp_scaled_c(1:45,:,:,j),1);
fluxdiv_c_ens(:,:,:,j*2-1) = fluxdiv_c(46:90,:,:,j);
fluxdiv_c_ens(:,:,:,j*2) = flipdim(fluxdiv_c(1:45,:,:,j),1);
eke_c_ens(:,:,:,j*2-1) = eke_c_tzav(46:90,:,:,j);
eke_c_ens(:,:,:,j*2) = flipdim(eke_c_tzav(1:45,:,:,j),1);
qgref_c_ens(:,:,:,j*2-1) = qgref_c(46:90,:,:,j);
qgref_c_ens(:,:,:,j*2) = flipdim(qgref_c(1:45,:,:,j),1);
psi_c_ens(:,:,:,j*2-1) = psi_c(46:90,:,:,j);
psi_c_ens(:,:,:,j*2) = -1*flipdim(psi_c(1:45,:,:,j),1);

end

for j=1:9

uE_w_ens(:,:,:,j*2-1) = uE_w_tzav(46:90,:,:,j);
uE_w_ens(:,:,:,j*2) = flipdim(uE_w_tzav(1:45,:,:,j),1);
theta_w_ens(:,:,:,j*2-1) = theta_w_tzav(46:90,:,:,j);
theta_w_ens(:,:,:,j*2) = flipdim(theta_w_tzav(1:45,:,:,j),1);
temp_w_ens(:,:,:,j*2-1) = temp_w_tzav(46:90,:,:,j);
temp_w_ens(:,:,:,j*2) = flipdim(temp_w_tzav(1:45,:,:,j),1);
vN_w_ens(:,:,:,j*2-1) = vN_w_tzav(46:90,:,:,j);
vN_w_ens(:,:,:,j*2) = -1*flipdim(vN_w_tzav(1:45,:,:,j),1);
htrt_w_ens(:,:,:,j*2-1) = htrt_w_tzav(46:90,:,:,j);
htrt_w_ens(:,:,:,j*2) = flipdim(htrt_w_tzav(1:45,:,:,j),1);
vt_ed_w_ens(:,:,:,j*2-1) = vt_ed_w_tzav(46:90,:,:,j);
vt_ed_w_ens(:,:,:,j*2) = -1*flipdim(vt_ed_w_tzav(1:45,:,:,j),1);
uv_ed_w_ens(:,:,:,j*2-1) = uv_ed_w_tzav(46:90,:,:,j);
uv_ed_w_ens(:,:,:,j*2) = -1*flipdim(uv_ed_w_tzav(1:45,:,:,j),1);
Fphi_scaled_w_ens(:,:,:,j*2-1) = Fphi_scaled_w(46:90,:,:,j);
Fphi_scaled_w_ens(:,:,:,j*2) = -1*flipdim(Fphi_scaled_w(1:45,:,:,j),1);
Fp_scaled_w_ens(:,:,:,j*2-1) = Fp_scaled_w(46:90,:,:,j);
Fp_scaled_w_ens(:,:,:,j*2) = flipdim(Fp_scaled_w(1:45,:,:,j),1);
fluxdiv_w_ens(:,:,:,j*2-1) = fluxdiv_w(46:90,:,:,j);
fluxdiv_w_ens(:,:,:,j*2) = flipdim(fluxdiv_w(1:45,:,:,j),1);
eke_w_ens(:,:,:,j*2-1) = eke_w_tzav(46:90,:,:,j);
eke_w_ens(:,:,:,j*2) = flipdim(eke_w_tzav(1:45,:,:,j),1);
qgref_w_ens(:,:,:,j*2-1) = qgref_w(46:90,:,:,j);
qgref_w_ens(:,:,:,j*2) = flipdim(qgref_w(1:45,:,:,j),1);
psi_w_ens(:,:,:,j*2-1) = psi_w(46:90,:,:,j);
psi_w_ens(:,:,:,j*2) = -1*flipdim(psi_w(1:45,:,:,j),1);

end

'calculating ensemble means'
psi_th_ezav = mean(psi_th_ens,4);
uE_th_ezav = mean(uE_th_ens,4);
theta_th_ezav = mean(theta_th_ens,4);
htrt_th_ezav = mean(htrt_th_ens,4);
uv_ed_th_ezav = mean(uv_ed_th_ens,4);
vt_ed_th_ezav = mean(vt_ed_th_ens,4);
Fphi_scaled_th_ezav = mean(Fphi_scaled_th_ens,4);
Fp_scaled_th_ezav = mean(Fp_scaled_th_ens,4);
fluxdiv_th_ezav = mean(fluxdiv_th_ens,4);
eke_th_ezav = mean(eke_th_ens,4);
qgref_th_ezav = mean(qgref_th_ens,4);

psi_c_ezav = mean(psi_c_ens,4);
uE_c_ezav = mean(uE_c_ens,4);
theta_c_ezav = mean(theta_c_ens,4);
htrt_c_ezav = mean(htrt_c_ens,4);
uv_ed_c_ezav = mean(uv_ed_c_ens,4);
vt_ed_c_ezav = mean(vt_ed_c_ens,4);
Fphi_scaled_c_ezav = mean(Fphi_scaled_c_ens,4);
Fp_scaled_c_ezav = mean(Fp_scaled_c_ens,4);
fluxdiv_c_ezav = mean(fluxdiv_c_ens,4);
eke_c_ezav = mean(eke_c_ens,4);
qgref_c_ezav = mean(qgref_c_ens,4);

psi_w_ezav = mean(psi_w_ens,4);
uE_w_ezav = mean(uE_w_ens,4);
theta_w_ezav = mean(theta_w_ens,4);
htrt_w_ezav = mean(htrt_w_ens,4);
uv_ed_w_ezav = mean(uv_ed_w_ens,4);
vt_ed_w_ezav = mean(vt_ed_w_ens,4);
Fphi_scaled_w_ezav = mean(Fphi_scaled_w_ens,4);
Fp_scaled_w_ezav = mean(Fp_scaled_w_ens,4);
fluxdiv_w_ezav = mean(fluxdiv_w_ens,4);
eke_w_ezav = mean(eke_w_ens,4);
qgref_w_ezav = mean(qgref_w_ens,4);

'saving ezav_th'
save('ezav_th.mat', 'psi_th_ezav', 'uE_th_ezav', 'theta_th_ezav', 'htrt_th_ezav', 'uv_ed_th_ezav', 'vt_ed_th_ezav', 'Fphi_scaled_th_ezav', 'Fp_scaled_th_ezav', 'fluxdiv_th_ezav', 'eke_th_ezav', 'qgref_th_ezav')

'saving ezav_c'
save('ezav_c.mat', 'psi_c_ezav', 'uE_c_ezav', 'theta_c_ezav', 'htrt_c_ezav', 'uv_ed_c_ezav', 'vt_ed_c_ezav', 'Fphi_scaled_c_ezav', 'Fp_scaled_c_ezav', 'fluxdiv_c_ezav', 'eke_c_ezav', 'qgref_c_ezav')

'saving ezav_w'
save('ezav_w.mat', 'psi_w_ezav', 'uE_w_ezav', 'theta_w_ezav', 'htrt_w_ezav', 'uv_ed_w_ezav', 'vt_ed_w_ezav', 'Fphi_scaled_w_ezav', 'Fp_scaled_w_ezav', 'fluxdiv_w_ezav', 'eke_w_ezav', 'qgref_w_ezav')

'saving ens_th'
save('ens_th.mat', 'psi_th_ens', 'uE_th_ens', 'theta_th_ens', 'htrt_th_ens', 'uv_ed_th_ens', 'vt_ed_th_ens', 'Fphi_scaled_th_ens', 'Fp_scaled_th_ens', 'fluxdiv_th_ens', 'eke_th_ens', 'qgref_th_ens')

'saving ens_c'
save('ens_c.mat', 'psi_c_ens', 'uE_c_ens', 'theta_c_ens', 'htrt_c_ens', 'uv_ed_c_ens', 'vt_ed_c_ens', 'Fphi_scaled_c_ens', 'Fp_scaled_c_ens', 'fluxdiv_c_ens', 'eke_c_ens', 'qgref_c_ens')

'saving ens_w'
save('ens_w.mat', 'psi_w_ens', 'uE_w_ens', 'theta_w_ens', 'htrt_w_ens', 'uv_ed_w_ens', 'vt_ed_w_ens', 'Fphi_scaled_w_ens', 'Fp_scaled_w_ens', 'fluxdiv_w_ens', 'eke_w_ens', 'qgref_w_ens')




