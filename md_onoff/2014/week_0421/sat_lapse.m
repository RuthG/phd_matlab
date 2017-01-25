%sat_lapse

%calculate saturated adiabatic lapse rate guesstimate and compare with actual lapse rate in tropics...
rDir='/disk1/MITgcm/verification/atm_gray_ruth/ensemble_control/';

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

load('yzav_c.mat')
load('yzav_th.mat')
load('yzav_w.mat')

g=9.81;
cp=1005;
L=2.5e6;
epsilon = 0.622;
Ra=287.04;
Rv=461.50;
%T0 = ones(size(theta_c_yzav)).*273.16;
T0 = 273.16;

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
T_c_yzav(:,k)=theta_c_yzav(:,k).*convthetatoT(k,1);
T_th_yzav(:,k)=theta_th_yzav(:,k).*convthetatoT(k,1);
T_w_yzav(:,k)=theta_w_yzav(:,k).*convthetatoT(k,1);
end

dTdp_c = gradient(T_c_yzav,-4000);
dTdp_th = gradient(T_th_yzav,-4000);
dTdp_w = gradient(T_w_yzav,-4000);


es_c = 305.39.*exp((L./Rv).*(1./T0 - 1./T_c_yzav));
es_th = 305.39.*exp((L./Rv).*(1./T0 - 1./T_th_yzav));
es_w = 610.78.*exp((L./Rv).*(1./T0 - 1./T_w_yzav));

for i=1:25
mus_c(:,i) = epsilon.*es_c(:,i)./rC(i);
mus_th(:,i) = epsilon.*es_th(:,i)./rC(i);
mus_w(:,i) = epsilon.*es_w(:,i)./rC(i);

dTdz_c(:,i) = -1.*dTdp_c(:,i).*g.*rC(i)./(Ra.*T_c_yzav(:,i));
dTdz_th(:,i) = -1.*dTdp_th(:,i).*g.*rC(i)./(Ra.*T_th_yzav(:,i));
dTdz_w(:,i) = -1.*dTdp_w(:,i).*g.*rC(i)./(Ra.*T_w_yzav(:,i));
end

satlapse_c = (g/cp).*(1 + L.*mus_c./(Ra.*T_c_yzav))./(1 + L.^2.*mus_c./(cp.*Rv.*T_c_yzav.^2));
satlapse_th = (g/cp).*(1 + L.*mus_th./(Ra.*T_th_yzav))./(1 + L.^2.*mus_th./(cp.*Rv.*T_th_yzav.^2));
satlapse_w = (g/cp).*(1 + L.*mus_w./(Ra.*T_w_yzav))./(1 + L.^2.*mus_w./(cp.*Rv.*T_w_yzav.^2));

for k=1:25
satlapse_dp_c(:,k) = satlapse_c(:,k).*Ra.*T_c_yzav(:,k)./g./rC(k);
end

drylapse(1:25) = g./cp;
