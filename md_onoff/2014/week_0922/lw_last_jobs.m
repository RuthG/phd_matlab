%load up sbdart and rad_mod lw profiles and plot vertical lines for each. Check how heat rates from window and non window compare, where are our weaknesses...?

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
drC=squeeze(rdmds([rDir,'DRC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
ny=90;

xi=-179:2:180;yi=-89:2:90;
yy=yi*90/60*pi/180;
sinyy=sin(yy);
sst=27*(1-sinyy.*sinyy);
sst(find(abs(yi)>=60))=0;
t_surf=sst+273.15;
p = 2000:4000:98000;
p_half = 0.:4000:100000;
grav 		= 9.8;
cp_air 		= 287.04./(2./7);

load('../week_0915/radmod_lw.mat')
load('../week_0922/lw_sbdart.mat')

heat_lw_tot = heat_lw_u + heat_lw_l + heat_win;
fxdn_lw_tot = fxdn_lw_u + fxdn_lw_l + fxdn_win;
fxup_lw_tot = fxup_lw_u + fxup_lw_l + fxup_win;

heat_lw = heat_lw_l + heat_lw_u;
fxdn_lw = fxdn_lw_l + fxdn_lw_u;
fxup_lw = fxup_lw_l + fxup_lw_u;

up_lw = up - up_win;
down_lw = down - down_win;

for k=1:25

   heat_lwup(:,k) = (fxup_lw(:,k+1) - fxup_lw(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
   heat_lwdn(:,k) = (-fxdn_lw(:,k+1) + fxdn_lw(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));

   heat_winup(:,k) = (fxup_win(:,k+1) - fxup_win(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
   heat_windn(:,k) = (-fxdn_win(:,k+1) + fxdn_win(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));

   tdt_lwup(:,k) = (up_lw(:,k+1) - up_lw(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
   tdt_lwdn(:,k) = (-down_lw(:,k+1) + down_lw(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));

   tdt_winup(:,k) = (up_win(:,k+1) - up_win(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
   tdt_windn(:,k) = (-down_win(:,k+1) + down_win(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));

end


%plot vertical profiles of heat rates at 0, 20, 40, 60, 80 degrees


figure
plot(heat_lw_tot(46,:),p,'b')
xlabel('Heating rate, K/day')
ylabel('Pressure, Pa')
title('Longwave heating rates')
set(gca,'YDir','reverse')
hold on
%plot(heat_lw_tot(56,:),p,'m')
plot(heat_lw_tot(66,:),p,'g')
%plot(heat_lw_tot(76,:),p,'k')
plot(heat_lw_tot(86,:),p,'r')
plot(tdt_lw(46,:).*86400,p,'b--')
%plot(tdt_lw(56,:).*86400,p,'m--')
plot(tdt_lw(66,:).*86400,p,'g--')
%plot(tdt_lw(76,:).*86400,p,'k--')
plot(tdt_lw(86,:).*86400,p,'r--')
%legend('Equator','lat=20','lat=40','lat=60','lat=80','Location','SouthWest')
legend('Equator','lat=40','lat=80','Location','SouthWest')
print('-dpdf','lw_heat_profiles.pdf')

%look at window versus non window
figure
plot(heat_win(46,:),p,'b')
xlabel('Heating rate, window, K/day')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
hold on
plot(heat_win(56,:),p,'m')
plot(heat_win(66,:),p,'g')
plot(heat_win(76,:),p,'k')
plot(heat_win(86,:),p,'r')
plot(tdt_win(46,:).*86400,p,'b:')
plot(tdt_win(56,:).*86400,p,'m:')
plot(tdt_win(66,:).*86400,p,'g:')
plot(tdt_win(76,:).*86400,p,'k:')
plot(tdt_win(86,:).*86400,p,'r:')


figure
plot(heat_lw(46,:),p,'b')
xlabel('Heating rate, non-window, K/day')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
hold on
plot(heat_lw(56,:),p,'m')
plot(heat_lw(66,:),p,'g')
plot(heat_lw(76,:),p,'k')
plot(heat_lw(86,:),p,'r')
plot((tdt_lw(46,:) - tdt_win(46,:)).*86400,p,'b:')
plot((tdt_lw(56,:) - tdt_win(56,:)).*86400,p,'m:')
plot((tdt_lw(66,:) - tdt_win(66,:)).*86400,p,'g:')
plot((tdt_lw(76,:) - tdt_win(76,:)).*86400,p,'k:')
plot((tdt_lw(86,:) - tdt_win(86,:)).*86400,p,'r:')

%look at olr and surface fluxes

figure
plot(yi(2:89),fxup_lw_tot(2:89,1) - fxdn_lw_tot(2:89,1),'r')
hold on
plot(yi(2:89),fxup_lw_tot(2:89,26) - fxdn_lw_tot(2:89,26),'b')
plot(yi(2:89),net(2:89,1),'r--')
plot(yi(2:89),net(2:89,26),'b--')
xlabel('Latitude')
ylabel('Net longwave flux, Wm^{-2}')
title('Net OLR and Surface Longwave Fluxes')
legend('OLR','Surface')
print('-dpdf','olrsurflw.pdf')



figure
plot(yi(2:89),net_win(2:89,1))
hold on
plot(yi(2:89),fxup_win(2:89,1) - fxdn_win(2:89,1),'r')

figure
plot(yi(2:89),net_win(2:89,26))
hold on
plot(yi(2:89),fxup_win(2:89,26) - fxdn_win(2:89,26),'r')

%look at down vs up
%ud_irrel = true;
ud_irrel = false;

if ud_irrel

else 

figure
plot(heat_lwup(46,:).*86400,p,'b')
xlabel('Heating rate, K/day')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
hold on
plot(heat_lwup(56,:).*86400,p,'m')
plot(heat_lwup(66,:).*86400,p,'g')
plot(heat_lwup(76,:).*86400,p,'k')
plot(heat_lwup(86,:).*86400,p,'r')
plot(tdt_lwup(46,:).*86400,p,'b:')
plot(tdt_lwup(56,:).*86400,p,'m:')
plot(tdt_lwup(66,:).*86400,p,'g:')
plot(tdt_lwup(76,:).*86400,p,'k:')
plot(tdt_lwup(86,:).*86400,p,'r:')

figure
plot(heat_lwdn(46,:).*86400,p,'b')
xlabel('Heating rate, K/day')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
hold on
plot(heat_lwdn(56,:).*86400,p,'m')
plot(heat_lwdn(66,:).*86400,p,'g')
plot(heat_lwdn(76,:).*86400,p,'k')
plot(heat_lwdn(86,:).*86400,p,'r')
plot(tdt_lwdn(46,:).*86400,p,'b:')
plot(tdt_lwdn(56,:).*86400,p,'m:')
plot(tdt_lwdn(66,:).*86400,p,'g:')
plot(tdt_lwdn(76,:).*86400,p,'k:')
plot(tdt_lwdn(86,:).*86400,p,'r:')

figure
plot(heat_winup(46,:).*86400,p,'b')
xlabel('Heating rate, K/day')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
hold on
plot(heat_winup(56,:).*86400,p,'m')
plot(heat_winup(66,:).*86400,p,'g')
plot(heat_winup(76,:).*86400,p,'k')
plot(heat_winup(86,:).*86400,p,'r')
plot(tdt_winup(46,:).*86400,p,'b:')
plot(tdt_winup(56,:).*86400,p,'m:')
plot(tdt_winup(66,:).*86400,p,'g:')
plot(tdt_winup(76,:).*86400,p,'k:')
plot(tdt_winup(86,:).*86400,p,'r:')

figure
plot(heat_windn(46,:).*86400,p,'b')
xlabel('Heating rate, K/day')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
hold on
plot(heat_windn(56,:).*86400,p,'m')
plot(heat_windn(66,:).*86400,p,'g')
plot(heat_windn(76,:).*86400,p,'k')
plot(heat_windn(86,:).*86400,p,'r')
plot(tdt_windn(46,:).*86400,p,'b:')
plot(tdt_windn(56,:).*86400,p,'m:')
plot(tdt_windn(66,:).*86400,p,'g:')
plot(tdt_windn(76,:).*86400,p,'k:')
plot(tdt_windn(86,:).*86400,p,'r:')

end





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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
v=-4:0.4:0.4;
[C,h] = contour(yi(2:89),p,(heat_lw(2:89,:)'+heat_win(2:89,:)'),v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title('LW heating rate, K/day (SBDART)')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi(2:89),p,tdt_lw(2:89,:)'.*86400,v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
title('LW heating rate, K/day (RadMod)')

print('-dpdf','heatrates_lw_zlevs.pdf')


figure
plot(yi(2:89),(heat_lw(2:89,25)'+heat_win(2:89,25)'));
hold on
plot(yi(2:89),tdt_lw(2:89,25)'.*86400,'b--');
ylabel('Pressure, hPa')
xlabel('Latitude')
title('LW surface heating rate, K/day')
print('-dpdf','heatrates_lw_surf.pdf')




