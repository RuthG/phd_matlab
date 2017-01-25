% load up v'T' and temperature data to calculate lowest level of the tropopause and the extent of the 'baroclinic zone'

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%

i=0;
for nit = 86400; %259200:86400:432000;
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i) = dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_w(:,:,:,i) = dyn(:,:,:,J);
[uEt_w(:,:,:,i),vNt_w(:,:,:,i)] = rotate_uv2uvEN(ut_w(:,:,:,i),vt_w(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'UVELSQ  '));
usqcs_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSQ  '));
vsqcs_w(:,:,:,i) = dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearh/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_h(:,:,:,i) = dyn(:,:,:,J);
[uE_h(:,:,:,i),vN_h(:,:,:,i)] = rotate_uv2uvEN(ucs_h(:,:,:,i),vcs_h(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_h(:,:,:,i) = dyn(:,:,:,J);
[uEt_h(:,:,:,i),vNt_h(:,:,:,i)] = rotate_uv2uvEN(ut_h(:,:,:,i),vt_h(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'UVELSQ  '));
usqcs_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSQ  '));
vsqcs_h(:,:,:,i) = dyn(:,:,:,J);


rDir='/disk1/MITgcm/verification/atm_gray_ruth/run/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_q(:,:,:,i) = dyn(:,:,:,J);
[uE_q(:,:,:,i),vN_q(:,:,:,i)] = rotate_uv2uvEN(ucs_q(:,:,:,i),vcs_q(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_q(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_q(:,:,:,i) = dyn(:,:,:,J);
[uEt_q(:,:,:,i),vNt_q(:,:,:,i)] = rotate_uv2uvEN(ut_q(:,:,:,i),vt_q(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'UVELSQ  '));
usqcs_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSQ  '));
vsqcs_q(:,:,:,i) = dyn(:,:,:,J);


end

theta_w_tav = mean(theta_w,4);
vN_w_tav = mean(vN_w,4);
vNt_w_tav = mean(vNt_w,4);
uE_w_tav = mean(uE_w,4);
tke_w = (usqcs_w + vsqcs_w)./2;
tke_w_tav = mean(tke_w,4);

theta_h_tav = mean(theta_h,4);
vN_h_tav = mean(vN_h,4);
vNt_h_tav = mean(vNt_h,4);
uE_h_tav = mean(uE_h,4);
tke_h = (usqcs_h + vsqcs_h)./2;
tke_h_tav = mean(tke_h,4);

theta_q_tav = mean(theta_q,4);
vN_q_tav = mean(vN_q,4);
vNt_q_tav = mean(vNt_q,4);
uE_q_tav = mean(uE_q,4);
tke_q = (usqcs_q + vsqcs_q)./2;
tke_q_tav = mean(tke_q,4);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_w_tav(:,:,j)=theta_w_tav(:,:,j).*convthetatoT(j,1);
temp_h_tav(:,:,j)=theta_h_tav(:,:,j).*convthetatoT(j,1);
temp_q_tav(:,:,j)=theta_q_tav(:,:,j).*convthetatoT(j,1);
end

xi=-179:2:180;yi=-89:2:90;
uEll_w=cube2latlon(xc,yc,uE_w_tav,xi,yi);
vNll_w=cube2latlon(xc,yc,vN_w_tav,xi,yi);
vNtll_w=cube2latlon(xc,yc,vNt_w_tav,xi,yi);
thetall_w=cube2latlon(xc,yc,theta_w_tav,xi,yi);
templl_w=cube2latlon(xc,yc,temp_w_tav,xi,yi);
tkell_w=cube2latlon(xc,yc,tke_w_tav,xi,yi);

uEll_h=cube2latlon(xc,yc,uE_h_tav,xi,yi);
vNll_h=cube2latlon(xc,yc,vN_h_tav,xi,yi);
vNtll_h=cube2latlon(xc,yc,vNt_h_tav,xi,yi);
thetall_h=cube2latlon(xc,yc,theta_h_tav,xi,yi);
templl_h=cube2latlon(xc,yc,temp_h_tav,xi,yi);
tkell_h=cube2latlon(xc,yc,tke_h_tav,xi,yi);

uEll_q=cube2latlon(xc,yc,uE_q_tav,xi,yi);
vNll_q=cube2latlon(xc,yc,vN_q_tav,xi,yi);
vNtll_q=cube2latlon(xc,yc,vNt_q_tav,xi,yi);
thetall_q=cube2latlon(xc,yc,theta_q_tav,xi,yi);
templl_q=cube2latlon(xc,yc,temp_q_tav,xi,yi);
tkell_q=cube2latlon(xc,yc,tke_q_tav,xi,yi);

uE_w_zav(:,:) = mean(uEll_w,1);
vN_w_zav(:,:) = mean(vNll_w,1);
tke_w_zav(:,:) = mean(tkell_w,1);
vNt_w_zav(:,:) = mean(vNtll_w,1);
theta_w_zav(:,:) = mean(thetall_w,1);
temp_w_zav(:,:) = mean(templl_w,1);

uE_h_zav(:,:) = mean(uEll_h,1);
vN_h_zav(:,:) = mean(vNll_h,1);
tke_h_zav(:,:) = mean(tkell_h,1);
vNt_h_zav(:,:) = mean(vNtll_h,1);
theta_h_zav(:,:) = mean(thetall_h,1);
temp_h_zav(:,:) = mean(templl_h,1);

uE_q_zav(:,:) = mean(uEll_q,1);
vN_q_zav(:,:) = mean(vNll_q,1);
tke_q_zav(:,:) = mean(tkell_q,1);
vNt_q_zav(:,:) = mean(vNtll_q,1);
theta_q_zav(:,:) = mean(thetall_q,1);
temp_q_zav(:,:) = mean(templl_q,1);


zke_w_zav = (uE_w_zav.^2 + vN_w_zav.^2)./2;
eke_w =  tke_w_zav - zke_w_zav;

zke_h_zav = (uE_h_zav.^2 + vN_h_zav.^2)./2;
eke_h =  tke_h_zav - zke_h_zav;

zke_q_zav = (uE_q_zav.^2 + vN_q_zav.^2)./2;
eke_q =  tke_q_zav - zke_q_zav;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% first find tropopause height %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:25
rhoair_w(:,i) = rC(i)./(287.058.*temp_w_zav(:,i));
rhoair_h(:,i) = rC(i)./(287.058.*temp_h_zav(:,i));
rhoair_q(:,i) = rC(i)./(287.058.*temp_q_zav(:,i));
end

g=9.81;
dtempdp_w = gradient(temp_w_zav,-4000.);
dtempdp_h = gradient(temp_h_zav,-4000.);
dtempdp_q = gradient(temp_q_zav,-4000.);
dtempdz_w = -1.*rhoair_w.*g.*dtempdp_w.*1000;
dtempdz_h = -1.*rhoair_h.*g.*dtempdp_h.*1000;
dtempdz_q = -1.*rhoair_q.*g.*dtempdp_q.*1000;


for i=1:88
trop_w(i) = rC(min(find((dtempdz_w(i+1,:) >= -2))));
trop_h(i) = rC(min(find((dtempdz_h(i+1,:) >= -2))));
trop_q(i) = rC(min(find((dtempdz_q(i+1,:) >= -2))));
end

sigma_t_max_w = max(trop_w);
level_w = find(rC == sigma_t_max_w);
sigma_t_max_h = max(trop_h);
level_h = find(rC == sigma_t_max_h);
sigma_t_max_q = max(trop_q);
level_q = find(rC == sigma_t_max_q);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%Now use this to calculate latitude where integral of v'theta'cos(lat) from surf to tropopause is max %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


vN_w_zav_t_zav = vN_w_zav.*theta_w_zav;
vt_ed_w_zav = vNt_w_zav - vN_w_zav_t_zav;
vN_h_zav_t_zav = vN_h_zav.*theta_h_zav;
vt_ed_h_zav = vNt_h_zav - vN_h_zav_t_zav;
vN_q_zav_t_zav = vN_q_zav.*theta_q_zav;
vt_ed_q_zav = vNt_q_zav - vN_q_zav_t_zav;

dsigma = 4000/100000;

for i=1:90
barzon_a_w(i,:) = vt_ed_w_zav(i,1:level_w).*cos(yi(i).*pi./180);
barzon_a_h(i,:) = vt_ed_h_zav(i,1:level_h).*cos(yi(i).*pi./180);
barzon_a_q(i,:) = vt_ed_q_zav(i,1:level_q).*cos(yi(i).*pi./180);
end

barzon_b_w = dsigma.*sum(barzon_a_w,2);
barzon_b_h = dsigma.*sum(barzon_a_h,2);
barzon_b_q = dsigma.*sum(barzon_a_q,2);

for i=1:45
barzon_c_w(i) = (barzon_b_w(91-i) - barzon_b_w(i))./2;
barzon_c_h(i) = (barzon_b_h(91-i) - barzon_b_h(i))./2;
barzon_c_q(i) = (barzon_b_q(91-i) - barzon_b_q(i))./2;
end

barzon_centre_w = find(barzon_c_w == max(barzon_c_w));
barzon_centre_h = find(barzon_c_h == max(barzon_c_h));
barzon_centre_q = find(barzon_c_q == max(barzon_c_q));

barzon_lats_w(1) = abs(yi(barzon_centre_w)) - 15;
barzon_lats_w(2) = abs(yi(barzon_centre_w)) + 15;
barzon_lats_h(1) = abs(yi(barzon_centre_h)) - 15;
barzon_lats_h(2) = abs(yi(barzon_centre_h)) + 15;
barzon_lats_q(1) = abs(yi(barzon_centre_q)) - 15;
barzon_lats_q(2) = abs(yi(barzon_centre_q)) + 15;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% identify edges of baroclinic zone %%%%%%%%%%%%%%%%%%%%%%%%%

if(mod(barzon_lats_w(1),2)==0)
plot_min_w = barzon_lats_w(1)-1;
plot_max_w = barzon_lats_w(2)+1;
else
plot_min_w = barzon_lats_w(1);
plot_max_w = barzon_lats_w(2);
end

if(mod(barzon_lats_h(1),2)==0)
plot_min_h = barzon_lats_h(1)-1;
plot_max_h = barzon_lats_h(2)+1;
else
plot_min_h = barzon_lats_h(1);
plot_max_h = barzon_lats_h(2);
end

if(mod(barzon_lats_q(1),2)==0)
plot_min_q = barzon_lats_q(1)-1;
plot_max_q = barzon_lats_q(2)+1;
else
plot_min_q = barzon_lats_q(1);
plot_max_q = barzon_lats_q(2);
end

name = ['bc_box_sh.mat'];
save(name,'barzon_lats_w','barzon_lats_h','barzon_lats_q','level_w','level_h','level_q')

return

