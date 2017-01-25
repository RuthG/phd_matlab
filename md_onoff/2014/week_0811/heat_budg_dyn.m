%load in total heating and vTheta and see if these balance?


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

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_w(:,:,:,i)=dyn(:,:,:,J);

J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i)=dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'UVELTH  '));
ucsth_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vcsth_w(:,:,:,i)=dyn(:,:,:,J);
[uEth_w(:,:,:,i),vNth_w(:,:,:,i)] = rotate_uv2uvEN(ucsth_w(:,:,:,i),vcsth_w(:,:,:,i),AngleCS,AngleSN,Grid);


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearh/';

%heating rates
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_h(:,:,:,i)=dyn(:,:,:,J);

J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_h(:,:,:,i)=dyn(:,:,:,J);
[uE_h(:,:,:,i),vN_h(:,:,:,i)] = rotate_uv2uvEN(ucs_h(:,:,:,i),vcs_h(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'UVELTH  '));
ucsth_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vcsth_h(:,:,:,i)=dyn(:,:,:,J);
[uEth_h(:,:,:,i),vNth_h(:,:,:,i)] = rotate_uv2uvEN(ucsth_h(:,:,:,i),vcsth_h(:,:,:,i),AngleCS,AngleSN,Grid);

end

%take time means
htrt_w_mean = mean(htrt_w,4);
difht_w_mean = mean(difht_w,4);
radht_w_mean = mean(radht_w,4);
cndht_w_mean = mean(cndht_w,4);
cnvht_w_mean = mean(cnvht_w,4);
vNth_w_mean = mean(vNth_w,4);
vN_w_mean = mean(vN_w,4);
theta_w_mean = mean(theta_w,4);

htrt_h_mean = mean(htrt_h,4);
difht_h_mean = mean(difht_h,4);
radht_h_mean = mean(radht_h,4);
cndht_h_mean = mean(cndht_h,4);
cnvht_h_mean = mean(cnvht_h,4);
vNth_h_mean = mean(vNth_h,4);
vN_h_mean = mean(vN_h,4);
theta_h_mean = mean(theta_h,4);

%density weighted height integral = pressure integral/g
%cp puts this into W/m-2
g=9.81;
cp=1004.64;
intfac = 4000.*cp./g;
a=6371.0e3;
htrt_w_vint = sum(htrt_w_mean,3).*intfac;
difht_w_vint = sum(difht_w_mean,3).*intfac;
radht_w_vint = sum(radht_w_mean,3).*intfac;
cndht_w_vint = sum(cndht_w_mean,3).*intfac;
cnvht_w_vint = sum(cnvht_w_mean,3).*intfac;

htrt_h_vint = sum(htrt_h_mean,3).*intfac;
difht_h_vint = sum(difht_h_mean,3).*intfac;
radht_h_vint = sum(radht_h_mean,3).*intfac;
cndht_h_vint = sum(cndht_h_mean,3).*intfac;
cnvht_h_vint = sum(cnvht_h_mean,3).*intfac;

%put on lat lon grid and zonally average
xi=-179:2:180;yi=-89:2:90;
vNthll_w=cube2latlon(xc,yc,vNth_w_mean,xi,yi);
thetall_w=cube2latlon(xc,yc,theta_w_mean,xi,yi);
vNll_w=cube2latlon(xc,yc,vN_w_mean,xi,yi);
htrtll_w=cube2latlon(xc,yc,htrt_w_vint,xi,yi);
difhtll_w=cube2latlon(xc,yc,difht_w_vint,xi,yi);
radhtll_w=cube2latlon(xc,yc,radht_w_vint,xi,yi);
cnvhtll_w=cube2latlon(xc,yc,cnvht_w_vint,xi,yi);
cndhtll_w=cube2latlon(xc,yc,cndht_w_vint,xi,yi);

vNthll_w_zav(:,:) = mean(vNthll_w,1);
thetall_w_zav(:,:) = mean(thetall_w,1);
vNll_w_zav(:,:) = mean(vNll_w,1);
htrtll_w_zav(:,:) = mean(htrtll_w,1);
difhtll_w_zav(:,:) = mean(difhtll_w,1);
radhtll_w_zav(:,:) = mean(radhtll_w,1);
cnvhtll_w_zav(:,:) = mean(cnvhtll_w,1);
cndhtll_w_zav(:,:) = mean(cndhtll_w,1);

vNthll_zon_w_zav = vNll_w_zav.*thetall_w_zav;
vNthll_ed_w_zav = vNthll_w_zav - vNthll_zon_w_zav;

xi=-179:2:180;yi=-89:2:90;
vNthll_h=cube2latlon(xc,yc,vNth_h_mean,xi,yi);
thetall_h=cube2latlon(xc,yc,theta_h_mean,xi,yi);
vNll_h=cube2latlon(xc,yc,vN_h_mean,xi,yi);
htrtll_h=cube2latlon(xc,yc,htrt_h_vint,xi,yi);
difhtll_h=cube2latlon(xc,yc,difht_h_vint,xi,yi);
radhtll_h=cube2latlon(xc,yc,radht_h_vint,xi,yi);
cnvhtll_h=cube2latlon(xc,yc,cnvht_h_vint,xi,yi);
cndhtll_h=cube2latlon(xc,yc,cndht_h_vint,xi,yi);

