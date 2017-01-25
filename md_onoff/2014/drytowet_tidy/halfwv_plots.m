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
load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/drytowet_tidy/hwv_data.mat')

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

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%PLOT 1
axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-25:2.5:45;
[C,h]=contourf(ylat(46:90),rC./100.,uE_hw_hzav(:,:)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,uE_hw_hzav(:,:)',v,'k:');
colorbar;
colormap(b2r(-25,45));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Zonal wind, m/s'])
hold off
freezeColors
cbfreeze(colorbar);
name=['best_halfwv.ps'];

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-6:0.3:6;
[C,h]=contourf(ylat(46:90),rC./100.,vN_hw_hzav(:,:)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,vN_hw_hzav(:,:)',v,'k:');
colorbar;
colormap(b2r(-6,6));
set(gca,'YDir','reverse')
title(['Meridional wind, m/s'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
v(1:21) = 250:5:350;
v(22:29) = 400:50:750;
[C,h]=contourf(ylat(46:90),rC./100.,theta_hw_hzav(:,:)',v);
colorbar;
colormap('default');
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Potential Temperature, K'])
freezeColors
cbfreeze(colorbar);

%PLOT 4
axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=175:5:300;
[C,h]=contourf(ylat(46:90),rC./100.,temp_hw_hzav(:,:)',v);
colorbar;
colormap('default');
set(gca,'YDir','reverse')
title(['Temperature, K'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
v=-15:5:50;
[C,h]=contourf(ylat(46:90),rC./100.,uv_ed_hw_hzav(:,:)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,uv_ed_hw_hzav(:,:)',v,'k:');
colorbar;
colormap(b2r(-15,50));
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title(['Horiz eddy mom flux, m^{2}/s^{2}'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
v=-4:1:20;
[C,h]=contourf(ylat(46:90),rC./100.,vt_ed_hw_hzav(:,:)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,vt_ed_hw_hzav(:,:)',v,'k:');
colorbar;
colormap(b2r(-4,20));
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
v=-0.13:0.01:0.04;
[C,h]=contourf(ylat(46:90),rC./100.,w_hw_hzav(:,:)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,w_hw_hzav(:,:)',v,'k:');
colorbar;
colormap(b2r(-0.13,0.04));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Vertical wind, Pa/s'])
hold off
freezeColors
cbfreeze(colorbar);
name=['best_halfwv.ps'];

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-4:0.2:0.6;
[C,h]=contourf(ylat(46:90),rC./100.,radht_hw_hzav(:,:)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,radht_hw_hzav(:,:)',v,'k:');
colorbar;
colormap(b2r(-4.,0.6));
set(gca,'YDir','reverse')
title(['Radiative heating, K/day'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-1.2:0.2:4;
[C,h]=contourf(ylat(46:90),rC./100.,difht_hw_hzav(:,:)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,difht_hw_hzav(:,:)',v,'k:');
colorbar;
colormap(b2r(-1.2,4));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Diffusive heating, K/day'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 4
axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-1.2:0.2:4;
[C,h]=contourf(ylat(46:90),rC./100.,htrt_hw_hzav(:,:)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,htrt_hw_hzav(:,:)',v,'k:');
colorbar;
colormap(b2r(-1.2,4));
set(gca,'YDir','reverse')
title(['Total heating, K/day'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
v = 0:0.2:4.6;
[C,h]=contourf(ylat(46:90),rC./100.,cndht_hw_hzav(:,:)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,cndht_hw_hzav(:,:)',v,'k:');
colorbar;
colormap(b2r(0,4.6));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['Condensational heating, K/day'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
v= -0.8:0.1:1.2;
[C,h]=contourf(ylat(46:90),rC./100.,cnvht_hw_hzav(:,:)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,cnvht_hw_hzav(:,:)',v,'k:');
colorbar;
colormap(b2r(-0.8,1.2));
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
[C,h]=contourf(ylat(46:90),rC./100.,q_hw_hzav(:,:)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,q_hw_hzav(:,:)',v,'k:');
colorbar;
colormap(b2r(0,0.02));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Specific humidity, kg/kg'])
hold off
freezeColors
cbfreeze(colorbar);
name=['best_halfwv.ps'];

print('-dpsc',name,'-append')


return
