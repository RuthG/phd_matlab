%load in 10 day avs from wet to dry expt and plot up

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';
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
ny=90;
ylat = -89:2:89;
load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/drytowet_tidy/firstten_data.mat')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
X = 21.0;                  %# A4 paper size
Y = 29.7;                  %# A4 paper size
xMargin = 0.75;               %# left/right margins from page borders
yMargin = 1;               %# bottom/top margins from page borders
xSize = X - 2*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 2*yMargin;     %# figure size on paper (widht & hieght)
xSize_sub = 0.4;
ySize_sub = 1./3-0.1;

pos1x = 0.1 ; 	pos1y = 2/3+0.05; 
pos2x = 0.55;	pos2y = 2/3+0.05;
pos3x = 0.1; 	pos3y = 1/3+0.05;
pos4x = 0.55; 	pos4y = 1/3+0.05;
pos5x = 0.1; 	pos5y = 0.05;
pos6x = 0.55; 	pos6y = 0.05;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:10

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%PLOT 1
axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-20:4.:48;
[C,h]=contourf(ylat(46:90),rC./100.,uE_ft_hzav(:,:,i)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,uE_ft_hzav(:,:,i)',v,'k:');
colorbar;
colormap(b2r(-20,48));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Zonal wind, m/s'])

hold off
freezeColors
cbfreeze(colorbar);
name=['best_wetonly' num2str(i) '.ps'];

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-10:1.:10;
[C,h]=contourf(ylat(46:90),rC./100.,vN_ft_hzav(:,:,i)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,vN_ft_hzav(:,:,i)',v,'k:');
colorbar;
colormap(b2r(-10,10));
set(gca,'YDir','reverse')
title(['Meridional wind, m/s'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=270:20:690;
[C,h]=contourf(ylat(46:90),rC./100.,theta_ft_hzav(:,:,i)',v);
hold on
v=-1000:1000:1000;
[C,h]=contour(ylat(46:90),rC./100.,theta_ft_hzav(:,:,i)',v,'k:');
colorbar;
colormap('default');
caxis([270 690]);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Potential Temperature, K'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 4
axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=186:5:300;
[C,h]=contourf(ylat(46:90),rC./100.,temp_ft_hzav(:,:,i)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,temp_ft_hzav(:,:,i)',v,'k:');
colorbar;
colormap('default');
caxis([186 300]);
set(gca,'YDir','reverse')
title(['Temperature, K'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
v=-70:10:110;
[C,h]=contourf(ylat(46:90),rC./100.,uv_ed_ft_hzav(:,:,i)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,uv_ed_ft_hzav(:,:,i)',v,'k:');
colorbar;
colormap(b2r(-70,110));
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title(['Horiz eddy mom flux, m^{2}/s^{2}'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
v=-90:10:100;
[C,h]=contourf(ylat(46:90),rC./100.,vt_ed_ft_hzav(:,:,i)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,vt_ed_ft_hzav(:,:,i)',v,'k:');
colorbar;
colormap(b2r(-90,100));
set(gca,'YDir','reverse')
xlabel('Latitude')
title(['Meridional eddy theta trans, Km/s'])
hold off
freezeColors
cbfreeze(colorbar);


 print('-dpsc',name)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%for each need to add: contours, colormaps, contour labelling

%PLOT 1
axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-0.12:0.01:0.08;
[C,h]=contourf(ylat(46:90),rC./100.,w_ft_hzav(:,:,i)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,w_ft_hzav(:,:,i)',v,'k:');
colorbar;
colormap(b2r(-0.12,0.08));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Vertical wind, Pa/s'])
hold off
freezeColors
cbfreeze(colorbar);
name=['best_wetonly' num2str(i) '.ps'];

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-4.2:0.3:1.2;
[C,h]=contourf(ylat(46:90),rC./100.,radht_ft_hzav(:,:,i)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,radht_ft_hzav(:,:,i)',v,'k:');
colorbar;
colormap(b2r(-4.2,1.2));
set(gca,'YDir','reverse')
title(['Radiative heating, K/day'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-3:0.5:8;
[C,h]=contourf(ylat(46:90),rC./100.,difht_ft_hzav(:,:,i)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,difht_ft_hzav(:,:,i)',v,'k:');
colorbar;
colormap(b2r(-3,8));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Diffusive heating, K/day'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 4
axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-5:5:110;
[C,h]=contourf(ylat(46:90),rC./100.,htrt_ft_hzav(:,:,i)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,htrt_ft_hzav(:,:,i)',v,'k:');
colorbar;
colormap(b2r(-5,110));
set(gca,'YDir','reverse')
title(['Total heating, K/day'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
v = 0:5.:110;
[C,h]=contourf(ylat(46:90),rC./100.,cndht_ft_hzav(:,:,i)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,cndht_ft_hzav(:,:,i)',v,'k:');
colorbar;
colormap(b2r(0,110));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['Condensational heating, K/day'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
v= -4.:0.2:3.;
[C,h]=contourf(ylat(46:90),rC./100.,cnvht_ft_hzav(:,:,i)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,cnvht_ft_hzav(:,:,i)',v,'k:');
colorbar;
colormap(b2r(-4,3));
set(gca,'YDir','reverse')
xlabel('Latitude')
title(['Convective heating, K/day'])
hold off
freezeColors
cbfreeze(colorbar);

print('-dpsc',name,'-append')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 3%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%PLOT 1
axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=0:0.001:0.02;
[C,h]=contourf(ylat(46:90),rC./100.,q_ft_hzav(:,:,i)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,q_ft_hzav(:,:,i)',v,'k:');
colorbar;
colormap(b2r(0,0.02));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Specific humidity, kg/kg'])
hold off
freezeColors
cbfreeze(colorbar);
name=['best_wetonly' num2str(i) '.ps'];

print('-dpsc',name,'-append')

end



return
