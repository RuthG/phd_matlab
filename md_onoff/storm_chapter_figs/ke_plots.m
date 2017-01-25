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

load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/uE_000_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/vN_000_5.mat')
uE_ll=cube2latlon(xc,yc,uE_000,xi,yi);
vN_ll=cube2latlon(xc,yc,vN_000,xi,yi);
ke_000_ll = uE_ll(:,:,:,day000).^2 + vN_ll(:,:,:,day000).^2;

load('/project/rg312/mat_files/snapshot_data_final/run_010/uE_010_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_010/vN_010_5.mat')
uE_ll=cube2latlon(xc,yc,uE_010,xi,yi);
vN_ll=cube2latlon(xc,yc,vN_010,xi,yi);
ke_010_ll = uE_ll(:,:,:,day000).^2 + vN_ll(:,:,:,day000).^2;

load('/project/rg312/mat_files/snapshot_data_final/run_025/uE_025_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_025/vN_025_5.mat')
uE_ll=cube2latlon(xc,yc,uE_025,xi,yi);
vN_ll=cube2latlon(xc,yc,vN_025,xi,yi);
ke_025_ll = uE_ll(:,:,:,day000).^2 + vN_ll(:,:,:,day000).^2;

load('/project/rg312/mat_files/snapshot_data_final/run_050/uE_050_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_050/vN_050_5.mat')
uE_ll=cube2latlon(xc,yc,uE_050,xi,yi);
vN_ll=cube2latlon(xc,yc,vN_050,xi,yi);
ke_050_ll = uE_ll(:,:,:,day000).^2 + vN_ll(:,:,:,day000).^2;

load('/project/rg312/mat_files/snapshot_data_final/run_th/uE_th_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_th/vN_th_5.mat')
uE_ll=cube2latlon(xc,yc,uE_th,xi,yi);
vN_ll=cube2latlon(xc,yc,vN_th,xi,yi);
ke_th_ll = uE_ll(:,:,:,day000).^2 + vN_ll(:,:,:,day000).^2;

load('/project/rg312/mat_files/snapshot_data_final/run_075/uE_075_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_075/vN_075_5.mat')
uE_ll=cube2latlon(xc,yc,uE_075,xi,yi);
vN_ll=cube2latlon(xc,yc,vN_075,xi,yi);
ke_075_ll = uE_ll(:,:,:,day000).^2 + vN_ll(:,:,:,day000).^2;

load('/project/rg312/mat_files/snapshot_data_final/run_100/uE_100_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_100/vN_100_5.mat')
uE_ll=cube2latlon(xc,yc,uE_100,xi,yi);
vN_ll=cube2latlon(xc,yc,vN_100,xi,yi);
ke_100_ll = uE_ll(:,:,:,day100).^2 + vN_ll(:,:,:,day100).^2;

load('/project/rg312/mat_files/snapshot_data_final/run_125/uE_125_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_125/vN_125_5.mat')
uE_ll=cube2latlon(xc,yc,uE_125,xi,yi);
vN_ll=cube2latlon(xc,yc,vN_125,xi,yi);
ke_125_ll = uE_ll(:,:,:,day000).^2 + vN_ll(:,:,:,day000).^2;

load('/project/rg312/mat_files/snapshot_data_final/run_150/uE_150_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_150/vN_150_5.mat')
uE_ll=cube2latlon(xc,yc,uE_150,xi,yi);
vN_ll=cube2latlon(xc,yc,vN_150,xi,yi);
ke_150_ll = uE_ll(:,:,:,day000).^2 + vN_ll(:,:,:,day000).^2;





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

v=0:500:3000;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(xi, yi, ke_000_ll(:,:,20)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
ylabel('Latitude','FontSize',12)
title('0.0')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(xi, yi, ke_010_ll(:,:,20)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
title('0.1')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(xi, yi, ke_025_ll(:,:,20)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
title('0.25')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(xi, yi, ke_050_ll(:,:,20)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
ylabel('Latitude','FontSize',12)
title('0.5')

axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contour(xi, yi, ke_th_ll(:,:,20)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
title('tropheat')

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contour(xi, yi, ke_075_ll(:,:,20)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
title('0.75')

axes('position',[pos7x pos7y xSize_sub ySize_sub])
[C,h] = contour(xi, yi, ke_100_ll(:,:,20)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
ylabel('Latitude','FontSize',12)
xlabel('Wavenumber','FontSize',12)
title('1.0')

axes('position',[pos8x pos8y xSize_sub ySize_sub])
[C,h] = contour(xi, yi, ke_125_ll(:,:,20)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
xlabel('Wavenumber','FontSize',12)
title('1.25')

axes('position',[pos9x pos9y xSize_sub ySize_sub])
[C,h] = contour(xi, yi, ke_150_ll(:,:,20)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
xlabel('Wavenumber','FontSize',12)
title('1.5')

print('-dpdf','ke.pdf')

