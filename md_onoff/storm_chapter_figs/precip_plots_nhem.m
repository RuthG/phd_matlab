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
J=find(strcmp(fldList,'AtPhConv'));
conv_010 = sfsnap(:,:,J);
conv_010_ll=cube2latlon(xc,yc,conv_010,xi,yi);

rDir='/project/rg312/final_runs/run_025_final/';
[sfsnap,iter,M]=rdmds([rDir,'sfsnapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhLscP'));
lscp_025 = sfsnap(:,:,J);
lscp_025_ll=cube2latlon(xc,yc,lscp_025,xi,yi);
J=find(strcmp(fldList,'AtPhCnvP'));
cnvp_025 = sfsnap(:,:,J);
cnvp_025_ll=cube2latlon(xc,yc,cnvp_025,xi,yi);
J=find(strcmp(fldList,'AtPhConv'));
conv_025 = sfsnap(:,:,J);
conv_025_ll=cube2latlon(xc,yc,conv_025,xi,yi);


rDir='/project/rg312/final_runs/run_050_final/';
[sfsnap,iter,M]=rdmds([rDir,'sfsnapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhLscP'));
lscp_050 = sfsnap(:,:,J);
lscp_050_ll=cube2latlon(xc,yc,lscp_050,xi,yi);
J=find(strcmp(fldList,'AtPhCnvP'));
cnvp_050 = sfsnap(:,:,J);
cnvp_050_ll=cube2latlon(xc,yc,cnvp_050,xi,yi);
J=find(strcmp(fldList,'AtPhConv'));
conv_050 = sfsnap(:,:,J);
conv_050_ll=cube2latlon(xc,yc,conv_050,xi,yi);


rDir='/project/rg312/final_runs/run_050_final_tropheat/';
[sfsnap,iter,M]=rdmds([rDir,'sfsnapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhLscP'));
lscp_th = sfsnap(:,:,J);
lscp_th_ll=cube2latlon(xc,yc,lscp_th,xi,yi);
J=find(strcmp(fldList,'AtPhCnvP'));
cnvp_th = sfsnap(:,:,J);
cnvp_th_ll=cube2latlon(xc,yc,cnvp_th,xi,yi);
J=find(strcmp(fldList,'AtPhConv'));
conv_th = sfsnap(:,:,J);
conv_th_ll=cube2latlon(xc,yc,conv_th,xi,yi);


rDir='/project/rg312/final_runs/run_075_final/';
[sfsnap,iter,M]=rdmds([rDir,'sfsnapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhLscP'));
lscp_075 = sfsnap(:,:,J);
lscp_075_ll=cube2latlon(xc,yc,lscp_075,xi,yi);
J=find(strcmp(fldList,'AtPhCnvP'));
cnvp_075 = sfsnap(:,:,J);
cnvp_075_ll=cube2latlon(xc,yc,cnvp_075,xi,yi);
J=find(strcmp(fldList,'AtPhConv'));
conv_075 = sfsnap(:,:,J);
conv_075_ll=cube2latlon(xc,yc,conv_075,xi,yi);


rDir='/project/rg312/final_runs/run_100_final/';
[sfsnap,iter,M]=rdmds([rDir,'sfsnapDiag'],nit100);  
eval(M);
J=find(strcmp(fldList,'AtPhLscP'));
lscp_100 = sfsnap(:,:,J);
lscp_100_ll=cube2latlon(xc,yc,lscp_100,xi,yi);
J=find(strcmp(fldList,'AtPhCnvP'));
cnvp_100 = sfsnap(:,:,J);
cnvp_100_ll=cube2latlon(xc,yc,cnvp_100,xi,yi);
J=find(strcmp(fldList,'AtPhConv'));
conv_100 = sfsnap(:,:,J);
conv_100_ll=cube2latlon(xc,yc,conv_100,xi,yi);
J=find(strcmp(fldList,'AtPhKlzb'));
klzb_100 = sfsnap(:,:,J);
klzb_100_ll=cube2latlon(xc,yc,klzb_100,xi,yi);

[snap,iter,M]=rdmds([rDir,'snapDiag'],nit100);  
eval(M);
J=find(strcmp(fldList,'AtPh_Trf'));
trf_100 = snap(:,:,:,J);
trf_100_ll=cube2latlon(xc,yc,trf_100,xi,yi);
J=find(strcmp(fldList,'AtPh_Qrf'));
qrf_100 = snap(:,:,:,J);
qrf_100_ll=cube2latlon(xc,yc,qrf_100,xi,yi);

rDir='/project/rg312/final_runs/run_125_final/';
[sfsnap,iter,M]=rdmds([rDir,'sfsnapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhLscP'));
lscp_125 = sfsnap(:,:,J);
lscp_125_ll=cube2latlon(xc,yc,lscp_125,xi,yi);
J=find(strcmp(fldList,'AtPhCnvP'));
cnvp_125 = sfsnap(:,:,J);
cnvp_125_ll=cube2latlon(xc,yc,cnvp_125,xi,yi);
J=find(strcmp(fldList,'AtPhConv'));
conv_125 = sfsnap(:,:,J);
conv_125_ll=cube2latlon(xc,yc,conv_125,xi,yi);


