%calculate different Hadley Cell width approximations

% need v (to get cell width and height) and t, lwn, lwd to get radeq t profile


% choose directory, load grid
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
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

%read files
i=0;
for nit = 259200:86400:432000;
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhLWD '));
lwd_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWN '));
lwn_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i) = dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearh/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhLWD '));
lwd_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWN '));
lwn_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_h(:,:,:,i) = dyn(:,:,:,J);
[uE_h(:,:,:,i),vN_h(:,:,:,i)] = rotate_uv2uvEN(ucs_h(:,:,:,i),vcs_h(:,:,:,i),AngleCS,AngleSN,Grid);


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearq/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhLWD '));
lwd_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWN '));
lwn_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_q(:,:,:,i) = dyn(:,:,:,J);
[uE_q(:,:,:,i),vN_q(:,:,:,i)] = rotate_uv2uvEN(ucs_q(:,:,:,i),vcs_q(:,:,:,i),AngleCS,AngleSN,Grid);


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yeard/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhLWD '));
lwd_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWN '));
lwn_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_d(:,:,:,i) = dyn(:,:,:,J);
[uE_d(:,:,:,i),vN_d(:,:,:,i)] = rotate_uv2uvEN(ucs_d(:,:,:,i),vcs_d(:,:,:,i),AngleCS,AngleSN,Grid);

end

%take time means
lwn_w_mean = mean(lwn_w,4);
lwd_w_mean = mean(lwd_w,4);
theta_w_mean = mean(theta_w,4);
q_w_mean = mean(q_w,4);
lwn_h_mean = mean(lwn_h,4);
lwd_h_mean = mean(lwd_h,4);
theta_h_mean = mean(theta_h,4);
q_h_mean = mean(q_h,4);
lwn_q_mean = mean(lwn_q,4);
lwd_q_mean = mean(lwd_q,4);
theta_q_mean = mean(theta_q,4);
q_q_mean = mean(q_q,4);
lwn_d_mean = mean(lwn_d,4);
lwd_d_mean = mean(lwd_d,4);
theta_d_mean = mean(theta_d,4);
q_d_mean = mean(q_d,4);

uE_w_mean = mean(uE_w,4);
vN_w_mean = mean(vN_w,4);
uE_h_mean = mean(uE_h,4);
vN_h_mean = mean(vN_h,4);
uE_q_mean = mean(uE_q,4);
vN_q_mean = mean(vN_q,4);
uE_d_mean = mean(uE_d,4);
vN_d_mean = mean(vN_d,4);

xi=-179:2:180;yi=-89:2:90;
lwnll_w=cube2latlon(xc,yc,lwn_w_mean,xi,yi);
lwdll_w=cube2latlon(xc,yc,lwd_w_mean,xi,yi);
thetall_w=cube2latlon(xc,yc,theta_w_mean,xi,yi);
qll_w=cube2latlon(xc,yc,q_w_mean,xi,yi);
lwnll_h=cube2latlon(xc,yc,lwn_h_mean,xi,yi);
lwdll_h=cube2latlon(xc,yc,lwd_h_mean,xi,yi);
thetall_h=cube2latlon(xc,yc,theta_h_mean,xi,yi);
qll_h=cube2latlon(xc,yc,q_h_mean,xi,yi);
lwnll_q=cube2latlon(xc,yc,lwn_q_mean,xi,yi);
lwdll_q=cube2latlon(xc,yc,lwd_q_mean,xi,yi);
thetall_q=cube2latlon(xc,yc,theta_q_mean,xi,yi);
qll_q=cube2latlon(xc,yc,q_q_mean,xi,yi);
lwnll_d=cube2latlon(xc,yc,lwn_d_mean,xi,yi);
lwdll_d=cube2latlon(xc,yc,lwd_d_mean,xi,yi);
thetall_d=cube2latlon(xc,yc,theta_d_mean,xi,yi);
qll_d=cube2latlon(xc,yc,q_d_mean,xi,yi);

