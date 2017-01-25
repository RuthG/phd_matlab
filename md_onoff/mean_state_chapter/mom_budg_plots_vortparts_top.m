load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_000.mat','zeta3v_zon_vint_top','zeta2w_vint_top','zeta3v_ed_vint_top','zeta2w_ed_vint_top')
zeta3v_zon_vint_top_000 = zeta3v_zon_vint_top;
zeta2w_vint_top_000 = zeta2w_vint_top;
zeta3v_ed_vint_top_000 = zeta3v_ed_vint_top;
zeta2w_ed_vint_top_000 = zeta2w_ed_vint_top;

load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_010.mat','zeta3v_zon_vint_top','zeta2w_vint_top','zeta3v_ed_vint_top','zeta2w_ed_vint_top')
zeta3v_zon_vint_top_010 = zeta3v_zon_vint_top;
zeta2w_vint_top_010 = zeta2w_vint_top;
zeta3v_ed_vint_top_010 = zeta3v_ed_vint_top;
zeta2w_ed_vint_top_010 = zeta2w_ed_vint_top;

load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_025.mat','zeta3v_zon_vint_top','zeta2w_vint_top','zeta3v_ed_vint_top','zeta2w_ed_vint_top')
zeta3v_zon_vint_top_025 = zeta3v_zon_vint_top;
zeta2w_vint_top_025 = zeta2w_vint_top;
zeta3v_ed_vint_top_025 = zeta3v_ed_vint_top;
zeta2w_ed_vint_top_025 = zeta2w_ed_vint_top;

load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_050.mat','zeta3v_zon_vint_top','zeta2w_vint_top','zeta3v_ed_vint_top','zeta2w_ed_vint_top')
zeta3v_zon_vint_top_050 = zeta3v_zon_vint_top;
zeta2w_vint_top_050 = zeta2w_vint_top;
zeta3v_ed_vint_top_050 = zeta3v_ed_vint_top;
zeta2w_ed_vint_top_050 = zeta2w_ed_vint_top;

load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_075.mat','zeta3v_zon_vint_top','zeta2w_vint_top','zeta3v_ed_vint_top','zeta2w_ed_vint_top')
zeta3v_zon_vint_top_075 = zeta3v_zon_vint_top;
zeta2w_vint_top_075 = zeta2w_vint_top;
zeta3v_ed_vint_top_075 = zeta3v_ed_vint_top;
zeta2w_ed_vint_top_075 = zeta2w_ed_vint_top;

load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_100.mat','zeta3v_zon_vint_top','zeta2w_vint_top','zeta3v_ed_vint_top','zeta2w_ed_vint_top')
zeta3v_zon_vint_top_100 = zeta3v_zon_vint_top;
zeta2w_vint_top_100 = zeta2w_vint_top;
zeta3v_ed_vint_top_100 = zeta3v_ed_vint_top;
zeta2w_ed_vint_top_100 = zeta2w_ed_vint_top;

load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_125.mat','zeta3v_zon_vint_top','zeta2w_vint_top','zeta3v_ed_vint_top','zeta2w_ed_vint_top')
zeta3v_zon_vint_top_125 = zeta3v_zon_vint_top;
zeta2w_vint_top_125 = zeta2w_vint_top;
zeta3v_ed_vint_top_125 = zeta3v_ed_vint_top;
zeta2w_ed_vint_top_125 = zeta2w_ed_vint_top;

load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_150.mat','zeta3v_zon_vint_top','zeta2w_vint_top','zeta3v_ed_vint_top','zeta2w_ed_vint_top')
zeta3v_zon_vint_top_150 = zeta3v_zon_vint_top;
zeta2w_vint_top_150 = zeta2w_vint_top;
zeta3v_ed_vint_top_150 = zeta3v_ed_vint_top;
zeta2w_ed_vint_top_150 = zeta2w_ed_vint_top;




load('/project/rg312/mat_files/chapter2_variables/cell_edge.mat')

yi=-89:2:89;

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

pos1x = 0.09 ; 	pos1y = 0.75; 
pos2x = 0.31 ; 	pos2y = 0.75; 
pos3x = 0.53 ; 	pos3y = 0.75; 
pos4x = 0.75 ; 	pos4y = 0.75; 
pos5x = 0.09 ; 	pos5y = 0.55; 
pos6x = 0.31 ; 	pos6y = 0.55; 
pos7x = 0.53 ; 	pos7y = 0.55; 
pos8x = 0.75 ; 	pos8y = 0.55; 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
set(gca,'FontSize',10)
hold on
plot(yi(46:90),zeta3v_zon_vint_top_000,'k','LineWidth',1.5)
plot(yi(46:90),zeta2w_vint_top_000,'k-.','LineWidth',1.5)
plot(yi(46:90),zeta3v_ed_vint_top_000,'k--','LineWidth',1.5)
plot(yi(46:90),zeta2w_ed_vint_top_000,'c','LineWidth',1.5)
plot([term_lat_000, term_lat_000],[-0.75, 0.5],'k')
xlim([0 90])
ylim([-0.75 0.5])
ylabel('Mom. budg. terms, Nm^{-2}','FontSize',12)
title(['0.0'],'FontSize',12)
%legend('C-total','C-zonal','C-eddy','Surface stress','Budget residual','location','SouthEast')
hold off

