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

load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/uE_000_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/vN_000_5.mat')
uE_ll=cube2latlon(xc,yc,uE_000(:,:,20,day000),xi,yi);
vN_ll=cube2latlon(xc,yc,vN_000(:,:,20,day000),xi,yi);
ke_000_ll = uE_ll.^2 + vN_ll.^2;

load('/project/rg312/mat_files/snapshot_data_final/run_010/uE_010_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_010/vN_010_5.mat')
uE_ll=cube2latlon(xc,yc,uE_010(:,:,20,day000),xi,yi);
vN_ll=cube2latlon(xc,yc,vN_010(:,:,20,day000),xi,yi);
ke_010_ll = uE_ll.^2 + vN_ll.^2;

load('/project/rg312/mat_files/snapshot_data_final/run_025/uE_025_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_025/vN_025_5.mat')
uE_ll=cube2latlon(xc,yc,uE_025(:,:,20,day000),xi,yi);
vN_ll=cube2latlon(xc,yc,vN_025(:,:,20,day000),xi,yi);
ke_025_ll = uE_ll.^2 + vN_ll.^2;

load('/project/rg312/mat_files/snapshot_data_final/run_050/uE_050_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_050/vN_050_5.mat')
uE_ll=cube2latlon(xc,yc,uE_050(:,:,20,day000),xi,yi);
vN_ll=cube2latlon(xc,yc,vN_050(:,:,20,day000),xi,yi);
ke_050_ll = uE_ll.^2 + vN_ll.^2;

load('/project/rg312/mat_files/snapshot_data_final/run_th/uE_th_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_th/vN_th_5.mat')
uE_ll=cube2latlon(xc,yc,uE_th(:,:,20,day000),xi,yi);
vN_ll=cube2latlon(xc,yc,vN_th(:,:,20,day000),xi,yi);
ke_th_ll = uE_ll.^2 + vN_ll.^2;

load('/project/rg312/mat_files/snapshot_data_final/run_075/uE_075_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_075/vN_075_5.mat')
uE_ll=cube2latlon(xc,yc,uE_075(:,:,20,day000),xi,yi);
vN_ll=cube2latlon(xc,yc,vN_075(:,:,20,day000),xi,yi);
ke_075_ll = uE_ll.^2 + vN_ll.^2;

load('/project/rg312/mat_files/snapshot_data_final/run_100/uE_100_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_100/vN_100_5.mat')
uE_ll=cube2latlon(xc,yc,uE_100(:,:,20,day100),xi,yi);
vN_ll=cube2latlon(xc,yc,vN_100(:,:,20,day100),xi,yi);
ke_100_ll = uE_ll.^2 + vN_ll.^2;

load('/project/rg312/mat_files/snapshot_data_final/run_125/uE_125_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_125/vN_125_5.mat')
uE_ll=cube2latlon(xc,yc,uE_125(:,:,20,day000),xi,yi);
vN_ll=cube2latlon(xc,yc,vN_125(:,:,20,day000),xi,yi);
ke_125_ll = uE_ll.^2 + vN_ll.^2;

load('/project/rg312/mat_files/snapshot_data_final/run_150/uE_150_5.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_150/vN_150_5.mat')
uE_ll=cube2latlon(xc,yc,uE_150(:,:,20,day000),xi,yi);
vN_ll=cube2latlon(xc,yc,vN_150(:,:,20,day000),xi,yi);
ke_150_ll = uE_ll.^2 + vN_ll.^2;




rDir='/project/rg312/final_runs/run_000_final/';
[sfsnap,iter,M]=rdmds([rDir,'sfsnapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhLscP'));
lscp_000 = sfsnap(:,:,J);
lscp_000_ll=cube2latlon(xc,yc,lscp_000,xi,yi);
J=find(strcmp(fldList,'AtPhCnvP'));
cnvp_000 = sfsnap(:,:,J);
cnvp_000_ll=cube2latlon(xc,yc,cnvp_000,xi,yi);


rDir='/project/rg312/final_runs/run_010_final/';
[sfsnap,iter,M]=rdmds([rDir,'sfsnapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhLscP'));
lscp_010 = sfsnap(:,:,J);
lscp_010_ll=cube2latlon(xc,yc,lscp_010,xi,yi);
J=find(strcmp(fldList,'AtPhCnvP'));
cnvp_010 = sfsnap(:,:,J);
cnvp_010_ll=cube2latlon(xc,yc,cnvp_010,xi,yi);


rDir='/project/rg312/final_runs/run_025_final/';
[sfsnap,iter,M]=rdmds([rDir,'sfsnapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhLscP'));
lscp_025 = sfsnap(:,:,J);
lscp_025_ll=cube2latlon(xc,yc,lscp_025,xi,yi);
J=find(strcmp(fldList,'AtPhCnvP'));
cnvp_025 = sfsnap(:,:,J);
cnvp_025_ll=cube2latlon(xc,yc,cnvp_025,xi,yi);


rDir='/project/rg312/final_runs/run_050_final/';
[sfsnap,iter,M]=rdmds([rDir,'sfsnapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhLscP'));
lscp_050 = sfsnap(:,:,J);
lscp_050_ll=cube2latlon(xc,yc,lscp_050,xi,yi);
J=find(strcmp(fldList,'AtPhCnvP'));
cnvp_050 = sfsnap(:,:,J);
cnvp_050_ll=cube2latlon(xc,yc,cnvp_050,xi,yi);


