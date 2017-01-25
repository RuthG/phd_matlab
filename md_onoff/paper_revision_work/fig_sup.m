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

load('/project/rg312/mat_files/blayer_levs_final.mat');

for i=2:89
    bl_000(i) = rC(b_lev_000(i))./100.;
    bl_100(i) = rC(b_lev_100(i))./100.;
end


load('/project/rg312/mat_files/heat_assym_anom.mat')

yi = -89:2:89;
rC = 980:-40:20;

%load stormtracklats
load('/project/rg312/mat_files/vt_lats_final.mat');

dcoeff_warm_000 = ( htrt_t_w_000(46:90,:).*86400./thsq_w_000(46:90,:) + flipdim( htrt_t_w_000(1:45,:).*86400./thsq_w_000(1:45,:) ,1) )./2;
dcoeff_cold_000 = ( htrt_t_c_000(46:90,:).*86400./thsq_c_000(46:90,:) + flipdim( htrt_t_c_000(1:45,:).*86400./thsq_c_000(1:45,:) ,1) )./2;
dcoeff_warm_100 = ( htrt_t_w_100(46:90,:).*86400./thsq_w_100(46:90,:) + flipdim( htrt_t_w_100(1:45,:).*86400./thsq_w_100(1:45,:) ,1) )./2;
dcoeff_cold_100 = ( htrt_t_c_100(46:90,:).*86400./thsq_c_100(46:90,:) + flipdim( htrt_t_c_100(1:45,:).*86400./thsq_c_100(1:45,:) ,1) )./2;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 22; %25.0;                  %# A4 paper size
X = 28; %32; % 20;                  %# A4 paper size
yMargin = 0;               %# left/right margins from page borders
xMargin = 0;               %# bottom/top margins from page borders
xSize = X - 2*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 2*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.35 ; 
xSize_sub = 0.35 ;

pos1x = 0.1 ; 	pos1y = 0.5; 
pos2x = 0.5;	pos2y = 0.5; 
pos3x = 0.1 ; 	pos3y = 0.1; 
pos4x = 0.5;	pos4y = 0.1; 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(yi(46:90),rC,dcoeff_warm_000',[-20,-2:0.2:0]);
hold on
grid on
plot([yi(x000n),yi(x000n)],[0,980],'k--', 'LineWidth',2)
plot(yi(46:89),bl_000(46:89),'k:', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
ylabel('Pressure, hPa','FontSize',15)
colormap(b2r(-1.5,0.));
text(-12,50,'\fontsize{12} (a)')
freezeColors

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(yi(46:90),rC,dcoeff_cold_000',[-20,-2:0.2:0]);
hold on
grid on
plot([yi(x000n),yi(x000n)],[0,980],'k--', 'LineWidth',2)
plot(yi(46:89),bl_000(46:89),'k:', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
colormap(b2r(-1.5,0.));
text(-12,50,'\fontsize{12} (b)')
freezeColors


axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(yi(46:90),rC,dcoeff_warm_100',[-20,-2:0.2:0]);
hold on
grid on
plot([yi(x100n),yi(x100n)],[0,980],'k--', 'LineWidth',2)
plot(yi(46:89),bl_100(46:89),'k:', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
colormap(b2r(-1.5,0.));
text(-12,50,'\fontsize{12} (c)')
freezeColors


axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(yi(46:90),rC,dcoeff_cold_100',[-20,-2:0.2:0]);
hold on
grid on
plot([yi(x100n),yi(x100n)],[0,980],'k--', 'LineWidth',2)
plot(yi(46:89),bl_100(46:89),'k:', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
colormap(b2r(-1.5,0.));
freezeColors
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',15);
x = get(c,'Position');
x(1) = 0.87; x(2) = 0.1; x(3) = 0.03; x(4) = 0.75;
set(c,'Position',x);
text(-12,50,'\fontsize{12} (d)')
set(gca, 'Position', originalSize)


print('-dpdf','figure_sup.pdf')



return

