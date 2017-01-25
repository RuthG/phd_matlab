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

load(['/project/rg312/mat_files/storm_chapter_data/run_100/htrt_100_comp_' num2str(year) '.mat'])
htrt_comp_100(:,:,year) = nanmean(comp_data,3);
load(['/project/rg312/mat_files/storm_chapter_data/run_100/radht_100_comp_' num2str(year) '.mat'])
radht_comp_100(:,:,year) = nanmean(comp_data,3);
load(['/project/rg312/mat_files/storm_chapter_data/run_100/difht_100_comp_' num2str(year) '.mat'])
difht_comp_100(:,:,year) = nanmean(comp_data,3);
load(['/project/rg312/mat_files/storm_chapter_data/run_100/cnvht_100_comp_' num2str(year) '.mat'])
cnvht_comp_100(:,:,year) = nanmean(comp_data,3);
load(['/project/rg312/mat_files/storm_chapter_data/run_100/cndht_100_comp_' num2str(year) '.mat'])
cndht_comp_100(:,:,year) = nanmean(comp_data,3);

end

htrt_comp_100 = mean(htrt_comp_100,3);
radht_comp_100 = mean(radht_comp_100,3);
cndht_comp_100 = mean(cndht_comp_100,3);
cnvht_comp_100 = mean(cnvht_comp_100,3);
difht_comp_100 = mean(difht_comp_100,3);

x= -34:2:34;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Y = 29.7;                  %# A4 paper size
X = 21;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 0*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.15; 
xSize_sub = 0.17; 

pos1x = 0.07 ; 	pos1y = 0.77; 
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

%myColorMap = flipud(bone); 
% Assign white (all 1's) to black (the first row in myColorMap).
%myColorMap(1, :) = [1 1 1];
%colormap(myColorMap); % Apply the colormap 

vp=-4:0.5:6;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(x,rC./100, htrt_comp_100',vp);
colormap(b2r(-4,6));
hold on
%clabel(C,h);
set(gca,'FontSize',10,'YDir','reverse')
ylabel('Pressure, hPa','FontSize',12)
title('Total diabatic heating, K/day')
freezeColors
'000'


axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contourf(x, rC./100, cndht_comp_100',vp);
colormap(b2r(-4,6));
hold on
%clabel(C,h);
ylabel('Pressure, hPa','FontSize',12)
set(gca,'FontSize',10,'YDir','reverse')
xlabel('Longitude','FontSize',12)
title({'Large-scale condensation';'heating, K/day'})
%title('Large-scale condensation heating, K/day')
freezeColors
'th'

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contourf(x, rC./100, cnvht_comp_100',vp);
colormap(b2r(-4,6));
hold on
%clabel(C,h);
set(gca,'FontSize',10,'YDir','reverse')
xlabel('Longitude','FontSize',12)
title('Convective heating, K/day')
freezeColors
'075'

axes('position',[pos7x pos7y xSize_sub ySize_sub])
[C,h] = contourf(x, rC./100, difht_comp_100',vp);
colormap(b2r(-4,6));
hold on
%clabel(C,h);
set(gca,'FontSize',10,'YDir','reverse')
xlabel('Longitude','FontSize',12)
title('Diffusive heating, K/day')
freezeColors
'100'

axes('position',[pos8x pos8y xSize_sub ySize_sub])
[C,h] = contourf(x,rC./100, radht_comp_100',vp);
colormap(b2r(-4,6));
hold on
%clabel(C,h);
set(gca,'FontSize',10,'YDir','reverse')
xlabel('Longitude','FontSize',12)
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
xc = get(c,'Position');
xc(1) = 0.92; xc(2) = 0.59; xc(3) = 0.015; xc(4) = 0.3;
set(c,'Position',xc);
set(gca, 'Position', originalSize);
title('Radiative heating. K/day')
freezeColors
'150'

print('-dpdf','htrt_bits_comp.pdf')


