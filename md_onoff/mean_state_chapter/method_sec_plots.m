%plot SSTs
%plot fixed optical depths used

yi = -90:2:90;

yy=yi*pi/180;
sst=sin(1.5*yy); sst=1.-sst.*sst; 
sst(find(abs(yi) > 60.))=0.;
sst=273.15+27*sst;

%tropheat 5K anomaly
cosyy=cos(yy.*90./10);
ssta= -5*cosyy.*cosyy;
ssta(find(abs(yi)>=10))=0;
sst_p=sst-ssta;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 0*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.25; 
xSize_sub = 0.6; 

pos1x = 0.1 ; 	pos1y = 0.7; 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])

plot(yi,sst_p,'k--')
hold on
plot(yi,sst,'k')
set(gca,'FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Sea surface temperature, K','FontSize',12)
xlim([-90 90])
print('-dpdf','sst.pdf')


clear


load('/project/rg312/mat_files/transmittances_final.mat')

xi=-179:2:179; yi = -89:2:89;

%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 0*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.17; 
xSize_sub = 0.25; 

pos1x = 0.07 ; 	pos1y = 0.73; 
pos2x = 0.39 ; 	pos2y = 0.73; 
pos3x = 0.71 ; 	pos3y = 0.73; 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

dtau_lw_zav(:,:) = -log(mean(cube2latlon(xc,yc,trans_lw,xi,yi),1));
dtau_wi_zav(:,:) = -log(mean(cube2latlon(xc,yc,trans_wi,xi,yi),1));
dtau_sw_zav(:,:) = -log(mean(cube2latlon(xc,yc,trans_sw,xi,yi),1));

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,dtau_lw_zav','k');
clabel(C,h);
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
title('Longwave','FontSize',12)

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,dtau_wi_zav','k');
clabel(C,h);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
title('Window region','FontSize',12)

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,dtau_sw_zav','k');
clabel(C,h);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
title('Shortwave','FontSize',12)

print('-dpdf','dtau.pdf')
