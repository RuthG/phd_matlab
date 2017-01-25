%load up surf LW fluxes for window and non window, see how current fitting attempts are doing at fitting these. Consider how to produce a fit that gets these right, if nothing else!

yi = -89:2:89;
rC = (98000:-4000:2000)';

load('~/md_onoff/radiation_chapter_beginning/lw_sbdart.mat')
fxdn_lw_1co2 = fxdn_lw_l + fxdn_lw_u + fxdn_win;
fxdn_win_1co2 = fxdn_win;
load('double_co2_runs/lw_sbdart_2co2.mat')
fxdn_lw_2co2 = fxdn_lw_u+ fxdn_lw_l + fxdn_win;
fxdn_win_2co2 = fxdn_win;
load('4_co2_runs/lw_sbdart_4co2.mat')
fxdn_lw_4co2 = fxdn_lw_l + fxdn_lw_u + fxdn_win;
fxdn_win_4co2 = fxdn_win;
load('10_co2_runs/lw_sbdart_10co2.mat')
fxdn_lw_10co2 = fxdn_lw_l + fxdn_lw_u + fxdn_win;
fxdn_win_10co2 = fxdn_win;
load('20_co2_runs/lw_sbdart_20co2.mat')
fxdn_lw_20co2 = fxdn_lw_l + fxdn_lw_u + fxdn_win;
fxdn_win_20co2 = fxdn_win;

load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_1co2.mat')
down_1co2 = down;
down_win_1co2 = down_win;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_2co2_final.mat')
down_2co2_final = down;
down_win_2co2_final = down_win;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_4co2_final.mat')
down_4co2_final = down;
down_win_4co2_final = down_win;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_10co2_final.mat')
down_10co2_final = down;
down_win_10co2_final = down_win;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_20co2_final.mat')
down_20co2_final = down;
down_win_20co2_final = down_win;

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
ySize_sub = 0.15; 
xSize_sub = 0.17; 


pos1x = 0.07 ; 	pos1y = 0.75; 
pos2x = 0.29 ; 	pos2y = 0.75; 
pos3x = 0.51 ; 	pos3y = 0.75; 
pos4x = 0.73 ; 	pos4y = 0.75; 
pos5x = 0.07 ; 	pos5y = 0.55; 
pos6x = 0.29 ; 	pos6y = 0.55; 
pos7x = 0.51 ; 	pos7y = 0.55; 
pos8x = 0.73 ; 	pos8y = 0.55; 
pos9x = 0.07 ; 	pos9y = 0.35; 
pos10x = 0.29 ; pos10y = 0.35; 
pos11x = 0.51 ; pos11y = 0.35; 
pos12x = 0.73 ;	pos12y = 0.35; 
pos13x = 0.07 ; pos13y = 0.15; 



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')



axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_lw_1co2(2:45,26),'k');
hold on
plot(yi(2:45), down_1co2(2:45,26),'m');
xlabel('Latitude')
ylabel('Surf flux, W/m^{2}')
title('1xCO2')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_lw_2co2(2:45,26),'k');
hold on
plot(yi(2:45), down_2co2_final(2:45,26),'m');
xlabel('Latitude')
%ylabel('Surf flux, W/m^{2}')
title('2xCO2')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_lw_4co2(2:45,26),'k');
hold on
plot(yi(2:45), down_4co2_final(2:45,26),'m');
xlabel('Latitude')
%ylabel('Surf flux, W/m^{2}')
title('4xCO2')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_lw_10co2(2:45,26),'k');
hold on
plot(yi(2:45), down_10co2_final(2:45,26),'m');
xlabel('Latitude')
%ylabel('Surf flux, W/m^{2}')
title('10xCO2')

axes('position',[pos5x pos5y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_lw_20co2(2:45,26),'k');
hold on
plot(yi(2:45), down_20co2_final(2:45,26),'m');
xlabel('Latitude')
ylabel('Surf flux, W/m^{2}')
title('20xCO2')

axes('position',[pos6x pos6y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_win_20co2(2:45,26),'k');
hold on
plot(yi(2:45), down_win_20co2_final(2:45,26),'m');
legend('SBDART','Final')
print('-dpdf','surf_fluxes/surf_flux_co2.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_win_1co2(2:45,26),'k');
hold on
plot(yi(2:45), down_win_1co2(2:45,26),'m');
xlabel('Latitude')
ylabel('Surf flux, W/m^{2}')
title('1xCO2 window')


axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_win_2co2(2:45,26),'k');
hold on
plot(yi(2:45), down_win_2co2_final(2:45,26),'m');
xlabel('Latitude')
%ylabel('Surf flux, W/m^{2}')
title('2xCO2 window')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_win_4co2(2:45,26),'k');
hold on
plot(yi(2:45), down_win_4co2_final(2:45,26),'m');
xlabel('Latitude')
%ylabel('Surf flux, W/m^{2}')
title('4xCO2 window')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_win_10co2(2:45,26),'k');
hold on
plot(yi(2:45), down_win_10co2_final(2:45,26),'m');
xlabel('Latitude')
%ylabel('Surf flux, W/m^{2}')
title('10xCO2 window')

