%FINALLY SORT OUT THE MOMENTUM BUDGET WOOOO

%Read in iteration number, directory, MITgcm output and grid details

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
J=find(strcmp(fldList,'WVEL    '));
w_w(:,:,:,i) = dyn(:,:,:,J);

%vort3u term = (f + zeta3)v
J=find(strcmp(fldList,'Um_AdvZ3'));
uzcs_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvZ3'));
vzcs_w(:,:,:,i) = dyn(:,:,:,J);
[uzE_w(:,:,:,i),vzN_w(:,:,:,i)] = rotate_uv2uvEN(uzcs_w(:,:,:,i),vzcs_w(:,:,:,i),AngleCS,AngleSN,Grid);

%shear term = - zeta2w
J=find(strcmp(fldList,'Um_AdvRe'));
urcs_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvRe'));
vrcs_w(:,:,:,i) = dyn(:,:,:,J);
[urE_w(:,:,:,i),vrN_w(:,:,:,i)] = rotate_uv2uvEN(urcs_w(:,:,:,i),vrcs_w(:,:,:,i),AngleCS,AngleSN,Grid);

%total = vort3+shear term
J=find(strcmp(fldList,'Um_Advec'));
uadvcs_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_Advec'));
vadvcs_w(:,:,:,i) = dyn(:,:,:,J);
[uadvE_w(:,:,:,i),vadvN_w(:,:,:,i)] = rotate_uv2uvEN(uadvcs_w(:,:,:,i),vadvcs_w(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'momVort3'));
vort3_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UV_VEL_C'));
uv_w(:,:,:,i) = dyn(:,:,:,J);

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhTauX'));
tauxcs_w(:,:,i)=surf(:,:,J);
J=find(strcmp(fldList,'AtPhTauY'));
tauycs_w(:,:,i)=surf(:,:,J);
[tauE_w(:,:,i),tauW_w(:,:,i)] = rotate_uv2uvEN(tauxcs_w(:,:,i),tauycs_w(:,:,i),AngleCS,AngleSN,Grid);

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
J=find(strcmp(fldList,'WVEL    '));
w_h(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'Um_AdvZ3'));
uzcs_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvZ3'));
vzcs_h(:,:,:,i) = dyn(:,:,:,J);
[uzE_h(:,:,:,i),vzN_h(:,:,:,i)] = rotate_uv2uvEN(uzcs_h(:,:,:,i),vzcs_h(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'Um_AdvRe'));
urcs_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvRe'));
vrcs_h(:,:,:,i) = dyn(:,:,:,J);
[urE_h(:,:,:,i),vrN_h(:,:,:,i)] = rotate_uv2uvEN(urcs_h(:,:,:,i),vrcs_h(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'Um_Advec'));
uadvcs_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_Advec'));
vadvcs_h(:,:,:,i) = dyn(:,:,:,J);
[uadvE_h(:,:,:,i),vadvN_h(:,:,:,i)] = rotate_uv2uvEN(uadvcs_h(:,:,:,i),vadvcs_h(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'momVort3'));
vort3_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UV_VEL_C'));
uv_h(:,:,:,i) = dyn(:,:,:,J);

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhTauX'));
tauxcs_h(:,:,i)=surf(:,:,J);
J=find(strcmp(fldList,'AtPhTauY'));
tauycs_h(:,:,i)=surf(:,:,J);
[tauE_h(:,:,i),tauW_h(:,:,i)] = rotate_uv2uvEN(tauxcs_h(:,:,i),tauycs_h(:,:,i),AngleCS,AngleSN,Grid);

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
J=find(strcmp(fldList,'WVEL    '));
w_q(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'Um_AdvZ3'));
uzcs_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvZ3'));
vzcs_q(:,:,:,i) = dyn(:,:,:,J);
[uzE_q(:,:,:,i),vzN_q(:,:,:,i)] = rotate_uv2uvEN(uzcs_q(:,:,:,i),vzcs_q(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'Um_AdvRe'));
urcs_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvRe'));
vrcs_q(:,:,:,i) = dyn(:,:,:,J);
[urE_q(:,:,:,i),vrN_q(:,:,:,i)] = rotate_uv2uvEN(urcs_q(:,:,:,i),vrcs_q(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'Um_Advec'));
uadvcs_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_Advec'));
vadvcs_q(:,:,:,i) = dyn(:,:,:,J);
[uadvE_q(:,:,:,i),vadvN_q(:,:,:,i)] = rotate_uv2uvEN(uadvcs_q(:,:,:,i),vadvcs_q(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'momVort3'));
vort3_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UV_VEL_C'));
uv_q(:,:,:,i) = dyn(:,:,:,J);

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhTauX'));
tauxcs_q(:,:,i)=surf(:,:,J);
J=find(strcmp(fldList,'AtPhTauY'));
tauycs_q(:,:,i)=surf(:,:,J);
[tauE_q(:,:,i),tauW_q(:,:,i)] = rotate_uv2uvEN(tauxcs_q(:,:,i),tauycs_q(:,:,i),AngleCS,AngleSN,Grid);

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
J=find(strcmp(fldList,'WVEL    '));
w_d(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'Um_AdvZ3'));
uzcs_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvZ3'));
vzcs_d(:,:,:,i) = dyn(:,:,:,J);
[uzE_d(:,:,:,i),vzN_d(:,:,:,i)] = rotate_uv2uvEN(uzcs_d(:,:,:,i),vzcs_d(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'Um_AdvRe'));
urcs_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvRe'));
vrcs_d(:,:,:,i) = dyn(:,:,:,J);
[urE_d(:,:,:,i),vrN_d(:,:,:,i)] = rotate_uv2uvEN(urcs_d(:,:,:,i),vrcs_d(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'Um_Advec'));
uadvcs_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_Advec'));
vadvcs_d(:,:,:,i) = dyn(:,:,:,J);
[uadvE_d(:,:,:,i),vadvN_d(:,:,:,i)] = rotate_uv2uvEN(uadvcs_d(:,:,:,i),vadvcs_d(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'momVort3'));
vort3_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UV_VEL_C'));
uv_d(:,:,:,i) = dyn(:,:,:,J);

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhTauX'));
tauxcs_d(:,:,i)=surf(:,:,J);
J=find(strcmp(fldList,'AtPhTauY'));
tauycs_d(:,:,i)=surf(:,:,J);
[tauE_d(:,:,i),tauW_d(:,:,i)] = rotate_uv2uvEN(tauxcs_d(:,:,i),tauycs_d(:,:,i),AngleCS,AngleSN,Grid);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Tropheat Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearth/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_th(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_th(:,:,:,i) = dyn(:,:,:,J);
[uE_th(:,:,:,i),vN_th(:,:,:,i)] = rotate_uv2uvEN(ucs_th(:,:,:,i),vcs_th(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'WVEL    '));
w_th(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'Um_AdvZ3'));
uzcs_th(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvZ3'));
vzcs_th(:,:,:,i) = dyn(:,:,:,J);
[uzE_th(:,:,:,i),vzN_th(:,:,:,i)] = rotate_uv2uvEN(uzcs_th(:,:,:,i),vzcs_th(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'Um_AdvRe'));
urcs_th(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvRe'));
vrcs_th(:,:,:,i) = dyn(:,:,:,J);
[urE_th(:,:,:,i),vrN_th(:,:,:,i)] = rotate_uv2uvEN(urcs_th(:,:,:,i),vrcs_th(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'Um_Advec'));
uadvcs_th(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_Advec'));
vadvcs_th(:,:,:,i) = dyn(:,:,:,J);
[uadvE_th(:,:,:,i),vadvN_th(:,:,:,i)] = rotate_uv2uvEN(uadvcs_th(:,:,:,i),vadvcs_th(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'momVort3'));
vort3_th(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UV_VEL_C'));
uv_th(:,:,:,i) = dyn(:,:,:,J);

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhTauX'));
tauxcs_th(:,:,i)=surf(:,:,J);
J=find(strcmp(fldList,'AtPhTauY'));
tauycs_th(:,:,i)=surf(:,:,J);
[tauE_th(:,:,i),tauW_th(:,:,i)] = rotate_uv2uvEN(tauxcs_th(:,:,i),tauycs_th(:,:,i),AngleCS,AngleSN,Grid);


end

%take time means

uE_w_mean = mean(uE_w,4);
vN_w_mean = mean(vN_w,4);
uzE_w_mean = mean(uzE_w,4);
urE_w_mean = mean(urE_w,4);
uadvE_w_mean = mean(uadvE_w,4);
tauE_w_mean = mean(tauE_w,3);
w_w_mean = mean(w_w,4);
vort3_w_mean = mean(vort3_w,4);
uv_w_mean = mean(uv_w,4);

uE_h_mean = mean(uE_h,4);
vN_h_mean = mean(vN_h,4);
uzE_h_mean = mean(uzE_h,4);
urE_h_mean = mean(urE_h,4);
uadvE_h_mean = mean(uadvE_h,4);
tauE_h_mean = mean(tauE_h,3);
w_h_mean = mean(w_h,4);
vort3_h_mean = mean(vort3_h,4);
uv_h_mean = mean(uv_h,4);

uE_q_mean = mean(uE_q,4);
vN_q_mean = mean(vN_q,4);
uzE_q_mean = mean(uzE_q,4);
urE_q_mean = mean(urE_q,4);
uadvE_q_mean = mean(uadvE_q,4);
tauE_q_mean = mean(tauE_q,3);
w_q_mean = mean(w_q,4);
vort3_q_mean = mean(vort3_q,4);
uv_q_mean = mean(uv_q,4);

uE_d_mean = mean(uE_d,4);
vN_d_mean = mean(vN_d,4);
uzE_d_mean = mean(uzE_d,4);
urE_d_mean = mean(urE_d,4);
uadvE_d_mean = mean(uadvE_d,4);
tauE_d_mean = mean(tauE_d,3);
w_d_mean = mean(w_d,4);
vort3_d_mean = mean(vort3_d,4);
uv_d_mean = mean(uv_d,4);

uE_th_mean = mean(uE_th,4);
vN_th_mean = mean(vN_th,4);
uzE_th_mean = mean(uzE_th,4);
urE_th_mean = mean(urE_th,4);
uadvE_th_mean = mean(uadvE_th,4);
tauE_th_mean = mean(tauE_th,3);
w_th_mean = mean(w_th,4);
vort3_th_mean = mean(vort3_th,4);
uv_th_mean = mean(uv_th,4);

%switch to lat lon grid

xi=-179:2:180;yi=-89:2:90;
uEll_w=cube2latlon(xc,yc,uE_w_mean,xi,yi);
vNll_w=cube2latlon(xc,yc,vN_w_mean,xi,yi);
uzEll_w=cube2latlon(xc,yc,uzE_w_mean,xi,yi);
urEll_w=cube2latlon(xc,yc,urE_w_mean,xi,yi);
uadvEll_w=cube2latlon(xc,yc,uadvE_w_mean,xi,yi);
tauEll_w=cube2latlon(xc,yc,tauE_w_mean,xi,yi);
wll_w=cube2latlon(xc,yc,w_w_mean,xi,yi);
vort3ll_w=cube2latlon(xc,yc,vort3_w_mean,xi,yi);
uvll_w=cube2latlon(xc,yc,uv_w_mean,xi,yi);

uEll_h=cube2latlon(xc,yc,uE_h_mean,xi,yi);
vNll_h=cube2latlon(xc,yc,vN_h_mean,xi,yi);
uzEll_h=cube2latlon(xc,yc,uzE_h_mean,xi,yi);
urEll_h=cube2latlon(xc,yc,urE_h_mean,xi,yi);
uadvEll_h=cube2latlon(xc,yc,uadvE_h_mean,xi,yi);
tauEll_h=cube2latlon(xc,yc,tauE_h_mean,xi,yi);
wll_h=cube2latlon(xc,yc,w_h_mean,xi,yi);
vort3ll_h=cube2latlon(xc,yc,vort3_h_mean,xi,yi);
uvll_h=cube2latlon(xc,yc,uv_h_mean,xi,yi);

uEll_q=cube2latlon(xc,yc,uE_q_mean,xi,yi);
vNll_q=cube2latlon(xc,yc,vN_q_mean,xi,yi);
uzEll_q=cube2latlon(xc,yc,uzE_q_mean,xi,yi);
urEll_q=cube2latlon(xc,yc,urE_q_mean,xi,yi);
uadvEll_q=cube2latlon(xc,yc,uadvE_q_mean,xi,yi);
tauEll_q=cube2latlon(xc,yc,tauE_q_mean,xi,yi);
wll_q=cube2latlon(xc,yc,w_q_mean,xi,yi);
vort3ll_q=cube2latlon(xc,yc,vort3_q_mean,xi,yi);
uvll_q=cube2latlon(xc,yc,uv_q_mean,xi,yi);

uEll_d=cube2latlon(xc,yc,uE_d_mean,xi,yi);
vNll_d=cube2latlon(xc,yc,vN_d_mean,xi,yi);
uzEll_d=cube2latlon(xc,yc,uzE_d_mean,xi,yi);
urEll_d=cube2latlon(xc,yc,urE_d_mean,xi,yi);
uadvEll_d=cube2latlon(xc,yc,uadvE_d_mean,xi,yi);
tauEll_d=cube2latlon(xc,yc,tauE_d_mean,xi,yi);
wll_d=cube2latlon(xc,yc,w_d_mean,xi,yi);
vort3ll_d=cube2latlon(xc,yc,vort3_d_mean,xi,yi);
uvll_d=cube2latlon(xc,yc,uv_d_mean,xi,yi);

uEll_th=cube2latlon(xc,yc,uE_th_mean,xi,yi);
vNll_th=cube2latlon(xc,yc,vN_th_mean,xi,yi);
uzEll_th=cube2latlon(xc,yc,uzE_th_mean,xi,yi);
urEll_th=cube2latlon(xc,yc,urE_th_mean,xi,yi);
uadvEll_th=cube2latlon(xc,yc,uadvE_th_mean,xi,yi);
tauEll_th=cube2latlon(xc,yc,tauE_th_mean,xi,yi);
wll_th=cube2latlon(xc,yc,w_th_mean,xi,yi);
vort3ll_th=cube2latlon(xc,yc,vort3_th_mean,xi,yi);
uvll_th=cube2latlon(xc,yc,uv_th_mean,xi,yi);

%and take zonal av

uE_w_zav(:,:) = mean(uEll_w,1);
vN_w_zav(:,:) = mean(vNll_w,1);
uzE_w_zav(:,:) = mean(uzEll_w,1);
urE_w_zav(:,:) = mean(urEll_w,1);
uadvE_w_zav(:,:) = mean(uadvEll_w,1);
tauE_w_zav = mean(tauEll_w,1);
w_w_zav(:,:) = mean(wll_w,1);
vort3_w_zav(:,:) = mean(vort3ll_w,1);
uv_w_zav(:,:) = mean(uvll_w,1);

uE_h_zav(:,:) = mean(uEll_h,1);
vN_h_zav(:,:) = mean(vNll_h,1);
uzE_h_zav(:,:) = mean(uzEll_h,1);
urE_h_zav(:,:) = mean(urEll_h,1);
uadvE_h_zav(:,:) = mean(uadvEll_h,1);
tauE_h_zav = mean(tauEll_h,1);
w_h_zav(:,:) = mean(wll_h,1);
vort3_h_zav(:,:) = mean(vort3ll_h,1);
uv_h_zav(:,:) = mean(uvll_h,1);

uE_q_zav(:,:) = mean(uEll_q,1);
vN_q_zav(:,:) = mean(vNll_q,1);
uzE_q_zav(:,:) = mean(uzEll_q,1);
urE_q_zav(:,:) = mean(urEll_q,1);
uadvE_q_zav(:,:) = mean(uadvEll_q,1);
tauE_q_zav = mean(tauEll_q,1);
w_q_zav(:,:) = mean(wll_q,1);
vort3_q_zav(:,:) = mean(vort3ll_q,1);
uv_q_zav(:,:) = mean(uvll_q,1);

uE_d_zav(:,:) = mean(uEll_d,1);
vN_d_zav(:,:) = mean(vNll_d,1);
uzE_d_zav(:,:) = mean(uzEll_d,1);
urE_d_zav(:,:) = mean(urEll_d,1);
uadvE_d_zav(:,:) = mean(uadvEll_d,1);
tauE_d_zav = mean(tauEll_d,1);
w_d_zav(:,:) = mean(wll_d,1);
vort3_d_zav(:,:) = mean(vort3ll_d,1);
uv_d_zav(:,:) = mean(uvll_d,1);

uE_th_zav(:,:) = mean(uEll_th,1);
vN_th_zav(:,:) = mean(vNll_th,1);
uzE_th_zav(:,:) = mean(uzEll_th,1);
urE_th_zav(:,:) = mean(urEll_th,1);
uadvE_th_zav(:,:) = mean(uadvEll_th,1);
tauE_th_zav = mean(tauEll_th,1);
w_th_zav(:,:) = mean(wll_th,1);
vort3_th_zav(:,:) = mean(vort3ll_th,1);
uv_th_zav(:,:) = mean(uvll_th,1);

%and take hzav

for i=1:45

uE_w_hzav(i,:) = (uE_w_zav(45+i,:) + uE_w_zav(46-i,:))./2;
vN_w_hzav(i,:) = (vN_w_zav(45+i,:) - vN_w_zav(46-i,:))./2;
uzE_w_hzav(i,:) = (uzE_w_zav(45+i,:) + uzE_w_zav(46-i,:))./2;
urE_w_hzav(i,:) = (urE_w_zav(45+i,:) + urE_w_zav(46-i,:))./2;
uadvE_w_hzav(i,:) = (uadvE_w_zav(45+i,:) + uadvE_w_zav(46-i,:))./2;
tauE_w_hzav(i) = (tauE_w_zav(45+i) + tauE_w_zav(46-i))./2;
w_w_hzav(i,:) = (w_w_zav(45+i,:) + w_w_zav(46-i,:))./2;
vort3_w_hzav(i,:) = (vort3_w_zav(45+i,:) - vort3_w_zav(46-i,:))./2;
uv_w_hzav(i,:) = (uv_w_zav(45+i,:) - uv_w_zav(46-i,:))./2;

uE_h_hzav(i,:) = (uE_h_zav(45+i,:) + uE_h_zav(46-i,:))./2;
vN_h_hzav(i,:) = (vN_h_zav(45+i,:) - vN_h_zav(46-i,:))./2;
uzE_h_hzav(i,:) = (uzE_h_zav(45+i,:) + uzE_h_zav(46-i,:))./2;
urE_h_hzav(i,:) = (urE_h_zav(45+i,:) + urE_h_zav(46-i,:))./2;
uadvE_h_hzav(i,:) = (uadvE_h_zav(45+i,:) + uadvE_h_zav(46-i,:))./2;
tauE_h_hzav(i) = (tauE_h_zav(45+i) + tauE_h_zav(46-i))./2;
w_h_hzav(i,:) = (w_h_zav(45+i,:) + w_h_zav(46-i,:))./2;
vort3_h_hzav(i,:) = (vort3_h_zav(45+i,:) - vort3_h_zav(46-i,:))./2;
uv_h_hzav(i,:) = (uv_h_zav(45+i,:) - uv_h_zav(46-i,:))./2;

uE_q_hzav(i,:) = (uE_q_zav(45+i,:) + uE_q_zav(46-i,:))./2;
vN_q_hzav(i,:) = (vN_q_zav(45+i,:) - vN_q_zav(46-i,:))./2;
uzE_q_hzav(i,:) = (uzE_q_zav(45+i,:) + uzE_q_zav(46-i,:))./2;
urE_q_hzav(i,:) = (urE_q_zav(45+i,:) + urE_q_zav(46-i,:))./2;
uadvE_q_hzav(i,:) = (uadvE_q_zav(45+i,:) + uadvE_q_zav(46-i,:))./2;
tauE_q_hzav(i) = (tauE_q_zav(45+i) + tauE_q_zav(46-i))./2;
w_q_hzav(i,:) = (w_q_zav(45+i,:) + w_q_zav(46-i,:))./2;
vort3_q_hzav(i,:) = (vort3_q_zav(45+i,:) - vort3_q_zav(46-i,:))./2;
uv_q_hzav(i,:) = (uv_q_zav(45+i,:) - uv_q_zav(46-i,:))./2;

uE_d_hzav(i,:) = (uE_d_zav(45+i,:) + uE_d_zav(46-i,:))./2;
vN_d_hzav(i,:) = (vN_d_zav(45+i,:) - vN_d_zav(46-i,:))./2;
uzE_d_hzav(i,:) = (uzE_d_zav(45+i,:) + uzE_d_zav(46-i,:))./2;
urE_d_hzav(i,:) = (urE_d_zav(45+i,:) + urE_d_zav(46-i,:))./2;
uadvE_d_hzav(i,:) = (uadvE_d_zav(45+i,:) + uadvE_d_zav(46-i,:))./2;
tauE_d_hzav(i) = (tauE_d_zav(45+i) + tauE_d_zav(46-i))./2;
w_d_hzav(i,:) = (w_d_zav(45+i,:) + w_d_zav(46-i,:))./2;
vort3_d_hzav(i,:) = (vort3_d_zav(45+i,:) - vort3_d_zav(46-i,:))./2;
uv_d_hzav(i,:) = (uv_d_zav(45+i,:) - uv_d_zav(46-i,:))./2;

uE_th_hzav(i,:) = (uE_th_zav(45+i,:) + uE_th_zav(46-i,:))./2;
vN_th_hzav(i,:) = (vN_th_zav(45+i,:) - vN_th_zav(46-i,:))./2;
uzE_th_hzav(i,:) = (uzE_th_zav(45+i,:) + uzE_th_zav(46-i,:))./2;
urE_th_hzav(i,:) = (urE_th_zav(45+i,:) + urE_th_zav(46-i,:))./2;
uadvE_th_hzav(i,:) = (uadvE_th_zav(45+i,:) + uadvE_th_zav(46-i,:))./2;
tauE_th_hzav(i) = (tauE_th_zav(45+i) + tauE_th_zav(46-i))./2;
w_th_hzav(i,:) = (w_th_zav(45+i,:) + w_th_zav(46-i,:))./2;
vort3_th_hzav(i,:) = (vort3_th_zav(45+i,:) - vort3_th_zav(46-i,:))./2;
uv_th_hzav(i,:) = (uv_th_zav(45+i,:) - uv_th_zav(46-i,:))./2;
end

uv_ed_w_hzav = uv_w_hzav - uE_w_hzav.*vN_w_hzav;
uv_ed_h_hzav = uv_h_hzav - uE_h_hzav.*vN_h_hzav;
uv_ed_q_hzav = uv_q_hzav - uE_q_hzav.*vN_q_hzav;
uv_ed_d_hzav = uv_d_hzav - uE_d_hzav.*vN_d_hzav;
uv_ed_th_hzav = uv_th_hzav - uE_th_hzav.*vN_th_hzav;

f = zeros(45,25);
cosphi = zeros(45,25);
omega = 2.*pi./(24.*60.*60);
for i=1:25
f(:,i) = 2.*omega.*sin(yi(46:90).*pi./180);
cosphi(:,i) = cos(yi(46:90).*pi./180);
end

%calculate vertical and horizontal gradients of u
a = 6371.0e3;
uE_w_weighted = uE_w_hzav.*cosphi;
uE_h_weighted = uE_h_hzav.*cosphi;
uE_q_weighted = uE_q_hzav.*cosphi;
uE_d_weighted = uE_d_hzav.*cosphi;
uE_th_weighted = uE_th_hzav.*cosphi;

uv_w_weighted = uv_w_hzav.*cosphi.^2;
uv_h_weighted = uv_h_hzav.*cosphi.^2;
uv_q_weighted = uv_q_hzav.*cosphi.^2;
uv_d_weighted = uv_d_hzav.*cosphi.^2;
uv_th_weighted = uv_th_hzav.*cosphi.^2;

uv_ed_w_weighted = uv_ed_w_hzav.*cosphi.^2;
uv_ed_h_weighted = uv_ed_h_hzav.*cosphi.^2;
uv_ed_q_weighted = uv_ed_q_hzav.*cosphi.^2;
uv_ed_d_weighted = uv_ed_d_hzav.*cosphi.^2;
uv_ed_th_weighted = uv_ed_th_hzav.*cosphi.^2;

[moo,dudy_s] = gradient(uE_w_weighted,pi./90);
dudy_w = dudy_s./cosphi./a;
[moo,dudy_s] = gradient(uE_h_weighted,pi./90);
dudy_h = dudy_s./cosphi./a;
[moo,dudy_s] = gradient(uE_q_weighted,pi./90);
dudy_q = dudy_s./cosphi./a;
[moo,dudy_s] = gradient(uE_d_weighted,pi./90);
dudy_d = dudy_s./cosphi./a;
[moo,dudy_s] = gradient(uE_th_weighted,pi./90);
dudy_th = dudy_s./cosphi./a;

[moo,duvdy_s] = gradient(uv_w_weighted,pi./90);
duvdy_w = duvdy_s./cosphi./cosphi./a;
[moo,duvdy_s] = gradient(uv_h_weighted,pi./90);
duvdy_h = duvdy_s./cosphi./cosphi./a;
[moo,duvdy_s] = gradient(uv_q_weighted,pi./90);
duvdy_q = duvdy_s./cosphi./cosphi./a;
[moo,duvdy_s] = gradient(uv_d_weighted,pi./90);
duvdy_d = duvdy_s./cosphi./cosphi./a;
[moo,duvdy_s] = gradient(uv_th_weighted,pi./90);
duvdy_th = duvdy_s./cosphi./cosphi./a;

[moo,duvdy_s_ed] = gradient(uv_ed_w_weighted,pi./90);
duvdy_ed_w = duvdy_s_ed./cosphi./cosphi./a;
[moo,duvdy_s_ed] = gradient(uv_ed_h_weighted,pi./90);
duvdy_ed_h = duvdy_s_ed./cosphi./cosphi./a;
[moo,duvdy_s_ed] = gradient(uv_ed_q_weighted,pi./90);
duvdy_ed_q = duvdy_s_ed./cosphi./cosphi./a;
[moo,duvdy_s_ed] = gradient(uv_ed_d_weighted,pi./90);
duvdy_ed_d = duvdy_s_ed./cosphi./cosphi./a;
[moo,duvdy_s_ed] = gradient(uv_ed_th_weighted,pi./90);
duvdy_ed_th = duvdy_s_ed./cosphi./cosphi./a;

dudp_w = gradient(uE_w_hzav,-4000);
dudp_h = gradient(uE_h_hzav,-4000);
dudp_q = gradient(uE_q_hzav,-4000);
dudp_d = gradient(uE_d_hzav,-4000);
dudp_th = gradient(uE_th_hzav,-4000);

%If -dudy is equivalent to vort3, which it is, then dudp should be an ok approx to vort2 :)

%Now we want to evaluate and vertically integrate:
%fv, f, v

fvN_w_hzav = f.*vN_w_hzav;
fvN_h_hzav = f.*vN_h_hzav;
fvN_q_hzav = f.*vN_q_hzav;
fvN_d_hzav = f.*vN_d_hzav;
fvN_th_hzav = f.*vN_th_hzav;

%zeta3v, total, zonal and eddy

zeta3v_w_tot_hzav = uzE_w_hzav - fvN_w_hzav;
zeta3v_h_tot_hzav = uzE_h_hzav - fvN_h_hzav;
zeta3v_q_tot_hzav = uzE_q_hzav - fvN_q_hzav;
zeta3v_d_tot_hzav = uzE_d_hzav - fvN_d_hzav;
zeta3v_th_tot_hzav = uzE_th_hzav - fvN_th_hzav;

zeta3v_w_zon_hzav = vort3_w_hzav.*vN_w_hzav;
zeta3v_h_zon_hzav = vort3_h_hzav.*vN_h_hzav;
zeta3v_q_zon_hzav = vort3_q_hzav.*vN_q_hzav;
zeta3v_d_zon_hzav = vort3_d_hzav.*vN_d_hzav;
zeta3v_th_zon_hzav = vort3_th_hzav.*vN_th_hzav;

zeta3v_w_ed_hzav = zeta3v_w_tot_hzav - zeta3v_w_zon_hzav;
zeta3v_h_ed_hzav = zeta3v_h_tot_hzav - zeta3v_h_zon_hzav;
zeta3v_q_ed_hzav = zeta3v_q_tot_hzav - zeta3v_q_zon_hzav;
zeta3v_d_ed_hzav = zeta3v_d_tot_hzav - zeta3v_d_zon_hzav;
zeta3v_th_ed_hzav = zeta3v_th_tot_hzav - zeta3v_th_zon_hzav;

%zeta2w, total, zonal and eddy

zeta2w_w_hzav = -dudp_w.*w_w_hzav;
zeta2w_h_hzav = -dudp_h.*w_h_hzav;
zeta2w_q_hzav = -dudp_q.*w_q_hzav;
zeta2w_d_hzav = -dudp_d.*w_d_hzav;
zeta2w_th_hzav = -dudp_th.*w_th_hzav;

zeta2w_w_ed_hzav = urE_w_hzav - zeta2w_w_hzav;
zeta2w_h_ed_hzav = urE_h_hzav - zeta2w_h_hzav;
zeta2w_q_ed_hzav = urE_q_hzav - zeta2w_q_hzav;
zeta2w_d_ed_hzav = urE_d_hzav - zeta2w_d_hzav;
zeta2w_th_ed_hzav = urE_th_hzav - zeta2w_th_hzav;

%friction - done


%take vertical integrals

intfac = 4000./9.81;


uadvE_w_vint = sum(uadvE_w_hzav,2).*intfac;
uadvE_h_vint = sum(uadvE_h_hzav,2).*intfac;
uadvE_q_vint = sum(uadvE_q_hzav,2).*intfac;
uadvE_d_vint = sum(uadvE_d_hzav,2).*intfac;
uadvE_th_vint = sum(uadvE_th_hzav,2).*intfac;

uadvE_w_vint_surf = sum(uadvE_w_hzav(:,1:8),2).*intfac;
uadvE_h_vint_surf = sum(uadvE_h_hzav(:,1:8),2).*intfac;
uadvE_q_vint_surf = sum(uadvE_q_hzav(:,1:8),2).*intfac;
uadvE_d_vint_surf = sum(uadvE_d_hzav(:,1:8),2).*intfac;
uadvE_th_vint_surf = sum(uadvE_th_hzav(:,1:8),2).*intfac;

uadvE_w_vint_top = sum(uadvE_w_hzav(:,9:25),2).*intfac;
uadvE_h_vint_top = sum(uadvE_h_hzav(:,9:25),2).*intfac;
uadvE_q_vint_top = sum(uadvE_q_hzav(:,9:25),2).*intfac;
uadvE_d_vint_top = sum(uadvE_d_hzav(:,9:25),2).*intfac;
uadvE_th_vint_top = sum(uadvE_th_hzav(:,9:25),2).*intfac;

uzE_w_vint = sum(uzE_w_hzav,2).*intfac;
uzE_h_vint = sum(uzE_h_hzav,2).*intfac;
uzE_q_vint = sum(uzE_q_hzav,2).*intfac;
uzE_d_vint = sum(uzE_d_hzav,2).*intfac;
uzE_th_vint = sum(uzE_th_hzav,2).*intfac;

uzE_w_vint_surf = sum(uzE_w_hzav(:,1:8),2).*intfac;
uzE_h_vint_surf = sum(uzE_h_hzav(:,1:8),2).*intfac;
uzE_q_vint_surf = sum(uzE_q_hzav(:,1:8),2).*intfac;
uzE_d_vint_surf = sum(uzE_d_hzav(:,1:8),2).*intfac;
uzE_th_vint_surf = sum(uzE_th_hzav(:,1:8),2).*intfac;

uzE_w_vint_top = sum(uzE_w_hzav(:,9:25),2).*intfac;
uzE_h_vint_top = sum(uzE_h_hzav(:,9:25),2).*intfac;
uzE_q_vint_top = sum(uzE_q_hzav(:,9:25),2).*intfac;
uzE_d_vint_top = sum(uzE_d_hzav(:,9:25),2).*intfac;
uzE_th_vint_top = sum(uzE_th_hzav(:,9:25),2).*intfac;

fvN_w_vint = sum(fvN_w_hzav,2).*intfac;
fvN_h_vint = sum(fvN_h_hzav,2).*intfac;
fvN_q_vint = sum(fvN_q_hzav,2).*intfac;
fvN_d_vint = sum(fvN_d_hzav,2).*intfac;
fvN_th_vint = sum(fvN_th_hzav,2).*intfac;

fvN_w_vint_surf = sum(fvN_w_hzav(:,1:8),2).*intfac;
fvN_h_vint_surf = sum(fvN_h_hzav(:,1:8),2).*intfac;
fvN_q_vint_surf = sum(fvN_q_hzav(:,1:8),2).*intfac;
fvN_d_vint_surf = sum(fvN_d_hzav(:,1:8),2).*intfac;
fvN_th_vint_surf = sum(fvN_th_hzav(:,1:8),2).*intfac;

fvN_w_vint_top = sum(fvN_w_hzav(:,9:25),2).*intfac;
fvN_h_vint_top = sum(fvN_h_hzav(:,9:25),2).*intfac;
fvN_q_vint_top = sum(fvN_q_hzav(:,9:25),2).*intfac;
fvN_d_vint_top = sum(fvN_d_hzav(:,9:25),2).*intfac;
fvN_th_vint_top = sum(fvN_th_hzav(:,9:25),2).*intfac;

zeta3v_w_zon_vint = sum(zeta3v_w_zon_hzav,2).*intfac;
zeta3v_h_zon_vint = sum(zeta3v_h_zon_hzav,2).*intfac;
zeta3v_q_zon_vint = sum(zeta3v_q_zon_hzav,2).*intfac;
zeta3v_d_zon_vint = sum(zeta3v_d_zon_hzav,2).*intfac;
zeta3v_th_zon_vint = sum(zeta3v_th_zon_hzav,2).*intfac;

zeta3v_w_zon_vint_surf = sum(zeta3v_w_zon_hzav(:,1:8),2).*intfac;
zeta3v_h_zon_vint_surf = sum(zeta3v_h_zon_hzav(:,1:8),2).*intfac;
zeta3v_q_zon_vint_surf = sum(zeta3v_q_zon_hzav(:,1:8),2).*intfac;
zeta3v_d_zon_vint_surf = sum(zeta3v_d_zon_hzav(:,1:8),2).*intfac;
zeta3v_th_zon_vint_surf = sum(zeta3v_th_zon_hzav(:,1:8),2).*intfac;

zeta3v_w_zon_vint_top = sum(zeta3v_w_zon_hzav(:,9:25),2).*intfac;
zeta3v_h_zon_vint_top = sum(zeta3v_h_zon_hzav(:,9:25),2).*intfac;
zeta3v_q_zon_vint_top = sum(zeta3v_q_zon_hzav(:,9:25),2).*intfac;
zeta3v_d_zon_vint_top = sum(zeta3v_d_zon_hzav(:,9:25),2).*intfac;
zeta3v_th_zon_vint_top = sum(zeta3v_th_zon_hzav(:,9:25),2).*intfac;

zeta3v_w_tot_vint = sum(zeta3v_w_tot_hzav,2).*intfac;
zeta3v_h_tot_vint = sum(zeta3v_h_tot_hzav,2).*intfac;
zeta3v_q_tot_vint = sum(zeta3v_q_tot_hzav,2).*intfac;
zeta3v_d_tot_vint = sum(zeta3v_d_tot_hzav,2).*intfac;
zeta3v_th_tot_vint = sum(zeta3v_th_tot_hzav,2).*intfac;

zeta3v_w_tot_vint_surf = sum(zeta3v_w_tot_hzav(:,1:8),2).*intfac;
zeta3v_h_tot_vint_surf = sum(zeta3v_h_tot_hzav(:,1:8),2).*intfac;
zeta3v_q_tot_vint_surf = sum(zeta3v_q_tot_hzav(:,1:8),2).*intfac;
zeta3v_d_tot_vint_surf = sum(zeta3v_d_tot_hzav(:,1:8),2).*intfac;
zeta3v_th_tot_vint_surf = sum(zeta3v_th_tot_hzav(:,1:8),2).*intfac;

zeta3v_w_tot_vint_top = sum(zeta3v_w_tot_hzav(:,9:25),2).*intfac;
zeta3v_h_tot_vint_top = sum(zeta3v_h_tot_hzav(:,9:25),2).*intfac;
zeta3v_q_tot_vint_top = sum(zeta3v_q_tot_hzav(:,9:25),2).*intfac;
zeta3v_d_tot_vint_top = sum(zeta3v_d_tot_hzav(:,9:25),2).*intfac;
zeta3v_th_tot_vint_top = sum(zeta3v_th_tot_hzav(:,9:25),2).*intfac;

zeta3v_w_ed_vint = sum(zeta3v_w_ed_hzav,2).*intfac;
zeta3v_h_ed_vint = sum(zeta3v_h_ed_hzav,2).*intfac;
zeta3v_q_ed_vint = sum(zeta3v_q_ed_hzav,2).*intfac;
zeta3v_d_ed_vint = sum(zeta3v_d_ed_hzav,2).*intfac;
zeta3v_th_ed_vint = sum(zeta3v_th_ed_hzav,2).*intfac;

zeta3v_w_ed_vint_surf = sum(zeta3v_w_ed_hzav(:,1:8),2).*intfac;
zeta3v_h_ed_vint_surf = sum(zeta3v_h_ed_hzav(:,1:8),2).*intfac;
zeta3v_q_ed_vint_surf = sum(zeta3v_q_ed_hzav(:,1:8),2).*intfac;
zeta3v_d_ed_vint_surf = sum(zeta3v_d_ed_hzav(:,1:8),2).*intfac;
zeta3v_th_ed_vint_surf = sum(zeta3v_th_ed_hzav(:,1:8),2).*intfac;

zeta3v_w_ed_vint_top = sum(zeta3v_w_ed_hzav(:,9:25),2).*intfac;
zeta3v_h_ed_vint_top = sum(zeta3v_h_ed_hzav(:,9:25),2).*intfac;
zeta3v_q_ed_vint_top = sum(zeta3v_q_ed_hzav(:,9:25),2).*intfac;
zeta3v_d_ed_vint_top = sum(zeta3v_d_ed_hzav(:,9:25),2).*intfac;
zeta3v_th_ed_vint_top = sum(zeta3v_th_ed_hzav(:,9:25),2).*intfac;

urE_w_vint = sum(urE_w_hzav,2).*intfac;
urE_h_vint = sum(urE_h_hzav,2).*intfac;
urE_q_vint = sum(urE_q_hzav,2).*intfac;
urE_d_vint = sum(urE_d_hzav,2).*intfac;
urE_th_vint = sum(urE_th_hzav,2).*intfac;

urE_w_vint_surf = sum(urE_w_hzav(:,1:8),2).*intfac;
urE_h_vint_surf = sum(urE_h_hzav(:,1:8),2).*intfac;
urE_q_vint_surf = sum(urE_q_hzav(:,1:8),2).*intfac;
urE_d_vint_surf = sum(urE_d_hzav(:,1:8),2).*intfac;
urE_th_vint_surf = sum(urE_th_hzav(:,1:8),2).*intfac;

urE_w_vint_top = sum(urE_w_hzav(:,9:25),2).*intfac;
urE_h_vint_top = sum(urE_h_hzav(:,9:25),2).*intfac;
urE_q_vint_top = sum(urE_q_hzav(:,9:25),2).*intfac;
urE_d_vint_top = sum(urE_d_hzav(:,9:25),2).*intfac;
urE_th_vint_top = sum(urE_th_hzav(:,9:25),2).*intfac;

zeta2w_w_vint = sum(zeta2w_w_hzav,2).*intfac;
zeta2w_h_vint = sum(zeta2w_h_hzav,2).*intfac;
zeta2w_q_vint = sum(zeta2w_q_hzav,2).*intfac;
zeta2w_d_vint = sum(zeta2w_d_hzav,2).*intfac;
zeta2w_th_vint = sum(zeta2w_th_hzav,2).*intfac;

zeta2w_w_vint_surf = sum(zeta2w_w_hzav(:,1:8),2).*intfac;
zeta2w_h_vint_surf = sum(zeta2w_h_hzav(:,1:8),2).*intfac;
zeta2w_q_vint_surf = sum(zeta2w_q_hzav(:,1:8),2).*intfac;
zeta2w_d_vint_surf = sum(zeta2w_d_hzav(:,1:8),2).*intfac;
zeta2w_th_vint_surf = sum(zeta2w_th_hzav(:,1:8),2).*intfac;

zeta2w_w_vint_top = sum(zeta2w_w_hzav(:,9:25),2).*intfac;
zeta2w_h_vint_top = sum(zeta2w_h_hzav(:,9:25),2).*intfac;
zeta2w_q_vint_top = sum(zeta2w_q_hzav(:,9:25),2).*intfac;
zeta2w_d_vint_top = sum(zeta2w_d_hzav(:,9:25),2).*intfac;
zeta2w_th_vint_top = sum(zeta2w_th_hzav(:,9:25),2).*intfac;

zeta2w_w_ed_vint = sum(zeta2w_w_ed_hzav,2).*intfac;
zeta2w_h_ed_vint = sum(zeta2w_h_ed_hzav,2).*intfac;
zeta2w_q_ed_vint = sum(zeta2w_q_ed_hzav,2).*intfac;
zeta2w_d_ed_vint = sum(zeta2w_d_ed_hzav,2).*intfac;
zeta2w_th_ed_vint = sum(zeta2w_th_ed_hzav,2).*intfac;

zeta2w_w_ed_vint_surf = sum(zeta2w_w_ed_hzav(:,1:8),2).*intfac;
zeta2w_h_ed_vint_surf = sum(zeta2w_h_ed_hzav(:,1:8),2).*intfac;
zeta2w_q_ed_vint_surf = sum(zeta2w_q_ed_hzav(:,1:8),2).*intfac;
zeta2w_d_ed_vint_surf = sum(zeta2w_d_ed_hzav(:,1:8),2).*intfac;
zeta2w_th_ed_vint_surf = sum(zeta2w_th_ed_hzav(:,1:8),2).*intfac;

zeta2w_w_ed_vint_top = sum(zeta2w_w_ed_hzav(:,9:25),2).*intfac;
zeta2w_h_ed_vint_top = sum(zeta2w_h_ed_hzav(:,9:25),2).*intfac;
zeta2w_q_ed_vint_top = sum(zeta2w_q_ed_hzav(:,9:25),2).*intfac;
zeta2w_d_ed_vint_top = sum(zeta2w_d_ed_hzav(:,9:25),2).*intfac;
zeta2w_th_ed_vint_top = sum(zeta2w_th_ed_hzav(:,9:25),2).*intfac;

duvdy_w_vint = sum(duvdy_w,2).*intfac;
duvdy_h_vint = sum(duvdy_h,2).*intfac;
duvdy_q_vint = sum(duvdy_q,2).*intfac;
duvdy_d_vint = sum(duvdy_d,2).*intfac;
duvdy_th_vint = sum(duvdy_th,2).*intfac;

duvdy_ed_w_vint = sum(duvdy_ed_w,2).*intfac;
duvdy_ed_h_vint = sum(duvdy_ed_h,2).*intfac;
duvdy_ed_q_vint = sum(duvdy_ed_q,2).*intfac;
duvdy_ed_d_vint = sum(duvdy_ed_d,2).*intfac;
duvdy_ed_th_vint = sum(duvdy_ed_th,2).*intfac;



%ACTUAL BITS TO PLOT 

C_total_w = uadvE_w_vint;
C_total_h = uadvE_h_vint;
C_total_q = uadvE_q_vint;
C_total_d = uadvE_d_vint;
C_total_th = uadvE_th_vint;

C_total_w_surf = zeta3v_w_tot_vint_surf + urE_w_vint_surf;
C_total_h_surf = zeta3v_h_tot_vint_surf + urE_h_vint_surf;
C_total_q_surf = zeta3v_q_tot_vint_surf + urE_q_vint_surf;
C_total_d_surf = zeta3v_d_tot_vint_surf + urE_d_vint_surf;
C_total_th_surf = zeta3v_th_tot_vint_surf + urE_th_vint_surf;

C_total_w_top = zeta3v_w_tot_vint_top + urE_w_vint_top;
C_total_h_top = zeta3v_h_tot_vint_top + urE_h_vint_top;
C_total_q_top = zeta3v_q_tot_vint_top + urE_q_vint_top;
C_total_d_top = zeta3v_d_tot_vint_top + urE_d_vint_top;
C_total_th_top = zeta3v_th_tot_vint_top + urE_th_vint_top;

C_zonal_w = fvN_w_vint + zeta3v_w_zon_vint + zeta2w_w_vint;
C_zonal_h = fvN_h_vint + zeta3v_h_zon_vint + zeta2w_h_vint;
C_zonal_q = fvN_q_vint + zeta3v_q_zon_vint + zeta2w_q_vint;
C_zonal_d = fvN_d_vint + zeta3v_d_zon_vint + zeta2w_d_vint;
C_zonal_th = fvN_th_vint + zeta3v_th_zon_vint + zeta2w_th_vint;

C_zonal_w_surf = zeta3v_w_zon_vint_surf + zeta2w_w_vint_surf;
C_zonal_h_surf = zeta3v_h_zon_vint_surf + zeta2w_h_vint_surf;
C_zonal_q_surf = zeta3v_q_zon_vint_surf + zeta2w_q_vint_surf;
C_zonal_d_surf = zeta3v_d_zon_vint_surf + zeta2w_d_vint_surf;
C_zonal_th_surf = zeta3v_th_zon_vint_surf + zeta2w_th_vint_surf;

C_zonal_w_top = zeta3v_w_zon_vint_top + zeta2w_w_vint_top;
C_zonal_h_top = zeta3v_h_zon_vint_top + zeta2w_h_vint_top;
C_zonal_q_top = zeta3v_q_zon_vint_top + zeta2w_q_vint_top;
C_zonal_d_top = zeta3v_d_zon_vint_top + zeta2w_d_vint_top;
C_zonal_th_top = zeta3v_th_zon_vint_top + zeta2w_th_vint_top;

C_eddy_w = zeta3v_w_ed_vint + zeta2w_w_ed_vint;
C_eddy_h = zeta3v_h_ed_vint + zeta2w_h_ed_vint;
C_eddy_q = zeta3v_q_ed_vint + zeta2w_q_ed_vint;
C_eddy_d = zeta3v_d_ed_vint + zeta2w_d_ed_vint;
C_eddy_th = zeta3v_th_ed_vint + zeta2w_th_ed_vint;

C_eddy_w_surf = zeta3v_w_ed_vint_surf + zeta2w_w_ed_vint_surf;
C_eddy_h_surf = zeta3v_h_ed_vint_surf + zeta2w_h_ed_vint_surf;
C_eddy_q_surf = zeta3v_q_ed_vint_surf + zeta2w_q_ed_vint_surf;
C_eddy_d_surf = zeta3v_d_ed_vint_surf + zeta2w_d_ed_vint_surf;
C_eddy_th_surf = zeta3v_th_ed_vint_surf + zeta2w_th_ed_vint_surf;

C_eddy_w_top = zeta3v_w_ed_vint_top + zeta2w_w_ed_vint_top;
C_eddy_h_top = zeta3v_h_ed_vint_top + zeta2w_h_ed_vint_top;
C_eddy_q_top = zeta3v_q_ed_vint_top + zeta2w_q_ed_vint_top;
C_eddy_d_top = zeta3v_d_ed_vint_top + zeta2w_d_ed_vint_top;
C_eddy_th_top = zeta3v_th_ed_vint_top + zeta2w_th_ed_vint_top;


%plot(yi(46:90),fvN_w_vint,'k')
%hold on
%plot(yi(46:90),C_total_w+tauE_w_hzav','r')
%xlabel('Latitude')
%title('1xwv')
%xlim([0 90])
%return
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
plot(yi(46:90),C_total_d,'k')
hold on
plot(yi(46:90),C_zonal_d,'k:')
plot(yi(46:90),C_eddy_d,'k--')
plot(yi(46:90),-tauE_d_hzav,'k-.')
plot(yi(46:90),C_total_d+tauE_d_hzav','r:')
xlim([0 90])
ylim([-0.25 0.2])
ylabel('Zonal momentum budget terms, Nm^{-2}')
title('0xwv')
legend('C-total','C-zonal','C-eddy','Surface stress','Budget residual','location','SouthEast')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi(46:90),C_total_q,'k')
hold on
plot(yi(46:90),C_zonal_q,'k:')
plot(yi(46:90),C_eddy_q,'k--')
plot(yi(46:90),-tauE_q_hzav,'k-.')
plot(yi(46:90),C_total_q+tauE_q_hzav','r:')
xlim([0 90])
ylim([-0.25 0.2])
title('0.25xwv')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi(46:90),C_total_h,'k')
hold on
plot(yi(46:90),C_zonal_h,'k:')
plot(yi(46:90),C_eddy_h,'k--')
plot(yi(46:90),-tauE_h_hzav,'k-.')
plot(yi(46:90),C_total_h+tauE_h_hzav','r:')
xlabel('Latitude')
xlim([0 90])
ylim([-0.25 0.2])
title('0.5xwv')
ylabel('Zonal momentum budget terms, Nm^{-2}')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(yi(46:90),C_total_w,'k')
hold on
plot(yi(46:90),C_zonal_w,'k:')
plot(yi(46:90),C_eddy_w,'k--')
plot(yi(46:90),-tauE_w_hzav,'k-.')
plot(yi(46:90),C_total_w+tauE_w_hzav','r:')
xlabel('Latitude')
title('1xwv')
xlim([0 90])
ylim([-0.25 0.2])

print('-dpdf','mom_budg_main.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi(46:90),C_total_th,'k')
hold on
plot(yi(46:90),C_zonal_th,'k:')
plot(yi(46:90),C_eddy_th,'k--')
plot(yi(46:90),-tauE_th_hzav,'k-.')
plot(yi(46:90),C_total_th+tauE_th_hzav','r:')
xlim([0 90])
ylim([-0.25 0.2])
ylabel('Zonal momentum budget terms, Nm^{-2}')
title('tropheat')
legend('C-total','C-zonal','C-eddy','Surface stress','Budget residual','location','SouthEast')
print('-dpdf','mom_budg_mainth.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi(46:90),zeta3v_d_tot_vint,'k')
hold on
plot(yi(46:90),zeta3v_d_zon_vint,'k:')
plot(yi(46:90),zeta3v_d_ed_vint,'k--')
xlim([0 90])
ylim([-0.2 0.5])
ylabel('Zonal momentum budget terms, Nm^{-2}')
title('0xwv')
legend('<\zeta_{3}v>','<\zeta_{3}><v>','<\zeta_{3}''v''>')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi(46:90),zeta3v_q_tot_vint,'k')
hold on
plot(yi(46:90),zeta3v_q_zon_vint,'k:')
plot(yi(46:90),zeta3v_q_ed_vint,'k--')
xlim([0 90])
ylim([-0.2 0.5])
title('0.25xwv')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi(46:90),zeta3v_h_tot_vint,'k')
hold on
plot(yi(46:90),zeta3v_h_zon_vint,'k:')
plot(yi(46:90),zeta3v_h_ed_vint,'k--')
xlim([0 90])
ylim([-0.2 0.5])
ylabel('Zonal momentum budget terms, Nm^{-2}')
xlabel('Latitude')
title('0.5xwv')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(yi(46:90),zeta3v_w_tot_vint,'k')
hold on
plot(yi(46:90),zeta3v_w_zon_vint,'k:')
plot(yi(46:90),zeta3v_w_ed_vint,'k--')
xlim([0 90])
ylim([-0.2 0.5])
xlabel('Latitude')
title('1xwv')

print('-dpdf','zeta3v.pdf')

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi(46:90),zeta3v_th_tot_vint,'k')
hold on
plot(yi(46:90),zeta3v_th_zon_vint,'k:')
plot(yi(46:90),zeta3v_th_ed_vint,'k--')
xlim([0 90])
ylim([-0.2 0.5])
ylabel('Zonal momentum budget terms, Nm^{-2}')
title('tropheat')
legend('<\zeta_{3}v>','<\zeta_{3}><v>','<\zeta_{3}''v''>')
print('-dpdf','zeta3vth.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi(46:90),urE_d_vint,'k')
hold on
plot(yi(46:90),zeta2w_d_vint,'k:')
plot(yi(46:90),zeta2w_d_ed_vint,'k--')
xlim([0 90])
ylim([-0.6 0.1])
ylabel('Zonal momentum budget terms, Nm^{-2}')
title('0xwv')
legend('-<\zeta_{2}w>','-<\zeta_{2}><w>','-<\zeta_{2}''w''>','location','SouthEast')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi(46:90),urE_q_vint,'k')
hold on
plot(yi(46:90),zeta2w_q_vint,'k:')
plot(yi(46:90),zeta2w_q_ed_vint,'k--')
xlim([0 90])
ylim([-0.6 0.1])
title('0.25xwv')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi(46:90),urE_h_vint,'k')
hold on
plot(yi(46:90),zeta2w_h_vint,'k:')
plot(yi(46:90),zeta2w_h_ed_vint,'k--')
xlim([0 90])
ylim([-0.6 0.1])
ylabel('Zonal momentum budget terms, Nm^{-2}')
xlabel('Latitude')
title('0.5xwv')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(yi(46:90),urE_w_vint,'k')
hold on
plot(yi(46:90),zeta2w_w_vint,':k')
plot(yi(46:90),zeta2w_w_ed_vint,'k--')
xlim([0 90])
ylim([-0.6 0.1])
xlabel('Latitude')
title('1xwv')

print('-dpdf','zeta2w.pdf')

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi(46:90),urE_th_vint,'k')
hold on
plot(yi(46:90),zeta2w_th_vint,'k:')
plot(yi(46:90),zeta2w_th_ed_vint,'k--')
xlim([0 90])
ylim([-0.6 0.1])
ylabel('Zonal momentum budget terms, Nm^{-2}')
title('tropheat')
legend('-<\zeta_{2}w>','-<\zeta_{2}><w>','-<\zeta_{2}''w''>','location','SouthEast')

print('-dpdf','zeta2wth.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi(46:90),C_total_d_surf,'k')
hold on
plot(yi(46:90),C_zonal_d_surf,'k:')
plot(yi(46:90),C_eddy_d_surf,'k--')
plot(yi(46:90),fvN_d_vint_surf,'b')
plot(yi(46:90),-tauE_d_hzav,'k-.')
xlim([0 90])
ylim([-0.25 0.2])
ylabel('Zonal momentum budget terms, Nm^{-2}')
title('0xwv')
legend('C-total','C-zonal','C-eddy','fv','Surface stress','location','SouthEast')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi(46:90),C_total_q_surf,'k')
hold on
plot(yi(46:90),C_zonal_q_surf,'k:')
plot(yi(46:90),C_eddy_q_surf,'k--')
plot(yi(46:90),fvN_q_vint_surf,'b')
plot(yi(46:90),-tauE_q_hzav,'k-.')
xlim([0 90])
ylim([-0.25 0.2])
title('0.25xwv')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi(46:90),C_total_h_surf,'k')
hold on
plot(yi(46:90),C_zonal_h_surf,'k:')
plot(yi(46:90),C_eddy_h_surf,'k--')
plot(yi(46:90),fvN_h_vint_surf,'b')
plot(yi(46:90),-tauE_h_hzav,'k-.')
xlabel('Latitude')
xlim([0 90])
ylim([-0.25 0.2])
title('0.5xwv')
ylabel('Zonal momentum budget terms, Nm^{-2}')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(yi(46:90),C_total_w_surf,'k')
hold on
plot(yi(46:90),C_zonal_w_surf,'k:')
plot(yi(46:90),C_eddy_w_surf,'k--')
plot(yi(46:90),fvN_w_vint_surf,'b')
plot(yi(46:90),-tauE_w_hzav,'k-.')
xlabel('Latitude')
title('1xwv')
xlim([0 90])
ylim([-0.25 0.2])

print('-dpdf','mom_budg_surf.pdf')

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi(46:90),C_total_th_surf,'k')
hold on
plot(yi(46:90),C_zonal_th_surf,'k:')
plot(yi(46:90),C_eddy_th_surf,'k--')
plot(yi(46:90),fvN_th_vint_surf,'b')
plot(yi(46:90),-tauE_th_hzav,'k-.')
xlim([0 90])
ylim([-0.25 0.2])
ylabel('Zonal momentum budget terms, Nm^{-2}')
title('tropheat')
legend('C-total','C-zonal','C-eddy','fv','Surface stress','location','SouthEast')
print('-dpdf','mom_budg_surfth.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi(46:90),C_total_d_top,'k')
hold on
plot(yi(46:90),C_zonal_d_top,'k:')
plot(yi(46:90),C_eddy_d_top,'k--')
plot(yi(46:90),fvN_d_vint_top,'b')
xlim([0 90])
ylim([-0.25 0.2])
ylabel('Zonal momentum budget terms, Nm^{-2}')
title('0xwv')
legend('C-total','C-zonal','C-eddy','fv','location','SouthEast')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi(46:90),C_total_q_top,'k')
hold on
plot(yi(46:90),C_zonal_q_top,'k:')
plot(yi(46:90),C_eddy_q_top,'k--')
plot(yi(46:90),fvN_q_vint_top,'b')
xlim([0 90])
ylim([-0.25 0.2])
title('0.25xwv')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi(46:90),C_total_h_top,'k')
hold on
plot(yi(46:90),C_zonal_h_top,'k:')
plot(yi(46:90),C_eddy_h_top,'k--')
plot(yi(46:90),fvN_h_vint_top,'b')
xlabel('Latitude')
xlim([0 90])
ylim([-0.25 0.2])
title('0.5xwv')
ylabel('Zonal momentum budget terms, Nm^{-2}')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(yi(46:90),C_total_w_top,'k')
hold on
plot(yi(46:90),C_zonal_w_top,'k:')
plot(yi(46:90),C_eddy_w_top,'k--')
plot(yi(46:90),fvN_w_vint_top,'b')
xlabel('Latitude')
title('1xwv')
xlim([0 90])
ylim([-0.25 0.2])

print('-dpdf','mom_budg_top.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi(46:90),C_total_th_top,'k')
hold on
plot(yi(46:90),C_zonal_th_top,'k:')
plot(yi(46:90),C_eddy_th_top,'k--')
plot(yi(46:90),fvN_th_vint_top,'b')
xlim([0 90])
ylim([-0.25 0.2])
ylabel('Zonal momentum budget terms, Nm^{-2}')
title('tropheat')
legend('C-total','C-zonal','C-eddy','fv','location','SouthEast')
print('-dpdf','mom_budg_topth.pdf')