uEll_w=cube2latlon(xc,yc,uE_w_mean,xi,yi);
vNll_w=cube2latlon(xc,yc,vN_w_mean,xi,yi);
uEll_h=cube2latlon(xc,yc,uE_h_mean,xi,yi);
vNll_h=cube2latlon(xc,yc,vN_h_mean,xi,yi);
uEll_q=cube2latlon(xc,yc,uE_q_mean,xi,yi);
vNll_q=cube2latlon(xc,yc,vN_q_mean,xi,yi);
uEll_d=cube2latlon(xc,yc,uE_d_mean,xi,yi);
vNll_d=cube2latlon(xc,yc,vN_d_mean,xi,yi);

lwn_w_zav(:,:) = mean(lwnll_w,1);
lwd_w_zav(:,:) = mean(lwdll_w,1);
theta_w_zav(:,:) = mean(thetall_w,1);
q_w_zav(:,:) = mean(qll_w,1);
lwn_h_zav(:,:) = mean(lwnll_h,1);
lwd_h_zav(:,:) = mean(lwdll_h,1);
theta_h_zav(:,:) = mean(thetall_h,1);
q_h_zav(:,:) = mean(qll_h,1);
lwn_q_zav(:,:) = mean(lwnll_q,1);
lwd_q_zav(:,:) = mean(lwdll_q,1);
theta_q_zav(:,:) = mean(thetall_q,1);
q_q_zav(:,:) = mean(qll_q,1);
lwn_d_zav(:,:) = mean(lwnll_d,1);
lwd_d_zav(:,:) = mean(lwdll_d,1);
theta_d_zav(:,:) = mean(thetall_d,1);
q_d_zav(:,:) = mean(qll_d,1);

uE_w_zav(:,:) = mean(uEll_w,1);
vN_w_zav(:,:) = mean(vNll_w,1);
uE_h_zav(:,:) = mean(uEll_h,1);
vN_h_zav(:,:) = mean(vNll_h,1);
uE_q_zav(:,:) = mean(uEll_q,1);
vN_q_zav(:,:) = mean(vNll_q,1);
uE_d_zav(:,:) = mean(uEll_d,1);
vN_d_zav(:,:) = mean(vNll_d,1);

%Calculate radiative equilibrium temperature

lwu_w_zav = lwn_w_zav + lwd_w_zav;
lwu_h_zav = lwn_h_zav + lwd_h_zav;
lwu_q_zav = lwn_q_zav + lwd_q_zav;
lwu_d_zav = lwn_d_zav + lwd_d_zav;

b_eq_w = (lwu_w_zav + lwd_w_zav)./2;
b_eq_h = (lwu_h_zav + lwd_h_zav)./2;
b_eq_q = (lwu_q_zav + lwd_q_zav)./2;
b_eq_d = (lwu_d_zav + lwd_d_zav)./2;

stefan = 5.67e-8;

t_eq_w = (b_eq_w./stefan).^(1/4);
t_eq_h = (b_eq_h./stefan).^(1/4);
t_eq_q = (b_eq_q./stefan).^(1/4);
t_eq_d = (b_eq_d./stefan).^(1/4);

%convert theta profile to a temperature profile, and radiative equilibrium temperature to a theta profile

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
T_w_zav(:,k)=theta_w_zav(:,k).*convthetatoT(k,1);
T_h_zav(:,k)=theta_h_zav(:,k).*convthetatoT(k,1);
T_q_zav(:,k)=theta_q_zav(:,k).*convthetatoT(k,1);
T_d_zav(:,k)=theta_d_zav(:,k).*convthetatoT(k,1);

theta_eq_w(:,k) = t_eq_w(:,k)./convthetatoT(k,1);
theta_eq_h(:,k) = t_eq_h(:,k)./convthetatoT(k,1);
theta_eq_q(:,k) = t_eq_q(:,k)./convthetatoT(k,1);
theta_eq_d(:,k) = t_eq_d(:,k)./convthetatoT(k,1);

end

