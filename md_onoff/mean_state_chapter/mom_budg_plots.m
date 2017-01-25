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
yi = -89:2:89;
xi=-179:2:179;

load('/project/rg312/mat_files/chapter2_variables/mombudg_tav_000.mat','tauE')
tauE_ll=cube2latlon(xc,yc,tauE,xi,yi);
tau_mean_000 = sum(sum(tauE.*ar))./sum(sum(ar))
load('/project/rg312/mat_files/chapter2_variables/mombudg_tav_010.mat','tauE')
tauE_ll=cube2latlon(xc,yc,tauE,xi,yi);
tau_mean_010 = sum(sum(tauE.*ar))./sum(sum(ar))
load('/project/rg312/mat_files/chapter2_variables/mombudg_tav_025.mat','tauE')
tauE_ll=cube2latlon(xc,yc,tauE,xi,yi);
tau_mean_025 = sum(sum(tauE.*ar))./sum(sum(ar))
load('/project/rg312/mat_files/chapter2_variables/mombudg_tav_050.mat','tauE')
tauE_ll=cube2latlon(xc,yc,tauE,xi,yi);
tau_mean_050 = sum(sum(tauE.*ar))./sum(sum(ar))
load('/project/rg312/mat_files/chapter2_variables/mombudg_tav_075.mat','tauE')
tauE_ll=cube2latlon(xc,yc,tauE,xi,yi);
tau_mean_075 = sum(sum(tauE.*ar))./sum(sum(ar))
load('/project/rg312/mat_files/chapter2_variables/mombudg_tav_100.mat','tauE')
tauE_ll=cube2latlon(xc,yc,tauE,xi,yi);
tau_mean_100 = sum(sum(tauE.*ar))./sum(sum(ar))
load('/project/rg312/mat_files/chapter2_variables/mombudg_tav_125.mat','tauE')
tauE_ll=cube2latlon(xc,yc,tauE,xi,yi);
tau_mean_125 = sum(sum(tauE.*ar))./sum(sum(ar))
load('/project/rg312/mat_files/chapter2_variables/mombudg_tav_150.mat','tauE')
tauE_ll=cube2latlon(xc,yc,tauE,xi,yi);
tau_mean_150 = sum(sum(tauE.*ar))./sum(sum(ar))



load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_000.mat','C_total','C_zonal','C_eddy','tauE_hzav','fvN_vint')
C_total_000 = C_total;
C_zonal_000 = C_zonal;
C_eddy_000 = C_eddy;
tauE_hzav_000 = tauE_hzav;
fvN_vint_000 = fvN_vint;
C_total_000 = C_total_000 - fvN_vint_000;
C_zonal_000 = C_zonal_000 - fvN_vint_000;

load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_010.mat','C_total','C_zonal','C_eddy','tauE_hzav','fvN_vint')
C_total_010 = C_total;
C_zonal_010 = C_zonal;
C_eddy_010 = C_eddy;
tauE_hzav_010 = tauE_hzav;
fvN_vint_010 = fvN_vint;
C_total_010 = C_total_010 - fvN_vint_010;
C_zonal_010 = C_zonal_010 - fvN_vint_010;

load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_025.mat','C_total','C_zonal','C_eddy','tauE_hzav','fvN_vint')
C_total_025 = C_total;
C_zonal_025 = C_zonal;
C_eddy_025 = C_eddy;
tauE_hzav_025 = tauE_hzav;
fvN_vint_025 = fvN_vint;
C_total_025 = C_total_025 - fvN_vint_025;
C_zonal_025 = C_zonal_025 - fvN_vint_025;

load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_050.mat','C_total','C_zonal','C_eddy','tauE_hzav','fvN_vint')
C_total_050 = C_total;
C_zonal_050 = C_zonal;
C_eddy_050 = C_eddy;
tauE_hzav_050 = tauE_hzav;
fvN_vint_050 = fvN_vint;
C_total_050 = C_total_050 - fvN_vint_050;
C_zonal_050 = C_zonal_050 - fvN_vint_050;

load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_075.mat','C_total','C_zonal','C_eddy','tauE_hzav','fvN_vint')
C_total_075 = C_total;
C_zonal_075 = C_zonal;
C_eddy_075 = C_eddy;
tauE_hzav_075 = tauE_hzav;
fvN_vint_075 = fvN_vint;
C_total_075 = C_total_075 - fvN_vint_075;
C_zonal_075 = C_zonal_075 - fvN_vint_075;

