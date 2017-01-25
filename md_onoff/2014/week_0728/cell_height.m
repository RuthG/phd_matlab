%try to diagnose cell height based on radiative controls/lapse rate


% choose directory, load grid
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

%read files
i=0;
for nit = 259200:86400:604800;
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWN '));
lwn_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWD '));
lwd_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radhtth_w(:,:,:,i)=dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWN '));
lwn_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWD '));
lwd_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radhtth_h(:,:,:,i)=dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_quarterwv/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWN '));
lwn_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWD '));
lwd_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radhtth_q(:,:,:,i)=dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWN '));
lwn_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWD '));
lwd_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radhtth_d(:,:,:,i)=dyn(:,:,:,J);

end

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
T_w(:,:,k,:)=theta_w(:,:,k,:).*convthetatoT(k,1);
T_h(:,:,k,:)=theta_h(:,:,k,:).*convthetatoT(k,1);
T_q(:,:,k,:)=theta_q(:,:,k,:).*convthetatoT(k,1);
T_d(:,:,k,:)=theta_d(:,:,k,:).*convthetatoT(k,1);
radht_w(:,:,k,:)=radhtth_w(:,:,k,:).*convthetatoT(k,1);
radht_h(:,:,k,:)=radhtth_h(:,:,k,:).*convthetatoT(k,1);
radht_q(:,:,k,:)=radhtth_q(:,:,k,:).*convthetatoT(k,1);
radht_d(:,:,k,:)=radhtth_d(:,:,k,:).*convthetatoT(k,1);
end

T_w_mean = mean(T_w,4);
T_h_mean = mean(T_h,4);
T_q_mean = mean(T_q,4);
T_d_mean = mean(T_d,4);
lwn_w_mean = mean(lwn_w,4);
lwn_h_mean = mean(lwn_h,4);
lwn_q_mean = mean(lwn_q,4);
lwn_d_mean = mean(lwn_d,4);
lwd_w_mean = mean(lwd_w,4);
lwd_h_mean = mean(lwd_h,4);
lwd_q_mean = mean(lwd_q,4);
lwd_d_mean = mean(lwd_d,4);
radht_w_mean = mean(radht_w,4);
radht_h_mean = mean(radht_h,4);
radht_q_mean = mean(radht_q,4);
radht_d_mean = mean(radht_d,4);

xi=-179:2:180;yi=-89:2:90;
Tll_w=cube2latlon(xc,yc,T_w_mean,xi,yi);
Tll_h=cube2latlon(xc,yc,T_h_mean,xi,yi);
Tll_q=cube2latlon(xc,yc,T_q_mean,xi,yi);
Tll_d=cube2latlon(xc,yc,T_d_mean,xi,yi);
lwnll_w=cube2latlon(xc,yc,lwn_w_mean,xi,yi);
lwnll_h=cube2latlon(xc,yc,lwn_h_mean,xi,yi);
lwnll_q=cube2latlon(xc,yc,lwn_q_mean,xi,yi);
lwnll_d=cube2latlon(xc,yc,lwn_d_mean,xi,yi);
lwdll_w=cube2latlon(xc,yc,lwd_w_mean,xi,yi);
lwdll_h=cube2latlon(xc,yc,lwd_h_mean,xi,yi);
lwdll_q=cube2latlon(xc,yc,lwd_q_mean,xi,yi);
lwdll_d=cube2latlon(xc,yc,lwd_d_mean,xi,yi);
radhtll_w=cube2latlon(xc,yc,radht_w_mean,xi,yi);
radhtll_h=cube2latlon(xc,yc,radht_h_mean,xi,yi);
radhtll_q=cube2latlon(xc,yc,radht_q_mean,xi,yi);
radhtll_d=cube2latlon(xc,yc,radht_d_mean,xi,yi);

Tll_w_zav(:,:) = mean(Tll_w,1);
Tll_h_zav(:,:) = mean(Tll_h,1);
Tll_q_zav(:,:) = mean(Tll_q,1);
Tll_d_zav(:,:) = mean(Tll_d,1);
lwnll_w_zav(:,:) = mean(lwnll_w,1);
lwnll_h_zav(:,:) = mean(lwnll_h,1);
lwnll_q_zav(:,:) = mean(lwnll_q,1);
lwnll_d_zav(:,:) = mean(lwnll_d,1);
lwdll_w_zav(:,:) = mean(lwdll_w,1);
lwdll_h_zav(:,:) = mean(lwdll_h,1);
lwdll_q_zav(:,:) = mean(lwdll_q,1);
lwdll_d_zav(:,:) = mean(lwdll_d,1);
radhtll_w_zav(:,:) = mean(radhtll_w,1);
radhtll_h_zav(:,:) = mean(radhtll_h,1);
radhtll_q_zav(:,:) = mean(radhtll_q,1);
radhtll_d_zav(:,:) = mean(radhtll_d,1);

