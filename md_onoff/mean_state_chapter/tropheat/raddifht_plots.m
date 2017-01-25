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
radht_tav = htrt_tav - cndht_tav-cnvht_tav-difht_tav;
radht_ll=cube2latlon(xc,yc,radht_tav,xi,yi);
radht_zav_000(:,:) = mean(radht_ll,1).*86400;
difht_ll=cube2latlon(xc,yc,difht_tav,xi,yi);
difht_zav_000(:,:) = mean(difht_ll,1).*86400;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_010.mat')
radht_tav = htrt_tav - cndht_tav-cnvht_tav-difht_tav;
radht_ll=cube2latlon(xc,yc,radht_tav,xi,yi);
radht_zav_010(:,:) = mean(radht_ll,1).*86400;
difht_ll=cube2latlon(xc,yc,difht_tav,xi,yi);
difht_zav_010(:,:) = mean(difht_ll,1).*86400;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_025.mat')
radht_tav = htrt_tav - cndht_tav-cnvht_tav-difht_tav;
radht_ll=cube2latlon(xc,yc,radht_tav,xi,yi);
radht_zav_025(:,:) = mean(radht_ll,1).*86400;
difht_ll=cube2latlon(xc,yc,difht_tav,xi,yi);
difht_zav_025(:,:) = mean(difht_ll,1).*86400;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_050.mat')
radht_tav = htrt_tav - cndht_tav-cnvht_tav-difht_tav;
radht_ll=cube2latlon(xc,yc,radht_tav,xi,yi);
radht_zav_050(:,:) = mean(radht_ll,1).*86400;
difht_ll=cube2latlon(xc,yc,difht_tav,xi,yi);
difht_zav_050(:,:) = mean(difht_ll,1).*86400;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_050_tropheat.mat')
radht_tav = htrt_tav - cndht_tav-cnvht_tav-difht_tav;
radht_ll=cube2latlon(xc,yc,radht_tav,xi,yi);
radht_zav_th(:,:) = mean(radht_ll,1).*86400;
difht_ll=cube2latlon(xc,yc,difht_tav,xi,yi);
difht_zav_th(:,:) = mean(difht_ll,1).*86400;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_075.mat')
radht_tav = htrt_tav - cndht_tav-cnvht_tav-difht_tav;
radht_ll=cube2latlon(xc,yc,radht_tav,xi,yi);
radht_zav_075(:,:) = mean(radht_ll,1).*86400;
difht_ll=cube2latlon(xc,yc,difht_tav,xi,yi);
difht_zav_075(:,:) = mean(difht_ll,1).*86400;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_100.mat')
radht_tav = htrt_tav - cndht_tav-cnvht_tav-difht_tav;
radht_ll=cube2latlon(xc,yc,radht_tav,xi,yi);
radht_zav_100(:,:) = mean(radht_ll,1).*86400;
difht_ll=cube2latlon(xc,yc,difht_tav,xi,yi);
difht_zav_100(:,:) = mean(difht_ll,1).*86400;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_125.mat')
radht_tav = htrt_tav - cndht_tav-cnvht_tav-difht_tav;
radht_ll=cube2latlon(xc,yc,radht_tav,xi,yi);
radht_zav_125(:,:) = mean(radht_ll,1).*86400;
difht_ll=cube2latlon(xc,yc,difht_tav,xi,yi);
difht_zav_125(:,:) = mean(difht_ll,1).*86400;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_150.mat')
radht_tav = htrt_tav - cndht_tav-cnvht_tav-difht_tav;
radht_ll=cube2latlon(xc,yc,radht_tav,xi,yi);
radht_zav_150(:,:) = mean(radht_ll,1).*86400;
difht_ll=cube2latlon(xc,yc,difht_tav,xi,yi);
difht_zav_150(:,:) = mean(difht_ll,1).*86400;

for i=1:45
radht_hzav_000(i,:) = (radht_zav_000(i+45,:) + radht_zav_000(46-i,:))./2;
radht_hzav_010(i,:) = (radht_zav_010(i+45,:) + radht_zav_010(46-i,:))./2;
radht_hzav_025(i,:) = (radht_zav_025(i+45,:) + radht_zav_025(46-i,:))./2;
radht_hzav_050(i,:) = (radht_zav_050(i+45,:) + radht_zav_050(46-i,:))./2;
radht_hzav_th(i,:) = (radht_zav_th(i+45,:) + radht_zav_th(46-i,:))./2;
radht_hzav_075(i,:) = (radht_zav_075(i+45,:) + radht_zav_075(46-i,:))./2;
radht_hzav_100(i,:) = (radht_zav_100(i+45,:) + radht_zav_100(46-i,:))./2;
radht_hzav_125(i,:) = (radht_zav_125(i+45,:) + radht_zav_125(46-i,:))./2;
radht_hzav_150(i,:) = (radht_zav_150(i+45,:) + radht_zav_150(46-i,:))./2;

