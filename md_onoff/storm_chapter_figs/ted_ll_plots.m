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

load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/t_000_5.mat')
t_ll=cube2latlon(xc,yc,t_000(:,:,5,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/t_000_timemean.mat')
t_ed_000 = t_ll - t_ll_tav(:,:,5);

load('/project/rg312/mat_files/snapshot_data_final/run_010/t_010_5.mat')
t_ll=cube2latlon(xc,yc,t_010(:,:,5,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_010/t_010_timemean.mat')
t_ed_010 = t_ll - t_ll_tav(:,:,5);

load('/project/rg312/mat_files/snapshot_data_final/run_025/t_025_5.mat')
t_ll=cube2latlon(xc,yc,t_025(:,:,5,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_025/t_025_timemean.mat')
t_ed_025 = t_ll - t_ll_tav(:,:,5);

load('/project/rg312/mat_files/snapshot_data_final/run_050/t_050_5.mat')
t_ll=cube2latlon(xc,yc,t_050(:,:,5,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_050/t_050_timemean.mat')
t_ed_050 = t_ll - t_ll_tav(:,:,5);

load('/project/rg312/mat_files/snapshot_data_final/run_th/t_th_5.mat')
t_ll=cube2latlon(xc,yc,t_th(:,:,5,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_th/t_th_timemean.mat')
t_ed_th = t_ll - t_ll_tav(:,:,5);

load('/project/rg312/mat_files/snapshot_data_final/run_075/t_075_5.mat')
t_ll=cube2latlon(xc,yc,t_075(:,:,5,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_075/t_075_timemean.mat')
t_ed_075 = t_ll - t_ll_tav(:,:,5);

load('/project/rg312/mat_files/snapshot_data_final/run_100/t_100_5.mat')
t_ll=cube2latlon(xc,yc,t_100(:,:,5,day100),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_100/t_100_timemean.mat')
t_ed_100 = t_ll - t_ll_tav(:,:,5);

load('/project/rg312/mat_files/snapshot_data_final/run_125/t_125_5.mat')
t_ll=cube2latlon(xc,yc,t_125(:,:,5,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_125/t_125_timemean.mat')
t_ed_125 = t_ll - t_ll_tav(:,:,5);

load('/project/rg312/mat_files/snapshot_data_final/run_150/t_150_5.mat')
t_ll=cube2latlon(xc,yc,t_150(:,:,5,day000),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_150/t_150_timemean.mat')
t_ed_150 = t_ll - t_ll_tav(:,:,5);






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

%myColorMap = flipud(bone); 
% Assign white (all 1's) to black (the first row in myColorMap).
%myColorMap(1, :) = [1 1 1];
%colormap(myColorMap); % Apply the colormap 

v=-12:1:12;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), t_ed_000(:,46:90)',v);
set(h,'LineColor','none')
colormap(b2r(-8,8));
%clabel(C,h);
set(gca,'FontSize',10)
ylabel('Latitude','FontSize',12)
title('dry')
freezeColors

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), t_ed_010(:,46:90)',v);
set(h,'LineColor','none')
colormap(b2r(-8,8));
%clabel(C,h);
set(gca,'FontSize',10)
title('010')
freezeColors

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), t_ed_025(:,46:90)',v);
colormap(b2r(-8,8));
set(h,'LineColor','none')
%clabel(C,h);
set(gca,'FontSize',10)
title('025')
freezeColors

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), t_ed_050(:,46:90)',v);
colormap(b2r(-8,8));
set(h,'LineColor','none')
%clabel(C,h);
set(gca,'FontSize',10)
ylabel('Latitude','FontSize',12)
title('050')
freezeColors

axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), t_ed_th(:,46:90)',v);
colormap(b2r(-8,8));
set(h,'LineColor','none')
%clabel(C,h);
set(gca,'FontSize',10)
title('tropheat')
freezeColors

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), t_ed_075(:,46:90)',v);
colormap(b2r(-8,8));
set(h,'LineColor','none')
%clabel(C,h);
set(gca,'FontSize',10)
title('075')
freezeColors

axes('position',[pos7x pos7y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), t_ed_100(:,46:90)',v);
colormap(b2r(-8,8));
set(h,'LineColor','none')
%clabel(C,h);
set(gca,'FontSize',10)
ylabel('Latitude','FontSize',12)
xlabel('Longitude','FontSize',12)
title('wet')
freezeColors

axes('position',[pos8x pos8y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), t_ed_125(:,46:90)',v);
colormap(b2r(-8,8));
set(h,'LineColor','none')
%clabel(C,h);
set(gca,'FontSize',10)
xlabel('Longitude','FontSize',12)
title('125')
freezeColors

axes('position',[pos9x pos9y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), t_ed_150(:,46:90)',v);
colormap(b2r(-8,8));
set(h,'LineColor','none')
%clabel(C,h);
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

print('-dpdf','t_ed_ll.pdf')

