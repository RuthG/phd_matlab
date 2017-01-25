%final tidy clean EP flux plots for report

% need vu, vtheta, theta, v, u


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

%read fields
i=0;
for nit = 259200:86400:432000;
i=i+1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Wet Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Half WV Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearh/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_h(:,:,:,i) = dyn(:,:,:,J);
[uE_h(:,:,:,i),vN_h(:,:,:,i)] = rotate_uv2uvEN(ucs_h(:,:,:,i),vcs_h(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_h(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_h(:,:,:,i) = dyn(:,:,:,J);
[uEt_h(:,:,:,i),vNt_h(:,:,:,i)] = rotate_uv2uvEN(ut_h(:,:,:,i),vt_h(:,:,:,i),AngleCS,AngleSN,Grid);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Quarter WV Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearq/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_q(:,:,:,i) = dyn(:,:,:,J);
[uE_q(:,:,:,i),vN_q(:,:,:,i)] = rotate_uv2uvEN(ucs_q(:,:,:,i),vcs_q(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_q(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_q(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_q(:,:,:,i) = dyn(:,:,:,J);
[uEt_q(:,:,:,i),vNt_q(:,:,:,i)] = rotate_uv2uvEN(ut_q(:,:,:,i),vt_q(:,:,:,i),AngleCS,AngleSN,Grid);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Dry Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yeard/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_d(:,:,:,i) = dyn(:,:,:,J);
[uE_d(:,:,:,i),vN_d(:,:,:,i)] = rotate_uv2uvEN(ucs_d(:,:,:,i),vcs_d(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_d(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_d(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_d(:,:,:,i) = dyn(:,:,:,J);
[uEt_d(:,:,:,i),vNt_d(:,:,:,i)] = rotate_uv2uvEN(ut_d(:,:,:,i),vt_d(:,:,:,i),AngleCS,AngleSN,Grid);

end


uE_w_mean = mean(uE_w,4);
uE_h_mean = mean(uE_h,4);
uE_q_mean = mean(uE_q,4);
uE_d_mean = mean(uE_d,4);

vN_w_mean = mean(vN_w,4);
vN_h_mean = mean(vN_h,4);
vN_q_mean = mean(vN_q,4);
vN_d_mean = mean(vN_d,4);

uv_w_mean = mean(uv_w,4);
uv_h_mean = mean(uv_h,4);
uv_q_mean = mean(uv_q,4);
uv_d_mean = mean(uv_d,4);

vNt_w_mean = mean(vNt_w,4);
vNt_h_mean = mean(vNt_h,4);
vNt_q_mean = mean(vNt_q,4);
vNt_d_mean = mean(vNt_d,4);

theta_w_mean = mean(theta_w,4);
theta_h_mean = mean(theta_h,4);
theta_q_mean = mean(theta_q,4);
theta_d_mean = mean(theta_d,4);

xi=-179:2:180;yi=-89:2:90;
uEll_w=cube2latlon(xc,yc,uE_w_mean,xi,yi);
uEll_h=cube2latlon(xc,yc,uE_h_mean,xi,yi);
uEll_q=cube2latlon(xc,yc,uE_q_mean,xi,yi);
uEll_d=cube2latlon(xc,yc,uE_d_mean,xi,yi);

vNll_w=cube2latlon(xc,yc,vN_w_mean,xi,yi);
vNll_h=cube2latlon(xc,yc,vN_h_mean,xi,yi);
vNll_q=cube2latlon(xc,yc,vN_q_mean,xi,yi);
vNll_d=cube2latlon(xc,yc,vN_d_mean,xi,yi);

uvll_w=cube2latlon(xc,yc,uv_w_mean,xi,yi);
uvll_h=cube2latlon(xc,yc,uv_h_mean,xi,yi);
uvll_q=cube2latlon(xc,yc,uv_q_mean,xi,yi);
uvll_d=cube2latlon(xc,yc,uv_d_mean,xi,yi);

vNtll_w=cube2latlon(xc,yc,vNt_w_mean,xi,yi);
vNtll_h=cube2latlon(xc,yc,vNt_h_mean,xi,yi);
vNtll_q=cube2latlon(xc,yc,vNt_q_mean,xi,yi);
vNtll_d=cube2latlon(xc,yc,vNt_d_mean,xi,yi);

thetall_w=cube2latlon(xc,yc,theta_w_mean,xi,yi);
thetall_h=cube2latlon(xc,yc,theta_h_mean,xi,yi);
thetall_q=cube2latlon(xc,yc,theta_q_mean,xi,yi);
thetall_d=cube2latlon(xc,yc,theta_d_mean,xi,yi);

uE_w_zav(:,:) = mean(uEll_w,1);
uE_h_zav(:,:) = mean(uEll_h,1);
uE_q_zav(:,:) = mean(uEll_q,1);
uE_d_zav(:,:) = mean(uEll_d,1);

vN_w_zav(:,:) = mean(vNll_w,1);
vN_h_zav(:,:) = mean(vNll_h,1);
vN_q_zav(:,:) = mean(vNll_q,1);
vN_d_zav(:,:) = mean(vNll_d,1);

uv_w_zav(:,:) = mean(uvll_w,1);
uv_h_zav(:,:) = mean(uvll_h,1);
uv_q_zav(:,:) = mean(uvll_q,1);
uv_d_zav(:,:) = mean(uvll_d,1);

vNt_w_zav(:,:) = mean(vNtll_w,1);
vNt_h_zav(:,:) = mean(vNtll_h,1);
vNt_q_zav(:,:) = mean(vNtll_q,1);
vNt_d_zav(:,:) = mean(vNtll_d,1);

theta_w_zav(:,:) = mean(thetall_w,1);
theta_h_zav(:,:) = mean(thetall_h,1);
theta_q_zav(:,:) = mean(thetall_q,1);
theta_d_zav(:,:) = mean(thetall_d,1);


vNt_w_ed_zav = vNt_w_zav - vN_w_zav.*theta_w_zav;
vNt_h_ed_zav = vNt_h_zav - vN_h_zav.*theta_h_zav;
vNt_q_ed_zav = vNt_q_zav - vN_q_zav.*theta_q_zav;
vNt_d_ed_zav = vNt_d_zav - vN_d_zav.*theta_d_zav;

uv_w_ed_zav = uv_w_zav - uE_w_zav.*vN_w_zav;
uv_h_ed_zav = uv_h_zav - uE_h_zav.*vN_h_zav;
uv_q_ed_zav = uv_q_zav - uE_q_zav.*vN_q_zav;
uv_d_ed_zav = uv_d_zav - uE_d_zav.*vN_d_zav;


for i=1:45

uv_w_ed_hzav(i,:) = (uv_w_ed_zav(45+i,:) - uv_w_ed_zav(46-i))./2;
uv_h_ed_hzav(i,:) = (uv_h_ed_zav(45+i,:) - uv_h_ed_zav(46-i))./2;
uv_q_ed_hzav(i,:) = (uv_q_ed_zav(45+i,:) - uv_q_ed_zav(46-i))./2;
uv_d_ed_hzav(i,:) = (uv_d_ed_zav(45+i,:) - uv_d_ed_zav(46-i))./2;

vNt_w_ed_hzav(i,:) = (vNt_w_ed_zav(45+i,:) - vNt_w_ed_zav(46-i))./2;
vNt_h_ed_hzav(i,:) = (vNt_h_ed_zav(45+i,:) - vNt_h_ed_zav(46-i))./2;
vNt_q_ed_hzav(i,:) = (vNt_q_ed_zav(45+i,:) - vNt_q_ed_zav(46-i))./2;
vNt_d_ed_hzav(i,:) = (vNt_d_ed_zav(45+i,:) - vNt_d_ed_zav(46-i))./2;

theta_w_hzav(i,:) = (theta_w_zav(45+i,:) + theta_w_zav(46-i))./2;
theta_h_hzav(i,:) = (theta_h_zav(45+i,:) + theta_h_zav(46-i))./2;
theta_q_hzav(i,:) = (theta_q_zav(45+i,:) + theta_q_zav(46-i))./2;
theta_d_hzav(i,:) = (theta_d_zav(45+i,:) + theta_d_zav(46-i))./2;

end



%%%%%%%%%%%%%%%%%%%%%%% EP fluxes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dthetadp_w = gradient(theta_w_hzav,-4000.);
dthetadp_h = gradient(theta_h_hzav,-4000.);
dthetadp_q = gradient(theta_q_hzav,-4000.);
dthetadp_d = gradient(theta_d_hzav,-4000.);

cosphi = zeros(45,25);
f = zeros(45,25);
omega = 2*pi/(24*60*60);
g=9.81;
a=6371.0e3;

for i=1:25
cosphi(:,i) = cos(yi(46:90).*pi./180);
f(:,i) = 2*omega*sin(yi(46:90).*pi./180);
end

prefactor = cosphi.*2.*pi.*a.^2./g;


%Calculate fluxes and scaled fluxes (Edmon 1980)

Fphi_w = -1.*a.*cosphi.*uv_w_ed_hzav;
Fphi_h = -1.*a.*cosphi.*uv_h_ed_hzav;
Fphi_q = -1.*a.*cosphi.*uv_q_ed_hzav;
Fphi_d = -1.*a.*cosphi.*uv_d_ed_hzav;

Fp_w   = a.*f.*cosphi.*vNt_w_ed_hzav./dthetadp_w;
Fp_h   = a.*f.*cosphi.*vNt_h_ed_hzav./dthetadp_h;
Fp_q   = a.*f.*cosphi.*vNt_q_ed_hzav./dthetadp_q;
Fp_d   = a.*f.*cosphi.*vNt_d_ed_hzav./dthetadp_d;

Fphi_scaled_w = Fphi_w.*prefactor./a;
Fphi_scaled_h = Fphi_h.*prefactor./a;
Fphi_scaled_q = Fphi_q.*prefactor./a;
Fphi_scaled_d = Fphi_d.*prefactor./a;

Fp_scaled_w = Fp_w.*prefactor;
Fp_scaled_h = Fp_h.*prefactor;
Fp_scaled_q = Fp_q.*prefactor;
Fp_scaled_d = Fp_d.*prefactor;


[fluxdiv_p_w ,fdp_y] = gradient(Fp_scaled_w,-4000);
[fdphi_x,fluxdiv_phi_w] = gradient(Fphi_scaled_w,pi./90.);
fluxdiv_w = fluxdiv_p_w + fluxdiv_phi_w;

[fluxdiv_p_h ,fdp_y] = gradient(Fp_scaled_h,-4000);
[fdphi_x,fluxdiv_phi_h] = gradient(Fphi_scaled_h,pi./90.);
fluxdiv_h = fluxdiv_p_h + fluxdiv_phi_h;

[fluxdiv_p_q ,fdp_y] = gradient(Fp_scaled_q,-4000);
[fdphi_x,fluxdiv_phi_q] = gradient(Fphi_scaled_q,pi./90.);
fluxdiv_q = fluxdiv_p_q + fluxdiv_phi_q;

[fluxdiv_p_d ,fdp_y] = gradient(Fp_scaled_d,-4000);
[fdphi_x,fluxdiv_phi_d] = gradient(Fphi_scaled_d,pi./90.);
fluxdiv_d = fluxdiv_p_d + fluxdiv_phi_d;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 21.0;                  %# A4 paper size
X = 29.7;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 2*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 2*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.3; %0.4;
xSize_sub = 1./2-0.1;

pos1x = 0.1 ; 	pos1y = 0.45; %1/2+0.05;
pos2x = 0.55;	pos2y = 0.45; %1/2+0.05;
pos3x = 0.1; 	pos3y = 0.05;
pos4x = 0.55; 	pos4y = 0.05;

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


%%% test regridding
for i=1:23
for j=1:13
Fphi_scaled_w_red(i,j) = Fphi_scaled_w(i*2 -1, j*2 -1);
Fp_scaled_w_red(i,j) = Fp_scaled_w(i*2 -1, j*2 -1);
Fphi_scaled_h_red(i,j) = Fphi_scaled_h(i*2 -1, j*2 -1);
Fp_scaled_h_red(i,j) = Fp_scaled_h(i*2 -1, j*2 -1);
Fphi_scaled_q_red(i,j) = Fphi_scaled_q(i*2 -1, j*2 -1);
Fp_scaled_q_red(i,j) = Fp_scaled_q(i*2 -1, j*2 -1);
Fphi_scaled_d_red(i,j) = Fphi_scaled_d(i*2 -1, j*2 -1);
Fp_scaled_d_red(i,j) = Fp_scaled_d(i*2 -1, j*2 -1);
xspaces(i) = yi(i*2+44 );
yspaces(j) = rC(j*2-1 );
end
end

axes('position',[pos4x pos4y xSize_sub ySize_sub])
%v=0:0.5:5;
%[C,h] = contour(yi(46:90),rC./10^3,fluxdiv_w'./1e16,v,'k');
%clabel(C,h);
%hold on
%v=-5:0.5:0;
%[C,h] = contour(yi(46:90),rC./10^3,fluxdiv_w'./1e16,v,'k--');
%clabel(C,h);
labelling = num2str(shiftdim([100:100:1000],1));
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_scaled_w_red',1.6e-20.*Fp_scaled_w_red','k','AutoScale','off');
%quiver(yi(46:90),rC./10^3,1e-14.*Fphi_scaled_w',1.6e-20.*Fp_scaled_w','k','AutoScale','off');
hold on
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
title(['1xwv'])
quiver(68, 21, 10, 0,'b');
text(68, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(68, 15, 0, -8,'b');
text(69, 12, '\fontsize{8}5E20 M3(PA)');
hold off


axes('position',[pos3x pos3y xSize_sub ySize_sub])
%v=0:0.5:5;
%[C,h] = contour(yi(46:90),rC./10^3,fluxdiv_h'./1e16,v,'k');
%clabel(C,h);
%hold on
%v=-5:0.5:0;
%[C,h] = contour(yi(46:90),rC./10^3,fluxdiv_h'./1e16,v,'k--');
%clabel(C,h);
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_scaled_h_red',1.6e-20.*Fp_scaled_h_red','k','AutoScale','off');
%quiver(yi(46:90),rC./10^3,1e-14.*Fphi_scaled_h',1.6e-20.*Fp_scaled_h','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, hPa')
title(['0.5xwv'])
hold off


axes('position',[pos2x pos2y xSize_sub ySize_sub])
%v=0:0.5:5;
%[C,h] = contour(yi(46:90),rC./10^3,fluxdiv_q'./1e16,v,'k');
%clabel(C,h);
%hold on
%v=-5:0.5:0;
%[C,h] = contour(yi(46:90),rC./10^3,fluxdiv_q'./1e16,v,'k--');
%clabel(C,h);
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_scaled_q_red',1.6e-20.*Fp_scaled_q_red','k','AutoScale','off');
%quiver(yi(46:90),rC./10^3,1e-14.*Fphi_scaled_q',1.6e-20.*Fp_scaled_q','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
title(['0.25xwv'])
hold off


axes('position',[pos1x pos1y xSize_sub ySize_sub])
%v=0:0.5:5;
%[C,h] = contour(yi(46:90),rC./10^3,fluxdiv_d'./1e16,v,'k');
%clabel(C,h);
%hold on
%v=-5:0.5:0;
%[C,h] = contour(yi(46:90),rC./10^3,fluxdiv_d'./1e16,v,'k--');
%clabel(C,h);
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_scaled_d_red',1.6e-20.*Fp_scaled_d_red','k','AutoScale','off');
%quiver(yi(46:90),rC./10^3,1e-14.*Fphi_scaled_d',1.6e-20.*Fp_scaled_d','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
ylabel('Pressure, hPa')
title(['0xwv'])
hold off

print('ep_flux.pdf','-dpdf')