%calculate equivalent potential temperature too
L  = 2.500e6;
cp = 1004.64;
rd = 287;
g=9.81;

teq_w_zav = T_w_zav + L./cp .* q_w_zav;
teq_h_zav = T_h_zav + L./cp .* q_h_zav;
teq_q_zav = T_q_zav + L./cp .* q_q_zav;
teq_d_zav = T_d_zav + L./cp .* q_d_zav;

for j=1:size(rC)
thetaeq_w_zav(:,j)=teq_w_zav(:,j)./convthetatoT(j,1);
thetaeq_h_zav(:,j)=teq_h_zav(:,j)./convthetatoT(j,1);
thetaeq_q_zav(:,j)=teq_q_zav(:,j)./convthetatoT(j,1);
thetaeq_d_zav(:,j)=teq_d_zav(:,j)./convthetatoT(j,1);
end



%deltheta_eq_w = theta_eq_w(45,:) - theta_eq_w(89,:);
%deltheta_eq_h = theta_eq_h(45,:) - theta_eq_h(89,:);
%deltheta_eq_q = theta_eq_q(45,:) - theta_eq_q(89,:);
%deltheta_eq_d = theta_eq_d(45,:) - theta_eq_d(89,:);

%Held Hou estimate needs the vertically averaged equator to pole radiative equilibrium potential temperature difference: estimate it!

theta_eq_w_vav = mean(theta_eq_w,2);
theta_eq_h_vav = mean(theta_eq_h,2);
theta_eq_q_vav = mean(theta_eq_q,2);
theta_eq_d_vav = mean(theta_eq_d,2);

deltheta_eq(1) = theta_eq_w_vav(45) - theta_eq_w_vav(89);
deltheta_eq(2) = theta_eq_h_vav(45) - theta_eq_h_vav(89);
deltheta_eq(3) = theta_eq_q_vav(45) - theta_eq_q_vav(89);
deltheta_eq(4) = theta_eq_d_vav(45) - theta_eq_d_vav(89);


%Calculate psi to get cell extent to compare all this with!

%%%%%%%%%%%%%%%%%%%%%%%%%% Wet psi  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Define constants
g=9.80;					%gravity
rad=6371.0e3;				%radius of earth
deltap = 4000;

integrand = zeros(size(vN_w_zav));
cosphi = zeros(90,25);
for k=1:25
cosphi(:,k) = cos(yi.*pi./180);
end
integrand = 2.*pi.*rad.*vN_w_zav.*cosphi./g;
psi_w = flipdim(cumsum(flipdim(integrand,2).*deltap,2),2);


%%%%%%%%%%%%%%%%%%%%%%%%%% Half WV psi  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

integrand = zeros(size(vN_h_zav));
cosphi = zeros(90,25);
for k=1:25
cosphi(:,k) = cos(yi.*pi./180);
end
integrand = 2.*pi.*rad.*vN_h_zav.*cosphi./g;
psi_h = flipdim(cumsum(flipdim(integrand,2).*deltap,2),2);

%%%%%%%%%%%%%%%%%%%%%%%%%% Quarter WV psi  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

integrand = zeros(size(vN_q_zav));
cosphi = zeros(90,25);
for k=1:25
cosphi(:,k) = cos(yi.*pi./180);
end
integrand = 2.*pi.*rad.*vN_q_zav.*cosphi./g;
psi_q = flipdim(cumsum(flipdim(integrand,2).*deltap,2),2);

%%%%%%%%%%%%%%%%%%%%%%%%%% Dry psi  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

integrand = zeros(size(vN_d_zav));
cosphi = zeros(90,25);
for k=1:25
cosphi(:,k) = cos(yi.*pi./180);
end
integrand = 2.*pi.*rad.*vN_d_zav.*cosphi./g;
psi_d = flipdim(cumsum(flipdim(integrand,2).*deltap,2),2);



