%load up TOA LW fluxes for window and non window, see how current fitting attempts are doing at fitting these. Consider how to produce a fit that gets these right, if nothing else!

yi = -89:2:89;
rC = (98000:-4000:2000)';

load('~/md_onoff/radiation_chapter_beginning/lw_sbdart.mat')
fxup_lw_1co2 = fxup_lw_l + fxup_lw_u + fxup_win;
fxup_win_1co2 = fxup_win;
load('double_co2_runs/lw_sbdart_2co2.mat')
fxup_lw_2co2 = fxup_lw_u+ fxup_lw_l + fxup_win;
fxup_win_2co2 = fxup_win;
load('4_co2_runs/lw_sbdart_4co2.mat')
fxup_lw_4co2 = fxup_lw_l + fxup_lw_u + fxup_win;
fxup_win_4co2 = fxup_win;
load('10_co2_runs/lw_sbdart_10co2.mat')
fxup_lw_10co2 = fxup_lw_l + fxup_lw_u + fxup_win;
fxup_win_10co2 = fxup_win;
load('20_co2_runs/lw_sbdart_20co2.mat')
fxup_lw_20co2 = fxup_lw_l + fxup_lw_u + fxup_win;
fxup_win_20co2 = fxup_win;

load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_1co2.mat')
up_1co2 = up;
up_win_1co2 = up_win;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_2co2.mat')
up_2co2_first = up;
up_win_2co2_first = up_win;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_4co2.mat')
up_4co2_first = up;
up_win_4co2_first = up_win;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_10co2.mat')
up_10co2_first = up;
up_win_10co2_first = up_win;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_20co2.mat')
up_20co2_first = up;
up_win_20co2_first = up_win;

load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_2co2_new.mat')
up_2co2_new = up;
up_win_2co2_new = up_win;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_4co2_new.mat')
up_4co2_new = up;
up_win_4co2_new = up_win;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_10co2_new.mat')
up_10co2_new = up;
up_win_10co2_new = up_win;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_20co2_new.mat')
up_20co2_new = up;
up_win_20co2_new = up_win;

load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_2co2_winonly.mat')
up_2co2_winonly = up;
up_win_2co2_winonly = up_win;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_4co2_winonly.mat')
up_4co2_winonly = up;
up_win_4co2_winonly = up_win;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_10co2_winonly.mat')
up_10co2_winonly = up;
up_win_10co2_winonly = up_win;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_20co2_winonly.mat')
up_20co2_winonly = up;
up_win_20co2_winonly = up_win;

load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_2co2_winonly2.mat')
up_2co2_winonly2 = up;
up_win_2co2_winonly2 = up_win;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_4co2_winonly2.mat')
up_4co2_winonly2 = up;
up_win_4co2_winonly2 = up_win;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_10co2_winonly2.mat')
up_10co2_winonly2 = up;
up_win_10co2_winonly2 = up_win;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_20co2_winonly2.mat')
up_20co2_winonly2 = up;
up_win_20co2_winonly2 = up_win;

