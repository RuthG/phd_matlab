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

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050_tropheat.mat','uE_tav')
uE_ll=cube2latlon(xc,yc,uE_tav,xi,yi);
uE_zav_th(:,:) = mean(uE_ll,1);
load('/project/rg312/mat_files/chapter2_variables/psi_tav_th.mat','psi_th_hzav')

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
uE_hzav_th(i,:) = (uE_zav_th(i+45,:) + uE_zav_th(46-i,:))./2;
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
ySize_sub = 0.10; 
xSize_sub = 0.2; 

pos1x = 0.1 ; 	pos1y = 0.83; 
pos2x = 0.37 ; 	pos2y = 0.83; 
pos3x = 0.64 ; 	pos3y = 0.83; 
pos4x = 0.1 ; 	pos4y = 0.69; 
pos5x = 0.37 ; 	pos5y = 0.69; 
pos6x = 0.64 ; 	pos6y = 0.69; 
pos7x = 0.1 ; 	pos7y = 0.55; 
pos8x = 0.37 ; 	pos8y = 0.55; 
pos9x = 0.64 ;   pos9y  = 0.55; 

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
title('0.0')
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
title('0.1')
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
title('0.25')
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
ylabel('Pressure, hPa','FontSize',12)
title('0.5')
freezeColors

axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,uE_hzav_th',v); set(h,'LineStyle','none');
set(gca,'YDir','reverse','FontSize',10)
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-20,45));
[C,h] = contour(yi(46:90),rC./100,uE_hzav_th',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(yi(46:90),rC./100,psi_th_hzav'./1e9,v_psi,'k');
clabel(C,h);
set(gca,'YDir','reverse','FontSize',10)
title('tropheat')
freezeColors

axes('position',[pos6x pos6y xSize_sub ySize_sub])
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
title('0.75')
freezeColors

axes('position',[pos7x pos7y xSize_sub ySize_sub])
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
ylabel('Pressure, hPa','FontSize',12)
title('1.0')
freezeColors


axes('position',[pos8x pos8y xSize_sub ySize_sub])
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
title('1.25')
freezeColors

axes('position',[pos9x pos9y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,uE_hzav_150',v); set(h,'LineStyle','none');
set(gca,'YDir','reverse','FontSize',10)
hold on
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
x = get(c,'Position');
x(1) = 0.87; x(2) = 0.59; x(3) = 0.015; x(4) = 0.3;
set(c,'Position',x);
set(gca, 'Position', originalSize);
colormap(b2r(-20,45));
[C,h] = contour(yi(46:90),rC./100,uE_hzav_150',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(yi(46:90),rC./100,psi_150_hzav'./1e9,v_psi,'k');
clabel(C,h);
xlabel('Latitude','FontSize',12)
title('1.5')
freezeColors
cbfreeze(c);

print('-dpdf','psi_uE.pdf')


