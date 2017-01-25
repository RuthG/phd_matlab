%produce plots of change in TOA flux in window and non-window for the SBDART data for the control profiles

yi = -89:2:89;
rC = (98000:-4000:2000)';

load('~/md_onoff/radiation_chapter_beginning/lw_sbdart.mat')
fxup_nonwin_1co2 = fxup_lw_l + fxup_lw_u;
fxup_win_1co2 = fxup_win;

load('double_co2_runs/lw_sbdart_2co2.mat')
fxup_nonwin_2co2 = fxup_lw_u+ fxup_lw_l;
fxup_win_2co2 = fxup_win;

load('4_co2_runs/lw_sbdart_4co2.mat')
fxup_nonwin_4co2 = fxup_lw_l + fxup_lw_u;
fxup_win_4co2 = fxup_win;

load('10_co2_runs/lw_sbdart_10co2.mat')
fxup_nonwin_10co2 = fxup_lw_l + fxup_lw_u;
fxup_win_10co2 = fxup_win;

load('20_co2_runs/lw_sbdart_20co2.mat')
fxup_nonwin_20co2 = fxup_lw_l + fxup_lw_u;
fxup_win_20co2 = fxup_win;

dfxup_nw_2 = fxup_nonwin_2co2 - fxup_nonwin_1co2;
dfxup_nw_4 = fxup_nonwin_4co2 - fxup_nonwin_1co2;
dfxup_nw_10 = fxup_nonwin_10co2 - fxup_nonwin_1co2(1:45,:);
dfxup_nw_20 = fxup_nonwin_20co2 - fxup_nonwin_1co2(1:45,:);

dfxup_w_2 = fxup_win_2co2 - fxup_win_1co2;
dfxup_w_4 = fxup_win_4co2 - fxup_win_1co2;
dfxup_w_10 = fxup_win_10co2 - fxup_win_1co2(1:45,:);
dfxup_w_20 = fxup_win_20co2 - fxup_win_1co2(1:45,:);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 0*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.2; 
xSize_sub = 0.34; 


pos1x = 0.07 ; 	pos1y = 0.60; 
pos2x = 0.51 ; 	pos2y = 0.60; 
pos3x = 0.07 ; 	pos3y = 0.35; 
pos4x = 0.51 ; 	pos4y = 0.35; 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi(2:45), dfxup_w_2(2:45,1),'k');
hold on
plot(yi(2:45), dfxup_nw_2(2:45,1));
ylim([-15 0])
xlim([-90 0])
legend('Window','Non-Window','Location','SouthWest')
title('2xCO2 - 1xCO2 TOA flux, W/m^{2}')
ylabel('TOA flux, W/m^{2}')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi(2:45), dfxup_w_4(2:45,1),'k');
hold on
plot(yi(2:45), dfxup_nw_4(2:45,1));
ylim([-15 0])
xlim([-90 0])
title('4xCO2 - 1xCO2 TOA flux, W/m^{2}')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi(2:45), dfxup_w_10(2:45,1),'k');
hold on
plot(yi(2:45), dfxup_nw_10(2:45,1));
xlabel('Latitude')
ylim([-15 0])
xlim([-90 0])
title('10xCO2 - 1xCO2 TOA flux, W/m^{2}')
ylabel('TOA flux, W/m^{2}')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(yi(2:45), dfxup_w_20(2:45,1),'k');
hold on
plot(yi(2:45), dfxup_nw_20(2:45,1));
xlabel('Latitude')
ylim([-15 0])
xlim([-90 0])
title('20xCO2 - 1xCO2 TOA flux, W/m^{2}')

print('-dpdf','hugo_toa_co2_fluxes.pdf')