for i=1:45
psi_w_hzav(46-i,:) = (-1*psi_w(i,:) + psi_w(91-i,:))./2;
psi_h_hzav(46-i,:) = (-1*psi_h(i,:) + psi_h(91-i,:))./2;
psi_q_hzav(46-i,:) = (-1*psi_q(i,:) + psi_q(91-i,:))./2;
psi_d_hzav(46-i,:) = (-1*psi_d(i,:) + psi_d(91-i,:))./2;
end

%define the Hadley cell width as the latitude where psi becomes negative at 500hPa

psi_width(1) = yi(45 + min(find(psi_w_hzav(:,13)<=0)));
psi_width(2) = yi(45 + min(find(psi_h_hzav(:,13)<=0)));
psi_width(3) = yi(45 + min(find(psi_q_hzav(:,13)<=0)));
psi_width(4) = yi(45 + min(find(psi_d_hzav(:,13)<=0)));

%we also need some height profiles to get our estimates, integrate the hydrostatic equation

dlnTdp_w = gradient(log(T_w_zav),-4000);
dlnTdp_h = gradient(log(T_h_zav),-4000);
dlnTdp_q = gradient(log(T_q_zav),-4000);
dlnTdp_d = gradient(log(T_d_zav),-4000);

g=9.81;
cp=1005;
L=2.5e6;
Ra=287.04;
Rv=461.50;
epsilon = Ra/Rv;
T0 = 273.16;
omega = 2.*pi./24./60./60;

for k=1:25
integrand_w(:,k) = Ra.*T_w_zav(:,k)./g./rC(k);
integrand_h(:,k) = Ra.*T_h_zav(:,k)./g./rC(k);
integrand_q(:,k) = Ra.*T_q_zav(:,k)./g./rC(k);
integrand_d(:,k) = Ra.*T_d_zav(:,k)./g./rC(k);
end

height_w = cumsum(integrand_w,2).*4000;
height_h = cumsum(integrand_h,2).*4000;
height_q = cumsum(integrand_q,2).*4000;
height_d = cumsum(integrand_d,2).*4000;

%define the tropopause as where dTdz hits 2K/km
prefac = zeros(90,25);
for k=1:25
prefac(:,k) = rC(k).*g./Ra;
end

dTdz_w = -prefac.*dlnTdp_w.*1000;
dTdz_h = -prefac.*dlnTdp_h.*1000;
dTdz_q = -prefac.*dlnTdp_q.*1000;
dTdz_d = -prefac.*dlnTdp_d.*1000;

%use our tropopause definition to get the tropopause pressure, height, and the dry bulk stability.

for i=2:89
trop_w(i) = rC(min(find((dTdz_w(i,:) >= -2))));
trop_h(i) = rC(min(find((dTdz_h(i,:) >= -2))));
trop_q(i) = rC(min(find((dTdz_q(i,:) >= -2))));
trop_d(i) = rC(min(find((dTdz_d(i,:) >= -2))));

trop_height_w(i) = height_w(i,(min(find((dTdz_w(i,:) >= -2)))));
trop_height_h(i) = height_h(i,(min(find((dTdz_h(i,:) >= -2)))));
trop_height_q(i) = height_q(i,(min(find((dTdz_q(i,:) >= -2)))));
trop_height_d(i) = height_d(i,(min(find((dTdz_d(i,:) >= -2)))));

bulk_stab_w(i) = theta_w_zav(i,min(find((dTdz_w(i,:) >= -2)))) - theta_w_zav(i,1);
bulk_stab_h(i) = theta_h_zav(i,min(find((dTdz_h(i,:) >= -2)))) - theta_h_zav(i,1);
bulk_stab_q(i) = theta_q_zav(i,min(find((dTdz_q(i,:) >= -2)))) - theta_q_zav(i,1);
bulk_stab_d(i) = theta_d_zav(i,min(find((dTdz_d(i,:) >= -2)))) - theta_d_zav(i,1);

end

%pick a reference temperature

T0_w = mean(theta_eq_w_vav(2:89));
T0_h = mean(theta_eq_h_vav(2:89));
T0_q = mean(theta_eq_q_vav(2:89));
T0_d = mean(theta_eq_d_vav(2:89));

