%compare incoming solar radiation functions for perpetual equinox vs real

yi = -89:2:90;

ss = sin(yi.*pi./180);
p2 = (1. - 3.*ss.^2)./4;
solar_eq = 0.25.*1360.*(1.0 + 1.4.*p2);


solar_real = 1360.*cos(yi.*pi./180);
negsol = find(solar_real<=0);
solar_real(negsol) = 0;

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
plot(yi,solar_eq)
xlabel('Latitude')
ylabel('Incident radiation, Wm^{-2}')
title('Incident solar, perpetual equinox')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi,solar_real)
xlabel('Latitude')
title('Incident solar, realistic')


print('-dpdf','insol.pdf')

