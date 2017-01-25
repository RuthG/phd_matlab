%load in data for line plots for 'paper' and make proper subplot versions

load('/project/rg312/mat_files/vNH_paper_plot_data_trop_final.mat')
load('/project/rg312/mat_files/vNt_paper_plot_data_trop_final.mat')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 25.0;                  %# A4 paper size
X = 32; % 20;                  %# A4 paper size
yMargin = 4;               %# left/right margins from page borders
xMargin = 4;               %# bottom/top margins from page borders
xSize = X - 2*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 2*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.35; %0.4;
xSize_sub = 0.35; %0.7;

pos1x = 0.2 ; 	pos1y = 0.6; 
pos2x = 0.2;	pos2y = 0.15; 


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


es0 = [0,0.1,0.25,0.5,0.75,1];
cp = 287.04./(2./7.);

filles0 = [es0, fliplr(es0)];
fillerrors = [vNt_ed.*cp+2.*vNt_ed_serr.*cp, fliplr(vNt_ed.*cp-2.*vNt_ed_serr.*cp)];
fillerrors_warm = [vNt_ed_warm.*cp+2.*vNt_ed_warm_serr.*cp, fliplr(vNt_ed_warm.*cp -2.*vNt_ed_warm_serr.*cp)];
fillerrors_cold = [vNt_ed_cold.*cp+2.*vNt_ed_cold_serr.*cp, fliplr(vNt_ed_cold.*cp -2.*vNt_ed_cold_serr.*cp)];

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(es0,vNt_ed.*cp,'k','Linewidth',2);
hold on
plot(es0,vNt_ed_warm.*cp,'r','Linewidth',2);
plot(es0,vNt_ed_cold.*cp,'b','Linewidth',2);
fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)
hold off
ylim([0.2e4 2.2e4])
text(0.90,2.1e4,'\bf \fontsize{15} (b)')
set(gca,'FontSize',15);
xlabel('Reference e_{s0} fraction')
ylabel('cp v''T'', Wm/kg ')



filles0 = [es0, fliplr(es0)];
fillerrors = [vNH_ed+2.*vNH_ed_serr, fliplr(vNH_ed-2.*vNH_ed_serr)];
fillerrors_warm = [vNH_ed_warm+2.*vNH_ed_warm_serr, fliplr(vNH_ed_warm -2.*vNH_ed_warm_serr)];
fillerrors_cold = [vNH_ed_cold+2.*vNH_ed_cold_serr, fliplr(vNH_ed_cold -2.*vNH_ed_cold_serr)];

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(es0,vNH_ed,'k','Linewidth',2);
hold on
plot(es0,vNH_ed_warm,'r','Linewidth',2);
plot(es0,vNH_ed_cold,'b','Linewidth',2);
fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)
hold off
ylim([0.2e4 2.2e4])
set(gca,'FontSize',15);
xlabel('Reference e_{s0} fraction')
ylabel('v''H'', Wm/kg ')
text(0.90,2.1e4,'\bf \fontsize{15} (a)')
legend({'Total','+ve T''','-ve T'''},'Location','northwest','FontSize',8)
legend boxoff

print('-depsc2','-r300','figure_1.eps')











load('/project/rg312/mat_files/tt_paper_plot_data_blayer_final.mat')





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 25.0;                  %# A4 paper size
X = 32;                  %# A4 paper size
yMargin = 4;               %# left/right margins from page borders
xMargin = 4;               %# bottom/top margins from page borders
xSize = X - 2*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 2*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.35; %0.4;
xSize_sub = 0.35;

pos1x = 0.15 ; 	pos1y = 0.6; 
pos2x = 0.6;	pos2y = 0.6; 
pos3x = 0.15 ; 	pos3y = 0.15; 
pos4x = 0.6;	pos4y = 0.15; 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


es0 = [0,0.1,0.25,0.5,0.75,1];