T0_w_max = max(theta_eq_w_vav(2:89));
T0_h_max = max(theta_eq_h_vav(2:89));
T0_q_max = max(theta_eq_q_vav(2:89));
T0_d_max = max(theta_eq_d_vav(2:89));

T0_w_min = min(theta_eq_w_vav(2:89));
T0_h_min = min(theta_eq_h_vav(2:89));
T0_q_min = min(theta_eq_q_vav(2:89));
T0_d_min = min(theta_eq_d_vav(2:89));

T0 = 295;

consts = 5./3 .* g ./ (omega.*rad).^2;

%evaluate held hou width

phi_hh(1) = sqrt(consts .* trop_height_w(45) .* deltheta_eq(1) ./ T0_w).*180./pi;
phi_hh(2) = sqrt(consts .* trop_height_h(45) .* deltheta_eq(2) ./ T0_h).*180./pi;
phi_hh(3) = sqrt(consts .* trop_height_q(45) .* deltheta_eq(3) ./ T0_q).*180./pi;
phi_hh(4) = sqrt(consts .* trop_height_d(45) .* deltheta_eq(4) ./ T0_d).*180./pi;

phi_hh_gen(1) = sqrt(consts .* trop_height_w(45) .* deltheta_eq(1) ./ T0).*180./pi;
phi_hh_gen(2) = sqrt(consts .* trop_height_h(45) .* deltheta_eq(2) ./ T0).*180./pi;
phi_hh_gen(3) = sqrt(consts .* trop_height_q(45) .* deltheta_eq(3) ./ T0).*180./pi;
phi_hh_gen(4) = sqrt(consts .* trop_height_d(45) .* deltheta_eq(4) ./ T0).*180./pi;

phi_hh_max(1) = sqrt(consts .* trop_height_w(45) .* deltheta_eq(1) ./ T0_w_max).*180./pi;
phi_hh_max(2) = sqrt(consts .* trop_height_h(45) .* deltheta_eq(2) ./ T0_h_max).*180./pi;
phi_hh_max(3) = sqrt(consts .* trop_height_q(45) .* deltheta_eq(3) ./ T0_q_max).*180./pi;
phi_hh_max(4) = sqrt(consts .* trop_height_d(45) .* deltheta_eq(4) ./ T0_d_max).*180./pi;

phi_hh_min (1) = sqrt(consts .* trop_height_w(45) .* deltheta_eq(1) ./ T0_w_min ).*180./pi;
phi_hh_min (2) = sqrt(consts .* trop_height_h(45) .* deltheta_eq(2) ./ T0_h_min ).*180./pi;
phi_hh_min (3) = sqrt(consts .* trop_height_q(45) .* deltheta_eq(3) ./ T0_q_min ).*180./pi;
phi_hh_min (4) = sqrt(consts .* trop_height_d(45) .* deltheta_eq(4) ./ T0_d_min ).*180./pi;

%take average of bulk stability and tropopause height over 20-40 degrees (subtropics), cf Frierson 07b

cosphi = cos(yi.*pi./180);

for i=1:89

bulk_stab_w_weighted(i) = bulk_stab_w(i).*cosphi(i);
bulk_stab_h_weighted(i) = bulk_stab_h(i).*cosphi(i);
bulk_stab_q_weighted(i) = bulk_stab_q(i).*cosphi(i);
bulk_stab_d_weighted(i) = bulk_stab_d(i).*cosphi(i);

trop_height_w_weighted(i) = trop_height_w(i).*cosphi(i);
trop_height_h_weighted(i) = trop_height_h(i).*cosphi(i);
trop_height_q_weighted(i) = trop_height_q(i).*cosphi(i);
trop_height_d_weighted(i) = trop_height_d(i).*cosphi(i);

end

%20 degrees = 55 40 = 65

