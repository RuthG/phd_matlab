
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

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050_tropheat.mat','q_tav')
q_ll=cube2latlon(xc,yc,q_tav,xi,yi);
q_zav_th(:,:) = mean(q_ll,1).*1000;

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050.mat','q_tav')
q_ll=cube2latlon(xc,yc,q_tav,xi,yi);
q_zav_050(:,:) = mean(q_ll,1).*1000;

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_075.mat','q_tav')
q_ll=cube2latlon(xc,yc,q_tav,xi,yi);
q_zav_075(:,:) = mean(q_ll,1).*1000;


for i=1:45
q_hzav_th(i,:) = (q_zav_th(i+45,:) + q_zav_th(46-i,:))./2;
q_hzav_050(i,:) = (q_zav_050(i+45,:) + q_zav_050(46-i,:))./2;
q_hzav_075(i,:) = (q_zav_075(i+45,:) + q_zav_075(46-i,:))./2;
end

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
ySize_sub = 0.225; %0.4;
xSize_sub = 0.375;

pos1x = 0.1 ; 	pos1y = 0.7; 
pos2x = 0.55;	pos2y = 0.7; 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')



v=0:2:20;
v_diff=-2:0.25:5.25;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,q_hzav_th' - q_hzav_050',v_diff);
set(h,'LineStyle','none')
hold on
[C,h] = contour(yi(46:90),rC./100,q_hzav_050',v,'k');
clabel(C,h,'FontSize',10)
set(gca,'YDir','reverse','FontSize',10)
colormap(b2r(-2,5.25));
ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
title('tropheat - 050','FontSize',12)
freezeColors

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,q_hzav_075' - q_hzav_050',v_diff);
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
x = get(c,'Position');
x(1) = 0.95; x(2) = 0.7; x(3) = 0.015; x(4) = 0.225;
set(c,'Position',x);
set(gca, 'Position', originalSize);
set(h,'LineStyle','none')
hold on
[C,h] = contour(yi(46:90),rC./100,q_hzav_050',v,'k');clabel(C,h,'FontSize',10)
set(gca,'YDir','reverse','FontSize',10)
colormap(b2r(-2,5.25));
xlabel('Latitude','FontSize',12)
title('075 - 050','FontSize',12)
freezeColors

print('-dpdf','q_th_vs_075.pdf')

