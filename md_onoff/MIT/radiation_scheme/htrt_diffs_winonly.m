%plot Xco2 - 1co2 for SBDART and radmod, and compare structure of heating/cooling, is the signal at least roughly correct?

yi = -89:2:89;
p = 2000:4000:98000;

load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_1co2.mat')
tdt_lw_1co2 = tdt_lw;
tdt_sw_1co2 = tdt_sw;
up_lw_1co2 = up;
down_lw_1co2 = down;

load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_2co2_winonly2.mat')
tdt_lw_2co2 = tdt_lw;
tdt_sw_2co2 = tdt_sw;
up_lw_2co2 = up;
down_lw_2co2 = down;

load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_4co2_winonly2.mat')
tdt_lw_4co2 = tdt_lw;
tdt_sw_4co2 = tdt_sw;
up_lw_4co2 = up;
down_lw_4co2 = down;

load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_10co2_winonly2.mat')
tdt_lw_10co2 = tdt_lw;
tdt_sw_10co2 = tdt_sw;
up_lw_10co2 = up;
down_lw_10co2 = down;


load('~/md_onoff/radiation_chapter_beginning/lw_sbdart.mat')
heat_lw_1co2 = heat_lw_l + heat_lw_u + heat_win;
heat_win_1co2 = heat_win;
fxdn_lw_1co2 = fxdn_lw_l + fxdn_lw_u + fxdn_win;
fxup_lw_1co2 = fxup_lw_l + fxup_lw_u + fxup_win;
load('~/md_onoff/radiation_chapter_beginning/sw_sbdart.mat')
heat_sw_1co2 = heat_sw;
fxdn_sw_1co2 = fxdn_sw;

load('double_co2_runs/lw_sbdart_2co2.mat')
heat_lw_2co2 = heat_lw_l + heat_lw_u + heat_win;
heat_win_2co2 = heat_win;
fxdn_lw_2co2 = fxdn_lw_l + fxdn_lw_u + fxdn_win;
fxup_lw_2co2 = fxup_lw_l + fxup_lw_u + fxup_win;
load('double_co2_runs/sw_sbdart_2co2.mat')
heat_sw_2co2 = heat_sw;
fxdn_sw_2co2 = fxdn_sw;

load('4_co2_runs/lw_sbdart_4co2.mat')
heat_lw_4co2 = heat_lw_l + heat_lw_u + heat_win;
heat_win_4co2 = heat_win;
fxdn_lw_4co2 = fxdn_lw_l + fxdn_lw_u + fxdn_win;
fxup_lw_4co2 = fxup_lw_l + fxup_lw_u + fxup_win;
load('4_co2_runs/sw_sbdart_4co2.mat')
heat_sw_4co2 = heat_sw;
fxdn_sw_4co2 = fxdn_sw;

load('10_co2_runs/lw_sbdart_10co2.mat')
heat_lw_10co2 = heat_lw_l + heat_lw_u + heat_win;
heat_win_10co2 = heat_win;
fxdn_lw_10co2 = fxdn_lw_l + fxdn_lw_u + fxdn_win;
fxup_lw_10co2 = fxup_lw_l + fxup_lw_u + fxup_win;
load('10_co2_runs/sw_sbdart_10co2.mat')
heat_sw_10co2 = heat_sw;
fxdn_sw_10co2 = fxdn_sw;


figure
plot(yi(2:45),fxup_lw_1co2(2:45,1),'LineWidth',2)
hold on
plot(yi(2:45),fxup_lw_2co2(2:45,1),'r','LineWidth',2)
plot(yi(2:45),fxup_lw_4co2(2:45,1),'c','LineWidth',2)
plot(yi(2:45),fxup_lw_10co2(2:45,1),'g','LineWidth',2)
xlabel('Latitude')
ylabel('TOA upward LW Flux, W/m^{2}')
legend('1co2','2co2','4co2','10co2','Location','NorthWest')
print('-dpng','toa_lw_sbdart.png')

