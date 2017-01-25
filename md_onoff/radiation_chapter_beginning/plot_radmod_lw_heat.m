%load in radmod sw heating and plot up to compare with SBDART

load('/project/rg312/mat_files/radiation_chapter/heating_myscheme.mat')

yi = -89:2:89;
p = 2000:4000:98000;





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
ySize_sub = 0.225; %0.4;
xSize_sub = 0.375;

pos1x = 0.1 ; 	pos1y = 0.7; 
pos2x = 0.55;	pos2y = 0.7; 
pos3x = 0.1; 	pos3y = 0.05;
pos4x = 0.55; 	pos4y = 0.05;



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-10:0.5:10;
[C,h] = contour(yi(2:89),p./100,tdt_lw(2:89,:)'.*86400,v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=0:0.2:1.6;
[C,h] = contour(yi(2:89),p./100,tdt_sw(2:89,:)'.*86400,v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)

print('-dpdf','radmod_heat.pdf')

close all


load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_vw.mat')

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-10:0.5:10;
label = -10:1:10;
[C,h] = contour(yi(2:89),p./100,tdt_lw(2:89,:)'.*86400,v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
%title('RadMod LW heating')
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
print('-dpdf','radmod_heat_vw.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_swpole.mat')
axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=0:0.2:1.6;
label = 0:0.2:1.6;
[C,h] = contour(yi(2:89),p./100,tdt_sw(2:89,:)'.*86400,v,'k');
clabel(C,h,label,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
print('-dpdf','radmod_heat_altsw.pdf')