load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_2co2_final.mat')
up_2co2_final = up;
up_win_2co2_final = up_win;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_4co2_final.mat')
up_4co2_final = up;
up_win_4co2_final = up_win;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_10co2_final.mat')
up_10co2_final = up;
up_win_10co2_final = up_win;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_20co2_final.mat')
up_20co2_final = up;
up_win_20co2_final = up_win;

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
plot(yi(2:45), fxup_lw_1co2(2:45,1),'k');
hold on
plot(yi(2:45), up_1co2(2:45,1));
xlabel('Latitude')
ylabel('TOA flux, W/m^{2}')
title('1xCO2')
%legend('SBDART','First','Location','NorthWest')
%print('-dpng','toa_fluxes/toa_flux_1co2')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi(2:45), fxup_lw_2co2(2:45,1),'k');
hold on
plot(yi(2:45), up_2co2_first(2:45,1));
plot(yi(2:45), up_2co2_new(2:45,1),'g');
plot(yi(2:45), up_2co2_winonly(2:45,1),'r');
plot(yi(2:45), up_2co2_winonly2(2:45,1),'r--');
plot(yi(2:45), up_2co2_final(2:45,1),'m');
xlabel('Latitude')
%ylabel('TOA flux, W/m^{2}')
title('2xCO2')
%legend('SBDART','First','New','Winonly','Winonly2','Final','Location','NorthWest')
%print('-dpng','toa_fluxes/toa_flux_2co2')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi(2:45), fxup_lw_4co2(2:45,1),'k');
hold on
plot(yi(2:45), up_4co2_first(2:45,1));
plot(yi(2:45), up_4co2_new(2:45,1),'g');
plot(yi(2:45), up_4co2_winonly(2:45,1),'r');
plot(yi(2:45), up_4co2_winonly2(2:45,1),'r--');
plot(yi(2:45), up_4co2_final(2:45,1),'m');
xlabel('Latitude')
%ylabel('TOA flux, W/m^{2}')
title('4xCO2')
%legend('SBDART','First','New','Winonly','Winonly2','Final','Location','NorthWest')
%print('-dpng','toa_fluxes/toa_flux_4co2')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(yi(2:45), fxup_lw_10co2(2:45,1),'k');
hold on
plot(yi(2:45), up_10co2_first(2:45,1));
plot(yi(2:45), up_10co2_new(2:45,1),'g');
plot(yi(2:45), up_10co2_winonly(2:45,1),'r');
plot(yi(2:45), up_10co2_winonly2(2:45,1),'r--');
plot(yi(2:45), up_10co2_final(2:45,1),'m');
xlabel('Latitude')
%ylabel('TOA flux, W/m^{2}')
title('10xCO2')
%legend('SBDART','First','New','Winonly','Winonly2','Final','Location','NorthWest')
%print('-dpng','toa_fluxes/toa_flux_10co2')

axes('position',[pos5x pos5y xSize_sub ySize_sub])
plot(yi(2:45), fxup_lw_20co2(2:45,1),'k');
hold on
plot(yi(2:45), up_20co2_first(2:45,1));
plot(yi(2:45), up_20co2_new(2:45,1),'g');
plot(yi(2:45), up_20co2_winonly(2:45,1),'r');
plot(yi(2:45), up_20co2_winonly2(2:45,1),'r--');
plot(yi(2:45), up_20co2_final(2:45,1),'m');
xlabel('Latitude')
ylabel('TOA flux, W/m^{2}')
title('20xCO2')
%legend('SBDART','First','New','Winonly','Winonly2','Final','Location','NorthWest')

axes('position',[pos6x pos6y xSize_sub ySize_sub])
plot(yi(2:45), fxup_win_20co2(2:45,1),'k');
hold on
plot(yi(2:45), up_win_20co2_first(2:45,1));
plot(yi(2:45), up_win_20co2_new(2:45,1),'g');
plot(yi(2:45), up_win_20co2_winonly(2:45,1),'r');
plot(yi(2:45), up_win_20co2_winonly2(2:45,1),'r--');
legend('SBDART','First','New','Winonly','Winonly2','Final')
print('-dpdf','toa_fluxes/toa_flux_co2.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi(2:45), fxup_win_1co2(2:45,1),'k');
hold on
plot(yi(2:45), up_win_1co2(2:45,1));
xlabel('Latitude')
ylabel('TOA flux, W/m^{2}')
title('1xCO2 window')
%legend('SBDART','First','Location','NorthWest')
%print('-dpng','toa_fluxes/toa_win_flux_1co2')


axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi(2:45), fxup_win_2co2(2:45,1),'k');
hold on
plot(yi(2:45), up_win_2co2_first(2:45,1));
plot(yi(2:45), up_win_2co2_new(2:45,1),'g');
plot(yi(2:45), up_win_2co2_winonly(2:45,1),'r');
plot(yi(2:45), up_win_2co2_winonly2(2:45,1),'r--');
plot(yi(2:45), up_win_2co2_final(2:45,1),'m');
xlabel('Latitude')
%ylabel('TOA flux, W/m^{2}')
title('2xCO2 window')
%legend('SBDART','First','New','Winonly','Winonly2','Final','Location','NorthWest')
%print('-dpng','toa_fluxes/toa_win_flux_2co2')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi(2:45), fxup_win_4co2(2:45,1),'k');
hold on
plot(yi(2:45), up_win_4co2_first(2:45,1));
plot(yi(2:45), up_win_4co2_new(2:45,1),'g');
plot(yi(2:45), up_win_4co2_winonly(2:45,1),'r');
plot(yi(2:45), up_win_4co2_winonly2(2:45,1),'r--');
plot(yi(2:45), up_win_4co2_final(2:45,1),'m');
xlabel('Latitude')
%ylabel('TOA flux, W/m^{2}')
title('4xCO2 window')
%legend('SBDART','First','New','Winonly','Winonly2','Final','Location','NorthWest')
%print('-dpng','toa_fluxes/toa_win_flux_4co2')


axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(yi(2:45), fxup_win_10co2(2:45,1),'k');
hold on
plot(yi(2:45), up_win_10co2_first(2:45,1));
plot(yi(2:45), up_win_10co2_new(2:45,1),'g');
plot(yi(2:45), up_win_10co2_winonly(2:45,1),'r');
plot(yi(2:45), up_win_10co2_winonly2(2:45,1),'r--');
plot(yi(2:45), up_win_10co2_final(2:45,1),'m');
xlabel('Latitude')
%ylabel('TOA flux, W/m^{2}')
title('10xCO2 window')
%legend('SBDART','First','New','Winonly','Winonly2','Final','Location','NorthWest')
%print('-dpng','toa_fluxes/toa_win_flux_10co2')


axes('position',[pos5x pos5y xSize_sub ySize_sub])
plot(yi(2:45), fxup_win_20co2(2:45,1),'k');
hold on
plot(yi(2:45), up_win_20co2_first(2:45,1));
plot(yi(2:45), up_win_20co2_new(2:45,1),'g');
plot(yi(2:45), up_win_20co2_winonly(2:45,1),'r');
plot(yi(2:45), up_win_20co2_winonly2(2:45,1),'r--');
plot(yi(2:45), up_win_20co2_final(2:45,1),'m');
xlabel('Latitude')
ylabel('TOA flux, W/m^{2}')
title('20xCO2 window')
%legend('SBDART','First','New','Winonly','Winonly2','Final','Location','NorthWest')

axes('position',[pos6x pos6y xSize_sub ySize_sub])
plot(yi(2:45), fxup_win_20co2(2:45,1),'k');
hold on
plot(yi(2:45), up_win_20co2_first(2:45,1));
plot(yi(2:45), up_win_20co2_new(2:45,1),'g');
plot(yi(2:45), up_win_20co2_winonly(2:45,1),'r');
plot(yi(2:45), up_win_20co2_winonly2(2:45,1),'r--');
legend('SBDART','First','New','Winonly','Winonly2','Final')
print('-dpdf','toa_fluxes/toa_win_flux_co2.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi(2:45), fxup_lw_2co2(2:45,1) - fxup_lw_1co2(2:45,1),'k');
hold on
%plot(yi(2:45), up_2co2_first(2:45,1) - up_1co2(2:45,1));
%plot(yi(2:45), up_2co2_new(2:45,1) - up_1co2(2:45,1),'g');
%plot(yi(2:45), up_2co2_winonly(2:45,1) - up_1co2(2:45,1),'r');
%plot(yi(2:45), up_2co2_winonly2(2:45,1) - up_1co2(2:45,1),'r--');
plot(yi(2:45), up_2co2_final(2:45,1) - up_1co2(2:45,1),'m');
ylim([-18 0])
%xlabel('Latitude')
ylabel('TOA flux, W/m^{2}')
title('2xCO2')
%legend('SBDART','First','New','Winonly','Winonly2','Location','NorthWest')
%print('-dpng','toa_fluxes/toa_flux_diff_2co2')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi(2:45), fxup_lw_4co2(2:45,1) - fxup_lw_1co2(2:45,1),'k');
hold on
%plot(yi(2:45), up_4co2_first(2:45,1) - up_1co2(2:45,1));
%plot(yi(2:45), up_4co2_new(2:45,1) - up_1co2(2:45,1),'g');
%plot(yi(2:45), up_4co2_winonly(2:45,1) - up_1co2(2:45,1),'r');
%plot(yi(2:45), up_4co2_winonly2(2:45,1) - up_1co2(2:45,1),'r--');
plot(yi(2:45), up_4co2_final(2:45,1) - up_1co2(2:45,1),'m');
ylim([-18 0])
%xlabel('Latitude')
%ylabel('TOA flux, W/m^{2}')
title('4xCO2')
%legend('SBDART','First','New','Winonly','Winonly2','Location','NorthWest')
%print('-dpng','toa_fluxes/toa_flux_diff_4co2')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi(2:45), fxup_lw_10co2(2:45,1) - fxup_lw_1co2(2:45,1),'k');
hold on
%plot(yi(2:45), up_10co2_first(2:45,1) - up_1co2(2:45,1));
%plot(yi(2:45), up_10co2_new(2:45,1) - up_1co2(2:45,1),'g');
%plot(yi(2:45), up_10co2_winonly(2:45,1) - up_1co2(2:45,1),'r');
%plot(yi(2:45), up_10co2_winonly2(2:45,1) - up_1co2(2:45,1),'r--');
plot(yi(2:45), up_10co2_final(2:45,1) - up_1co2(2:45,1),'m');
ylim([-18 0])
%xlabel('Latitude')
%ylabel('TOA flux, W/m^{2}')
title('10xCO2')
%legend('SBDART','First','New','Winonly','Winonly2','Location','NorthWest')
%print('-dpng','toa_fluxes/toa_flux_diff_10co2')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(yi(2:45), fxup_lw_20co2(2:45,1) - fxup_lw_1co2(2:45,1),'k');
hold on
%plot(yi(2:45), up_20co2_first(2:45,1) - up_1co2(2:45,1));
%plot(yi(2:45), up_20co2_new(2:45,1) - up_1co2(2:45,1),'g');
%plot(yi(2:45), up_20co2_winonly(2:45,1) - up_1co2(2:45,1),'r');
%plot(yi(2:45), up_20co2_winonly2(2:45,1) - up_1co2(2:45,1),'r--');
plot(yi(2:45), up_20co2_final(2:45,1) - up_1co2(2:45,1),'m');
ylim([-18 0])
%xlabel('Latitude')
%ylabel('TOA flux, W/m^{2}')
title('20xCO2')
%legend('SBDART','First','New','Winonly','Winonly2','Location','NorthWest')
%print('-dpng','toa_fluxes/toa_flux_diff_20co2')


