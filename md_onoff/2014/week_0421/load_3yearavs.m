%load up data for 3 year averages
%want: years as single hemisphere  (ie 90x25x6 arrays) and time means (90x25)

%Read in iteration number, directory, MITgcm output and grid details

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


%load up 10 members of yearsemble

i=0;
for nit = 432000:86400:604800;
i=i+1


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Tropheat run%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nit_q = nit + 518400;
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv_tropheat3eq/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit_q);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_th(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_th(:,:,:,i) = dyn(:,:,:,J);
[uE_th(:,:,:,i),vN_th(:,:,:,i)] = rotate_uv2uvEN(ucs_th(:,:,:,i),vcs_th(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_th(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
temp_th(:,:,k,i)=theta_th(:,:,k,i).*convthetatoT(k,1);
end

J=find(strcmp(fldList,'UV_VEL_C'));
uv_th(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_th(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_th(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_th(:,:,:,i),vNt_av_th(:,:,:,i)] = rotate_uv2uvEN(ut_av_th(:,:,:,i),vt_av_th(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'VVELSQ  '));
vsq_av_th(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELSQ  '));
usq_av_th(:,:,:,i) = dyn(:,:,:,J);

tothke_th(:,:,:,i) = vsq_av_th(:,:,:,i) + usq_av_th(:,:,:,i);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_in_th=dyn(:,:,:,J);
htrt_theta_th(:,:,:,i)=htrt_in_th*86400.;

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit_q);
eval(M);
J=find(strcmp(fldList,'AtPhTauX'));
taux_th(:,:,i) = surf(:,:,J);
J=find(strcmp(fldList,'AtPhTauY'));
tauy_th(:,:,i) = surf(:,:,J);
[tauE_th(:,:,i),tauN_th(:,:,i)] = rotate_uv2uvEN(taux_th(:,:,i),tauy_th(:,:,i),AngleCS,AngleSN,Grid);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Control run%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_c(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_c(:,:,:,i) = dyn(:,:,:,J);
[uE_c(:,:,:,i),vN_c(:,:,:,i)] = rotate_uv2uvEN(ucs_c(:,:,:,i),vcs_c(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_c(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
temp_c(:,:,k,i)=theta_c(:,:,k,i).*convthetatoT(k,1);
end

J=find(strcmp(fldList,'UV_VEL_C'));
uv_c(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_c(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_c(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_c(:,:,:,i),vNt_av_c(:,:,:,i)] = rotate_uv2uvEN(ut_av_c(:,:,:,i),vt_av_c(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'VVELSQ  '));
vsq_av_c(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELSQ  '));
usq_av_c(:,:,:,i) = dyn(:,:,:,J);

tothke_c(:,:,:,i) = vsq_av_c(:,:,:,i) + usq_av_c(:,:,:,i);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_in_c=dyn(:,:,:,J);
htrt_theta_c(:,:,:,i)=htrt_in_c*86400.;

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);
eval(M);
J=find(strcmp(fldList,'AtPhTauX'));
taux_c(:,:,i) = surf(:,:,J);
J=find(strcmp(fldList,'AtPhTauY'));
tauy_c(:,:,i) = surf(:,:,J);
[tauE_c(:,:,i),tauN_c(:,:,i)] = rotate_uv2uvEN(taux_c(:,:,i),tauy_c(:,:,i),AngleCS,AngleSN,Grid);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Wet run%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';


[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i) = dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
temp_w(:,:,k,i)=theta_w(:,:,k,i).*convthetatoT(k,1);
end

J=find(strcmp(fldList,'UV_VEL_C'));
uv_w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_w(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_w(:,:,:,i),vNt_av_w(:,:,:,i)] = rotate_uv2uvEN(ut_av_w(:,:,:,i),vt_av_w(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'VVELSQ  '));
vsq_av_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELSQ  '));
usq_av_w(:,:,:,i) = dyn(:,:,:,J);

tothke_w(:,:,:,i) = vsq_av_w(:,:,:,i) + usq_av_w(:,:,:,i);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_in_w=dyn(:,:,:,J);
htrt_theta_w(:,:,:,i)=htrt_in_w*86400.;

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);
eval(M);
J=find(strcmp(fldList,'AtPhTauX'));
taux_w(:,:,i) = surf(:,:,J);
J=find(strcmp(fldList,'AtPhTauY'));
tauy_w(:,:,i) = surf(:,:,J);
[tauE_w(:,:,i),tauN_w(:,:,i)] = rotate_uv2uvEN(taux_w(:,:,i),tauy_w(:,:,i),AngleCS,AngleSN,Grid);

end

'variables loaded'

%Now we have 4D arrays for U, V, theta, temp, uv, vt, ut, vsq, usq, total ke, htrt
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

for i=1:3
for k=1:25
integrand_th(:,:,k,i) = rad.*vN_th(:,:,k,i).*cos(yg.*dtr)./g;
integrand_c(:,:,k,i) = rad.*vN_c(:,:,k,i).*cos(yg.*dtr)./g;
integrand_w(:,:,k,i) = rad.*vN_w(:,:,k,i).*cos(yg.*dtr)./g;
end
end

integral_p_th = flipdim(cumsum(flipdim(integrand_th,3).*deltap,3),3);
integral_p_c = flipdim(cumsum(flipdim(integrand_c,3).*deltap,3),3);
integral_p_w = flipdim(cumsum(flipdim(integrand_w,3).*deltap,3),3);

[integral_lam,mskzon,ylat,areazon]=calcZonalAvgCube(integral_p_th,ny,yc,ar,hc);
psi_th = integral_lam.*pi.*2;
[integral_lam,mskzon,ylat,areazon]=calcZonalAvgCube(integral_p_c,ny,yc,ar,hc);
psi_c = integral_lam.*pi.*2;
[integral_lam,mskzon,ylat,areazon]=calcZonalAvgCube(integral_p_w,ny,yc,ar,hc);
psi_w = integral_lam.*pi.*2;

'psi calculated, starting zonal averaging'

%%%%%%%%%%%%%%%%%%%%%%% zavs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[uE_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_th,ny,yc,ar,hc);
[vN_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_th,ny,yc,ar,hc);
[theta_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_th,ny,yc,ar,hc);
[temp_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_th,ny,yc,ar,hc);
[uv_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_th,ny,yc,ar,hc);
[vt_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_th,ny,yc,ar,hc);
[htrt_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_theta_th,ny,yc,ar,hc);
[tothke_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tothke_th,ny,yc,ar,hc);
[tauE_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tauE_th,ny,yc,ar,hc);
vt_ed_th_zav = vt_th_zav - vN_th_zav.*theta_th_zav;
uv_ed_th_zav = uv_th_zav - uE_th_zav.*vN_th_zav;
eke_th_zav = (tothke_th_zav - uE_th_zav.*uE_th_zav - vN_th_zav.*vN_th_zav)./2;

[uE_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_c,ny,yc,ar,hc);
[vN_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_c,ny,yc,ar,hc);
[theta_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_c,ny,yc,ar,hc);
[temp_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_c,ny,yc,ar,hc);
[uv_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_c,ny,yc,ar,hc);
[vt_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_c,ny,yc,ar,hc);
[htrt_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_theta_c,ny,yc,ar,hc);
[tothke_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tothke_c,ny,yc,ar,hc);
[tauE_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tauE_c,ny,yc,ar,hc);
vt_ed_c_zav = vt_c_zav - vN_c_zav.*theta_c_zav;
uv_ed_c_zav = uv_c_zav - uE_c_zav.*vN_c_zav;
eke_c_zav = (tothke_c_zav - uE_c_zav.*uE_c_zav - vN_c_zav.*vN_c_zav)./2;

[uE_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_w,ny,yc,ar,hc);
[vN_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_w,ny,yc,ar,hc);
[theta_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_w,ny,yc,ar,hc);
[temp_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_w,ny,yc,ar,hc);
[uv_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_w,ny,yc,ar,hc);
[vt_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_w,ny,yc,ar,hc);
[htrt_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_theta_w,ny,yc,ar,hc);
[tothke_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tothke_w,ny,yc,ar,hc);
[tauE_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tauE_w,ny,yc,ar,hc);
vt_ed_w_zav = vt_w_zav - vN_w_zav.*theta_w_zav;
uv_ed_w_zav = uv_w_zav - uE_w_zav.*vN_w_zav;
eke_w_zav = (tothke_w_zav - uE_w_zav.*uE_w_zav - vN_w_zav.*vN_w_zav)./2;

'zonal averaging done, starting EP flux calculation'
%%%%%%%%%%%%%%%%%%%%%%% EP fluxes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dthetadp_th = gradient(theta_th_zav,-4000.);
dthetadp_c = gradient(theta_c_zav,-4000.);
dthetadp_w = gradient(theta_w_zav,-4000.);

ylat_radians = ylat.*pi./180;

costhi = cos(ylat_radians);
omega = 2*pi/(24*60*60);
f = 2*omega*sin(ylat_radians);
g=9.81;

prefactor = costhi.*2.*pi.*rad.^2./g;

%Calculate fluxes and scaled fluxes (Edmon 1980)
for i=1:90
Fphi_th(i,:,:) = -1.*rad.*costhi(i).*uv_ed_th_zav(i,:,:);
Fp_th(i,:,:)   = rad.*f(i).*costhi(i).*vt_ed_th_zav(i,:,:)./dthetadp_th(i,:,:);
Fphi_scaled_th(i,:,:) = Fphi_th(i,:,:).*prefactor(i)./rad;
Fp_scaled_th(i,:,:) = Fp_th(i,:,:).*prefactor(i);

Fphi_c(i,:,:) = -1.*rad.*costhi(i).*uv_ed_c_zav(i,:,:);
Fp_c(i,:,:)   = rad.*f(i).*costhi(i).*vt_ed_c_zav(i,:,:)./dthetadp_c(i,:,:);
Fphi_scaled_c(i,:,:) = Fphi_c(i,:,:).*prefactor(i)./rad;
Fp_scaled_c(i,:,:) = Fp_c(i,:,:).*prefactor(i);

Fphi_w(i,:,:) = -1.*rad.*costhi(i).*uv_ed_w_zav(i,:,:);
Fp_w(i,:,:)   = rad.*f(i).*costhi(i).*vt_ed_w_zav(i,:,:)./dthetadp_w(i,:,:);
Fphi_scaled_w(i,:,:) = Fphi_w(i,:,:).*prefactor(i)./rad;
Fp_scaled_w(i,:,:) = Fp_w(i,:,:).*prefactor(i);
end

fluxdiv_p_th = gradient(Fp_scaled_th,-4000);
fluxdiv_p_c = gradient(Fp_scaled_c,-4000);
fluxdiv_p_w = gradient(Fp_scaled_w,-4000);

[fdphi_x,fluxdiv_phi_th,fdphi_t] = gradient(Fphi_scaled_th,2*pi./180.);
[fdphi_x,fluxdiv_phi_c,fdphi_t] = gradient(Fphi_scaled_c,2*pi./180.);
[fdphi_x,fluxdiv_phi_w,fdphi_t] = gradient(Fphi_scaled_w,2*pi./180.);

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
H = 8000 ;   % Dyearsity scale height (taken from Isla's thesis)
R = 287.0 ; %gas const for dry air
g=9.81;

ylat_arr = zeros(90,25,3);
rC_arr = zeros(90,25,3);
f_arr = zeros(90,25,3);

for i=1:90
ylat_arr(i,:,:) = ylat(i).*pi./180;
f_arr(i,:,:) = f(i);
end
for i=1:25
rC_arr(:,i,:) = rC(i);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Next evaluate dq/dphi. Need du/dp, dtheta/dp

% 2*omega*cos(lat)
term1_th = 2.*omeg.*cos(ylat_arr);

% d( d(ucos(lat)dlat)/acos(lat)) dlat
[b,top_th,moo] = gradient(uE_th_zav.*cos(ylat_arr),pi./90);
[b,top_c,moo] = gradient(uE_c_zav.*cos(ylat_arr),pi./90);
[b,top_w,moo] = gradient(uE_w_zav.*cos(ylat_arr),pi./90);
bottom = a.*cos(ylat_arr);

frac = top_th./bottom;
[b,term2_th,moo] = gradient(frac,pi./90);
frac = top_c./bottom;
[b,term2_c,moo] = gradient(frac,pi./90);
frac = top_w./bottom;
[b,term2_w,moo] = gradient(frac,pi./90);


% af^2/R * d(ptheta/T * dudp/dthetadp)dp
dudp_th = gradient(uE_th_zav,-4000);
dudp_c = gradient(uE_c_zav,-4000);
dudp_w = gradient(uE_w_zav,-4000);

prod_th = rC_arr.*theta_th_zav./temp_th_zav.*dudp_th./dthetadp_th;
prod_c = rC_arr.*theta_c_zav./temp_c_zav.*dudp_c./dthetadp_c;
prod_w = rC_arr.*theta_w_zav./temp_w_zav.*dudp_w./dthetadp_w;

diff_th = gradient(prod_th,-4000);
diff_c = gradient(prod_c,-4000);
diff_w = gradient(prod_w,-4000);

term3_th=  a.*f_arr.^2./R.*diff_th;
term3_c=  a.*f_arr.^2./R.*diff_c;
term3_w=  a.*f_arr.^2./R.*diff_w;

dqdphi_th = term1_th - term2_th + term3_th;
dqdphi_c = term1_th - term2_c + term3_c;
dqdphi_w = term1_th - term2_w + term3_w;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Also evaluate N = sqrt (g/theta dtheta/dz)

Nsq_th = -(g.^2.*rC_arr)./(R.*temp_th_zav.*theta_th_zav) .* dthetadp_th;
N_th = sqrt(Nsq_th);
Nsq_c = -(g.^2.*rC_arr)./(R.*temp_c_zav.*theta_c_zav) .* dthetadp_c;
N_c = sqrt(Nsq_c);
Nsq_w = -(g.^2.*rC_arr)./(R.*temp_w_zav.*theta_w_zav) .* dthetadp_w;
N_w = sqrt(Nsq_w);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%qg ref index!

bit1_th = dqdphi_th./(a.*(uE_th_zav-c));
bit2_th = (k./(a.*cos(ylat_arr))).^2 ;
bit3_th = (f_arr./(2.*N_th.*H)).^2 ;

bit1_c = dqdphi_c./(a.*(uE_c_zav-c));
bit3_c = (f_arr./(2.*N_c.*H)).^2 ;

bit1_w = dqdphi_w./(a.*(uE_w_zav-c));
bit3_w = (f_arr./(2.*N_w.*H)).^2 ;

qgref_th = (bit1_th - bit2_th - bit3_th).*a.^2;
qgref_c =  (bit1_c - bit2_th - bit3_c).*a.^2;
qgref_w =  (bit1_w - bit2_th - bit3_w).*a.^2;

%%%%%%%%%%%%%%%%%%%%%%%% e-av%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%make matrix of years for each variable, including each hemisphere separately
'all variables complete, filling yearsemble member arrays'
for j=1:3

uE_th_years(:,:,j*2-1) = uE_th_zav(46:90,:,j);
uE_th_years(:,:,j*2) = flipdim(uE_th_zav(1:45,:,j),1);
theta_th_years(:,:,j*2-1) = theta_th_zav(46:90,:,j);
theta_th_years(:,:,j*2) = flipdim(theta_th_zav(1:45,:,j),1);
temp_th_years(:,:,j*2-1) = temp_th_zav(46:90,:,j);
temp_th_years(:,:,j*2) = flipdim(temp_th_zav(1:45,:,j),1);
vN_th_years(:,:,j*2-1) = vN_th_zav(46:90,:,j);
vN_th_years(:,:,j*2) = -1*flipdim(vN_th_zav(1:45,:,j),1);
htrt_th_years(:,:,j*2-1) = htrt_th_zav(46:90,:,j);
htrt_th_years(:,:,j*2) = flipdim(htrt_th_zav(1:45,:,j),1);
vt_ed_th_years(:,:,j*2-1) = vt_ed_th_zav(46:90,:,j);
vt_ed_th_years(:,:,j*2) = -1*flipdim(vt_ed_th_zav(1:45,:,j),1);
uv_ed_th_years(:,:,j*2-1) = uv_ed_th_zav(46:90,:,j);
uv_ed_th_years(:,:,j*2) = -1*flipdim(uv_ed_th_zav(1:45,:,j),1);
Fphi_scaled_th_years(:,:,j*2-1) = Fphi_scaled_th(46:90,:,j);
Fphi_scaled_th_years(:,:,j*2) = -1*flipdim(Fphi_scaled_th(1:45,:,j),1);
Fp_scaled_th_years(:,:,j*2-1) = Fp_scaled_th(46:90,:,j);
Fp_scaled_th_years(:,:,j*2) = flipdim(Fp_scaled_th(1:45,:,j),1);
fluxdiv_th_years(:,:,j*2-1) = fluxdiv_th(46:90,:,j);
fluxdiv_th_years(:,:,j*2) = flipdim(fluxdiv_th(1:45,:,j),1);
eke_th_years(:,:,j*2-1) = eke_th_zav(46:90,:,j);
eke_th_years(:,:,j*2) = flipdim(eke_th_zav(1:45,:,j),1);
qgref_th_years(:,:,j*2-1) = qgref_th(46:90,:,j);
qgref_th_years(:,:,j*2) = flipdim(qgref_th(1:45,:,j),1);
psi_th_years(:,:,j*2-1) = psi_th(46:90,:,j);
psi_th_years(:,:,j*2) = -1*flipdim(psi_th(1:45,:,j),1);
tauE_th_years(:,j*2-1) = tauE_th_zav(46:90,j);
tauE_th_years(:,j*2) = flipdim(tauE_th_zav(1:45,j),1);
uv_th_years(:,:,j*2-1) = uv_th_zav(46:90,:,j);
uv_th_years(:,:,j*2) = -1*flipdim(uv_th_zav(1:45,:,j),1);

uE_c_years(:,:,j*2-1) = uE_c_zav(46:90,:,j);
uE_c_years(:,:,j*2) = flipdim(uE_c_zav(1:45,:,j),1);
theta_c_years(:,:,j*2-1) = theta_c_zav(46:90,:,j);
theta_c_years(:,:,j*2) = flipdim(theta_c_zav(1:45,:,j),1);
temp_c_years(:,:,j*2-1) = temp_c_zav(46:90,:,j);
temp_c_years(:,:,j*2) = flipdim(temp_c_zav(1:45,:,j),1);
vN_c_years(:,:,j*2-1) = vN_c_zav(46:90,:,j);
vN_c_years(:,:,j*2) = -1*flipdim(vN_c_zav(1:45,:,j),1);
htrt_c_years(:,:,j*2-1) = htrt_c_zav(46:90,:,j);
htrt_c_years(:,:,j*2) = flipdim(htrt_c_zav(1:45,:,j),1);
vt_ed_c_years(:,:,j*2-1) = vt_ed_c_zav(46:90,:,j);
vt_ed_c_years(:,:,j*2) = -1*flipdim(vt_ed_c_zav(1:45,:,j),1);
uv_ed_c_years(:,:,j*2-1) = uv_ed_c_zav(46:90,:,j);
uv_ed_c_years(:,:,j*2) = -1*flipdim(uv_ed_c_zav(1:45,:,j),1);
Fphi_scaled_c_years(:,:,j*2-1) = Fphi_scaled_c(46:90,:,j);
Fphi_scaled_c_years(:,:,j*2) = -1*flipdim(Fphi_scaled_c(1:45,:,j),1);
Fp_scaled_c_years(:,:,j*2-1) = Fp_scaled_c(46:90,:,j);
Fp_scaled_c_years(:,:,j*2) = flipdim(Fp_scaled_c(1:45,:,j),1);
fluxdiv_c_years(:,:,j*2-1) = fluxdiv_c(46:90,:,j);
fluxdiv_c_years(:,:,j*2) = flipdim(fluxdiv_c(1:45,:,j),1);
eke_c_years(:,:,j*2-1) = eke_c_zav(46:90,:,j);
eke_c_years(:,:,j*2) = flipdim(eke_c_zav(1:45,:,j),1);
qgref_c_years(:,:,j*2-1) = qgref_c(46:90,:,j);
qgref_c_years(:,:,j*2) = flipdim(qgref_c(1:45,:,j),1);
psi_c_years(:,:,j*2-1) = psi_c(46:90,:,j);
psi_c_years(:,:,j*2) = -1*flipdim(psi_c(1:45,:,j),1);
tauE_c_years(:,j*2-1) = tauE_c_zav(46:90,j);
tauE_c_years(:,j*2) = flipdim(tauE_c_zav(1:45,j),1);
uv_c_years(:,:,j*2-1) = uv_c_zav(46:90,:,j);
uv_c_years(:,:,j*2) = -1*flipdim(uv_c_zav(1:45,:,j),1);

uE_w_years(:,:,j*2-1) = uE_w_zav(46:90,:,j);
uE_w_years(:,:,j*2) = flipdim(uE_w_zav(1:45,:,j),1);
theta_w_years(:,:,j*2-1) = theta_w_zav(46:90,:,j);
theta_w_years(:,:,j*2) = flipdim(theta_w_zav(1:45,:,j),1);
temp_w_years(:,:,j*2-1) = temp_w_zav(46:90,:,j);
temp_w_years(:,:,j*2) = flipdim(temp_w_zav(1:45,:,j),1);
vN_w_years(:,:,j*2-1) = vN_w_zav(46:90,:,j);
vN_w_years(:,:,j*2) = -1*flipdim(vN_w_zav(1:45,:,j),1);
htrt_w_years(:,:,j*2-1) = htrt_w_zav(46:90,:,j);
htrt_w_years(:,:,j*2) = flipdim(htrt_w_zav(1:45,:,j),1);
vt_ed_w_years(:,:,j*2-1) = vt_ed_w_zav(46:90,:,j);
vt_ed_w_years(:,:,j*2) = -1*flipdim(vt_ed_w_zav(1:45,:,j),1);
uv_ed_w_years(:,:,j*2-1) = uv_ed_w_zav(46:90,:,j);
uv_ed_w_years(:,:,j*2) = -1*flipdim(uv_ed_w_zav(1:45,:,j),1);
Fphi_scaled_w_years(:,:,j*2-1) = Fphi_scaled_w(46:90,:,j);
Fphi_scaled_w_years(:,:,j*2) = -1*flipdim(Fphi_scaled_w(1:45,:,j),1);
Fp_scaled_w_years(:,:,j*2-1) = Fp_scaled_w(46:90,:,j);
Fp_scaled_w_years(:,:,j*2) = flipdim(Fp_scaled_w(1:45,:,j),1);
fluxdiv_w_years(:,:,j*2-1) = fluxdiv_w(46:90,:,j);
fluxdiv_w_years(:,:,j*2) = flipdim(fluxdiv_w(1:45,:,j),1);
eke_w_years(:,:,j*2-1) = eke_w_zav(46:90,:,j);
eke_w_years(:,:,j*2) = flipdim(eke_w_zav(1:45,:,j),1);
qgref_w_years(:,:,j*2-1) = qgref_w(46:90,:,j);
qgref_w_years(:,:,j*2) = flipdim(qgref_w(1:45,:,j),1);
psi_w_years(:,:,j*2-1) = psi_w(46:90,:,j);
psi_w_years(:,:,j*2) = -1*flipdim(psi_w(1:45,:,j),1);
tauE_w_years(:,j*2-1) = tauE_w_zav(46:90,j);
tauE_w_years(:,j*2) = flipdim(tauE_w_zav(1:45,j),1);
uv_w_years(:,:,j*2-1) = uv_w_zav(46:90,:,j);
uv_w_years(:,:,j*2) = -1*flipdim(uv_w_zav(1:45,:,j),1);

end

'calculating time/hem means'
psi_th_yzav = mean(psi_th_years,3);
uE_th_yzav = mean(uE_th_years,3);
vN_th_yzav = mean(vN_th_years,3);
theta_th_yzav = mean(theta_th_years,3);
htrt_th_yzav = mean(htrt_th_years,3);
uv_ed_th_yzav = mean(uv_ed_th_years,3);
vt_ed_th_yzav = mean(vt_ed_th_years,3);
Fphi_scaled_th_yzav = mean(Fphi_scaled_th_years,3);
Fp_scaled_th_yzav = mean(Fp_scaled_th_years,3);
fluxdiv_th_yzav = mean(fluxdiv_th_years,3);
eke_th_yzav = mean(eke_th_years,3);
qgref_th_yzav = mean(qgref_th_years,3);
tauE_th_yzav = mean(tauE_th_years,2);
uv_th_yzav = mean(uv_th_years,3);

psi_c_yzav = mean(psi_c_years,3);
uE_c_yzav = mean(uE_c_years,3);
vN_c_yzav = mean(vN_c_years,3);
theta_c_yzav = mean(theta_c_years,3);
htrt_c_yzav = mean(htrt_c_years,3);
uv_ed_c_yzav = mean(uv_ed_c_years,3);
vt_ed_c_yzav = mean(vt_ed_c_years,3);
Fphi_scaled_c_yzav = mean(Fphi_scaled_c_years,3);
Fp_scaled_c_yzav = mean(Fp_scaled_c_years,3);
fluxdiv_c_yzav = mean(fluxdiv_c_years,3);
eke_c_yzav = mean(eke_c_years,3);
qgref_c_yzav = mean(qgref_c_years,3);
tauE_c_yzav = mean(tauE_c_years,2);
uv_c_yzav = mean(uv_c_years,3);

psi_w_yzav = mean(psi_w_years,3);
uE_w_yzav = mean(uE_w_years,3);
vN_w_yzav = mean(vN_w_years,3);
theta_w_yzav = mean(theta_w_years,3);
htrt_w_yzav = mean(htrt_w_years,3);
uv_ed_w_yzav = mean(uv_ed_w_years,3);
vt_ed_w_yzav = mean(vt_ed_w_years,3);
Fphi_scaled_w_yzav = mean(Fphi_scaled_w_years,3);
Fp_scaled_w_yzav = mean(Fp_scaled_w_years,3);
fluxdiv_w_yzav = mean(fluxdiv_w_years,3);
eke_w_yzav = mean(eke_w_years,3);
qgref_w_yzav = mean(qgref_w_years,3);
tauE_w_yzav = mean(tauE_w_years,2);
uv_w_yzav = mean(uv_w_years,3);

'saving yzav_th'
save('yzav_th.mat', 'psi_th_yzav', 'uE_th_yzav', 'vN_th_yzav', 'theta_th_yzav', 'htrt_th_yzav', 'uv_ed_th_yzav', 'vt_ed_th_yzav', 'Fphi_scaled_th_yzav', 'Fp_scaled_th_yzav', 'fluxdiv_th_yzav', 'eke_th_yzav', 'qgref_th_yzav', 'tauE_th_yzav', 'uv_th_yzav')

'saving yzav_c'
save('yzav_c.mat', 'psi_c_yzav', 'uE_c_yzav', 'vN_c_yzav', 'theta_c_yzav', 'htrt_c_yzav', 'uv_ed_c_yzav', 'vt_ed_c_yzav', 'Fphi_scaled_c_yzav', 'Fp_scaled_c_yzav', 'fluxdiv_c_yzav', 'eke_c_yzav', 'qgref_c_yzav', 'tauE_c_yzav', 'uv_c_yzav')

'saving yzav_w'
save('yzav_w.mat', 'psi_w_yzav', 'uE_w_yzav', 'vN_w_yzav', 'theta_w_yzav', 'htrt_w_yzav', 'uv_ed_w_yzav', 'vt_ed_w_yzav', 'Fphi_scaled_w_yzav', 'Fp_scaled_w_yzav', 'fluxdiv_w_yzav', 'eke_w_yzav', 'qgref_w_yzav', 'tauE_w_yzav', 'uv_w_yzav')

'saving years_th'
save('years_th.mat', 'psi_th_years', 'uE_th_years', 'vN_th_years', 'theta_th_years', 'htrt_th_years', 'uv_ed_th_years', 'vt_ed_th_years', 'Fphi_scaled_th_years', 'Fp_scaled_th_years', 'fluxdiv_th_years', 'eke_th_years', 'qgref_th_years', 'tauE_th_years', 'uv_th_years')

'saving years_c'
save('years_c.mat', 'psi_c_years', 'uE_c_years', 'vN_c_years', 'theta_c_years', 'htrt_c_years', 'uv_ed_c_years', 'vt_ed_c_years', 'Fphi_scaled_c_years', 'Fp_scaled_c_years', 'fluxdiv_c_years', 'eke_c_years', 'qgref_c_years', 'tauE_c_years', 'uv_c_years')

'saving years_w'
save('years_w.mat', 'psi_w_years', 'uE_w_years', 'vN_w_years', 'theta_w_years', 'htrt_w_years', 'uv_ed_w_years', 'vt_ed_w_years', 'Fphi_scaled_w_years', 'Fp_scaled_w_years', 'fluxdiv_w_years', 'eke_w_years', 'qgref_w_years', 'tauE_w_years', 'uv_w_years')




