%check heat budget to see if
%a) in subsiding branch Q~const for all runs
%b) is eddy term small here?


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



%have a go at defining volume of grid in m3....
g=9.81;
convthetatoT=(rC/101325.0).^(2./7.);
rd = 287;

for j=1:25
t_w(:,:,j)=theta_w(:,:,j).*convthetatoT(j,1);
t_h(:,:,j)=theta_h(:,:,j).*convthetatoT(j,1);
t_q(:,:,j)=theta_q(:,:,j).*convthetatoT(j,1);
t_d(:,:,j)=theta_d(:,:,j).*convthetatoT(j,1);
t_th(:,:,j)=theta_th(:,:,j).*convthetatoT(j,1);
end

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

%weight vtheta by cosphi and differentiate
cosphi = zeros(90,25);
for i=1:90
cosphi(i,:) = cos(yi(i).*pi./180);
end

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

vNth_ed_w_conv = -1.*vNth_ed_w_conv_s./cosphi./a;
vNth_ed_h_conv = -1.*vNth_ed_h_conv_s./cosphi./a;
vNth_ed_q_conv = -1.*vNth_ed_q_conv_s./cosphi./a;
vNth_ed_d_conv = -1.*vNth_ed_d_conv_s./cosphi./a;
vNth_ed_th_conv = -1.*vNth_ed_th_conv_s./cosphi./a;

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

vdthetady_w = dthetady_w .* vNll_w_zav;
vdthetady_h = dthetady_h .* vNll_h_zav;
vdthetady_q = dthetady_q .* vNll_q_zav;
vdthetady_d = dthetady_d .* vNll_d_zav;
vdthetady_th = dthetady_th .* vNll_th_zav;

wdthetadp_w = dthetadp_w .* wll_w_zav;
wdthetadp_h = dthetadp_h .* wll_h_zav;
wdthetadp_q = dthetadp_q .* wll_q_zav;
wdthetadp_d = dthetadp_d .* wll_d_zav;
wdthetadp_th = dthetadp_th .* wll_th_zav;


vNth_ed_w_vint = intfac.*sum(vNth_ed_w_conv,2);
vNth_ed_h_vint = intfac.*sum(vNth_ed_h_conv,2);
vNth_ed_q_vint = intfac.*sum(vNth_ed_q_conv,2);
vNth_ed_d_vint = intfac.*sum(vNth_ed_d_conv,2);
vNth_ed_th_vint = intfac.*sum(vNth_ed_th_conv,2);

wdthetadp_w_vint = intfac.*sum(wdthetadp_w,2);
wdthetadp_h_vint = intfac.*sum(wdthetadp_h,2);
wdthetadp_q_vint = intfac.*sum(wdthetadp_q,2);
wdthetadp_d_vint = intfac.*sum(wdthetadp_d,2);
wdthetadp_th_vint = intfac.*sum(wdthetadp_th,2);

vdthetady_w_vint = intfac.*sum(vdthetady_w,2);
vdthetady_h_vint = intfac.*sum(vdthetady_h,2);
vdthetady_q_vint = intfac.*sum(vdthetady_q,2);
vdthetady_d_vint = intfac.*sum(vdthetady_d,2);
vdthetady_th_vint = intfac.*sum(vdthetady_th,2);

htrtll_w_vint = intfac.*sum(htrtll_w_zav,2);
htrtll_h_vint = intfac.*sum(htrtll_h_zav,2);
htrtll_q_vint = intfac.*sum(htrtll_q_zav,2);
htrtll_d_vint = intfac.*sum(htrtll_d_zav,2);
htrtll_th_vint = intfac.*sum(htrtll_th_zav,2);

for i = 1:45

vNth_ed_w_hzav(i) = (vNth_ed_w_vint(46-i) + vNth_ed_w_vint(45+i))./2;
vNth_ed_h_hzav(i) = (vNth_ed_h_vint(46-i) + vNth_ed_h_vint(45+i))./2;
vNth_ed_q_hzav(i) = (vNth_ed_q_vint(46-i) + vNth_ed_q_vint(45+i))./2;
vNth_ed_d_hzav(i) = (vNth_ed_d_vint(46-i) + vNth_ed_d_vint(45+i))./2;
vNth_ed_th_hzav(i) = (vNth_ed_th_vint(46-i) + vNth_ed_th_vint(45+i))./2;

wdthetadp_w_hzav(i) = (wdthetadp_w_vint(46-i) + wdthetadp_w_vint(45+i))./2;
wdthetadp_h_hzav(i) = (wdthetadp_h_vint(46-i) + wdthetadp_h_vint(45+i))./2;
wdthetadp_q_hzav(i) = (wdthetadp_q_vint(46-i) + wdthetadp_q_vint(45+i))./2;
wdthetadp_d_hzav(i) = (wdthetadp_d_vint(46-i) + wdthetadp_d_vint(45+i))./2;
wdthetadp_th_hzav(i) = (wdthetadp_th_vint(46-i) + wdthetadp_th_vint(45+i))./2;