figure
plot(yi(2:45),fxup_lw_2co2(2:45,1) - fxup_lw_1co2(2:45,1),'r','LineWidth',2)
hold on
plot(yi(2:45),fxup_lw_4co2(2:45,1) - fxup_lw_1co2(2:45,1),'c','LineWidth',2)
plot(yi(2:45),fxup_lw_10co2(2:45,1) - fxup_lw_1co2(2:45,1),'g','LineWidth',2)
xlabel('Latitude')
ylabel('TOA upward LW Flux difference, W/m^{2}')
legend('2co2','4co2','10co2','Location','NorthWest')
print('-dpng','toa_lw_sbdart_diffs.png')

figure
plot(yi(2:45),fxup_lw_1co2(2:45,25),'LineWidth',2)
hold on
plot(yi(2:45),fxup_lw_2co2(2:45,25),'r','LineWidth',2)
plot(yi(2:45),fxup_lw_4co2(2:45,25),'c','LineWidth',2)
plot(yi(2:45),fxup_lw_10co2(2:45,25),'g','LineWidth',2)
xlabel('Latitude')
ylabel('Surface upward LW Flux, W/m^{2}')
legend('1co2','2co2','4co2','10co2','Location','NorthWest')
print('-dpng','surfup_lw_sbdart.png')

figure
plot(yi(2:45),fxdn_lw_1co2(2:45,25),'LineWidth',2)
hold on
plot(yi(2:45),fxdn_lw_2co2(2:45,25),'r','LineWidth',2)
plot(yi(2:45),fxdn_lw_4co2(2:45,25),'c','LineWidth',2)
plot(yi(2:45),fxdn_lw_10co2(2:45,25),'g','LineWidth',2)
xlabel('Latitude')
ylabel('Surface downward LW Flux, W/m^{2}')
legend('1co2','2co2','4co2','10co2','Location','NorthWest')
print('-dpng','surfdn_lw_sbdart.png')

figure
plot(yi(2:45),fxdn_lw_2co2(2:45,25) - fxdn_lw_1co2(2:45,25),'r','LineWidth',2)
hold on
plot(yi(2:45),fxdn_lw_4co2(2:45,25) - fxdn_lw_1co2(2:45,25),'c','LineWidth',2)
plot(yi(2:45),fxdn_lw_10co2(2:45,25) - fxdn_lw_1co2(2:45,25),'g','LineWidth',2)
xlabel('Latitude')
ylabel('Surface downward LW Flux, W/m^{2}')
legend('2co2','4co2','10co2','Location','NorthWest')
print('-dpng','surfdn_lw_sbdart_diffs.png')


figure
plot(yi(2:45),up_lw_1co2(2:45,1),'LineWidth',2)
hold on
plot(yi(2:45),up_lw_2co2(2:45,1),'r','LineWidth',2)
plot(yi(2:45),up_lw_4co2(2:45,1),'c','LineWidth',2)
plot(yi(2:45),up_lw_10co2(2:45,1),'g','LineWidth',2)
xlabel('Latitude')
ylabel('TOA upward LW Flux, W/m^{2}')
legend('1co2','2co2','4co2','10co2','Location','NorthWest')
print('-dpng','toa_lw_mit_winonly2.png')

figure
plot(yi(2:45),up_lw_2co2(2:45,1) - up_lw_1co2(2:45,1),'r','LineWidth',2)
hold on
plot(yi(2:45),up_lw_4co2(2:45,1) - up_lw_1co2(2:45,1),'c','LineWidth',2)
plot(yi(2:45),up_lw_10co2(2:45,1) - up_lw_1co2(2:45,1),'g','LineWidth',2)
xlabel('Latitude')
ylabel('TOA upward LW Flux, W/m^{2}')
legend('2co2','4co2','10co2','Location','NorthWest')
print('-dpng','toa_lw_mit_diffs_winonly2.png')

figure
plot(yi(2:45),up_lw_1co2(2:45,25),'LineWidth',2)
hold on
plot(yi(2:45),up_lw_2co2(2:45,25),'r','LineWidth',2)
plot(yi(2:45),up_lw_4co2(2:45,25),'c','LineWidth',2)
plot(yi(2:45),up_lw_10co2(2:45,25),'g','LineWidth',2)
xlabel('Latitude')
ylabel('Surface upward LW Flux, W/m^{2}')
legend('1co2','2co2','4co2','10co2','Location','NorthWest')
print('-dpng','surfup_lw_mit_winonly2.png')

