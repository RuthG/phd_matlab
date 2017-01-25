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
for nit = 259200:86400:604800;
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Quarter WV Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_quarterwv/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_q(:,:,:,i) = dyn(:,:,:,J);
[uE_q(:,:,:,i),vN_q(:,:,:,i)] = rotate_uv2uvEN(ucs_q(:,:,:,i),vcs_q(:,:,:,i),AngleCS,AngleSN,Grid);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Dry Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_d(:,:,:,i) = dyn(:,:,:,J);
[uE_d(:,:,:,i),vN_d(:,:,:,i)] = rotate_uv2uvEN(ucs_d(:,:,:,i),vcs_d(:,:,:,i),AngleCS,AngleSN,Grid);

end

uE_w_mean = mean(uE_w,4);
vN_w_mean = mean(vN_w,4);
uE_h_mean = mean(uE_h,4);
vN_h_mean = mean(vN_h,4);
uE_q_mean = mean(uE_q,4);
vN_q_mean = mean(vN_q,4);
uE_d_mean = mean(uE_d,4);
vN_d_mean = mean(vN_d,4);

xi=-179:2:180;yi=-89:2:90;
uEll_w=cube2latlon(xc,yc,uE_w_mean,xi,yi);
vNll_w=cube2latlon(xc,yc,vN_w_mean,xi,yi);
uEll_h=cube2latlon(xc,yc,uE_h_mean,xi,yi);
vNll_h=cube2latlon(xc,yc,vN_h_mean,xi,yi);
uEll_q=cube2latlon(xc,yc,uE_q_mean,xi,yi);
vNll_q=cube2latlon(xc,yc,vN_q_mean,xi,yi);
uEll_d=cube2latlon(xc,yc,uE_d_mean,xi,yi);
vNll_d=cube2latlon(xc,yc,vN_d_mean,xi,yi);

uE_w_zav(:,:) = mean(uEll_w,1);
vN_w_zav(:,:) = mean(vNll_w,1);
uE_h_zav(:,:) = mean(uEll_h,1);
vN_h_zav(:,:) = mean(vNll_h,1);
uE_q_zav(:,:) = mean(uEll_q,1);
vN_q_zav(:,:) = mean(vNll_q,1);
uE_d_zav(:,:) = mean(uEll_d,1);
vN_d_zav(:,:) = mean(vNll_d,1);


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


%%%%%%%%%%%%%%%%%%%%%%%% t-av/h-av %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uE_w_tzav = mean(uE_w_zav,3);
uE_h_tzav = mean(uE_h_zav,3);
uE_q_tzav = mean(uE_q_zav,3);
uE_d_tzav = mean(uE_d_zav,3);


for i=1:45
psi_w_hzav(46-i,:) = (-1*psi_w(i,:) + psi_w(91-i,:))./2;
uE_w_hzav(46-i,:) = (uE_w_tzav(i,:) + uE_w_tzav(91-i,:))./2;
psi_h_hzav(46-i,:) = (-1*psi_h(i,:) + psi_h(91-i,:))./2;
uE_h_hzav(46-i,:) = (uE_h_tzav(i,:) + uE_h_tzav(91-i,:))./2;
psi_q_hzav(46-i,:) = (-1*psi_q(i,:) + psi_q(91-i,:))./2;
uE_q_hzav(46-i,:) = (uE_q_tzav(i,:) + uE_q_tzav(91-i,:))./2;
psi_d_hzav(46-i,:) = (-1*psi_d(i,:) + psi_d(91-i,:))./2;
uE_d_hzav(46-i,:) = (uE_d_tzav(i,:) + uE_d_tzav(91-i,:))./2;
end





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
v=-25:5:45;
[C,h]=contourf(yi(46:90),rC./100.,uE_d_hzav',v);
hold on
colorbar
colormap(b2r(-25,45));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['0xwv'])
v = -220:10:0;
[C,h]=contour(yi(46:90),rC./100.,psi_d_hzav'./1e9,v,'k--');
clabel(C,h);
hold on
v=0:30:210;
[C,h]=contour(yi(46:90),rC./100.,psi_d_hzav'./1e9,v,'k');
clabel(C,h);
hold off

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-25:5:45;
[C,h]=contourf(yi(46:90),rC./100.,uE_q_hzav',v);
hold on
colorbar
colormap(b2r(-25,45));
title(['0.25xwv'])
set(gca,'YDir','reverse')
v = -220:10:0;
[C,h]=contour(yi(46:90),rC./100.,psi_q_hzav'./1e9,v,'k--');
clabel(C,h);
hold on
v=0:30:210;
[C,h]=contour(yi(46:90),rC./100.,psi_q_hzav'./1e9,v,'k');
clabel(C,h);
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-25:5:45;
[C,h]=contourf(yi(46:90),rC./100.,uE_h_hzav',v);
hold on
colorbar
colormap(b2r(-25,45));
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title(['0.5xwv'])
v = -220:10:0;
[C,h]=contour(yi(46:90),rC./100.,psi_h_hzav'./1e9,v,'k--');
clabel(C,h);
hold on
v=0:30:210;
[C,h]=contour(yi(46:90),rC./100.,psi_h_hzav'./1e9,v,'k');
clabel(C,h);
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-25:5:45;
[C,h]=contourf(yi(46:90),rC./100.,uE_w_hzav',v);
hold on
colorbar
colormap(b2r(-25,45));
set(gca,'YDir','reverse')
xlabel('Latitude')
title(['1xwv'])
v = -220:10:0;
[C,h]=contour(yi(46:90),rC./100.,psi_w_hzav'./1e9,v,'k--');
clabel(C,h);
hold on
v=0:30:210;
[C,h]=contour(yi(46:90),rC./100.,psi_w_hzav'./1e9,v,'k');
clabel(C,h);

hold off




print('-dpdf','upsi.pdf')

