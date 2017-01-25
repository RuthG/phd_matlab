%load up KE and calculate rhines scale

load('/project/rg312/mat_files/chapter2_variables/rhines_scale.mat')
load('/project/rg312/mat_files/chapter2_variables/rossby_scale.mat')
load('/project/rg312/mat_files/chapter2_variables/fft_000.mat')
load('/project/rg312/mat_files/chapter2_variables/fft_010.mat')
load('/project/rg312/mat_files/chapter2_variables/fft_025.mat')
load('/project/rg312/mat_files/chapter2_variables/fft_050.mat')
load('/project/rg312/mat_files/chapter2_variables/fft_th.mat')
load('/project/rg312/mat_files/chapter2_variables/fft_075.mat')
load('/project/rg312/mat_files/chapter2_variables/fft_100.mat')
load('/project/rg312/mat_files/chapter2_variables/fft_125.mat')
load('/project/rg312/mat_files/chapter2_variables/fft_150.mat')
load('/project/rg312/mat_files/chapter2_variables/jet_peaks.mat', 'y_000', 'y_010', 'y_025', 'y_050', 'y_th', 'y_075', 'y_100', 'y_125', 'y_150')

yi = -89:2:89;


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

v=0:1:7; 

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_000_ss_hzav(1:21,:)',v);
hold on
plot(kd_000(46:90),yi(46:90),'Color',[1 0 1],'LineWidth',2)
plot(kbeta_000(46:90),yi(46:90),'Color',[1 1 1],'LineWidth',2)
plot([0 20],[y_000 y_000],'--','Color',[1 1 1],'LineWidth',2)
set(h,'LineColor','none')
set(gca,'FontSize',10)
caxis([0 7])
ylabel('Latitude','FontSize',12)
%set(gca,'XTickLabel',[]);
title('dry')
freezeColors

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_010_ss_hzav(1:21,:)',v);
hold on
plot(kd_010(46:90),yi(46:90),'Color',[1 0 1],'LineWidth',2)
plot(kbeta_010(46:90),yi(46:90),'Color',[1 1 1],'LineWidth',2)
plot([0 20],[y_010 y_010],'--','Color',[1 1 1],'LineWidth',2)
set(h,'LineColor','none')
set(gca,'FontSize',10)
caxis([0 7])
%set(gca,'XTickLabel',[]);
title('010')
freezeColors

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_025_ss_hzav(1:21,:)',v);
hold on
plot(kd_025(46:90),yi(46:90),'Color',[1 0 1],'LineWidth',2)
plot(kbeta_025(46:90),yi(46:90),'Color',[1 1 1],'LineWidth',2)
plot([0 20],[y_025 y_025],'--','Color',[1 1 1],'LineWidth',2)
set(h,'LineColor','none')
set(gca,'FontSize',10)
caxis([0 7])
%set(gca,'XTickLabel',[]);
title('025')
freezeColors

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_050_ss_hzav(1:21,:)',v);
hold on
plot(kd_050(46:90),yi(46:90),'Color',[1 0 1],'LineWidth',2)
plot(kbeta_050(46:90),yi(46:90),'Color',[1 1 1],'LineWidth',2)
plot([0 20],[y_050 y_050],'--','Color',[1 1 1],'LineWidth',2)
set(h,'LineColor','none')
set(gca,'FontSize',10)
caxis([0 7])
ylabel('Latitude','FontSize',12)
%set(gca,'XTickLabel',[]);
title('050')
freezeColors

axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_th_ss_hzav(1:21,:)',v);
hold on
plot(kd_th(46:90),yi(46:90),'Color',[1 0 1],'LineWidth',2)
plot(kbeta_th(46:90),yi(46:90),'Color',[1 1 1],'LineWidth',2)
plot([0 20],[y_th y_th],'--','Color',[1 1 1],'LineWidth',2)
set(h,'LineColor','none')
set(gca,'FontSize',10)
caxis([0 7])
%set(gca,'XTickLabel',[]);
title('tropheat')
freezeColors

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_075_ss_hzav(1:21,:)',v);
hold on
plot(kd_075(46:90),yi(46:90),'Color',[1 0 1],'LineWidth',2)
plot(kbeta_075(46:90),yi(46:90),'Color',[1 1 1],'LineWidth',2)
plot([0 20],[y_075 y_075],'--','Color',[1 1 1],'LineWidth',2)
set(h,'LineColor','none')
set(gca,'FontSize',10)
caxis([0 7])
%set(gca,'XTickLabel',[]);
title('075')
freezeColors

axes('position',[pos7x pos7y xSize_sub ySize_sub])
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_100_ss_hzav(1:21,:)',v);
hold on
plot(kd_100(46:90),yi(46:90),'Color',[1 0 1],'LineWidth',2)
plot(kbeta_100(46:90),yi(46:90),'Color',[1 1 1],'LineWidth',2)
plot([0 20],[y_100 y_100],'--','Color',[1 1 1],'LineWidth',2)
set(h,'LineColor','none')
set(gca,'FontSize',10)
caxis([0 7])
ylabel('Latitude','FontSize',12)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber','FontSize',12)
title('wet')
freezeColors

axes('position',[pos8x pos8y xSize_sub ySize_sub])
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_125_ss_hzav(1:21,:)',v);
hold on
plot(kd_125(46:90),yi(46:90),'Color',[1 0 1],'LineWidth',2)
plot(kbeta_125(46:90),yi(46:90),'Color',[1 1 1],'LineWidth',2)
plot([0 20],[y_125 y_125],'--','Color',[1 1 1],'LineWidth',2)
set(h,'LineColor','none')
set(gca,'FontSize',10)
caxis([0 7])
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber','FontSize',12)
title('125')
freezeColors

axes('position',[pos9x pos9y xSize_sub ySize_sub])
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_150_ss_hzav(1:21,:)',v);
hold on
plot(kd_150(46:90),yi(46:90),'Color',[1 0 1],'LineWidth',2)
plot(kbeta_150(46:90),yi(46:90),'Color',[1 1 1],'LineWidth',2)
plot([0 20],[y_150 y_150],'--','Color',[1 1 1],'LineWidth',2)
set(h,'LineColor','none')
set(gca,'FontSize',10)
caxis([0 7])
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber','FontSize',12)
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
ylabel(c,'Variance, m^2/s^{2}')
x = get(c,'Position');
x(1) = 0.87; x(2) = 0.59; x(3) = 0.015; x(4) = 0.3;
set(c,'Position',x);
set(gca, 'Position', originalSize);
title('150')
freezeColors




print('-dpdf','fft.pdf')

