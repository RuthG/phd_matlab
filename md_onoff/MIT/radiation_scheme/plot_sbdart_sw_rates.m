%load in sbdart lw heat rates for the varying CO2 experiments and make a single page sheet 
yi = -89:2:-1;
rC = (98000:-4000:2000)';

lat = (-89:2:-1).*pi./180;
solar_constant 	= 1360.0;
ss = sin(lat);
p2 = (1. - 3.*ss.^2)./4;
del_sol = 1.4;
solar = repmat(0.25.*solar_constant.*(1.0 + del_sol.*p2'),[1,25]);
mitflux(:,1) = solar(:,1);
p_half = 0:4000:100000;
p = 2000:4000:98000;
grav = 9.8;
cp_air 		= 287.04./(2./7);

load('~/md_onoff/radiation_chapter_beginning/sw_sbdart.mat')
for i=1:25
trans(:,i) = fxdn_sw(1:45,i+1)./fxdn_sw(1:45,1);
end
mitflux(:,2:26) = solar.*trans;
for k=1:25
   heat_sw_1co2(:,k) = -(mitflux(:,k+1) - mitflux (:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
end

load('double_co2_runs/sw_sbdart_2co2.mat')
for i=1:25
trans(:,i) = fxdn_sw(1:45,i+1)./fxdn_sw(1:45,1);
end
mitflux(:,2:26) = solar.*trans;
for k=1:25
   heat_sw_2co2(:,k) = -(mitflux(:,k+1) - mitflux (:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
end

load('4_co2_runs/sw_sbdart_4co2.mat')
for i=1:25
trans(:,i) = fxdn_sw(1:45,i+1)./fxdn_sw(1:45,1);
end
mitflux(:,2:26) = solar.*trans;
for k=1:25
   heat_sw_4co2(:,k) = -(mitflux(:,k+1) - mitflux (:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
end

load('10_co2_runs/sw_sbdart_10co2.mat')
for i=1:25
trans(:,i) = fxdn_sw(1:45,i+1)./fxdn_sw(1:45,1);
end
mitflux(:,2:26) = solar.*trans;
for k=1:25
   heat_sw_10co2(:,k) = -(mitflux(:,k+1) - mitflux (:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
end

load('20_co2_runs/sw_sbdart_20co2.mat')
for i=1:25
trans(:,i) = fxdn_sw(1:45,i+1)./fxdn_sw(1:45,1);
end
mitflux(:,2:26) = solar.*trans;
for k=1:25
   heat_sw_20co2(:,k) = -(mitflux(:,k+1) - mitflux (:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
end


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

v=-8:0.1:8;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,heat_sw_1co2(2:45,:)'.*86400,v,'k');
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
%xlabel('Latitude','FontSize',12)
clabel(C,h);
title('1co2 SBDART','FontSize',12)

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,heat_sw_2co2(2:45,:)'.*86400,v,'k');
set(gca,'YDir','reverse','FontSize',10)
%ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
clabel(C,h);
title('2co2 SBDART','FontSize',12)

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,heat_sw_4co2(2:45,:)'.*86400,v,'k');
set(gca,'YDir','reverse','FontSize',10)
%ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
clabel(C,h);
title('4co2 SBDART','FontSize',12)

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,heat_sw_10co2(2:45,:)'.*86400,v,'k');
set(gca,'YDir','reverse','FontSize',10)
%ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
clabel(C,h);
title('10co2 SBDART','FontSize',12)

axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,heat_sw_20co2(2:45,:)'.*86400,v,'k');
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
clabel(C,h);
title('20co2 SBDART','FontSize',12)

print('-dpdf','sbdart_htrts_co2_sw.pdf')





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

v=-0.2:0.02:0.2;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,heat_sw_2co2(2:45,:)'.*86400 - heat_sw_1co2(2:45,:)'.*86400,v,'k');
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
clabel(C,h);
title('2co2 SBDART diffs','FontSize',12)

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,heat_sw_4co2(2:45,:)'.*86400 - heat_sw_1co2(2:45,:)'.*86400,v,'k');
set(gca,'YDir','reverse','FontSize',10)
%ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
clabel(C,h);
title('4co2 SBDART diffs','FontSize',12)

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,heat_sw_10co2(2:45,:)'.*86400 - heat_sw_1co2(2:45,:)'.*86400,v,'k');
set(gca,'YDir','reverse','FontSize',10)
%ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
clabel(C,h);
title('10co2 SBDART diffs','FontSize',12)

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,heat_sw_20co2(2:45,:)'.*86400 - heat_sw_1co2(2:45,:)'.*86400,v,'k');
set(gca,'YDir','reverse','FontSize',10)
%ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
clabel(C,h);
title('20co2 SBDART diffs','FontSize',12)

print('-dpdf','sbdart_htrts_co2_diffs_sw.pdf')

