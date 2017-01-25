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
for nit = 86400
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallowerd_qzero/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_d(:,:,:,i)=dyn(:,:,:,J);
end

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
T_d(:,:,k,:)=theta_d(:,:,k,:).*convthetatoT(k,1);
end

T_d_mean = mean(T_d,4);
q_d_mean = mean(q_d,4);

xi=-179:2:180;yi=-89:2:90;
Tll_d=cube2latlon(xc,yc,T_d_mean,xi,yi);
qll_d=cube2latlon(xc,yc,q_d_mean,xi,yi);

Tll_d_zav(:,:) = mean(Tll_d,1);
qll_d_zav(:,:) = mean(qll_d,1);


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


dTdz_d = prefac.*dlnTdp_d.*1000;


%now try again with calculating saturated lapse rate...

%want mus, need sat vapour pressure first:


es_d = 0.*exp((L./Rv).*(1./T0 - 1./Tll_d_zav));

for i=1:25
mus_d(:,i) = epsilon.*es_d(:,i)./(rC(i)-es_d(:,i)); %epsilon.*es_d(:,i)./rC(i); 
end

relhum_d = qll_d_zav./mus_d;

gamma_s_d = 1000.*g./cp .* (1 + L.*mus_d./(Ra.*Tll_d_zav))./(1+ L^2.*mus_d./(cp.*Rv.*Tll_d_zav.^2));

figure
plot(gamma_s_d(46,:),rC./100,'c:')
hold on

plot(dTdz_d(46,:),rC./100,'c')

set(gca,'YDir','reverse')
xlabel('Lapse rate, K/km')
ylabel('Pressure, hPa')
print('-dpng','lapse.png')

figure
plot(gamma_s_d(68,:),rC./100,'c:')
hold on

plot(dTdz_d(68,:),rC./100,'c')

set(gca,'YDir','reverse')
xlabel('Lapse rate, K/km')
ylabel('Pressure, hPa')
print('-dpng','lapse_extratrop.png')
return
for i=1:45
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
