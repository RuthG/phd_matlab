%FINALLY SORT OUT THE MOMENTUM BUDGET WOOOO

%Read in iteration number, directory, MITgcm output and grid details

rDir='/disk1/MITgcm/verification/atm_gray_ruth/run_radon_varyingwin/';
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
for nit = 62640:240:86400;
i=i+1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% VW Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/run_radon_varyingwin/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_vw(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_vw(:,:,:,i) = dyn(:,:,:,J);
[uE_vw(:,:,:,i),vN_vw(:,:,:,i)] = rotate_uv2uvEN(ucs_vw(:,:,:,i),vcs_vw(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'WVEL    '));
w_vw(:,:,:,i) = dyn(:,:,:,J);

%vort3u term = (f + zeta3)v
J=find(strcmp(fldList,'Um_AdvZ3'));
uzcs_vw(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvZ3'));
vzcs_vw(:,:,:,i) = dyn(:,:,:,J);
[uzE_vw(:,:,:,i),vzN_vw(:,:,:,i)] = rotate_uv2uvEN(uzcs_vw(:,:,:,i),vzcs_vw(:,:,:,i),AngleCS,AngleSN,Grid);

%shear term = - zeta2w
J=find(strcmp(fldList,'Um_AdvRe'));
urcs_vw(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvRe'));
vrcs_vw(:,:,:,i) = dyn(:,:,:,J);
[urE_vw(:,:,:,i),vrN_vw(:,:,:,i)] = rotate_uv2uvEN(urcs_vw(:,:,:,i),vrcs_vw(:,:,:,i),AngleCS,AngleSN,Grid);

%total = vort3+shear term
J=find(strcmp(fldList,'Um_Advec'));
uadvcs_vw(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_Advec'));
vadvcs_vw(:,:,:,i) = dyn(:,:,:,J);
[uadvE_vw(:,:,:,i),vadvN_vw(:,:,:,i)] = rotate_uv2uvEN(uadvcs_vw(:,:,:,i),vadvcs_vw(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'momVort3'));
vort3_vw(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UV_VEL_C'));
uv_vw(:,:,:,i) = dyn(:,:,:,J);

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhTauX'));
tauxcs_vw(:,:,i)=surf(:,:,J);
J=find(strcmp(fldList,'AtPhTauY'));
tauycs_vw(:,:,i)=surf(:,:,J);
[tauE_vw(:,:,i),tauW_vw(:,:,i)] = rotate_uv2uvEN(tauxcs_vw(:,:,i),tauycs_vw(:,:,i),AngleCS,AngleSN,Grid);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% NP WV Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/run_radon_cwnp/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_np(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_np(:,:,:,i) = dyn(:,:,:,J);
[uE_np(:,:,:,i),vN_np(:,:,:,i)] = rotate_uv2uvEN(ucs_np(:,:,:,i),vcs_np(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'WVEL    '));
w_np(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'Um_AdvZ3'));
uzcs_np(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvZ3'));
vzcs_np(:,:,:,i) = dyn(:,:,:,J);
[uzE_np(:,:,:,i),vzN_np(:,:,:,i)] = rotate_uv2uvEN(uzcs_np(:,:,:,i),vzcs_np(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'Um_AdvRe'));
urcs_np(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvRe'));
vrcs_np(:,:,:,i) = dyn(:,:,:,J);
[urE_np(:,:,:,i),vrN_np(:,:,:,i)] = rotate_uv2uvEN(urcs_np(:,:,:,i),vrcs_np(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'Um_Advec'));
uadvcs_np(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_Advec'));
vadvcs_np(:,:,:,i) = dyn(:,:,:,J);
[uadvE_np(:,:,:,i),vadvN_np(:,:,:,i)] = rotate_uv2uvEN(uadvcs_np(:,:,:,i),vadvcs_np(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'momVort3'));
vort3_np(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UV_VEL_C'));
uv_np(:,:,:,i) = dyn(:,:,:,J);

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhTauX'));
tauxcs_np(:,:,i)=surf(:,:,J);
J=find(strcmp(fldList,'AtPhTauY'));
tauycs_np(:,:,i)=surf(:,:,J);
[tauE_np(:,:,i),tauW_np(:,:,i)] = rotate_uv2uvEN(tauxcs_np(:,:,i),tauycs_np(:,:,i),AngleCS,AngleSN,Grid);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% ORIG WV Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/run_radon_doshallower/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_orig = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_orig = dyn(:,:,:,J);
[uE_orig,vN_orig] = rotate_uv2uvEN(ucs_orig,vcs_orig,AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'WVEL    '));
w_orig = dyn(:,:,:,J);

J=find(strcmp(fldList,'Um_AdvZ3'));
uzcs_orig = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvZ3'));
vzcs_orig = dyn(:,:,:,J);
[uzE_orig,vzN_orig] = rotate_uv2uvEN(uzcs_orig,vzcs_orig,AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'Um_AdvRe'));
urcs_orig = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvRe'));
vrcs_orig = dyn(:,:,:,J);
[urE_orig,vrN_orig] = rotate_uv2uvEN(urcs_orig,vrcs_orig,AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'Um_Advec'));
uadvcs_orig = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_Advec'));
vadvcs_orig = dyn(:,:,:,J);
[uadvE_orig,vadvN_orig] = rotate_uv2uvEN(uadvcs_orig,vadvcs_orig,AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'momVort3'));
vort3_orig = dyn(:,:,:,J);
J=find(strcmp(fldList,'UV_VEL_C'));
uv_orig = dyn(:,:,:,J);

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhTauX'));
tauxcs_orig=surf(:,:,J);
J=find(strcmp(fldList,'AtPhTauY'));
tauycs_orig=surf(:,:,J);
[tauE_orig,tauW_orig] = rotate_uv2uvEN(tauxcs_orig,tauycs_orig,AngleCS,AngleSN,Grid);


%take time means

uE_vw_mean = mean(uE_vw,4);
vN_vw_mean = mean(vN_vw,4);
uzE_vw_mean = mean(uzE_vw,4);
urE_vw_mean = mean(urE_vw,4);
uadvE_vw_mean = mean(uadvE_vw,4);
tauE_vw_mean = mean(tauE_vw,3);
w_vw_mean = mean(w_vw,4);
vort3_vw_mean = mean(vort3_vw,4);
uv_vw_mean = mean(uv_vw,4);

uE_np_mean = mean(uE_np,4);
vN_np_mean = mean(vN_np,4);
uzE_np_mean = mean(uzE_np,4);
urE_np_mean = mean(urE_np,4);
uadvE_np_mean = mean(uadvE_np,4);
tauE_np_mean = mean(tauE_np,3);
w_np_mean = mean(w_np,4);
vort3_np_mean = mean(vort3_np,4);
uv_np_mean = mean(uv_np,4);

%switch to lat lon grid

xi=-179:2:180;yi=-89:2:90;
uEll_vw=cube2latlon(xc,yc,uE_vw_mean,xi,yi);
vNll_vw=cube2latlon(xc,yc,vN_vw_mean,xi,yi);
uzEll_vw=cube2latlon(xc,yc,uzE_vw_mean,xi,yi);
urEll_vw=cube2latlon(xc,yc,urE_vw_mean,xi,yi);
uadvEll_vw=cube2latlon(xc,yc,uadvE_vw_mean,xi,yi);
tauEll_vw=cube2latlon(xc,yc,tauE_vw_mean,xi,yi);
wll_vw=cube2latlon(xc,yc,w_vw_mean,xi,yi);
vort3ll_vw=cube2latlon(xc,yc,vort3_vw_mean,xi,yi);
uvll_vw=cube2latlon(xc,yc,uv_vw_mean,xi,yi);

uEll_np=cube2latlon(xc,yc,uE_np_mean,xi,yi);
vNll_np=cube2latlon(xc,yc,vN_np_mean,xi,yi);
uzEll_np=cube2latlon(xc,yc,uzE_np_mean,xi,yi);
urEll_np=cube2latlon(xc,yc,urE_np_mean,xi,yi);
uadvEll_np=cube2latlon(xc,yc,uadvE_np_mean,xi,yi);
tauEll_np=cube2latlon(xc,yc,tauE_np_mean,xi,yi);
wll_np=cube2latlon(xc,yc,w_np_mean,xi,yi);
vort3ll_np=cube2latlon(xc,yc,vort3_np_mean,xi,yi);
uvll_np=cube2latlon(xc,yc,uv_np_mean,xi,yi);

uEll_orig=cube2latlon(xc,yc,uE_orig,xi,yi);
vNll_orig=cube2latlon(xc,yc,vN_orig,xi,yi);
uzEll_orig=cube2latlon(xc,yc,uzE_orig,xi,yi);
urEll_orig=cube2latlon(xc,yc,urE_orig,xi,yi);
uadvEll_orig=cube2latlon(xc,yc,uadvE_orig,xi,yi);
tauEll_orig=cube2latlon(xc,yc,tauE_orig,xi,yi);
wll_orig=cube2latlon(xc,yc,w_orig,xi,yi);
vort3ll_orig=cube2latlon(xc,yc,vort3_orig,xi,yi);
uvll_orig=cube2latlon(xc,yc,uv_orig,xi,yi);


%and take zonal av

uE_vw_zav(:,:) = mean(uEll_vw,1);
vN_vw_zav(:,:) = mean(vNll_vw,1);
uzE_vw_zav(:,:) = mean(uzEll_vw,1);
urE_vw_zav(:,:) = mean(urEll_vw,1);
uadvE_vw_zav(:,:) = mean(uadvEll_vw,1);
tauE_vw_zav = mean(tauEll_vw,1);
w_vw_zav(:,:) = mean(wll_vw,1);
vort3_vw_zav(:,:) = mean(vort3ll_vw,1);
uv_vw_zav(:,:) = mean(uvll_vw,1);

uE_np_zav(:,:) = mean(uEll_np,1);
vN_np_zav(:,:) = mean(vNll_np,1);
uzE_np_zav(:,:) = mean(uzEll_np,1);
urE_np_zav(:,:) = mean(urEll_np,1);
uadvE_np_zav(:,:) = mean(uadvEll_np,1);
tauE_np_zav = mean(tauEll_np,1);
w_np_zav(:,:) = mean(wll_np,1);
vort3_np_zav(:,:) = mean(vort3ll_np,1);
uv_np_zav(:,:) = mean(uvll_np,1);

uE_orig_zav(:,:) = mean(uEll_orig,1);
vN_orig_zav(:,:) = mean(vNll_orig,1);
uzE_orig_zav(:,:) = mean(uzEll_orig,1);
urE_orig_zav(:,:) = mean(urEll_orig,1);
uadvE_orig_zav(:,:) = mean(uadvEll_orig,1);
tauE_orig_zav = mean(tauEll_orig,1);
w_orig_zav(:,:) = mean(wll_orig,1);
vort3_orig_zav(:,:) = mean(vort3ll_orig,1);
uv_orig_zav(:,:) = mean(uvll_orig,1);


%and take hzav

for i=1:45

uE_vw_hzav(i,:) = (uE_vw_zav(45+i,:) + uE_vw_zav(46-i,:))./2;
vN_vw_hzav(i,:) = (vN_vw_zav(45+i,:) - vN_vw_zav(46-i,:))./2;
uzE_vw_hzav(i,:) = (uzE_vw_zav(45+i,:) + uzE_vw_zav(46-i,:))./2;
urE_vw_hzav(i,:) = (urE_vw_zav(45+i,:) + urE_vw_zav(46-i,:))./2;
uadvE_vw_hzav(i,:) = (uadvE_vw_zav(45+i,:) + uadvE_vw_zav(46-i,:))./2;
tauE_vw_hzav(i) = (tauE_vw_zav(45+i) + tauE_vw_zav(46-i))./2;
w_vw_hzav(i,:) = (w_vw_zav(45+i,:) + w_vw_zav(46-i,:))./2;
vort3_vw_hzav(i,:) = (vort3_vw_zav(45+i,:) - vort3_vw_zav(46-i,:))./2;
uv_vw_hzav(i,:) = (uv_vw_zav(45+i,:) - uv_vw_zav(46-i,:))./2;

uE_np_hzav(i,:) = (uE_np_zav(45+i,:) + uE_np_zav(46-i,:))./2;
vN_np_hzav(i,:) = (vN_np_zav(45+i,:) - vN_np_zav(46-i,:))./2;
uzE_np_hzav(i,:) = (uzE_np_zav(45+i,:) + uzE_np_zav(46-i,:))./2;
urE_np_hzav(i,:) = (urE_np_zav(45+i,:) + urE_np_zav(46-i,:))./2;
uadvE_np_hzav(i,:) = (uadvE_np_zav(45+i,:) + uadvE_np_zav(46-i,:))./2;
tauE_np_hzav(i) = (tauE_np_zav(45+i) + tauE_np_zav(46-i))./2;
w_np_hzav(i,:) = (w_np_zav(45+i,:) + w_np_zav(46-i,:))./2;
vort3_np_hzav(i,:) = (vort3_np_zav(45+i,:) - vort3_np_zav(46-i,:))./2;
uv_np_hzav(i,:) = (uv_np_zav(45+i,:) - uv_np_zav(46-i,:))./2;

uE_orig_hzav(i,:) = (uE_orig_zav(45+i,:) + uE_orig_zav(46-i,:))./2;
vN_orig_hzav(i,:) = (vN_orig_zav(45+i,:) - vN_orig_zav(46-i,:))./2;
uzE_orig_hzav(i,:) = (uzE_orig_zav(45+i,:) + uzE_orig_zav(46-i,:))./2;
urE_orig_hzav(i,:) = (urE_orig_zav(45+i,:) + urE_orig_zav(46-i,:))./2;
uadvE_orig_hzav(i,:) = (uadvE_orig_zav(45+i,:) + uadvE_orig_zav(46-i,:))./2;
tauE_orig_hzav(i) = (tauE_orig_zav(45+i) + tauE_orig_zav(46-i))./2;
w_orig_hzav(i,:) = (w_orig_zav(45+i,:) + w_orig_zav(46-i,:))./2;
vort3_orig_hzav(i,:) = (vort3_orig_zav(45+i,:) - vort3_orig_zav(46-i,:))./2;
uv_orig_hzav(i,:) = (uv_orig_zav(45+i,:) - uv_orig_zav(46-i,:))./2;


end

uv_ed_vw_hzav = uv_vw_hzav - uE_vw_hzav.*vN_vw_hzav;
uv_ed_np_hzav = uv_np_hzav - uE_np_hzav.*vN_np_hzav;
uv_ed_orig_hzav = uv_orig_hzav - uE_orig_hzav.*vN_orig_hzav;

f = zeros(45,25);
cosphi = zeros(45,25);
omega = 2.*pi./(24.*60.*60);
for i=1:25
f(:,i) = 2.*omega.*sin(yi(46:90).*pi./180);
cosphi(:,i) = cos(yi(46:90).*pi./180);
end

%calculate vertical and horizontal gradients of u
a = 6371.0e3;
uE_vw_weighted = uE_vw_hzav.*cosphi;
uE_np_weighted = uE_np_hzav.*cosphi;
uE_orig_weighted = uE_orig_hzav.*cosphi;


uv_vw_weighted = uv_vw_hzav.*cosphi.^2;
uv_np_weighted = uv_np_hzav.*cosphi.^2;
uv_orig_weighted = uv_orig_hzav.*cosphi.^2;


uv_ed_vw_weighted = uv_ed_vw_hzav.*cosphi.^2;
uv_ed_np_weighted = uv_ed_np_hzav.*cosphi.^2;
uv_ed_orig_weighted = uv_ed_orig_hzav.*cosphi.^2;


[moo,dudy_s] = gradient(uE_vw_weighted,pi./90);
dudy_vw = dudy_s./cosphi./a;
[moo,dudy_s] = gradient(uE_np_weighted,pi./90);
dudy_np = dudy_s./cosphi./a;
[moo,dudy_s] = gradient(uE_orig_weighted,pi./90);
dudy_orig = dudy_s./cosphi./a;


[moo,duvdy_s] = gradient(uv_vw_weighted,pi./90);
duvdy_vw = duvdy_s./cosphi./cosphi./a;
[moo,duvdy_s] = gradient(uv_np_weighted,pi./90);
duvdy_np = duvdy_s./cosphi./cosphi./a;
[moo,duvdy_s] = gradient(uv_orig_weighted,pi./90);
duvdy_orig = duvdy_s./cosphi./cosphi./a;


[moo,duvdy_s_ed] = gradient(uv_ed_vw_weighted,pi./90);
duvdy_ed_vw = duvdy_s_ed./cosphi./cosphi./a;
[moo,duvdy_s_ed] = gradient(uv_ed_np_weighted,pi./90);
duvdy_ed_np = duvdy_s_ed./cosphi./cosphi./a;
[moo,duvdy_s_ed] = gradient(uv_ed_orig_weighted,pi./90);
duvdy_ed_orig = duvdy_s_ed./cosphi./cosphi./a;


dudp_vw = gradient(uE_vw_hzav,-4000);
dudp_np = gradient(uE_np_hzav,-4000);
dudp_orig = gradient(uE_orig_hzav,-4000);


%If -dudy is equivalent to vort3, which it is, then dudp should be an ok approx to vort2 :)

%Now we want to evaluate and vertically integrate:
%fv, f, v

fvN_vw_hzav = f.*vN_vw_hzav;
fvN_np_hzav = f.*vN_np_hzav;
fvN_orig_hzav = f.*vN_orig_hzav;


%zeta3v, total, zonal and eddy

zeta3v_vw_tot_hzav = uzE_vw_hzav - fvN_vw_hzav;
zeta3v_np_tot_hzav = uzE_np_hzav - fvN_np_hzav;
zeta3v_orig_tot_hzav = uzE_orig_hzav - fvN_orig_hzav;


zeta3v_vw_zon_hzav = vort3_vw_hzav.*vN_vw_hzav;
zeta3v_np_zon_hzav = vort3_np_hzav.*vN_np_hzav;
zeta3v_orig_zon_hzav = vort3_orig_hzav.*vN_orig_hzav;


zeta3v_vw_ed_hzav = zeta3v_vw_tot_hzav - zeta3v_vw_zon_hzav;
zeta3v_np_ed_hzav = zeta3v_np_tot_hzav - zeta3v_np_zon_hzav;
zeta3v_orig_ed_hzav = zeta3v_orig_tot_hzav - zeta3v_orig_zon_hzav;


%zeta2w, total, zonal and eddy

zeta2w_vw_hzav = -dudp_vw.*w_vw_hzav;
zeta2w_np_hzav = -dudp_np.*w_np_hzav;
zeta2w_orig_hzav = -dudp_orig.*w_orig_hzav;


zeta2w_vw_ed_hzav = urE_vw_hzav - zeta2w_vw_hzav;
zeta2w_np_ed_hzav = urE_np_hzav - zeta2w_np_hzav;
zeta2w_orig_ed_hzav = urE_orig_hzav - zeta2w_orig_hzav;


%friction - done


%take vertical integrals

intfac = 4000./9.81;


uadvE_vw_vint = sum(uadvE_vw_hzav,2).*intfac;
uadvE_np_vint = sum(uadvE_np_hzav,2).*intfac;
uadvE_orig_vint = sum(uadvE_orig_hzav,2).*intfac;


uadvE_vw_vint_surf = sum(uadvE_vw_hzav(:,1:8),2).*intfac;
uadvE_np_vint_surf = sum(uadvE_np_hzav(:,1:8),2).*intfac;
uadvE_orig_vint_surf = sum(uadvE_orig_hzav(:,1:8),2).*intfac;

uadvE_vw_vint_top = sum(uadvE_vw_hzav(:,9:25),2).*intfac;
uadvE_np_vint_top = sum(uadvE_np_hzav(:,9:25),2).*intfac;
uadvE_orig_vint_top = sum(uadvE_orig_hzav(:,9:25),2).*intfac;

uadvE_vw_vint_jet = sum(uadvE_vw_hzav(:,19:24),2).*intfac;
uadvE_np_vint_jet = sum(uadvE_np_hzav(:,19:24),2).*intfac;
uadvE_orig_vint_jet = sum(uadvE_orig_hzav(:,19:24),2).*intfac;


uzE_vw_vint = sum(uzE_vw_hzav,2).*intfac;
uzE_np_vint = sum(uzE_np_hzav,2).*intfac;
uzE_orig_vint = sum(uzE_orig_hzav,2).*intfac;

uzE_vw_vint_surf = sum(uzE_vw_hzav(:,1:8),2).*intfac;
uzE_np_vint_surf = sum(uzE_np_hzav(:,1:8),2).*intfac;
uzE_orig_vint_surf = sum(uzE_orig_hzav(:,1:8),2).*intfac;

uzE_vw_vint_top = sum(uzE_vw_hzav(:,9:25),2).*intfac;
uzE_np_vint_top = sum(uzE_np_hzav(:,9:25),2).*intfac;
uzE_orig_vint_top = sum(uzE_orig_hzav(:,9:25),2).*intfac;

uzE_vw_vint_jet = sum(uzE_vw_hzav(:,19:24),2).*intfac;
uzE_np_vint_jet = sum(uzE_np_hzav(:,19:24),2).*intfac;
uzE_orig_vint_jet = sum(uzE_orig_hzav(:,19:24),2).*intfac;


fvN_vw_vint = sum(fvN_vw_hzav,2).*intfac;
fvN_np_vint = sum(fvN_np_hzav,2).*intfac;
fvN_orig_vint = sum(fvN_orig_hzav,2).*intfac;

fvN_vw_vint_surf = sum(fvN_vw_hzav(:,1:8),2).*intfac;
fvN_np_vint_surf = sum(fvN_np_hzav(:,1:8),2).*intfac;
fvN_orig_vint_surf = sum(fvN_orig_hzav(:,1:8),2).*intfac;

fvN_vw_vint_top = sum(fvN_vw_hzav(:,9:25),2).*intfac;
fvN_np_vint_top = sum(fvN_np_hzav(:,9:25),2).*intfac;
fvN_orig_vint_top = sum(fvN_orig_hzav(:,9:25),2).*intfac;

fvN_vw_vint_jet = sum(fvN_vw_hzav(:,19:24),2).*intfac;
fvN_np_vint_jet = sum(fvN_np_hzav(:,19:24),2).*intfac;
fvN_orig_vint_jet = sum(fvN_orig_hzav(:,19:24),2).*intfac;


zeta3v_vw_zon_vint = sum(zeta3v_vw_zon_hzav,2).*intfac;
zeta3v_np_zon_vint = sum(zeta3v_np_zon_hzav,2).*intfac;
zeta3v_orig_zon_vint = sum(zeta3v_orig_zon_hzav,2).*intfac;

zeta3v_vw_zon_vint_surf = sum(zeta3v_vw_zon_hzav(:,1:8),2).*intfac;
zeta3v_np_zon_vint_surf = sum(zeta3v_np_zon_hzav(:,1:8),2).*intfac;
zeta3v_orig_zon_vint_surf = sum(zeta3v_orig_zon_hzav(:,1:8),2).*intfac;

zeta3v_vw_zon_vint_top = sum(zeta3v_vw_zon_hzav(:,9:25),2).*intfac;
zeta3v_np_zon_vint_top = sum(zeta3v_np_zon_hzav(:,9:25),2).*intfac;
zeta3v_orig_zon_vint_top = sum(zeta3v_orig_zon_hzav(:,9:25),2).*intfac;

zeta3v_vw_zon_vint_jet = sum(zeta3v_vw_zon_hzav(:,19:24),2).*intfac;
zeta3v_np_zon_vint_jet = sum(zeta3v_np_zon_hzav(:,19:24),2).*intfac;
zeta3v_orig_zon_vint_jet = sum(zeta3v_orig_zon_hzav(:,19:24),2).*intfac;


zeta3v_vw_tot_vint = sum(zeta3v_vw_tot_hzav,2).*intfac;
zeta3v_np_tot_vint = sum(zeta3v_np_tot_hzav,2).*intfac;
zeta3v_orig_tot_vint = sum(zeta3v_orig_tot_hzav,2).*intfac;

zeta3v_vw_tot_vint_surf = sum(zeta3v_vw_tot_hzav(:,1:8),2).*intfac;
zeta3v_np_tot_vint_surf = sum(zeta3v_np_tot_hzav(:,1:8),2).*intfac;
zeta3v_orig_tot_vint_surf = sum(zeta3v_orig_tot_hzav(:,1:8),2).*intfac;

zeta3v_vw_tot_vint_top = sum(zeta3v_vw_tot_hzav(:,9:25),2).*intfac;
zeta3v_np_tot_vint_top = sum(zeta3v_np_tot_hzav(:,9:25),2).*intfac;
zeta3v_orig_tot_vint_top = sum(zeta3v_orig_tot_hzav(:,9:25),2).*intfac;

zeta3v_vw_tot_vint_jet = sum(zeta3v_vw_tot_hzav(:,19:24),2).*intfac;
zeta3v_np_tot_vint_jet = sum(zeta3v_np_tot_hzav(:,19:24),2).*intfac;
zeta3v_orig_tot_vint_jet = sum(zeta3v_orig_tot_hzav(:,19:24),2).*intfac;


zeta3v_vw_ed_vint = sum(zeta3v_vw_ed_hzav,2).*intfac;
zeta3v_np_ed_vint = sum(zeta3v_np_ed_hzav,2).*intfac;
zeta3v_orig_ed_vint = sum(zeta3v_orig_ed_hzav,2).*intfac;

zeta3v_vw_ed_vint_surf = sum(zeta3v_vw_ed_hzav(:,1:8),2).*intfac;
zeta3v_np_ed_vint_surf = sum(zeta3v_np_ed_hzav(:,1:8),2).*intfac;
zeta3v_orig_ed_vint_surf = sum(zeta3v_orig_ed_hzav(:,1:8),2).*intfac;

zeta3v_vw_ed_vint_top = sum(zeta3v_vw_ed_hzav(:,9:25),2).*intfac;
zeta3v_np_ed_vint_top = sum(zeta3v_np_ed_hzav(:,9:25),2).*intfac;
zeta3v_orig_ed_vint_top = sum(zeta3v_orig_ed_hzav(:,9:25),2).*intfac;

zeta3v_vw_ed_vint_jet = sum(zeta3v_vw_ed_hzav(:,19:24),2).*intfac;
zeta3v_np_ed_vint_jet = sum(zeta3v_np_ed_hzav(:,19:24),2).*intfac;
zeta3v_orig_ed_vint_jet = sum(zeta3v_orig_ed_hzav(:,19:24),2).*intfac;


urE_vw_vint = sum(urE_vw_hzav,2).*intfac;
urE_np_vint = sum(urE_np_hzav,2).*intfac;
urE_orig_vint = sum(urE_orig_hzav,2).*intfac;

urE_vw_vint_surf = sum(urE_vw_hzav(:,1:8),2).*intfac;
urE_np_vint_surf = sum(urE_np_hzav(:,1:8),2).*intfac;
urE_orig_vint_surf = sum(urE_orig_hzav(:,1:8),2).*intfac;

urE_vw_vint_top = sum(urE_vw_hzav(:,9:25),2).*intfac;
urE_np_vint_top = sum(urE_np_hzav(:,9:25),2).*intfac;
urE_orig_vint_top = sum(urE_orig_hzav(:,9:25),2).*intfac;

urE_vw_vint_jet = sum(urE_vw_hzav(:,19:24),2).*intfac;
urE_np_vint_jet = sum(urE_np_hzav(:,19:24),2).*intfac;
urE_orig_vint_jet = sum(urE_orig_hzav(:,19:24),2).*intfac;


zeta2w_vw_vint = sum(zeta2w_vw_hzav,2).*intfac;
zeta2w_np_vint = sum(zeta2w_np_hzav,2).*intfac;
zeta2w_orig_vint = sum(zeta2w_orig_hzav,2).*intfac;

zeta2w_vw_vint_surf = sum(zeta2w_vw_hzav(:,1:8),2).*intfac;
zeta2w_np_vint_surf = sum(zeta2w_np_hzav(:,1:8),2).*intfac;
zeta2w_orig_vint_surf = sum(zeta2w_orig_hzav(:,1:8),2).*intfac;

zeta2w_vw_vint_top = sum(zeta2w_vw_hzav(:,9:25),2).*intfac;
zeta2w_np_vint_top = sum(zeta2w_np_hzav(:,9:25),2).*intfac;
zeta2w_orig_vint_top = sum(zeta2w_orig_hzav(:,9:25),2).*intfac;

zeta2w_vw_vint_jet = sum(zeta2w_vw_hzav(:,19:24),2).*intfac;
zeta2w_np_vint_jet = sum(zeta2w_np_hzav(:,19:24),2).*intfac;
zeta2w_orig_vint_jet = sum(zeta2w_orig_hzav(:,19:24),2).*intfac;


zeta2w_vw_ed_vint = sum(zeta2w_vw_ed_hzav,2).*intfac;
zeta2w_np_ed_vint = sum(zeta2w_np_ed_hzav,2).*intfac;
zeta2w_orig_ed_vint = sum(zeta2w_orig_ed_hzav,2).*intfac;

zeta2w_vw_ed_vint_surf = sum(zeta2w_vw_ed_hzav(:,1:8),2).*intfac;
zeta2w_np_ed_vint_surf = sum(zeta2w_np_ed_hzav(:,1:8),2).*intfac;
zeta2w_orig_ed_vint_surf = sum(zeta2w_orig_ed_hzav(:,1:8),2).*intfac;

zeta2w_vw_ed_vint_top = sum(zeta2w_vw_ed_hzav(:,9:25),2).*intfac;
zeta2w_np_ed_vint_top = sum(zeta2w_np_ed_hzav(:,9:25),2).*intfac;
zeta2w_orig_ed_vint_top = sum(zeta2w_orig_ed_hzav(:,9:25),2).*intfac;

zeta2w_vw_ed_vint_jet = sum(zeta2w_vw_ed_hzav(:,19:24),2).*intfac;
zeta2w_np_ed_vint_jet = sum(zeta2w_np_ed_hzav(:,19:24),2).*intfac;
zeta2w_orig_ed_vint_jet = sum(zeta2w_orig_ed_hzav(:,19:24),2).*intfac;


duvdy_vw_vint = sum(duvdy_vw,2).*intfac;
duvdy_np_vint = sum(duvdy_np,2).*intfac;
duvdy_orig_vint = sum(duvdy_orig,2).*intfac;

duvdy_ed_vw_vint = sum(duvdy_ed_vw,2).*intfac;
duvdy_ed_np_vint = sum(duvdy_ed_np,2).*intfac;
duvdy_ed_orig_vint = sum(duvdy_ed_orig,2).*intfac;




%ACTUAL BITS TO PLOT 

C_total_vw = uadvE_vw_vint;
C_total_np = uadvE_np_vint;
C_total_orig = uadvE_orig_vint;

C_total_vw_surf = zeta3v_vw_tot_vint_surf + urE_vw_vint_surf;
C_total_np_surf = zeta3v_np_tot_vint_surf + urE_np_vint_surf;
C_total_orig_surf = zeta3v_orig_tot_vint_surf + urE_orig_vint_surf;

C_total_vw_top = zeta3v_vw_tot_vint_top + urE_vw_vint_top;
C_total_np_top = zeta3v_np_tot_vint_top + urE_np_vint_top;
C_total_orig_top = zeta3v_orig_tot_vint_top + urE_orig_vint_top;

C_total_vw_jet = zeta3v_vw_tot_vint_jet + urE_vw_vint_jet;
C_total_np_jet = zeta3v_np_tot_vint_jet + urE_np_vint_jet;
C_total_orig_jet = zeta3v_orig_tot_vint_jet + urE_orig_vint_jet;


C_zonal_vw = fvN_vw_vint + zeta3v_vw_zon_vint + zeta2w_vw_vint;
C_zonal_np = fvN_np_vint + zeta3v_np_zon_vint + zeta2w_np_vint;
C_zonal_orig = fvN_orig_vint + zeta3v_orig_zon_vint + zeta2w_orig_vint;

C_zonal_vw_surf = zeta3v_vw_zon_vint_surf + zeta2w_vw_vint_surf;
C_zonal_np_surf = zeta3v_np_zon_vint_surf + zeta2w_np_vint_surf;
C_zonal_orig_surf = zeta3v_orig_zon_vint_surf + zeta2w_orig_vint_surf;

C_zonal_vw_top = zeta3v_vw_zon_vint_top + zeta2w_vw_vint_top;
C_zonal_np_top = zeta3v_np_zon_vint_top + zeta2w_np_vint_top;
C_zonal_orig_top = zeta3v_orig_zon_vint_top + zeta2w_orig_vint_top;

C_zonal_vw_jet = zeta3v_vw_zon_vint_jet + zeta2w_vw_vint_jet;
C_zonal_np_jet = zeta3v_np_zon_vint_jet + zeta2w_np_vint_jet;
C_zonal_orig_jet = zeta3v_orig_zon_vint_jet + zeta2w_orig_vint_jet;


C_eddy_vw = zeta3v_vw_ed_vint + zeta2w_vw_ed_vint;
C_eddy_np = zeta3v_np_ed_vint + zeta2w_np_ed_vint;
C_eddy_orig = zeta3v_orig_ed_vint + zeta2w_orig_ed_vint;

C_eddy_vw_surf = zeta3v_vw_ed_vint_surf + zeta2w_vw_ed_vint_surf;
C_eddy_np_surf = zeta3v_np_ed_vint_surf + zeta2w_np_ed_vint_surf;
C_eddy_orig_surf = zeta3v_orig_ed_vint_surf + zeta2w_orig_ed_vint_surf;

C_eddy_vw_top = zeta3v_vw_ed_vint_top + zeta2w_vw_ed_vint_top;
C_eddy_np_top = zeta3v_np_ed_vint_top + zeta2w_np_ed_vint_top;
C_eddy_orig_top = zeta3v_orig_ed_vint_top + zeta2w_orig_ed_vint_top;

C_eddy_vw_jet = zeta3v_vw_ed_vint_jet + zeta2w_vw_ed_vint_jet;
C_eddy_np_jet = zeta3v_np_ed_vint_jet + zeta2w_np_ed_vint_jet;
C_eddy_orig_jet = zeta3v_orig_ed_vint_jet + zeta2w_orig_ed_vint_jet;

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
plot(yi(46:90),C_total_orig,'k')
hold on
plot(yi(46:90),C_zonal_orig,'k:')
plot(yi(46:90),C_eddy_orig,'k--')
plot(yi(46:90),-tauE_orig_hzav,'k-.')
plot(yi(46:90),C_total_orig+tauE_orig_hzav','r:')
xlim([0 90])
ylim([-0.25 0.2])
title('orig')
ylabel('Zonal momentum budget terms, Nm^{-2}')
legend('C-total','C-zonal','C-eddy','Surface stress','Budget residual','location','SouthEast')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi(46:90),C_total_vw,'k')
hold on
plot(yi(46:90),C_zonal_vw,'k:')
plot(yi(46:90),C_eddy_vw,'k--')
plot(yi(46:90),-tauE_vw_hzav,'k-.')
plot(yi(46:90),C_total_vw+tauE_vw_hzav','r:')
xlabel('Latitude')
title('Varying Window Frac')
xlim([0 90])
ylim([-0.25 0.2])

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi(46:90),C_total_np,'k')
hold on
plot(yi(46:90),C_zonal_np,'k:')
plot(yi(46:90),C_eddy_np,'k--')
plot(yi(46:90),-tauE_np_hzav,'k-.')
plot(yi(46:90),C_total_np+tauE_np_hzav','r:')
xlabel('Latitude')
xlim([0 90])
ylim([-0.25 0.2])
title('Const Window, Improved Fit')
ylabel('Zonal momentum budget terms, Nm^{-2}')

print('-dpdf','mom_budg_main.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi(46:90),zeta3v_orig_tot_vint,'k')
hold on
plot(yi(46:90),zeta3v_orig_zon_vint,'k:')
plot(yi(46:90),zeta3v_orig_ed_vint,'k--')
xlim([0 90])
ylim([-0.2 0.5])
title('orig')
ylabel('Zonal momentum budget terms, Nm^{-2}')
legend('<\zeta_{3}v>','<\zeta_{3}><v>','<\zeta_{3}''v''>')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi(46:90),zeta3v_vw_tot_vint,'k')
hold on
plot(yi(46:90),zeta3v_vw_zon_vint,'k:')
plot(yi(46:90),zeta3v_vw_ed_vint,'k--')
xlim([0 90])
ylim([-0.2 0.5])
xlabel('Latitude')
title('Varying Window Frac')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi(46:90),zeta3v_np_tot_vint,'k')
hold on
plot(yi(46:90),zeta3v_np_zon_vint,'k:')
plot(yi(46:90),zeta3v_np_ed_vint,'k--')
xlim([0 90])
ylim([-0.2 0.5])
ylabel('Zonal momentum budget terms, Nm^{-2}')
xlabel('Latitude')
title('Const Window, Improved Fit')

print('-dpdf','zeta3v.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi(46:90),urE_orig_vint,'k')
hold on
plot(yi(46:90),zeta2w_orig_vint,'k:')
plot(yi(46:90),zeta2w_orig_ed_vint,'k--')
xlim([0 90])
ylim([-0.6 0.1])
title('orig')
ylabel('Zonal momentum budget terms, Nm^{-2}')
legend('-<\zeta_{2}w>','-<\zeta_{2}><w>','-<\zeta_{2}''w''>','location','SouthEast')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi(46:90),urE_vw_vint,'k')
hold on
plot(yi(46:90),zeta2w_vw_vint,':k')
plot(yi(46:90),zeta2w_vw_ed_vint,'k--')
xlim([0 90])
ylim([-0.6 0.1])
xlabel('Latitude')
title('Varying Window Frac')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi(46:90),urE_np_vint,'k')
hold on
plot(yi(46:90),zeta2w_np_vint,'k:')
plot(yi(46:90),zeta2w_np_ed_vint,'k--')
xlim([0 90])
ylim([-0.6 0.1])
ylabel('Zonal momentum budget terms, Nm^{-2}')
xlabel('Latitude')
title('Const Window, Improved Fit')



print('-dpdf','zeta2w.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi(46:90),C_total_orig_surf,'k')
hold on
plot(yi(46:90),C_zonal_orig_surf,'k:')
plot(yi(46:90),C_eddy_orig_surf,'k--')
plot(yi(46:90),fvN_orig_vint_surf,'b')
plot(yi(46:90),-tauE_orig_hzav,'k-.')
xlim([0 90])
ylim([-0.25 0.2])
title('orig')
ylabel('Zonal momentum budget terms, Nm^{-2}')
legend('C-total','C-zonal','C-eddy','fv','Surface stress','location','SouthEast')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi(46:90),C_total_vw_surf,'k')
hold on
plot(yi(46:90),C_zonal_vw_surf,'k:')
plot(yi(46:90),C_eddy_vw_surf,'k--')
plot(yi(46:90),fvN_vw_vint_surf,'b')
plot(yi(46:90),-tauE_vw_hzav,'k-.')
xlabel('Latitude')
title('1xwv')
xlim([0 90])
ylim([-0.25 0.2])
title('Varying Window Frac')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi(46:90),C_total_np_surf,'k')
hold on
plot(yi(46:90),C_zonal_np_surf,'k:')
plot(yi(46:90),C_eddy_np_surf,'k--')
plot(yi(46:90),fvN_np_vint_surf,'b')
plot(yi(46:90),-tauE_np_hzav,'k-.')
xlabel('Latitude')
xlim([0 90])
ylim([-0.25 0.2])
title('Const Window, Improved Fit')
ylabel('Zonal momentum budget terms, Nm^{-2}')

print('-dpdf','mom_budg_surf.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi(46:90),C_total_orig_top,'k')
hold on
plot(yi(46:90),C_zonal_orig_top,'k:')
plot(yi(46:90),C_eddy_orig_top,'k--')
plot(yi(46:90),fvN_orig_vint_top,'b')
xlim([0 90])
ylim([-0.25 0.2])
title('orig')
ylabel('Zonal momentum budget terms, Nm^{-2}')
legend('C-total','C-zonal','C-eddy','fv','location','SouthEast')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi(46:90),C_total_vw_top,'k')
hold on
plot(yi(46:90),C_zonal_vw_top,'k:')
plot(yi(46:90),C_eddy_vw_top,'k--')
plot(yi(46:90),fvN_vw_vint_top,'b')
xlabel('Latitude')
title('1xwv')
xlim([0 90])
ylim([-0.25 0.2])
title('Varying Window Frac')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi(46:90),C_total_np_top,'k')
hold on
plot(yi(46:90),C_zonal_np_top,'k:')
plot(yi(46:90),C_eddy_np_top,'k--')
plot(yi(46:90),fvN_np_vint_top,'b')
xlabel('Latitude')
xlim([0 90])
ylim([-0.25 0.2])
title('Const Window, Improved Fit')
ylabel('Zonal momentum budget terms, Nm^{-2}')

print('-dpdf','mom_budg_top.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi(46:90),C_total_orig_jet,'k')
hold on
plot(yi(46:90),C_zonal_orig_jet,'k:')
plot(yi(46:90),C_eddy_orig_jet,'k--')
plot(yi(46:90),fvN_orig_vint_jet,'b')
xlim([0 90])
ylim([-0.25 0.2])
title('orig')
ylabel('Zonal momentum budget terms, Nm^{-2}')
legend('C-total','C-zonal','C-eddy','fv','location','SouthEast')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi(46:90),C_total_vw_jet,'k')
hold on
plot(yi(46:90),C_zonal_vw_jet,'k:')
plot(yi(46:90),C_eddy_vw_jet,'k--')
plot(yi(46:90),fvN_vw_vint_jet,'b')
xlabel('Latitude')
title('1xwv')
xlim([0 90])
ylim([-0.25 0.2])
title('Varying Window Frac')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi(46:90),C_total_np_jet,'k')
hold on
plot(yi(46:90),C_zonal_np_jet,'k:')
plot(yi(46:90),C_eddy_np_jet,'k--')
plot(yi(46:90),fvN_np_vint_jet,'b')
xlabel('Latitude')
xlim([0 90])
ylim([-0.25 0.2])
title('Const Window, Improved Fit')
ylabel('Zonal momentum budget terms, Nm^{-2}')

print('-dpdf','mom_budg_jet.pdf')

