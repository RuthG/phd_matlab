%load in sbdart lw heat rates for the varying CO2 experiments and make a single page sheet 
yi = -89:2:89;
rC = (98000:-4000:2000)';
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_1co2.mat')
tdt_lw_1co2 = tdt_lw.*86400;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_2co2_winonly2.mat')
tdt_lw_2co2 = tdt_lw.*86400;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_4co2_winonly2.mat')
tdt_lw_4co2 = tdt_lw.*86400;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_10co2_winonly2.mat')
tdt_lw_10co2 = tdt_lw.*86400;
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_20co2_winonly2.mat')
tdt_lw_20co2 = tdt_lw.*86400;

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



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

v=-8:0.5:8;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,tdt_lw_1co2(2:45,:)',v,'k');
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
%xlabel('Latitude','FontSize',12)
clabel(C,h);
title('1co2 win only 2','FontSize',12)

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,tdt_lw_2co2(2:45,:)',v,'k');
set(gca,'YDir','reverse','FontSize',10)
%ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
clabel(C,h);
title('2co2 win only 2','FontSize',12)

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,tdt_lw_4co2(2:45,:)',v,'k');
set(gca,'YDir','reverse','FontSize',10)
%ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
clabel(C,h);
title('4co2 win only 2','FontSize',12)

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,tdt_lw_10co2(2:45,:)',v,'k');
set(gca,'YDir','reverse','FontSize',10)
%ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
clabel(C,h);
title('10co2 win only 2','FontSize',12)

axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,tdt_lw_20co2(2:45,:)',v,'k');
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
clabel(C,h);
title('20co2 win only 2','FontSize',12)

print('-dpdf','radmod_htrts_winonly2_co2.pdf')

