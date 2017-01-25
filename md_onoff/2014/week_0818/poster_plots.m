%load up theta, u, u'v' and plot up for the 2 runs


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
%%%%%%%%%%%%%%%%%%%%%%%% Tropheat Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearth/';
nitth = nit;
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nitth);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_th(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_th(:,:,:,i) = dyn(:,:,:,J);
[uE_th(:,:,:,i),vN_th(:,:,:,i)] = rotate_uv2uvEN(ucs_th(:,:,:,i),vcs_th(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_th(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_th(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_th(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_th(:,:,:,i) = dyn(:,:,:,J);
[uEt_th(:,:,:,i),vNt_th(:,:,:,i)] = rotate_uv2uvEN(ut_th(:,:,:,i),vt_th(:,:,:,i),AngleCS,AngleSN,Grid);

end


uE_w_mean = mean(uE_w,4);
vN_w_mean = mean(vN_w,4);
uv_w_mean = mean(uv_w,4);
theta_w_mean = mean(theta_w,4);
vNt_w_mean = mean(vNt_w,4);

uE_h_mean = mean(uE_h,4);
vN_h_mean = mean(vN_h,4);
uv_h_mean = mean(uv_h,4);
theta_h_mean = mean(theta_h,4);
vNt_h_mean = mean(vNt_h,4);

uE_th_mean = mean(uE_th,4);
vN_th_mean = mean(vN_th,4);
uv_th_mean = mean(uv_th,4);
theta_th_mean = mean(theta_th,4);
vNt_th_mean = mean(vNt_th,4);

xi=-179:2:180;yi=-89:2:90;
uEll_w = cube2latlon(xc,yc,uE_w_mean,xi,yi);
vNll_w = cube2latlon(xc,yc,vN_w_mean,xi,yi);
thetall_w = cube2latlon(xc,yc,theta_w_mean,xi,yi);
uvll_w = cube2latlon(xc,yc,uv_w_mean,xi,yi);
vNtll_w = cube2latlon(xc,yc,vNt_w_mean,xi,yi);

uEll_th= cube2latlon(xc,yc,uE_th_mean,xi,yi);
vNll_th= cube2latlon(xc,yc,vN_th_mean,xi,yi);
thetall_th= cube2latlon(xc,yc,theta_th_mean,xi,yi);
uvll_th = cube2latlon(xc,yc,uv_th_mean,xi,yi);
vNtll_th = cube2latlon(xc,yc,vNt_th_mean,xi,yi);

uEll_h = cube2latlon(xc,yc,uE_h_mean,xi,yi);
vNll_h = cube2latlon(xc,yc,vN_h_mean,xi,yi);
thetall_h = cube2latlon(xc,yc,theta_h_mean,xi,yi);
uvll_h = cube2latlon(xc,yc,uv_h_mean,xi,yi);
vNtll_h = cube2latlon(xc,yc,vNt_h_mean,xi,yi);

uE_w_zav(:,:) = mean(uEll_w,1);
vN_w_zav(:,:) = mean(vNll_w,1);
theta_w_zav(:,:) = mean(thetall_w,1);
uv_w_zav(:,:) = mean(uvll_w,1);
vNt_w_zav(:,:) = mean(vNtll_w,1);
uE_th_zav(:,:) = mean(uEll_th,1);
vN_th_zav(:,:) = mean(vNll_th,1);
theta_th_zav(:,:) = mean(thetall_th,1);
uv_th_zav(:,:) = mean(uvll_th,1);
vNt_th_zav(:,:) = mean(vNtll_th,1);
uE_h_zav(:,:) = mean(uEll_h,1);
vN_h_zav(:,:) = mean(vNll_h,1);
theta_h_zav(:,:) = mean(thetall_h,1);
uv_h_zav(:,:) = mean(uvll_h,1);
vNt_h_zav(:,:) = mean(vNtll_h,1);

vNt_w_ed_zav = vNt_w_zav - vN_w_zav.*theta_w_zav;
vNt_h_ed_zav = vNt_h_zav - vN_h_zav.*theta_h_zav;
vNt_th_ed_zav = vNt_th_zav - vN_th_zav.*theta_th_zav;

uv_w_ed_zav = uv_w_zav - uE_w_zav.*vN_w_zav;
uv_h_ed_zav = uv_h_zav - uE_h_zav.*vN_h_zav;
uv_th_ed_zav = uv_th_zav - uE_th_zav.*vN_th_zav;


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

%%%%%%%%%%%%%%%%%%%%%%%%%% Tropheat WV psi  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

integrand = zeros(size(vN_th_zav));
cosphi = zeros(90,25);
for k=1:25
cosphi(:,k) = cos(yi.*pi./180);
end
integrand = 2.*pi.*rad.*vN_th_zav.*cosphi./g;
psi_th = flipdim(cumsum(flipdim(integrand,2).*deltap,2),2);



for i=1:45
psi_w_hzav(46-i,:) = (-1*psi_w(i,:) + psi_w(91-i,:))./2;
uE_w_hzav(46-i,:) = (uE_w_zav(i,:) + uE_w_zav(91-i,:))./2;
theta_w_hzav(46-i,:) = (theta_w_zav(i,:) + theta_w_zav(91-i,:))./2;

psi_h_hzav(46-i,:) = (-1*psi_h(i,:) + psi_h(91-i,:))./2;
uE_h_hzav(46-i,:) = (uE_h_zav(i,:) + uE_h_zav(91-i,:))./2;
theta_h_hzav(46-i,:) = (theta_h_zav(i,:) + theta_h_zav(91-i,:))./2;

psi_th_hzav(46-i,:) = (-1*psi_th(i,:) + psi_th(91-i,:))./2;
uE_th_hzav(46-i,:) = (uE_th_zav(i,:) + uE_th_zav(91-i,:))./2;
theta_th_hzav(46-i,:) = (theta_th_zav(i,:) + theta_th_zav(91-i,:))./2;

uv_w_ed_hzav(i,:) = (uv_w_ed_zav(45+i,:) - uv_w_ed_zav(46-i))./2;
uv_h_ed_hzav(i,:) = (uv_h_ed_zav(45+i,:) - uv_h_ed_zav(46-i))./2;
uv_th_ed_hzav(i,:) = (uv_th_ed_zav(45+i,:) - uv_th_ed_zav(46-i))./2;

vNt_w_ed_hzav(i,:) = (vNt_w_ed_zav(45+i,:) - vNt_w_ed_zav(46-i))./2;
vNt_h_ed_hzav(i,:) = (vNt_h_ed_zav(45+i,:) - vNt_h_ed_zav(46-i))./2;
vNt_th_ed_hzav(i,:) = (vNt_th_ed_zav(45+i,:) - vNt_th_ed_zav(46-i))./2;

end


%%%%%%%%%%%%%%%%%%%%%%% EP fluxes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dthetadp_w = gradient(theta_w_hzav,-4000.);
dthetadp_h = gradient(theta_h_hzav,-4000.);
dthetadp_th = gradient(theta_th_hzav,-4000.);

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
Fphi_th = -1.*a.*cosphi.*uv_th_ed_hzav;

Fp_w   = a.*f.*cosphi.*vNt_w_ed_hzav./dthetadp_w;
Fp_h   = a.*f.*cosphi.*vNt_h_ed_hzav./dthetadp_h;
Fp_th   = a.*f.*cosphi.*vNt_th_ed_hzav./dthetadp_th;

Fphi_scaled_w = Fphi_w.*prefactor./a;
Fphi_scaled_h = Fphi_h.*prefactor./a;
Fphi_scaled_th = Fphi_th.*prefactor./a;

Fp_scaled_w = Fp_w.*prefactor;
Fp_scaled_h = Fp_h.*prefactor;
Fp_scaled_th = Fp_th.*prefactor;

[fluxdiv_p_w ,fdp_y] = gradient(Fp_scaled_w,-4000);
[fdphi_x,fluxdiv_phi_w] = gradient(Fphi_scaled_w,pi./90.);
fluxdiv_w = fluxdiv_p_w + fluxdiv_phi_w;

[fluxdiv_p_h ,fdp_y] = gradient(Fp_scaled_h,-4000);
[fdphi_x,fluxdiv_phi_h] = gradient(Fphi_scaled_h,pi./90.);
fluxdiv_h = fluxdiv_p_h + fluxdiv_phi_h;

[fluxdiv_p_th ,fdp_y] = gradient(Fp_scaled_th,-4000);
[fdphi_x,fluxdiv_phi_th] = gradient(Fphi_scaled_th,pi./90.);
fluxdiv_th = fluxdiv_p_th + fluxdiv_phi_th;


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

axes('position',[pos1x pos1y xSize_sub ySize_sub])

v=-12:2:20;
[C,h]=contourf(yi(46:90),rC./100.,uE_w_hzav'-uE_h_hzav',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(yi(46:90),rC./100.,uE_w_hzav'-uE_h_hzav',v,'k:');
colorbar;
colormap(b2r(-12,20));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['1xwv - 0.5xwv'])
v=-25:5:0;
[C,h]=contour(yi(46:90),rC./100.,uE_h_hzav',v,'k--');
%clabel(C,h);
v=0:5:45;
[C,h]=contour(yi(46:90),rC./100.,uE_h_hzav',v,'k');
%clabel(C,h);
freezeColors
cbfreeze(colorbar);
hold off

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-12:2:20;
[C,h]=contourf(yi(46:90),rC./100.,uE_th_hzav'-uE_h_hzav',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(yi(46:90),rC./100.,uE_th_hzav'-uE_h_hzav',v,'k:');
colorbar;
colormap(b2r(-12,20));
set(gca,'YDir','reverse')
xlabel('Latitude')
title(['tropheat - 0.5xwv'])
v=-25:5:0;
[C,h]=contour(yi(46:90),rC./100.,uE_h_hzav',v,'k--');
%clabel(C,h);
v=0:5:45;
[C,h]=contour(yi(46:90),rC./100.,uE_h_hzav',v,'k');
%clabel(C,h);
freezeColors
cbfreeze(colorbar);
hold off
print('-dpdf','uE_wth_diff.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-4:2:22;
[C,h]=contourf(yi(46:90),rC./100.,theta_w_hzav'-theta_h_hzav',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(yi(46:90),rC./100.,theta_w_hzav'-theta_h_hzav',v,'k:');
colorbar;
colormap(b2r(-4,22));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['1xwv - 0.5xwv'])
v=250:5:650;
[C,h]=contour(yi(46:90),rC./100.,theta_h_hzav',v,'k');
%clabel(C,h);
freezeColors
cbfreeze(colorbar);
hold off

axes('position',[pos2x pos2y xSize_sub ySize_sub])

v=-4:2:22;
[C,h]=contourf(yi(46:90),rC./100.,theta_th_hzav'-theta_h_hzav',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(yi(46:90),rC./100.,theta_th_hzav'-theta_h_hzav',v,'k:');
colorbar;
colormap(b2r(-4,22));
set(gca,'YDir','reverse')
xlabel('Latitude')
title(['tropheat - 0.5xwv'])
v=250:5:650;
[C,h]=contour(yi(46:90),rC./100.,theta_h_hzav',v,'k');
%clabel(C,h);
freezeColors
cbfreeze(colorbar);
hold off
print('-dpdf','theta_wth_diff.pdf')


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
Fphi_scaled_th_red(i,j) = Fphi_scaled_th(i*2 -1, j*2 -1);
Fp_scaled_th_red(i,j) = Fp_scaled_th(i*2 -1, j*2 -1);
xspaces(i) = yi(i*2+44 );
yspaces(j) = rC(j*2-1 );
end
end

axes('position',[pos1x pos1y xSize_sub ySize_sub])
labelling = num2str(shiftdim([100:100:1000],1));
quiver(xspaces,yspaces./10^3,1e-14.*(Fphi_scaled_w_red' - Fphi_scaled_h_red') ,1.6e-20.*(Fp_scaled_w_red' - Fp_scaled_h_red'),'k','AutoScale','off');
hold on
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, hPa')
title(['1xwv - 0.5xwv'])
hold off

axes('position',[pos2x pos2y xSize_sub ySize_sub])
quiver(xspaces,yspaces./10^3,1e-14.*(Fphi_scaled_th_red' - Fphi_scaled_h_red') ,1.6e-20.*(Fp_scaled_th_red' - Fp_scaled_h_red'),'k','AutoScale','off');
hold on
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
title(['tropheat - 0.5xwv'])
quiver(68, 21, 10, 0,'b');
text(68, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(68, 15, 0, -8,'b');
text(69, 12, '\fontsize{8}5E20 M3(PA)');
hold off

print('-dpdf','epflux_wth_diff.pdf')




hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-10:5:20;
[C,h]=contourf(yi(46:90),rC./100.,uv_w_ed_hzav'-uv_h_ed_hzav',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(yi(46:90),rC./100.,uv_w_ed_hzav'-uv_h_ed_hzav',v,'k:');
colorbar;
colormap(b2r(-10,20));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
%xlabel('Latitude')
title('1xwv - 0.5xwv')
v = -10:5:0;
[C,h]=contour(yi(46:90),rC./100.,uv_h_ed_hzav',v,'k--');
%clabel(C,h);
v = 0:5:30;
[C,h]=contour(yi(46:90),rC./100.,uv_h_ed_hzav',v,'k');
%clabel(C,h);
freezeColors
cbfreeze(colorbar);
hold off

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-10:5:20;
[C,h]=contourf(yi(46:90),rC./100.,uv_th_ed_hzav'-uv_h_ed_hzav',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(yi(46:90),rC./100.,uv_th_ed_hzav'-uv_h_ed_hzav',v,'k:');
colorbar;
colormap(b2r(-10,20));
set(gca,'YDir','reverse')
%xlabel('Latitude')
title('tropheat - 0.5xwv')
v = -10:5:0;
[C,h]=contour(yi(46:90),rC./100.,uv_h_ed_hzav',v,'k--');
%clabel(C,h);
v = 0:5:30;
[C,h]=contour(yi(46:90),rC./100.,uv_h_ed_hzav',v,'k');
%clabel(C,h);
freezeColors
cbfreeze(colorbar);
hold off
%print('-dpdf','uved_wth_diff.pdf')

%hFig = figure('Menubar','none');
%# figure size printed on paper
%set(hFig, 'PaperUnits','centimeters')
%set(hFig, 'PaperSize',[X Y])
%set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
%set(hFig, 'PaperOrientation','portrait')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-6:1:6;
[C,h]=contourf(yi(46:90),rC./100.,vNt_w_ed_hzav'-vNt_h_ed_hzav',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(yi(46:90),rC./100.,vNt_w_ed_hzav'-vNt_h_ed_hzav',v,'k:');
colorbar;
colormap(b2r(-6,6));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
%title('1xwv - 0.5xwv')
v = -20:4:0;
[C,h]=contour(yi(46:90),rC./100.,vNt_h_ed_hzav',v,'k--');
%clabel(C,h);
v = 0:4:20;
[C,h]=contour(yi(46:90),rC./100.,vNt_h_ed_hzav',v,'k');
%clabel(C,h);
freezeColors
cbfreeze(colorbar);
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-6:1:6;
[C,h]=contourf(yi(46:90),rC./100.,vNt_th_ed_hzav'-vNt_h_ed_hzav',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(yi(46:90),rC./100.,vNt_th_ed_hzav'-vNt_h_ed_hzav',v,'k:');
colorbar;
colormap(b2r(-6,6));
set(gca,'YDir','reverse')
xlabel('Latitude')
%title('tropheat - 0.5xwv')
v = -20:4:0;
[C,h]=contour(yi(46:90),rC./100.,vNt_h_ed_hzav',v,'k--');
%clabel(C,h);
v = 0:4:20;
[C,h]=contour(yi(46:90),rC./100.,vNt_h_ed_hzav',v,'k');
%clabel(C,h);
freezeColors
cbfreeze(colorbar);
hold off
print('-dpdf','vted_wth_diff.pdf')











%# centimeters units
X = 20.0;                  %# A4 paper size
Y = 11.0;                  %# A4 paper size
xMargin = 1;               %# left/right margins from page borders
yMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 1*yMargin;     %# figure size on paper (widht & hieght)

hFig = figure; %('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-25:5:45;
[C,h]=contourf(yi(46:90),rC./100.,uE_th_hzav',v);
hold on
colorbar
colormap(b2r(-25,45));
v = -220:10:0;
[C,h]=contour(yi(46:90),rC./100.,psi_th_hzav'./1e9,v,'k--');
%set(h,'edgecolor','none')
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
v=0:30:280;
[C,h]=contour(yi(46:90),rC./100.,psi_th_hzav'./1e9,v,'k');
vec=30:30:280;
clabel(C,h,vec);
hold off
print('-dpdf','upsi_th.pdf')