axes('position',[pos5x pos5y xSize_sub ySize_sub])
plot(yi(2:45), fxup_win_2co2(2:45,1) - fxup_win_1co2(2:45,1),'k');
hold on
%plot(yi(2:45), up_win_2co2_first(2:45,1) - up_win_1co2(2:45,1));
%plot(yi(2:45), up_win_2co2_new(2:45,1) - up_win_1co2(2:45,1),'g');
%plot(yi(2:45), up_win_2co2_winonly(2:45,1) - up_win_1co2(2:45,1),'r');
%plot(yi(2:45), up_win_2co2_winonly2(2:45,1) - up_win_1co2(2:45,1),'r--');
plot(yi(2:45), up_win_2co2_final(2:45,1) - up_win_1co2(2:45,1),'m');
ylim([-18 0])
%xlabel('Latitude')
ylabel('TOA flux, W/m^{2}')
title('2xCO2 window')
%legend('SBDART','First','New','Winonly','Winonly2','Location','NorthWest')
%print('-dpng','toa_fluxes/toa_win_flux_diff_2co2')

axes('position',[pos6x pos6y xSize_sub ySize_sub])
plot(yi(2:45), fxup_win_4co2(2:45,1) - fxup_win_1co2(2:45,1),'k');
hold on
%plot(yi(2:45), up_win_4co2_first(2:45,1) - up_win_1co2(2:45,1));
%plot(yi(2:45), up_win_4co2_new(2:45,1) - up_win_1co2(2:45,1),'g');
%plot(yi(2:45), up_win_4co2_winonly(2:45,1) - up_win_1co2(2:45,1),'r');
%plot(yi(2:45), up_win_4co2_winonly2(2:45,1) - up_win_1co2(2:45,1),'r--');
plot(yi(2:45), up_win_4co2_final(2:45,1) - up_win_1co2(2:45,1),'m');
ylim([-18 0])
%xlabel('Latitude')
%ylabel('TOA flux, W/m^{2}')
title('4xCO2 window')
%legend('SBDART','First','New','Winonly','Winonly2','Location','NorthWest')
%print('-dpng','toa_fluxes/toa_win_flux_diff_4co2')


