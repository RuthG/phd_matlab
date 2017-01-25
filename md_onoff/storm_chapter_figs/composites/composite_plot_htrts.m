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
xi = -179:2:179;

L = 2.500e6;
cp = 287.04./(2./7.);

for year=1:10;
year

load(['/project/rg312/mat_files/storm_chapter_data/run_000/htrt_000_comp_' num2str(year) '.mat'])
htrt_comp_000(:,:,year) = nanmean(comp_data,3);
load(['/project/rg312/mat_files/storm_chapter_data/run_000/t_ed_000_comp_' num2str(year) '.mat'])
t_ed_comp_000(:,:,year) = nanmean(comp_data,3);

load(['/project/rg312/mat_files/storm_chapter_data/run_010/htrt_010_comp_' num2str(year) '.mat'])
htrt_comp_010(:,:,year) = nanmean(comp_data,3);
load(['/project/rg312/mat_files/storm_chapter_data/run_010/t_ed_010_comp_' num2str(year) '.mat'])
t_ed_comp_010(:,:,year) = nanmean(comp_data,3);

load(['/project/rg312/mat_files/storm_chapter_data/run_025/htrt_025_comp_' num2str(year) '.mat'])
htrt_comp_025(:,:,year) = nanmean(comp_data,3);
load(['/project/rg312/mat_files/storm_chapter_data/run_025/t_ed_025_comp_' num2str(year) '.mat'])
t_ed_comp_025(:,:,year) = nanmean(comp_data,3);

load(['/project/rg312/mat_files/storm_chapter_data/run_050/htrt_050_comp_' num2str(year) '.mat'])
htrt_comp_050(:,:,year) = nanmean(comp_data,3);
load(['/project/rg312/mat_files/storm_chapter_data/run_050/t_ed_050_comp_' num2str(year) '.mat'])
t_ed_comp_050(:,:,year) = nanmean(comp_data,3);

load(['/project/rg312/mat_files/storm_chapter_data/run_th/htrt_th_comp_' num2str(year) '.mat'])
htrt_comp_th(:,:,year) = nanmean(comp_data,3);
load(['/project/rg312/mat_files/storm_chapter_data/run_th/t_ed_th_comp_' num2str(year) '.mat'])
t_ed_comp_th(:,:,year) = nanmean(comp_data,3);

load(['/project/rg312/mat_files/storm_chapter_data/run_075/htrt_075_comp_' num2str(year) '.mat'])
htrt_comp_075(:,:,year) = nanmean(comp_data,3);
load(['/project/rg312/mat_files/storm_chapter_data/run_075/t_ed_075_comp_' num2str(year) '.mat'])
t_ed_comp_075(:,:,year) = nanmean(comp_data,3);

load(['/project/rg312/mat_files/storm_chapter_data/run_100/htrt_100_comp_' num2str(year) '.mat'])
htrt_comp_100(:,:,year) = nanmean(comp_data,3);
load(['/project/rg312/mat_files/storm_chapter_data/run_100/t_ed_100_comp_' num2str(year) '.mat'])
t_ed_comp_100(:,:,year) = nanmean(comp_data,3);

load(['/project/rg312/mat_files/storm_chapter_data/run_125/htrt_125_comp_' num2str(year) '.mat'])
htrt_comp_125(:,:,year) = nanmean(comp_data,3);
load(['/project/rg312/mat_files/storm_chapter_data/run_125/t_ed_125_comp_' num2str(year) '.mat'])
t_ed_comp_125(:,:,year) = nanmean(comp_data,3);

load(['/project/rg312/mat_files/storm_chapter_data/run_150/htrt_150_comp_' num2str(year) '.mat'])
htrt_comp_150(:,:,year) = nanmean(comp_data,3);
load(['/project/rg312/mat_files/storm_chapter_data/run_150/t_ed_150_comp_' num2str(year) '.mat'])
t_ed_comp_150(:,:,year) = nanmean(comp_data,3);

end

htrt_comp_000 = mean(htrt_comp_000,3);
t_ed_comp_000 = mean(t_ed_comp_000,3);
htrt_comp_010 = mean(htrt_comp_010,3);
t_ed_comp_010 = mean(t_ed_comp_010,3);
htrt_comp_025 = mean(htrt_comp_025,3);
t_ed_comp_025 = mean(t_ed_comp_025,3);
htrt_comp_050 = mean(htrt_comp_050,3);
t_ed_comp_050 = mean(t_ed_comp_050,3);
htrt_comp_075 = mean(htrt_comp_075,3);
t_ed_comp_075 = mean(t_ed_comp_075,3);
htrt_comp_100 = mean(htrt_comp_100,3);
t_ed_comp_100 = mean(t_ed_comp_100,3);
htrt_comp_125 = mean(htrt_comp_125,3);
t_ed_comp_125 = mean(t_ed_comp_125,3);
htrt_comp_150 = mean(htrt_comp_150,3);
t_ed_comp_150 = mean(t_ed_comp_150,3);
htrt_comp_th = mean(htrt_comp_th,3);
t_ed_comp_th = mean(t_ed_comp_th,3);