rDir='/project/rg312/final_runs/run_150_final/';
[sfsnap,iter,M]=rdmds([rDir,'sfsnapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhLscP'));
lscp_150 = sfsnap(:,:,J);
lscp_150_ll=cube2latlon(xc,yc,lscp_150,xi,yi);
J=find(strcmp(fldList,'AtPhCnvP'));
cnvp_150 = sfsnap(:,:,J);
cnvp_150_ll=cube2latlon(xc,yc,cnvp_150,xi,yi);
J=find(strcmp(fldList,'AtPhConv'));
conv_150 = sfsnap(:,:,J);
conv_150_ll=cube2latlon(xc,yc,conv_150,xi,yi);
J=find(strcmp(fldList,'AtPhKlzb'));
klzb_150 = sfsnap(:,:,J);
klzb_150_ll=cube2latlon(xc,yc,klzb_150,xi,yi);

[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPh_Trf'));
trf_150 = snap(:,:,:,J);
trf_150_ll=cube2latlon(xc,yc,trf_150,xi,yi);
J=find(strcmp(fldList,'AtPh_Qrf'));
qrf_150 = snap(:,:,:,J);
qrf_150_ll=cube2latlon(xc,yc,qrf_150,xi,yi);


load('/project/rg312/mat_files/snapshot_data_final/run_100/t_100_5.mat')
t_100_ll=cube2latlon(xc,yc,t_100(:,:,:,day100),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_150/t_150_5.mat')
t_150_ll=cube2latlon(xc,yc,t_150(:,:,:,day000),xi,yi);

load('/project/rg312/mat_files/snapshot_data_final/run_100/q_100_5.mat')
q_100_ll=cube2latlon(xc,yc,q_100(:,:,:,day100),xi,yi);
load('/project/rg312/mat_files/snapshot_data_final/run_150/q_150_5.mat')
q_150_ll=cube2latlon(xc,yc,q_150(:,:,:,day000),xi,yi);

figure
contourf(squeeze(t_150_ll(:,46,:)-trf_150_ll(:,46,:))') 
colorbar
figure
contourf(squeeze(t_100_ll(:,46,:)-trf_100_ll(:,46,:))')
colorbar





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21.;                  %# A4 paper size
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

v=0:1000:3000;
vp = 0:0.15e-4:3e-4;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), cnvp_000_ll(:,46:90)' + lscp_000_ll(:,46:90)',vp);
set(h,'LineColor','none')
caxis([0 3e-4])
%hold on
%[C,h] = contour(xi, yi(46:90), ke_000_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
ylabel('Latitude','FontSize',12)
title('dry')
xlim([-180 180])
ylim([1 89])
freezeColors
'000'

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), cnvp_010_ll(:,46:90)' + lscp_010_ll(:,46:90)',vp);
set(h,'LineColor','none')
caxis([0 3e-4])
%hold on
%[C,h] = contour(xi, yi(46:90), ke_010_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
title('010')
freezeColors
'010'

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), cnvp_025_ll(:,46:90)' + lscp_025_ll(:,46:90)',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
%hold on
%[C,h] = contour(xi, yi(46:90), ke_025_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
title('025')
freezeColors
'025'

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), cnvp_050_ll(:,46:90)' + lscp_050_ll(:,46:90)',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
%hold on
%[C,h] = contour(xi, yi(46:90), ke_050_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
ylabel('Latitude','FontSize',12)
title('050')
freezeColors
'050'

axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), cnvp_th_ll(:,46:90)' + lscp_th_ll(:,46:90)',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
%hold on
%[C,h] = contour(xi, yi(46:90), ke_th_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
title('tropheat')
freezeColors
'th'

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), cnvp_075_ll(:,46:90)' + lscp_075_ll(:,46:90)',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
%hold on
%[C,h] = contour(xi, yi(46:90), ke_075_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
title('075')
freezeColors
'075'

axes('position',[pos7x pos7y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), cnvp_100_ll(:,46:90)' + lscp_100_ll(:,46:90)',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
%hold on
%[C,h] = contour(xi, yi(46:90), ke_100_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
ylabel('Latitude','FontSize',12)
xlabel('Longitude','FontSize',12)
title('wet')
freezeColors
'100'

axes('position',[pos8x pos8y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), cnvp_125_ll(:,46:90)' + lscp_125_ll(:,46:90)',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
%hold on
%[C,h] = contour(xi, yi(46:90), ke_125_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
xlabel('Longitude','FontSize',12)
title('125')
freezeColors
'125'

axes('position',[pos9x pos9y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), cnvp_150_ll(:,46:90)' + lscp_150_ll(:,46:90)',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
%hold on
%[C,h] = contour(xi, yi(46:90), ke_150_ll(:,46:90)',v,'k');
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
'150'

print('-dpdf','precip_nhem.pdf')






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21.;                  %# A4 paper size
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

v=0:1000:3000;
vp = 0:0.15e-4:3e-4;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), cnvp_000_ll(:,46:90)',vp);
set(h,'LineColor','none')
caxis([0 3e-4])
%hold on
%[C,h] = contour(xi, yi(46:90), ke_000_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
ylabel('Latitude','FontSize',12)
title('dry')
xlim([-180 180])
ylim([1 89])
freezeColors
'000'

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), cnvp_010_ll(:,46:90)',vp);
set(h,'LineColor','none')
caxis([0 3e-4])
%hold on
%[C,h] = contour(xi, yi(46:90), ke_010_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
title('010')
freezeColors
'010'

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), cnvp_025_ll(:,46:90)',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
%hold on
%[C,h] = contour(xi, yi(46:90), ke_025_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
title('025')
freezeColors
'025'

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), cnvp_050_ll(:,46:90)',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
%hold on
%[C,h] = contour(xi, yi(46:90), ke_050_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
ylabel('Latitude','FontSize',12)
title('050')
freezeColors
'050'

axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), cnvp_th_ll(:,46:90)',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
%hold on
%[C,h] = contour(xi, yi(46:90), ke_th_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
title('tropheat')
freezeColors
'th'

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), cnvp_075_ll(:,46:90)',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
%hold on
%[C,h] = contour(xi, yi(46:90), ke_075_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
title('075')
freezeColors
'075'

axes('position',[pos7x pos7y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), cnvp_100_ll(:,46:90)',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
%hold on
%[C,h] = contour(xi, yi(46:90), ke_100_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
ylabel('Latitude','FontSize',12)
xlabel('Longitude','FontSize',12)
title('wet')
freezeColors
'100'

axes('position',[pos8x pos8y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), cnvp_125_ll(:,46:90)',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
%hold on
%[C,h] = contour(xi, yi(46:90), ke_125_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
xlabel('Longitude','FontSize',12)
title('125')
freezeColors
'125'

axes('position',[pos9x pos9y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), cnvp_150_ll(:,46:90)',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
%hold on
%[C,h] = contour(xi, yi(46:90), ke_150_ll(:,46:90)',v,'k');
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
'150'

print('-dpdf','cnv_precip_nhem.pdf')






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21.;                  %# A4 paper size
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

v=0:1000:3000;
vp = 0:0.15e-4:3e-4;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), lscp_000_ll(:,46:90)',vp);
set(h,'LineColor','none')
caxis([0 3e-4])
%hold on
%[C,h] = contour(xi, yi(46:90), ke_000_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
ylabel('Latitude','FontSize',12)
title('dry')
xlim([-180 180])
ylim([1 89])
freezeColors
'000'

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), lscp_010_ll(:,46:90)',vp);
set(h,'LineColor','none')
caxis([0 3e-4])
%hold on
%[C,h] = contour(xi, yi(46:90), ke_010_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
title('010')
freezeColors
'010'

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), lscp_025_ll(:,46:90)',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
%hold on
%[C,h] = contour(xi, yi(46:90), ke_025_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
title('025')
freezeColors
'025'

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), lscp_050_ll(:,46:90)',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
%hold on
%[C,h] = contour(xi, yi(46:90), ke_050_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
ylabel('Latitude','FontSize',12)
title('050')
freezeColors
'050'

axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), lscp_th_ll(:,46:90)',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
%hold on
%[C,h] = contour(xi, yi(46:90), ke_th_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
title('tropheat')
freezeColors
'th'

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), lscp_075_ll(:,46:90)',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
%hold on
%[C,h] = contour(xi, yi(46:90), ke_075_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
title('075')
freezeColors
'075'

axes('position',[pos7x pos7y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), lscp_100_ll(:,46:90)',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
%hold on
%[C,h] = contour(xi, yi(46:90), ke_100_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
ylabel('Latitude','FontSize',12)
xlabel('Longitude','FontSize',12)
title('wet')
freezeColors
'100'

axes('position',[pos8x pos8y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), lscp_125_ll(:,46:90)',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
%hold on
%[C,h] = contour(xi, yi(46:90), ke_125_ll(:,46:90)',v,'k');
%clabel(C,h);
set(gca,'FontSize',10)
xlabel('Longitude','FontSize',12)
title('125')
freezeColors
'125'

axes('position',[pos9x pos9y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi(46:90), lscp_150_ll(:,46:90)',vp);
caxis([0 3e-4])
set(h,'LineColor','none')
%hold on
%[C,h] = contour(xi, yi(46:90), ke_150_ll(:,46:90)',v,'k');
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
'150'

print('-dpdf','lsc_precip_nhem.pdf')