dlnTdp_w = gradient(log(Tll_w_zav),-4000);
dlnTdp_h = gradient(log(Tll_h_zav),-4000);
dlnTdp_q = gradient(log(Tll_q_zav),-4000);
dlnTdp_d = gradient(log(Tll_d_zav),-4000);

g=9.81;
cp=1005;
L=2.5e6;
Ra=287.04;
Rv=461.50;
epsilon = Ra/Rv;
T0 = 273.16;

prefac = zeros(90,25);
for k=1:25
prefac(:,k) = rC(k).*g./Ra;
end

dTdz_w = prefac.*dlnTdp_w.*1000;
dTdz_h = prefac.*dlnTdp_h.*1000;
dTdz_q = prefac.*dlnTdp_q.*1000;
dTdz_d = prefac.*dlnTdp_d.*1000;

stefbo = 5.6734e-8;
bb_w = stefbo.*Tll_w_zav.^4;
bb_h = stefbo.*Tll_h_zav.^4;
bb_q = stefbo.*Tll_q_zav.^4;
bb_d = stefbo.*Tll_d_zav.^4;

bbeq_w = (lwdll_w_zav - (lwnll_w_zav-lwdll_w_zav))./2;


radeq_press_w = rC(max(find(radhtll_w_zav(45,:) <= 0)));
radeq_press_h = rC(max(find(radhtll_h_zav(45,:) <= 0)));
radeq_press_q = rC(max(find(radhtll_q_zav(45,:) <= 0)));
radeq_press_d = rC(max(find(radhtll_d_zav(45,:) <= 0)));

for k=1:25
integrand_w(:,k) = Ra.*Tll_w_zav(:,k)./g./rC(k);
integrand_h(:,k) = Ra.*Tll_h_zav(:,k)./g./rC(k);
integrand_q(:,k) = Ra.*Tll_q_zav(:,k)./g./rC(k);
integrand_d(:,k) = Ra.*Tll_d_zav(:,k)./g./rC(k);
end

height_w = cumsum(integrand_w,2).*4000;
height_h = cumsum(integrand_h,2).*4000;
height_q = cumsum(integrand_q,2).*4000;
height_d = cumsum(integrand_d,2).*4000;

emheight_w = height_w(45,max(find(radhtll_w_zav(45,:) <= 0)));
emheight_h = height_h(45,max(find(radhtll_h_zav(45,:) <= 0)));
emheight_q = height_q(45,max(find(radhtll_q_zav(45,:) <= 0)));
emheight_d = height_d(45,max(find(radhtll_d_zav(45,:) <= 0)));

surfT=300;
%surfp=101325;

alph = 2^-0.25;

plot(dTdz_w(45,:),rC)
hold on
plot(dTdz_h(45,:),rC)
plot(dTdz_q(45,:),rC)
plot(dTdz_d(45,:),rC)
set(gca,'YDir','reverse')

lapseav_w = mean(dTdz_w(45,1:17),2);
lapseav_h = mean(dTdz_h(45,1:17),2);
lapseav_q = mean(dTdz_q(45,1:17),2);
lapseav_d = mean(dTdz_d(45,1:17),2);

height_est_w = (1-alph).*surfT./lapseav_w.*1000 + alph.*emheight_w;
height_est_h = (1-alph).*surfT./lapseav_h.*1000 + alph.*emheight_h;
height_est_q = (1-alph).*surfT./lapseav_q.*1000 + alph.*emheight_q;
height_est_d = (1-alph).*surfT./lapseav_d.*1000 + alph.*emheight_d;


height_play1_d = (1-alph).*surfT./lapseav_d.*1000 + alph.*emheight_w;
height_play1_q = (1-alph).*surfT./lapseav_q.*1000 + alph.*emheight_w;
height_play1_h = (1-alph).*surfT./lapseav_h.*1000 + alph.*emheight_w;

height_play2_d = (1-alph).*surfT./lapseav_w.*1000 + alph.*emheight_d;
height_play2_q = (1-alph).*surfT./lapseav_w.*1000 + alph.*emheight_q;
height_play2_h = (1-alph).*surfT./lapseav_w.*1000 + alph.*emheight_h;

