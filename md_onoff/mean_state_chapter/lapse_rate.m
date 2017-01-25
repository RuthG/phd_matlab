% choose directory, load grid
rDir='/project/rg312/final_runs/run_100_final/';
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
xi=-179:2:180;yi=-89:2:90;

g=9.8;
kappa = 2/7;
L=2.5e6;
Ra=287.04;
Rv=461.50;
cp=Ra./kappa;
epsilon = Ra/Rv;
T0 = 273.16;

prefac = zeros(90,25);
for k=1:25
prefac(:,k) = rC(k).*g./Ra;
end


load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_000.mat','q_tav','theta_tav')
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
qll=cube2latlon(xc,yc,q_tav,xi,yi);
theta_zav_000(:,:) = mean(thetall,1);
q_zav_000(:,:) = mean(qll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_010.mat','q_tav','theta_tav')
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
qll=cube2latlon(xc,yc,q_tav,xi,yi);
theta_zav_010(:,:) = mean(thetall,1);
q_zav_010(:,:) = mean(qll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_025.mat','q_tav','theta_tav')
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
qll=cube2latlon(xc,yc,q_tav,xi,yi);
theta_zav_025(:,:) = mean(thetall,1);
q_zav_025(:,:) = mean(qll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050.mat','q_tav','theta_tav')
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
qll=cube2latlon(xc,yc,q_tav,xi,yi);
theta_zav_050(:,:) = mean(thetall,1);
q_zav_050(:,:) = mean(qll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_075.mat','q_tav','theta_tav')
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
qll=cube2latlon(xc,yc,q_tav,xi,yi);
theta_zav_075(:,:) = mean(thetall,1);
q_zav_075(:,:) = mean(qll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_100.mat','q_tav','theta_tav')
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
qll=cube2latlon(xc,yc,q_tav,xi,yi);
theta_zav_100(:,:) = mean(thetall,1);
q_zav_100(:,:) = mean(qll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_125.mat','q_tav','theta_tav')
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
qll=cube2latlon(xc,yc,q_tav,xi,yi);
theta_zav_125(:,:) = mean(thetall,1);
q_zav_125(:,:) = mean(qll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_150.mat','q_tav','theta_tav')
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
qll=cube2latlon(xc,yc,q_tav,xi,yi);
theta_zav_150(:,:) = mean(thetall,1);
q_zav_150(:,:) = mean(qll,1);


convthetatoT=(rC/100000.0).^(2./7.);
for k=1:size(rC)
t_zav_000(:,k)=theta_zav_000(:,k).*convthetatoT(k,1);
t_zav_010(:,k)=theta_zav_010(:,k).*convthetatoT(k,1);
t_zav_025(:,k)=theta_zav_025(:,k).*convthetatoT(k,1);
t_zav_050(:,k)=theta_zav_050(:,k).*convthetatoT(k,1);
t_zav_075(:,k)=theta_zav_075(:,k).*convthetatoT(k,1);
t_zav_100(:,k)=theta_zav_100(:,k).*convthetatoT(k,1);
t_zav_125(:,k)=theta_zav_125(:,k).*convthetatoT(k,1);
t_zav_150(:,k)=theta_zav_150(:,k).*convthetatoT(k,1);
end




dlnTdp_000 = gradient(log(t_zav_000),-4000);
dlnTdp_010 = gradient(log(t_zav_010),-4000);
dlnTdp_025 = gradient(log(t_zav_025),-4000);
dlnTdp_050 = gradient(log(t_zav_050),-4000);
dlnTdp_075 = gradient(log(t_zav_075),-4000);
dlnTdp_100 = gradient(log(t_zav_100),-4000);
dlnTdp_125 = gradient(log(t_zav_125),-4000);
dlnTdp_150 = gradient(log(t_zav_150),-4000);

dTdz_000 = prefac.*dlnTdp_000.*1000;
dTdz_010 = prefac.*dlnTdp_010.*1000;
dTdz_025 = prefac.*dlnTdp_025.*1000;
dTdz_050 = prefac.*dlnTdp_050.*1000;
dTdz_075 = prefac.*dlnTdp_075.*1000;
dTdz_100 = prefac.*dlnTdp_100.*1000;
dTdz_125 = prefac.*dlnTdp_125.*1000;
dTdz_150 = prefac.*dlnTdp_150.*1000;


%now try again with calculating saturated lapse rate...

%want mus, need sat vapour pressure first:

es_000 = 0.*610.78.*exp((L./Rv).*(1./T0 - 1./t_zav_000));
es_010 = 0.1.*610.78.*exp((L./Rv).*(1./T0 - 1./t_zav_010));
es_025 = 0.25.*610.78.*exp((L./Rv).*(1./T0 - 1./t_zav_025));
es_050 = 0.5.*610.78.*exp((L./Rv).*(1./T0 - 1./t_zav_050));
es_075 = 0.75.*610.78.*exp((L./Rv).*(1./T0 - 1./t_zav_075));
es_100 = 1.0.*610.78.*exp((L./Rv).*(1./T0 - 1./t_zav_100));
es_125 = 1.25.*610.78.*exp((L./Rv).*(1./T0 - 1./t_zav_125));
es_150 = 1.5.*610.78.*exp((L./Rv).*(1./T0 - 1./t_zav_150));

for i=1:25
mus_000(:,i) = epsilon.*es_000(:,i)./(rC(i)-es_000(:,i)); 
mus_010(:,i) = epsilon.*es_010(:,i)./(rC(i)-es_010(:,i)); 
mus_025(:,i) = epsilon.*es_025(:,i)./(rC(i)-es_025(:,i)); 
mus_050(:,i) = epsilon.*es_050(:,i)./(rC(i)-es_050(:,i)); 
mus_075(:,i) = epsilon.*es_075(:,i)./(rC(i)-es_075(:,i)); 
mus_100(:,i) = epsilon.*es_100(:,i)./(rC(i)-es_100(:,i)); 
mus_125(:,i) = epsilon.*es_125(:,i)./(rC(i)-es_125(:,i)); 
mus_150(:,i) = epsilon.*es_150(:,i)./(rC(i)-es_150(:,i)); 
end

%relhum_000 = q_zav_000./mus_000;

gamma_s_000 = 1000.*g./cp .* (1 + L.*mus_000./(Ra.*t_zav_000))./(1+ L^2.*mus_000./(cp.*Rv.*t_zav_000.^2));
gamma_s_010 = 1000.*g./cp .* (1 + L.*mus_010./(Ra.*t_zav_010))./(1+ L^2.*mus_010./(cp.*Rv.*t_zav_010.^2));
gamma_s_025 = 1000.*g./cp .* (1 + L.*mus_025./(Ra.*t_zav_025))./(1+ L^2.*mus_025./(cp.*Rv.*t_zav_025.^2));
gamma_s_050 = 1000.*g./cp .* (1 + L.*mus_050./(Ra.*t_zav_050))./(1+ L^2.*mus_050./(cp.*Rv.*t_zav_050.^2));
gamma_s_075 = 1000.*g./cp .* (1 + L.*mus_075./(Ra.*t_zav_075))./(1+ L^2.*mus_075./(cp.*Rv.*t_zav_075.^2));
gamma_s_100 = 1000.*g./cp .* (1 + L.*mus_100./(Ra.*t_zav_100))./(1+ L^2.*mus_100./(cp.*Rv.*t_zav_100.^2));
gamma_s_125 = 1000.*g./cp .* (1 + L.*mus_125./(Ra.*t_zav_125))./(1+ L^2.*mus_125./(cp.*Rv.*t_zav_125.^2));
gamma_s_150 = 1000.*g./cp .* (1 + L.*mus_150./(Ra.*t_zav_150))./(1+ L^2.*mus_150./(cp.*Rv.*t_zav_150.^2));





figure
plot(gamma_s_000(46,:),rC./100,'c:')
hold on
plot(gamma_s_010(46,:),rC./100,'r:')
plot(gamma_s_025(46,:),rC./100,'k:')
plot(gamma_s_050(46,:),rC./100,':')
plot(dTdz_000(46,:),rC./100,'c')
plot(dTdz_010(46,:),rC./100,'r')
plot(dTdz_025(46,:),rC./100,'k')
plot(dTdz_050(46,:),rC./100)
set(gca,'YDir','reverse')
xlabel('Lapse rate, K/km')
ylabel('Pressure, hPa')

figure
plot(gamma_s_075(46,:),rC./100,'c:')
hold on
plot(gamma_s_100(46,:),rC./100,'r:')
plot(gamma_s_125(46,:),rC./100,'k:')
plot(gamma_s_150(46,:),rC./100,':')
plot(dTdz_075(46,:),rC./100,'c')
plot(dTdz_100(46,:),rC./100,'r')
plot(dTdz_125(46,:),rC./100,'k')
plot(dTdz_150(46,:),rC./100)
set(gca,'YDir','reverse')
xlabel('Lapse rate, K/km')
ylabel('Pressure, hPa')

return




for i=1:45
relhum_w_hzav(46-i,:) = (relhum_w(i,:) + relhum_w(91-i,:))./2;
relhum_h_hzav(46-i,:) = (relhum_h(i,:) + relhum_h(91-i,:))./2;
relhum_q_hzav(46-i,:) = (relhum_q(i,:) + relhum_q(91-i,:))./2;
relhum_d_hzav(46-i,:) = (relhum_d(i,:) + relhum_d(91-i,:))./2;
end


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


%axes('position',[pos1x pos1y xSize_sub ySize_sub])
%v=-25:5:45;
%[C,h]=contourf(yi(46:90),rC./100.,relhum_d_hzav');
%colorbar
%colormap(b2r(-25,45));
%set(gca,'YDir','reverse')
%ylabel('Pressure, hPa')
%title(['0xwv'])
%freezeColors
%cbfreeze(colorbar);
%hold off

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=0.:0.1:1;
[C,h]=contour(yi(46:90),rC./100.,relhum_q_hzav',v,'k');
%colorbar
%colormap(b2r(-25,45));
set(gca,'YDir','reverse')
title(['0.25xwv'])
%freezeColors
%cbfreeze(colorbar);
clabel(C,h);
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=0.:0.1:1;
[C,h]=contour(yi(46:90),rC./100.,relhum_h_hzav',v,'k');
%colorbar
%colormap(b2r(-25,45));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['0.5xwv'])
%freezeColors
%cbfreeze(colorbar);
clabel(C,h);
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=0.:0.1:1;
[C,h]=contour(yi(46:90),rC./100.,relhum_w_hzav',v,'k');
%colorbar
%colormap(b2r(-25,45));
set(gca,'YDir','reverse')
xlabel('Latitude')
title(['1xwv'])
%freezeColors
%cbfreeze(colorbar);
clabel(C,h);
hold off

print('-dpdf','relhum.pdf')