load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_100.mat','C_total','C_zonal','C_eddy','tauE_hzav','fvN_vint')
C_total_100 = C_total;
C_zonal_100 = C_zonal;
C_eddy_100 = C_eddy;
tauE_hzav_100 = tauE_hzav;
fvN_vint_100 = fvN_vint;
C_total_100 = C_total_100 - fvN_vint_100;
C_zonal_100 = C_zonal_100 - fvN_vint_100;

load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_125.mat','C_total','C_zonal','C_eddy','tauE_hzav','fvN_vint')
C_total_125 = C_total;
C_zonal_125 = C_zonal;
C_eddy_125 = C_eddy;
tauE_hzav_125 = tauE_hzav;
fvN_vint_125 = fvN_vint;
C_total_125 = C_total_125 - fvN_vint_125;
C_zonal_125 = C_zonal_125 - fvN_vint_125;

load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_150.mat','C_total','C_zonal','C_eddy','tauE_hzav','fvN_vint')
C_total_150 = C_total;
C_zonal_150 = C_zonal;
C_eddy_150 = C_eddy;
tauE_hzav_150 = tauE_hzav;
fvN_vint_150 = fvN_vint;
C_total_150 = C_total_150 - fvN_vint_150;
C_zonal_150 = C_zonal_150 - fvN_vint_150;

load('/project/rg312/mat_files/chapter2_variables/cell_edge.mat')

yi=-89:2:89;


Y = 29.7;                  %# A4 paper size
X = 21;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 0*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.35; 
xSize_sub = 0.85; 

pos1x = 0.1 ; 	pos1y = 0.5; 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi(46:90),C_total_100+tauE_hzav_100','r','LineWidth',1.5)
set(gca,'FontSize',10)
hold on
plot(yi(46:90),C_total_100,'k','LineWidth',1.5)
plot(yi(46:90),C_zonal_100,'k-.','LineWidth',1.5)
plot(yi(46:90),C_eddy_100,'k--','LineWidth',1.5)
plot(yi(46:90),-tauE_hzav_100,'c','LineWidth',1.5)
%plot([term_lat_100, term_lat_100],[-0.25, 0.2],'k')
xlim([0 87])
ylim([-0.25 0.2])
xlabel('Latitude','FontSize',12)
ylabel('Mom. budg. terms, Nm^{-2}','FontSize',12)
hold off

