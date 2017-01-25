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
J=find(strcmp(fldList,'WVELTH  '));
wth_w(:,:,:,i)=dyn(:,:,:,J);

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
J=find(strcmp(fldList,'WVELTH  '));
wth_h(:,:,:,i)=dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearq/';

%heating rates
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);


J=find(strcmp(fldList,'AtPhdTdt'));
htrt_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_q(:,:,:,i)=dyn(:,:,:,J);

J=find(strcmp(fldList,'THETA   '));
theta_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_q(:,:,:,i)=dyn(:,:,:,J);
[uE_q(:,:,:,i),vN_q(:,:,:,i)] = rotate_uv2uvEN(ucs_q(:,:,:,i),vcs_q(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'UVELTH  '));
ucsth_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vcsth_q(:,:,:,i)=dyn(:,:,:,J);
[uEth_q(:,:,:,i),vNth_q(:,:,:,i)] = rotate_uv2uvEN(ucsth_q(:,:,:,i),vcsth_q(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'WVELTH  '));
wth_q(:,:,:,i)=dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yeard/';

%heating rates
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);


J=find(strcmp(fldList,'AtPhdTdt'));
htrt_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_d(:,:,:,i)=dyn(:,:,:,J);

J=find(strcmp(fldList,'THETA   '));
theta_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_d(:,:,:,i)=dyn(:,:,:,J);
[uE_d(:,:,:,i),vN_d(:,:,:,i)] = rotate_uv2uvEN(ucs_d(:,:,:,i),vcs_d(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'UVELTH  '));
ucsth_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vcsth_d(:,:,:,i)=dyn(:,:,:,J);
[uEth_d(:,:,:,i),vNth_d(:,:,:,i)] = rotate_uv2uvEN(ucsth_d(:,:,:,i),vcsth_d(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'WVELTH  '));
wth_d(:,:,:,i)=dyn(:,:,:,J);

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
wth_w_mean = mean(wth_w,4);

htrt_h_mean = mean(htrt_h,4);
difht_h_mean = mean(difht_h,4);
radht_h_mean = mean(radht_h,4);
cndht_h_mean = mean(cndht_h,4);
cnvht_h_mean = mean(cnvht_h,4);
vNth_h_mean = mean(vNth_h,4);
vN_h_mean = mean(vN_h,4);
theta_h_mean = mean(theta_h,4);
wth_h_mean = mean(wth_h,4);

htrt_q_mean = mean(htrt_q,4);
difht_q_mean = mean(difht_q,4);
radht_q_mean = mean(radht_q,4);
cndht_q_mean = mean(cndht_q,4);
cnvht_q_mean = mean(cnvht_q,4);
vNth_q_mean = mean(vNth_q,4);
vN_q_mean = mean(vN_q,4);
theta_q_mean = mean(theta_q,4);
wth_q_mean = mean(wth_q,4);

htrt_d_mean = mean(htrt_d,4);
difht_d_mean = mean(difht_d,4);
radht_d_mean = mean(radht_d,4);
cndht_d_mean = mean(cndht_d,4);
cnvht_d_mean = mean(cnvht_d,4);
vNth_d_mean = mean(vNth_d,4);
vN_d_mean = mean(vN_d,4);
theta_d_mean = mean(theta_d,4);
wth_d_mean = mean(wth_d,4);

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

htrt_q_vint = sum(htrt_q_mean,3).*intfac;
difht_q_vint = sum(difht_q_mean,3).*intfac;
radht_q_vint = sum(radht_q_mean,3).*intfac;
cndht_q_vint = sum(cndht_q_mean,3).*intfac;
cnvht_q_vint = sum(cnvht_q_mean,3).*intfac;

htrt_d_vint = sum(htrt_d_mean,3).*intfac;
difht_d_vint = sum(difht_d_mean,3).*intfac;
radht_d_vint = sum(radht_d_mean,3).*intfac;
cndht_d_vint = sum(cndht_d_mean,3).*intfac;
cnvht_d_vint = sum(cnvht_d_mean,3).*intfac;

