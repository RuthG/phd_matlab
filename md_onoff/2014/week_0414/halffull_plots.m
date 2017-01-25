%load up data for tropheat3 experiment and plot up key difference fields plus qg-ref index

%Read in iteration number, directory, MITgcm output and grid details

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_halftofull/';

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

%read fields
i=0;
for nit = 691440:240:705600;
i=i+1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Tropheat run%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_halftofull/';


[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_th(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_th(:,:,:,i) = dyn(:,:,:,J);
[uE_th(:,:,:,i),vN_th(:,:,:,i)] = rotate_uv2uvEN(ucs_th(:,:,:,i),vcs_th(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_th(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_th(:,:,j,i)=theta_th(:,:,j,i).*convthetatoT(j,1);
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Control run%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_tropheat_hw_control/';


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
for j=1:size(rC)
temp_c(:,:,j,i)=theta_c(:,:,j,i).*convthetatoT(j,1);
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


end



%%%%%%%%%%%%%%%%%%%%%%%%%% Tropheat psi  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Define constants
g=9.80;					%gravity
rad=6371.0e3;				%radius of earth
dtr=pi/180;				%conversion from deg to radians
xi=-179:2:180;
yi=-89:2:90;

deltap = 4000;
deltalam = 2.*pi./180.;

integrand = zeros(size(vN_th));

for i=1:60
for k=1:25
integrand(:,:,k,i) = rad.*vN_th(:,:,k,i).*cos(yg.*dtr)./g;
end
end

integral_p = flipdim(cumsum(flipdim(integrand,3).*deltap,3),3);

[integral_lam,mskzon,ylat,areazon]=calcZonalAvgCube(integral_p,ny,yc,ar,hc);
integral_lam_th = integral_lam.*pi.*2;

%psi_th = mean(integral_lam,3);

%%%%%%%%%%%%%%%%%%%%%%%%%% Control psi  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

integrand = zeros(size(vN_c));

for i=1:60
for k=1:25
integrand(:,:,k,i) = rad.*vN_c(:,:,k,i).*cos(yg.*dtr)./g;
end
end

integral_p = flipdim(cumsum(flipdim(integrand,3).*deltap,3),3);

[integral_lam,mskzon,ylat,areazon]=calcZonalAvgCube(integral_p,ny,yc,ar,hc);
integral_lam_c = integral_lam.*pi.*2;

%psi_c = mean(integral_lam,3);



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


for i=1:6
uE_th_tzav(:,:,i) = mean(uE_th_zav(:,:,10*i-9:10*i),3);
theta_th_tzav(:,:,i) = mean(theta_th_zav(:,:,10*i-9:10*i),3);
temp_th_tzav(:,:,i) = mean(temp_th_zav(:,:,10*i-9:10*i),3);
psi_th(:,:,i) = mean(integral_lam_th(:,:,10*i-9:10*i),3);

uE_c_tzav(:,:,i) = mean(uE_c_zav(:,:,10*i-9:10*i),3);
theta_c_tzav(:,:,i) = mean(theta_c_zav(:,:,10*i-9:10*i),3);
temp_c_tzav(:,:,i) = mean(temp_c_zav(:,:,10*i-9:10*i),3);
psi_c(:,:,i) = mean(integral_lam_c(:,:,10*i-9:10*i),3);

end





%%%%%%%%%%%%%%%%%%%%%%% EP fluxes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% tropheat %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dthetadp_th = gradient(theta_th_zav,-4000.);

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
end

[fdp_x,fdp_y,fdp_t] = gradient(Fp_scaled_th,-4000);
fluxdiv_p_th = fdp_x;

[fdphi_x,fdphi_y,fdphi_t] = gradient(Fphi_scaled_th,2*pi./180.);
fluxdiv_phi_th = fdphi_y;

fluxdiv_th = fluxdiv_p_th + fluxdiv_phi_th;


%%%%%%%%%%%%%%%%%%%%% control%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dthetadp_c = gradient(theta_c_zav,-4000.);

ylat_radians = ylat.*pi./180;

costhi = cos(ylat_radians);
omega = 2*pi/(24*60*60);
f = 2*omega*sin(ylat_radians);
g=9.81;

prefactor = costhi.*2.*pi.*rad.^2./g;

%Calculate fluxes and scaled fluxes (Edmon 1980)
for i=1:90
Fphi_c(i,:,:) = -1.*rad.*costhi(i).*uv_ed_c_zav(i,:,:);
Fp_c(i,:,:)   = rad.*f(i).*costhi(i).*vt_ed_c_zav(i,:,:)./dthetadp_c(i,:,:);
Fphi_scaled_c(i,:,:) = Fphi_c(i,:,:).*prefactor(i)./rad;
Fp_scaled_c(i,:,:) = Fp_c(i,:,:).*prefactor(i);
end

[fdp_x,fdp_y,fdp_t] = gradient(Fp_scaled_c,-4000);
fluxdiv_p_c = fdp_x;

[fdphi_x,fdphi_y,fdphi_t] = gradient(Fphi_scaled_c,2*pi./180.);
fluxdiv_phi_c = fdphi_y;

fluxdiv_c = fluxdiv_p_c + fluxdiv_phi_c;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% tropheat QG refractive index %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Constants needed: a, c, k, f/omega, H, R

a = 6371000; % radius of earth
c = 8.0; %phase speed guesstimate for now
k = 7;   %waveno to look at
omeg = 2.*pi./(24.*60.*60);  %rotation rate of earth
f = 2.*omeg.*sin(ylat.*pi./180);
H = 8000 ;   % Density scale height (taken from Isla's thesis)
R = 287.0 ; %gas const for dry air
g=9.81;

ylat_arr = zeros(90,25,6);
rC_arr = zeros(90,25,6);
f_arr = zeros(90,25,6);
for j=1:6
for i=1:25
ylat_arr(:,i,j) = ylat.*pi./180;
f_arr(:,i,j) = f;
end
for i=1:90
rC_arr(i,:,j) = rC;
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Next evaluate dq/dphi. Need du/dp, dtheta/dp

term1_th = 2.*omeg.*cos(ylat_arr);

[b,top_th,moo] = gradient(uE_th_tzav.*cos(ylat_arr),pi./90);
bottom = a.*cos(ylat_arr);

frac = top_th./bottom;

[b,term2_th,moo] = gradient(frac,pi./90);

[dudp_th,b,moo] = gradient(uE_th_tzav,-4000);
[dthetadp_th,b,moo] = gradient(theta_th_tzav,-4000);

prod_th = rC_arr.*theta_th_tzav./temp_th_tzav.*dudp_th./dthetadp_th;

[diff_th,b,moo] = gradient(prod_th,-4000);

term3_th=  a.*f_arr.^2./R.*diff_th;

dqdphi_th = term1_th - term2_th + term3_th;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Also evaluate N = sqrt (g/theta dtheta/dz)

Nsq_th = -(g.^2.*rC_arr)./(R.*temp_th_tzav.*theta_th_tzav) .* dthetadp_th;
N_th = sqrt(Nsq_th);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%qg ref index!

bit1_th = dqdphi_th./(a.*(uE_th_tzav-c));
bit2_th = (k./(a.*cos(ylat_arr))).^2 ;
bit3_th = (f_arr./(2.*N_th.*H)).^2 ;

qgref_th = ( dqdphi_th./(a.*(uE_th_tzav-c)) -  (k./(a.*cos(ylat_arr))).^2   - (f_arr./(2.*N_th.*H)).^2 ) .*a.^2;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% control QG refractive index %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Constants needed: a, c, k, f/omega, H, R

a = 6371000; % radius of earth
c = 8.0; %phase speed guesstimate for now
k = 7;   %waveno to look at
omeg = 2.*pi./(24.*60.*60);  %rotation rate of earth
f = 2.*omeg.*sin(ylat.*pi./180);
H = 8000 ;   % Density scale height (taken from Isla's thesis)
R = 287.0 ; %gas const for dry air
g=9.81;

ylat_arr = zeros(90,25,6);
rC_arr = zeros(90,25,6);
f_arr = zeros(90,25,6);
for j=1:6
for i=1:25
ylat_arr(:,i,j) = ylat.*pi./180;
f_arr(:,i,j) = f;
end
for i=1:90
rC_arr(i,:,j) = rC;
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Next evaluate dq/dphi. Need du/dp, dtheta/dp

term1_c = 2.*omeg.*cos(ylat_arr);

[b,top_c,moo] = gradient(uE_c_tzav.*cos(ylat_arr),pi./90);
bottom = a.*cos(ylat_arr);

frac = top_c./bottom;

[b,term2_c,moo] = gradient(frac,pi./90);

[dudp_c,b,moo] = gradient(uE_c_tzav,-4000);
[dthetadp_c,b,moo] = gradient(theta_c_tzav,-4000);

prod_c = rC_arr.*theta_c_tzav./temp_c_tzav.*dudp_c./dthetadp_c;

[diff_c,b,moo] = gradient(prod_c,-4000);

term3_c=  a.*f_arr.^2./R.*diff_c;

dqdphi_c = term1_c - term2_c + term3_c;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Also evaluate N = sqrt (g/theta dtheta/dz)

Nsq_c = -(g.^2.*rC_arr)./(R.*temp_c_tzav.*theta_c_tzav) .* dthetadp_c;
N_c = sqrt(Nsq_c);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%qg ref index!

bit1_c = dqdphi_c./(a.*(uE_c_tzav-c));
bit2_c = (k./(a.*cos(ylat_arr))).^2 ;
bit3_c = (f_arr./(2.*N_c.*H)).^2 ;

qgref_c = ( dqdphi_c./(a.*(uE_c_tzav-c)) -  (k./(a.*cos(ylat_arr))).^2   - (f_arr./(2.*N_c.*H)).^2 ) .*a.^2;



%%%%%%%%%%%%%%%%%%%%%%%% t-av/h-av %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:6
uE_th_tzav(:,:,i) = mean(uE_th_zav(:,:,10*i-9:10*i),3);
theta_th_tzav(:,:,i) = mean(theta_th_zav(:,:,10*i-9:10*i),3);
temp_th_tzav(:,:,i) = mean(temp_th_zav(:,:,10*i-9:10*i),3);
vN_th_tzav(:,:,i) = mean(vN_th_zav(:,:,10*i-9:10*i),3);
htrt_th_tzav(:,:,i) = mean(htrt_theta_th_zav(:,:,10*i-9:10*i),3);
vt_ed_th_tzav(:,:,i) = mean(vt_ed_th_zav(:,:,10*i-9:10*i),3);
uv_ed_th_tzav(:,:,i) = mean(uv_ed_th_zav(:,:,10*i-9:10*i),3);
Fphi_scaled_th_tav(:,:,i) = mean(Fphi_scaled_th(:,:,10*i-9:10*i),3);
Fp_scaled_th_tav(:,:,i) = mean(Fp_scaled_th(:,:,10*i-9:10*i),3);
fluxdiv_th_tav(:,:,i) = mean(fluxdiv_th(:,:,10*i-9:10*i),3);
eke_th_tav(:,:,i) =  mean(eke_th_zav(:,:,10*i-9:10*i),3);

uE_c_tzav(:,:,i) = mean(uE_c_zav(:,:,10*i-9:10*i),3);
theta_c_tzav(:,:,i) = mean(theta_c_zav(:,:,10*i-9:10*i),3);
temp_c_tzav(:,:,i) = mean(temp_c_zav(:,:,10*i-9:10*i),3);
vN_c_tzav(:,:,i) = mean(vN_c_zav(:,:,10*i-9:10*i),3);
htrt_c_tzav(:,:,i) = mean(htrt_theta_c_zav(:,:,10*i-9:10*i),3);
vt_ed_c_tzav(:,:,i) = mean(vt_ed_c_zav(:,:,10*i-9:10*i),3);
uv_ed_c_tzav(:,:,i) = mean(uv_ed_c_zav(:,:,10*i-9:10*i),3);
Fphi_scaled_c_tav(:,:,i) = mean(Fphi_scaled_c(:,:,10*i-9:10*i),3);
Fp_scaled_c_tav(:,:,i) = mean(Fp_scaled_c(:,:,10*i-9:10*i),3);
fluxdiv_c_tav(:,:,i) = mean(fluxdiv_c(:,:,10*i-9:10*i),3);
eke_c_tav(:,:,i) =  mean(eke_c_zav(:,:,10*i-9:10*i),3);
end



for i=1:45

psi_th_hzav(46-i,:,:) = (-1*psi_th(i,:,:) + psi_th(91-i,:,:))./2;
uE_th_hzav(46-i,:,:) = (uE_th_tzav(i,:,:) + uE_th_tzav(91-i,:,:))./2;
theta_th_hzav(46-i,:,:) = (theta_th_tzav(i,:,:) + theta_th_tzav(91-i,:,:))./2;
htrt_th_hzav(46-i,:,:) = (htrt_th_tzav(i,:,:) + htrt_th_tzav(91-i,:,:))./2;
uv_ed_th_hzav(46-i,:,:) = (-1*uv_ed_th_tzav(i,:,:) + uv_ed_th_tzav(91-i,:,:))./2;
vt_ed_th_hzav(46-i,:,:) = (-1*vt_ed_th_tzav(i,:,:) + vt_ed_th_tzav(91-i,:,:))./2;
Fphi_scaled_th_hzav(46-i,:,:) = (-1*Fphi_scaled_th_tav(i,:,:) + Fphi_scaled_th_tav(91-i,:,:))./2;
Fp_scaled_th_hzav(46-i,:,:) = (Fp_scaled_th_tav(i,:,:) + Fp_scaled_th_tav(91-i,:,:))./2;
fluxdiv_th_hzav(46-i,:,:) = (fluxdiv_th_tav(i,:,:) + fluxdiv_th_tav(91-i,:,:))./2;
eke_th_hzav(46-i,:,:) = (eke_th_tav(i,:,:) + eke_th_tav(91-i,:,:))./2;
qgref_th_hzav(46-i,:,:) = (qgref_th(i,:,:) + qgref_th(91-i,:,:))./2;

psi_c_hzav(46-i,:,:) = (-1*psi_c(i,:,:) + psi_c(91-i,:,:))./2;
uE_c_hzav(46-i,:,:) = (uE_c_tzav(i,:,:) + uE_c_tzav(91-i,:,:))./2;
theta_c_hzav(46-i,:,:) = (theta_c_tzav(i,:,:) + theta_c_tzav(91-i,:,:))./2;
htrt_c_hzav(46-i,:,:) = (htrt_c_tzav(i,:,:) + htrt_c_tzav(91-i,:,:))./2;
uv_ed_c_hzav(46-i,:,:) = (-1*uv_ed_c_tzav(i,:,:) + uv_ed_c_tzav(91-i,:,:))./2;
vt_ed_c_hzav(46-i,:,:) = (-1*vt_ed_c_tzav(i,:,:) + vt_ed_c_tzav(91-i,:,:))./2;
Fphi_scaled_c_hzav(46-i,:,:) = (-1*Fphi_scaled_c_tav(i,:,:) + Fphi_scaled_c_tav(91-i,:,:))./2;
Fp_scaled_c_hzav(46-i,:,:) = (Fp_scaled_c_tav(i,:,:) + Fp_scaled_c_tav(91-i,:,:))./2;
fluxdiv_c_hzav(46-i,:,:) = (fluxdiv_c_tav(i,:,:) + fluxdiv_c_tav(91-i,:,:))./2;
eke_c_hzav(46-i,:,:) = (eke_c_tav(i,:,:) + eke_c_tav(91-i,:,:))./2;
qgref_c_hzav(46-i,:,:) = (qgref_c(i,:,:) + qgref_c(91-i,:,:))./2;

end

masking = zeros(90,25,6);
masking_load = zeros(90,25);

for i=1:6
masking_load(find(qgref_th(:,:,i) >= 0 & qgref_c(:,:,i) >=0 )) = 1;
masking(:,:,i) = masking_load;
end

for i=1:45
masking_hzav(46-i,:,:) = (masking(i,:,:) + masking(91-i,:,:))./2;
end

masking_hzav(find(masking_hzav < 1 )) = 0;

psi_diff = psi_th_hzav - psi_c_hzav;
uE_diff = uE_th_hzav - uE_c_hzav;
theta_diff = theta_th_hzav - theta_c_hzav;
htrt_diff = htrt_th_hzav - htrt_c_hzav;
Fphi_diff = Fphi_scaled_th_hzav - Fphi_scaled_c_hzav;
Fp_diff = Fp_scaled_th_hzav - Fp_scaled_c_hzav;
fluxdiv_diff = fluxdiv_th_hzav - fluxdiv_c_hzav;
eke_diff = eke_th_hzav - eke_c_hzav;
qgref_diff = masking_hzav.*(qgref_th_hzav - qgref_c_hzav);






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
X = 21.0;                  %# A4 paper size
Y = 29.7;                  %# A4 paper size
xMargin = 0.75;               %# left/right margins from page borders
yMargin = 1;               %# bottom/top margins from page borders
xSize = X - 2*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 2*yMargin;     %# figure size on paper (widht & hieght)
xSize_sub = 0.4;
ySize_sub = 1./3-0.1;

pos1x = 0.1 ; 	pos1y = 2/3+0.05; 
pos2x = 0.55;	pos2y = 2/3+0.05;
pos3x = 0.1; 	pos3y = 1/3+0.05;
pos4x = 0.55; 	pos4y = 1/3+0.05;
pos5x = 0.1; 	pos5y = 0.05;
pos6x = 0.55; 	pos6y = 0.05;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-10:2:0;
[C,h]=contour(ylat(46:90),rC./100.,uE_diff(:,:,1)',v,'k--');
clabel(C,h);
hold on
v=0:2:10;
[C,h]=contour(ylat(46:90),rC./100.,uE_diff(:,:,1)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(a)'],'color','k','fontw','b')
hold off


axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-10:2:0;
[C,h]=contour(ylat(46:90),rC./100.,uE_diff(:,:,2)',v,'k--');
clabel(C,h);
hold on
v=0:2:10;
[C,h]=contour(ylat(46:90),rC./100.,uE_diff(:,:,2)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(b)'],'color','k','fontw','b')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-10:2:0;
[C,h]=contour(ylat(46:90),rC./100.,uE_diff(:,:,3)',v,'k--');
clabel(C,h);
hold on
v=0:2:10;
[C,h]=contour(ylat(46:90),rC./100.,uE_diff(:,:,3)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(a)'],'color','k','fontw','b')
hold off


axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-10:2:0;
[C,h]=contour(ylat(46:90),rC./100.,uE_diff(:,:,4)',v,'k--');
clabel(C,h);
hold on
v=0:2:10;
[C,h]=contour(ylat(46:90),rC./100.,uE_diff(:,:,4)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(b)'],'color','k','fontw','b')
hold off

axes('position',[pos5x pos5y xSize_sub ySize_sub])
v=-10:2:0;
[C,h]=contour(ylat(46:90),rC./100.,uE_diff(:,:,5)',v,'k--');
clabel(C,h);
hold on
v=0:2:10;
[C,h]=contour(ylat(46:90),rC./100.,uE_diff(:,:,5)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(a)'],'color','k','fontw','b')
hold off


axes('position',[pos6x pos6y xSize_sub ySize_sub])
v=-10:2:0;
[C,h]=contour(ylat(46:90),rC./100.,uE_diff(:,:,6)',v,'k--');
clabel(C,h);
hold on
v=0:2:10;
[C,h]=contour(ylat(46:90),rC./100.,uE_diff(:,:,6)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(b)'],'color','k','fontw','b')
hold off

print('-dpdf','u_halftofull.pdf')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-100:25:0;
[C,h]=contour(ylat(46:90),rC./100.,psi_diff(:,:,1)'./1e9,v,'k--');
clabel(C,h);
hold on
v=0:25:200;
[C,h]=contour(ylat(46:90),rC./100.,psi_diff(:,:,1)'./1e9,v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(a)'],'color','k','fontw','b')
hold off


axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-100:25:0;
[C,h]=contour(ylat(46:90),rC./100.,psi_diff(:,:,2)'./1e9,v,'k--');
clabel(C,h);
hold on
v=0:25:200;
[C,h]=contour(ylat(46:90),rC./100.,psi_diff(:,:,2)'./1e9,v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(b)'],'color','k','fontw','b')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-100:25:0;
[C,h]=contour(ylat(46:90),rC./100.,psi_diff(:,:,3)'./1e9,v,'k--');
clabel(C,h);
hold on
v=0:25:200;
[C,h]=contour(ylat(46:90),rC./100.,psi_diff(:,:,3)'./1e9,v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(a)'],'color','k','fontw','b')
hold off


axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-100:25:0;
[C,h]=contour(ylat(46:90),rC./100.,psi_diff(:,:,4)'./1e9,v,'k--');
clabel(C,h);
hold on
v=0:25:200;
[C,h]=contour(ylat(46:90),rC./100.,psi_diff(:,:,4)'./1e9,v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(b)'],'color','k','fontw','b')
hold off

axes('position',[pos5x pos5y xSize_sub ySize_sub])
v=-100:25:0;
[C,h]=contour(ylat(46:90),rC./100.,psi_diff(:,:,5)'./1e9,v,'k--');
clabel(C,h);
hold on
v=0:25:200;
[C,h]=contour(ylat(46:90),rC./100.,psi_diff(:,:,5)'./1e9,v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(a)'],'color','k','fontw','b')
hold off


axes('position',[pos6x pos6y xSize_sub ySize_sub])
v=-100:25:0;
[C,h]=contour(ylat(46:90),rC./100.,psi_diff(:,:,6)'./1e9,v,'k--');
clabel(C,h);
hold on
v=0:25:200;
[C,h]=contour(ylat(46:90),rC./100.,psi_diff(:,:,6)'./1e9,v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(b)'],'color','k','fontw','b')
hold off

print('-dpdf','psi_halftofull.pdf')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 3%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-10:2:0;
[C,h]=contour(ylat(46:90),rC./100.,theta_diff(:,:,1)',v,'k--');
clabel(C,h);
hold on
v=0:2:20;
[C,h]=contour(ylat(46:90),rC./100.,theta_diff(:,:,1)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(a)'],'color','k','fontw','b')
hold off


axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-10:2:0;
[C,h]=contour(ylat(46:90),rC./100.,theta_diff(:,:,2)',v,'k--');
clabel(C,h);
hold on
v=0:2:20;
[C,h]=contour(ylat(46:90),rC./100.,theta_diff(:,:,2)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(b)'],'color','k','fontw','b')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-10:2:0;
[C,h]=contour(ylat(46:90),rC./100.,theta_diff(:,:,3)',v,'k--');
clabel(C,h);
hold on
v=0:2:20;
[C,h]=contour(ylat(46:90),rC./100.,theta_diff(:,:,3)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(a)'],'color','k','fontw','b')
hold off


axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-10:2:0;
[C,h]=contour(ylat(46:90),rC./100.,theta_diff(:,:,4)',v,'k--');
clabel(C,h);
hold on
v=0:2:20;
[C,h]=contour(ylat(46:90),rC./100.,theta_diff(:,:,4)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(b)'],'color','k','fontw','b')
hold off

axes('position',[pos5x pos5y xSize_sub ySize_sub])
v=-10:2:0;
[C,h]=contour(ylat(46:90),rC./100.,theta_diff(:,:,5)',v,'k--');
clabel(C,h);
hold on
v=0:2:20;
[C,h]=contour(ylat(46:90),rC./100.,theta_diff(:,:,5)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(a)'],'color','k','fontw','b')
hold off


axes('position',[pos6x pos6y xSize_sub ySize_sub])
v=-10:2:0;
[C,h]=contour(ylat(46:90),rC./100.,theta_diff(:,:,6)',v,'k--');
clabel(C,h);
hold on
v=0:2:20;
[C,h]=contour(ylat(46:90),rC./100.,theta_diff(:,:,6)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(b)'],'color','k','fontw','b')
hold off

print('-dpdf','theta_halftofull.pdf')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 4%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,htrt_diff(:,:,1)',v,'k--');
clabel(C,h);
hold on
v=0:1:20;
[C,h]=contour(ylat(46:90),rC./100.,htrt_diff(:,:,1)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(a)'],'color','k','fontw','b')
hold off


axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,htrt_diff(:,:,2)',v,'k--');
clabel(C,h);
hold on
v=0:1:20;
[C,h]=contour(ylat(46:90),rC./100.,htrt_diff(:,:,2)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(b)'],'color','k','fontw','b')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,htrt_diff(:,:,3)',v,'k--');
clabel(C,h);
hold on
v=0:1:20;
[C,h]=contour(ylat(46:90),rC./100.,htrt_diff(:,:,3)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(a)'],'color','k','fontw','b')
hold off


axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,htrt_diff(:,:,4)',v,'k--');
clabel(C,h);
hold on
v=0:1:20;
[C,h]=contour(ylat(46:90),rC./100.,htrt_diff(:,:,4)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(b)'],'color','k','fontw','b')
hold off

axes('position',[pos5x pos5y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,htrt_diff(:,:,5)',v,'k--');
clabel(C,h);
hold on
v=0:1:20;
[C,h]=contour(ylat(46:90),rC./100.,htrt_diff(:,:,5)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(a)'],'color','k','fontw','b')
hold off


axes('position',[pos6x pos6y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,htrt_diff(:,:,6)',v,'k--');
clabel(C,h);
hold on
v=0:1:20;
[C,h]=contour(ylat(46:90),rC./100.,htrt_diff(:,:,6)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(b)'],'color','k','fontw','b')
hold off

print('-dpdf','htrt_halftofull.pdf')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 5%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%%% test regridding
for i=1:23
for j=1:13
Fphi_diff_red(i,j,:) = Fphi_diff(i*2 -1, j*2 -1,:);
Fp_diff_red(i,j,:) = Fp_diff(i*2 -1, j*2 -1,:);
xspaces(i) = ylat(i*2+44 );
yspaces(j) = rC(j*2-1 );
end
end


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-400:50:400;
contourf(ylat(46:90),rC./10^3,qgref_diff(:,:,1)',v)
colormap(b2r(-400,400));
colorbar
caxis([-400 400]);
hold on
labelling = num2str(shiftdim([200:200:1000],1));
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_diff_red(:,:,1)',1.6e-20.*Fp_diff_red(:,:,1)','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
quiver(68, 21, 10, 0,'b');
text(68, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(68, 15, 0, -8,'b');
text(69, 12, '\fontsize{8}5E20 M3(PA)');
hold off
freezeColors
cbfreeze(colorbar);


axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-400:50:400;
contourf(ylat(46:90),rC./10^3,qgref_diff(:,:,2)',v)
colormap(b2r(-400,400));
colorbar
caxis([-400 400]);
hold on
labelling = num2str(shiftdim([200:200:1000],1));
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_diff_red(:,:,2)',1.6e-20.*Fp_diff_red(:,:,2)','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',[])
xlabel('Latitude')
ylabel('Pressure, Pa')
quiver(68, 21, 10, 0,'b');
text(68, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(68, 15, 0, -8,'b');
text(69, 12, '\fontsize{8}5E20 M3(PA)');
hold off
freezeColors
cbfreeze(colorbar);


axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-400:50:400;
contourf(ylat(46:90),rC./10^3,qgref_diff(:,:,3)',v)
colormap(b2r(-400,400));
colorbar
caxis([-400 400]);
hold on
labelling = num2str(shiftdim([200:200:1000],1));
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_diff_red(:,:,3)',1.6e-20.*Fp_diff_red(:,:,3)','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
quiver(68, 21, 10, 0,'b');
text(68, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(68, 15, 0, -8,'b');
text(69, 12, '\fontsize{8}5E20 M3(PA)');
hold off
freezeColors
cbfreeze(colorbar);



axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-400:50:400;
contourf(ylat(46:90),rC./10^3,qgref_diff(:,:,4)',v)
colormap(b2r(-400,400));
colorbar
caxis([-400 400]);
hold on
labelling = num2str(shiftdim([200:200:1000],1));
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_diff_red(:,:,4)',1.6e-20.*Fp_diff_red(:,:,4)','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',[])
xlabel('Latitude')
ylabel('Pressure, Pa')
quiver(68, 21, 10, 0,'b');
text(68, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(68, 15, 0, -8,'b');
text(69, 12, '\fontsize{8}5E20 M3(PA)');
hold off
freezeColors
cbfreeze(colorbar);


axes('position',[pos5x pos5y xSize_sub ySize_sub])
v=-400:50:400;
contourf(ylat(46:90),rC./10^3,qgref_diff(:,:,5)',v)
colormap(b2r(-400,400));
colorbar
caxis([-400 400]);
hold on
labelling = num2str(shiftdim([200:200:1000],1));
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_diff_red(:,:,5)',1.6e-20.*Fp_diff_red(:,:,5)','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
quiver(68, 21, 10, 0,'b');
text(68, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(68, 15, 0, -8,'b');
text(69, 12, '\fontsize{8}5E20 M3(PA)');
hold off
freezeColors
cbfreeze(colorbar);



axes('position',[pos6x pos6y xSize_sub ySize_sub])
v=-400:50:400;
contourf(ylat(46:90),rC./10^3,qgref_diff(:,:,6)',v)
colormap(b2r(-400,400));
colorbar
caxis([-400 400]);
hold on
labelling = num2str(shiftdim([200:200:1000],1));
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_diff_red(:,:,6)',1.6e-20.*Fp_diff_red(:,:,6)','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',[])
xlabel('Latitude')
ylabel('Pressure, Pa')
quiver(68, 21, 10, 0,'b');
text(68, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(68, 15, 0, -8,'b');
text(69, 12, '\fontsize{8}5E20 M3(PA)');
hold off
freezeColors
cbfreeze(colorbar);



print('-dpdf','qgref_halftofull.pdf')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 6%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-100:10:0;
[C,h]=contour(ylat(46:90),rC./100.,eke_diff(:,:,1)',v,'k--');
clabel(C,h);
hold on
v=0:10:125;
[C,h]=contour(ylat(46:90),rC./100.,eke_diff(:,:,1)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(a)'],'color','k','fontw','b')
hold off


axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-100:10:0;
[C,h]=contour(ylat(46:90),rC./100.,eke_diff(:,:,2)',v,'k--');
clabel(C,h);
hold on
v=0:10:125;
[C,h]=contour(ylat(46:90),rC./100.,eke_diff(:,:,2)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(b)'],'color','k','fontw','b')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-100:10:0;
[C,h]=contour(ylat(46:90),rC./100.,eke_diff(:,:,3)',v,'k--');
clabel(C,h);
hold on
v=0:10:125;
[C,h]=contour(ylat(46:90),rC./100.,eke_diff(:,:,3)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(a)'],'color','k','fontw','b')
hold off


axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-100:10:0;
[C,h]=contour(ylat(46:90),rC./100.,eke_diff(:,:,4)',v,'k--');
clabel(C,h);
hold on
v=0:10:125;
[C,h]=contour(ylat(46:90),rC./100.,eke_diff(:,:,4)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(b)'],'color','k','fontw','b')
hold off

axes('position',[pos5x pos5y xSize_sub ySize_sub])
v=-100:10:0;
[C,h]=contour(ylat(46:90),rC./100.,eke_diff(:,:,5)',v,'k--');
clabel(C,h);
hold on
v=0:10:125;
[C,h]=contour(ylat(46:90),rC./100.,eke_diff(:,:,5)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(a)'],'color','k','fontw','b')
hold off


axes('position',[pos6x pos6y xSize_sub ySize_sub])
v=-100:10:0;
[C,h]=contour(ylat(46:90),rC./100.,eke_diff(:,:,6)',v,'k--');
clabel(C,h);
hold on
v=0:10:125;
[C,h]=contour(ylat(46:90),rC./100.,eke_diff(:,:,6)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(b)'],'color','k','fontw','b')
hold off

print('-dpdf','eke_halftofull.pdf')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 7%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%%% test regridding
for i=1:23
for j=1:13
Fphi_diff_red(i,j,:) = Fphi_diff(i*2 -1, j*2 -1,:);
Fp_diff_red(i,j,:) = Fp_diff(i*2 -1, j*2 -1,:);
xspaces(i) = ylat(i*2+44 );
yspaces(j) = rC(j*2-1 );
end
end


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=0:0.25:5;
[C,h] = contour(ylat(46:90),rC./10^3,fluxdiv_diff(:,:,1)'./1e16,v,'k');
clabel(C,h);
hold on
v=-5:0.25:0;
[C,h] = contour(ylat(46:90),rC./10^3,fluxdiv_diff(:,:,1)'./1e16,v,'k--');
clabel(C,h);
labelling = num2str(shiftdim([200:200:1000],1));
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_diff_red(:,:,1)',1.6e-20.*Fp_diff_red(:,:,1)','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, hPa')
quiver(68, 21, 10, 0,'b');
text(68, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(68, 15, 0, -8,'b');
text(69, 12, '\fontsize{8}5E20 M3(PA)');
hold off



axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=0:0.25:5;
[C,h] = contour(ylat(46:90),rC./10^3,fluxdiv_diff(:,:,2)'./1e16,v,'k');
clabel(C,h);
hold on
v=-5:0.25:0;
[C,h] = contour(ylat(46:90),rC./10^3,fluxdiv_diff(:,:,2)'./1e16,v,'k--');
clabel(C,h);
labelling = num2str(shiftdim([200:200:1000],1));
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_diff_red(:,:,2)',1.6e-20.*Fp_diff_red(:,:,2)','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',[])
xlabel('Latitude')
ylabel('Pressure, hPa')
quiver(68, 21, 10, 0,'b');
text(68, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(68, 15, 0, -8,'b');
text(69, 12, '\fontsize{8}5E20 M3(PA)');
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=0:0.25:5;
[C,h] = contour(ylat(46:90),rC./10^3,fluxdiv_diff(:,:,3)'./1e16,v,'k');
clabel(C,h);
hold on
v=-5:0.25:0;
[C,h] = contour(ylat(46:90),rC./10^3,fluxdiv_diff(:,:,3)'./1e16,v,'k--');
clabel(C,h);
labelling = num2str(shiftdim([200:200:1000],1));
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_diff_red(:,:,3)',1.6e-20.*Fp_diff_red(:,:,3)','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, hPa')
quiver(68, 21, 10, 0,'b');
text(68, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(68, 15, 0, -8,'b');
text(69, 12, '\fontsize{8}5E20 M3(PA)');
hold off


axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=0:0.25:5;
[C,h] = contour(ylat(46:90),rC./10^3,fluxdiv_diff(:,:,4)'./1e16,v,'k');
clabel(C,h);
hold on
v=-5:0.25:0;
[C,h] = contour(ylat(46:90),rC./10^3,fluxdiv_diff(:,:,4)'./1e16,v,'k--');
clabel(C,h);
labelling = num2str(shiftdim([200:200:1000],1));
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_diff_red(:,:,4)',1.6e-20.*Fp_diff_red(:,:,4)','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',[])
xlabel('Latitude')
ylabel('Pressure, hPa')
quiver(68, 21, 10, 0,'b');
text(68, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(68, 15, 0, -8,'b');
text(69, 12, '\fontsize{8}5E20 M3(PA)');
hold off

axes('position',[pos5x pos5y xSize_sub ySize_sub])
v=0:0.25:5;
[C,h] = contour(ylat(46:90),rC./10^3,fluxdiv_diff(:,:,5)'./1e16,v,'k');
clabel(C,h);
hold on
v=-5:0.25:0;
[C,h] = contour(ylat(46:90),rC./10^3,fluxdiv_diff(:,:,5)'./1e16,v,'k--');
clabel(C,h);
labelling = num2str(shiftdim([200:200:1000],1));
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_diff_red(:,:,5)',1.6e-20.*Fp_diff_red(:,:,5)','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, hPa')
quiver(68, 21, 10, 0,'b');
text(68, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(68, 15, 0, -8,'b');
text(69, 12, '\fontsize{8}5E20 M3(PA)');
hold off


axes('position',[pos6x pos6y xSize_sub ySize_sub])
v=0:0.25:5;
[C,h] = contour(ylat(46:90),rC./10^3,fluxdiv_diff(:,:,6)'./1e16,v,'k');
clabel(C,h);
hold on
v=-5:0.25:0;
[C,h] = contour(ylat(46:90),rC./10^3,fluxdiv_diff(:,:,6)'./1e16,v,'k--');
clabel(C,h);
labelling = num2str(shiftdim([200:200:1000],1));
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_diff_red(:,:,6)',1.6e-20.*Fp_diff_red(:,:,6)','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',[])
xlabel('Latitude')
ylabel('Pressure, hPa')
quiver(68, 21, 10, 0,'b');
text(68, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(68, 15, 0, -8,'b');
text(69, 12, '\fontsize{8}5E20 M3(PA)');
hold off

print('-dpdf','epflux_halftofull.pdf')
