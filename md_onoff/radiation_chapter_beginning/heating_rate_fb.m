%plot up heating rate predictions from Frierson and Byrne 


yi = -89:2:89;
p = 20:40:1000;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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


load('/project/rg312/mat_files/radiation_chapter/tdt_lw_frierson.mat')
axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-10:0.5:10;
[C,h] = contour(yi,p,tdt_lw'.*86400,v,'k');
set(gca,'FontSize',10);
label = -10:1:10;
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa','FontSize',12);
xlabel('Latitude','FontSize',12);
%title('LW heating rate, K/day (Frierson et al.)')

load('/project/rg312/mat_files/radiation_chapter/tdt_lw_byrne.mat')
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi,p,tdt_lw'.*86400,v,'k');
set(gca,'FontSize',10);
label = -10:1:10;
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',12);
%title('LW heating rate, K/day (Byrne et al.)')

print('-dpdf','heatrates_fb.pdf')