%put on lat lon grid and zonally average
xi=-179:2:180;yi=-89:2:90;
vNthll_w=cube2latlon(xc,yc,vNth_w_mean,xi,yi);
wthll_w=cube2latlon(xc,yc,wth_w_mean,xi,yi);
thetall_w=cube2latlon(xc,yc,theta_w_mean,xi,yi);
vNll_w=cube2latlon(xc,yc,vN_w_mean,xi,yi);
htrtll_w=cube2latlon(xc,yc,htrt_w_vint,xi,yi);
difhtll_w=cube2latlon(xc,yc,difht_w_vint,xi,yi);
radhtll_w=cube2latlon(xc,yc,radht_w_vint,xi,yi);
cnvhtll_w=cube2latlon(xc,yc,cnvht_w_vint,xi,yi);
cndhtll_w=cube2latlon(xc,yc,cndht_w_vint,xi,yi);

vNthll_w_zav(:,:) = mean(vNthll_w,1);
wthll_w_zav(:,:) = mean(wthll_w,1);
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
wthll_h=cube2latlon(xc,yc,wth_h_mean,xi,yi);
thetall_h=cube2latlon(xc,yc,theta_h_mean,xi,yi);
vNll_h=cube2latlon(xc,yc,vN_h_mean,xi,yi);
htrtll_h=cube2latlon(xc,yc,htrt_h_vint,xi,yi);
difhtll_h=cube2latlon(xc,yc,difht_h_vint,xi,yi);
radhtll_h=cube2latlon(xc,yc,radht_h_vint,xi,yi);
cnvhtll_h=cube2latlon(xc,yc,cnvht_h_vint,xi,yi);
cndhtll_h=cube2latlon(xc,yc,cndht_h_vint,xi,yi);

vNthll_h_zav(:,:) = mean(vNthll_h,1);
wthll_h_zav(:,:) = mean(wthll_h,1);
thetall_h_zav(:,:) = mean(thetall_h,1);
vNll_h_zav(:,:) = mean(vNll_h,1);
htrtll_h_zav(:,:) = mean(htrtll_h,1);
difhtll_h_zav(:,:) = mean(difhtll_h,1);
radhtll_h_zav(:,:) = mean(radhtll_h,1);
cnvhtll_h_zav(:,:) = mean(cnvhtll_h,1);
cndhtll_h_zav(:,:) = mean(cndhtll_h,1);

vNthll_zon_h_zav = vNll_h_zav.*thetall_h_zav;
vNthll_ed_h_zav = vNthll_h_zav - vNthll_zon_h_zav;

xi=-179:2:180;yi=-89:2:90;
vNthll_q=cube2latlon(xc,yc,vNth_q_mean,xi,yi);
wthll_q=cube2latlon(xc,yc,wth_q_mean,xi,yi);
thetall_q=cube2latlon(xc,yc,theta_q_mean,xi,yi);
vNll_q=cube2latlon(xc,yc,vN_q_mean,xi,yi);
htrtll_q=cube2latlon(xc,yc,htrt_q_vint,xi,yi);
difhtll_q=cube2latlon(xc,yc,difht_q_vint,xi,yi);
radhtll_q=cube2latlon(xc,yc,radht_q_vint,xi,yi);
cnvhtll_q=cube2latlon(xc,yc,cnvht_q_vint,xi,yi);
cndhtll_q=cube2latlon(xc,yc,cndht_q_vint,xi,yi);

vNthll_q_zav(:,:) = mean(vNthll_q,1);
wthll_q_zav(:,:) = mean(wthll_q,1);
thetall_q_zav(:,:) = mean(thetall_q,1);
vNll_q_zav(:,:) = mean(vNll_q,1);
htrtll_q_zav(:,:) = mean(htrtll_q,1);
difhtll_q_zav(:,:) = mean(difhtll_q,1);
radhtll_q_zav(:,:) = mean(radhtll_q,1);
cnvhtll_q_zav(:,:) = mean(cnvhtll_q,1);
cndhtll_q_zav(:,:) = mean(cndhtll_q,1);

vNthll_zon_q_zav = vNll_q_zav.*thetall_q_zav;
vNthll_ed_q_zav = vNthll_q_zav - vNthll_zon_q_zav;