axes('position',[pos7x pos7y xSize_sub ySize_sub])
plot(yi(2:45), fxup_win_10co2(2:45,1) - fxup_win_1co2(2:45,1),'k');
hold on
%plot(yi(2:45), up_win_10co2_first(2:45,1) - up_win_1co2(2:45,1));
%plot(yi(2:45), up_win_10co2_new(2:45,1) - up_win_1co2(2:45,1),'g');
%plot(yi(2:45), up_win_10co2_winonly(2:45,1) - up_win_1co2(2:45,1),'r');
%plot(yi(2:45), up_win_10co2_winonly2(2:45,1) - up_win_1co2(2:45,1),'r--');
plot(yi(2:45), up_win_10co2_final(2:45,1) - up_win_1co2(2:45,1),'m');
ylim([-18 0])
%xlabel('Latitude')
%ylabel('TOA flux, W/m^{2}')
title('10xCO2 window')
%legend('SBDART','First','New','Winonly','Winonly2','Location','NorthWest')
%print('-dpng','toa_fluxes/toa_win_flux_diff_10co2')

axes('position',[pos8x pos8y xSize_sub ySize_sub])
plot(yi(2:45), fxup_win_20co2(2:45,1) - fxup_win_1co2(2:45,1),'k');
hold on
%plot(yi(2:45), up_win_20co2_first(2:45,1) - up_win_1co2(2:45,1));
%plot(yi(2:45), up_win_20co2_new(2:45,1) - up_win_1co2(2:45,1),'g');
%plot(yi(2:45), up_win_20co2_winonly(2:45,1) - up_win_1co2(2:45,1),'r');
%plot(yi(2:45), up_win_20co2_winonly2(2:45,1) - up_win_1co2(2:45,1),'r--');
plot(yi(2:45), up_win_20co2_final(2:45,1) - up_win_1co2(2:45,1),'m');
ylim([-18 0])
%xlabel('Latitude')
%ylabel('TOA flux, W/m^{2}')
title('20xCO2 window')
%legend('SBDART','First','New','Winonly','Winonly2','Location','NorthWest')


axes('position',[pos9x pos9y xSize_sub ySize_sub])
plot(yi(2:45), fxup_lw_2co2(2:45,1) - fxup_lw_1co2(2:45,1) - (fxup_win_2co2(2:45,1) - fxup_win_1co2(2:45,1)),'k');
hold on
%plot(yi(2:45), up_2co2_first(2:45,1) - up_1co2(2:45,1) - (up_win_2co2_first(2:45,1) - up_win_1co2(2:45,1)));
%plot(yi(2:45), up_2co2_new(2:45,1) - up_1co2(2:45,1) - (up_win_2co2_new(2:45,1) - up_win_1co2(2:45,1)),'g');
%plot(yi(2:45), up_2co2_winonly(2:45,1) - up_1co2(2:45,1) - (up_win_2co2_winonly(2:45,1) - up_win_1co2(2:45,1)),'r');
%plot(yi(2:45), up_2co2_winonly2(2:45,1) - up_1co2(2:45,1) - (up_win_2co2_winonly2(2:45,1) - up_win_1co2(2:45,1)),'r--');
plot(yi(2:45), up_2co2_final(2:45,1) - up_1co2(2:45,1) - (up_win_2co2_final(2:45,1) - up_win_1co2(2:45,1)),'m');
ylim([-18 0])
xlabel('Latitude')
ylabel('TOA flux, W/m^{2}')
title('2xCO2 non-window')
%legend('SBDART','First','New','Winonly','Winonly2','Location','NorthWest')
%print('-dpng','toa_fluxes/toa_win_flux_diff_2co2')

axes('position',[pos10x pos10y xSize_sub ySize_sub])
plot(yi(2:45), fxup_lw_4co2(2:45,1) - fxup_lw_1co2(2:45,1) - (fxup_win_4co2(2:45,1) - fxup_win_1co2(2:45,1)),'k');
hold on
%plot(yi(2:45), up_4co2_first(2:45,1) - up_1co2(2:45,1) - (up_win_4co2_first(2:45,1) - up_win_1co2(2:45,1)));
%plot(yi(2:45), up_4co2_new(2:45,1) - up_1co2(2:45,1) - (up_win_4co2_new(2:45,1) - up_win_1co2(2:45,1)),'g');
%plot(yi(2:45), up_4co2_winonly(2:45,1) - up_1co2(2:45,1) - (up_win_4co2_winonly(2:45,1) - up_win_1co2(2:45,1)),'r');
%plot(yi(2:45), up_4co2_winonly2(2:45,1) - up_1co2(2:45,1) - (up_win_4co2_winonly2(2:45,1) - up_win_1co2(2:45,1)),'r--');
plot(yi(2:45), up_4co2_final(2:45,1) - up_1co2(2:45,1) - (up_win_4co2_final(2:45,1) - up_win_1co2(2:45,1)),'m');
ylim([-18 0])
xlabel('Latitude')
%ylabel('TOA flux, W/m^{2}')
title('4xCO2 non-window')
%legend('SBDART','First','New','Winonly','Winonly2','Location','NorthWest')
%print('-dpng','toa_fluxes/toa_win_flux_diff_4co2')

