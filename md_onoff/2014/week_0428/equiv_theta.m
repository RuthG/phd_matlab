%calculate moist potential temperature 

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

%load in time averaged data

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0421/yzav_c.mat')
load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0421/yzav_th.mat')
load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0421/yzav_w.mat')

%Constants
g=9.81;
cp=1005;
L=2.5e6;
Ra=287.04;
Rv=461.50;
epsilon = Ra/Rv;
T0 = 273.16;

%Calculate T profile from theta
convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
T_c_yzav(:,k)=theta_c_yzav(:,k).*convthetatoT(k,1);
T_th_yzav(:,k)=theta_th_yzav(:,k).*convthetatoT(k,1);
T_w_yzav(:,k)=theta_w_yzav(:,k).*convthetatoT(k,1);
end

%And then differentiate w.r.t. pressure
dTdp_c = gradient(T_c_yzav,-4000);
dTdp_th = gradient(T_th_yzav,-4000);
dTdp_w = gradient(T_w_yzav,-4000);

%want mus, need sat vapour pressure first:

es_c = 305.39.*exp((L./Rv).*(1./T0 - 1./T_c_yzav));
es_th = 305.39.*exp((L./Rv).*(1./T0 - 1./T_th_yzav));
es_w = 610.78.*exp((L./Rv).*(1./T0 - 1./T_w_yzav));

for i=1:25
mus_c(:,i) = epsilon.*es_c(:,i)./(rC(i)-es_c(:,i)); % epsilon.*es_c(:,i)./rC(i); 
mus_th(:,i) = epsilon.*es_th(:,i)./(rC(i)-es_th(:,i)); %epsilon.*es_th(:,i)./rC(i); 
mus_w(:,i) = epsilon.*es_w(:,i)./(rC(i)-es_w(:,i)); %epsilon.*es_w(:,i)./rC(i); 
end

%Use formula for equivalent theta
theta_equiv_c = theta_c_yzav.*exp(L.*mus_c./cp./T_c_yzav);
theta_equiv_th = theta_th_yzav.*exp(L.*mus_th./cp./T_th_yzav);
theta_equiv_w = theta_w_yzav.*exp(L.*mus_w./cp./T_w_yzav);

ylat=1:2:89;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
X = 21.0;                  %# A4 paper size
Y = 29.7;                  %# A4 paper size
xMargin = 0.75;               %# left/right margins from page borders
yMargin = 1;               %# bottom/top margins from page borders
xSize = X - 2*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 2*yMargin;     %# figure size on paper (widht & hieght)
xSize_sub = 0.4;
ySize_sub = 1./3-0.1;

posx = [0.1,0.55,0.1,0.55,0.1,0.55];
posy = [2/3+0.05,2/3+0.05,1/3+0.05,1/3+0.05,0.05,0.05];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[posx(1) posy(1) xSize_sub ySize_sub])
v = 200:30:750;
[C,h] = contour(ylat,rC./100,theta_equiv_c',v,'k');
ylabel('Pressure, hPa')
xlabel('Latitude')
title('Control')
set(gca,'YDir','reverse')
clabel(C,h);

axes('position',[posx(3) posy(3) xSize_sub ySize_sub])
[C,h] = contour(ylat,rC./100,theta_equiv_th',v,'k');
ylabel('Pressure, hPa')
xlabel('Latitude')
title('Tropical heating')
set(gca,'YDir','reverse')
clabel(C,h);

axes('position',[posx(4) posy(4) xSize_sub ySize_sub])
[C,h] = contour(ylat,rC./100,theta_equiv_w',v,'k');
set(gca, 'YTickLabel', []);
xlabel('Latitude')
title('Full water vapour')
set(gca,'YDir','reverse')
clabel(C,h);

axes('position',[posx(5) posy(5) xSize_sub ySize_sub])
v=-10:2:0;
[C,h] = contour(ylat,rC./100,theta_equiv_th' - theta_equiv_c',v,'k--');
clabel(C,h);
hold on
v=0:2:20;
[C,h]=contour(ylat,rC./100.,theta_equiv_th' - theta_equiv_c',v,'k');
ylabel('Pressure, hPa')
xlabel('Latitude')
title('Tropheat - ctrl')
set(gca,'YDir','reverse')
clabel(C,h);

axes('position',[posx(6) posy(6) xSize_sub ySize_sub])
v=-10:2:0;
[C,h] = contour(ylat,rC./100,theta_equiv_w' - theta_equiv_c',v,'k--');
clabel(C,h);
hold on
v=0:2:20;
[C,h]=contour(ylat,rC./100.,theta_equiv_w' - theta_equiv_c',v,'k');
clabel(C,h);
set(gca, 'YTickLabel', []);
xlabel('Latitude')
title('Full wv - ctrl')
set(gca,'YDir','reverse')


print('-dpdf','equiv_theta.pdf')