axes('position',[pos5x pos5y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_win_20co2(2:45,26),'k');
hold on
plot(yi(2:45), down_win_20co2_final(2:45,26),'m');
xlabel('Latitude')
ylabel('Surf flux, W/m^{2}')
title('20xCO2 window')

axes('position',[pos6x pos6y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_win_20co2(2:45,26),'k');
hold on
plot(yi(2:45), down_win_20co2_final(2:45,26),'m');
legend('SBDART','Final')
print('-dpdf','surf_fluxes/surf_win_flux_co2.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_lw_2co2(2:45,26) - fxdn_lw_1co2(2:45,26),'k');
hold on
plot(yi(2:45), down_2co2_final(2:45,26) - down_1co2(2:45,26),'m');
ylim([0 20])
%xlabel('Latitude')
ylabel('Surf flux, W/m^{2}')
title('2xCO2')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_lw_4co2(2:45,26) - fxdn_lw_1co2(2:45,26),'k');
hold on
plot(yi(2:45), down_4co2_final(2:45,26) - down_1co2(2:45,26),'m');
ylim([0 20])
%xlabel('Latitude')
%ylabel('Surf flux, W/m^{2}')
title('4xCO2')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_lw_10co2(2:45,26) - fxdn_lw_1co2(2:45,26),'k');
hold on
plot(yi(2:45), down_10co2_final(2:45,26) - down_1co2(2:45,26),'m');
ylim([0 20])
%xlabel('Latitude')
%ylabel('Surf flux, W/m^{2}')
title('10xCO2')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_lw_20co2(2:45,26) - fxdn_lw_1co2(2:45,26),'k');
hold on
plot(yi(2:45), down_20co2_final(2:45,26) - down_1co2(2:45,26),'m');
ylim([0 20])
%xlabel('Latitude')
%ylabel('Surf flux, W/m^{2}')
title('20xCO2')

axes('position',[pos5x pos5y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_win_2co2(2:45,26) - fxdn_win_1co2(2:45,26),'k');
hold on
plot(yi(2:45), down_win_2co2_final(2:45,26) - down_win_1co2(2:45,26),'m');
ylim([0 20])
%xlabel('Latitude')
ylabel('Surf flux, W/m^{2}')
title('2xCO2 window')

axes('position',[pos6x pos6y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_win_4co2(2:45,26) - fxdn_win_1co2(2:45,26),'k');
hold on
plot(yi(2:45), down_win_4co2_final(2:45,26) - down_win_1co2(2:45,26),'m');
ylim([0 20])
%xlabel('Latitude')
%ylabel('Surf flux, W/m^{2}')
title('4xCO2 window')

axes('position',[pos7x pos7y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_win_10co2(2:45,26) - fxdn_win_1co2(2:45,26),'k');
hold on
plot(yi(2:45), down_win_10co2_final(2:45,26) - down_win_1co2(2:45,26),'m');
ylim([0 20])
%xlabel('Latitude')
%ylabel('Surf flux, W/m^{2}')
title('10xCO2 window')

axes('position',[pos8x pos8y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_win_20co2(2:45,26) - fxdn_win_1co2(2:45,26),'k');
hold on
plot(yi(2:45), down_win_20co2_final(2:45,26) - down_win_1co2(2:45,26),'m');
ylim([0 20])
%xlabel('Latitude')
%ylabel('Surf flux, W/m^{2}')
title('20xCO2 window')

axes('position',[pos9x pos9y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_lw_2co2(2:45,26) - fxdn_lw_1co2(2:45,26) - (fxdn_win_2co2(2:45,26) - fxdn_win_1co2(2:45,26)),'k');
hold on
plot(yi(2:45), down_2co2_final(2:45,26) - down_1co2(2:45,26) - (down_win_2co2_final(2:45,26) - down_win_1co2(2:45,26)),'m');
ylim([0 20])
xlabel('Latitude')
ylabel('Surf flux, W/m^{2}')
title('2xCO2 non-window')

axes('position',[pos10x pos10y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_lw_4co2(2:45,26) - fxdn_lw_1co2(2:45,26) - (fxdn_win_4co2(2:45,26) - fxdn_win_1co2(2:45,26)),'k');
hold on
plot(yi(2:45), down_4co2_final(2:45,26) - down_1co2(2:45,26) - (down_win_4co2_final(2:45,26) - down_win_1co2(2:45,26)),'m');
ylim([0 20])
xlabel('Latitude')
%ylabel('Surf flux, W/m^{2}')
title('4xCO2 non-window')

axes('position',[pos11x pos11y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_lw_10co2(2:45,26) - fxdn_lw_1co2(2:45,26) - (fxdn_win_10co2(2:45,26) - fxdn_win_1co2(2:45,26)),'k');
hold on
plot(yi(2:45), down_10co2_final(2:45,26) - down_1co2(2:45,26) - (down_win_10co2_final(2:45,26) - down_win_1co2(2:45,26)),'m');
ylim([0 20])
xlabel('Latitude')
%ylabel('Surf flux, W/m^{2}')
title('10xCO2 non-window')

axes('position',[pos12x pos12y xSize_sub ySize_sub])
plot(yi(2:45), fxdn_lw_20co2(2:45,26) - fxdn_lw_1co2(2:45,26) - (fxdn_win_20co2(2:45,26) - fxdn_win_1co2(2:45,26)),'k');
hold on
plot(yi(2:45), down_20co2_final(2:45,26) - down_1co2(2:45,26) - (down_win_20co2_final(2:45,26) - down_win_1co2(2:45,26)),'m');
ylim([0 20])
xlabel('Latitude')
%ylabel('Surf flux, W/m^{2}')
title('20xCO2 non-window')

axes('position',[pos13x pos13y xSize_sub ySize_sub])
plot(yi(2:45), down_win_20co2_final(2:45,26) - down_win_1co2(2:45,26),'k');
hold on
plot(yi(2:45), down_win_20co2_final(2:45,26) - down_win_1co2(2:45,26),'m');
legend('SBDART','Final')

print('-dpdf','surf_fluxes/surf_flux_diff_co2.pdf')

