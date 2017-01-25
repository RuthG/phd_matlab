
%[ph_hist_full_000, ph_hist_midlats_000] = ph_hist_fun('000');
%'000'
%[ph_hist_full_010, ph_hist_midlats_010] = ph_hist_fun('010');
%'010'
%[ph_hist_full_025, ph_hist_midlats_025] = ph_hist_fun('025');
%'025'
%[ph_hist_full_050, ph_hist_midlats_050] = ph_hist_fun('050');
%'050'
%[ph_hist_full_th,  ph_hist_midlats_th]  = ph_hist_fun('th ');
%'th'
%[ph_hist_full_075, ph_hist_midlats_075] = ph_hist_fun('075');
%'075'
%[ph_hist_full_100, ph_hist_midlats_100] = ph_hist_fun('100');
%'100'
%[ph_hist_full_125, ph_hist_midlats_125] = ph_hist_fun('125');
%'125'
%[ph_hist_full_150, ph_hist_midlats_150] = ph_hist_fun('150');
%'150'

xbins = -400:4:400;

load('/project/rg312/mat_files/snapshot_data_final/ph_hists.mat')

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
load('/project/rg312/mat_files/vt_lats_final.mat')




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21;                  %# A4 paper size
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

axes('position',[pos1x pos1y xSize_sub ySize_sub])
h=bar(xbins,ph_hist_full_000,'k');
set(h,'EdgeColor','none')
set(gca,'FontSize',10)
ylabel('Frequency','FontSize',12)
xlim([-400 400])
ylim([0 0.12])
title('dry')
freezeColors

axes('position',[pos2x pos2y xSize_sub ySize_sub])
h=bar(xbins,ph_hist_full_010,'k');
set(h,'EdgeColor','none')
set(gca,'FontSize',10)
xlim([-400 400])
ylim([0 0.12])
title('010')
freezeColors

axes('position',[pos3x pos3y xSize_sub ySize_sub])
h=bar(xbins,ph_hist_full_025,'k');
set(h,'EdgeColor','none')
set(gca,'FontSize',10)
xlim([-400 400])
ylim([0 0.12])
title('025')
freezeColors

axes('position',[pos4x pos4y xSize_sub ySize_sub])
h=bar(xbins,ph_hist_full_050,'k');
set(h,'EdgeColor','none')
set(gca,'FontSize',10)
ylabel('Frequency','FontSize',12)
xlim([-400 400])
ylim([0 0.12])
title('050')
freezeColors

axes('position',[pos5x pos5y xSize_sub ySize_sub])
h=bar(xbins,ph_hist_full_th,'k');
set(h,'EdgeColor','none')
set(gca,'FontSize',10)
xlim([-400 400])
ylim([0 0.12])
title('tropheat')
freezeColors

axes('position',[pos6x pos6y xSize_sub ySize_sub])
h=bar(xbins,ph_hist_full_075,'k');
set(h,'EdgeColor','none')
set(gca,'FontSize',10)
xlim([-400 400])
ylim([0 0.12])
title('075')
freezeColors

axes('position',[pos7x pos7y xSize_sub ySize_sub])
h=bar(xbins,ph_hist_full_100,'k');
set(h,'EdgeColor','none')
set(gca,'FontSize',10)
ylabel('Frequency','FontSize',12)
%xlabel('Eddy geopotential height, m','FontSize',12)
xlim([-400 400])
ylim([0 0.12])
title('wet')
freezeColors

axes('position',[pos8x pos8y xSize_sub ySize_sub])
h=bar(xbins,ph_hist_full_125,'k');
set(h,'EdgeColor','none')
set(gca,'FontSize',10)
xlabel('Eddy geopotential height, m','FontSize',12)
xlim([-400 400])
ylim([0 0.12])
title('125')
freezeColors

axes('position',[pos9x pos9y xSize_sub ySize_sub])
h=bar(xbins,ph_hist_full_150,'k');
set(h,'EdgeColor','none')
set(gca,'FontSize',10)
%xlabel('Eddy geopotential height, m','FontSize',12)
xlim([-400 400])
ylim([0 0.12])
title('150')
freezeColors

print('-dpdf','phpdf.pdf')





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

axes('position',[pos1x pos1y xSize_sub ySize_sub])
h=bar(xbins,ph_hist_midlats_000,'k');
set(h,'EdgeColor','none')
set(gca,'FontSize',10)
ylabel('Frequency','FontSize',12)
xlim([-400 400])
ylim([0 0.04])
title('dry')
freezeColors

axes('position',[pos2x pos2y xSize_sub ySize_sub])
h=bar(xbins,ph_hist_midlats_010,'k');
set(h,'EdgeColor','none')
set(gca,'FontSize',10)
xlim([-400 400])
ylim([0 0.04])
title('010')
freezeColors

axes('position',[pos3x pos3y xSize_sub ySize_sub])
h=bar(xbins,ph_hist_midlats_025,'k');
set(h,'EdgeColor','none')
set(gca,'FontSize',10)
xlim([-400 400])
ylim([0 0.04])
title('025')
freezeColors

axes('position',[pos4x pos4y xSize_sub ySize_sub])
h=bar(xbins,ph_hist_midlats_050,'k');
set(h,'EdgeColor','none')
set(gca,'FontSize',10)
ylabel('Frequency','FontSize',12)
xlim([-400 400])
ylim([0 0.04])
title('050')
freezeColors

axes('position',[pos5x pos5y xSize_sub ySize_sub])
h=bar(xbins,ph_hist_midlats_th,'k');
set(h,'EdgeColor','none')
set(gca,'FontSize',10)
xlim([-400 400])
ylim([0 0.04])
title('tropheat')
freezeColors

axes('position',[pos6x pos6y xSize_sub ySize_sub])
h=bar(xbins,ph_hist_midlats_075,'k');
set(h,'EdgeColor','none')
set(gca,'FontSize',10)
xlim([-400 400])
ylim([0 0.04])
title('075')
freezeColors

axes('position',[pos7x pos7y xSize_sub ySize_sub])
h=bar(xbins,ph_hist_midlats_100,'k');
set(h,'EdgeColor','none')
set(gca,'FontSize',10)
ylabel('Frequency','FontSize',12)
xlabel('Eddy geopotential height, m','FontSize',12)
xlim([-400 400])
ylim([0 0.04])
title('wet')
freezeColors

axes('position',[pos8x pos8y xSize_sub ySize_sub])
h=bar(xbins,ph_hist_midlats_125,'k');
set(h,'EdgeColor','none')
set(gca,'FontSize',10)
xlabel('Eddy geopotential height, m','FontSize',12)
xlim([-400 400])
ylim([0 0.04])
title('125')
freezeColors

axes('position',[pos9x pos9y xSize_sub ySize_sub])
h=bar(xbins,ph_hist_midlats_150,'k');
set(h,'EdgeColor','none')
set(gca,'FontSize',10)
xlabel('Eddy geopotential height, m','FontSize',12)
xlim([-400 400])
ylim([0 0.04])
title('150')
freezeColors

print('-dpdf','phpdf_midlats.pdf')
