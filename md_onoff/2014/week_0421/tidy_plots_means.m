%for the 4 varying water vapour climates we have, plot up one pdf of the 'key fields' and one of everything.
%key fields are u, theta, EP flux/divergence, psi, htrt, EKE
%everything is u, v, w, u'v', v'T', EKE, theta, T, q, heating terms


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

%read fields
i=0;
for nit = 432000:86400:604800;
i=i+1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Wet Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
htrt_in=dyn(:,:,:,J);
htrt_theta_w(:,:,:,i)=htrt_in*86400.;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Half WV Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_h(:,:,:,i) = dyn(:,:,:,J);
[uE_h(:,:,:,i),vN_h(:,:,:,i)] = rotate_uv2uvEN(ucs_h(:,:,:,i),vcs_h(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
temp_h(:,:,k,i)=theta_h(:,:,k,i).*convthetatoT(k,1);
end

J=find(strcmp(fldList,'UV_VEL_C'));
uv_h(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_h(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_h(:,:,:,i),vNt_av_h(:,:,:,i)] = rotate_uv2uvEN(ut_av_h(:,:,:,i),vt_av_h(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'VVELSQ  '));
vsq_av_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELSQ  '));
usq_av_h(:,:,:,i) = dyn(:,:,:,J);

tothke_h(:,:,:,i) = vsq_av_h(:,:,:,i) + usq_av_h(:,:,:,i);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_in=dyn(:,:,:,J);
htrt_theta_h(:,:,:,i)=htrt_in*86400.;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Quarter WV Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nit_q = nit + 518400;
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv_tropheat3eq/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit_q);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_q(:,:,:,i) = dyn(:,:,:,J);
[uE_q(:,:,:,i),vN_q(:,:,:,i)] = rotate_uv2uvEN(ucs_q(:,:,:,i),vcs_q(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_q(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
temp_q(:,:,k,i)=theta_q(:,:,k,i).*convthetatoT(k,1);
end

J=find(strcmp(fldList,'UV_VEL_C'));
uv_q(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_q(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_q(:,:,:,i),vNt_av_q(:,:,:,i)] = rotate_uv2uvEN(ut_av_q(:,:,:,i),vt_av_q(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'VVELSQ  '));
vsq_av_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELSQ  '));
usq_av_q(:,:,:,i) = dyn(:,:,:,J);

tothke_q(:,:,:,i) = vsq_av_q(:,:,:,i) + usq_av_q(:,:,:,i);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_in=dyn(:,:,:,J);
htrt_theta_q(:,:,:,i)=htrt_in*86400.;


end






%%%%%%%%%%%%%%%%%%%%%%%%%% Wet psi  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Define constants
g=9.80;					%gravity
rad=6371.0e3;				%radius of earth
dtr=pi/180;				%conversion from deg to radians
xi=-179:2:180;
yi=-89:2:90;

deltap = 4000;
deltalam = 2.*pi./180.;

integrand = zeros(size(vN_w));

for i=1:3
for k=1:25
integrand(:,:,k,i) = rad.*vN_w(:,:,k,i).*cos(yg.*dtr)./g;
end
end

integral_p = flipdim(cumsum(flipdim(integrand,3).*deltap,3),3);

[integral_lam,mskzon,ylat,areazon]=calcZonalAvgCube(integral_p,ny,yc,ar,hc);
integral_lam = integral_lam.*pi.*2;

psi_w = mean(integral_lam,3);

%%%%%%%%%%%%%%%%%%%%%%%%%% Half WV psi  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

integrand = zeros(size(vN_h));

for i=1:3
for k=1:25
integrand(:,:,k,i) = rad.*vN_h(:,:,k,i).*cos(yg.*dtr)./g;
end
end

integral_p = flipdim(cumsum(flipdim(integrand,3).*deltap,3),3);

[integral_lam,mskzon,ylat,areazon]=calcZonalAvgCube(integral_p,ny,yc,ar,hc);
integral_lam = integral_lam.*pi.*2;

psi_h = mean(integral_lam,3);

%%%%%%%%%%%%%%%%%%%%%%%%%% Quarter WV psi  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

integrand = zeros(size(vN_q));

for i=1:3
for k=1:25
integrand(:,:,k,i) = rad.*vN_q(:,:,k,i).*cos(yg.*dtr)./g;
end
end

integral_p = flipdim(cumsum(flipdim(integrand,3).*deltap,3),3);

[integral_lam,mskzon,ylat,areazon]=calcZonalAvgCube(integral_p,ny,yc,ar,hc);
integral_lam = integral_lam.*pi.*2;

psi_q = mean(integral_lam,3);


%%%%%%%%%%%%%%%%%%%%%%% zavs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

[uE_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_h,ny,yc,ar,hc);
[vN_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_h,ny,yc,ar,hc);
[theta_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_h,ny,yc,ar,hc);
[temp_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_h,ny,yc,ar,hc);
[uv_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_h,ny,yc,ar,hc);
[vt_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_h,ny,yc,ar,hc);
[htrt_theta_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_theta_h,ny,yc,ar,hc);
[tothke_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tothke_h,ny,yc,ar,hc);
vt_ed_h_zav = vt_h_zav - vN_h_zav.*theta_h_zav;
uv_ed_h_zav = uv_h_zav - uE_h_zav.*vN_h_zav;
eke_h_zav = (tothke_h_zav - uE_h_zav.*uE_h_zav - vN_h_zav.*vN_h_zav)./2;

[uE_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_q,ny,yc,ar,hc);
[vN_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_q,ny,yc,ar,hc);
[theta_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_q,ny,yc,ar,hc);
[temp_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_q,ny,yc,ar,hc);
[uv_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_q,ny,yc,ar,hc);
[vt_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_q,ny,yc,ar,hc);
[htrt_theta_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_theta_q,ny,yc,ar,hc);
[tothke_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tothke_q,ny,yc,ar,hc);
vt_ed_q_zav = vt_q_zav - vN_q_zav.*theta_q_zav;
uv_ed_q_zav = uv_q_zav - uE_q_zav.*vN_q_zav;
eke_q_zav = (tothke_q_zav - uE_q_zav.*uE_q_zav - vN_q_zav.*vN_q_zav)./2;


%%%%%%%%%%%%%%%%%%%%%%% EP fluxes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% wet %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dthetadp_w = gradient(theta_w_zav,-4000.);

ylat_radians = ylat.*pi./180;

costhi = cos(ylat_radians);
omega = 2*pi/(24*60*60);
f = 2*omega*sin(ylat_radians);
g=9.81;

prefactor = costhi.*2.*pi.*rad.^2./g;

%Calculate fluxes and scaled fluxes (Edmon 1980)
for i=1:90
Fphi_w(i,:,:) = -1.*rad.*costhi(i).*uv_ed_w_zav(i,:,:);
Fp_w(i,:,:)   = rad.*f(i).*costhi(i).*vt_ed_w_zav(i,:,:)./dthetadp_w(i,:,:);
Fphi_scaled_w(i,:,:) = Fphi_w(i,:,:).*prefactor(i)./rad;
Fp_scaled_w(i,:,:) = Fp_w(i,:,:).*prefactor(i);
end

[fdp_x,fdp_y,fdp_t] = gradient(Fp_scaled_w,-4000);
fluxdiv_p_w = fdp_x;

[fdphi_x,fdphi_y,fdphi_t] = gradient(Fphi_scaled_w,2*pi./180.);
fluxdiv_phi_w = fdphi_y;

fluxdiv_w = fluxdiv_p_w + fluxdiv_phi_w;


%%%%%%%%%%%%%%%%%%%%% Half wv %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dthetadp_h = gradient(theta_h_zav,-4000.);

ylat_radians = ylat.*pi./180;

costhi = cos(ylat_radians);
omega = 2*pi/(24*60*60);
f = 2*omega*sin(ylat_radians);
g=9.81;

prefactor = costhi.*2.*pi.*rad.^2./g;

%Calculate fluxes and scaled fluxes (Edmon 1980)
for i=1:90
Fphi_h(i,:,:) = -1.*rad.*costhi(i).*uv_ed_h_zav(i,:,:);
Fp_h(i,:,:)   = rad.*f(i).*costhi(i).*vt_ed_h_zav(i,:,:)./dthetadp_h(i,:,:);
Fphi_scaled_h(i,:,:) = Fphi_h(i,:,:).*prefactor(i)./rad;
Fp_scaled_h(i,:,:) = Fp_h(i,:,:).*prefactor(i);
end

[fdp_x,fdp_y,fdp_t] = gradient(Fp_scaled_h,-4000);
fluxdiv_p_h = fdp_x;

[fdphi_x,fdphi_y,fdphi_t] = gradient(Fphi_scaled_h,2*pi./180.);
fluxdiv_phi_h = fdphi_y;

fluxdiv_h = fluxdiv_p_h + fluxdiv_phi_h;


%%%%%%%%%%%%%%%%%%%%% Quarter WV %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dthetadp_q = gradient(theta_q_zav,-4000.);

ylat_radians = ylat.*pi./180;

costhi = cos(ylat_radians);
omega = 2*pi/(24*60*60);
f = 2*omega*sin(ylat_radians);
g=9.81;

prefactor = costhi.*2.*pi.*rad.^2./g;

%Calculate fluxes and scaled fluxes (Edmon 1980)
for i=1:90
Fphi_q(i,:,:) = -1.*rad.*costhi(i).*uv_ed_q_zav(i,:,:);
Fp_q(i,:,:)   = rad.*f(i).*costhi(i).*vt_ed_q_zav(i,:,:)./dthetadp_q(i,:,:);
Fphi_scaled_q(i,:,:) = Fphi_q(i,:,:).*prefactor(i)./rad;
Fp_scaled_q(i,:,:) = Fp_q(i,:,:).*prefactor(i);
end

[fdp_x,fdp_y,fdp_t] = gradient(Fp_scaled_q,-4000);
fluxdiv_p_q = fdp_x;

[fdphi_x,fdphi_y,fdphi_t] = gradient(Fphi_scaled_q,2*pi./180.);
fluxdiv_phi_q = fdphi_y;

fluxdiv_q = fluxdiv_p_q + fluxdiv_phi_q;

%%%%%%%%%%%%%%%%%%%%%%%% t-av/h-av %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uE_w_tzav = mean(uE_w_zav,3);
vN_w_tzav = mean(vN_w_zav,3);
theta_w_tzav = mean(theta_w_zav,3);
temp_w_tzav = mean(temp_w_zav,3);
htrt_w_tzav = mean(htrt_theta_w_zav,3);
vt_ed_w_tzav = mean(vt_ed_w_zav,3);
uv_ed_w_tzav = mean(uv_ed_w_zav,3);
Fphi_scaled_w_tav = mean(Fphi_scaled_w,3);
Fp_scaled_w_tav = mean(Fp_scaled_w,3);
fluxdiv_w_tav = mean(fluxdiv_w,3);
eke_w_tav = mean(eke_w_zav,3);

uE_h_tzav = mean(uE_h_zav,3);
vN_h_tzav = mean(vN_h_zav,3);
theta_h_tzav = mean(theta_h_zav,3);
temp_h_tzav = mean(temp_h_zav,3);
htrt_h_tzav = mean(htrt_theta_h_zav,3);
vt_ed_h_tzav = mean(vt_ed_h_zav,3);
uv_ed_h_tzav = mean(uv_ed_h_zav,3);
Fphi_scaled_h_tav = mean(Fphi_scaled_h,3);
Fp_scaled_h_tav = mean(Fp_scaled_h,3);
fluxdiv_h_tav = mean(fluxdiv_h,3);
eke_h_tav = mean(eke_h_zav,3);

uE_q_tzav = mean(uE_q_zav,3);
vN_q_tzav = mean(vN_q_zav,3);
theta_q_tzav = mean(theta_q_zav,3);
temp_q_tzav = mean(temp_q_zav,3);
htrt_q_tzav = mean(htrt_theta_q_zav,3);
vt_ed_q_tzav = mean(vt_ed_q_zav,3);
uv_ed_q_tzav = mean(uv_ed_q_zav,3);
Fphi_scaled_q_tav = mean(Fphi_scaled_q,3);
Fp_scaled_q_tav = mean(Fp_scaled_q,3);
fluxdiv_q_tav = mean(fluxdiv_q,3);
eke_q_tav = mean(eke_q_zav,3);

for i=1:45
psi_w_hzav(46-i,:) = (-1*psi_w(i,:) + psi_w(91-i,:))./2;
uE_w_hzav(46-i,:) = (uE_w_tzav(i,:) + uE_w_tzav(91-i,:))./2;
theta_w_hzav(46-i,:) = (theta_w_tzav(i,:) + theta_w_tzav(91-i,:))./2;
temp_w_hzav(46-i,:) = (temp_w_tzav(i,:) + temp_w_tzav(91-i,:))./2;
htrt_w_hzav(46-i,:) = (htrt_w_tzav(i,:) + htrt_w_tzav(91-i,:))./2;
uv_ed_w_hzav(46-i,:) = (-1*uv_ed_w_tzav(i,:) + uv_ed_w_tzav(91-i,:))./2;
vt_ed_w_hzav(46-i,:) = (-1*vt_ed_w_tzav(i,:) + vt_ed_w_tzav(91-i,:))./2;
Fphi_scaled_w_hzav(46-i,:) = (-1*Fphi_scaled_w_tav(i,:) + Fphi_scaled_w_tav(91-i,:))./2;
Fp_scaled_w_hzav(46-i,:) = (Fp_scaled_w_tav(i,:) + Fp_scaled_w_tav(91-i,:))./2;
fluxdiv_w_hzav(46-i,:) = (fluxdiv_w_tav(i,:) + fluxdiv_w_tav(91-i,:))./2;
eke_w_hzav(46-i,:) = (eke_w_tav(i,:) + eke_w_tav(91-i,:))./2;

psi_h_hzav(46-i,:) = (-1*psi_h(i,:) + psi_h(91-i,:))./2;
uE_h_hzav(46-i,:) = (uE_h_tzav(i,:) + uE_h_tzav(91-i,:))./2;
theta_h_hzav(46-i,:) = (theta_h_tzav(i,:) + theta_h_tzav(91-i,:))./2;
temp_h_hzav(46-i,:) = (temp_h_tzav(i,:) + temp_h_tzav(91-i,:))./2;
htrt_h_hzav(46-i,:) = (htrt_h_tzav(i,:) + htrt_h_tzav(91-i,:))./2;
uv_ed_h_hzav(46-i,:) = (-1*uv_ed_h_tzav(i,:) + uv_ed_h_tzav(91-i,:))./2;
vt_ed_h_hzav(46-i,:) = (-1*vt_ed_h_tzav(i,:) + vt_ed_h_tzav(91-i,:))./2;
Fphi_scaled_h_hzav(46-i,:) = (-1*Fphi_scaled_h_tav(i,:) + Fphi_scaled_h_tav(91-i,:))./2;
Fp_scaled_h_hzav(46-i,:) = (Fp_scaled_h_tav(i,:) + Fp_scaled_h_tav(91-i,:))./2;
fluxdiv_h_hzav(46-i,:) = (fluxdiv_h_tav(i,:) + fluxdiv_h_tav(91-i,:))./2;
eke_h_hzav(46-i,:) = (eke_h_tav(i,:) + eke_h_tav(91-i,:))./2;

psi_q_hzav(46-i,:) = (-1*psi_q(i,:) + psi_q(91-i,:))./2;
uE_q_hzav(46-i,:) = (uE_q_tzav(i,:) + uE_q_tzav(91-i,:))./2;
theta_q_hzav(46-i,:) = (theta_q_tzav(i,:) + theta_q_tzav(91-i,:))./2;
temp_q_hzav(46-i,:) = (temp_q_tzav(i,:) + temp_q_tzav(91-i,:))./2;
htrt_q_hzav(46-i,:) = (htrt_q_tzav(i,:) + htrt_q_tzav(91-i,:))./2;
uv_ed_q_hzav(46-i,:) = (-1*uv_ed_q_tzav(i,:) + uv_ed_q_tzav(91-i,:))./2;
vt_ed_q_hzav(46-i,:) = (-1*vt_ed_q_tzav(i,:) + vt_ed_q_tzav(91-i,:))./2;
Fphi_scaled_q_hzav(46-i,:) = (-1*Fphi_scaled_q_tav(i,:) + Fphi_scaled_q_tav(91-i,:))./2;
Fp_scaled_q_hzav(46-i,:) = (Fp_scaled_q_tav(i,:) + Fp_scaled_q_tav(91-i,:))./2;
fluxdiv_q_hzav(46-i,:) = (fluxdiv_q_tav(i,:) + fluxdiv_q_tav(91-i,:))./2;
eke_q_hzav(46-i,:) = (eke_q_tav(i,:) + eke_q_tav(91-i,:))./2;

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% QG refractive index %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Constants needed: a, c, k, f/omega, H, R

a = 6371000; % radius of earth
c = 8.0; %phase speed guesstimate for now
k = 7;   %waveno to look at
omeg = 2.*pi./(24.*60.*60);  %rotation rate of earth
f = 2.*omeg.*sin(ylat(46:90).*pi./180);
H = 8000 ;   % Density scale height (taken from Isla's thesis)
R = 287.0 ; %gas const for dry air
g=9.81;

ylat_arr = zeros(45,25);
rC_arr = zeros(45,25);
f_arr = zeros(45,25);

for i=1:45
ylat_arr(i,:) = ylat(45+i).*pi./180;
f_arr(i,:) = f(i);
end
for i=1:25
rC_arr(:,i) = rC(i);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Next evaluate dq/dphi. Need du/dp, dtheta/dp

% 2*omega*cos(lat)
term1 = 2.*omeg.*cos(ylat_arr);

% d( d(ucos(lat)dlat)/acos(lat)) dlat
[b,top_q] = gradient(uE_q_hzav.*cos(ylat_arr),pi./90);
[b,top_h] = gradient(uE_h_hzav.*cos(ylat_arr),pi./90);
[b,top_w] = gradient(uE_w_hzav.*cos(ylat_arr),pi./90);
bottom = a.*cos(ylat_arr);

frac = top_q./bottom;
[b,term2_q] = gradient(frac,pi./90);
frac = top_h./bottom;
[b,term2_h] = gradient(frac,pi./90);
frac = top_w./bottom;
[b,term2_w] = gradient(frac,pi./90);


% af^2/R * d(ptheta/T * dudp/dthetadp)dp
dudp_q = gradient(uE_q_hzav,-4000);
dudp_h = gradient(uE_h_hzav,-4000);
dudp_w = gradient(uE_w_hzav,-4000);
dthetadp_q = gradient(theta_q_hzav,-4000);
dthetadp_h = gradient(theta_h_hzav,-4000);
dthetadp_w = gradient(theta_w_hzav,-4000);

prod_q = rC_arr.*theta_q_hzav./temp_q_hzav.*dudp_q./dthetadp_q;
prod_h = rC_arr.*theta_h_hzav./temp_h_hzav.*dudp_h./dthetadp_h;
prod_w = rC_arr.*theta_w_hzav./temp_w_hzav.*dudp_w./dthetadp_w;

diff_q = gradient(prod_q,-4000);
diff_h = gradient(prod_h,-4000);
diff_w = gradient(prod_w,-4000);

term3_q=  a.*f_arr.^2./R.*diff_q;
term3_h=  a.*f_arr.^2./R.*diff_h;
term3_w=  a.*f_arr.^2./R.*diff_w;

dqdphi_q = term1 - term2_q + term3_q;
dqdphi_h = term1 - term2_h + term3_h;
dqdphi_w = term1 - term2_w + term3_w;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Also evaluate N = sqrt (g/theta dtheta/dz)

Nsq_q = -(g.^2.*rC_arr)./(R.*temp_q_hzav.*theta_q_hzav) .* dthetadp_q;
N_q = sqrt(Nsq_q);
Nsq_h = -(g.^2.*rC_arr)./(R.*temp_h_hzav.*theta_h_hzav) .* dthetadp_h;
N_h = sqrt(Nsq_h);
Nsq_w = -(g.^2.*rC_arr)./(R.*temp_w_hzav.*theta_w_hzav) .* dthetadp_w;
N_w = sqrt(Nsq_w);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%qg ref index!

bit1_q = dqdphi_q./(a.*(uE_q_hzav-c));
bit2 = (k./(a.*cos(ylat_arr))).^2 ;
bit3_q = (f_arr./(2.*N_q.*H)).^2 ;

bit1_h = dqdphi_h./(a.*(uE_h_hzav-c));
bit3_h = (f_arr./(2.*N_h.*H)).^2 ;

bit1_w = dqdphi_w./(a.*(uE_w_hzav-c));
bit3_w = (f_arr./(2.*N_w.*H)).^2 ;

qgref_q = (bit1_q - bit2 - bit3_q).*a.^2;
qgref_h = (bit1_h - bit2 - bit3_h).*a.^2;
qgref_w = (bit1_w - bit2 - bit3_w).*a.^2;


save('eqm_w.mat', 'psi_w_hzav', 'uE_w_hzav', 'theta_w_hzav', 'htrt_w_hzav', 'uv_ed_w_hzav', 'vt_ed_w_hzav', 'Fphi_scaled_w_hzav', 'Fp_scaled_w_hzav', 'fluxdiv_w_hzav', 'eke_w_hzav', 'qgref_w')

save('eqm_th.mat', 'psi_q_hzav', 'uE_q_hzav', 'theta_q_hzav', 'htrt_q_hzav', 'uv_ed_q_hzav', 'vt_ed_q_hzav', 'Fphi_scaled_q_hzav', 'Fp_scaled_q_hzav', 'fluxdiv_q_hzav', 'eke_q_hzav', 'qgref_q')

save('eqm_c.mat', 'psi_h_hzav', 'uE_h_hzav', 'theta_h_hzav', 'htrt_h_hzav', 'uv_ed_h_hzav', 'vt_ed_h_hzav', 'Fphi_scaled_h_hzav', 'Fp_scaled_h_hzav', 'fluxdiv_h_hzav', 'eke_h_hzav', 'qgref_h')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 21.0;                  %# A4 paper size
X = 29.7;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 2*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 2*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.4;
xSize_sub = 1./2-0.1;

pos1x = 0.1 ; 	pos1y = 1/2+0.05;
pos2x = 0.55;	pos2y = 1/2+0.05;
pos3x = 0.1; 	pos3y = 0.05;
pos4x = 0.55; 	pos4y = 0.05;



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')




axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-25:5:0;
[C,h]=contour(ylat(46:90),rC./100.,uE_w_hzav',v,'k--');
clabel(C,h);
hold on
v=0:5:45;
[C,h]=contour(ylat(46:90),rC./100.,uE_w_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(a)'],'color','k','fontw','b')
hold off

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-25:5:0;
[C,h]=contour(ylat(46:90),rC./100.,uE_h_hzav',v,'k--');
clabel(C,h);
hold on
v=0:5:45;
[C,h]=contour(ylat(46:90),rC./100.,uE_h_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(b)'],'color','k','fontw','b')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-25:5:0;
[C,h]=contour(ylat(46:90),rC./100.,uE_q_hzav',v,'k--');
clabel(C,h);
hold on
v=0:5:45;
[C,h]=contour(ylat(46:90),rC./100.,uE_q_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(c)'],'color','k','fontw','b')
hold off

print('-dpdf','u.pdf')





hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v = -210:30:0;
[C,h]=contour(ylat(46:90),rC./100.,psi_w_hzav'./1e9,v,'k--');
clabel(C,h);
hold on
v=0:30:210;
[C,h]=contour(ylat(46:90),rC./100.,psi_w_hzav'./1e9,v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(c)'],'color','k','fontw','b')
hold off

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v = -210:30:0;
[C,h]=contour(ylat(46:90),rC./100.,psi_h_hzav'./1e9,v,'k--');
clabel(C,h);
hold on
v=0:30:210;
[C,h]=contour(ylat(46:90),rC./100.,psi_h_hzav'./1e9,v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(c)'],'color','k','fontw','b')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v = -210:30:0;
[C,h]=contour(ylat(46:90),rC./100.,psi_q_hzav'./1e9,v,'k--');
clabel(C,h);
hold on
v=0:30:210;
[C,h]=contour(ylat(46:90),rC./100.,psi_q_hzav'./1e9,v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(c)'],'color','k','fontw','b')
hold off


print('-dpdf','psi.pdf')




hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v = 200:30:750;
[C,h]=contour(ylat(46:90),rC./100.,theta_w_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')
hold off


axes('position',[pos2x pos2y xSize_sub ySize_sub])
v = 200:30:750;
[C,h]=contour(ylat(46:90),rC./100.,theta_h_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v = 200:30:750;
[C,h]=contour(ylat(46:90),rC./100.,theta_q_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')
hold off

print('-dpdf','theta.pdf')




hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


%%% test regridding
for i=1:23
for j=1:13
Fphi_scaled_w_hzav_red(i,j) = Fphi_scaled_w_hzav(i*2 -1, j*2 -1);
Fp_scaled_w_hzav_red(i,j) = Fp_scaled_w_hzav(i*2 -1, j*2 -1);
Fphi_scaled_h_hzav_red(i,j) = Fphi_scaled_h_hzav(i*2 -1, j*2 -1);
Fp_scaled_h_hzav_red(i,j) = Fp_scaled_h_hzav(i*2 -1, j*2 -1);
Fphi_scaled_q_hzav_red(i,j) = Fphi_scaled_q_hzav(i*2 -1, j*2 -1);
Fp_scaled_q_hzav_red(i,j) = Fp_scaled_q_hzav(i*2 -1, j*2 -1);
xspaces(i) = ylat(i*2+44 );
yspaces(j) = rC(j*2-1 );
end
end

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=0:0.5:5;
[C,h] = contour(ylat(46:90),rC./10^3,fluxdiv_w_hzav'./1e16,v,'k');
clabel(C,h);
hold on
v=-5:0.5:0;
[C,h] = contour(ylat(46:90),rC./10^3,fluxdiv_w_hzav'./1e16,v,'k--');
clabel(C,h);
labelling = num2str(shiftdim([100:100:1000],1));
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_scaled_w_hzav_red',1.6e-20.*Fp_scaled_w_hzav_red','k','AutoScale','off');
%quiver(ylat(46:90),rC./10^3,1e-14.*Fphi_scaled_w_hzav',1.6e-20.*Fp_scaled_w_hzav','k','AutoScale','off');
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
v=0:0.5:5;
[C,h] = contour(ylat(46:90),rC./10^3,fluxdiv_h_hzav'./1e16,v,'k');
clabel(C,h);
hold on
v=-5:0.5:0;
[C,h] = contour(ylat(46:90),rC./10^3,fluxdiv_h_hzav'./1e16,v,'k--');
clabel(C,h);
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_scaled_h_hzav_red',1.6e-20.*Fp_scaled_h_hzav_red','k','AutoScale','off');
%quiver(ylat(46:90),rC./10^3,1e-14.*Fphi_scaled_h_hzav',1.6e-20.*Fp_scaled_h_hzav','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
xlabel('Latitude')
set(gca, 'YTickLabel', []);
quiver(68, 21, 10, 0,'b');
text(68, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(68, 15, 0, -8,'b');
text(69, 12, '\fontsize{8}5E20 M3(PA)');
hold off


axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=0:0.5:5;
[C,h] = contour(ylat(46:90),rC./10^3,fluxdiv_q_hzav'./1e16,v,'k');
clabel(C,h);
hold on
v=-5:0.5:0;
[C,h] = contour(ylat(46:90),rC./10^3,fluxdiv_q_hzav'./1e16,v,'k--');
clabel(C,h);
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_scaled_q_hzav_red',1.6e-20.*Fp_scaled_q_hzav_red','k','AutoScale','off');
%quiver(ylat(46:90),rC./10^3,1e-14.*Fphi_scaled_q_hzav',1.6e-20.*Fp_scaled_q_hzav','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
xlabel('Latitude')
ylabel('Pressure, hPa')
set(gca,'YTickLabel',labelling)
quiver(68, 21, 10, 0,'b');
text(68, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(68, 15, 0, -8,'b');
text(69, 12, '\fontsize{8}5E20 M3(PA)');
hold off



print('-dpdf','ep_flux.pdf')




hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=0:20:300;
[C,h]=contour(ylat(46:90),rC./100.,eke_w_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
%text(-.15,-0.9,['(c)'],'color','k','fontw','b')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=0:20:300;
[C,h]=contour(ylat(46:90),rC./100.,eke_h_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
hold off
%text(-.15,-0.9,['(c)'],'color','k','fontw','b')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=0:20:300;
[C,h]=contour(ylat(46:90),rC./100.,eke_q_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
%text(-.15,-0.9,['(c)'],'color','k','fontw','b')

print('-dpdf','eke.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,htrt_w_hzav',v,'k--');
clabel(C,h);
hold on
v=0:1:6.5;
[C,h]=contour(ylat(46:90),rC./100.,htrt_w_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')


axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,htrt_h_hzav',v,'k--');
clabel(C,h);
hold on
v=0:1:6.5;
[C,h]=contour(ylat(46:90),rC./100.,htrt_h_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
hold off
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')


axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,htrt_q_hzav',v,'k--');
clabel(C,h);
hold on
v=0:1:6.5;
[C,h]=contour(ylat(46:90),rC./100.,htrt_q_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')

print('-dpdf','htrt.pdf')






hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=0:50:400;
[C,h] = contour(ylat(46:90),rC./10^3,qgref_w',v,'k');
clabel(C,h);
hold on
labelling = num2str(shiftdim([100:100:1000],1));
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_scaled_w_hzav_red',1.6e-20.*Fp_scaled_w_hzav_red','k','AutoScale','off');
%quiver(ylat(46:90),rC./10^3,1e-14.*Fphi_scaled_w_hzav',1.6e-20.*Fp_scaled_w_hzav','k','AutoScale','off');
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
v=0:50:400;
[C,h] = contour(ylat(46:90),rC./10^3,qgref_h',v,'k');
clabel(C,h);
hold on
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_scaled_h_hzav_red',1.6e-20.*Fp_scaled_h_hzav_red','k','AutoScale','off');
%quiver(ylat(46:90),rC./10^3,1e-14.*Fphi_scaled_h_hzav',1.6e-20.*Fp_scaled_h_hzav','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
xlabel('Latitude')
set(gca, 'YTickLabel', []);
quiver(68, 21, 10, 0,'b');
text(68, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(68, 15, 0, -8,'b');
text(69, 12, '\fontsize{8}5E20 M3(PA)');
hold off


axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=0:50:400;
[C,h] = contour(ylat(46:90),rC./10^3,qgref_q',v,'k');
clabel(C,h);
hold on
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_scaled_q_hzav_red',1.6e-20.*Fp_scaled_q_hzav_red','k','AutoScale','off');
%quiver(ylat(46:90),rC./10^3,1e-14.*Fphi_scaled_q_hzav',1.6e-20.*Fp_scaled_q_hzav','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
xlabel('Latitude')
ylabel('Pressure, hPa')
set(gca,'YTickLabel',labelling)
quiver(68, 21, 10, 0,'b');
text(68, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(68, 15, 0, -8,'b');
text(69, 12, '\fontsize{8}5E20 M3(PA)');
hold off



print('-dpdf','qgref.pdf')
