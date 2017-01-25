% do last few jobs to check SW radiation: 
% check magfac effects vs SBDART for equinox and solstice situations
% demonstrate upward radiation not too important vs downward

%first look at magfac effects

load('radmod_sw_mag.mat')
load('../week_0915/sw_sbdart_bt.mat')

load('radmod_lw_mag.mat')
load('../week_0915/lw_sbdart_bt.mat')

p = 2000:4000:98000;
p_half = 0.:4000:100000;
grav 		= 9.8;
cp_air 		= 287.04./(2./7);
yi = -89:2:89;

for i=1:25
trans_sw(:,i) = fxdn_sw_half(:,i+1)./fxdn_sw_half(:,1);
end

fxdn_sw_scaled(:,1) = solar_down(:,1);
for i=1:25
fxdn_sw_scaled(:,i+1) = solar_down(:,1).*trans_sw(:,i);
end

heat_lw = heat_lw_l + heat_lw_u;

for k=1:25

   heat_scaled_sw(:,k) = (-fxdn_sw_scaled(:,k+1) + fxdn_sw_scaled(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));

%check relative importance of upward sw fluxes
   heat_up_sw(:,k) = (fxup_sw_half(:,k+1) - fxup_sw_half(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
   heat_dn_sw(:,k) = (-fxdn_sw_half(:,k+1) + fxdn_sw_half(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));

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
v=0:0.1:1.6;
label = 0:0.2:1.6;
[C,h] = contour(yi,p,heat_scaled_sw'.*86400,v,'k');
clabel(C,h,label);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title('SW heating rate, K/day (SBDART)')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi,p,tdt_sw'.*86400,v,'k');
clabel(C,h,label);
set(gca,'YDir','reverse')
title('SW heating rate, K/day (RadMod)')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-4:0.2:0.2;
[C,h] = contour(yi(2:89),p,(heat_lw(2:89,:)'+heat_win(2:89,:)'),v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title('LW heating rate, K/day (SBDART)')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi,p,tdt_lw'.*86400,v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
title('LW heating rate, K/day (RadMod)')

print('-dpdf','heatrates_bt_mag.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-1:0.1:1;
label = -1:0.1:1;
[C,h] = contour(yi,p,heat_up_sw'.*86400,v,'k');
clabel(C,h,label);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title('SW heating rate, upward beam, K/day (SBDART)')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=0:0.5:4.5;
label = 0:0.5:4.5;
[C,h] = contour(yi,p,heat_dn_sw'.*86400,v,'k');
clabel(C,h,label);
set(gca,'YDir','reverse')
xlabel('Latitude')
title('SW heating rate, downward beam, K/day (SBDART)')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=0:0.5:4.5;
label = 0:0.5:4.5;
[C,h] = contour(yi,p,(heat_dn_sw' + heat_up_sw').*86400,v,'k');
clabel(C,h,label);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title('SW heating rate, total, K/day (SBDART)')


print('-dpdf','heat_updn_mag.pdf')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% Repeat for szen run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



load('radmod_sw_szen_mag.mat')
load('../week_0915/sw_sbdart_szen.mat')

load('radmod_lw_szen_mag.mat')
load('../week_0915/lw_sbdart_szen.mat')



p = 2000:4000:98000;
p_half = 0.:4000:100000;
grav 		= 9.8;
cp_air 		= 287.04./(2./7);
yi = -89:2:89;

for i=1:25
trans_sw(:,i) = fxdn_sw_half(:,i+1)./fxdn_sw_half(:,1);
end

fxdn_sw_scaled(:,1) = solar_down(:,1);
for i=1:25
fxdn_sw_scaled(:,i+1) = solar_down(:,1).*trans_sw(:,i);
end

heat_lw = heat_lw_l + heat_lw_u;

for k=1:25

   heat_scaled_sw(:,k) = (-fxdn_sw_scaled(:,k+1) + fxdn_sw_scaled(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));

%check relative importance of upward sw fluxes
   heat_up_sw(:,k) = (fxup_sw_half(:,k+1) - fxup_sw_half(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
   heat_dn_sw(:,k) = (-fxdn_sw_half(:,k+1) + fxdn_sw_half(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));

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
v=0:0.5:4.5;
label = 0:0.5:4.5;
[C,h] = contour(yi,p,heat_scaled_sw'.*86400,v,'k');
clabel(C,h,label);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title('SW heating rate, K/day (SBDART)')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi,p,tdt_sw'.*86400,v,'k');
clabel(C,h,label);
set(gca,'YDir','reverse')
title('SW heating rate, K/day (RadMod)')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-4:0.2:0.2;
[C,h] = contour(yi(2:89),p,(heat_lw(2:89,:)'+heat_win(2:89,:)'),v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title('LW heating rate, K/day (SBDART)')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi,p,tdt_lw'.*86400,v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
title('LW heating rate, K/day (RadMod)')

print('-dpdf','heatrates_szen_mag.pdf')




hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-1:0.1:1;
label = -1:0.1:1;
[C,h] = contour(yi,p,heat_up_sw'.*86400,v,'k');
clabel(C,h,label);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title('SW heating rate, upward beam, K/day (SBDART)')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=0:0.5:4.5;
label = 0:0.5:4.5;
[C,h] = contour(yi,p,heat_dn_sw'.*86400,v,'k');
clabel(C,h,label);
set(gca,'YDir','reverse')
xlabel('Latitude')
title('SW heating rate, downward beam, K/day (SBDART)')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=0:0.5:4.5;
label = 0:0.5:4.5;
[C,h] = contour(yi,p,(heat_dn_sw' + heat_up_sw').*86400,v,'k');
clabel(C,h,label);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title('SW heating rate, total, K/day (SBDART)')


print('-dpdf','heat_updn_szen_mag.pdf')
