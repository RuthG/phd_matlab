%load in radmod sw heating and plot up to compare with SBDART

yi = -89:2:89;
p = 2000:4000:98000;


load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_1co2.mat')
dtau_1co2 = -log(dtrans);
dtau_win_1co2 = -log(dtrans_win);

load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_2co2.mat')
dtau_2co2 = -log(dtrans);
dtau_win_2co2 = -log(dtrans_win);

load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_4co2.mat')
dtau_4co2 = -log(dtrans);
dtau_win_4co2 = -log(dtrans_win);

load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_10co2.mat')
dtau_10co2 = -log(dtrans);
dtau_win_10co2 = -log(dtrans_win);




%%%%%% Plots %%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 0*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.15; %0.4;
xSize_sub = 0.375;

pos1x = 0.1 ; 	pos1y = 0.8; 
pos2x = 0.55;	pos2y = 0.8; 
pos3x = 0.1; 	pos3y = 0.6;
pos4x = 0.55; 	pos4y = 0.6;


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),p./100,dtau_1co2(2:45,:)','k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),p./100,dtau_2co2(2:45,:)','k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),p./100,dtau_4co2(2:45,:)','k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),p./100,dtau_10co2(2:45,:)','k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

print('-dpdf','dtau_zavs_radmod.pdf')




hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),p./100,dtau_1co2(2:45,:)','k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),p./100,dtau_2co2(2:45,:)' - dtau_1co2(2:45,:)','k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),p./100,dtau_4co2(2:45,:)' - dtau_1co2(2:45,:)','k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),p./100,dtau_10co2(2:45,:)' - dtau_1co2(2:45,:)','k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

print('-dpdf','dtau_zavs_diffs_radmod.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),p./100,dtau_win_1co2(2:45,:)','k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),p./100,dtau_win_2co2(2:45,:)','k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),p./100,dtau_win_4co2(2:45,:)','k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),p./100,dtau_win_10co2(2:45,:)','k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

print('-dpdf','dtau_win_zavs_radmod.pdf')




hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),p./100,dtau_win_1co2(2:45,:)','k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),p./100,dtau_win_2co2(2:45,:)' - dtau_win_1co2(2:45,:)','k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),p./100,dtau_win_4co2(2:45,:)' - dtau_win_1co2(2:45,:)','k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),p./100,dtau_win_10co2(2:45,:)' - dtau_win_1co2(2:45,:)','k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

print('-dpdf','dtau_win_zavs_diffs_radmod.pdf')