vdthetady_w_hzav(i) = (vdthetady_w_vint(46-i) + vdthetady_w_vint(45+i))./2;
vdthetady_h_hzav(i) = (vdthetady_h_vint(46-i) + vdthetady_h_vint(45+i))./2;
vdthetady_q_hzav(i) = (vdthetady_q_vint(46-i) + vdthetady_q_vint(45+i))./2;
vdthetady_d_hzav(i) = (vdthetady_d_vint(46-i) + vdthetady_d_vint(45+i))./2;
vdthetady_th_hzav(i) = (vdthetady_th_vint(46-i) + vdthetady_th_vint(45+i))./2;

htrtll_w_hzav(i) = (htrtll_w_vint(46-i) + htrtll_w_vint(45+i))./2;
htrtll_h_hzav(i) = (htrtll_h_vint(46-i) + htrtll_h_vint(45+i))./2;
htrtll_q_hzav(i) = (htrtll_q_vint(46-i) + htrtll_q_vint(45+i))./2;
htrtll_d_hzav(i) = (htrtll_d_vint(46-i) + htrtll_d_vint(45+i))./2;
htrtll_th_hzav(i) = (htrtll_th_vint(46-i) + htrtll_th_vint(45+i))./2;

end


ext_w = 37;
ext_h = 29;
ext_q = 25;
ext_d = 27;

y_w = 64;
y_h = 60;
y_q = 58;
y_d = 59;

htrt_edge(1) = htrtll_w_hzav(y_w-45);
htrt_edge(2) = htrtll_h_hzav(y_h-45);
htrt_edge(3) = htrtll_q_hzav(y_q-45);
htrt_edge(4) = htrtll_d_hzav(y_d-45);

vNth_edge(1) = vNth_ed_w_hzav(y_w-45);
vNth_edge(2) = vNth_ed_h_hzav(y_h-45);
vNth_edge(3) = vNth_ed_q_hzav(y_q-45);
vNth_edge(4) = vNth_ed_d_hzav(y_d-45);

wdthdp_edge(1) = wdthetadp_w_hzav(y_w-45);
wdthdp_edge(2) = wdthetadp_h_hzav(y_h-45);
wdthdp_edge(3) = wdthetadp_q_hzav(y_q-45);
wdthdp_edge(4) = wdthetadp_d_hzav(y_d-45);

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
plot(yi(46:90),htrtll_w_hzav,'b')
hold on
plot(yi(46:90),htrtll_h_hzav,'k')
plot(yi(46:90),htrtll_q_hzav,'g')
plot(yi(46:90),htrtll_d_hzav,'r')
plot(yi(46:90),htrtll_th_hzav,'m')
plot([ext_w, ext_w],[-200 600],'b:')
plot([ext_h, ext_h],[-200 600],'k:')
plot([ext_q, ext_q],[-200 600],'g:')
plot([ext_d, ext_d],[-200 600],'r:')
ylabel('Vertically averaged heating rate, Wm^{-2}')
ylim([-200 600])
title('Total diabatic heating')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi(46:90),vNth_ed_w_hzav,'b')
hold on
plot(yi(46:90),vNth_ed_h_hzav,'k')
plot(yi(46:90),vNth_ed_q_hzav,'g')
plot(yi(46:90),vNth_ed_d_hzav,'r')
plot(yi(46:90),vNth_ed_th_hzav,'m')
plot([ext_w, ext_w],[-200 600],'b:')
plot([ext_h, ext_h],[-200 600],'k:')
plot([ext_q, ext_q],[-200 600],'g:')
plot([ext_d, ext_d],[-200 600],'r:')
title('<dv''\theta''>/dy ')
ylim([-200 600])

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi(46:90),wdthetadp_w_hzav,'b')
hold on
plot(yi(46:90),wdthetadp_h_hzav,'k')
plot(yi(46:90),wdthetadp_q_hzav,'g')
plot(yi(46:90),wdthetadp_d_hzav,'r')
plot(yi(46:90),wdthetadp_th_hzav,'m') 
plot([ext_w, ext_w],[-200 600],'b:')
plot([ext_h, ext_h],[-200 600],'k:')
plot([ext_q, ext_q],[-200 600],'g:')
plot([ext_d, ext_d],[-200 600],'r:')
xlabel('Latitude')
title('<\omega> d<\theta>/dp')
ylabel('Vertically averaged heating rate, Wm^{-2}')
ylim([-200 600])

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(yi(46:90),vdthetady_w_hzav,'b')
hold on
plot(yi(46:90),vdthetady_h_hzav,'k')
plot(yi(46:90),vdthetady_q_hzav,'g')
plot(yi(46:90),vdthetady_d_hzav,'r')
plot(yi(46:90),vdthetady_th_hzav,'m')
plot([ext_w, ext_w],[-200 600],'b:')
plot([ext_h, ext_h],[-200 600],'k:')
plot([ext_q, ext_q],[-200 600],'g:')
plot([ext_d, ext_d],[-200 600],'r:')
xlabel('Latitude')
title('<v> d<\theta>/dy')
ylim([-200 600])

print('-dpdf','heat_budg_terms.pdf')