vNthll_h_zav(:,:) = mean(vNthll_h,1);
thetall_h_zav(:,:) = mean(thetall_h,1);
vNll_h_zav(:,:) = mean(vNll_h,1);
htrtll_h_zav(:,:) = mean(htrtll_h,1);
difhtll_h_zav(:,:) = mean(difhtll_h,1);
radhtll_h_zav(:,:) = mean(radhtll_h,1);
cnvhtll_h_zav(:,:) = mean(cnvhtll_h,1);
cndhtll_h_zav(:,:) = mean(cndhtll_h,1);

vNthll_zon_h_zav = vNll_h_zav.*thetall_h_zav;
vNthll_ed_h_zav = vNthll_h_zav - vNthll_zon_h_zav;

%weight vtheta by cosphi and differentiate
cosphi = zeros(90,25);
for i=1:90
cosphi(i,:) = cos(yi(i).*pi./180);
end

vNth_w_wt = vNthll_w_zav.*cosphi;
vNth_zon_w_wt = vNthll_zon_w_zav.*cosphi;
vNth_ed_w_wt = vNthll_ed_w_zav.*cosphi;

vNth_h_wt = vNthll_h_zav.*cosphi;
vNth_zon_h_wt = vNthll_zon_h_zav.*cosphi;
vNth_ed_h_wt = vNthll_ed_h_zav.*cosphi;

[moo,vNth_zon_w_conv_s] = gradient(vNth_zon_w_wt,pi./90);
[moo,vNth_zon_h_conv_s] = gradient(vNth_zon_h_wt,pi./90);

[moo,vNth_ed_w_conv_s] = gradient(vNth_ed_w_wt,pi./90);
[moo,vNth_ed_h_conv_s] = gradient(vNth_ed_h_wt,pi./90);

[moo,vNth_w_conv_s] = gradient(vNth_w_wt,pi./90);
[moo,vNth_h_conv_s] = gradient(vNth_h_wt,pi./90);


vNth_w_conv = -1.*vNth_w_conv_s./cosphi./a;
vNth_zon_w_conv = -1.*vNth_zon_w_conv_s./cosphi./a;
vNth_ed_w_conv = -1.*vNth_ed_w_conv_s./cosphi./a;

vNth_h_conv = -1.*vNth_h_conv_s./cosphi./a;
vNth_zon_h_conv = -1.*vNth_zon_h_conv_s./cosphi./a;
vNth_ed_h_conv = -1.*vNth_ed_h_conv_s./cosphi./a;


%vertically integrate vNth conv
vNth_w_vint = intfac.*sum(vNth_w_conv,2);
vNth_h_vint = intfac.*sum(vNth_h_conv,2);

vNth_ed_w_vint = intfac.*sum(vNth_ed_w_conv,2);
vNth_ed_h_vint = intfac.*sum(vNth_ed_h_conv,2);

vNth_zon_w_vint = intfac.*sum(vNth_zon_w_conv,2);
vNth_zon_h_vint = intfac.*sum(vNth_zon_h_conv,2);


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
plot(yi,htrtll_w_zav,'k')
hold on
xlabel('Latitude')
title('1xwv')
plot(yi,-vNth_w_vint,'c')
plot(yi,-vNth_w_vint-htrtll_w_zav','r')
ylim([-150 550])
xlim([-90 90])

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi,htrtll_h_zav,'k')
hold on
xlabel('Latitude')
ylabel('Vertically integrated heating rate, Wm^{-2}')
title('0.5xwv')
plot(yi,-vNth_h_vint,'c')
plot(yi,-vNth_h_vint-htrtll_h_zav','r')
ylim([-150 550])
xlim([-90 90])

print('-dpdf','vertheat_check_sh.pdf')


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
plot(yi,htrtll_w_zav,'k')
hold on
xlabel('Latitude')
title('1xwv')
plot(yi,cndhtll_w_zav+cnvhtll_w_zav)
plot(yi,radhtll_w_zav,'g')
plot(yi,difhtll_w_zav,'r')
%plot(yi,-vNth_w_vint,'c')
plot(yi,-vNth_ed_w_vint,'c')
%plot(yi,-vNth_zon_w_vint,'c--')
ylim([-150 550])
xlim([-90 90])

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi,htrtll_h_zav,'k')
hold on
xlabel('Latitude')
ylabel('Vertically integrated heating rate, Wm^{-2}')
title('0.5xwv')
plot(yi,cndhtll_h_zav+cnvhtll_h_zav)
plot(yi,radhtll_h_zav,'g')
plot(yi,difhtll_h_zav,'r')
%plot(yi,-vNth_h_vint,'c')
plot(yi,-vNth_ed_h_vint,'c')
%plot(yi,-vNth_zon_h_vint,'c--')
ylim([-150 550])
xlim([-90 90])

h=legend('Total Diabatic Heating','Latent Heating','Radiative Heating','Diffusive Heating','v''\theta'' Divergence');
set(h,'Interpreter','latex')
h=legend('Total Diabatic Heating','Latent Heating','Radiative Heating','Diffusive Heating','v''\theta'' Divergence');

print('-dpdf','vertheat_sh.pdf')
