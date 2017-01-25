%load up u and v for a snapshot for each experiment and plot quiver plots in jet

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

day000 = 1;
day100 = 61;

nit = 86400.*5 + 240;
nit100 = 86400.*5 + 240.*61;

load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/w_000_5.mat')
w_000_ll=cube2latlon(xc,yc,w_000(:,:,8,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/ph_adj_000_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/ph_adj_000_timemean.mat')
ph_ed_000_ll=cube2latlon(xc,yc,ph_adj_000(:,:,8,day000),xi,yi) - ph_adj_ll_tav(:,:,8);

load('/project/rg312/mat_files/snapshot_data_final/run_010/w_010_5.mat')
w_010_ll=cube2latlon(xc,yc,w_010(:,:,8,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_010/ph_adj_010_5.mat')
ph_010_ll=cube2latlon(xc,yc,ph_adj_010(:,:,8,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_010/ph_adj_010_timemean.mat')
ph_ed_010_ll=cube2latlon(xc,yc,ph_adj_010(:,:,8,day000),xi,yi) - ph_adj_ll_tav(:,:,8);

load('/project/rg312/mat_files/snapshot_data_final/run_025/w_025_5.mat')
w_025_ll=cube2latlon(xc,yc,w_025(:,:,8,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_025/ph_adj_025_5.mat')
ph_025_ll=cube2latlon(xc,yc,ph_adj_025(:,:,8,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_025/ph_adj_025_timemean.mat')
ph_ed_025_ll=cube2latlon(xc,yc,ph_adj_025(:,:,8,day000),xi,yi) - ph_adj_ll_tav(:,:,8);

load('/project/rg312/mat_files/snapshot_data_final/run_050/w_050_5.mat')
w_050_ll=cube2latlon(xc,yc,w_050(:,:,8,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_050/ph_adj_050_5.mat')
ph_050_ll=cube2latlon(xc,yc,ph_adj_050(:,:,8,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_050/ph_adj_050_timemean.mat')
ph_ed_050_ll=cube2latlon(xc,yc,ph_adj_050(:,:,8,day000),xi,yi) - ph_adj_ll_tav(:,:,8);

load('/project/rg312/mat_files/snapshot_data_final/run_th/w_th_5.mat')
w_th_ll=cube2latlon(xc,yc,w_th(:,:,8,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_th/ph_adj_th_5.mat')
ph_th_ll=cube2latlon(xc,yc,ph_adj_th(:,:,8,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_th/ph_adj_th_timemean.mat')
ph_ed_th_ll=cube2latlon(xc,yc,ph_adj_th(:,:,8,day000),xi,yi) - ph_adj_ll_tav(:,:,8);

load('/project/rg312/mat_files/snapshot_data_final/run_075/w_075_5.mat')
w_075_ll=cube2latlon(xc,yc,w_075(:,:,8,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_075/ph_adj_075_5.mat')
ph_075_ll=cube2latlon(xc,yc,ph_adj_075(:,:,8,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_075/ph_adj_075_timemean.mat')
ph_ed_075_ll=cube2latlon(xc,yc,ph_adj_075(:,:,8,day000),xi,yi) - ph_adj_ll_tav(:,:,8);

load('/project/rg312/mat_files/snapshot_data_final/run_100/w_100_5.mat')
w_100_ll=cube2latlon(xc,yc,w_100(:,:,8,day100),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_100/ph_adj_100_5.mat')
ph_100_ll=cube2latlon(xc,yc,ph_adj_100(:,:,8,day100),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_100/ph_adj_100_timemean.mat')
ph_ed_100_ll=cube2latlon(xc,yc,ph_adj_100(:,:,8,day100),xi,yi) - ph_adj_ll_tav(:,:,8);

load('/project/rg312/mat_files/snapshot_data_final/run_125/w_125_5.mat')
w_125_ll=cube2latlon(xc,yc,w_125(:,:,8,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_125/ph_adj_125_5.mat')
ph_125_ll=cube2latlon(xc,yc,ph_adj_125(:,:,8,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_125/ph_adj_125_timemean.mat')
ph_ed_125_ll=cube2latlon(xc,yc,ph_adj_125(:,:,8,day000),xi,yi) - ph_adj_ll_tav(:,:,8);

load('/project/rg312/mat_files/snapshot_data_final/run_150/w_150_5.mat')
w_150_ll=cube2latlon(xc,yc,w_150(:,:,8,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_150/ph_adj_150_5.mat')
ph_150_ll=cube2latlon(xc,yc,ph_adj_150(:,:,8,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_150/ph_adj_150_timemean.mat')
ph_ed_150_ll=cube2latlon(xc,yc,ph_adj_150(:,:,8,day000),xi,yi) - ph_adj_ll_tav(:,:,8);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1.;               %# bottom/top margins from page borders
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

%myColorMap = flipud(bone); 
% Assign white (all 1's) to black (the first row in myColorMap).
%myColorMap(1, :) = [1 1 1];
%colormap(myColorMap); % Apply the colormap 

v=-2:0.2:2;
vph = -300:50:300;
vlabel = 2000:200:4000;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), w_000_ll(:,46:90)',v);
set(h,'LineColor','none')
hold on
vph = -300:50:50;
[C,h] = contour(xi,yi(46:90), ph_ed_000_ll(:,46:90)'./9.8,vph,'k--');
vph = 0:50:300;
[C,h] = contour(xi,yi(46:90), ph_ed_000_ll(:,46:90)'./9.8,vph,'k');
clabel(C,h,0);
colormap(b2r(-0.75,0.75));
set(gca,'FontSize',10)
ylabel('Latitude','FontSize',12)
title('dry')
freezeColors

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), w_010_ll(:,46:90)',v);
set(h,'LineColor','none')
hold on
vph = -300:50:50;
[C,h] = contour(xi,yi(46:90), ph_ed_010_ll(:,46:90)'./9.8,vph,'k--');
vph = 0:50:300;
[C,h] = contour(xi,yi(46:90), ph_ed_010_ll(:,46:90)'./9.8,vph,'k');
clabel(C,h,0);
colormap(b2r(-0.75,0.75));
set(gca,'FontSize',10)
title('010')
freezeColors

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), w_025_ll(:,46:90)',v);
set(h,'LineColor','none')
hold on
vph = -300:50:50;
[C,h] = contour(xi,yi(46:90), ph_ed_025_ll(:,46:90)'./9.8,vph,'k--');
vph = 0:50:300;
[C,h] = contour(xi,yi(46:90), ph_ed_025_ll(:,46:90)'./9.8,vph,'k');
clabel(C,h,0);
colormap(b2r(-0.75,0.75));
set(gca,'FontSize',10)
title('025')
freezeColors

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), w_050_ll(:,46:90)',v);
set(h,'LineColor','none')
hold on
vph = -300:50:50;
[C,h] = contour(xi,yi(46:90), ph_ed_050_ll(:,46:90)'./9.8,vph,'k--');
vph = 0:50:300;
[C,h] = contour(xi,yi(46:90), ph_ed_050_ll(:,46:90)'./9.8,vph,'k');
clabel(C,h,0);
colormap(b2r(-0.75,0.75));
set(gca,'FontSize',10)
ylabel('Latitude','FontSize',12)
title('050')
freezeColors

axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), w_th_ll(:,46:90)',v);
set(h,'LineColor','none')
hold on
vph = -300:50:50;
[C,h] = contour(xi,yi(46:90), ph_ed_th_ll(:,46:90)'./9.8,vph,'k--');
vph = 0:50:300;
[C,h] = contour(xi,yi(46:90), ph_ed_th_ll(:,46:90)'./9.8,vph,'k');
clabel(C,h,0);
colormap(b2r(-0.75,0.75));
set(gca,'FontSize',10)
title('tropheat')
freezeColors

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), w_075_ll(:,46:90)',v);
set(h,'LineColor','none')
hold on
vph = -300:50:50;
[C,h] = contour(xi,yi(46:90), ph_ed_075_ll(:,46:90)'./9.8,vph,'k--');
vph = 0:50:300;
[C,h] = contour(xi,yi(46:90), ph_ed_075_ll(:,46:90)'./9.8,vph,'k');
clabel(C,h,0);
colormap(b2r(-0.75,0.75));
set(gca,'FontSize',10)
title('075')
freezeColors

axes('position',[pos7x pos7y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), w_100_ll(:,46:90)',v);
set(h,'LineColor','none')
hold on
vph = -300:50:50;
[C,h] = contour(xi,yi(46:90), ph_ed_100_ll(:,46:90)'./9.8,vph,'k--');
vph = 0:50:300;
[C,h] = contour(xi,yi(46:90), ph_ed_100_ll(:,46:90)'./9.8,vph,'k');
clabel(C,h,0);
colormap(b2r(-0.75,0.75));
set(gca,'FontSize',10)
ylabel('Latitude','FontSize',12)
xlabel('Longitude','FontSize',12)
title('wet')
freezeColors

axes('position',[pos8x pos8y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), w_125_ll(:,46:90)',v);
set(h,'LineColor','none')
hold on
vph = -300:50:50;
[C,h] = contour(xi,yi(46:90), ph_ed_125_ll(:,46:90)'./9.8,vph,'k--');
vph = 0:50:300;
[C,h] = contour(xi,yi(46:90), ph_ed_125_ll(:,46:90)'./9.8,vph,'k');
clabel(C,h,0);
colormap(b2r(-0.75,0.75));
set(gca,'FontSize',10)
xlabel('Longitude','FontSize',12)
title('125')
freezeColors

axes('position',[pos9x pos9y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), w_150_ll(:,46:90)',v);
set(h,'LineColor','none')
hold on
vph = -300:50:50;
[C,h] = contour(xi,yi(46:90), ph_ed_150_ll(:,46:90)'./9.8,vph,'k--');
vph = 0:50:300;
[C,h] = contour(xi,yi(46:90), ph_ed_150_ll(:,46:90)'./9.8,vph,'k');
clabel(C,h,0);
colormap(b2r(-0.75,0.75));
set(gca,'FontSize',10)
xlabel('Longitude','FontSize',12)
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
x = get(c,'Position');
x(1) = 0.87; x(2) = 0.59; x(3) = 0.015; x(4) = 0.3;
set(c,'Position',x);
set(gca, 'Position', originalSize);
title('150')
freezeColors

print('-dpdf','w_ll.pdf')

