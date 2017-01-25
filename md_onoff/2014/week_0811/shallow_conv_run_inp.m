%load in diags from existing shallow conv run and look at stability, mass trans etc, get a feel for how conv impacts on this.

% need vu, vtheta, theta, v, u

rDir='/disk1/MITgcm/verification/atm_gray_ruth/run/';
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
for nit = 259200;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'SALT    '));
q_w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i) = dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_w(:,:,:,i) = dyn(:,:,:,J);
[uEt_w(:,:,:,i),vNt_w(:,:,:,i)] = rotate_uv2uvEN(ut_w(:,:,:,i),vt_w(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'AtPhdTcv'));
cvht_w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'AtPhdTcd'));
cdht_w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'AtPhdTdf'));
dfht_w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'AtPhdTrd'));
rdht_w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'AtPhTrLW'));
trlw_w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'AtPhTrSW'));
trsw_w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'AtPhTrWI'));
trwi_w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'Um_AdvZ3'));
ucsz_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvZ3'));
vcsz_w(:,:,:,i) = dyn(:,:,:,J);
[uEz_w(:,:,:,i),vNz_w(:,:,:,i)] = rotate_uv2uvEN(ucsz_w(:,:,:,i),vcsz_w(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'Um_AdvRe'));
ucsr_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvRe'));
vcsr_w(:,:,:,i) = dyn(:,:,:,J);
[uEr_w(:,:,:,i),vNr_w(:,:,:,i)] = rotate_uv2uvEN(ucsr_w(:,:,:,i),vcsr_w(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'Um_Advec'));
ucsadv_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_Advec'));
vcsadv_w(:,:,:,i) = dyn(:,:,:,J);
[uEadv_w(:,:,:,i),vNadv_w(:,:,:,i)] = rotate_uv2uvEN(ucsadv_w(:,:,:,i),vcsadv_w(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'AtPhdUdt'));
ducsdt_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdVdt'));
dvcsdt_w(:,:,:,i) = dyn(:,:,:,J);
[duEdt_w(:,:,:,i),dvNdt_w(:,:,:,i)] = rotate_uv2uvEN(ducsdt_w(:,:,:,i),dvcsdt_w(:,:,:,i),AngleCS,AngleSN,Grid);


end

uE_w_mean = mean(uE_w,4);
vN_w_mean = mean(vN_w,4);
uv_w_mean = mean(uv_w,4);
vNt_w_mean = mean(vNt_w,4);
theta_w_mean = mean(theta_w,4);
htrt_w_mean = mean(htrt_w,4);
dfht_w_mean = mean(dfht_w,4);
rdht_w_mean = mean(rdht_w,4);
cvht_w_mean = mean(cvht_w,4);
cdht_w_mean = mean(cdht_w,4);
uEz_w_mean = mean(uEz_w,4);
uEr_w_mean = mean(uEr_w,4);
uEadv_w_mean = mean(uEadv_w,4);
duEdt_w_mean = mean(duEdt_w,4);

xi=-179:2:180;yi=-89:2:90;
uEll_w=cube2latlon(xc,yc,uE_w_mean,xi,yi);
vNll_w=cube2latlon(xc,yc,vN_w_mean,xi,yi);
uvll_w=cube2latlon(xc,yc,uv_w_mean,xi,yi);
vNtll_w=cube2latlon(xc,yc,vNt_w_mean,xi,yi);
thetall_w=cube2latlon(xc,yc,theta_w_mean,xi,yi);
htrtll_w=cube2latlon(xc,yc,htrt_w_mean,xi,yi);
dfhtll_w=cube2latlon(xc,yc,dfht_w_mean,xi,yi);
rdhtll_w=cube2latlon(xc,yc,rdht_w_mean,xi,yi);
cvhtll_w=cube2latlon(xc,yc,cvht_w_mean,xi,yi);
cdhtll_w=cube2latlon(xc,yc,cdht_w_mean,xi,yi);
uEzll_w=cube2latlon(xc,yc,uEz_w_mean,xi,yi);
uErll_w=cube2latlon(xc,yc,uEr_w_mean,xi,yi);
uEadvll_w=cube2latlon(xc,yc,uEadv_w_mean,xi,yi);
duEdtll_w=cube2latlon(xc,yc,duEdt_w_mean,xi,yi);
trlwll_w=cube2latlon(xc,yc,trlw_w,xi,yi);
trswll_w=cube2latlon(xc,yc,trsw_w,xi,yi);
trwill_w=cube2latlon(xc,yc,trwi_w,xi,yi);