axes('position',[pos2x pos2y xSize_sub ySize_sub])
set(gca,'FontSize',10)
hold on
plot(yi(46:90),zeta3v_zon_vint_top_010,'k','LineWidth',1.5)
plot(yi(46:90),zeta2w_vint_top_010,'k-.','LineWidth',1.5)
plot(yi(46:90),zeta3v_ed_vint_top_010,'k--','LineWidth',1.5)
plot(yi(46:90),zeta2w_ed_vint_top_010,'c','LineWidth',1.5)
plot([term_lat_010, term_lat_010],[-0.75, 0.5],'k')
xlim([0 90])
ylim([-0.75 0.5])
title(['0.1'],'FontSize',12)
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
set(gca,'FontSize',10)
hold on
plot(yi(46:90),zeta3v_zon_vint_top_025,'k','LineWidth',1.5)
plot(yi(46:90),zeta2w_vint_top_025,'k-.','LineWidth',1.5)
plot(yi(46:90),zeta3v_ed_vint_top_025,'k--','LineWidth',1.5)
plot(yi(46:90),zeta2w_ed_vint_top_025,'c','LineWidth',1.5)
plot([term_lat_025, term_lat_025],[-0.75, 0.5],'k')
xlim([0 90])
ylim([-0.75 0.5])
title(['0.25'],'FontSize',12)
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
set(gca,'FontSize',10)
hold on
plot(yi(46:90),zeta3v_zon_vint_top_050,'k','LineWidth',1.5)
plot(yi(46:90),zeta2w_vint_top_050,'k-.','LineWidth',1.5)
plot(yi(46:90),zeta3v_ed_vint_top_050,'k--','LineWidth',1.5)
plot(yi(46:90),zeta2w_ed_vint_top_050,'c','LineWidth',1.5)
plot([term_lat_050, term_lat_050],[-0.75, 0.5],'k')
xlim([0 90])
ylim([-0.75 0.5])
title(['0.5'],'FontSize',12)
hold off

axes('position',[pos5x pos5y xSize_sub ySize_sub])
set(gca,'FontSize',10)
hold on
plot(yi(46:90),zeta3v_zon_vint_top_075,'k','LineWidth',1.5)
plot(yi(46:90),zeta2w_vint_top_075,'k-.','LineWidth',1.5)
plot(yi(46:90),zeta3v_ed_vint_top_075,'k--','LineWidth',1.5)
plot(yi(46:90),zeta2w_ed_vint_top_075,'c','LineWidth',1.5)
plot([term_lat_075, term_lat_075],[-0.75, 0.5],'k')
xlim([0 90])
ylim([-0.75 0.5])
ylabel('Mom. budg. terms, Nm^{-2}','FontSize',12)
xlabel('Latitude','FontSize',12)
title(['0.75'],'FontSize',12)
hold off

axes('position',[pos6x pos6y xSize_sub ySize_sub])
set(gca,'FontSize',10)
hold on
plot(yi(46:90),zeta3v_zon_vint_top_100,'k','LineWidth',1.5)
plot(yi(46:90),zeta2w_vint_top_100,'k-.','LineWidth',1.5)
plot(yi(46:90),zeta3v_ed_vint_top_100,'k--','LineWidth',1.5)
plot(yi(46:90),zeta2w_ed_vint_top_100,'c','LineWidth',1.5)
plot([term_lat_100, term_lat_100],[-0.75, 0.5],'k')
xlim([0 90])
ylim([-0.75 0.5])
xlabel('Latitude','FontSize',12)
title(['1.0'],'FontSize',12)
hold off

axes('position',[pos7x pos7y xSize_sub ySize_sub])
set(gca,'FontSize',10)
hold on
plot(yi(46:90),zeta3v_zon_vint_top_125,'k','LineWidth',1.5)
plot(yi(46:90),zeta2w_vint_top_125,'k-.','LineWidth',1.5)
plot(yi(46:90),zeta3v_ed_vint_top_125,'k--','LineWidth',1.5)
plot(yi(46:90),zeta2w_ed_vint_top_125,'c','LineWidth',1.5)
plot([term_lat_125, term_lat_125],[-0.75, 0.5],'k')
xlim([0 90])
ylim([-0.75 0.5])
xlabel('Latitude','FontSize',12)
title(['1.25'],'FontSize',12)
hold off


axes('position',[pos8x pos8y xSize_sub ySize_sub])
set(gca,'FontSize',10)
hold on
plot(yi(46:90),zeta3v_zon_vint_top_150,'k','LineWidth',1.5)
plot(yi(46:90),zeta2w_vint_top_150,'k-.','LineWidth',1.5)
plot(yi(46:90),zeta3v_ed_vint_top_150,'k--','LineWidth',1.5)
plot(yi(46:90),zeta2w_ed_vint_top_150,'c','LineWidth',1.5)
plot([term_lat_150, term_lat_150],[-0.75, 0.5],'k')
xlim([0 90])
ylim([-0.75 0.5])
xlabel('Latitude','FontSize',12)
title(['1.5'],'FontSize',12)
hold off


print('mom_budg_vortparts_top.pdf','-dpdf')

