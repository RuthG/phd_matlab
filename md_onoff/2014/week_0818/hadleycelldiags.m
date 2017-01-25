%load, evaluate and plot Ro, Ht, held hou extent, and subcriticality from walker and schneider

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
J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i)=dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearh/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_h(:,:,:,i)=dyn(:,:,:,J);
[uE_h(:,:,:,i),vN_h(:,:,:,i)] = rotate_uv2uvEN(ucs_h(:,:,:,i),vcs_h(:,:,:,i),AngleCS,AngleSN,Grid);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearq/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_q(:,:,:,i)=dyn(:,:,:,J);
[uE_q(:,:,:,i),vN_q(:,:,:,i)] = rotate_uv2uvEN(ucs_q(:,:,:,i),vcs_q(:,:,:,i),AngleCS,AngleSN,Grid);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yeard/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_d(:,:,:,i)=dyn(:,:,:,J);
[uE_d(:,:,:,i),vN_d(:,:,:,i)] = rotate_uv2uvEN(ucs_d(:,:,:,i),vcs_d(:,:,:,i),AngleCS,AngleSN,Grid);

end

uE_w_mean = mean(uE_w,4);
uE_h_mean = mean(uE_h,4);
uE_q_mean = mean(uE_q,4);
uE_d_mean = mean(uE_d,4);

theta_w_mean = mean(theta_w,4);
theta_h_mean = mean(theta_h,4);
theta_q_mean = mean(theta_q,4);
theta_d_mean = mean(theta_d,4);

xi=-179:2:180;yi=-89:2:90;
thetall_w=cube2latlon(xc,yc,theta_w_mean,xi,yi);
thetall_h=cube2latlon(xc,yc,theta_h_mean,xi,yi);
thetall_q=cube2latlon(xc,yc,theta_q_mean,xi,yi);
thetall_d=cube2latlon(xc,yc,theta_d_mean,xi,yi);

uEll_w=cube2latlon(xc,yc,uE_w_mean,xi,yi);
uEll_h=cube2latlon(xc,yc,uE_h_mean,xi,yi);
uEll_q=cube2latlon(xc,yc,uE_q_mean,xi,yi);
uEll_d=cube2latlon(xc,yc,uE_d_mean,xi,yi);

theta_w_zav(:,:) = mean(thetall_w,1);
theta_h_zav(:,:) = mean(thetall_h,1);
theta_q_zav(:,:) = mean(thetall_q,1);
theta_d_zav(:,:) = mean(thetall_d,1);

uE_w_zav(:,:) = mean(uEll_w,1);
uE_h_zav(:,:) = mean(uEll_h,1);
uE_q_zav(:,:) = mean(uEll_q,1);
uE_d_zav(:,:) = mean(uEll_d,1);

g=9.81;
a=6371.0e3;
omega = 2.*pi./60./60./24;
rd = 287;
cosphi = zeros(90,25);
sinphi = zeros(90,25);
for k=1:25
cosphi(:,k) = cos(yi.*pi./180);
sinphi(:,k) = sin(yi.*pi./180);
end

angmom_w = (omega.*a.*cosphi + uE_w_zav).*a.*cosphi;
angmom_h = (omega.*a.*cosphi + uE_h_zav).*a.*cosphi;
angmom_q = (omega.*a.*cosphi + uE_q_zav).*a.*cosphi;
angmom_d = (omega.*a.*cosphi + uE_d_zav).*a.*cosphi;

f = 2.*omega.*sinphi;

bottom = a.*cosphi;
[b,top_w] = gradient(uE_w_zav.*cosphi,pi./90);
dudy_w = top_w./bottom;
[b,top_h] = gradient(uE_h_zav.*cosphi,pi./90);
dudy_h = top_h./bottom;
[b,top_q] = gradient(uE_q_zav.*cosphi,pi./90);
dudy_q = top_q./bottom;
[b,top_d] = gradient(uE_d_zav.*cosphi,pi./90);
dudy_d = top_d./bottom;

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
t_w_zav(:,j)=theta_w_zav(:,j).*convthetatoT(j,1);
t_h_zav(:,j)=theta_h_zav(:,j).*convthetatoT(j,1);
t_q_zav(:,j)=theta_q_zav(:,j).*convthetatoT(j,1);
t_d_zav(:,j)=theta_d_zav(:,j).*convthetatoT(j,1);
end

for k=1:25
rho_w(:,k) = rC(k)./(rd.*t_w_zav(:,k));
rho_h(:,k) = rC(k)./(rd.*t_h_zav(:,k));
rho_q(:,k) = rC(k)./(rd.*t_q_zav(:,k));
rho_d(:,k) = rC(k)./(rd.*t_d_zav(:,k));
end