difht_hzav_000(i,:) = (difht_zav_000(i+45,:) + difht_zav_000(46-i,:))./2;
difht_hzav_010(i,:) = (difht_zav_010(i+45,:) + difht_zav_010(46-i,:))./2;
difht_hzav_025(i,:) = (difht_zav_025(i+45,:) + difht_zav_025(46-i,:))./2;
difht_hzav_050(i,:) = (difht_zav_050(i+45,:) + difht_zav_050(46-i,:))./2;
difht_hzav_th(i,:) = (difht_zav_th(i+45,:) + difht_zav_th(46-i,:))./2;
difht_hzav_075(i,:) = (difht_zav_075(i+45,:) + difht_zav_075(46-i,:))./2;
difht_hzav_100(i,:) = (difht_zav_100(i+45,:) + difht_zav_100(46-i,:))./2;
difht_hzav_125(i,:) = (difht_zav_125(i+45,:) + difht_zav_125(46-i,:))./2;
difht_hzav_150(i,:) = (difht_zav_150(i+45,:) + difht_zav_150(46-i,:))./2;

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

v=-6:0.5:2;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,radht_hzav_000',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-6,2));
%[C,h] = contour(yi(46:90),rC./100,radht_hzav_000',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
title('0.0')
freezeColors

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,radht_hzav_010',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-6,2));
%[C,h] = contour(yi(46:90),rC./100,radht_hzav_010',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
title('0.1')
freezeColors
text(-0.2,1.3,'Radiative heating rate, K/day','Units','normalized','FontSize',12)

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,radht_hzav_025',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-6,2));
%[C,h] = contour(yi(46:90),rC./100,radht_hzav_025',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
title('0.25')
freezeColors

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,radht_hzav_050',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-6,2));
%[C,h] = contour(yi(46:90),rC./100,radht_hzav_050',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
title('0.5')
freezeColors


axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,radht_hzav_th',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-6,2));
%[C,h] = contour(yi(46:90),rC./100,radht_hzav_th',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
title('tropheat')
freezeColors


axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,radht_hzav_075',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-6,2));
%[C,h] = contour(yi(46:90),rC./100,radht_hzav_075',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
title('0.75')
freezeColors

axes('position',[pos7x pos7y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,radht_hzav_100',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-6,2));
%[C,h] = contour(yi(46:90),rC./100,radht_hzav_100',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
title('1.0')
freezeColors


axes('position',[pos8x pos8y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,radht_hzav_125',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-6,2));
%[C,h] = contour(yi(46:90),rC./100,radht_hzav_125',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
title('1.25')
freezeColors

axes('position',[pos9x pos9y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,radht_hzav_150',v);
hold on
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
x = get(c,'Position');
x(1) = 0.87; x(2) = 0.59; x(3) = 0.015; x(4) = 0.3;
set(c,'Position',x);
set(gca, 'Position', originalSize);
colormap(b2r(-6,2));
%[C,h] = contour(yi(46:90),rC./100,radht_hzav_150',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
title('1.5')
freezeColors
cbfreeze(c);

print('-dpdf','radht.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')



v=-5.5:0.5:5.5;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,difht_hzav_000',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-5.5,5.5));
%[C,h] = contour(yi(46:90),rC./100,difht_hzav_000',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
title('0.0')
freezeColors

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,difht_hzav_010',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-5.5,5.5));
%[C,h] = contour(yi(46:90),rC./100,difht_hzav_010',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
title('0.1')
freezeColors
text(-0.2,1.3,'Diffusive heating rate, K/day','Units','normalized','FontSize',12)

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,difht_hzav_025',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-5.5,5.5));
%[C,h] = contour(yi(46:90),rC./100,difht_hzav_025',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
title('0.25')
freezeColors

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,difht_hzav_050',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-5.5,5.5));
%[C,h] = contour(yi(46:90),rC./100,difht_hzav_050',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
title('0.5')
freezeColors

axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,difht_hzav_th',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-5.5,5.5));
%[C,h] = contour(yi(46:90),rC./100,difht_hzav_th',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
title('tropheat')
freezeColors

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,difht_hzav_075',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-5.5,5.5));
%[C,h] = contour(yi(46:90),rC./100,difht_hzav_075',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
title('0.75')
freezeColors

axes('position',[pos7x pos7y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,difht_hzav_100',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-5.5,5.5));
%[C,h] = contour(yi(46:90),rC./100,difht_hzav_100',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
title('1.0')
freezeColors


axes('position',[pos8x pos8y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,difht_hzav_125',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-5.5,5.5));
%[C,h] = contour(yi(46:90),rC./100,difht_hzav_125',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
title('1.25')
freezeColors

axes('position',[pos9x pos9y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,difht_hzav_150',v);
hold on
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
x = get(c,'Position');
x(1) = 0.87; x(2) = 0.59; x(3) = 0.015; x(4) = 0.3;
set(c,'Position',x);
set(gca, 'Position', originalSize);
colormap(b2r(-5.5,5.5));
%[C,h] = contour(yi(46:90),rC./100,difht_hzav_150',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
title('1.5')
freezeColors
cbfreeze(c);



print('-dpdf','difht.pdf')


