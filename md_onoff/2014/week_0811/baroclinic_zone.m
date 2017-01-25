% load up v'T' and temperature data to calculate lowest level of the tropopause and the extent of the 'baroclinic zone'

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';

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
for nit = 259200:86400:604800;
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';

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


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';

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


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_quarterwv/';

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

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_d(:,:,:,i) = dyn(:,:,:,J);
[uE_d(:,:,:,i),vN_d(:,:,:,i)] = rotate_uv2uvEN(ucs_d(:,:,:,i),vcs_d(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_d(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_d(:,:,:,i) = dyn(:,:,:,J);
[uEt_d(:,:,:,i),vNt_d(:,:,:,i)] = rotate_uv2uvEN(ut_d(:,:,:,i),vt_d(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'UVELSQ  '));
usqcs_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSQ  '));
vsqcs_d(:,:,:,i) = dyn(:,:,:,J);

end

theta_w_tav = mean(theta_w,4);
theta_h_tav = mean(theta_h,4);
theta_q_tav = mean(theta_q,4);
theta_d_tav = mean(theta_d,4);

vN_w_tav = mean(vN_w,4);
vN_h_tav = mean(vN_h,4);
vN_q_tav = mean(vN_q,4);
vN_d_tav = mean(vN_d,4);

vNt_w_tav = mean(vNt_w,4);
vNt_h_tav = mean(vNt_h,4);
vNt_q_tav = mean(vNt_q,4);
vNt_d_tav = mean(vNt_d,4);

uE_w_tav = mean(uE_w,4);
uE_h_tav = mean(uE_h,4);
uE_q_tav = mean(uE_q,4);
uE_d_tav = mean(uE_d,4);

tke_w = (usqcs_w + vsqcs_w)./2;
tke_h = (usqcs_h + vsqcs_h)./2;
tke_q = (usqcs_q + vsqcs_q)./2;
tke_d = (usqcs_d + vsqcs_d)./2;

tke_w_tav = mean(tke_w,4);
tke_h_tav = mean(tke_h,4);
tke_q_tav = mean(tke_q,4);
tke_d_tav = mean(tke_d,4);


convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_w_tav(:,:,j)=theta_w_tav(:,:,j).*convthetatoT(j,1);
temp_h_tav(:,:,j)=theta_h_tav(:,:,j).*convthetatoT(j,1);
temp_q_tav(:,:,j)=theta_q_tav(:,:,j).*convthetatoT(j,1);
temp_d_tav(:,:,j)=theta_d_tav(:,:,j).*convthetatoT(j,1);
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
uEll_d=cube2latlon(xc,yc,uE_d_tav,xi,yi);
vNll_d=cube2latlon(xc,yc,vN_d_tav,xi,yi);
vNtll_d=cube2latlon(xc,yc,vNt_d_tav,xi,yi);
thetall_d=cube2latlon(xc,yc,theta_d_tav,xi,yi);
templl_d=cube2latlon(xc,yc,temp_d_tav,xi,yi);
tkell_d=cube2latlon(xc,yc,tke_d_tav,xi,yi);

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
uE_d_zav(:,:) = mean(uEll_d,1);
vN_d_zav(:,:) = mean(vNll_d,1);
tke_d_zav(:,:) = mean(tkell_d,1);
vNt_d_zav(:,:) = mean(vNtll_d,1);
theta_d_zav(:,:) = mean(thetall_d,1);
temp_d_zav(:,:) = mean(templl_d,1);

zke_w_zav = (uE_w_zav.^2 + vN_w_zav.^2)./2;
zke_h_zav = (uE_h_zav.^2 + vN_h_zav.^2)./2;
zke_q_zav = (uE_q_zav.^2 + vN_q_zav.^2)./2;
zke_d_zav = (uE_d_zav.^2 + vN_d_zav.^2)./2;

eke_w =  tke_w_zav - zke_w_zav;
eke_h =  tke_h_zav - zke_h_zav;
eke_q =  tke_q_zav - zke_q_zav;
eke_d =  tke_d_zav - zke_d_zav;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% first find tropopause height %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:25
rhoair_w(:,i) = rC(i)./(287.058.*temp_w_zav(:,i));
rhoair_h(:,i) = rC(i)./(287.058.*temp_h_zav(:,i));
rhoair_q(:,i) = rC(i)./(287.058.*temp_q_zav(:,i));
rhoair_d(:,i) = rC(i)./(287.058.*temp_d_zav(:,i));
end

g=9.81;
dtempdp_w = gradient(temp_w_zav,-4000.);
dtempdz_w = -1.*rhoair_w.*g.*dtempdp_w.*1000;
dtempdp_h = gradient(temp_h_zav,-4000.);
dtempdz_h = -1.*rhoair_h.*g.*dtempdp_h.*1000;
dtempdp_q = gradient(temp_q_zav,-4000.);
dtempdz_q = -1.*rhoair_q.*g.*dtempdp_q.*1000;
dtempdp_d = gradient(temp_d_zav,-4000.);
dtempdz_d = -1.*rhoair_d.*g.*dtempdp_d.*1000;

for i=1:88
trop_w(i) = rC(min(find((dtempdz_w(i+1,:) >= -2))));
trop_h(i) = rC(min(find((dtempdz_h(i+1,:) >= -2))));
trop_q(i) = rC(min(find((dtempdz_q(i+1,:) >= -2))));
trop_d(i) = rC(min(find((dtempdz_d(i+1,:) >= -2))));
end

sigma_t_max_w = max(trop_w);
level_w = find(rC == sigma_t_max_w);
sigma_t_max_h = max(trop_h);
level_h = find(rC == sigma_t_max_h);
sigma_t_max_q = max(trop_q);
level_q = find(rC == sigma_t_max_q);
sigma_t_max_d = max(trop_d);
level_d = find(rC == sigma_t_max_d);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%Now use this to calculate latitude where integral of v'theta'cos(lat) from surf to tropopause is max %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


vN_w_zav_t_zav = vN_w_zav.*theta_w_zav;
vt_ed_w_zav = vNt_w_zav - vN_w_zav_t_zav;
vN_h_zav_t_zav = vN_h_zav.*theta_h_zav;
vt_ed_h_zav = vNt_h_zav - vN_h_zav_t_zav;
vN_q_zav_t_zav = vN_q_zav.*theta_q_zav;
vt_ed_q_zav = vNt_q_zav - vN_q_zav_t_zav;
vN_d_zav_t_zav = vN_d_zav.*theta_d_zav;
vt_ed_d_zav = vNt_d_zav - vN_d_zav_t_zav;

dsigma = 4000/100000;

for i=1:90
barzon_a_w(i,:) = vt_ed_w_zav(i,1:level_w).*cos(yi(i).*pi./180);
barzon_a_h(i,:) = vt_ed_h_zav(i,1:level_h).*cos(yi(i).*pi./180);
barzon_a_q(i,:) = vt_ed_q_zav(i,1:level_q).*cos(yi(i).*pi./180);
barzon_a_d(i,:) = vt_ed_d_zav(i,1:level_d).*cos(yi(i).*pi./180);
end

barzon_b_w = dsigma.*sum(barzon_a_w,2);
barzon_b_h = dsigma.*sum(barzon_a_h,2);
barzon_b_q = dsigma.*sum(barzon_a_q,2);
barzon_b_d = dsigma.*sum(barzon_a_d,2);

for i=1:45
barzon_c_w(i) = (barzon_b_w(91-i) - barzon_b_w(i))./2;
barzon_c_h(i) = (barzon_b_h(91-i) - barzon_b_h(i))./2;
barzon_c_q(i) = (barzon_b_q(91-i) - barzon_b_q(i))./2;
barzon_c_d(i) = (barzon_b_d(91-i) - barzon_b_d(i))./2;
end

barzon_centre_w = find(barzon_c_w == max(barzon_c_w));
barzon_centre_h = find(barzon_c_h == max(barzon_c_h));
barzon_centre_q = find(barzon_c_q == max(barzon_c_q));
barzon_centre_d = find(barzon_c_d == max(barzon_c_d));

barzon_lats_w(1) = abs(yi(barzon_centre_w)) - 15;
barzon_lats_w(2) = abs(yi(barzon_centre_w)) + 15;
barzon_lats_h(1) = abs(yi(barzon_centre_h)) - 15;
barzon_lats_h(2) = abs(yi(barzon_centre_h)) + 15;
barzon_lats_q(1) = abs(yi(barzon_centre_q)) - 15;
barzon_lats_q(2) = abs(yi(barzon_centre_q)) + 15;
barzon_lats_d(1) = abs(yi(barzon_centre_d)) - 15;
barzon_lats_d(2) = abs(yi(barzon_centre_d)) + 15;


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

if(mod(barzon_lats_d(1),2)==0)
plot_min_d = barzon_lats_d(1)-1;
plot_max_d = barzon_lats_d(2)+1;
else
plot_min_d = barzon_lats_d(1);
plot_max_d = barzon_lats_d(2);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% plot to check calc makes sens %%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
v = 180:5:300;
contourf(yi,rC,temp_d_zav',v)
colorbar
set(gca,'YDir','reverse')
caxis([180 300])
hold on
plot(yi(2:89),trop_d,'k','LineWidth',2)
plot([plot_min_d, plot_min_d],[98000,0],'k--')
plot([-plot_min_d, -plot_min_d],[98000,0],'k--')
plot([plot_max_d, plot_max_d],[98000,0],'k--')
plot([-plot_max_d, -plot_max_d],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_d,sigma_t_max_d],'k--')
hold off

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v = 180:5:300;
contourf(yi,rC,temp_q_zav',v)
colorbar
set(gca,'YDir','reverse')
caxis([180 300])
hold on
plot(yi(2:89),trop_q,'k','LineWidth',2)
plot([plot_min_q, plot_min_q],[98000,0],'k--')
plot([-plot_min_q, -plot_min_q],[98000,0],'k--')
plot([plot_max_q, plot_max_q],[98000,0],'k--')
plot([-plot_max_q, -plot_max_q],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_q,sigma_t_max_q],'k--')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v = 180:5:300;
contourf(yi,rC,temp_h_zav',v)
colorbar
set(gca,'YDir','reverse')
caxis([180 300])
hold on
plot(yi(2:89),trop_h,'k','LineWidth',2)
plot([plot_min_h, plot_min_h],[98000,0],'k--')
plot([-plot_min_h, -plot_min_h],[98000,0],'k--')
plot([plot_max_h, plot_max_h],[98000,0],'k--')
plot([-plot_max_h, -plot_max_h],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_h,sigma_t_max_h],'k--')
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v = 180:5:300;
contourf(yi,rC,temp_w_zav',v)
colorbar
set(gca,'YDir','reverse')
caxis([180 300])
hold on
plot(yi(2:89),trop_w,'k','LineWidth',2)
plot([plot_min_w, plot_min_w],[98000,0],'k--')
plot([-plot_min_w, -plot_min_w],[98000,0],'k--')
plot([plot_max_w, plot_max_w],[98000,0],'k--')
plot([-plot_max_w, -plot_max_w],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_w,sigma_t_max_w],'k--')
hold off

print('-dpdf','temp_eke.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-20:2:20;
contourf(yi,rC,vt_ed_d_zav',v)
colorbar
set(gca,'YDir','reverse')
caxis([-20 20])
hold on
plot(yi(2:89),trop_d,'k','LineWidth',2)
plot([plot_min_d, plot_min_d],[98000,0],'k--')
plot([-plot_min_d, -plot_min_d],[98000,0],'k--')
plot([plot_max_d, plot_max_d],[98000,0],'k--')
plot([-plot_max_d, -plot_max_d],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_d,sigma_t_max_d],'k--')
hold off

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-20:2:20;
contourf(yi,rC,vt_ed_q_zav',v)
colorbar
set(gca,'YDir','reverse')
caxis([-20 20])
hold on
plot(yi(2:89),trop_q,'k','LineWidth',2)
plot([plot_min_q, plot_min_q],[98000,0],'k--')
plot([-plot_min_q, -plot_min_q],[98000,0],'k--')
plot([plot_max_q, plot_max_q],[98000,0],'k--')
plot([-plot_max_q, -plot_max_q],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_q,sigma_t_max_q],'k--')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-20:2:20;
contourf(yi,rC,vt_ed_h_zav',v)
colorbar
set(gca,'YDir','reverse')
caxis([-20 20])
hold on
plot(yi(2:89),trop_h,'k','LineWidth',2)
plot([plot_min_h, plot_min_h],[98000,0],'k--')
plot([-plot_min_h, -plot_min_h],[98000,0],'k--')
plot([plot_max_h, plot_max_h],[98000,0],'k--')
plot([-plot_max_h, -plot_max_h],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_h,sigma_t_max_h],'k--')
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-20:2:20;
contourf(yi,rC,vt_ed_w_zav',v)
colorbar
set(gca,'YDir','reverse')
caxis([-20 20])
hold on
plot(yi(2:89),trop_w,'k','LineWidth',2)
plot([plot_min_w, plot_min_w],[98000,0],'k--')
plot([-plot_min_w, -plot_min_w],[98000,0],'k--')
plot([plot_max_w, plot_max_w],[98000,0],'k--')
plot([-plot_max_w, -plot_max_w],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_w,sigma_t_max_w],'k--')
hold off

print('-dpdf','vted_eke.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v = 250:10:750;
contourf(yi,rC,theta_d_zav',v)
colorbar
set(gca,'YDir','reverse')
caxis([250 750])
hold on
plot(yi(2:89),trop_d,'k','LineWidth',2)
plot([plot_min_d, plot_min_d],[98000,0],'k--')
plot([-plot_min_d, -plot_min_d],[98000,0],'k--')
plot([plot_max_d, plot_max_d],[98000,0],'k--')
plot([-plot_max_d, -plot_max_d],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_d,sigma_t_max_d],'k--')
hold off

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v = 250:10:750;
contourf(yi,rC,theta_q_zav',v)
colorbar
set(gca,'YDir','reverse')
caxis([250 750])
hold on
plot(yi(2:89),trop_q,'k','LineWidth',2)
plot([plot_min_q, plot_min_q],[98000,0],'k--')
plot([-plot_min_q, -plot_min_q],[98000,0],'k--')
plot([plot_max_q, plot_max_q],[98000,0],'k--')
plot([-plot_max_q, -plot_max_q],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_q,sigma_t_max_q],'k--')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v = 250:10:750;
contourf(yi,rC,theta_h_zav',v)
colorbar
set(gca,'YDir','reverse')
caxis([250 750])
hold on
plot(yi(2:89),trop_h,'k','LineWidth',2)
plot([plot_min_h, plot_min_h],[98000,0],'k--')
plot([-plot_min_h, -plot_min_h],[98000,0],'k--')
plot([plot_max_h, plot_max_h],[98000,0],'k--')
plot([-plot_max_h, -plot_max_h],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_h,sigma_t_max_h],'k--')
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v = 250:10:750;
contourf(yi,rC,theta_w_zav',v)
colorbar
set(gca,'YDir','reverse')
caxis([250 750])
hold on
plot(yi(2:89),trop_w,'k','LineWidth',2)
plot([plot_min_w, plot_min_w],[98000,0],'k--')
plot([-plot_min_w, -plot_min_w],[98000,0],'k--')
plot([plot_max_w, plot_max_w],[98000,0],'k--')
plot([-plot_max_w, -plot_max_w],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_w,sigma_t_max_w],'k--')
hold off

print('-dpdf','theta_eke.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v = 0:10:230;
contourf(yi,rC,eke_d',v)
colorbar
set(gca,'YDir','reverse')
caxis([0 230])
hold on
plot(yi(2:89),trop_d,'k','LineWidth',2)
plot([plot_min_d, plot_min_d],[98000,0],'k--')
plot([-plot_min_d, -plot_min_d],[98000,0],'k--')
plot([plot_max_d, plot_max_d],[98000,0],'k--')
plot([-plot_max_d, -plot_max_d],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_d,sigma_t_max_d],'k--')
hold off

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v = 0:10:230;
contourf(yi,rC,eke_q',v)
colorbar
set(gca,'YDir','reverse')
caxis([0 230])
hold on
plot(yi(2:89),trop_q,'k','LineWidth',2)
plot([plot_min_q, plot_min_q],[98000,0],'k--')
plot([-plot_min_q, -plot_min_q],[98000,0],'k--')
plot([plot_max_q, plot_max_q],[98000,0],'k--')
plot([-plot_max_q, -plot_max_q],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_q,sigma_t_max_q],'k--')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v = 0:10:230;
contourf(yi,rC,eke_h',v)
colorbar
set(gca,'YDir','reverse')
caxis([0 230])
hold on
plot(yi(2:89),trop_h,'k','LineWidth',2)
plot([plot_min_h, plot_min_h],[98000,0],'k--')
plot([-plot_min_h, -plot_min_h],[98000,0],'k--')
plot([plot_max_h, plot_max_h],[98000,0],'k--')
plot([-plot_max_h, -plot_max_h],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_h,sigma_t_max_h],'k--')
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v = 0:10:230;
contourf(yi,rC,eke_w',v)
colorbar
set(gca,'YDir','reverse')
caxis([0 230])
hold on
plot(yi(2:89),trop_w,'k','LineWidth',2)
plot([plot_min_w, plot_min_w],[98000,0],'k--')
plot([-plot_min_w, -plot_min_w],[98000,0],'k--')
plot([plot_max_w, plot_max_w],[98000,0],'k--')
plot([-plot_max_w, -plot_max_w],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_w,sigma_t_max_w],'k--')
hold off

print('-dpdf','eke_eke.pdf')




name = ['bc_box_d.mat'];
save(name,'barzon_lats_d','level_d')
name = ['bc_box_q.mat'];
save(name,'barzon_lats_q','level_q')
name = ['bc_box_h.mat'];
save(name,'barzon_lats_h','level_h')
name = ['bc_box_w.mat'];
save(name,'barzon_lats_w','level_w')

return

