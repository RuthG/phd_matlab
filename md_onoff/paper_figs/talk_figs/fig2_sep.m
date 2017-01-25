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

load('/net/spat-nas/project/rg312/mat_files/snapshot_data_final/front_diag.mat')
load('/net/spat-nas/project/rg312/mat_files/snapshot_data_final/fig2data.mat')

day000 = 1;
day100 = 61;



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
v=-160:10:160;
[C,h] = contourf(xi,yi,vNt_ed_000(:,:,day000)',v);
set(h,'LineColor','none')
set(gca,'FontSize',18)
hold on
v = -0.9:1:0.1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,day000)',v,'Color',[0.5,0.5,0.5],'LineWidth',2);
colormap(b2r(-80,80));
freezeColors
xlim([-90 90])
ylim([0 90])
%text(-115,85,'\fontsize{15} (a)')
%colorbar('FontSize',18)
%title('v''T'', Km/s, 0es0');
ylabel('Latitude','FontSize',18)
%xlabel('Longitude','FontSize',18)
freezeColors

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-160:10:160;
[C,h] = contourf(xi,yi,vNt_ed_100(:,:,day100)',v);
set(h,'LineColor','none')
set(gca,'FontSize',18)
hold on
v = -0.9:1:0.1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,day100)',v,'Color',[0.5,0.5,0.5],'LineWidth',2);
colormap(b2r(-80,80)); freezeColors
xlim([-90 90])
ylim([0 90])
xlabel('Longitude','FontSize',18)
ylabel('Latitude','FontSize',18)
%text(-115,85,'\fontsize{15} (b)')
originalSize = get(gca, 'Position')
%colorbar('FontSize',18)
c = colorbar('eastoutside','FontSize',18);
x = get(c,'Position');
x(1) = 0.47; x(2) = 0.25; x(3) = 0.015; x(4) = 0.5;
set(c,'Position',x);
set(gca, 'Position', originalSize)
freezeColors
print('-dpdf','vt_ed.pdf')


%title('v''T'', Km/s, 1es0');
%ylabel('Latitude')
%xlabel('Longitude')

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-12:1:12;
[C,h] = contourf(xi,yi,t_ed_000(:,:,day000)',v);
set(h,'LineColor','none')
set(gca,'FontSize',18)
hold on
v = -0.9:1:0.1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,day000)',v,'Color',[0.5,0.5,0.5],'LineWidth',2);
colormap(b2r(-8,8)); freezeColors
xlim([-90 90])
ylim([0 90])
%text(-115,85,'\fontsize{15} (c)')
%colorbar('FontSize',18)
%title('T'', K, 0es0');
ylabel('Latitude','FontSize',18)
%xlabel('Longitude','FontSize',18)
freezeColors

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-12:1:12;
[C,h] = contourf(xi,yi,t_ed_100(:,:,day100)',v);
set(h,'LineColor','none')
set(gca,'FontSize',18)
hold on
v = -0.9:1:0.1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,day100)',v,'Color',[0.5,0.5,0.5],'LineWidth',2);
colormap(b2r(-8,8)); freezeColors
xlim([-90 90])
ylim([0 90])
%text(-115,85,'\fontsize{15} (d)')
originalSize = get(gca, 'Position')
%colorbar('FontSize',18)
c = colorbar('eastoutside','FontSize',18);
x = get(c,'Position');
x(1) = 0.47; x(2) = 0.25; x(3) = 0.015; x(4) = 0.5;
set(c,'Position',x);
set(gca, 'Position', originalSize)
%title('T'', K, 1es0');
ylabel('Latitude','FontSize',18)
xlabel('Longitude','FontSize',18)
freezeColors
print('-dpdf','t_ed.pdf')





hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

ySize_sub = 0.35 ; 
xSize_sub = 0.7 ;


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-26:2:26;
[C,h] = contourf(xi,yi,vN_ed_000(:,:,day000)',v);
set(h,'LineColor','none')
set(gca,'FontSize',18)
hold on
v = -0.9:1:0.1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,day000)',v,'Color',[0.5,0.5,0.5],'LineWidth',2);
colormap(b2r(-20,20)); freezeColors
%xlim([-90 90])
ylim([0 90])
%text(-115,85,'\fontsize{15} (c)')
%colorbar('FontSize',18)
%title('T'', K, 0es0');
ylabel('Latitude','FontSize',18)
%xlabel('Longitude','FontSize',18)
freezeColors

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-26:2:26;
[C,h] = contourf(xi,yi,vN_ed_100(:,:,day100)',v);
set(h,'LineColor','none')
set(gca,'FontSize',18)
hold on
v = -0.9:1:0.1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,day100)',v,'Color',[0.5,0.5,0.5],'LineWidth',2);
colormap(b2r(-20,20)); freezeColors
%xlim([-90 90])
ylim([0 90])
%text(-115,85,'\fontsize{15} (d)')
originalSize = get(gca, 'Position')
%colorbar('FontSize',18)
c = colorbar('eastoutside','FontSize',18);
x = get(c,'Position');
x(1) = 0.82; x(2) = 0.25; x(3) = 0.015; x(4) = 0.5;
set(c,'Position',x);
set(gca, 'Position', originalSize)
%title('T'', K, 1es0');
ylabel('Latitude','FontSize',18)
xlabel('Longitude','FontSize',18)
freezeColors
print('-dpdf','v_ed.pdf')





return



for day100 = 1:10:151
figure
v=-160:10:160;
[C,h] = contourf(xi,yi,vNt_ed_100(:,:,day100)',v);
set(h,'LineColor','none')
set(gca,'FontSize',12)
hold on
v = -0.9:1:0.1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,day100)',v,'Color',[0.5,0.5,0.5]); 
colormap(b2r(-80,80));
xlim([-90 90])
ylim([0 90])

figure
v=-12:1:12;
[C,h] = contourf(xi,yi,t_ed_100(:,:,day100)',v);
set(h,'LineColor','none')
set(gca,'FontSize',12)
hold on
v = -0.9:1:0.1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,day100)',v,'Color',[0.5,0.5,0.5]); %,'LineWidth',1);
colormap(b2r(-8,8)); 
xlim([-90 90])
ylim([0 90])

end



