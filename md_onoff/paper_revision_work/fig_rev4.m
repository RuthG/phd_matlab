%load in snapshots and remove averages. Contour plots of T' and v'T snapshots for 0 and 1 runs with front diag overlaid


rDir='/net/spat-nas/project/rg312/final_runs/run_000_final_noshallow/';
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
yi=-89:2:89;
xi = -179:2:179;

load('/project/rg312/mat_files/vt_assym.mat')

yi = -89:2:89;
rC = 980:-40:20;

%load stormtracklats
load('/project/rg312/mat_files/vt_lats_final.mat');

assym_000 = ( (vt_w_000(46:90,:) - vt_c_000(46:90,:))./(vt_c_000(46:90,:) + vt_w_000(46:90,:)) + flipdim( (vt_w_000(1:45,:) - vt_c_000(1:45,:))./(vt_c_000(1:45,:) + vt_w_000(1:45,:)) ,1) )./2;

total_000 = ( vt_c_000(46:90,:) + vt_w_000(46:90,:) - flipdim( vt_c_000(1:45,:) + vt_w_000(1:45,:) ,1) )./2;

assym_100 = ( (vt_w_100(46:90,:) - vt_c_100(46:90,:))./(vt_c_100(46:90,:) + vt_w_100(46:90,:)) + flipdim( (vt_w_100(1:45,:) - vt_c_100(1:45,:))./(vt_c_100(1:45,:) + vt_w_100(1:45,:)) ,1) )./2;

total_100 = ( vt_c_100(46:90,:) + vt_w_100(46:90,:) - flipdim( vt_c_100(1:45,:) + vt_w_100(1:45,:) ,1) )./2;


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
xSize_sub = 0.65 ; %0.35; %0.7;


pos1x = 0.15 ; 	pos1y = 0.55; 
pos2x = 0.15;	pos2y = 0.15; 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
h=pcolor(yi(46:90),rC, assym_000' );
set(h,'edgecolor','none')
hold on
grid on
set(gca,'layer','top')
[C,h]=contour(yi(46:90),rC,total_000',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x000n),yi(x000n)],[0,980],'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
ylabel('Pressure, hPa','FontSize',15)
colormap(b2r(-0.5,0.5));
text(-20,50,'\fontsize{12} (a)')
freezeColors

axes('position',[pos2x pos2y xSize_sub ySize_sub])
h=pcolor(yi(46:90),rC, assym_100' );
set(h,'edgecolor','none')
hold on
grid on
set(gca,'layer','top')
[C,h]=contour(yi(46:90),rC,total_100',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x100n),yi(x100n)],[0,980],'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
ylabel('Pressure, hPa','FontSize',15)
xlabel('Latitude','FontSize',15)
colormap(b2r(-0.5,0.5));
freezeColors
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',15);
x = get(c,'Position');
x(1) = 0.83; x(2) = 0.2; x(3) = 0.03; x(4) = 0.65;
set(c,'Position',x);
set(gca, 'Position', originalSize)
text(-20,50,'\fontsize{12} (b)')

print('-dpdf','figure_assym.pdf')


return

[C,h]=contourf(yi(46:90),rC,dcoeff_warm_000',[-20,-2:0.2:0]);
hold on
grid on
plot([yi(x000n),yi(x000n)],[0,980],'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
ylabel('Pressure, hPa','FontSize',15)
colormap(b2r(-1.5,0.));
freezeColors

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(yi(46:90),rC,dcoeff_cold_000',[-20,-2:0.2:0]);
hold on
grid on
plot([yi(x000n),yi(x000n)],[0,980],'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
colormap(b2r(-1.5,0.));
freezeColors


axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(yi(46:90),rC,dcoeff_warm_100',[-20,-2:0.2:0]);
hold on
grid on
plot([yi(x100n),yi(x100n)],[0,980],'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
colormap(b2r(-1.5,0.));
freezeColors


axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(yi(46:90),rC,dcoeff_cold_100',[-20,-2:0.2:0]);
hold on
grid on
plot([yi(x100n),yi(x100n)],[0,980],'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
colormap(b2r(-1.5,0.));
freezeColors
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',15);
x = get(c,'Position');
x(1) = 0.87; x(2) = 0.1; x(3) = 0.03; x(4) = 0.75;
set(c,'Position',x);

%colorbar('FontSize',15)
set(gca, 'Position', originalSize)


print('-dpdf','figure_sup.pdf')



return

