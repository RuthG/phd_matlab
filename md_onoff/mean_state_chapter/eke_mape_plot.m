load('/project/rg312/mat_files/chapter2_variables/eke_baroclinic_zone.mat')
load('/project/rg312/mat_files/chapter2_variables/mape_baroclinic_zone.mat')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 0*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.2625; 
xSize_sub = 0.6; 

pos1x = 0.1 ; 	pos1y = 0.7; 


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(mape_000./10^6, eke_out_000./10^6, 'ok')
set(gca,'FontSize',10)
hold on
plot(mape_010./10^6, eke_out_010./10^6, '+k')
plot(mape_025./10^6, eke_out_025./10^6, '*k')
plot(mape_050./10^6, eke_out_050./10^6, 'vk')
%plot(mape_th./10^6, eke_out_th./10^6, 'sk')
plot(mape_075./10^6, eke_out_075./10^6, 'dk')
plot(mape_100./10^6, eke_out_100./10^6, 'xk')
plot(mape_125./10^6, eke_out_125./10^6, '^k')
plot(mape_150./10^6, eke_out_150./10^6, 'pk')
legend('dry','010','025','050','075','100','125','150','Location','NorthWest')
xlabel('Mean available potential energy, MJm^{-2}','FontSize',12)
ylabel('Eddy kinetic energy, MJm^{-2}','FontSize',12)

print('-dpdf','eke_mape.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(0,eke_out_000./mape_000,'ok')
hold on
plot(0.1,eke_out_010./mape_010,'+k')
plot(0.25,eke_out_025./mape_025,'*k')
plot(0.5,eke_out_050./mape_050,'vk')
%plot(0.5,eke_out_th./mape_th,'sk')
plot(0.75,eke_out_075./mape_075,'dk')
plot(1.0,eke_out_100./mape_100,'xk')
plot(1.25,eke_out_125./mape_125,'^k')
plot(1.5,eke_out_150./mape_150,'pk')
xlabel('e_{s0} fraction','FontSize',12)
ylabel('Ratio of EKE/MAPE','FontSize',12)

print('-dpdf','eke_mape_ratio.pdf')