xi=-179:2:180;yi=-89:2:90;
vNthll_d=cube2latlon(xc,yc,vNth_d_mean,xi,yi);
wthll_d=cube2latlon(xc,yc,wth_d_mean,xi,yi);
thetall_d=cube2latlon(xc,yc,theta_d_mean,xi,yi);
vNll_d=cube2latlon(xc,yc,vN_d_mean,xi,yi);
htrtll_d=cube2latlon(xc,yc,htrt_d_vint,xi,yi);
difhtll_d=cube2latlon(xc,yc,difht_d_vint,xi,yi);
radhtll_d=cube2latlon(xc,yc,radht_d_vint,xi,yi);
cnvhtll_d=cube2latlon(xc,yc,cnvht_d_vint,xi,yi);
cndhtll_d=cube2latlon(xc,yc,cndht_d_vint,xi,yi);

vNthll_d_zav(:,:) = mean(vNthll_d,1);
wthll_d_zav(:,:) = mean(wthll_d,1);
thetall_d_zav(:,:) = mean(thetall_d,1);
vNll_d_zav(:,:) = mean(vNll_d,1);
htrtll_d_zav(:,:) = mean(htrtll_d,1);
difhtll_d_zav(:,:) = mean(difhtll_d,1);
radhtll_d_zav(:,:) = mean(radhtll_d,1);
cnvhtll_d_zav(:,:) = mean(cnvhtll_d,1);
cndhtll_d_zav(:,:) = mean(cndhtll_d,1);

vNthll_zon_d_zav = vNll_d_zav.*thetall_d_zav;
vNthll_ed_d_zav = vNthll_d_zav - vNthll_zon_d_zav;

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

vNth_q_wt = vNthll_q_zav.*cosphi;
vNth_zon_q_wt = vNthll_zon_q_zav.*cosphi;
vNth_ed_q_wt = vNthll_ed_q_zav.*cosphi;

vNth_d_wt = vNthll_d_zav.*cosphi;
vNth_zon_d_wt = vNthll_zon_d_zav.*cosphi;
vNth_ed_d_wt = vNthll_ed_d_zav.*cosphi;

delwth_w = (wthll_w_zav(:,1) - wthll_w_zav(:,25)).*cp./g;
delwth_h = (wthll_h_zav(:,1) - wthll_h_zav(:,25)).*cp./g;
delwth_q = (wthll_q_zav(:,1) - wthll_q_zav(:,25)).*cp./g;
delwth_d = (wthll_d_zav(:,1) - wthll_d_zav(:,25)).*cp./g;


[moo,vNth_zon_w_conv_s] = gradient(vNth_zon_w_wt,pi./90);
[moo,vNth_zon_h_conv_s] = gradient(vNth_zon_h_wt,pi./90);
[moo,vNth_zon_q_conv_s] = gradient(vNth_zon_q_wt,pi./90);
[moo,vNth_zon_d_conv_s] = gradient(vNth_zon_d_wt,pi./90);

[moo,vNth_ed_w_conv_s] = gradient(vNth_ed_w_wt,pi./90);
[moo,vNth_ed_h_conv_s] = gradient(vNth_ed_h_wt,pi./90);
[moo,vNth_ed_q_conv_s] = gradient(vNth_ed_q_wt,pi./90);
[moo,vNth_ed_d_conv_s] = gradient(vNth_ed_d_wt,pi./90);

[moo,vNth_w_conv_s] = gradient(vNth_w_wt,pi./90);
[moo,vNth_h_conv_s] = gradient(vNth_h_wt,pi./90);
[moo,vNth_q_conv_s] = gradient(vNth_q_wt,pi./90);
[moo,vNth_d_conv_s] = gradient(vNth_d_wt,pi./90);

vNth_w_conv = -1.*vNth_w_conv_s./cosphi./a;
vNth_zon_w_conv = -1.*vNth_zon_w_conv_s./cosphi./a;
vNth_ed_w_conv = -1.*vNth_ed_w_conv_s./cosphi./a;