bulk_stab_w_av = sum(bulk_stab_w_weighted(55:65))./sum(cosphi(55:65));
bulk_stab_h_av = sum(bulk_stab_h_weighted(55:65))./sum(cosphi(55:65));
bulk_stab_d_av = sum(bulk_stab_q_weighted(55:65))./sum(cosphi(55:65));
bulk_stab_q_av = sum(bulk_stab_d_weighted(55:65))./sum(cosphi(55:65));

trop_height_w_av = sum(trop_height_w_weighted(55:65))./sum(cosphi(55:65));
trop_height_h_av = sum(trop_height_h_weighted(55:65))./sum(cosphi(55:65));
trop_height_q_av = sum(trop_height_q_weighted(55:65))./sum(cosphi(55:65));
trop_height_d_av = sum(trop_height_d_weighted(55:65))./sum(cosphi(55:65));


%evaluate frierson 07b width
phi_h(1) = (bulk_stab_w_av .* trop_height_w_av).^(0.25);
phi_h(2) = (bulk_stab_h_av .* trop_height_h_av).^(0.25);
phi_h(3) = (bulk_stab_q_av .* trop_height_q_av).^(0.25);
phi_h(4) = (bulk_stab_d_av .* trop_height_d_av).^(0.25);

%check what happens if we just use tropical values (not v sensible!)
phi_h_alt(1) = (bulk_stab_w(45) .* trop_height_w(45)).^(0.25);
phi_h_alt(2) = (bulk_stab_h(45) .* trop_height_h(45)).^(0.25);
phi_h_alt(3) = (bulk_stab_q(45) .* trop_height_q(45)).^(0.25);
phi_h_alt(4) = (bulk_stab_d(45) .* trop_height_d(45)).^(0.25);


%now lets try Schneiders way! Need near surface theta gradients (dp and dy), f, beta

f = 2.*omega.*sin(yi.*pi./180);
beta = 2.*omega.*cos(yi.*pi./180)./rad;

%for i=1:25

%theta_w_zav_weighted(:,i) = theta_w_zav(:,i).*cosphi';
%theta_h_zav_weighted(:,i) = theta_h_zav(:,i).*cosphi';
%theta_q_zav_weighted(:,i) = theta_q_zav(:,i).*cosphi';
%theta_d_zav_weighted(:,i) = theta_d_zav(:,i).*cosphi';

%end

%[moo, dthetady_s_w] = gradient(theta_w_zav_weighted,pi./90);
%[moo, dthetady_s_h] = gradient(theta_h_zav_weighted,pi./90);
%[moo, dthetady_s_q] = gradient(theta_q_zav_weighted,pi./90);
%[moo, dthetady_s_d] = gradient(theta_d_zav_weighted,pi./90);

%for i=1:25
%dthetady_w(:,i) = dthetady_s_w(:,i)./cosphi';
%dthetady_h(:,i) = dthetady_s_h(:,i)./cosphi';
%dthetady_q(:,i) = dthetady_s_q(:,i)./cosphi';
%dthetady_d(:,i) = dthetady_s_d(:,i)./cosphi';
%end

[moo, dthetady_w] = gradient(theta_w_zav,pi./90);
[moo, dthetady_h] = gradient(theta_h_zav,pi./90);
[moo, dthetady_q] = gradient(theta_q_zav,pi./90);
[moo, dthetady_d] = gradient(theta_d_zav,pi./90);

[moo, dthetaeqdy_w] = gradient(thetaeq_w_zav,pi./90);
[moo, dthetaeqdy_h] = gradient(thetaeq_h_zav,pi./90);
[moo, dthetaeqdy_q] = gradient(thetaeq_q_zav,pi./90);
[moo, dthetaeqdy_d] = gradient(thetaeq_d_zav,pi./90);

dthetady_w = dthetady_w./rad;
dthetady_h = dthetady_h./rad;
dthetady_q = dthetady_q./rad;
dthetady_d = dthetady_d./rad;

