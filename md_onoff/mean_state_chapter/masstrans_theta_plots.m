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

load('/project/rg312/mat_files/chapter2_variables/psi_theta_000.mat','psi_mean')
psi_mean_000 = psi_mean;
load('/project/rg312/mat_files/chapter2_variables/psi_theta_010.mat','psi_mean')
psi_mean_010 = psi_mean;
load('/project/rg312/mat_files/chapter2_variables/psi_theta_025.mat','psi_mean')
psi_mean_025 = psi_mean;
load('/project/rg312/mat_files/chapter2_variables/psi_theta_050.mat','psi_mean')
psi_mean_050 = psi_mean;
load('/project/rg312/mat_files/chapter2_variables/psi_theta_075.mat','psi_mean')
psi_mean_075 = psi_mean;
load('/project/rg312/mat_files/chapter2_variables/psi_theta_100.mat','psi_mean')
psi_mean_100 = psi_mean;
load('/project/rg312/mat_files/chapter2_variables/psi_theta_125.mat','psi_mean')
psi_mean_125 = psi_mean;
load('/project/rg312/mat_files/chapter2_variables/psi_theta_150.mat','psi_mean')
psi_mean_150 = psi_mean;

for i=1:45
psi_hzav_000(i,:) = (-psi_mean_000(i+45,:) + psi_mean_000(46-i,:))./2;
psi_hzav_010(i,:) = (-psi_mean_010(i+45,:) + psi_mean_010(46-i,:))./2;
psi_hzav_025(i,:) = (-psi_mean_025(i+45,:) + psi_mean_025(46-i,:))./2;
psi_hzav_050(i,:) = (-psi_mean_050(i+45,:) + psi_mean_050(46-i,:))./2;
psi_hzav_075(i,:) = (-psi_mean_075(i+45,:) + psi_mean_075(46-i,:))./2;
psi_hzav_100(i,:) = (-psi_mean_100(i+45,:) + psi_mean_100(46-i,:))./2;
psi_hzav_125(i,:) = (-psi_mean_125(i+45,:) + psi_mean_125(46-i,:))./2;
psi_hzav_150(i,:) = (-psi_mean_150(i+45,:) + psi_mean_150(46-i,:))./2;
end

layers=100;
mintheta = 265;
maxtheta=400.;
spacing=single((maxtheta-mintheta)/layers);
theta_layers=mintheta+spacing*(0:layers-1)+spacing/2.;	%centre of theta layers


yy=yi*pi/180;
sst=sin(1.5*yy); sst=1.-sst.*sst; 
sst(find(abs(yi) > 60.))=0.;
sst=273.15+27*sst;

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

v=(0.5e11:0.5e11:2.5e11)./1e9;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),theta_layers,psi_hzav_000'./1e9,v,'k');
hold on
plot(yi,sst,'r');
clabel(C,h,'FontSize',10)
set(gca,'FontSize',10)
ylabel('Potential Temperature, K','FontSize',12)
title('dry','FontSize',12)

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),theta_layers,psi_hzav_010'./1e9,v,'k');
hold on
plot(yi,sst,'r');
clabel(C,h,'FontSize',10)
set(gca,'FontSize',10)
title('010','FontSize',12)

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),theta_layers,psi_hzav_025'./1e9,v,'k');
hold on
plot(yi,sst,'r');
clabel(C,h,'FontSize',10)
set(gca,'FontSize',10)
title('025','FontSize',12)


axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),theta_layers,psi_hzav_050'./1e9,v,'k');
hold on
plot(yi,sst,'r');
clabel(C,h,'FontSize',10)
set(gca,'FontSize',10)
title('050','FontSize',12)


axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),theta_layers,psi_hzav_075'./1e9,v,'k');
hold on
plot(yi,sst,'r');
clabel(C,h,'FontSize',10)
set(gca,'FontSize',10)
ylabel('Potential Temperature, K','FontSize',12)
xlabel('Latitude','FontSize',12)
title('075','FontSize',12)

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),theta_layers,psi_hzav_100'./1e9,v,'k');
hold on
plot(yi,sst,'r');
clabel(C,h,'FontSize',10)
set(gca,'FontSize',10)
xlabel('Latitude','FontSize',12)
title('wet','FontSize',12)


axes('position',[pos7x pos7y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),theta_layers,psi_hzav_125'./1e9,v,'k');
hold on
plot(yi,sst,'r');
clabel(C,h,'FontSize',10)
set(gca,'FontSize',10)
xlabel('Latitude','FontSize',12)
title('125','FontSize',12)

axes('position',[pos8x pos8y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),theta_layers,psi_hzav_150'./1e9,v,'k');
hold on
plot(yi,sst,'r');
clabel(C,h,'FontSize',10)
set(gca,'FontSize',10)
xlabel('Latitude','FontSize',12)
title('150','FontSize',12)


print('-dpdf','psi_theta.pdf')


