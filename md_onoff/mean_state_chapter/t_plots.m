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

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_000.mat','theta_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_000(:,:) = mean(theta_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_010.mat','theta_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_010(:,:) = mean(theta_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_025.mat','theta_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_025(:,:) = mean(theta_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050.mat','theta_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_050(:,:) = mean(theta_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_075.mat','theta_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_075(:,:) = mean(theta_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_100.mat','theta_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_100(:,:) = mean(theta_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_125.mat','theta_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_125(:,:) = mean(theta_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_150.mat','theta_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_150(:,:) = mean(theta_ll,1);

for i=1:45
theta_hzav_000(i,:) = (theta_zav_000(i+45,:) + theta_zav_000(46-i,:))./2;
theta_hzav_010(i,:) = (theta_zav_010(i+45,:) + theta_zav_010(46-i,:))./2;
theta_hzav_025(i,:) = (theta_zav_025(i+45,:) + theta_zav_025(46-i,:))./2;
theta_hzav_050(i,:) = (theta_zav_050(i+45,:) + theta_zav_050(46-i,:))./2;
theta_hzav_075(i,:) = (theta_zav_075(i+45,:) + theta_zav_075(46-i,:))./2;
theta_hzav_100(i,:) = (theta_zav_100(i+45,:) + theta_zav_100(46-i,:))./2;
theta_hzav_125(i,:) = (theta_zav_125(i+45,:) + theta_zav_125(46-i,:))./2;
theta_hzav_150(i,:) = (theta_zav_150(i+45,:) + theta_zav_150(46-i,:))./2;
end

convthetatoT=(rC/100000.0).^(2./7.);
for j=1:size(rC)
theta_hzav_000(:,j)=theta_hzav_000(:,j).*convthetatoT(j,1);
theta_hzav_010(:,j)=theta_hzav_010(:,j).*convthetatoT(j,1);
theta_hzav_025(:,j)=theta_hzav_025(:,j).*convthetatoT(j,1);
theta_hzav_050(:,j)=theta_hzav_050(:,j).*convthetatoT(j,1);
theta_hzav_075(:,j)=theta_hzav_075(:,j).*convthetatoT(j,1);
theta_hzav_100(:,j)=theta_hzav_100(:,j).*convthetatoT(j,1);
theta_hzav_125(:,j)=theta_hzav_125(:,j).*convthetatoT(j,1);
theta_hzav_150(:,j)=theta_hzav_150(:,j).*convthetatoT(j,1);
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

v=150:10:700;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),rC./100,theta_hzav_000',v,'k');
clabel(C,h,'FontSize',10)
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
title('0.0')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),rC./100,theta_hzav_010',v,'k');
clabel(C,h,'FontSize',10)
set(gca,'YDir','reverse','FontSize',10)
title('0.1')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),rC./100,theta_hzav_025',v,'k');
clabel(C,h,'FontSize',10)
set(gca,'YDir','reverse','FontSize',10)
title('0.25')


axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),rC./100,theta_hzav_050',v,'k');
clabel(C,h,'FontSize',10)
set(gca,'YDir','reverse','FontSize',10)
title('0.5')


axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),rC./100,theta_hzav_075',v,'k');
clabel(C,h,'FontSize',10)
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
title('0.75')

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),rC./100,theta_hzav_100',v,'k');
clabel(C,h,'FontSize',10)
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
title('1.0')


axes('position',[pos7x pos7y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),rC./100,theta_hzav_125',v,'k');
clabel(C,h,'FontSize',10)
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
title('1.25')

axes('position',[pos8x pos8y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),rC./100,theta_hzav_150',v,'k');
clabel(C,h,'FontSize',10)
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
title('1.5')


print('-dpdf','t.pdf')

