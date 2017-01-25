%load up u and v for a snapshot for each experiment and plot quiver plots in jet


% choose directory, load grid
rDir='/project/rg312/final_runs/run_100_final/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
yi = -89:2:89; xi = -179:2:179;
nit = 903840;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%

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
[sfsnap,iter,M]=rdmds([rDir,'sfsnapDiag'],nit);  
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

v=0:0.05e-3:2e-3; 

load('MyColormaps.mat')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(xi, yi, cnvp_000_ll' + lscp_000_ll',v);
set(gca,'FontSize',10)
colormap(gca,mycmap)
set(h,'LineColor','none')
caxis([0 2e-3])
ylabel('Latitude','FontSize',12)
%set(gca,'XTickLabel',[]);
title('0.0')
freezeColors

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(xi, yi, cnvp_010_ll' + lscp_010_ll',v);
set(gca,'FontSize',10)
set(h,'LineColor','none')
colormap(gca,mycmap)
caxis([0 2e-3])
%set(gca,'XTickLabel',[]);
title('0.1')
freezeColors

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contourf(xi, yi, cnvp_025_ll' + lscp_025_ll',v);
set(gca,'FontSize',10)
set(h,'LineColor','none')
colormap(gca,mycmap)
caxis([0 2e-3])
%set(gca,'XTickLabel',[]);
title('0.25')
freezeColors

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contourf(xi, yi, cnvp_050_ll' + lscp_050_ll',v);
set(gca,'FontSize',10)
set(h,'LineColor','none')
colormap(gca,mycmap)
caxis([0 2e-3])
ylabel('Latitude','FontSize',12)
%set(gca,'XTickLabel',[]);
title('0.5')
freezeColors

axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contourf(xi, yi, cnvp_th_ll' + lscp_th_ll',v);
set(gca,'FontSize',10)
set(h,'LineColor','none')
colormap(gca,mycmap)
caxis([0 2e-3])
%set(gca,'XTickLabel',[]);
title('tropheat')
freezeColors

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contourf(xi, yi, cnvp_075_ll' + lscp_075_ll',v);
set(gca,'FontSize',10)
set(h,'LineColor','none')
colormap(gca,mycmap)
caxis([0 2e-3])
%set(gca,'XTickLabel',[]);
title('0.75')
freezeColors

axes('position',[pos7x pos7y xSize_sub ySize_sub])
[C,h] = contourf(xi, yi, cnvp_100_ll' + lscp_100_ll',v);
set(gca,'FontSize',10)
set(h,'LineColor','none')
colormap(gca,mycmap)
caxis([0 2e-3])
ylabel('Latitude','FontSize',12)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber','FontSize',12)
title('1.0')
freezeColors

axes('position',[pos8x pos8y xSize_sub ySize_sub])
[C,h] = contourf(xi, yi, cnvp_125_ll' + lscp_125_ll',v);
set(gca,'FontSize',10)
set(h,'LineColor','none')
colormap(gca,mycmap)
caxis([0 2e-3])
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber','FontSize',12)
title('1.25')
freezeColors

axes('position',[pos9x pos9y xSize_sub ySize_sub])
[C,h] = contourf(xi, yi, cnvp_150_ll' + lscp_150_ll',v);
set(gca,'FontSize',10)
set(h,'LineColor','none')
colormap(gca,mycmap)
caxis([0 2e-3])
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber','FontSize',12)
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
x = get(c,'Position');
x(1) = 0.87; x(2) = 0.59; x(3) = 0.015; x(4) = 0.3;
set(c,'Position',x);
set(gca, 'Position', originalSize);
title('1.5')
freezeColors




print('-dpdf','cnvlsc_precip.pdf')

