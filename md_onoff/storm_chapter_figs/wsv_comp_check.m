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

rC = (98000:-4000:2000)';
rC_half = (100000:-4000:0)';

for year=1:10;
year

load(['/project/rg312/mat_files/storm_chapter_data/run_000/wsv_000_comp_' num2str(year) '.mat'])
v_fb_comp_000(:,:,year) = nanmean(comp_data,3);

load(['/project/rg312/mat_files/storm_chapter_data/run_010/wsv_010_comp_' num2str(year) '.mat'])
v_fb_comp_010(:,:,year) = nanmean(comp_data,3);

load(['/project/rg312/mat_files/storm_chapter_data/run_025/wsv_025_comp_' num2str(year) '.mat'])
v_fb_comp_025(:,:,year) = nanmean(comp_data,3);

load(['/project/rg312/mat_files/storm_chapter_data/run_050/wsv_050_comp_' num2str(year) '.mat'])
v_fb_comp_050(:,:,year) = nanmean(comp_data,3);

load(['/project/rg312/mat_files/storm_chapter_data/run_th/wsv_th_comp_' num2str(year) '.mat'])
v_fb_comp_th(:,:,year) = nanmean(comp_data,3);

load(['/project/rg312/mat_files/storm_chapter_data/run_075/wsv_075_comp_' num2str(year) '.mat'])
v_fb_comp_075(:,:,year) = nanmean(comp_data,3);

load(['/project/rg312/mat_files/storm_chapter_data/run_100/wsv_100_comp_' num2str(year) '.mat'])
v_fb_comp_100(:,:,year) = nanmean(comp_data,3);

load(['/project/rg312/mat_files/storm_chapter_data/run_125/wsv_125_comp_' num2str(year) '.mat'])
v_fb_comp_125(:,:,year) = nanmean(comp_data,3);

load(['/project/rg312/mat_files/storm_chapter_data/run_150/wsv_150_comp_' num2str(year) '.mat'])
v_fb_comp_150(:,:,year) = nanmean(comp_data,3);

end

v_fb_comp_000 = mean(v_fb_comp_000,3);
v_fb_comp_010 = mean(v_fb_comp_010,3);
v_fb_comp_025 = mean(v_fb_comp_025,3);
v_fb_comp_050 = mean(v_fb_comp_050,3);
v_fb_comp_075 = mean(v_fb_comp_075,3);
v_fb_comp_100 = mean(v_fb_comp_100,3);
v_fb_comp_125 = mean(v_fb_comp_125,3);
v_fb_comp_150 = mean(v_fb_comp_150,3);
v_fb_comp_th = mean(v_fb_comp_th,3);

w_fb_half_000(:,26) = zeros(35,1);
w_fb_half_000(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_000,2),2).*-4000,2);
w_fb_000 = interp1(rC_half,w_fb_half_000',rC)';

w_fb_half_010(:,26) = zeros(35,1);
w_fb_half_010(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_010,2),2).*-4000,2);
w_fb_010 = interp1(rC_half,w_fb_half_010',rC)';

w_fb_half_025(:,26) = zeros(35,1);
w_fb_half_025(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_025,2),2).*-4000,2);
w_fb_025 = interp1(rC_half,w_fb_half_025',rC)';

w_fb_half_050(:,26) = zeros(35,1);
w_fb_half_050(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_050,2),2).*-4000,2);
w_fb_050 = interp1(rC_half,w_fb_half_050',rC)';

w_fb_half_th(:,26) = zeros(35,1);
w_fb_half_th(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_th,2),2).*-4000,2);
w_fb_th = interp1(rC_half,w_fb_half_th',rC)';

w_fb_half_075(:,26) = zeros(35,1);
w_fb_half_075(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_075,2),2).*-4000,2);
w_fb_075 = interp1(rC_half,w_fb_half_075',rC)';

w_fb_half_100(:,26) = zeros(35,1);
w_fb_half_100(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_100,2),2).*-4000,2);
w_fb_100 = interp1(rC_half,w_fb_half_100',rC)';

w_fb_half_125(:,26) = zeros(35,1);
w_fb_half_125(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_125,2),2).*-4000,2);
w_fb_125 = interp1(rC_half,w_fb_half_125',rC)';

w_fb_half_150(:,26) = zeros(35,1);
w_fb_half_150(:,1:25) = flipdim(cumsum(flipdim(v_fb_comp_150,2),2).*-4000,2);
w_fb_150 = interp1(rC_half,w_fb_half_150',rC)';







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

vp=-0.30:0.025:0.1;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(x,rC./100, w_fb_000',vp);
colormap(b2r(-0.3,0.1));
hold on
[C,h] = contour(x,rC./100,w_fb_000',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
%clabel(C,h);
set(gca,'FontSize',10,'YDir','reverse')
ylabel('Pressure, hPa','FontSize',12)
title('dry')
freezeColors
'000'

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(x, rC./100, w_fb_010',vp);
colormap(b2r(-0.3,0.1));
hold on
[C,h] = contour(x,rC./100,w_fb_010',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
%clabel(C,h);
set(gca,'FontSize',10,'YDir','reverse')
title('010')
freezeColors
'010'

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contourf(x, rC./100, w_fb_025',vp);
colormap(b2r(-0.3,0.1));
hold on
[C,h] = contour(x,rC./100,w_fb_025',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
%clabel(C,h);
set(gca,'FontSize',10,'YDir','reverse')
title('025')
freezeColors
'025'

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contourf(x, rC./100, w_fb_050',vp);
colormap(b2r(-0.3,0.1));
hold on
[C,h] = contour(x,rC./100,w_fb_050',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
%clabel(C,h);
set(gca,'FontSize',10,'YDir','reverse')
ylabel('Pressure, hPa','FontSize',12)
title('050')
freezeColors
'050'

axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contourf(x, rC./100, w_fb_th',vp);
colormap(b2r(-0.3,0.1));
hold on
[C,h] = contour(x,rC./100,w_fb_th',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
%clabel(C,h);
set(gca,'FontSize',10,'YDir','reverse')
title('tropheat')
freezeColors
'th'

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contourf(x, rC./100, w_fb_075',vp);
colormap(b2r(-0.3,0.1));
hold on
[C,h] = contour(x,rC./100,w_fb_075',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
%clabel(C,h);
set(gca,'FontSize',10,'YDir','reverse')
title('075')
freezeColors
'075'

axes('position',[pos7x pos7y xSize_sub ySize_sub])
[C,h] = contourf(x, rC./100, w_fb_100',vp);
colormap(b2r(-0.3,0.1));
hold on
[C,h] = contour(x,rC./100,w_fb_100',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
%clabel(C,h);
set(gca,'FontSize',10,'YDir','reverse')
ylabel('Pressure, hPa','FontSize',12)
xlabel('Longitude','FontSize',12)
title('wet')
freezeColors
'100'

axes('position',[pos8x pos8y xSize_sub ySize_sub])
[C,h] = contourf(x,rC./100, w_fb_125',vp);
colormap(b2r(-0.3,0.1));
hold on
[C,h] = contour(x,rC./100,w_fb_125',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
%clabel(C,h);
set(gca,'FontSize',10,'YDir','reverse')
xlabel('Longitude','FontSize',12)
title('125')
freezeColors
'125'

axes('position',[pos9x pos9y xSize_sub ySize_sub])
[C,h] = contourf(x,rC./100, w_fb_150',vp);
colormap(b2r(-0.3,0.1));
hold on
[C,h] = contour(x,rC./100,w_fb_150',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
%clabel(C,h);
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

print('-dpdf','wsv_comp.pdf')



