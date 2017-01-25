%create histograms of T' and htrt' from low level data for 000 and 100 run in storm track region
%hope to hell they show the right thing

load('/net/spat-nas/project/rg312/mat_files/snapshot_data_final/tv_histograms.mat')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 24; %25.0;                  %# A4 paper size
X =  16; %32; % 20;                  %# A4 paper size
yMargin = 0;               %# left/right margins from page borders
xMargin = 0;               %# bottom/top margins from page borders
xSize = X - 2*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 2*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.35 ; %0.35; %0.4;
xSize_sub = 0.8 ; %0.35; %0.7;

pos1x = 0.15 ; 	pos1y = 0.6; 
pos2x = 0.15;	pos2y = 0.15; 


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
%set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
h_000=bar(xbins_t,t_hist_000_5_norm,'r');
hold on;
h_100=bar(xbins_t,t_hist_100_5_norm);
alpha(get(h_000,'children'),.5);
alpha(get(h_100,'children'),.25);
set(h_000,'EdgeColor','none')
%set(h_100,'EdgeColor','none')
%ylim([0 0.15])
xlim([-10 10])
set(gca,'FontSize',15);
xlabel('T'', K','FontSize',18)
ylabel('Probability','FontSize',18)
%legend('Dry','Wet')

print('-dpdf','histt.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
%set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
h_000=bar(xbins_v,v_hist_000_5_norm,'r');
hold on;
h_100=bar(xbins_v,v_hist_100_5_norm);
alpha(get(h_000,'children'),.5);
alpha(get(h_100,'children'),.25);
set(h_000,'EdgeColor','none')
%set(h_100,'EdgeColor','none')
%ylim([0 0.15])
xlim([-25 25])
set(gca,'FontSize',15);
xlabel('v'', m/s','FontSize',18)
ylabel('Probability','FontSize',18)
%legend('Dry','Wet')


print('-dpdf','histv.pdf')


