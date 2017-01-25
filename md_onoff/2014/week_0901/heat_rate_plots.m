%plot up heat rates to help thinking about cell width

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
rC=squeeze(rdmds([rDir,'RC']));
yi = 1:2:89;
g=9.81;
cp=1004.64;
intfac = 4000.*cp./g;
es0(1) = 610.78;
es0(2) = 305.39;
es0(3) = 305.39./2;
es0(4) = 0;
es0(5) = 305.39;

load('heat_budg_vars.mat')
load('lapse_rates.mat')



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

v=-3:0.5:5;

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi,rC,htrtll_d_hzav'.*86400,v,'k');
clabel(C,h);
title(['0xwv'])
ylabel('Pressure, hPa')
set(gca,'YDir','reverse')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi,rC,htrtll_q_hzav'.*86400,v,'k');
clabel(C,h);
title(['0.25xwv'])
set(gca,'YDir','reverse')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi,rC,htrtll_h_hzav'.*86400,v,'k');
clabel(C,h);
title(['0.5xwv'])
ylabel('Pressure, hPa')
xlabel('Latitude')
set(gca,'YDir','reverse') 

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi,rC,htrtll_w_hzav'.*86400,v,'k');
clabel(C,h);
title(['1xwv'])
xlabel('Latitude')
set(gca,'YDir','reverse')

print('-dpdf','heatrates.pdf')
