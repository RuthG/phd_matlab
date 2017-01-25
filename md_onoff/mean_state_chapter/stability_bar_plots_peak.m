
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

pos1x = 0.07 ; 	pos1y = 0.75; 
pos2x = 0.29 ; 	pos2y = 0.75; 
pos3x = 0.51 ; 	pos3y = 0.75; 
pos4x = 0.73 ; 	pos4y = 0.75; 
pos5x = 0.07 ; 	pos5y = 0.55; 
pos6x = 0.29 ; 	pos6y = 0.55; 
pos7x = 0.51 ; 	pos7y = 0.55; 
pos8x = 0.73 ; 	pos8y = 0.55; 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/stab_hist_data_000.mat')
axes('position',[pos1x pos1y xSize_sub ySize_sub])
bar(xbins,stab_hist_data_midlatstight./sum(stab_hist_data_midlatstight),'k','EdgeColor','none');
set(gca,'FontSize',10)
xlim([-10 5])
ylim([0 0.2])
ylabel('Probability','FontSize',12)
title('0.0')

load('/project/rg312/mat_files/snapshot_data_final/run_010/stab_hist_data_010.mat')
axes('position',[pos2x pos2y xSize_sub ySize_sub])
bar(xbins,stab_hist_data_midlatstight./sum(stab_hist_data_midlatstight),'k','EdgeColor','none');
set(gca,'FontSize',10)
xlim([-10 5])
ylim([0 0.2])
title('0.1')

load('/project/rg312/mat_files/snapshot_data_final/run_025/stab_hist_data_025.mat')
axes('position',[pos3x pos3y xSize_sub ySize_sub])
bar(xbins,stab_hist_data_midlatstight./sum(stab_hist_data_midlatstight),'k','EdgeColor','none');
set(gca,'FontSize',10)
xlim([-10 5])
ylim([0 0.2])
title('0.25')

load('/project/rg312/mat_files/snapshot_data_final/run_050/stab_hist_data_050.mat')
axes('position',[pos4x pos4y xSize_sub ySize_sub])
bar(xbins,stab_hist_data_midlatstight./sum(stab_hist_data_midlatstight),'k','EdgeColor','none');
set(gca,'FontSize',10)
xlim([-10 5])
ylim([0 0.2])
title('0.5')

load('/project/rg312/mat_files/snapshot_data_final/run_075/stab_hist_data_075.mat')
axes('position',[pos5x pos5y xSize_sub ySize_sub])
bar(xbins,stab_hist_data_midlatstight./sum(stab_hist_data_midlatstight),'k','EdgeColor','none');
set(gca,'FontSize',10)
xlabel('dT/dz - \Gamma_{s}, K/km','FontSize',12)
ylabel('Probability','FontSize',12)
xlim([-10 5])
ylim([0 0.2])
title('0.75')

load('/project/rg312/mat_files/snapshot_data_final/run_100/stab_hist_data_100.mat')
axes('position',[pos6x pos6y xSize_sub ySize_sub])
bar(xbins,stab_hist_data_midlatstight./sum(stab_hist_data_midlatstight),'k','EdgeColor','none');
set(gca,'FontSize',10)
xlabel('dT/dz - \Gamma_{s}, K/km','FontSize',12)
xlim([-10 5])
ylim([0 0.2])
title('1.0')

load('/project/rg312/mat_files/snapshot_data_final/run_125/stab_hist_data_125.mat')
axes('position',[pos7x pos7y xSize_sub ySize_sub])
bar(xbins,stab_hist_data_midlatstight./sum(stab_hist_data_midlatstight),'k','EdgeColor','none');
set(gca,'FontSize',10)
xlabel('dT/dz - \Gamma_{s}, K/km','FontSize',12)
xlim([-10 5])
ylim([0 0.2])
title('1.25')

load('/project/rg312/mat_files/snapshot_data_final/run_150/stab_hist_data_150.mat')
axes('position',[pos8x pos8y xSize_sub ySize_sub])
bar(xbins,stab_hist_data_midlatstight./sum(stab_hist_data_midlatstight),'k','EdgeColor','none');
set(gca,'FontSize',10)
xlabel('dT/dz - \Gamma_{s}, K/km','FontSize',12)
xlim([-10 5])
ylim([0 0.2])
title('1.5')


print('-dpdf','stability_bar_peak.pdf')


