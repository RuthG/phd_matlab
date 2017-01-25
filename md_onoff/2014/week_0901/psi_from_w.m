%psi_from_w.m
%calculate mass trans from w...

% need w, a, g, cosphi

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

%heating rates
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'WVEL    '));
w_w(:,:,:,i)=dyn(:,:,:,J);


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearh/';

%heating rates
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'WVEL    '));
w_h(:,:,:,i)=dyn(:,:,:,J);


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearq/';

%heating rates
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'WVEL    '));
w_q(:,:,:,i)=dyn(:,:,:,J);


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yeard/';

%heating rates
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'WVEL    '));
w_d(:,:,:,i)=dyn(:,:,:,J);


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearth/';

%heating rates
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'WVEL    '));
w_th(:,:,:,i)=dyn(:,:,:,J);

end


w_w_mean = mean(w_w,4);
w_h_mean = mean(w_h,4);
w_q_mean = mean(w_q,4);
w_d_mean = mean(w_d,4);
w_th_mean = mean(w_th,4);

xi=-179:2:180;yi=-89:2:90;
wll_w=cube2latlon(xc,yc,w_w_mean,xi,yi);
wll_h=cube2latlon(xc,yc,w_h_mean,xi,yi);
wll_q=cube2latlon(xc,yc,w_q_mean,xi,yi);
wll_d=cube2latlon(xc,yc,w_d_mean,xi,yi);
wll_th=cube2latlon(xc,yc,w_th_mean,xi,yi);

wll_w_zav(:,:) = mean(wll_w,1);
wll_h_zav(:,:) = mean(wll_h,1);
wll_q_zav(:,:) = mean(wll_q,1);
wll_d_zav(:,:) = mean(wll_d,1);
wll_th_zav(:,:) = mean(wll_th,1);

cosphi = zeros(45,25);

for i=1:45

w_w_hzav(i,:) = (wll_w_zav(46-i,:) + wll_w_zav(45+i,:))./2;
w_h_hzav(i,:) = (wll_h_zav(46-i,:) + wll_h_zav(45+i,:))./2;
w_q_hzav(i,:) = (wll_q_zav(46-i,:) + wll_q_zav(45+i,:))./2;
w_d_hzav(i,:) = (wll_d_zav(46-i,:) + wll_d_zav(45+i,:))./2;
w_th_hzav(i,:) = (wll_th_zav(46-i,:) + wll_th_zav(45+i,:))./2;
cosphi(i,:) = cos(yi(45+i).*pi./180);

end

g=9.81;
a=6371.0e3;

integrand_w = w_w_hzav.*cosphi;
integrand_h = w_h_hzav.*cosphi;
integrand_q = w_q_hzav.*cosphi;
integrand_d = w_d_hzav.*cosphi;
integrand_th = w_th_hzav.*cosphi;

prefac = -2.*pi.*a.^2./g;

intfac = pi./90;

psi_w = prefac.*cumsum(integrand_w,1).*intfac;
psi_h = prefac.*cumsum(integrand_h,1).*intfac;
psi_q = prefac.*cumsum(integrand_q,1).*intfac;
psi_d = prefac.*cumsum(integrand_d,1).*intfac;
psi_th = prefac.*cumsum(integrand_th,1).*intfac;



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
v = -220:10:0;
[C,h]=contour(yi(46:90),rC./100.,psi_d'./1e9,v,'k--');
clabel(C,h);
hold on
v=0:30:210;
[C,h]=contour(yi(46:90),rC./100.,psi_d'./1e9,v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['0xwv'])
hold off

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v = -220:10:0;
[C,h]=contour(yi(46:90),rC./100.,psi_q'./1e9,v,'k--');
clabel(C,h);
hold on
v=0:30:210;
[C,h]=contour(yi(46:90),rC./100.,psi_q'./1e9,v,'k');
clabel(C,h);
title(['0.25xwv'])
set(gca,'YDir','reverse')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v = -220:10:0;
[C,h]=contour(yi(46:90),rC./100.,psi_h'./1e9,v,'k--');
clabel(C,h);
hold on
v=0:30:210;
[C,h]=contour(yi(46:90),rC./100.,psi_h'./1e9,v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title(['0.5xwv'])
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v = -220:10:0;
[C,h]=contour(yi(46:90),rC./100.,psi_w'./1e9,v,'k--');
clabel(C,h);
hold on
v=0:30:210;
[C,h]=contour(yi(46:90),rC./100.,psi_w'./1e9,v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
title(['1xwv'])
hold off

print('-dpdf','psi_via_w.pdf')