dTdz_w = rho_w.*g.*gradient(t_w_zav,-4000);
dTdz_h = rho_h.*g.*gradient(t_h_zav,-4000);
dTdz_q = rho_q.*g.*gradient(t_q_zav,-4000);
dTdz_d = rho_d.*g.*gradient(t_d_zav,-4000);

rossby_w = dudy_w./f;
rossby_h = dudy_h./f;
rossby_q = dudy_q./f;
rossby_d = dudy_d./f;

for i=1:45
angmom_d_hzav(i,:) = (angmom_d(45+i,:) + angmom_d(46-i,:))./2;
angmom_q_hzav(i,:) = (angmom_q(45+i,:) + angmom_q(46-i,:))./2;
angmom_h_hzav(i,:) = (angmom_h(45+i,:) + angmom_h(46-i,:))./2;
angmom_w_hzav(i,:) = (angmom_w(45+i,:) + angmom_w(46-i,:))./2;
end



%Held Hou

theta_w_vzav = mean(theta_w_zav,2);
theta_h_vzav = mean(theta_h_zav,2);
theta_q_vzav = mean(theta_q_zav,2);
theta_d_vzav = mean(theta_d_zav,2);

deltheta_w = theta_w_vzav(46) - theta_w_vzav(90);
deltheta_h = theta_h_vzav(46) - theta_h_vzav(90);
deltheta_q = theta_q_vzav(46) - theta_q_vzav(90);
deltheta_d = theta_d_vzav(46) - theta_d_vzav(90);

%psihh 












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

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=0:0.2:1.4;
[C,h] = contour(yi,rC./100,rossby_w',v,'k');
clabel(C,h);
xlabel('Latitude')
set(gca,'YDir','reverse')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=0:0.2:1.4;
[C,h] = contour(yi,rC./100,rossby_h',v,'k');
clabel(C,h);
ylabel('Pressure, hPa')
xlabel('Latitude')
set(gca,'YDir','reverse')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=0:0.2:1.4;
[C,h] = contour(yi,rC./100,rossby_q',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=0:0.2:1.4;
[C,h] = contour(yi,rC./100,rossby_d',v,'k');
clabel(C,h);
ylabel('Pressure, hPa')
set(gca,'YDir','reverse')

print('rossby.pdf','-dpdf')





hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

labels = [1,5,10];
axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=0:1:10;
[C,h] = contour(yi(46:90),rC./100,angmom_w_hzav'./(0.1*omega.*a^2),v,'k');
clabel(C,h,labels);
xlabel('Latitude')
title(['1xwv'])
set(gca,'YDir','reverse')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=0:1:10;
[C,h] = contour(yi(46:90),rC./100,angmom_h_hzav'./(0.1*omega.*a^2),v,'k');
clabel(C,h,labels);
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['0.5xwv'])
set(gca,'YDir','reverse')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=0:1:10;
[C,h] = contour(yi(46:90),rC./100,angmom_q_hzav'./(0.1*omega.*a^2),v,'k');
clabel(C,h,labels);
title(['0.5xwv'])
set(gca,'YDir','reverse')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=0:1:10;
[C,h] = contour(yi(46:90),rC./100,angmom_d_hzav'./(0.1*omega.*a^2),v,'k');
clabel(C,h,labels);
ylabel('Pressure, hPa')
title(['1xwv'])
set(gca,'YDir','reverse')

print('angmom.pdf','-dpdf')




hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=0:0.2:1;
[C,h] = contour(yi,rC./100,rossby_w',v);
%colormap(b2r(0,1));
hold on
v=0:1:10;
[C,h] = contour(yi,rC./100,angmom_w'./(0.1*omega.*a^2),v,'k');
clabel(C,h);
xlabel('Latitude')
set(gca,'YDir','reverse')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=0:0.2:1;
[C,h] = contour(yi,rC./100,rossby_h',v);
%colormap(b2r(0,1));
hold on
v=0:1:10;
[C,h] = contour(yi,rC./100,angmom_h'./(0.1*omega.*a^2),v,'k');
clabel(C,h);
ylabel('Pressure, hPa')
xlabel('Latitude')
set(gca,'YDir','reverse')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=0:0.2:1;
[C,h] = contour(yi,rC./100,rossby_q',v);
%colormap(b2r(0,1));
hold on
v=0:1:10;
[C,h] = contour(yi,rC./100,angmom_q'./(0.1*omega.*a^2),v,'k');
clabel(C,h);
set(gca,'YDir','reverse')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=0:0.2:1;
[C,h] = contour(yi,rC./100,rossby_d',v);
%colormap(b2r(0,1));
hold on
v=0:1:10;
[C,h] = contour(yi,rC./100,angmom_d'./(0.1*omega.*a^2),v,'k');
clabel(C,h);
ylabel('Pressure, hPa')
set(gca,'YDir','reverse')

print('angmomross.pdf','-dpdf')
