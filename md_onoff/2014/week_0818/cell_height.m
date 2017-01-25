%try to diagnose cell height based on radiative controls/lapse rate


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
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWN '));
lwn_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWD '));
lwd_w(:,:,:,i)=dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearh/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWN '));
lwn_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWD '));
lwd_h(:,:,:,i)=dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearq/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWN '));
lwn_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWD '));
lwd_q(:,:,:,i)=dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yeard/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWN '));
lwn_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWD '));
lwd_d(:,:,:,i)=dyn(:,:,:,J);

end

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
T_w(:,:,k,:)=theta_w(:,:,k,:).*convthetatoT(k,1);
T_h(:,:,k,:)=theta_h(:,:,k,:).*convthetatoT(k,1);
T_q(:,:,k,:)=theta_q(:,:,k,:).*convthetatoT(k,1);
T_d(:,:,k,:)=theta_d(:,:,k,:).*convthetatoT(k,1);
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


T_w_zav(:,:) = mean(Tll_w,1);
T_h_zav(:,:) = mean(Tll_h,1);
T_q_zav(:,:) = mean(Tll_q,1);
T_d_zav(:,:) = mean(Tll_d,1);
lwn_w_zav(:,:) = mean(lwnll_w,1);
lwn_h_zav(:,:) = mean(lwnll_h,1);
lwn_q_zav(:,:) = mean(lwnll_q,1);
lwn_d_zav(:,:) = mean(lwnll_d,1);
lwd_w_zav(:,:) = mean(lwdll_w,1);
lwd_h_zav(:,:) = mean(lwdll_h,1);
lwd_q_zav(:,:) = mean(lwdll_q,1);
lwd_d_zav(:,:) = mean(lwdll_d,1);

lwu_w_zav = lwn_w_zav + lwd_w_zav;
lwu_h_zav = lwn_h_zav + lwd_h_zav;
lwu_q_zav = lwn_q_zav + lwd_q_zav;
lwu_d_zav = lwn_d_zav + lwd_d_zav;

b_eq_w = (lwu_w_zav + lwd_w_zav)./2;
b_eq_h = (lwu_h_zav + lwd_h_zav)./2;
b_eq_q = (lwu_q_zav + lwd_q_zav)./2;
b_eq_d = (lwu_d_zav + lwd_d_zav)./2;

stefan = 5.6734e-8;

t_eq_w = (b_eq_w./stefan).^(1/4);
t_eq_h = (b_eq_h./stefan).^(1/4);
t_eq_q = (b_eq_q./stefan).^(1/4);
t_eq_d = (b_eq_d./stefan).^(1/4);

dlnTdp_w = gradient(log(T_w_zav),-4000);
dlnTdp_h = gradient(log(T_h_zav),-4000);
dlnTdp_q = gradient(log(T_q_zav),-4000);
dlnTdp_d = gradient(log(T_d_zav),-4000);

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


radeq_press_w = rC(min(find(T_w_zav(45,:) - t_eq_w(45,:) <= 0)));
radeq_press_h = rC(min(find(T_h_zav(45,:) - t_eq_h(45,:) <= 0)));
radeq_press_q = rC(min(find(T_q_zav(45,:) - t_eq_q(45,:) <= 0)));
radeq_press_d = rC(min(find(T_d_zav(45,:) - t_eq_d(45,:) <= 0)));


for k=1:25
integrand_w(:,k) = Ra.*T_w_zav(:,k)./g./rC(k);
integrand_h(:,k) = Ra.*T_h_zav(:,k)./g./rC(k);
integrand_q(:,k) = Ra.*T_q_zav(:,k)./g./rC(k);
integrand_d(:,k) = Ra.*T_d_zav(:,k)./g./rC(k);
end

height_w = cumsum(integrand_w,2).*4000;
height_h = cumsum(integrand_h,2).*4000;
height_q = cumsum(integrand_q,2).*4000;
height_d = cumsum(integrand_d,2).*4000;

emheight_w = height_w(45,min(find(T_w_zav(45,:) - t_eq_w(45,:) <= 0)));
emheight_h = height_h(45,min(find(T_h_zav(45,:) - t_eq_h(45,:) <= 0)));
emheight_q = height_q(45,min(find(T_q_zav(45,:) - t_eq_q(45,:) <= 0)));
emheight_d = height_d(45,min(find(T_d_zav(45,:) - t_eq_d(45,:) <= 0)));

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

