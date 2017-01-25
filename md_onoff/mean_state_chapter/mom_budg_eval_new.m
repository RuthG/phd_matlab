rDir='/project/rg312/final_runs/run_000_final_noshallow/';
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

%want
%C_total = <-vdu/dy> - <wdu/dp> = uadvE_ll - fv
%C_zonal = -<v><du/dy> = <v>.*<vort3>
%C_eddy = C_total - C_zonal
%tauE

load('/project/rg312/mat_files/chapter2_variables/mombudg_tav_000.mat')
load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_000.mat','uE_tav','vN_tav','w_tav')

uE_ll=cube2latlon(xc,yc,uE_tav,xi,yi);
vN_ll=cube2latlon(xc,yc,vN_tav,xi,yi);
uzE_ll=cube2latlon(xc,yc,uzE,xi,yi);
urE_ll=cube2latlon(xc,yc,urE,xi,yi);
uadvE_ll=cube2latlon(xc,yc,uadvE,xi,yi);
tauE_ll=cube2latlon(xc,yc,tauE,xi,yi);
vort3_ll=cube2latlon(xc,yc,vort3_tav,xi,yi);

uE_zav(:,:) = mean(uE_ll,1);
vN_zav(:,:) = mean(vN_ll,1);
uzE_zav(:,:) = mean(uzE_ll,1);
urE_zav(:,:) = mean(urE_ll,1);
uadvE_zav(:,:) = mean(uadvE_ll,1);
tauE_zav = mean(tauE_ll,1);
vort3_zav(:,:) = mean(vort3_ll,1);

%take hem av
for i=1:45
uE_hzav(i,:) = (uE_zav(45+i,:) + uE_zav(46-i,:))./2;
vN_hzav(i,:) = (vN_zav(45+i,:) - vN_zav(46-i,:))./2;
uzE_hzav(i,:) = (uzE_zav(45+i,:) + uzE_zav(46-i,:))./2;
urE_hzav(i,:) = (urE_zav(45+i,:) + urE_zav(46-i,:))./2;
uadvE_hzav(i,:) = (uadvE_zav(45+i,:) + uadvE_zav(46-i,:))./2;
tauE_hzav(i) = (tauE_zav(45+i) + tauE_zav(46-i))./2;
vort3_hzav(i,:) = (vort3_zav(45+i,:) - vort3_zav(46-i,:))./2;
end

f = zeros(45,25);
omega = 2.*pi./(24.*60.*60);
for i=1:25
f(:,i) = 2.*omega.*sin(yi(46:90).*pi./180);
end

fvN_hzav = f.*vN_hzav;

C_total_hzav = uadvE_hzav - fvN_hzav;
C_zonal_hzav = vN_hzav.*vort3_hzav;
C_eddy_hzav = C_total_hzav - C_zonal_hzav;

%take vertical integrals
intfac = 4000./9.8;

C_total = sum(C_total_hzav,2).*intfac;
C_total_surf = sum(C_total_hzav(:,1:8),2).*intfac;
C_total_top = sum(C_total_hzav(:,9:25),2).*intfac;

C_zonal = sum(C_zonal_hzav,2).*intfac;
C_zonal_surf = sum(C_zonal_hzav(:,1:8),2).*intfac;
C_zonal_top = sum(C_zonal_hzav(:,9:25),2).*intfac;

C_eddy = sum(C_eddy_hzav,2).*intfac;
C_eddy_surf = sum(C_eddy_hzav(:,1:8),2).*intfac;
C_eddy_top = sum(C_eddy_hzav(:,9:25),2).*intfac;

uadvE_vint = sum(uadvE_hzav,2).*intfac;
uadvE_vint_surf = sum(uadvE_hzav(:,1:8),2).*intfac;
uadvE_vint_top = sum(uadvE_hzav(:,9:25),2).*intfac;

uzE_vint = sum(uzE_hzav,2).*intfac;
uzE_vint_surf = sum(uzE_hzav(:,1:8),2).*intfac;
uzE_vint_top = sum(uzE_hzav(:,9:25),2).*intfac;

urE_vint = sum(urE_hzav,2).*intfac;
urE_vint_surf = sum(urE_hzav(:,1:8),2).*intfac;
urE_vint_top = sum(urE_hzav(:,9:25),2).*intfac;

fvN_vint = sum(fvN_hzav,2).*intfac;
fvN_vint_surf = sum(fvN_hzav(:,1:8),2).*intfac;
fvN_vint_top = sum(fvN_hzav(:,9:25),2).*intfac;

save('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_new_000.mat')