uE_w_zav(:,:) = mean(uEll_w,1);
vN_w_zav(:,:) = mean(vNll_w,1);
uv_w_zav(:,:) = mean(uvll_w,1);
vNt_w_zav(:,:) = mean(vNtll_w,1);
theta_w_zav(:,:) = mean(thetall_w,1);
cdht_w_zav(:,:) = mean(cdhtll_w,1);
cvht_w_zav(:,:) = mean(cvhtll_w,1);
rdht_w_zav(:,:) = mean(rdhtll_w,1);
dfht_w_zav(:,:) = mean(dfhtll_w,1);
uEz_w_zav(:,:) = mean(uEzll_w,1);
uEr_w_zav(:,:) = mean(uErll_w,1);
uEadv_w_zav(:,:) = mean(uEadvll_w,1);
duEdt_w_zav(:,:) = mean(duEdtll_w,1);
trlw_w_zav(:,:) = mean(trlwll_w,1);
trwi_w_zav(:,:) = mean(trwill_w,1);
trsw_w_zav(:,:) = mean(trswll_w,1);

uv_w_ed_zav = uv_w_zav - uE_w_zav.*vN_w_zav;
vNt_w_ed_zav = vNt_w_zav - theta_w_zav.*vN_w_zav;

%%%%%%%%%%%%%%%%%%%%%%% EP fluxes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dthetadp_w = gradient(theta_w_zav,-4000.);

cosphi = zeros(90,25);
f = zeros(90,25);
omega = 2*pi/(24*60*60);
g=9.81;
a=6371.0e3;

for i=1:25
cosphi(:,i) = cos(yi.*pi./180);
f(:,i) = 2*omega*sin(yi.*pi./180);
end

prefactor = cosphi.*2.*pi.*a.^2./g;

%Calculate fluxes and scaled fluxes (Edmon 1980)

Fphi_w = -1.*a.*cosphi.*uv_w_ed_zav;
Fp_w   = a.*f.*cosphi.*vNt_w_ed_zav./dthetadp_w;

Fphi_scaled_w = Fphi_w.*prefactor./a;
Fp_scaled_w = Fp_w.*prefactor;

[fluxdiv_p_w ,fdp_y] = gradient(Fp_scaled_w,-4000);
[fdphi_x,fluxdiv_phi_w] = gradient(Fphi_scaled_w,pi./90.);
fluxdiv_w = fluxdiv_p_w + fluxdiv_phi_w;



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


for i=1:45
psi_w_hzav(46-i,:) = (-1*psi_w(i,:) + psi_w(91-i,:))./2;
uE_w_hzav(46-i,:) = (uE_w_zav(i,:) + uE_w_zav(91-i,:))./2;
theta_w_hzav(46-i,:) = (theta_w_zav(i,:) + theta_w_zav(91-i,:))./2;
Fphi_scaled_w_hzav(46-i,:) = (-1*Fphi_scaled_w(i,:) + Fphi_scaled_w(91-i,:))./2;
Fp_scaled_w_hzav(46-i,:) = (Fp_scaled_w(i,:) + Fp_scaled_w(91-i,:))./2;
end

figure
v=250:5:650;
[C,h] = contour(yi(46:90),rC./100,theta_w_hzav',v,'k');
vec=250:10:650;
clabel(C,h,vec);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title('1xwv, free rad, shallow conv')
print('-dpng','theta_sho.png')

figure
v=-25:5:45;
[C,h]=contourf(yi(46:90),rC./100.,uE_w_hzav',v);
hold on
colorbar
colormap(b2r(-25,45));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title('1xwv, free rad, shallow conv')
v = -220:10:0;
[C,h]=contour(yi(46:90),rC./100.,psi_w_hzav'./1e9,v,'k--');
clabel(C,h);
hold on
v=0:30:210;
[C,h]=contour(yi(46:90),rC./100.,psi_w_hzav'./1e9,v,'k');
clabel(C,h);
hold off
print('-dpng','upsi_sho.png')


%%% test regridding
for i=1:23
for j=1:13
Fphi_scaled_w_red(i,j) = Fphi_scaled_w_hzav(i*2 -1, j*2 -1);
Fp_scaled_w_red(i,j) = Fp_scaled_w_hzav(i*2 -1, j*2 -1);
xspaces(i) = yi(i*2+44 );
yspaces(j) = rC(j*2-1 );
end
end

figure
%v=0:0.5:5;
%[C,h] = contour(yi(46:90),rC./10^3,fluxdiv_w'./1e16,v,'k');
%clabel(C,h);
%hold on
%v=-5:0.5:0;
%[C,h] = contour(yi(46:90),rC./10^3,fluxdiv_w'./1e16,v,'k--');
%clabel(C,h);
labelling = num2str(shiftdim([100:100:1000],1));
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_scaled_w_red',1.6e-20.*Fp_scaled_w_red','k','AutoScale','off');
hold on
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
quiver(68, 21, 10, 0,'b');
text(68, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(68, 15, 0, -8,'b');
text(69, 12, '\fontsize{8}5E20 M3(PA)');
hold off
print('-dpng','ep_flux_sho.png')
