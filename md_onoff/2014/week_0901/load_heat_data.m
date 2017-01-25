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
J=find(strcmp(fldList,'WVEL    '));
w_w(:,:,:,i)=dyn(:,:,:,J);


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
J=find(strcmp(fldList,'WVEL    '));
w_h(:,:,:,i)=dyn(:,:,:,J);


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
J=find(strcmp(fldList,'WVEL    '));
w_q(:,:,:,i)=dyn(:,:,:,J);


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
J=find(strcmp(fldList,'WVEL    '));
w_d(:,:,:,i)=dyn(:,:,:,J);


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearth/';

%heating rates
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_th(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_th(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_th(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_th(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_th(:,:,:,i)=dyn(:,:,:,J);

J=find(strcmp(fldList,'THETA   '));
theta_th(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_th(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_th(:,:,:,i)=dyn(:,:,:,J);
[uE_th(:,:,:,i),vN_th(:,:,:,i)] = rotate_uv2uvEN(ucs_th(:,:,:,i),vcs_th(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'UVELTH  '));
ucsth_th(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vcsth_th(:,:,:,i)=dyn(:,:,:,J);
[uEth_th(:,:,:,i),vNth_th(:,:,:,i)] = rotate_uv2uvEN(ucsth_th(:,:,:,i),vcsth_th(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'WVEL    '));
w_th(:,:,:,i)=dyn(:,:,:,J);


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
w_w_mean = mean(w_w,4);

htrt_h_mean = mean(htrt_h,4);
difht_h_mean = mean(difht_h,4);
radht_h_mean = mean(radht_h,4);
cndht_h_mean = mean(cndht_h,4);
cnvht_h_mean = mean(cnvht_h,4);
vNth_h_mean = mean(vNth_h,4);
vN_h_mean = mean(vN_h,4);
theta_h_mean = mean(theta_h,4);
w_h_mean = mean(w_h,4);

htrt_q_mean = mean(htrt_q,4);
difht_q_mean = mean(difht_q,4);
radht_q_mean = mean(radht_q,4);
cndht_q_mean = mean(cndht_q,4);
cnvht_q_mean = mean(cnvht_q,4);
vNth_q_mean = mean(vNth_q,4);
vN_q_mean = mean(vN_q,4);
theta_q_mean = mean(theta_q,4);
w_q_mean = mean(w_q,4);

htrt_d_mean = mean(htrt_d,4);
difht_d_mean = mean(difht_d,4);
radht_d_mean = mean(radht_d,4);
cndht_d_mean = mean(cndht_d,4);
cnvht_d_mean = mean(cnvht_d,4);
vNth_d_mean = mean(vNth_d,4);
vN_d_mean = mean(vN_d,4);
theta_d_mean = mean(theta_d,4);
w_d_mean = mean(w_d,4);

htrt_th_mean = mean(htrt_th,4);
difht_th_mean = mean(difht_th,4);
radht_th_mean = mean(radht_th,4);
cndht_th_mean = mean(cndht_th,4);
cnvht_th_mean = mean(cnvht_th,4);
vNth_th_mean = mean(vNth_th,4);
vN_th_mean = mean(vN_th,4);
theta_th_mean = mean(theta_th,4);
w_th_mean = mean(w_th,4);

%put on lat lon grid and zonally average
xi=-179:2:180;yi=-89:2:90;
vNthll_w=cube2latlon(xc,yc,vNth_w_mean,xi,yi);
wll_w=cube2latlon(xc,yc,w_w_mean,xi,yi);
thetall_w=cube2latlon(xc,yc,theta_w_mean,xi,yi);
vNll_w=cube2latlon(xc,yc,vN_w_mean,xi,yi);
htrtll_w=cube2latlon(xc,yc,htrt_w_mean,xi,yi);
difhtll_w=cube2latlon(xc,yc,difht_w_mean,xi,yi);
radhtll_w=cube2latlon(xc,yc,radht_w_mean,xi,yi);
cnvhtll_w=cube2latlon(xc,yc,cnvht_w_mean,xi,yi);
cndhtll_w=cube2latlon(xc,yc,cndht_w_mean,xi,yi);

vNthll_w_zav(:,:) = mean(vNthll_w,1);
wll_w_zav(:,:) = mean(wll_w,1);
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
wll_h=cube2latlon(xc,yc,w_h_mean,xi,yi);
thetall_h=cube2latlon(xc,yc,theta_h_mean,xi,yi);
vNll_h=cube2latlon(xc,yc,vN_h_mean,xi,yi);
htrtll_h=cube2latlon(xc,yc,htrt_h_mean,xi,yi);
difhtll_h=cube2latlon(xc,yc,difht_h_mean,xi,yi);
radhtll_h=cube2latlon(xc,yc,radht_h_mean,xi,yi);
cnvhtll_h=cube2latlon(xc,yc,cnvht_h_mean,xi,yi);
cndhtll_h=cube2latlon(xc,yc,cndht_h_mean,xi,yi);

vNthll_h_zav(:,:) = mean(vNthll_h,1);
wll_h_zav(:,:) = mean(wll_h,1);
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
wll_q=cube2latlon(xc,yc,w_q_mean,xi,yi);
thetall_q=cube2latlon(xc,yc,theta_q_mean,xi,yi);
vNll_q=cube2latlon(xc,yc,vN_q_mean,xi,yi);
htrtll_q=cube2latlon(xc,yc,htrt_q_mean,xi,yi);
difhtll_q=cube2latlon(xc,yc,difht_q_mean,xi,yi);
radhtll_q=cube2latlon(xc,yc,radht_q_mean,xi,yi);
cnvhtll_q=cube2latlon(xc,yc,cnvht_q_mean,xi,yi);
cndhtll_q=cube2latlon(xc,yc,cndht_q_mean,xi,yi);

vNthll_q_zav(:,:) = mean(vNthll_q,1);
wll_q_zav(:,:) = mean(wll_q,1);
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
wll_d=cube2latlon(xc,yc,w_d_mean,xi,yi);
thetall_d=cube2latlon(xc,yc,theta_d_mean,xi,yi);
vNll_d=cube2latlon(xc,yc,vN_d_mean,xi,yi);
htrtll_d=cube2latlon(xc,yc,htrt_d_mean,xi,yi);
difhtll_d=cube2latlon(xc,yc,difht_d_mean,xi,yi);
radhtll_d=cube2latlon(xc,yc,radht_d_mean,xi,yi);
cnvhtll_d=cube2latlon(xc,yc,cnvht_d_mean,xi,yi);
cndhtll_d=cube2latlon(xc,yc,cndht_d_mean,xi,yi);

vNthll_d_zav(:,:) = mean(vNthll_d,1);
wll_d_zav(:,:) = mean(wll_d,1);
thetall_d_zav(:,:) = mean(thetall_d,1);
vNll_d_zav(:,:) = mean(vNll_d,1);
htrtll_d_zav(:,:) = mean(htrtll_d,1);
difhtll_d_zav(:,:) = mean(difhtll_d,1);
radhtll_d_zav(:,:) = mean(radhtll_d,1);
cnvhtll_d_zav(:,:) = mean(cnvhtll_d,1);
cndhtll_d_zav(:,:) = mean(cndhtll_d,1);

vNthll_zon_d_zav = vNll_d_zav.*thetall_d_zav;
vNthll_ed_d_zav = vNthll_d_zav - vNthll_zon_d_zav;

xi=-179:2:180;yi=-89:2:90;
vNthll_th=cube2latlon(xc,yc,vNth_th_mean,xi,yi);
wll_th=cube2latlon(xc,yc,w_th_mean,xi,yi);
thetall_th=cube2latlon(xc,yc,theta_th_mean,xi,yi);
vNll_th=cube2latlon(xc,yc,vN_th_mean,xi,yi);
htrtll_th=cube2latlon(xc,yc,htrt_th_mean,xi,yi);
difhtll_th=cube2latlon(xc,yc,difht_th_mean,xi,yi);
radhtll_th=cube2latlon(xc,yc,radht_th_mean,xi,yi);
cnvhtll_th=cube2latlon(xc,yc,cnvht_th_mean,xi,yi);
cndhtll_th=cube2latlon(xc,yc,cndht_th_mean,xi,yi);

vNthll_th_zav(:,:) = mean(vNthll_th,1);
wll_th_zav(:,:) = mean(wll_th,1);
thetall_th_zav(:,:) = mean(thetall_th,1);
vNll_th_zav(:,:) = mean(vNll_th,1);
htrtll_th_zav(:,:) = mean(htrtll_th,1);
difhtll_th_zav(:,:) = mean(difhtll_th,1);
radhtll_th_zav(:,:) = mean(radhtll_th,1);
cnvhtll_th_zav(:,:) = mean(cnvhtll_th,1);
cndhtll_th_zav(:,:) = mean(cndhtll_th,1);

vNthll_zon_th_zav = vNll_th_zav.*thetall_th_zav;
vNthll_ed_th_zav = vNthll_th_zav - vNthll_zon_th_zav;

g=9.81;
cp=1004.64;
intfac = 4000.*cp./g;
a=6371.0e3;
convthetatoT=(rC/101325.0).^(2./7.);

for j=1:25
t_w(:,j)  = thetall_w_zav(:,j).*convthetatoT(j,1);
t_h(:,j)  = thetall_h_zav(:,j).*convthetatoT(j,1);
t_q(:,j)  = thetall_q_zav(:,j).*convthetatoT(j,1);
t_d(:,j)  = thetall_d_zav(:,j).*convthetatoT(j,1);
t_th(:,j) = thetall_th_zav(:,j).*convthetatoT(j,1);
end


%weight vtheta by cosphi and differentiate
cosphi = zeros(90,25);
for i=1:90
cosphi(i,:) = cos(yi(i).*pi./180);
end

%calculate eddy term

vNth_ed_w_wt = vNthll_ed_w_zav.*cosphi;
vNth_ed_h_wt = vNthll_ed_h_zav.*cosphi;
vNth_ed_q_wt = vNthll_ed_q_zav.*cosphi;
vNth_ed_d_wt = vNthll_ed_d_zav.*cosphi;
vNth_ed_th_wt = vNthll_ed_th_zav.*cosphi;

[moo,vNth_ed_w_conv_s] = gradient(vNth_ed_w_wt,pi./90);
[moo,vNth_ed_h_conv_s] = gradient(vNth_ed_h_wt,pi./90);
[moo,vNth_ed_q_conv_s] = gradient(vNth_ed_q_wt,pi./90);
[moo,vNth_ed_d_conv_s] = gradient(vNth_ed_d_wt,pi./90);
[moo,vNth_ed_th_conv_s] = gradient(vNth_ed_th_wt,pi./90);

vNth_ed_w_conv = vNth_ed_w_conv_s./cosphi./a;
vNth_ed_h_conv = vNth_ed_h_conv_s./cosphi./a;
vNth_ed_q_conv = vNth_ed_q_conv_s./cosphi./a;
vNth_ed_d_conv = vNth_ed_d_conv_s./cosphi./a;
vNth_ed_th_conv = vNth_ed_th_conv_s./cosphi./a;

%lapse rate

dthetadp_w = gradient(thetall_w_zav,-4000);
dthetadp_h = gradient(thetall_h_zav,-4000);
dthetadp_q = gradient(thetall_q_zav,-4000);
dthetadp_d = gradient(thetall_d_zav,-4000);
dthetadp_th = gradient(thetall_th_zav,-4000);

[moo,dthetady_w] = gradient(thetall_w_zav,pi./90);
[moo,dthetady_h] = gradient(thetall_h_zav,pi./90);
[moo,dthetady_q] = gradient(thetall_q_zav,pi./90);
[moo,dthetady_d] = gradient(thetall_d_zav,pi./90);
[moo,dthetady_th] = gradient(thetall_th_zav,pi./90);

dthetady_w = dthetady_w./a;
dthetady_h = dthetady_h./a;
dthetady_q = dthetady_q./a;
dthetady_d = dthetady_d./a;
dthetady_th = dthetady_th./a;

%zonal transport

vdthetady_w = dthetady_w .* vNll_w_zav;
vdthetady_h = dthetady_h .* vNll_h_zav;
vdthetady_q = dthetady_q .* vNll_q_zav;
vdthetady_d = dthetady_d .* vNll_d_zav;
vdthetady_th = dthetady_th .* vNll_th_zav;

%vertical transport

wdthetadp_w = dthetadp_w .* wll_w_zav;
wdthetadp_h = dthetadp_h .* wll_h_zav;
wdthetadp_q = dthetadp_q .* wll_q_zav;
wdthetadp_d = dthetadp_d .* wll_d_zav;
wdthetadp_th = dthetadp_th .* wll_th_zav;



%%%%%%%%%%%%%%%%%%%%%%%%%% Wet psi  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
deltap = 4000;

integrand = zeros(size(vNll_w_zav));
cosphi = zeros(90,25);
for k=1:25
cosphi(:,k) = cos(yi.*pi./180);
end
integrand = 2.*pi.*a.*vNll_w_zav.*cosphi./g;
psi_w = flipdim(cumsum(flipdim(integrand,2).*deltap,2),2);


%%%%%%%%%%%%%%%%%%%%%%%%%% Half WV psi  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

integrand = zeros(size(vNll_h_zav));
cosphi = zeros(90,25);
for k=1:25
cosphi(:,k) = cos(yi.*pi./180);
end
integrand = 2.*pi.*a.*vNll_h_zav.*cosphi./g;
psi_h = flipdim(cumsum(flipdim(integrand,2).*deltap,2),2);

%%%%%%%%%%%%%%%%%%%%%%%%%% Quarter WV psi  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

integrand = zeros(size(vNll_q_zav));
cosphi = zeros(90,25);
for k=1:25
cosphi(:,k) = cos(yi.*pi./180);
end
integrand = 2.*pi.*a.*vNll_q_zav.*cosphi./g;
psi_q = flipdim(cumsum(flipdim(integrand,2).*deltap,2),2);

%%%%%%%%%%%%%%%%%%%%%%%%%% Dry psi  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

integrand = zeros(size(vNll_d_zav));
cosphi = zeros(90,25);
for k=1:25
cosphi(:,k) = cos(yi.*pi./180);
end
integrand = 2.*pi.*a.*vNll_d_zav.*cosphi./g;
psi_d = flipdim(cumsum(flipdim(integrand,2).*deltap,2),2);

%%%%%%%%%%%%%%%%%%%%%%%%%% Tropheat psi  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

integrand = zeros(size(vNll_th_zav));
cosphi = zeros(90,25);
for k=1:25
cosphi(:,k) = cos(yi.*pi./180);
end
integrand = 2.*pi.*a.*vNll_th_zav.*cosphi./g;
psi_th = flipdim(cumsum(flipdim(integrand,2).*deltap,2),2);


%take hemispheric averages
for i = 1:45

dvNthdy_ed_w_hzav(i,:) = (vNth_ed_w_conv(46-i,:) + vNth_ed_w_conv(45+i,:))./2;
dvNthdy_ed_h_hzav(i,:) = (vNth_ed_h_conv(46-i,:) + vNth_ed_h_conv(45+i,:))./2;
dvNthdy_ed_q_hzav(i,:) = (vNth_ed_q_conv(46-i,:) + vNth_ed_q_conv(45+i,:))./2;
dvNthdy_ed_d_hzav(i,:) = (vNth_ed_d_conv(46-i,:) + vNth_ed_d_conv(45+i,:))./2;
dvNthdy_ed_th_hzav(i,:) = (vNth_ed_th_conv(46-i,:) + vNth_ed_th_conv(45+i,:))./2;

wdthetadp_w_hzav(i,:) = (wdthetadp_w(46-i,:) + wdthetadp_w(45+i,:))./2;
wdthetadp_h_hzav(i,:) = (wdthetadp_h(46-i,:) + wdthetadp_h(45+i,:))./2;
wdthetadp_q_hzav(i,:) = (wdthetadp_q(46-i,:) + wdthetadp_q(45+i,:))./2;
wdthetadp_d_hzav(i,:) = (wdthetadp_d(46-i,:) + wdthetadp_d(45+i,:))./2;
wdthetadp_th_hzav(i,:) = (wdthetadp_th(46-i,:) + wdthetadp_th(45+i,:))./2;

vdthetady_w_hzav(i,:) = (vdthetady_w(46-i,:) + vdthetady_w(45+i,:))./2;
vdthetady_h_hzav(i,:) = (vdthetady_h(46-i,:) + vdthetady_h(45+i,:))./2;
vdthetady_q_hzav(i,:) = (vdthetady_q(46-i,:) + vdthetady_q(45+i,:))./2;
vdthetady_d_hzav(i,:) = (vdthetady_d(46-i,:) + vdthetady_d(45+i,:))./2;
vdthetady_th_hzav(i,:) = (vdthetady_th(46-i,:) + vdthetady_th(45+i,:))./2;

htrtll_w_hzav(i,:) = (htrtll_w_zav(46-i,:) + htrtll_w_zav(45+i,:))./2;
htrtll_h_hzav(i,:) = (htrtll_h_zav(46-i,:) + htrtll_h_zav(45+i,:))./2;
htrtll_q_hzav(i,:) = (htrtll_q_zav(46-i,:) + htrtll_q_zav(45+i,:))./2;
htrtll_d_hzav(i,:) = (htrtll_d_zav(46-i,:) + htrtll_d_zav(45+i,:))./2;
htrtll_th_hzav(i,:) = (htrtll_th_zav(46-i,:) + htrtll_th_zav(45+i,:))./2;

difhtll_w_hzav(i,:) = (difhtll_w_zav(46-i,:) + difhtll_w_zav(45+i,:))./2;
difhtll_h_hzav(i,:) = (difhtll_h_zav(46-i,:) + difhtll_h_zav(45+i,:))./2;
difhtll_q_hzav(i,:) = (difhtll_q_zav(46-i,:) + difhtll_q_zav(45+i,:))./2;
difhtll_d_hzav(i,:) = (difhtll_d_zav(46-i,:) + difhtll_d_zav(45+i,:))./2;
difhtll_th_hzav(i,:) = (difhtll_th_zav(46-i,:) + difhtll_th_zav(45+i,:))./2;

radhtll_w_hzav(i,:) = (radhtll_w_zav(46-i,:) + radhtll_w_zav(45+i,:))./2;
radhtll_h_hzav(i,:) = (radhtll_h_zav(46-i,:) + radhtll_h_zav(45+i,:))./2;
radhtll_q_hzav(i,:) = (radhtll_q_zav(46-i,:) + radhtll_q_zav(45+i,:))./2;
radhtll_d_hzav(i,:) = (radhtll_d_zav(46-i,:) + radhtll_d_zav(45+i,:))./2;
radhtll_th_hzav(i,:) = (radhtll_th_zav(46-i,:) + radhtll_th_zav(45+i,:))./2;

cnvhtll_w_hzav(i,:) = (cnvhtll_w_zav(46-i,:) + cnvhtll_w_zav(45+i,:))./2;
cnvhtll_h_hzav(i,:) = (cnvhtll_h_zav(46-i,:) + cnvhtll_h_zav(45+i,:))./2;
cnvhtll_q_hzav(i,:) = (cnvhtll_q_zav(46-i,:) + cnvhtll_q_zav(45+i,:))./2;
cnvhtll_d_hzav(i,:) = (cnvhtll_d_zav(46-i,:) + cnvhtll_d_zav(45+i,:))./2;
cnvhtll_th_hzav(i,:) = (cnvhtll_th_zav(46-i,:) + cnvhtll_th_zav(45+i,:))./2;

cndhtll_w_hzav(i,:) = (cndhtll_w_zav(46-i,:) + cndhtll_w_zav(45+i,:))./2;
cndhtll_h_hzav(i,:) = (cndhtll_h_zav(46-i,:) + cndhtll_h_zav(45+i,:))./2;
cndhtll_q_hzav(i,:) = (cndhtll_q_zav(46-i,:) + cndhtll_q_zav(45+i,:))./2;
cndhtll_d_hzav(i,:) = (cndhtll_d_zav(46-i,:) + cndhtll_d_zav(45+i,:))./2;
cndhtll_th_hzav(i,:) = (cndhtll_th_zav(46-i,:) + cndhtll_th_zav(45+i,:))./2;

thetall_w_hzav(i,:) = (thetall_w_zav(46-i,:) + thetall_w_zav(45+i,:))./2;
thetall_h_hzav(i,:) = (thetall_h_zav(46-i,:) + thetall_h_zav(45+i,:))./2;
thetall_q_hzav(i,:) = (thetall_q_zav(46-i,:) + thetall_q_zav(45+i,:))./2;
thetall_d_hzav(i,:) = (thetall_d_zav(46-i,:) + thetall_d_zav(45+i,:))./2;
thetall_th_hzav(i,:) = (thetall_th_zav(46-i,:) + thetall_th_zav(45+i,:))./2;

t_w_hzav(i,:) = (t_w(46-i,:) + t_w(45+i,:))./2;
t_h_hzav(i,:) = (t_h(46-i,:) + t_h(45+i,:))./2;
t_q_hzav(i,:) = (t_q(46-i,:) + t_q(45+i,:))./2;
t_d_hzav(i,:) = (t_d(46-i,:) + t_d(45+i,:))./2;
t_th_hzav(i,:) = (t_th(46-i,:) + t_th(45+i,:))./2;

psi_w_hzav(i,:) = (-psi_w(46-i,:) + psi_w(45+i,:))./2;
psi_h_hzav(i,:) = (-psi_h(46-i,:) + psi_h(45+i,:))./2;
psi_q_hzav(i,:) = (-psi_q(46-i,:) + psi_q(45+i,:))./2;
psi_d_hzav(i,:) = (-psi_d(46-i,:) + psi_d(45+i,:))./2;
psi_th_hzav(i,:) = (-psi_th(46-i,:) + psi_th(45+i,:))./2;

dthetadp_w_hzav(i,:) = (dthetadp_w(46-i,:) + dthetadp_w(45+i,:))./2;
dthetadp_h_hzav(i,:) = (dthetadp_h(46-i,:) + dthetadp_h(45+i,:))./2;
dthetadp_q_hzav(i,:) = (dthetadp_q(46-i,:) + dthetadp_q(45+i,:))./2;
dthetadp_d_hzav(i,:) = (dthetadp_d(46-i,:) + dthetadp_d(45+i,:))./2;
dthetadp_th_hzav(i,:) = (dthetadp_th(46-i,:) + dthetadp_th(45+i,:))./2;


end


save('heat_budg_vars.mat', 'dvNthdy_ed_w_hzav', 'wdthetadp_w_hzav', 'vdthetady_w_hzav', 'htrtll_w_hzav', 'difhtll_w_hzav', 'radhtll_w_hzav', 'cnvhtll_w_hzav', 'cndhtll_w_hzav', 'thetall_w_hzav', 't_w_hzav', 'psi_w_hzav', 'dvNthdy_ed_h_hzav', 'wdthetadp_h_hzav', 'vdthetady_h_hzav', 'htrtll_h_hzav', 'difhtll_h_hzav', 'radhtll_h_hzav', 'cnvhtll_h_hzav', 'cndhtll_h_hzav', 'thetall_h_hzav', 't_h_hzav', 'psi_h_hzav', 'dvNthdy_ed_q_hzav', 'wdthetadp_q_hzav', 'vdthetady_q_hzav', 'htrtll_q_hzav', 'difhtll_q_hzav', 'radhtll_q_hzav', 'cnvhtll_q_hzav', 'cndhtll_q_hzav', 'thetall_q_hzav', 't_q_hzav', 'psi_q_hzav', 'dvNthdy_ed_d_hzav', 'wdthetadp_d_hzav', 'vdthetady_d_hzav', 'htrtll_d_hzav', 'difhtll_d_hzav', 'radhtll_d_hzav', 'cnvhtll_d_hzav', 'cndhtll_d_hzav', 'thetall_d_hzav', 't_d_hzav', 'psi_d_hzav', 'dvNthdy_ed_th_hzav', 'wdthetadp_th_hzav', 'vdthetady_th_hzav', 'htrtll_th_hzav', 'difhtll_th_hzav', 'radhtll_th_hzav', 'cnvhtll_th_hzav', 'cndhtll_th_hzav', 'thetall_th_hzav', 't_th_hzav', 'psi_th_hzav')

save('lapse_rates.mat','dthetadp_w_hzav','dthetadp_h_hzav','dthetadp_q_hzav','dthetadp_d_hzav','dthetadp_th_hzav')