x= -34:2:34;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21.;                  %# A4 paper size
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

vp=-5:0.5:5;
v = -4:1:5;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(x,rC./100, htrt_comp_000',vp);
set(h,'LineColor','none')
colormap(b2r(-5,5));
hold on
[C,h] = contour(x,rC./100,htrt_comp_000',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(x, rC./100, t_ed_comp_000',v,'k');
clabel(C,h);
set(gca,'FontSize',10,'YDir','reverse')
ylabel('Pressure, hPa','FontSize',12)
title('dry')
freezeColors
'000'

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(x, rC./100, htrt_comp_010',vp);
set(h,'LineColor','none')
colormap(b2r(-5,5));
hold on
[C,h] = contour(x,rC./100,htrt_comp_010',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(x, rC./100, t_ed_comp_010',v,'k');
clabel(C,h);
set(gca,'FontSize',10,'YDir','reverse')
title('010')
freezeColors
'010'

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contourf(x, rC./100, htrt_comp_025',vp);
colormap(b2r(-5,5));
set(h,'LineColor','none')
hold on
[C,h] = contour(x,rC./100,htrt_comp_025',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(x, rC./100, t_ed_comp_025',v,'k');
clabel(C,h);
set(gca,'FontSize',10,'YDir','reverse')
title('025')
freezeColors
'025'

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contourf(x, rC./100, htrt_comp_050',vp);
colormap(b2r(-5,5));
set(h,'LineColor','none')
hold on
[C,h] = contour(x,rC./100,htrt_comp_050',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(x, rC./100, t_ed_comp_050',v,'k');
clabel(C,h);
set(gca,'FontSize',10,'YDir','reverse')
ylabel('Pressure, hPa','FontSize',12)
title('050')
freezeColors
'050'

axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contourf(x, rC./100, htrt_comp_th',vp);
colormap(b2r(-5,5));
set(h,'LineColor','none')
hold on
[C,h] = contour(x,rC./100,htrt_comp_th',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(x, rC./100, t_ed_comp_th',v,'k');
clabel(C,h);
set(gca,'FontSize',10,'YDir','reverse')
title('tropheat')
freezeColors
'th'

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contourf(x, rC./100, htrt_comp_075',vp);
colormap(b2r(-5,5));
set(h,'LineColor','none')
hold on
[C,h] = contour(x,rC./100,htrt_comp_075',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(x, rC./100, t_ed_comp_075',v,'k');
clabel(C,h);
set(gca,'FontSize',10,'YDir','reverse')
title('075')
freezeColors
'075'

axes('position',[pos7x pos7y xSize_sub ySize_sub])
[C,h] = contourf(x, rC./100, htrt_comp_100',vp);
colormap(b2r(-5,5));
set(h,'LineColor','none')
hold on
[C,h] = contour(x,rC./100,htrt_comp_100',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(x, rC./100, t_ed_comp_100',v,'k');
clabel(C,h);
set(gca,'FontSize',10,'YDir','reverse')
ylabel('Pressure, hPa','FontSize',12)
xlabel('Longitude','FontSize',12)
title('wet')
freezeColors
'100'

axes('position',[pos8x pos8y xSize_sub ySize_sub])
[C,h] = contourf(x,rC./100, htrt_comp_125',vp);
colormap(b2r(-5,5));
set(h,'LineColor','none')
hold on
[C,h] = contour(x,rC./100,htrt_comp_125',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(x, rC./100, t_ed_comp_125',v,'k');
clabel(C,h);
set(gca,'FontSize',10,'YDir','reverse')
xlabel('Longitude','FontSize',12)
title('125')
freezeColors
'125'

axes('position',[pos9x pos9y xSize_sub ySize_sub])
[C,h] = contourf(x,rC./100, htrt_comp_150',vp);
colormap(b2r(-5,5));
set(h,'LineColor','none')
hold on
[C,h] = contour(x, rC./100,htrt_comp_150',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(x, rC./100, t_ed_comp_150',v,'k');
clabel(C,h);
set(gca,'FontSize',10,'YDir','reverse')
xlabel('Longitude','FontSize',12)
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
xc = get(c,'Position');
xc(1) = 0.87; xc(2) = 0.59; xc(3) = 0.015; xc(4) = 0.3;
set(c,'Position',xc);
set(gca, 'Position', originalSize);
title('150')
freezeColors
'150'

print('-dpdf','htrt_t_comp.pdf')