filles0 = [es0, fliplr(es0)];
fillerrors = [tt_ed+2.*tt_ed_serr, fliplr(tt_ed-2.*tt_ed_serr)];
fillerrors_warm = [tt_ed_warm+2.*tt_ed_warm_serr, fliplr(tt_ed_warm -2.*tt_ed_warm_serr)];
fillerrors_cold = [tt_ed_cold+2.*tt_ed_cold_serr, fliplr(tt_ed_cold -2.*tt_ed_cold_serr)];

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(es0,tt_ed,'k','Linewidth',2);
hold on
plot(es0,tt_ed_warm,'r','Linewidth',2);
plot(es0,tt_ed_cold,'b','Linewidth',2);
fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)
hold off
ylim([0 18])
text(0.90,17,'\bf \fontsize{15} (a)')
set(gca,'FontSize',15);
xlabel('Reference e_{s0} fraction')
ylabel('T''.^2, K^2')


load('/project/rg312/mat_files/tt_paper_plot_data_freetrop_final.mat')

filles0 = [es0, fliplr(es0)];
fillerrors = [vNH_ed+2.*vNH_ed_serr, fliplr(vNH_ed-2.*vNH_ed_serr)];
fillerrors_warm = [vNH_ed_warm+2.*vNH_ed_warm_serr, fliplr(vNH_ed_warm -2.*vNH_ed_warm_serr)];
fillerrors_cold = [vNH_ed_cold+2.*vNH_ed_cold_serr, fliplr(vNH_ed_cold -2.*vNH_ed_cold_serr)];

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(es0,tt_ed,'k','Linewidth',2);
hold on
plot(es0,tt_ed_warm,'r','Linewidth',2);
plot(es0,tt_ed_cold,'b','Linewidth',2);
fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)
hold off
ylim([0 18])
set(gca,'FontSize',15);
xlabel('Reference e_{s0} fraction')
ylabel('T''.^2, K^2')
text(0.90,17,'\bf \fontsize{15} (b)')
legend({'Total','+ve T''','-ve T'''},'Location','northwest','FontSize',8)
legend boxoff



load('/project/rg312/mat_files/vNt_paper_plot_data_blayer_final.mat')


filles0 = [es0, fliplr(es0)];
fillerrors = [vNt_ed+2.*vNt_ed_serr, fliplr(vNt_ed-2.*vNt_ed_serr)];
fillerrors_warm = [vNt_ed_warm+2.*vNt_ed_warm_serr, fliplr(vNt_ed_warm -2.*vNt_ed_warm_serr)];
fillerrors_cold = [vNt_ed_cold+2.*vNt_ed_cold_serr, fliplr(vNt_ed_cold -2.*vNt_ed_cold_serr)];

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(es0,vNt_ed,'k','Linewidth',2);
hold on
plot(es0,vNt_ed_warm,'r','Linewidth',2);
plot(es0,vNt_ed_cold,'b','Linewidth',2);
fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)
hold off
ylim([2 16])
text(0.90,15,'\bf \fontsize{15} (c)')
set(gca,'FontSize',15);
xlabel('Reference e_{s0} fraction')
ylabel('v''T'', Km/s ')

load('/project/rg312/mat_files/vNt_paper_plot_data_freetrop_final.mat')


filles0 = [es0, fliplr(es0)];
fillerrors = [vNt_ed+2.*vNt_ed_serr, fliplr(vNt_ed-2.*vNt_ed_serr)];
fillerrors_warm = [vNt_ed_warm+2.*vNt_ed_warm_serr, fliplr(vNt_ed_warm -2.*vNt_ed_warm_serr)];
fillerrors_cold = [vNt_ed_cold+2.*vNt_ed_cold_serr, fliplr(vNt_ed_cold -2.*vNt_ed_cold_serr)];

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(es0,vNt_ed,'k','Linewidth',2);
hold on
plot(es0,vNt_ed_warm,'r','Linewidth',2);
plot(es0,vNt_ed_cold,'b','Linewidth',2);
fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)
hold off
ylim([2 16])
text(0.90,15,'\bf \fontsize{15} (d)')
set(gca,'FontSize',15);
xlabel('Reference e_{s0} fraction')
ylabel('v''T'', Km/s ')




print('-depsc2','-r300','figure_3.eps')





