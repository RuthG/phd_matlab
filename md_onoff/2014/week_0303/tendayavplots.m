%load in 10 day avs from wet to dry expt and plot up
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_accidentalcontrol/';

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

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0303/tendayavs_control.mat')
uE_hzav_c = uE_hzav;
vN_hzav_c = vN_hzav;
theta_hzav_c = theta_hzav;
temp_hzav_c = temp_hzav;
uv_ed_hzav_c = uv_ed_hzav;
vt_ed_hzav_c = vt_ed_hzav;
w_hzav_c = w_hzav;
q_hzav_c = q_hzav;
htrt_hzav_c = htrt_hzav;
radht_hzav_c = radht_hzav;
cndht_hzav_c = cndht_hzav;
cnvht_hzav_c = cnvht_hzav;
difht_hzav_c = difht_hzav;
load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0303/tendayavs_tropheat3.mat')


uE_diffs = uE_hzav - uE_hzav_c;
vN_diffs = vN_hzav - vN_hzav_c;
theta_diffs = theta_hzav - theta_hzav_c;
temp_diffs = temp_hzav - temp_hzav_c;
uv_ed_diffs = uv_ed_hzav - uv_ed_hzav_c;
vt_ed_diffs = vt_ed_hzav - vt_ed_hzav_c;
w_diffs = w_hzav - w_hzav_c;
q_diffs = q_hzav - q_hzav_c;
htrt_diffs = htrt_hzav - htrt_hzav_c;
radht_diffs = radht_hzav - radht_hzav_c;
cndht_diffs = cndht_hzav - cndht_hzav_c;
cnvht_diffs = cnvht_hzav - cnvht_hzav_c;
difht_diffs = difht_hzav - difht_hzav_c;


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
for i=1:6

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%PLOT 1
axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-10:2.:32;
[C,h]=contourf(ylat(46:90),rC./100.,uE_diffs(:,:,i)',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,uE_diffs(:,:,i)',v,'k:');
colorbar;
colormap(b2r(-10,32));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Zonal wind, m/s'])
v=-25:2.5:0;
[C,h]=contour(ylat(46:90),rC./100.,uE_hzav_c(:,:,i)',v,'k--');
clabel(C,h);
v=0:2.5:45;
[C,h]=contour(ylat(46:90),rC./100.,uE_hzav_c(:,:,i)',v,'k');
clabel(C,h);
hold off
freezeColors
cbfreeze(colorbar);
name=['best_spinup_tdayav' num2str(i) '.ps'];

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-4:0.2:4;
[C,h]=contourf(ylat(46:90),rC./100.,vN_diffs(:,:,i)',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,vN_diffs(:,:,i)',v,'k:');
colorbar;
colormap(b2r(-4,4));
set(gca,'YDir','reverse')
title(['Meridional wind, m/s'])
hold on
v=-6:0.3:0;
[C,h]=contour(ylat(46:90),rC./100.,vN_hzav_c(:,:,i)',v,'k--');
clabel(C,h);
v=0:0.3:6;
[C,h]=contour(ylat(46:90),rC./100.,vN_hzav_c(:,:,i)',v,'k');
clabel(C,h);
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-10:2.5:40;
[C,h]=contourf(ylat(46:90),rC./100.,theta_diffs(:,:,i)',v);
set(h,'edgecolor','none')
hold on
v=-1000:1000:1000;
[C,h]=contour(ylat(46:90),rC./100.,theta_diffs(:,:,i)',v,'k:');
colorbar;
colormap(b2r(-10,40));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Potential Temperature, K'])
hold on
v(1:21) = 250:5:350;
v(22:29) = 400:50:750;
[C,h]=contour(ylat(46:90),rC./100.,theta_hzav_c(:,:,i)',v,'k');
clabel(C,h);
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 4
axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-4.5:1.5:28.5;
[C,h]=contourf(ylat(46:90),rC./100.,temp_diffs(:,:,i)',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,temp_diffs(:,:,i)',v,'k:');
colorbar;
colormap(b2r(-4.5,28.5));
set(gca,'YDir','reverse')
title(['Temperature, K'])
hold on
v=175:5:300;
[C,h]=contour(ylat(46:90),rC./100.,temp_hzav_c(:,:,i)',v,'k');
clabel(C,h);
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
v=-40:2.5:5;
[C,h]=contourf(ylat(46:90),rC./100.,uv_ed_diffs(:,:,i)',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,uv_ed_diffs(:,:,i)',v,'k:');
colorbar;
colormap(b2r(-40,5));
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title(['Horiz eddy mom flux, m^{2}/s^{2}'])
hold on
v= -50:5:0;
[C,h]=contour(ylat(46:90),rC./100.,uv_ed_hzav_c(:,:,i)',v,'k--');
clabel(C,h);
v= 0:5:50;
[C,h]=contour(ylat(46:90),rC./100.,uv_ed_hzav_c(:,:,i)',v,'k');
clabel(C,h);
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
v=-12.5:1.25:2.5;
[C,h]=contourf(ylat(46:90),rC./100.,vt_ed_diffs(:,:,i)',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,vt_ed_diffs(:,:,i)',v,'k:');
colorbar;
colormap(b2r(-12.5,2.5));
set(gca,'YDir','reverse')
xlabel('Latitude')
title(['Meridional eddy theta trans, Km/s'])
hold on
v=-26:2:0;
[C,h]=contour(ylat(46:90),rC./100.,vt_ed_hzav_c(:,:,i)',v,'k--');
clabel(C,h);
v=0:2:26;
[C,h]=contour(ylat(46:90),rC./100.,vt_ed_hzav_c(:,:,i)',v,'k');
clabel(C,h);
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
[C,h]=contourf(ylat(46:90),rC./100.,w_diffs(:,:,i)',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,w_diffs(:,:,i)',v,'k:');
colorbar;
colormap(b2r(-0.12,0.08));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Vertical wind, Pa/s'])
hold on
v=-0.2:0.01:0;
[C,h]=contour(ylat(46:90),rC./100.,w_hzav_c(:,:,i)',v,'k--');
clabel(C,h);
v=0.:0.01:0.1;
[C,h]=contour(ylat(46:90),rC./100.,w_hzav_c(:,:,i)',v,'k');
clabel(C,h);
hold off
freezeColors
cbfreeze(colorbar);
name=['best_spinup_tdayav' num2str(i) '.ps'];

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-2.4:0.2:1.4;
[C,h]=contourf(ylat(46:90),rC./100.,radht_diffs(:,:,i)',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,radht_diffs(:,:,i)',v,'k:');
colorbar;
colormap(b2r(-2.4,1.4));
set(gca,'YDir','reverse')
title(['Radiative heating, K/day'])
hold on
v=-4:0.2:0;
[C,h]=contour(ylat(46:90),rC./100.,radht_hzav_c(:,:,i)',v,'k--');
clabel(C,h);
v=0:0.2:0.6;
[C,h]=contour(ylat(46:90),rC./100.,radht_hzav_c(:,:,i)',v,'k');
clabel(C,h);
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-4:0.2:1.6;
[C,h]=contourf(ylat(46:90),rC./100.,difht_diffs(:,:,i)',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,difht_diffs(:,:,i)',v,'k:');
colorbar;
colormap(b2r(-4,1.6));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Diffusive heating, K/day'])
hold on
v=-2:0.25:0;
[C,h]=contour(ylat(46:90),rC./100.,difht_hzav_c(:,:,i)',v,'k--');
clabel(C,h);
v=0:0.25:4;
[C,h]=contour(ylat(46:90),rC./100.,difht_hzav_c(:,:,i)',v,'k');
clabel(C,h);
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 4
axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-2.:0.4:6.4;
[C,h]=contourf(ylat(46:90),rC./100.,htrt_diffs(:,:,i)',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,htrt_diffs(:,:,i)',v,'k:');
colorbar;
colormap(b2r(-2,6.4));
set(gca,'YDir','reverse')
title(['Total heating, K/day'])
hold on
v=-2:0.5:0;
[C,h]=contour(ylat(46:90),rC./100.,htrt_hzav_c(:,:,i)',v,'k--');
clabel(C,h);
v=0:0.5:6.5;
[C,h]=contour(ylat(46:90),rC./100.,htrt_hzav_c(:,:,i)',v,'k');
clabel(C,h);
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
v = 0:0.15:6;
[C,h]=contourf(ylat(46:90),rC./100.,cndht_diffs(:,:,i)',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,cndht_diffs(:,:,i)',v,'k:');
colorbar;
colormap(b2r(0,6));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['Condensational heating, K/day'])
hold on
v=0:0.3:6;
[C,h]=contour(ylat(46:90),rC./100.,cndht_hzav_c(:,:,i)',v,'k');
clabel(C,h);
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
v= -1.5:0.15:1.65;
[C,h]=contourf(ylat(46:90),rC./100.,cnvht_diffs(:,:,i)',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,cnvht_diffs(:,:,i)',v,'k:');
colorbar;
colormap(b2r(-1.5,1.65));
set(gca,'YDir','reverse')
xlabel('Latitude')
title(['Convective heating, K/day'])
hold on
v=-1:0.125:0;
[C,h]=contour(ylat(46:90),rC./100.,cnvht_hzav_c(:,:,i)',v,'k--');
clabel(C,h);
v=0:0.125:1.5;
[C,h]=contour(ylat(46:90),rC./100.,cnvht_hzav_c(:,:,i)',v,'k');
clabel(C,h);
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
[C,h]=contourf(ylat(46:90),rC./100.,q_diffs(:,:,i)',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,q_diffs(:,:,i)',v,'k:');
colorbar;
colormap(b2r(0,0.02));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Specific humidity, kg/kg'])
hold on
v=0:1e-3:20e-3;
[C,h]=contour(ylat(46:90),rC./100.,q_hzav_c(:,:,i)',v,'k');
clabel(C,h);
hold off
freezeColors
cbfreeze(colorbar);
name=['best_spinup_tdayav' num2str(i) '.ps'];

print('-dpsc',name,'-append')

end