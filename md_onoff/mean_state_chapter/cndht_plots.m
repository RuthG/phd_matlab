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

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_000.mat')
cndht_ll=cube2latlon(xc,yc,cndht_tav,xi,yi);
cndht_zav_000(:,:) = mean(cndht_ll,1).*86400;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_010.mat')
cndht_ll=cube2latlon(xc,yc,cndht_tav,xi,yi);
cndht_zav_010(:,:) = mean(cndht_ll,1).*86400;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_025.mat')
cndht_ll=cube2latlon(xc,yc,cndht_tav,xi,yi);
cndht_zav_025(:,:) = mean(cndht_ll,1).*86400;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_050.mat')
cndht_ll=cube2latlon(xc,yc,cndht_tav,xi,yi);
cndht_zav_050(:,:) = mean(cndht_ll,1).*86400;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_075.mat')
cndht_ll=cube2latlon(xc,yc,cndht_tav,xi,yi);
cndht_zav_075(:,:) = mean(cndht_ll,1).*86400;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_100.mat')
cndht_ll=cube2latlon(xc,yc,cndht_tav,xi,yi);
cndht_zav_100(:,:) = mean(cndht_ll,1).*86400;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_125.mat')
cndht_ll=cube2latlon(xc,yc,cndht_tav,xi,yi);
cndht_zav_125(:,:) = mean(cndht_ll,1).*86400;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_150.mat')
cndht_ll=cube2latlon(xc,yc,cndht_tav,xi,yi);
cndht_zav_150(:,:) = mean(cndht_ll,1).*86400;

for i=1:45
cndht_hzav_000(i,:) = (cndht_zav_000(i+45,:) + cndht_zav_000(46-i,:))./2;
cndht_hzav_010(i,:) = (cndht_zav_010(i+45,:) + cndht_zav_010(46-i,:))./2;
cndht_hzav_025(i,:) = (cndht_zav_025(i+45,:) + cndht_zav_025(46-i,:))./2;
cndht_hzav_050(i,:) = (cndht_zav_050(i+45,:) + cndht_zav_050(46-i,:))./2;
cndht_hzav_075(i,:) = (cndht_zav_075(i+45,:) + cndht_zav_075(46-i,:))./2;
cndht_hzav_100(i,:) = (cndht_zav_100(i+45,:) + cndht_zav_100(46-i,:))./2;
cndht_hzav_125(i,:) = (cndht_zav_125(i+45,:) + cndht_zav_125(46-i,:))./2;
cndht_hzav_150(i,:) = (cndht_zav_150(i+45,:) + cndht_zav_150(46-i,:))./2;
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

v=0:0.5:10;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,cndht_hzav_000',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(0,10));
%[C,h] = contour(yi(46:90),rC./100,cndht_hzav_000',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
xlim([1 89])
ylim([20 980])
title('dry','FontSize',12)
freezeColors

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,cndht_hzav_010',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(0,10));
%[C,h] = contour(yi(46:90),rC./100,cndht_hzav_010',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
title('010','FontSize',12)
freezeColors
text(0.35,1.25,'Large-scale condensation heating rate, K/day','Units','normalized','FontSize',12)

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,cndht_hzav_025',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(0,10));
%[C,h] = contour(yi(46:90),rC./100,cndht_hzav_025',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
title('025','FontSize',12)
freezeColors

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,cndht_hzav_050',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(0,10));
%[C,h] = contour(yi(46:90),rC./100,cndht_hzav_050',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
title('050','FontSize',12)
freezeColors


axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,cndht_hzav_075',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(0,10));
%[C,h] = contour(yi(46:90),rC./100,cndht_hzav_075',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
title('075','FontSize',12)
freezeColors

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,cndht_hzav_100',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(0,10));
%[C,h] = contour(yi(46:90),rC./100,cndht_hzav_100',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
title('wet','FontSize',12)
freezeColors


axes('position',[pos7x pos7y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,cndht_hzav_125',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(0,10));
%[C,h] = contour(yi(46:90),rC./100,cndht_hzav_125',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
title('125','FontSize',12)
freezeColors

axes('position',[pos8x pos8y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,cndht_hzav_150',v);
hold on
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
x = get(c,'Position');
x(1) = 0.92; x(2) = 0.57; x(3) = 0.015; x(4) = 0.3;
set(c,'Position',x);
set(gca, 'Position', originalSize);
colormap(b2r(0,10));
%[C,h] = contour(yi(46:90),rC./100,cndht_hzav_150',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
title('150','FontSize',12)
freezeColors
cbfreeze(c);

print('-dpdf','cndht.pdf')