vNth_h_conv = -1.*vNth_h_conv_s./cosphi./a;
vNth_zon_h_conv = -1.*vNth_zon_h_conv_s./cosphi./a;
vNth_ed_h_conv = -1.*vNth_ed_h_conv_s./cosphi./a;

vNth_q_conv = -1.*vNth_q_conv_s./cosphi./a;
vNth_zon_q_conv = -1.*vNth_zon_q_conv_s./cosphi./a;
vNth_ed_q_conv = -1.*vNth_ed_q_conv_s./cosphi./a;

vNth_d_conv = -1.*vNth_d_conv_s./cosphi./a;
vNth_zon_d_conv = -1.*vNth_zon_d_conv_s./cosphi./a;
vNth_ed_d_conv = -1.*vNth_ed_d_conv_s./cosphi./a;


%vertically integrate vNth conv
vNth_w_vint = intfac.*sum(vNth_w_conv,2);
vNth_h_vint = intfac.*sum(vNth_h_conv,2);
vNth_q_vint = intfac.*sum(vNth_q_conv,2);
vNth_d_vint = intfac.*sum(vNth_d_conv,2);

vNth_ed_w_vint = intfac.*sum(vNth_ed_w_conv,2);
vNth_ed_h_vint = intfac.*sum(vNth_ed_h_conv,2);
vNth_ed_q_vint = intfac.*sum(vNth_ed_q_conv,2);
vNth_ed_d_vint = intfac.*sum(vNth_ed_d_conv,2);

vNth_zon_w_vint = intfac.*sum(vNth_zon_w_conv,2);
vNth_zon_h_vint = intfac.*sum(vNth_zon_h_conv,2);
vNth_zon_q_vint = intfac.*sum(vNth_zon_q_conv,2);
vNth_zon_d_vint = intfac.*sum(vNth_zon_d_conv,2);

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
%plot(yi,-delwth_w,'g')
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

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi,htrtll_q_zav,'k')
hold on
title('0.25xwv')
plot(yi,-vNth_q_vint,'c')
plot(yi,-vNth_q_vint-htrtll_q_zav','r')
ylim([-150 550])
xlim([-90 90])

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi,htrtll_d_zav,'k')
hold on
ylabel('Vertically integrated heating rate, Wm^{-2}')
title('0xwv')
plot(yi,-vNth_d_vint,'c')
plot(yi,-vNth_d_vint-htrtll_d_zav','r')
ylim([-150 550])
xlim([-90 90])

print('-dpdf','vertheat_check.pdf')


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
%plot(yi,-vNth_ed_w_vint,'c')
%plot(yi,-vNth_zon_w_vint,'c--')
ylim([-150 450])
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
%plot(yi,-vNth_ed_h_vint,'c')
%plot(yi,-vNth_zon_h_vint,'c--')
ylim([-150 450])
xlim([-90 90])

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi,htrtll_q_zav,'k')
hold on
title('0.25xwv')
plot(yi,cndhtll_q_zav+cnvhtll_q_zav)
plot(yi,radhtll_q_zav,'g')
plot(yi,difhtll_q_zav,'r')
%plot(yi,-vNth_q_vint,'c')
%plot(yi,-vNth_ed_q_vint,'c')
%plot(yi,-vNth_zon_q_vint,'c--')
ylim([-150 450])
xlim([-90 90])

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi,htrtll_d_zav,'k')
hold on
ylabel('Vertically integrated heating rate, Wm^{-2}')
title('0xwv')
plot(yi,cndhtll_d_zav+cnvhtll_d_zav)
plot(yi,radhtll_d_zav,'g')
plot(yi,difhtll_d_zav,'r')
%plot(yi,-vNth_d_vint,'c')
%plot(yi,-vNth_ed_d_vint,'c')
%plot(yi,-vNth_zon_d_vint,'c--')
ylim([-150 450])
xlim([-90 90])
h=legend('Q_{diabatic}','Q_{latent}','Q_{radiative}','Q_{sensible}'); %,'v''\theta'' Divergence');
%set(h,'Interpreter','latex')
%h=legend('Total Diabatic Heating','Latent Heating','Radiative Heating','Diffusive Heating'); %,'v''\theta'' Divergence');

print('-dpdf','vertheat.pdf')
