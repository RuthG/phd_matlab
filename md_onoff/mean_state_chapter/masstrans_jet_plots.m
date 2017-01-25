%load up data for jets and temperatures for the rad on run. Do for F and B also later


rDir='/project/rg312/final_runs/run_000_final_noshallow/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
drC=squeeze(rdmds([rDir,'DRC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
xi=-179:2:179;
yi=-89:2:89;

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_000.mat','uE_tav')
uE_ll=cube2latlon(xc,yc,uE_tav,xi,yi);
uE_zav_000(:,:) = mean(uE_ll,1);
load('/project/rg312/mat_files/chapter2_variables/psi_tav_000.mat','psi_000_hzav')

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_010.mat','uE_tav')
uE_ll=cube2latlon(xc,yc,uE_tav,xi,yi);
uE_zav_010(:,:) = mean(uE_ll,1);
load('/project/rg312/mat_files/chapter2_variables/psi_tav_010.mat','psi_010_hzav')

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_025.mat','uE_tav')
uE_ll=cube2latlon(xc,yc,uE_tav,xi,yi);
uE_zav_025(:,:) = mean(uE_ll,1);
load('/project/rg312/mat_files/chapter2_variables/psi_tav_025.mat','psi_025_hzav')

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050.mat','uE_tav')
uE_ll=cube2latlon(xc,yc,uE_tav,xi,yi);
uE_zav_050(:,:) = mean(uE_ll,1);
load('/project/rg312/mat_files/chapter2_variables/psi_tav_050.mat','psi_050_hzav')

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_075.mat','uE_tav')
uE_ll=cube2latlon(xc,yc,uE_tav,xi,yi);
uE_zav_075(:,:) = mean(uE_ll,1);
load('/project/rg312/mat_files/chapter2_variables/psi_tav_075.mat','psi_075_hzav')

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_100.mat','uE_tav')
uE_ll=cube2latlon(xc,yc,uE_tav,xi,yi);
uE_zav_100(:,:) = mean(uE_ll,1);
load('/project/rg312/mat_files/chapter2_variables/psi_tav_100.mat','psi_100_hzav')

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_125.mat','uE_tav')
uE_ll=cube2latlon(xc,yc,uE_tav,xi,yi);
uE_zav_125(:,:) = mean(uE_ll,1);
load('/project/rg312/mat_files/chapter2_variables/psi_tav_125.mat','psi_125_hzav')

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_150.mat','uE_tav')
uE_ll=cube2latlon(xc,yc,uE_tav,xi,yi);
uE_zav_150(:,:) = mean(uE_ll,1);
load('/project/rg312/mat_files/chapter2_variables/psi_tav_150.mat','psi_150_hzav')



for i=1:45
uE_hzav_000(i,:) = (uE_zav_000(i+45,:) + uE_zav_000(46-i,:))./2;
uE_hzav_010(i,:) = (uE_zav_010(i+45,:) + uE_zav_010(46-i,:))./2;
uE_hzav_025(i,:) = (uE_zav_025(i+45,:) + uE_zav_025(46-i,:))./2;
uE_hzav_050(i,:) = (uE_zav_050(i+45,:) + uE_zav_050(46-i,:))./2;
uE_hzav_075(i,:) = (uE_zav_075(i+45,:) + uE_zav_075(46-i,:))./2;
uE_hzav_100(i,:) = (uE_zav_100(i+45,:) + uE_zav_100(46-i,:))./2;
uE_hzav_125(i,:) = (uE_zav_125(i+45,:) + uE_zav_125(46-i,:))./2;
uE_hzav_150(i,:) = (uE_zav_150(i+45,:) + uE_zav_150(46-i,:))./2;
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

pos1x = 0.1 ; 	pos1y = 0.75; 
pos2x = 0.5 ; 	pos2y = 0.75; 
pos3x = 0.1 ; 	pos3y = 0.55; 
pos4x = 0.5 ; 	pos4y = 0.55; 
pos5x = 0.1 ; 	pos5y = 0.35; 
pos6x = 0.5 ; 	pos6y = 0.35; 
pos7x = 0.1 ; 	pos7y = 0.15; 
pos8x = 0.5 ; 	pos8y = 0.15; 

pos1x = 0.07 ; 	pos1y = 0.75; 
pos2x = 0.29 ; 	pos2y = 0.75; 
pos3x = 0.51 ; 	pos3y = 0.75; 
pos4x = 0.73 ; 	pos4y = 0.75; 
pos5x = 0.07 ; 	pos5y = 0.55; 
pos6x = 0.29 ; 	pos6y = 0.55; 
pos7x = 0.51 ; 	pos7y = 0.55; 
pos8x = 0.73 ; 	pos8y = 0.55; 

pos9x  = 0.07 ; 	pos9y  = 0.25; 
pos10x = 0.29 ; 	pos10y = 0.25; 
pos11x = 0.51 ; 	pos11y = 0.25; 
pos12x = 0.73 ; 	pos12y = 0.25; 
pos13x = 0.07 ; 	pos13y = 0.05; 
pos14x = 0.29 ; 	pos14y = 0.05; 
pos15x = 0.51 ; 	pos15y = 0.05; 
pos16x = 0.73 ; 	pos16y = 0.05; 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

v=-20:5:45;
v_psi = [-40:10:0,30:30:180];

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,uE_hzav_000',v); set(h,'LineStyle','none');
set(gca,'YDir','reverse','FontSize',10)
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-20,45));
[C,h] = contour(yi(46:90),rC./100,uE_hzav_000',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(yi(46:90),rC./100,psi_000_hzav'./1e9,v_psi,'k');
clabel(C,h);
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
title('dry','FontSize',12)
freezeColors

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,uE_hzav_010',v); set(h,'LineStyle','none');
set(gca,'YDir','reverse','FontSize',10)
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-20,45));
[C,h] = contour(yi(46:90),rC./100,uE_hzav_010',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(yi(46:90),rC./100,psi_010_hzav'./1e9,v_psi,'k');
clabel(C,h);
set(gca,'YDir','reverse','FontSize',10)
title('010','FontSize',12)
freezeColors

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,uE_hzav_025',v); set(h,'LineStyle','none');
set(gca,'YDir','reverse','FontSize',10)
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-20,45));
[C,h] = contour(yi(46:90),rC./100,uE_hzav_025',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(yi(46:90),rC./100,psi_025_hzav'./1e9,v_psi,'k');
clabel(C,h);
set(gca,'YDir','reverse','FontSize',10)
title('025','FontSize',12)
freezeColors

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,uE_hzav_050',v); set(h,'LineStyle','none');
set(gca,'YDir','reverse','FontSize',10)
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-20,45));
[C,h] = contour(yi(46:90),rC./100,uE_hzav_050',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(yi(46:90),rC./100,psi_050_hzav'./1e9,v_psi,'k');
clabel(C,h);
set(gca,'YDir','reverse','FontSize',10)
title('050','FontSize',12)
freezeColors


axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,uE_hzav_075',v); set(h,'LineStyle','none');
set(gca,'YDir','reverse','FontSize',10)
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-20,45));
[C,h] = contour(yi(46:90),rC./100,uE_hzav_075',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(yi(46:90),rC./100,psi_075_hzav'./1e9,v_psi,'k');
clabel(C,h);
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
title('075','FontSize',12)
freezeColors

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,uE_hzav_100',v); set(h,'LineStyle','none');
set(gca,'YDir','reverse','FontSize',10)
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-20,45));
[C,h] = contour(yi(46:90),rC./100,uE_hzav_100',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(yi(46:90),rC./100,psi_100_hzav'./1e9,v_psi,'k');
clabel(C,h);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
title('wet','FontSize',12)
freezeColors


axes('position',[pos7x pos7y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,uE_hzav_125',v); set(h,'LineStyle','none');
set(gca,'YDir','reverse','FontSize',10)
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-20,45));
[C,h] = contour(yi(46:90),rC./100,uE_hzav_125',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(yi(46:90),rC./100,psi_125_hzav'./1e9,v_psi,'k');
clabel(C,h);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
title('125','FontSize',12)
freezeColors

axes('position',[pos8x pos8y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,uE_hzav_150',v); set(h,'LineStyle','none');
set(gca,'YDir','reverse','FontSize',10)
hold on
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
x = get(c,'Position');
x(1) = 0.92; x(2) = 0.57; x(3) = 0.015; x(4) = 0.3;
set(c,'Position',x);
set(gca, 'Position', originalSize);
colormap(b2r(-20,45));
[C,h] = contour(yi(46:90),rC./100,uE_hzav_150',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(yi(46:90),rC./100,psi_150_hzav'./1e9,v_psi,'k');
clabel(C,h);
xlabel('Latitude','FontSize',12)
title('150','FontSize',12)
freezeColors
cbfreeze(c);

print('-dpdf','psi_uE.pdf')


