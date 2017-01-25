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


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearth/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_th(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWN '));
lwn_th(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWD '));
lwd_th(:,:,:,i)=dyn(:,:,:,J);

end

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
T_th(:,:,k,:)=theta_th(:,:,k,:).*convthetatoT(k,1);
end

T_th_mean = mean(T_th,4);
lwn_th_mean = mean(lwn_th,4);
lwd_th_mean = mean(lwd_th,4);


xi=-179:2:180;yi=-89:2:90;
Tll_th=cube2latlon(xc,yc,T_th_mean,xi,yi);
lwnll_th=cube2latlon(xc,yc,lwn_th_mean,xi,yi);
lwdll_th=cube2latlon(xc,yc,lwd_th_mean,xi,yi);

T_th_zav(:,:) = mean(Tll_th,1);
lwn_th_zav(:,:) = mean(lwnll_th,1);
lwd_th_zav(:,:) = mean(lwdll_th,1);

lwu_th_zav = lwn_th_zav + lwd_th_zav;

b_eq_th = (lwu_th_zav + lwd_th_zav)./2;

stefan = 5.6734e-8;

t_eq_th = (b_eq_th./stefan).^(1/4);

dlnTdp_th = gradient(log(T_th_zav),-4000);

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

dTdz_th = prefac.*dlnTdp_th.*1000;

radeq_press_th = rC(min(find(T_th_zav(45,:) - t_eq_th(45,:) <= 0)));

for k=1:25
integrand_th(:,k) = Ra.*T_th_zav(:,k)./g./rC(k);
end

height_th = cumsum(integrand_th,2).*4000;

emheight_th = height_th(45,min(find(T_th_zav(45,:) - t_eq_th(45,:) <= 0)));

surfT=300;
%surfp=101325;

alph = 2^-0.25;

plot(dTdz_th(45,:),rC)
set(gca,'YDir','reverse')

lapseav_th = mean(dTdz_th(45,1:17),2);

height_est_th = (1-alph).*surfT./lapseav_th.*1000 + alph.*emheight_th;


