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

load('/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_000_ns/t_000_5.mat')
load('/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_100/t_100_5.mat')
load('/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_000_ns/t_000_timemean.mat');
t_ll_tav_000 = t_ll_tav;
load('/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_100/t_100_timemean.mat');
t_ll_tav_100 = t_ll_tav;

t_ll_000 = squeeze(cube2latlon(xc,yc,t_000,xi,yi));
t_ll_100 = squeeze(cube2latlon(xc,yc,t_100,xi,yi));
clear('t_000','t_100')


load('/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_000_ns/vN_000_5.mat')
load('/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_100/vN_100_5.mat')
load('/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_000_ns/vN_000_timemean.mat');
vN_ll_tav_000 = vN_ll_tav;
load('/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_100/vN_100_timemean.mat');
vN_ll_tav_100 = vN_ll_tav;

vN_ll_000 = squeeze(cube2latlon(xc,yc,vN_000,xi,yi));
vN_ll_100 = squeeze(cube2latlon(xc,yc,vN_100,xi,yi));
clear('vN_000','vN_100')


day000 = 1;
day100 = 200;

vN_ed_000 = vN_ll_000 - repmat(vN_ll_tav_000,[1 1 1 360]);
vN_ed_100 = vN_ll_100 - repmat(vN_ll_tav_100,[1 1 1 360]);

t_ed_000 = t_ll_000 - repmat(t_ll_tav_000,[1 1 1 360]);
t_ed_100 = t_ll_100 - repmat(t_ll_tav_100,[1 1 1 360]);

vNt_ed_000 = vN_ed_000.*t_ed_000;
vNt_ed_100 = vN_ed_100.*t_ed_100;



return


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
[C,h] = contourf(xi,yi,vNt_ed_000(:,:,5,day000)',v);
set(h,'LineColor','none')
set(gca,'FontSize',12)
hold on
v = -0.9:1:0.1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1,day000)',v,'Color',[0.6,0.6,0.6]); %,'LineWidth',1);
colormap(b2r(-80,80));
freezeColors
xlim([-90 90])
ylim([0 90])
text(-115,85,'\fontsize{15} (a)')
%colorbar('FontSize',15)
%title('v''T'', Km/s, 0es0');
ylabel('Latitude','FontSize',15)
%xlabel('Longitude','FontSize',15)


axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-160:10:160;
[C,h] = contourf(xi,yi,vNt_ed_100(:,:,5,day100)',v);
set(h,'LineColor','none')
set(gca,'FontSize',12)
hold on
v = -0.9:1:0.1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,day100)',v,'Color',[0.6,0.6,0.6]); %,'LineWidth',1);
colormap(b2r(-80,80)); freezeColors
xlim([-90 90])
ylim([0 90])
text(-115,85,'\fontsize{15} (b)')
originalSize = get(gca, 'Position')
colorbar('FontSize',15)
set(gca, 'Position', originalSize)

%title('v''T'', Km/s, 1es0');
%ylabel('Latitude')
%xlabel('Longitude')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-12:1:12;
[C,h] = contourf(xi,yi,t_ed_000(:,:,day000)',v);
set(h,'LineColor','none')
set(gca,'FontSize',12)
hold on
v = -0.9:1:0.1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,day000)',v,'Color',[0.6,0.6,0.6]); %,'LineWidth',1);
colormap(b2r(-8,8)); freezeColors
xlim([-90 90])
ylim([0 90])
text(-115,85,'\fontsize{15} (c)')
%colorbar('FontSize',15)
%title('T'', K, 0es0');
ylabel('Latitude','FontSize',15)
xlabel('Longitude','FontSize',15)


axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-12:1:12;
[C,h] = contourf(xi,yi,t_ed_100(:,:,5,day100)',v);
set(h,'LineColor','none')
set(gca,'FontSize',12)
hold on
v = -0.9:1:0.1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,day100)',v,'Color',[0.6,0.6,0.6]); %,'LineWidth',1);
colormap(b2r(-8,8)); freezeColors
xlim([-90 90])
ylim([0 90])
text(-115,85,'\fontsize{15} (d)')
originalSize = get(gca, 'Position')
colorbar('FontSize',15)
set(gca, 'Position', originalSize)
%title('T'', K, 1es0');
%ylabel('Latitude')
xlabel('Longitude','FontSize',15)

print('-dpdf','figure_2.pdf')
print('-depsc2','figure_2.eps')