rDir='/project/rg312/final_runs/run_050_final_tropheat/';
[sfsnap,iter,M]=rdmds([rDir,'sfsnapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhLscP'));
lscp_th = sfsnap(:,:,J);
lscp_th_ll=cube2latlon(xc,yc,lscp_th,xi,yi);
J=find(strcmp(fldList,'AtPhCnvP'));
cnvp_th = sfsnap(:,:,J);
cnvp_th_ll=cube2latlon(xc,yc,cnvp_th,xi,yi);


rDir='/project/rg312/final_runs/run_075_final/';
[sfsnap,iter,M]=rdmds([rDir,'sfsnapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhLscP'));
lscp_075 = sfsnap(:,:,J);
lscp_075_ll=cube2latlon(xc,yc,lscp_075,xi,yi);
J=find(strcmp(fldList,'AtPhCnvP'));
cnvp_075 = sfsnap(:,:,J);
cnvp_075_ll=cube2latlon(xc,yc,cnvp_075,xi,yi);


rDir='/project/rg312/final_runs/run_100_final/';
[sfsnap,iter,M]=rdmds([rDir,'sfsnapDiag'],nit100);  
eval(M);
J=find(strcmp(fldList,'AtPhLscP'));
lscp_100 = sfsnap(:,:,J);
lscp_100_ll=cube2latlon(xc,yc,lscp_100,xi,yi);
J=find(strcmp(fldList,'AtPhCnvP'));
cnvp_100 = sfsnap(:,:,J);
cnvp_100_ll=cube2latlon(xc,yc,cnvp_100,xi,yi);


rDir='/project/rg312/final_runs/run_125_final/';
[sfsnap,iter,M]=rdmds([rDir,'sfsnapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhLscP'));
lscp_125 = sfsnap(:,:,J);
lscp_125_ll=cube2latlon(xc,yc,lscp_125,xi,yi);
J=find(strcmp(fldList,'AtPhCnvP'));
cnvp_125 = sfsnap(:,:,J);
cnvp_125_ll=cube2latlon(xc,yc,cnvp_125,xi,yi);


rDir='/project/rg312/final_runs/run_150_final/';
[sfsnap,iter,M]=rdmds([rDir,'sfsnapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhLscP'));
lscp_150 = sfsnap(:,:,J);
lscp_150_ll=cube2latlon(xc,yc,lscp_150,xi,yi);
J=find(strcmp(fldList,'AtPhCnvP'));
cnvp_150 = sfsnap(:,:,J);
cnvp_150_ll=cube2latlon(xc,yc,cnvp_150,xi,yi);





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7.*2;                  %# A4 paper size
X = 21.*2;                  %# A4 paper size
yMargin = 0.75.*2;               %# left/right margins from page borders
xMargin = 1.*2;               %# bottom/top margins from page borders
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

myColorMap = flipud(bone); 
% Assign white (all 1's) to black (the first row in myColorMap).
%myColorMap(1, :) = [1 1 1];
colormap(myColorMap); % Apply the colormap 

v=0:1000:3000;
vp = 0:0.15e-4:3e-4;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi, cnvp_000_ll' + lscp_000_ll',vp);
set(h,'LineColor','none')
caxis([0 3e-4])
hold on
[C,h] = contour(xi, yi, ke_000_ll',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
ylabel('Latitude','FontSize',12)
title('0.0')
freezeColors
'000'

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi, cnvp_010_ll' + lscp_010_ll',vp);
set(h,'LineColor','none')
caxis([0 3e-4])
hold on
[C,h] = contour(xi, yi, ke_010_ll',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
title('0.1')
freezeColors
'010'

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi, cnvp_025_ll' + lscp_025_ll',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
hold on
[C,h] = contour(xi, yi, ke_025_ll',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
title('0.25')
freezeColors
'025'

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi, cnvp_050_ll' + lscp_050_ll',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
hold on
[C,h] = contour(xi, yi, ke_050_ll',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
ylabel('Latitude','FontSize',12)
title('0.5')
freezeColors
'050'

axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi, cnvp_th_ll' + lscp_th_ll',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
hold on
[C,h] = contour(xi, yi, ke_th_ll',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
title('tropheat')
freezeColors
'th'

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi, cnvp_075_ll' + lscp_075_ll',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
hold on
[C,h] = contour(xi, yi, ke_075_ll',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
title('0.75')
freezeColors
'075'

axes('position',[pos7x pos7y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi, cnvp_100_ll' + lscp_100_ll',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
hold on
[C,h] = contour(xi, yi, ke_100_ll',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
ylabel('Latitude','FontSize',12)
xlabel('Longitude','FontSize',12)
title('1.0')
freezeColors
'100'

axes('position',[pos8x pos8y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi, cnvp_125_ll' + lscp_125_ll',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
hold on
[C,h] = contour(xi, yi, ke_125_ll',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
xlabel('Longitude','FontSize',12)
title('1.25')
freezeColors
'125'

axes('position',[pos9x pos9y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi, cnvp_150_ll' + lscp_150_ll',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
hold on
[C,h] = contour(xi, yi, ke_150_ll',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
xlabel('Longitude','FontSize',12)
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
x = get(c,'Position');
x(1) = 0.87; x(2) = 0.59; x(3) = 0.015; x(4) = 0.3;
set(c,'Position',x);
set(gca, 'Position', originalSize);
title('1.5')
freezeColors
'150'

print('-dpdf','ke_precip.pdf')

