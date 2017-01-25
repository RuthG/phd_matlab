
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
for nit = 259200:86400:432000;
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i) = dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);
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
J=find(strcmp(fldList,'UVELSQ  '));
usqcs_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSQ  '));
vsqcs_h(:,:,:,i) = dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearq/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
ucs_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_q(:,:,:,i) = dyn(:,:,:,J);
[uE_q(:,:,:,i),vN_q(:,:,:,i)] = rotate_uv2uvEN(ucs_q(:,:,:,i),vcs_q(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'UVELSQ  '));
usqcs_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSQ  '));
vsqcs_q(:,:,:,i) = dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yeard/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
ucs_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_d(:,:,:,i) = dyn(:,:,:,J);
[uE_d(:,:,:,i),vN_d(:,:,:,i)] = rotate_uv2uvEN(ucs_d(:,:,:,i),vcs_d(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'UVELSQ  '));
usqcs_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSQ  '));
vsqcs_d(:,:,:,i) = dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearth/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
ucs_th(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_th(:,:,:,i) = dyn(:,:,:,J);
[uE_th(:,:,:,i),vN_th(:,:,:,i)] = rotate_uv2uvEN(ucs_th(:,:,:,i),vcs_th(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'UVELSQ  '));
usqcs_th(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSQ  '));
vsqcs_th(:,:,:,i) = dyn(:,:,:,J);

end

uE_w_tav = mean(uE_w,4);
uE_h_tav = mean(uE_h,4);
uE_q_tav = mean(uE_q,4);
uE_d_tav = mean(uE_d,4);
uE_th_tav = mean(uE_th,4);

vN_w_tav = mean(vN_w,4);
vN_h_tav = mean(vN_h,4);
vN_q_tav = mean(vN_q,4);
vN_d_tav = mean(vN_d,4);
vN_th_tav = mean(vN_th,4);

tke_w = (usqcs_w + vsqcs_w)./2;
tke_h = (usqcs_h + vsqcs_h)./2;
tke_q = (usqcs_q + vsqcs_q)./2;
tke_d = (usqcs_d + vsqcs_d)./2;
tke_th = (usqcs_th + vsqcs_th)./2;

tke_w_tav = mean(tke_w,4);
tke_h_tav = mean(tke_h,4);
tke_q_tav = mean(tke_q,4);
tke_d_tav = mean(tke_d,4);
tke_th_tav = mean(tke_th,4);

p0 = 100000;

xi=-179:2:180;yi=-89:2:90;
uEll_w=cube2latlon(xc,yc,uE_w_tav,xi,yi);
vNll_w=cube2latlon(xc,yc,vN_w_tav,xi,yi);
tkell_w=cube2latlon(xc,yc,tke_w_tav,xi,yi);
uEll_h=cube2latlon(xc,yc,uE_h_tav,xi,yi);
vNll_h=cube2latlon(xc,yc,vN_h_tav,xi,yi);
tkell_h=cube2latlon(xc,yc,tke_h_tav,xi,yi);
uEll_q=cube2latlon(xc,yc,uE_q_tav,xi,yi);
vNll_q=cube2latlon(xc,yc,vN_q_tav,xi,yi);
tkell_q=cube2latlon(xc,yc,tke_q_tav,xi,yi);
uEll_d=cube2latlon(xc,yc,uE_d_tav,xi,yi);
vNll_d=cube2latlon(xc,yc,vN_d_tav,xi,yi);
tkell_d=cube2latlon(xc,yc,tke_d_tav,xi,yi);
uEll_th=cube2latlon(xc,yc,uE_th_tav,xi,yi);
vNll_th=cube2latlon(xc,yc,vN_th_tav,xi,yi);
tkell_th=cube2latlon(xc,yc,tke_th_tav,xi,yi);

uE_w_zav(:,:) = mean(uEll_w,1);
vN_w_zav(:,:) = mean(vNll_w,1);
tke_w_zav(:,:) = mean(tkell_w,1);
uE_h_zav(:,:) = mean(uEll_h,1);
vN_h_zav(:,:) = mean(vNll_h,1);
tke_h_zav(:,:) = mean(tkell_h,1);
uE_q_zav(:,:) = mean(uEll_q,1);
vN_q_zav(:,:) = mean(vNll_q,1);
tke_q_zav(:,:) = mean(tkell_q,1);
uE_d_zav(:,:) = mean(uEll_d,1);
vN_d_zav(:,:) = mean(vNll_d,1);
tke_d_zav(:,:) = mean(tkell_d,1);
uE_th_zav(:,:) = mean(uEll_th,1);
vN_th_zav(:,:) = mean(vNll_th,1);
tke_th_zav(:,:) = mean(tkell_th,1);

zke_w_zav = (uE_w_zav.^2 + vN_w_zav.^2)./2;
zke_h_zav = (uE_h_zav.^2 + vN_h_zav.^2)./2;
zke_q_zav = (uE_q_zav.^2 + vN_q_zav.^2)./2;
zke_d_zav = (uE_d_zav.^2 + vN_d_zav.^2)./2;
zke_th_zav = (uE_th_zav.^2 + vN_th_zav.^2)./2;

eke_w =  tke_w_zav - zke_w_zav;
eke_h =  tke_h_zav - zke_h_zav;
eke_q =  tke_q_zav - zke_q_zav;
eke_d =  tke_d_zav - zke_d_zav;
eke_th =  tke_th_zav - zke_th_zav;

%convert to two hemispheres
eke_hem_th(:,:,1) = eke_th(46:90,:);
eke_hem_d(:,:,1) = eke_d(46:90,:);
eke_hem_q(:,:,1) = eke_q(46:90,:);
eke_hem_h(:,:,1) = eke_h(46:90,:);
eke_hem_w(:,:,1) = eke_w(46:90,:);

for i=1:45
eke_hem_th(i,:,2) = eke_th(46-i,:);
eke_hem_d(i,:,2) = eke_d(46-i,:);
eke_hem_q(i,:,2) = eke_q(46-i,:);
eke_hem_h(i,:,2) = eke_h(46-i,:);
eke_hem_w(i,:,2) = eke_w(46-i,:);
end

name = ['bc_box_th.mat'];
load(name)
name = ['bc_box_d.mat'];
load(name)
name = ['bc_box_q.mat'];
load(name)
name = ['bc_box_h.mat'];
load(name)
name = ['bc_box_w.mat'];
load(name)

if mod(barzon_lats_th(1),2) == 0
barzon_reg_th = barzon_lats_th(1)+1:2:barzon_lats_th(2)+1;
else
barzon_reg_th = barzon_lats_th(1):2:barzon_lats_th(2);
end

if mod(barzon_lats_d(1),2) == 0
barzon_reg_d = barzon_lats_d(1)+1:2:barzon_lats_d(2)+1;
else
barzon_reg_d = barzon_lats_d(1):2:barzon_lats_d(2);
end

if mod(barzon_lats_q(1),2) == 0
barzon_reg_q = barzon_lats_q(1)+1:2:barzon_lats_q(2)+1;
else
barzon_reg_q = barzon_lats_q(1):2:barzon_lats_q(2);
end

if mod(barzon_lats_h(1),2) == 0
barzon_reg_h = barzon_lats_h(1)+1:2:barzon_lats_h(2)+1;
else
barzon_reg_h = barzon_lats_h(1):2:barzon_lats_h(2);
end

if mod(barzon_lats_w(1),2) == 0
barzon_reg_w = barzon_lats_w(1)+1:2:barzon_lats_w(2)+1;
else
barzon_reg_w = barzon_lats_w(1):2:barzon_lats_w(2);
end


%set up loop
ylat2=1:2:89;
start_th = find(ylat2 == min(barzon_reg_th))-1;
start_d = find(ylat2 == min(barzon_reg_d))-1;
start_q = find(ylat2 == min(barzon_reg_q))-1;
start_h = find(ylat2 == min(barzon_reg_h))-1;
start_w = find(ylat2 == min(barzon_reg_w))-1;

for i=1:size(barzon_reg_th,2)
eke_weight_th(i,:,:) = cos(barzon_reg_th(i).*pi./180) .* eke_hem_th(start_th+i,:,:) ;
cosy_th(i) = cos(barzon_reg_th(i).*pi./180);
end
for i=1:size(barzon_reg_d,2)
eke_weight_d(i,:,:) = cos(barzon_reg_d(i).*pi./180) .* eke_hem_d(start_d+i,:,:) ;
cosy_d(i) = cos(barzon_reg_d(i).*pi./180);
end
for i=1:size(barzon_reg_q,2)
eke_weight_q(i,:,:) = cos(barzon_reg_q(i).*pi./180) .* eke_hem_q(start_q+i,:,:) ;
cosy_q(i) = cos(barzon_reg_q(i).*pi./180);
end
for i=1:size(barzon_reg_h,2)
eke_weight_h(i,:,:) = cos(barzon_reg_h(i).*pi./180) .* eke_hem_h(start_h+i,:,:) ;
cosy_h(i) = cos(barzon_reg_h(i).*pi./180);
end
for i=1:size(barzon_reg_w,2)
eke_weight_w(i,:,:) = cos(barzon_reg_w(i).*pi./180) .* eke_hem_w(start_w+i,:,:) ;
cosy_w(i) = cos(barzon_reg_w(i).*pi./180);
end

eke_bzav_th(:,:) = sum(eke_weight_th,1)./sum(cosy_th) ;
eke_bzav_d(:,:) = sum(eke_weight_d,1)./sum(cosy_d) ;
eke_bzav_q(:,:) = sum(eke_weight_q,1)./sum(cosy_q) ;
eke_bzav_h(:,:) = sum(eke_weight_h,1)./sum(cosy_h) ;
eke_bzav_w(:,:) = sum(eke_weight_w,1)./sum(cosy_w) ;

eke_bzav_th_av = mean(eke_bzav_th,2);
eke_bzav_d_av = mean(eke_bzav_d,2);
eke_bzav_q_av = mean(eke_bzav_q,2);
eke_bzav_h_av = mean(eke_bzav_h,2);
eke_bzav_w_av = mean(eke_bzav_w,2);

figure
plot(eke_bzav_d_av,rC,'k')
set(gca,'YDir','reverse')
hold on
plot(eke_bzav_q_av,rC,'r')
plot(eke_bzav_h_av,rC,'g')
plot(eke_bzav_w_av,rC,'b')
plot(eke_bzav_th_av,rC,'m')
print('-dpng','eke_bzav.png')


%integrating over dp/g is rho dz

eke_int_th = sum(eke_bzav_th(1:level_th,:),1) .* 4000./9.81;
eke_int_d = sum(eke_bzav_d(1:level_d,:),1) .* 4000./9.81;
eke_int_q = sum(eke_bzav_q(1:level_q,:),1) .* 4000./9.81;
eke_int_h = sum(eke_bzav_h(1:level_h,:),1) .* 4000./9.81;
eke_int_w = sum(eke_bzav_w(1:level_w,:),1) .* 4000./9.81;

eke_out_th = mean(eke_int_th);
eke_out_d = mean(eke_int_d);
eke_out_q = mean(eke_int_q);
eke_out_h = mean(eke_int_h);
eke_out_w = mean(eke_int_w);

%save
name = ['eke_out.mat'];
save(name, 'eke_out_d', 'eke_out_q','eke_out_h','eke_out_w','eke_out_th')