print('-dpdf','mom_budg_100.pdf')



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
plot(yi(46:90),C_total_000+tauE_hzav_000','r','LineWidth',1.5)
set(gca,'FontSize',10)
hold on
plot(yi(46:90),C_total_000,'k','LineWidth',1.5)
plot(yi(46:90),C_zonal_000,'k-.','LineWidth',1.5)
plot(yi(46:90),C_eddy_000,'k--','LineWidth',1.5)
plot(yi(46:90),-tauE_hzav_000,'c','LineWidth',1.5)
%plot([term_lat_000, term_lat_000],[-0.25, 0.2],'k')
plot([yi(46), yi(90)],[-tau_mean_000, -tau_mean_000],'k--')
xlim([0 90])
ylim([-0.25 0.2])
ylabel('Mom. budg. terms, Nm^{-2}','FontSize',12)
title(['dry'],'FontSize',12)
%legend('C-total','C-zonal','C-eddy','Surface stress','Budget residual','location','SouthEast')
hold off

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi(46:90),C_total_010+tauE_hzav_010','r','LineWidth',1.5)
set(gca,'FontSize',10)
hold on
plot(yi(46:90),C_total_010,'k','LineWidth',1.5)
plot(yi(46:90),C_zonal_010,'k-.','LineWidth',1.5)
plot(yi(46:90),C_eddy_010,'k--','LineWidth',1.5)
plot(yi(46:90),-tauE_hzav_010,'c','LineWidth',1.5)
%plot([term_lat_010, term_lat_010],[-0.25, 0.2],'k')
plot([yi(46), yi(90)],[-tau_mean_010, -tau_mean_010],'k--')
xlim([0 90])
ylim([-0.25 0.2])
title(['010'],'FontSize',12)
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi(46:90),C_total_025+tauE_hzav_025','r','LineWidth',1.5)
set(gca,'FontSize',10)
hold on
plot(yi(46:90),C_total_025,'k','LineWidth',1.5)
plot(yi(46:90),C_zonal_025,'k-.','LineWidth',1.5)
plot(yi(46:90),C_eddy_025,'k--','LineWidth',1.5)
plot(yi(46:90),-tauE_hzav_025,'c','LineWidth',1.5)
%plot([term_lat_025, term_lat_025],[-0.25, 0.2],'k')
plot([yi(46), yi(90)],[-tau_mean_025, -tau_mean_025],'k--')
xlim([0 90])
ylim([-0.25 0.2])
title(['025'],'FontSize',12)
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(yi(46:90),C_total_050+tauE_hzav_050','r','LineWidth',1.5)
set(gca,'FontSize',10)
hold on
plot(yi(46:90),C_total_050,'k','LineWidth',1.5)
plot(yi(46:90),C_zonal_050,'k-.','LineWidth',1.5)
plot(yi(46:90),C_eddy_050,'k--','LineWidth',1.5)
plot(yi(46:90),-tauE_hzav_050,'c','LineWidth',1.5)
%plot([term_lat_050, term_lat_050],[-0.25, 0.2],'k')
plot([yi(46), yi(90)],[-tau_mean_050, -tau_mean_050],'k--')
xlim([0 90])
ylim([-0.25 0.2])
title(['050'],'FontSize',12)
hold off

axes('position',[pos5x pos5y xSize_sub ySize_sub])
plot(yi(46:90),C_total_075+tauE_hzav_075','r','LineWidth',1.5)
set(gca,'FontSize',10)
hold on
plot(yi(46:90),C_total_075,'k','LineWidth',1.5)
plot(yi(46:90),C_zonal_075,'k-.','LineWidth',1.5)
plot(yi(46:90),C_eddy_075,'k--','LineWidth',1.5)
plot(yi(46:90),-tauE_hzav_075,'c','LineWidth',1.5)
%plot([term_lat_075, term_lat_075],[-0.25, 0.2],'k')
plot([yi(46), yi(90)],[-tau_mean_075, -tau_mean_075],'k--')
xlim([0 90])
ylim([-0.25 0.2])
ylabel('Mom. budg. terms, Nm^{-2}','FontSize',12)
xlabel('Latitude','FontSize',12)
title(['075'],'FontSize',12)
hold off

axes('position',[pos6x pos6y xSize_sub ySize_sub])
plot(yi(46:90),C_total_100+tauE_hzav_100','r','LineWidth',1.5)
set(gca,'FontSize',10)
hold on
plot(yi(46:90),C_total_100,'k','LineWidth',1.5)
plot(yi(46:90),C_zonal_100,'k-.','LineWidth',1.5)
plot(yi(46:90),C_eddy_100,'k--','LineWidth',1.5)
plot(yi(46:90),-tauE_hzav_100,'c','LineWidth',1.5)
%plot([term_lat_100, term_lat_100],[-0.25, 0.2],'k')
plot([yi(46), yi(90)],[-tau_mean_100, -tau_mean_100],'k--')
xlim([0 90])
ylim([-0.25 0.2])
xlabel('Latitude','FontSize',12)
title(['wet'],'FontSize',12)
hold off

axes('position',[pos7x pos7y xSize_sub ySize_sub])
plot(yi(46:90),C_total_125+tauE_hzav_125','r','LineWidth',1.5)
set(gca,'FontSize',10)
hold on
plot(yi(46:90),C_total_125,'k','LineWidth',1.5)
plot(yi(46:90),C_zonal_125,'k-.','LineWidth',1.5)
plot(yi(46:90),C_eddy_125,'k--','LineWidth',1.5)
plot(yi(46:90),-tauE_hzav_125,'c','LineWidth',1.5)
%plot([term_lat_125, term_lat_125],[-0.25, 0.2],'k')
plot([yi(46), yi(90)],[-tau_mean_125, -tau_mean_125],'k--')
xlim([0 90])
ylim([-0.25 0.2])
xlabel('Latitude','FontSize',12)
title(['125'],'FontSize',12)
hold off


axes('position',[pos8x pos8y xSize_sub ySize_sub])
plot(yi(46:90),C_total_150+tauE_hzav_150','r','LineWidth',1.5)
set(gca,'FontSize',10)
hold on
plot(yi(46:90),C_total_150,'k','LineWidth',1.5)
plot(yi(46:90),C_zonal_150,'k-.','LineWidth',1.5)
plot(yi(46:90),C_eddy_150,'k--','LineWidth',1.5)
plot(yi(46:90),-tauE_hzav_150,'c','LineWidth',1.5)
%plot([term_lat_150, term_lat_150],[-0.25, 0.2],'k')
plot([yi(46), yi(90)],[-tau_mean_150, -tau_mean_150],'k--')
xlim([0 90])
ylim([-0.25 0.2])
xlabel('Latitude','FontSize',12)
title(['150'],'FontSize',12)
hold off


print('mom_budg.pdf','-dpdf')

