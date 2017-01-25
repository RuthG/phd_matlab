rDir='/project/rg312/final_runs/run_100_final/';
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
yi = -89:2:89;
xi=-179:2:179;

load('/project/rg312/mat_files/chapter2_variables/mombudg_tav_150.mat')
load('/project/rg312/mat_files/chapter2_variables/epvars_tav_150.mat','uv_tav')
load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_150.mat','uE_tav','vN_tav','w_tav')

uE_ll=cube2latlon(xc,yc,uE_tav,xi,yi);
vN_ll=cube2latlon(xc,yc,vN_tav,xi,yi);
uzE_ll=cube2latlon(xc,yc,uzE,xi,yi);
urE_ll=cube2latlon(xc,yc,urE,xi,yi);
uadvE_ll=cube2latlon(xc,yc,uadvE,xi,yi);
tauE_ll=cube2latlon(xc,yc,tauE,xi,yi);
w_ll=cube2latlon(xc,yc,w_tav,xi,yi);
vort3_ll=cube2latlon(xc,yc,vort3_tav,xi,yi);
uv_ll=cube2latlon(xc,yc,uv_tav,xi,yi);

uE_zav(:,:) = mean(uE_ll,1);
vN_zav(:,:) = mean(vN_ll,1);
uzE_zav(:,:) = mean(uzE_ll,1);
urE_zav(:,:) = mean(urE_ll,1);
uadvE_zav(:,:) = mean(uadvE_ll,1);
tauE_zav = mean(tauE_ll,1);
w_zav(:,:) = mean(w_ll,1);
vort3_zav(:,:) = mean(vort3_ll,1);
uv_zav(:,:) = mean(uv_ll,1);

%take hem av

for i=1:45

uE_hzav(i,:) = (uE_zav(45+i,:) + uE_zav(46-i,:))./2;
vN_hzav(i,:) = (vN_zav(45+i,:) - vN_zav(46-i,:))./2;
uzE_hzav(i,:) = (uzE_zav(45+i,:) + uzE_zav(46-i,:))./2;
urE_hzav(i,:) = (urE_zav(45+i,:) + urE_zav(46-i,:))./2;
uadvE_hzav(i,:) = (uadvE_zav(45+i,:) + uadvE_zav(46-i,:))./2;
tauE_hzav(i) = (tauE_zav(45+i) + tauE_zav(46-i))./2;
w_hzav_wlevs(i,:) = (w_zav(45+i,:) + w_zav(46-i,:))./2;
vort3_hzav(i,:) = (vort3_zav(45+i,:) - vort3_zav(46-i,:))./2;
uv_hzav(i,:) = (uv_zav(45+i,:) - uv_zav(46-i,:))./2;

end

w_hzav_wlevs(:,26) = 0;
rC_wlevs = (100000:-4000:0)';
w_hzav = interp1(rC_wlevs,w_hzav_wlevs',rC)';

uv_ed_hzav = uv_hzav - uE_hzav.*vN_hzav;
f = zeros(45,25);
cosphi = zeros(45,25);
omega = 2.*pi./(24.*60.*60);
for i=1:25
f(:,i) = 2.*omega.*sin(yi(46:90).*pi./180);
cosphi(:,i) = cos(yi(46:90).*pi./180);
end

%calculate vertical and horizontal gradients of u
a = 6371.0e3;
uE_weighted = uE_hzav.*cosphi;

uv_weighted = uv_hzav.*cosphi.^2;

uv_ed_weighted = uv_ed_hzav.*cosphi.^2;

[moo,dudy_s] = gradient(uE_weighted,pi./90);
dudy_w = dudy_s./cosphi./a;

[moo,duvdy_s] = gradient(uv_weighted,pi./90);
duvdy_w = duvdy_s./cosphi./cosphi./a;

[moo,duvdy_s_ed] = gradient(uv_ed_weighted,pi./90);
duvdy_ed_w = duvdy_s_ed./cosphi./cosphi./a;

dudp_w = gradient(uE_hzav,-4000);

%If -dudy is equivalent to vort3, which it is, then dudp should be an ok approx to vort2 :)