figure
plot(yi(2:45),down_lw_1co2(2:45,25),'LineWidth',2)
hold on
plot(yi(2:45),down_lw_2co2(2:45,25),'r','LineWidth',2)
plot(yi(2:45),down_lw_4co2(2:45,25),'c','LineWidth',2)
plot(yi(2:45),down_lw_10co2(2:45,25),'g','LineWidth',2)
xlabel('Latitude')
ylabel('Surface downward LW Flux, W/m^{2}')
legend('1co2','2co2','4co2','10co2','Location','NorthWest')
print('-dpng','surfdn_lw_mit_winonly2.png')

figure
plot(yi(2:45),down_lw_2co2(2:45,25) - down_lw_1co2(2:45,25),'r','LineWidth',2)
hold on
plot(yi(2:45),down_lw_4co2(2:45,25) - down_lw_1co2(2:45,25),'c','LineWidth',2)
plot(yi(2:45),down_lw_10co2(2:45,25) - down_lw_1co2(2:45,25),'g','LineWidth',2)
xlabel('Latitude')
ylabel('Surface downward LW Flux difference, W/m^{2}')
legend('2co2','4co2','10co2','Location','NorthWest')
print('-dpng','surfdn_lw_mit_diffs_winonly2.png')



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
pos3x = 0.1; 	pos3y = 0.4;
pos4x = 0.55; 	pos4y = 0.4;

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

v=-10:0.1:10;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi(2:89),p./100,(tdt_lw_2co2(2:89,:) - tdt_lw_1co2(2:89,:))'.*86400,v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
title('Model LW 2-1 co2')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi(2:89),p./100,(heat_lw_2co2(2:89,:) - heat_lw_1co2(2:89,:))',v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
title('SBDART LW 2-1 co2')

v=-10:0.1:10;

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi(2:89),p./100,(tdt_sw_2co2(2:89,:) - tdt_sw_1co2(2:89,:))'.*86400,v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
title('Model SW 2-1 co2')


axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi(2:89),p./100,(heat_sw_2co2(2:89,:) - heat_sw_1co2(2:89,:))',v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
title('SBDART SW 2-1 co2')

print('-dpdf','heat_diffs_2m1co2_winonly2.pdf')







hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

v=-10:0.1:10;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi(2:89),p./100,(tdt_lw_4co2(2:89,:) - tdt_lw_1co2(2:89,:))'.*86400,v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
title('Model LW 4-1 co2')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi(2:89),p./100,(heat_lw_4co2(2:89,:) - heat_lw_1co2(2:89,:))',v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
title('SBDART LW 4-1 co2')

v=-10:0.1:10;

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi(2:89),p./100,(tdt_sw_4co2(2:89,:) - tdt_sw_1co2(2:89,:))'.*86400,v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
title('Model SW 4-1 co2')


axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi(2:89),p./100,(heat_sw_4co2(2:89,:) - heat_sw_1co2(2:89,:))',v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
title('SBDART SW 4-1 co2')

print('-dpdf','heat_diffs_4m1co2_winonly2.pdf')









hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

v=-10:0.1:10;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),p./100,(tdt_lw_10co2(2:45,:) - tdt_lw_1co2(2:45,:))'.*86400,v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
title('Model LW 10-1 co2')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),p./100,(heat_lw_10co2(2:45,:) - heat_lw_1co2(2:45,:))',v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
title('SBDART LW 10-1 co2')

v=-10:0.1:10;

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),p./100,(tdt_sw_10co2(2:45,:) - tdt_sw_1co2(2:45,:))'.*86400,v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
title('Model SW 10-1 co2')


axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),p./100,(heat_sw_10co2(2:45,:) - heat_sw_1co2(2:45,:))',v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
title('SBDART SW 10-1 co2')

print('-dpdf','heat_diffs_10m1co2_winonly2.pdf')

