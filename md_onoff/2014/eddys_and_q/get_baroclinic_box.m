%load up v'T' and temp data for 0, 0.5, 1 wv runs, and calculate 
%a) lowest level of tropopause 
%b) extend of 'baroclinic zone'

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Load data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a=system('find bc_zone_data.mat');

if a > 0

i=0;
for nit = 259200:86400:604800;
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_f(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_f(:,:,:,i) = dyn(:,:,:,J);
[uE_f(:,:,:,i),vN_f(:,:,:,i)] = rotate_uv2uvEN(ucs_f(:,:,:,i),vcs_f(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_f(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_f(:,:,j,i)=theta_f(:,:,j,i).*convthetatoT(j,1);
end

J=find(strcmp(fldList,'VVELTH  '));
vt_f(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_f(:,:,:,i) = dyn(:,:,:,J);
[uEt_f(:,:,:,i),vNt_f(:,:,:,i)] = rotate_uv2uvEN(ut_f(:,:,:,i),vt_f(:,:,:,i),AngleCS,AngleSN,Grid);

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

for j=1:size(rC)
temp_h(:,:,j,i)=theta_h(:,:,j,i).*convthetatoT(j,1);
end

J=find(strcmp(fldList,'VVELTH  '));
vt_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_h(:,:,:,i) = dyn(:,:,:,J);
[uEt_h(:,:,:,i),vNt_h(:,:,:,i)] = rotate_uv2uvEN(ut_h(:,:,:,i),vt_h(:,:,:,i),AngleCS,AngleSN,Grid);

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

for j=1:size(rC)
temp_d(:,:,j,i)=theta_d(:,:,j,i).*convthetatoT(j,1);
end

J=find(strcmp(fldList,'VVELTH  '));
vt_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_d(:,:,:,i) = dyn(:,:,:,J);
[uEt_d(:,:,:,i),vNt_d(:,:,:,i)] = rotate_uv2uvEN(ut_d(:,:,:,i),vt_d(:,:,:,i),AngleCS,AngleSN,Grid);


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

for j=1:size(rC)
temp_q(:,:,j,i)=theta_q(:,:,j,i).*convthetatoT(j,1);
end

J=find(strcmp(fldList,'VVELTH  '));
vt_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_q(:,:,:,i) = dyn(:,:,:,J);
[uEt_q(:,:,:,i),vNt_q(:,:,:,i)] = rotate_uv2uvEN(ut_q(:,:,:,i),vt_q(:,:,:,i),AngleCS,AngleSN,Grid);

end

save('bc_zone_data.mat')

else

load('bc_zone_data.mat')

end


% first find tropopause height
temp_d_tav = mean(temp_d,4);
temp_h_tav = mean(temp_h,4);
temp_f_tav = mean(temp_f,4);
temp_q_tav = mean(temp_q,4);

for i=1:25
rhoair_d(:,:,i) = rC(i)./(287.058.*temp_d_tav(:,:,i));
rhoair_h(:,:,i) = rC(i)./(287.058.*temp_h_tav(:,:,i));
rhoair_f(:,:,i) = rC(i)./(287.058.*temp_f_tav(:,:,i));
rhoair_q(:,:,i) = rC(i)./(287.058.*temp_q_tav(:,:,i));
end

g=9.81;

[junk,junk2,dtempdp_d] = gradient(temp_d_tav,-4000.);
dtempdz_d = -1.*rhoair_d.*g.*dtempdp_d.*1000;
[dtempdz_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(dtempdz_d,ny,yc,ar,hc);

[junk,junk2,dtempdp_h] = gradient(temp_h_tav,-4000.);
dtempdz_h = -1.*rhoair_f.*g.*dtempdp_h.*1000;
[dtempdz_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(dtempdz_h,ny,yc,ar,hc);

[junk,junk2,dtempdp_f] = gradient(temp_f_tav,-4000.);
dtempdz_f = -1.*rhoair_f.*g.*dtempdp_f.*1000;
[dtempdz_f_zav,mskzon,ylat,areazon]=calcZonalAvgCube(dtempdz_f,ny,yc,ar,hc);

[junk,junk2,dtempdp_q] = gradient(temp_q_tav,-4000.);
dtempdz_q = -1.*rhoair_q.*g.*dtempdp_q.*1000;
[dtempdz_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(dtempdz_q,ny,yc,ar,hc);

for i=1:90
trop_d(i) = rC(min(find((dtempdz_d_zav(i,:) >= -2))));
trop_h(i) = rC(min(find((dtempdz_h_zav(i,:) >= -2))));
trop_f(i) = rC(min(find((dtempdz_f_zav(i,:) >= -2))));
trop_q(i) = rC(min(find((dtempdz_q_zav(i,:) >= -2))));
end

sigma_t_max_d = max(trop_d);
sigma_t_max_h = max(trop_h);
sigma_t_max_f = max(trop_f);
sigma_t_max_q = max(trop_q);

level_d = find(rC == sigma_t_max_d);
level_h = find(rC == sigma_t_max_h);
level_f = find(rC == sigma_t_max_f);
level_q = find(rC == sigma_t_max_q);

%Now use this to calculate latitude where integral of v'theta'cos(lat) from surf to tropopause is max

[theta_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_d,ny,yc,ar,hc);
[vN_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_d,ny,yc,ar,hc);
[vNt_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_d,ny,yc,ar,hc);
[theta_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_h,ny,yc,ar,hc);
[vN_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_h,ny,yc,ar,hc);
[vNt_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_h,ny,yc,ar,hc);
[theta_f_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_f,ny,yc,ar,hc);
[vN_f_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_f,ny,yc,ar,hc);
[vNt_f_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_f,ny,yc,ar,hc);
[theta_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_q,ny,yc,ar,hc);
[vN_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_q,ny,yc,ar,hc);
[vNt_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_q,ny,yc,ar,hc);

vN_zav_t_zav_d = vN_d_zav.*theta_d_zav;
vt_ed_d_zav = vNt_d_zav - vN_zav_t_zav_d;
vN_zav_t_zav_h = vN_h_zav.*theta_h_zav;
vt_ed_h_zav = vNt_h_zav - vN_zav_t_zav_h;
vN_zav_t_zav_f = vN_f_zav.*theta_f_zav;
vt_ed_f_zav = vNt_f_zav - vN_zav_t_zav_f;
vN_zav_t_zav_q = vN_q_zav.*theta_q_zav;
vt_ed_q_zav = vNt_q_zav - vN_zav_t_zav_q;

vt_ed_d_tzav = mean(vt_ed_d_zav,3);
vt_ed_h_tzav = mean(vt_ed_h_zav,3);
vt_ed_f_tzav = mean(vt_ed_f_zav,3);
vt_ed_q_tzav = mean(vt_ed_q_zav,3);

dsigma = 4000/101325.0;

for i=1:90
barzon_d_a(i,:) = vt_ed_d_zav(i,1:level_d).*cos(ylat(i).*pi./180);
barzon_h_a(i,:) = vt_ed_h_zav(i,1:level_h).*cos(ylat(i).*pi./180);
barzon_f_a(i,:) = vt_ed_f_zav(i,1:level_f).*cos(ylat(i).*pi./180);
barzon_q_a(i,:) = vt_ed_q_zav(i,1:level_q).*cos(ylat(i).*pi./180);
end

barzon_d_b = dsigma.*sum(barzon_d_a,2);
barzon_h_b = dsigma.*sum(barzon_h_a,2);
barzon_f_b = dsigma.*sum(barzon_f_a,2);
barzon_q_b = dsigma.*sum(barzon_q_a,2);

for i=1:45
barzon_d_c(i) = (barzon_d_b(91-i) - barzon_d_b(i))./2;
barzon_h_c(i) = (barzon_h_b(91-i) - barzon_h_b(i))./2;
barzon_f_c(i) = (barzon_f_b(91-i) - barzon_f_b(i))./2;
barzon_q_c(i) = (barzon_q_b(91-i) - barzon_q_b(i))./2;
end

barzon_centre_d = find(barzon_d_c == max(barzon_d_c));
barzon_centre_h = find(barzon_h_c == max(barzon_h_c));
barzon_centre_f = find(barzon_f_c == max(barzon_f_c));
barzon_centre_q = find(barzon_q_c == max(barzon_q_c));

barzon_lats_d(1) = abs(ylat(barzon_centre_d)) - 15;
barzon_lats_d(2) = abs(ylat(barzon_centre_d)) + 15;
barzon_lats_h(1) = abs(ylat(barzon_centre_h)) - 15;
barzon_lats_h(2) = abs(ylat(barzon_centre_h)) + 15;
barzon_lats_f(1) = abs(ylat(barzon_centre_f)) - 15;
barzon_lats_f(2) = abs(ylat(barzon_centre_f)) + 15;
barzon_lats_q(1) = abs(ylat(barzon_centre_q)) - 15;
barzon_lats_q(2) = abs(ylat(barzon_centre_q)) + 15;

[temp_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_d_tav,ny,yc,ar,hc);
[temp_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_h_tav,ny,yc,ar,hc);
[temp_f_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_f_tav,ny,yc,ar,hc);
[temp_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_q_tav,ny,yc,ar,hc);

% identify edges of baroclinic zone
if(mod(barzon_lats_d(1),2)==0)
plot_min_d = barzon_lats_d(1)-1;
plot_max_d = barzon_lats_d(2)+1;
else
plot_min_d = barzon_lats_d(1);
plot_max_d = barzon_lats_d(2);
end

if(mod(barzon_lats_h(1),2)==0)
plot_min_h = barzon_lats_h(1)-1;
plot_max_h = barzon_lats_h(2)+1;
else
plot_min_h = barzon_lats_h(1);
plot_max_h = barzon_lats_h(2);
end

if(mod(barzon_lats_f(1),2)==0)
plot_min_f = barzon_lats_f(1)-1;
plot_max_f = barzon_lats_f(2)+1;
else
plot_min_f = barzon_lats_f(1);
plot_max_f = barzon_lats_f(2);
end

if(mod(barzon_lats_q(1),2)==0)
plot_min_q = barzon_lats_q(1)-1;
plot_max_q = barzon_lats_q(2)+1;
else
plot_min_q = barzon_lats_q(1);
plot_max_q = barzon_lats_q(2);
end

v = 180:5:300;
contourf(ylat,rC,temp_d_zav',v)
colorbar
set(gca,'YDir','reverse')
caxis([180 300])
hold on
plot(ylat,trop_d,'k','LineWidth',2)
plot([plot_min_d, plot_min_d],[98000,0],'k--')
plot([-plot_min_d, -plot_min_d],[98000,0],'k--')
plot([plot_max_d, plot_max_d],[98000,0],'k--')
plot([-plot_max_d, -plot_max_d],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_d,sigma_t_max_d],'k--')
print('-dpng','temp_d.png')
hold off

v = 180:5:300;
contourf(ylat,rC,temp_h_zav',v)
colorbar
set(gca,'YDir','reverse')
caxis([180 300])
hold on
plot(ylat,trop_h,'k','LineWidth',2)
plot([plot_min_h, plot_min_h],[98000,0],'k--')
plot([-plot_min_h, -plot_min_h],[98000,0],'k--')
plot([plot_max_h, plot_max_h],[98000,0],'k--')
plot([-plot_max_h, -plot_max_h],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_h,sigma_t_max_h],'k--')
print('-dpng','temp_h.png')
hold off

v = 180:5:300;
contourf(ylat,rC,temp_f_zav',v)
colorbar
set(gca,'YDir','reverse')
caxis([180 300])
hold on
plot(ylat,trop_f,'k','LineWidth',2)
plot([plot_min_f, plot_min_f],[98000,0],'k--')
plot([-plot_min_f, -plot_min_f],[98000,0],'k--')
plot([plot_max_f, plot_max_f],[98000,0],'k--')
plot([-plot_max_f, -plot_max_f],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_f,sigma_t_max_f],'k--')
print('-dpng','temp_f.png')
hold off


v = 180:5:300;
contourf(ylat,rC,temp_q_zav',v)
colorbar
set(gca,'YDir','reverse')
caxis([180 300])
hold on
plot(ylat,trop_q,'k','LineWidth',2)
plot([plot_min_q, plot_min_q],[98000,0],'k--')
plot([-plot_min_q, -plot_min_q],[98000,0],'k--')
plot([plot_max_q, plot_max_q],[98000,0],'k--')
plot([-plot_max_q, -plot_max_q],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_q,sigma_t_max_q],'k--')
print('-dpng','temp_q.png')
hold off

v=-20:2:20;
contourf(ylat,rC,vt_ed_d_tzav',v)
colorbar
set(gca,'YDir','reverse')
caxis([-20 20])
hold on
plot(ylat,trop_d,'k','LineWidth',2)
plot([plot_min_d, plot_min_d],[98000,0],'k--')
plot([-plot_min_d, -plot_min_d],[98000,0],'k--')
plot([plot_max_d, plot_max_d],[98000,0],'k--')
plot([-plot_max_d, -plot_max_d],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_d,sigma_t_max_d],'k--')
print('-dpng','vt_d.png')
hold off

v=-20:2:20;
contourf(ylat,rC,vt_ed_h_tzav',v)
colorbar
set(gca,'YDir','reverse')
caxis([-20 20])
hold on
plot(ylat,trop_h,'k','LineWidth',2)
plot([plot_min_h, plot_min_h],[98000,0],'k--')
plot([-plot_min_h, -plot_min_h],[98000,0],'k--')
plot([plot_max_h, plot_max_h],[98000,0],'k--')
plot([-plot_max_h, -plot_max_h],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_h,sigma_t_max_h],'k--')
print('-dpng','vt_h.png')
hold off

v=-20:2:20;
contourf(ylat,rC,vt_ed_f_tzav',v)
colorbar
set(gca,'YDir','reverse')
caxis([-20 20])
hold on
plot(ylat,trop_f,'k','LineWidth',2)
plot([plot_min_f, plot_min_f],[98000,0],'k--')
plot([-plot_min_f, -plot_min_f],[98000,0],'k--')
plot([plot_max_f, plot_max_f],[98000,0],'k--')
plot([-plot_max_f, -plot_max_f],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_f,sigma_t_max_f],'k--')
print('-dpng','vt_f.png')
hold off

v=-20:2:20;
contourf(ylat,rC,vt_ed_q_tzav',v)
colorbar
set(gca,'YDir','reverse')
caxis([-20 20])
hold on
plot(ylat,trop_q,'k','LineWidth',2)
plot([plot_min_q, plot_min_q],[98000,0],'k--')
plot([-plot_min_q, -plot_min_q],[98000,0],'k--')
plot([plot_max_q, plot_max_q],[98000,0],'k--')
plot([-plot_max_q, -plot_max_q],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_q,sigma_t_max_q],'k--')
print('-dpng','vt_q.png')
hold off

[theta_f_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_f,ny,yc,ar,hc);
theta_f_tzav = mean(theta_f_zav,3);

v = 250:10:750;
contourf(ylat,rC,theta_f_tzav',v)
colorbar
set(gca,'YDir','reverse')
caxis([250 750])
hold on
plot(ylat,trop_f,'k','LineWidth',2)
plot([plot_min_f, plot_min_f],[98000,0],'k--')
plot([-plot_min_f, -plot_min_f],[98000,0],'k--')
plot([plot_max_f, plot_max_f],[98000,0],'k--')
plot([-plot_max_f, -plot_max_f],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_f,sigma_t_max_f],'k--')
print('-dpng','theta_f.png')
hold off


plot(ylat,barzon_d_b,'r')
hold on
plot(ylat,barzon_h_b,'g')
plot(ylat,barzon_f_b)
plot(ylat,barzon_q_b,'--')
print('-dpng','vt_integral.png')
hold off

save('bc_zone_data.mat')
save('bc_box.mat','barzon_lats_d','barzon_lats_h','barzon_lats_f','barzon_lats_q','level_d','level_h','level_f','level_q')
return