%Now we want to evaluate and vertically integrate:
%fv, f, v

fvN_hzav = f.*vN_hzav;

%zeta3v, total, zonal and eddy

zeta3v_tot_hzav = uzE_hzav - fvN_hzav;

zeta3v_zon_hzav = vort3_hzav.*vN_hzav;

zeta3v_ed_hzav = zeta3v_tot_hzav - zeta3v_zon_hzav;

%zeta2w, total, zonal and eddy

zeta2w_hzav = -dudp_w.*w_hzav;
zeta2w_ed_hzav = urE_hzav - zeta2w_hzav;

%friction - done


%take vertical integrals

intfac = 4000./9.81;


uadvE_vint = sum(uadvE_hzav,2).*intfac;

uadvE_vint_surf = sum(uadvE_hzav(:,1:8),2).*intfac;

uadvE_vint_top = sum(uadvE_hzav(:,9:25),2).*intfac;

uzE_vint = sum(uzE_hzav,2).*intfac;

uzE_vint_surf = sum(uzE_hzav(:,1:8),2).*intfac;

uzE_vint_top = sum(uzE_hzav(:,9:25),2).*intfac;

fvN_vint = sum(fvN_hzav,2).*intfac;

fvN_vint_surf = sum(fvN_hzav(:,1:8),2).*intfac;

fvN_vint_top = sum(fvN_hzav(:,9:25),2).*intfac;

zeta3v_zon_vint = sum(zeta3v_zon_hzav,2).*intfac;

zeta3v_zon_vint_surf = sum(zeta3v_zon_hzav(:,1:8),2).*intfac;

zeta3v_zon_vint_top = sum(zeta3v_zon_hzav(:,9:25),2).*intfac;

zeta3v_tot_vint = sum(zeta3v_tot_hzav,2).*intfac;
zeta3v_tot_vint_surf = sum(zeta3v_tot_hzav(:,1:8),2).*intfac;
zeta3v_tot_vint_top = sum(zeta3v_tot_hzav(:,9:25),2).*intfac;

zeta3v_ed_vint = sum(zeta3v_ed_hzav,2).*intfac;

zeta3v_ed_vint_surf = sum(zeta3v_ed_hzav(:,1:8),2).*intfac;

zeta3v_ed_vint_top = sum(zeta3v_ed_hzav(:,9:25),2).*intfac;

urE_vint = sum(urE_hzav,2).*intfac;

urE_vint_surf = sum(urE_hzav(:,1:8),2).*intfac;

urE_vint_top = sum(urE_hzav(:,9:25),2).*intfac;

zeta2w_vint = sum(zeta2w_hzav,2).*intfac;

zeta2w_vint_surf = sum(zeta2w_hzav(:,1:8),2).*intfac;

zeta2w_vint_top = sum(zeta2w_hzav(:,9:25),2).*intfac;

zeta2w_ed_vint = sum(zeta2w_ed_hzav,2).*intfac;

zeta2w_ed_vint_surf = sum(zeta2w_ed_hzav(:,1:8),2).*intfac;

zeta2w_ed_vint_top = sum(zeta2w_ed_hzav(:,9:25),2).*intfac;

duvdy_vint = sum(duvdy_w,2).*intfac;

duvdy_ed_vint = sum(duvdy_ed_w,2).*intfac;



%ACTUAL BITS TO PLOT 

C_total = uadvE_vint;

C_total_surf = zeta3v_tot_vint_surf + urE_vint_surf;

C_total_top = zeta3v_tot_vint_top + urE_vint_top;

C_zonal = fvN_vint + zeta3v_zon_vint + zeta2w_vint;

C_zonal_surf = zeta3v_zon_vint_surf + zeta2w_vint_surf;

C_zonal_top = zeta3v_zon_vint_top + zeta2w_vint_top;

C_eddy = zeta3v_ed_vint + zeta2w_ed_vint;

C_eddy_surf = zeta3v_ed_vint_surf + zeta2w_ed_vint_surf;

C_eddy_top = zeta3v_ed_vint_top + zeta2w_ed_vint_top;

save('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_150.mat')
