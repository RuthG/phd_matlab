% lw_plots
% plot difference and percentage difference in heat rates
% plot heat rates associated with different fluxes, try to identify problems
% do some different latitudes too!

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

b_tot = b + b_win;

%calculate heating rates from window and non-window parts, and from up and down fluxes

up_lw = up - up_win;
down_lw = down - down_win;

for k=1:25

%SBDART non window up and down parts
   heat_lwup(:,k) = (fxup_lw(:,k+1) - fxup_lw(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
   heat_lwdn(:,k) = (-fxdn_lw(:,k+1) + fxdn_lw(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));

%SBDART window up and down parts
   heat_winup(:,k) = (fxup_win(:,k+1) - fxup_win(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
   heat_windn(:,k) = (-fxdn_win(:,k+1) + fxdn_win(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));

%Radmod non window up and down parts
   tdt_lwup(:,k) = (up_lw(:,k+1) - up_lw(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
   tdt_lwdn(:,k) = (-down_lw(:,k+1) + down_lw(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));

%SDBART window up and down parts
   tdt_winup(:,k) = (up_win(:,k+1) - up_win(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
   tdt_windn(:,k) = (-down_win(:,k+1) + down_win(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));

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


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v = -1.4:0.4:1.6;
[C,h] = contour(yi,p./100,tdt_lw'.*86400 - heat_lw_tot',v,'k');
set(gca,'YDir','reverse')
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('radiationmod - SBDART: LW heating difference')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v = -160:20:60;
[C,h] = contour(yi,p./100,100.*(tdt_lw'.*86400 - heat_lw_tot')./heat_lw_tot',v,'k');
set(gca,'YDir','reverse')
clabel(C,h);
xlabel('Latitude')
title('radiationmod - SBDART: LW heating percentage difference')

print('-dpdf','lw_heat_diffs.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])

plot(heat_lwup(46,:).*86400,p,'b')
xlabel('Heating rate, K/day')
ylabel('Pressure, Pa')
xlim([-1 7])
set(gca,'YDir','reverse')
hold on
plot(heat_winup(46,:).*86400,p,'r')
plot(tdt_lwup(46,:).*86400,p,'b--')
plot(tdt_winup(46,:).*86400,p,'r--')
legend('Non-Window','Window','Location','SouthEast')
title('Upward heat rates')

axes('position',[pos2x pos2y xSize_sub ySize_sub])

plot(heat_lwdn(46,:).*86400,p,'b')
xlabel('Heating rate, K/day')
set(gca,'YDir','reverse')
xlim([-7 1])
hold on
plot(heat_windn(46,:).*86400,p,'r')
plot(tdt_lwdn(46,:).*86400,p,'b--')
plot(tdt_windn(46,:).*86400,p,'r--')
title('Downward heat rates')

print('-dpdf','lw_heat_decomp.pdf')






% do all plots also for 70N


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(fxdn_lw_tot(81,:), p_half,'r')
set(gca,'YDir','reverse')
hold on
plot(fxup_lw_tot(81,:),p_half,'b')
plot(b_tot(81,:),p,'k')
plot(down(81,:),p_half,'r--')
plot(up(81,:),p_half,'b--')
ylabel('Pressure, Pa')
xlabel('Flux, Wm^{-2}')
title('Total Longwave Fluxes; 70N')


axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(fxdn_win(81,:), p_half,'r')
set(gca,'YDir','reverse')
hold on
plot(fxup_win(81,:),p_half,'b')
plot(b_win(81,:),p,'k')
plot(down_win(81,:),p_half,'r--')
plot(up_win(81,:),p_half,'b--')
xlabel('Flux, Wm^{-2}')
title('Window Region Fluxes')


axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(fxdn_lw(81,:), p_half,'r')
set(gca,'YDir','reverse')
hold on
plot(fxup_lw(81,:),p_half,'b')
plot(b(81,:),p,'k')
plot(down(81,:) - down_win(81,:),p_half,'r--')
plot(up(81,:) - up_win(81,:),p_half,'b--')
ylabel('Pressure, Pa')
xlabel('Flux, Wm^{-2}')
legend('Downward LW flux','Upward LW flux','Blackbody flux','Location','SouthWest')
title('Non-Window Region Fluxes')

print('-dpdf','lw_flux_70.pdf')




hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])

plot(heat_lwup(81,:).*86400,p,'b')
xlabel('Heating rate, K/day')
ylabel('Pressure, Pa')
xlim([-1 3])
set(gca,'YDir','reverse')
hold on
plot(heat_winup(81,:).*86400,p,'r')
plot(tdt_lwup(81,:).*86400,p,'b--')
plot(tdt_winup(81,:).*86400,p,'r--')
legend('Non-Window','Window','Location','SouthEast')
title('Upward heat rates; 70N')

axes('position',[pos2x pos2y xSize_sub ySize_sub])

plot(heat_lwdn(81,:).*86400,p,'b')
xlabel('Heating rate, K/day')
set(gca,'YDir','reverse')
xlim([-3 1])
hold on
plot(heat_windn(81,:).*86400,p,'r')
plot(tdt_lwdn(81,:).*86400,p,'b--')
plot(tdt_windn(81,:).*86400,p,'r--')
title('Downward heat rates')

print('-dpdf','lw_heat_decomp_70.pdf')