dthetaeqdy_w = dthetaeqdy_w./rad;
dthetaeqdy_h = dthetaeqdy_h./rad;
dthetaeqdy_q = dthetaeqdy_q./rad;
dthetaeqdy_d = dthetaeqdy_d./rad;

[dthetadp_w,moo] = gradient(theta_w_zav,-4000);
[dthetadp_h,moo] = gradient(theta_h_zav,-4000);
[dthetadp_q,moo] = gradient(theta_q_zav,-4000);
[dthetadp_d,moo] = gradient(theta_d_zav,-4000);

[dthetaeqdp_w,moo] = gradient(thetaeq_w_zav,-4000);
[dthetaeqdp_h,moo] = gradient(thetaeq_h_zav,-4000);
[dthetaeqdp_q,moo] = gradient(thetaeq_q_zav,-4000);
[dthetaeqdp_d,moo] = gradient(thetaeq_d_zav,-4000);



for i=1:25

delta_v_w(:,i) = -2.* dthetadp_w(1:89,i).*(98000 - trop_w)';
delta_v_h(:,i) = -2.* dthetadp_h(1:89,i).*(98000 - trop_h)';
delta_v_q(:,i) = -2.* dthetadp_q(1:89,i).*(98000 - trop_q)';
delta_v_d(:,i) = -2.* dthetadp_d(1:89,i).*(98000 - trop_d)';

Sc_w(:,i) = -f(1:89)'./ beta(1:89)' .*dthetady_w(1:89,i) ./ delta_v_w(1:89,i);
Sc_h(:,i) = -f(1:89)'./ beta(1:89)' .*dthetady_h(1:89,i) ./ delta_v_h(1:89,i);
Sc_q(:,i) = -f(1:89)'./ beta(1:89)' .*dthetady_q(1:89,i) ./ delta_v_q(1:89,i);
Sc_d(:,i) = -f(1:89)'./ beta(1:89)' .*dthetady_d(1:89,i) ./ delta_v_d(1:89,i);

deltaeq_v_w(:,i) = -2.* dthetaeqdp_w(1:89,i).*(98000 - trop_w)';
deltaeq_v_h(:,i) = -2.* dthetaeqdp_q(1:89,i).*(98000 - trop_h)';
deltaeq_v_q(:,i) = -2.* dthetaeqdp_h(1:89,i).*(98000 - trop_q)';
deltaeq_v_d(:,i) = -2.* dthetaeqdp_d(1:89,i).*(98000 - trop_d)';

Sc_w_eq(:,i) = -f(1:89)'./ beta(1:89)' .*dthetaeqdy_w(1:89,i) ./ deltaeq_v_w(1:89,i);
Sc_h_eq(:,i) = -f(1:89)'./ beta(1:89)' .*dthetaeqdy_h(1:89,i) ./ deltaeq_v_h(1:89,i);
Sc_q_eq(:,i) = -f(1:89)'./ beta(1:89)' .*dthetaeqdy_q(1:89,i) ./ deltaeq_v_q(1:89,i);
Sc_d_eq(:,i) = -f(1:89)'./ beta(1:89)' .*dthetaeqdy_d(1:89,i) ./ deltaeq_v_d(1:89,i);
end


for i=1:44;
Sc_w_hzav(i,:) = (Sc_w(45+i,:) + Sc_w(46-i,:))./2;
Sc_h_hzav(i,:) = (Sc_h(45+i,:) + Sc_h(46-i,:))./2;
Sc_q_hzav(i,:) = (Sc_q(45+i,:) + Sc_q(46-i,:))./2;
Sc_d_hzav(i,:) = (Sc_d(45+i,:) + Sc_d(46-i,:))./2;
end

%phi_s(1) = yi(45 + min(find(Sc_w_hzav(:,1)>=1)));
phi_s(2) = yi(45 + min(find(Sc_h_hzav(:,1)>=1)));
phi_s(3) = yi(45 + min(find(Sc_q_hzav(:,1)>=1)));
phi_s(4) = yi(45 + min(find(Sc_d_hzav(:,1)>=1)));

