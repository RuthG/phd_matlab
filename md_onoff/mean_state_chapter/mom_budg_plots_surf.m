load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_000.mat','C_total_surf','C_zonal_surf','C_eddy_surf','tauE_hzav','fvN_vint_surf')
C_total_000 = C_total_surf;
C_zonal_000 = C_zonal_surf;
C_eddy_000 = C_eddy_surf;
tauE_hzav_000 = tauE_hzav;
fvN_vint_surf_000 = fvN_vint_surf;

load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_010.mat','C_total_surf','C_zonal_surf','C_eddy_surf','tauE_hzav','fvN_vint_surf')
C_total_010 = C_total_surf;
C_zonal_010 = C_zonal_surf;
C_eddy_010 = C_eddy_surf;
tauE_hzav_010 = tauE_hzav;
fvN_vint_surf_010 = fvN_vint_surf;

load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_025.mat','C_total_surf','C_zonal_surf','C_eddy_surf','tauE_hzav','fvN_vint_surf')
C_total_025 = C_total_surf;
C_zonal_025 = C_zonal_surf;
C_eddy_025 = C_eddy_surf;
tauE_hzav_025 = tauE_hzav;
fvN_vint_surf_025 = fvN_vint_surf;

load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_050.mat','C_total_surf','C_zonal_surf','C_eddy_surf','tauE_hzav','fvN_vint_surf')
C_total_050 = C_total_surf;
C_zonal_050 = C_zonal_surf;
C_eddy_050 = C_eddy_surf;
tauE_hzav_050 = tauE_hzav;
fvN_vint_surf_050 = fvN_vint_surf;

load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_075.mat','C_total_surf','C_zonal_surf','C_eddy_surf','tauE_hzav','fvN_vint_surf')
C_total_075 = C_total_surf;
C_zonal_075 = C_zonal_surf;
C_eddy_075 = C_eddy_surf;
tauE_hzav_075 = tauE_hzav;
fvN_vint_surf_075 = fvN_vint_surf;

load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_100.mat','C_total_surf','C_zonal_surf','C_eddy_surf','tauE_hzav','fvN_vint_surf')
C_total_100 = C_total_surf;
C_zonal_100 = C_zonal_surf;
C_eddy_100 = C_eddy_surf;
tauE_hzav_100 = tauE_hzav;
fvN_vint_surf_100 = fvN_vint_surf;

load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_125.mat','C_total_surf','C_zonal_surf','C_eddy_surf','tauE_hzav','fvN_vint_surf')
C_total_125 = C_total_surf;
C_zonal_125 = C_zonal_surf;
C_eddy_125 = C_eddy_surf;
tauE_hzav_125 = tauE_hzav;
fvN_vint_surf_125 = fvN_vint_surf;

load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_150.mat','C_total_surf','C_zonal_surf','C_eddy_surf','tauE_hzav','fvN_vint_surf')
C_total_150 = C_total_surf;
C_zonal_150 = C_zonal_surf;
C_eddy_150 = C_eddy_surf;
tauE_hzav_150 = tauE_hzav;
fvN_vint_surf_150 = fvN_vint_surf;


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
plot(yi(46:90),C_total_000,'k')
set(gca,'FontSize',10)
hold on
plot(yi(46:90),C_zonal_000,'k:')
plot(yi(46:90),C_eddy_000,'k--')
plot(yi(46:90),fvN_vint_surf_000,'b')
plot(yi(46:90),-tauE_hzav_000,'k-.')
xlim([0 90])
ylim([-0.25 0.2])
ylabel('Mom. budg. terms, Nm^{-2}','FontSize',12)
title(['0.0'],'FontSize',12)
%legend('C-total','C-zonal','C-eddy','Surface stress','Budget residual','location','SouthEast')
hold off

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi(46:90),C_total_010,'k')
set(gca,'FontSize',10)
hold on
plot(yi(46:90),C_zonal_010,'k:')
plot(yi(46:90),C_eddy_010,'k--')
plot(yi(46:90),fvN_vint_surf_010,'b')
plot(yi(46:90),-tauE_hzav_010,'k-.')
xlim([0 90])
ylim([-0.25 0.2])
title(['0.1'],'FontSize',12)
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi(46:90),C_total_025,'k')
set(gca,'FontSize',10)
hold on
plot(yi(46:90),C_zonal_025,'k:')
plot(yi(46:90),C_eddy_025,'k--')
plot(yi(46:90),fvN_vint_surf_025,'b')
plot(yi(46:90),-tauE_hzav_025,'k-.')
xlim([0 90])
ylim([-0.25 0.2])
title(['0.25'],'FontSize',12)
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(yi(46:90),C_total_050,'k')
set(gca,'FontSize',10)
hold on
plot(yi(46:90),C_zonal_050,'k:')
plot(yi(46:90),C_eddy_050,'k--')
plot(yi(46:90),fvN_vint_surf_050,'b')
plot(yi(46:90),-tauE_hzav_050,'k-.')
xlim([0 90])
ylim([-0.25 0.2])
title(['0.5'],'FontSize',12)
hold off

axes('position',[pos5x pos5y xSize_sub ySize_sub])
plot(yi(46:90),C_total_075,'k')
set(gca,'FontSize',10)
hold on
plot(yi(46:90),C_zonal_075,'k:')
plot(yi(46:90),C_eddy_075,'k--')
plot(yi(46:90),fvN_vint_surf_075,'b')
plot(yi(46:90),-tauE_hzav_075,'k-.')
xlim([0 90])
ylim([-0.25 0.2])
ylabel('Mom. budg. terms, Nm^{-2}','FontSize',12)
xlabel('Latitude','FontSize',12)
title(['0.75'],'FontSize',12)
hold off

axes('position',[pos6x pos6y xSize_sub ySize_sub])
plot(yi(46:90),C_total_100,'k')
set(gca,'FontSize',10)
hold on
plot(yi(46:90),C_zonal_100,'k:')
plot(yi(46:90),C_eddy_100,'k--')
plot(yi(46:90),fvN_vint_surf_100,'b')
plot(yi(46:90),-tauE_hzav_100,'k-.')
xlim([0 90])
ylim([-0.25 0.2])
xlabel('Latitude','FontSize',12)
title(['1.0'],'FontSize',12)
hold off

axes('position',[pos7x pos7y xSize_sub ySize_sub])
plot(yi(46:90),C_total_125,'k')
set(gca,'FontSize',10)
hold on
plot(yi(46:90),C_zonal_125,'k:')
plot(yi(46:90),C_eddy_125,'k--')
plot(yi(46:90),fvN_vint_surf_125,'b')
plot(yi(46:90),-tauE_hzav_125,'k-.')
xlim([0 90])
ylim([-0.25 0.2])
xlabel('Latitude','FontSize',12)
title(['1.25'],'FontSize',12)
hold off


axes('position',[pos8x pos8y xSize_sub ySize_sub])
plot(yi(46:90),C_total_150,'k')
set(gca,'FontSize',10)
hold on
plot(yi(46:90),C_zonal_150,'k:')
plot(yi(46:90),C_eddy_150,'k--')
plot(yi(46:90),fvN_vint_surf_150,'b')
plot(yi(46:90),-tauE_hzav_150,'k-.')
xlim([0 90])
ylim([-0.25 0.2])
xlabel('Latitude','FontSize',12)
title(['1.5'],'FontSize',12)
hold off


print('mom_budg_surf.pdf','-dpdf')