axes('position',[pos11x pos11y xSize_sub ySize_sub])
plot(yi(2:45), fxup_lw_10co2(2:45,1) - fxup_lw_1co2(2:45,1) - (fxup_win_10co2(2:45,1) - fxup_win_1co2(2:45,1)),'k');
hold on
%plot(yi(2:45), up_10co2_first(2:45,1) - up_1co2(2:45,1) - (up_win_10co2_first(2:45,1) - up_win_1co2(2:45,1)));
%plot(yi(2:45), up_10co2_new(2:45,1) - up_1co2(2:45,1) - (up_win_10co2_new(2:45,1) - up_win_1co2(2:45,1)),'g');
%plot(yi(2:45), up_10co2_winonly(2:45,1) - up_1co2(2:45,1) - (up_win_10co2_winonly(2:45,1) - up_win_1co2(2:45,1)),'r');
%plot(yi(2:45), up_10co2_winonly2(2:45,1) - up_1co2(2:45,1) - (up_win_10co2_winonly2(2:45,1) - up_win_1co2(2:45,1)),'r--');
plot(yi(2:45), up_10co2_final(2:45,1) - up_1co2(2:45,1) - (up_win_10co2_final(2:45,1) - up_win_1co2(2:45,1)),'m');
ylim([-18 0])
xlabel('Latitude')
%ylabel('TOA flux, W/m^{2}')
title('10xCO2 non-window')
%legend('SBDART','First','New','Winonly','Winonly2','Location','NorthWest')
%print('-dpng','toa_fluxes/toa_win_flux_diff_10co2')

axes('position',[pos12x pos12y xSize_sub ySize_sub])
plot(yi(2:45), fxup_lw_20co2(2:45,1) - fxup_lw_1co2(2:45,1) - (fxup_win_20co2(2:45,1) - fxup_win_1co2(2:45,1)),'k');
hold on
%plot(yi(2:45), up_20co2_first(2:45,1) - up_1co2(2:45,1) - (up_win_20co2_first(2:45,1) - up_win_1co2(2:45,1)));
%plot(yi(2:45), up_20co2_new(2:45,1) - up_1co2(2:45,1) - (up_win_20co2_new(2:45,1) - up_win_1co2(2:45,1)),'g');
%plot(yi(2:45), up_20co2_winonly(2:45,1) - up_1co2(2:45,1) - (up_win_20co2_winonly(2:45,1) - up_win_1co2(2:45,1)),'r');
%plot(yi(2:45), up_20co2_winonly2(2:45,1) - up_1co2(2:45,1) - (up_win_20co2_winonly2(2:45,1) - up_win_1co2(2:45,1)),'r--');
plot(yi(2:45), up_20co2_final(2:45,1) - up_1co2(2:45,1) - (up_win_20co2_final(2:45,1) - up_win_1co2(2:45,1)),'m');
ylim([-18 0])
xlabel('Latitude')
%ylabel('TOA flux, W/m^{2}')
title('20xCO2 non-window')
%legend('SBDART','First','New','Winonly','Winonly2','Location','NorthWest')

axes('position',[pos13x pos13y xSize_sub ySize_sub])
plot(yi(2:45), up_win_20co2_first(2:45,1) - up_win_1co2(2:45,1),'k');
hold on
plot(yi(2:45), up_win_20co2_first(2:45,1) - up_win_1co2(2:45,1),'m');
%plot(yi(2:45), up_win_20co2_new(2:45,1) - up_win_1co2(2:45,1),'g');
%plot(yi(2:45), up_win_20co2_winonly(2:45,1) - up_win_1co2(2:45,1),'r');
%plot(yi(2:45), up_win_20co2_winonly2(2:45,1) - up_win_1co2(2:45,1),'r--');
legend('SBDART','Final')

print('-dpdf','toa_fluxes/toa_flux_diff_co2.pdf')

