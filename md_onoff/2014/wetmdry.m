%produce plots of wet control minus dry control

%load up data
page2 = true;   %theta and temp
page3 = true;   %u'v'  and v't'
page4 = true;   % w    and q
page5 = true;   %radht and difht
page6 = true;   %cndht and cnvht
page7 = true;   %htrt

rDir = '/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';
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

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/means_ctrl.mat')

uE_wet = uE_ctrl_mean;
vN_wet = vN_ctrl_mean;
theta_wet = theta_ctrl_mean;
temp_wet = temp_ctrl_mean;
uv_ed_wet = uv_ed_ctrl_mean;
vt_ed_wet = vt_ed_ctrl_mean;
w_wet = w_ctrl_mean;
q_wet = q_ctrl_mean;
htrt_wet = htrt_ctrl_mean;
radht_wet = radht_ctrl_mean;
cndht_wet = cndht_ctrl_mean;
cnvht_wet = cnvht_ctrl_mean;
difht_wet = difht_ctrl_mean;

load('/disk1/MITgcm/verification/atm_gray_ruth/md_offoff/means_ctrl.mat')

uE_dry = uE_ctrl_mean;
vN_dry = vN_ctrl_mean;
theta_dry = theta_ctrl_mean;
temp_dry = temp_ctrl_mean;
uv_ed_dry = uv_ed_ctrl_mean;
vt_ed_dry = vt_ed_ctrl_mean;
w_dry = w_ctrl_mean;
q_dry = q_ctrl_mean;
htrt_dry = htrt_ctrl_mean;
radht_dry = radht_ctrl_mean;
cndht_dry = cndht_ctrl_mean;
cnvht_dry = cnvht_ctrl_mean;
difht_dry = difht_ctrl_mean;

%zonally average

[uE_zav_wet,mskzon,ylat,areazon]=calcZonalAvgCube(uE_wet,ny,yc,ar,hc);
[vN_zav_wet,mskzon,ylat,areazon]=calcZonalAvgCube(vN_wet,ny,yc,ar,hc);
[theta_zav_wet,mskzon,ylat,areazon]=calcZonalAvgCube(theta_wet,ny,yc,ar,hc);
[temp_zav_wet,mskzon,ylat,areazon]=calcZonalAvgCube(temp_wet,ny,yc,ar,hc);
[uv_ed_zav_wet,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ed_wet,ny,yc,ar,hc);
[vt_ed_zav_wet,mskzon,ylat,areazon]=calcZonalAvgCube(vt_ed_wet,ny,yc,ar,hc);
[w_zav_wet,mskzon,ylat,areazon]=calcZonalAvgCube(w_wet,ny,yc,ar,hc);
[q_zav_wet,mskzon,ylat,areazon]=calcZonalAvgCube(q_wet,ny,yc,ar,hc);
[htrt_zav_wet,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_wet,ny,yc,ar,hc);
[radht_zav_wet,mskzon,ylat,areazon]=calcZonalAvgCube(radht_wet,ny,yc,ar,hc);
[cndht_zav_wet,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_wet,ny,yc,ar,hc);
[cnvht_zav_wet,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_wet,ny,yc,ar,hc);
[difht_zav_wet,mskzon,ylat,areazon]=calcZonalAvgCube(difht_wet,ny,yc,ar,hc);

[uE_zav_dry,mskzon,ylat,areazon]=calcZonalAvgCube(uE_dry,ny,yc,ar,hc);
[vN_zav_dry,mskzon,ylat,areazon]=calcZonalAvgCube(vN_dry,ny,yc,ar,hc);
[theta_zav_dry,mskzon,ylat,areazon]=calcZonalAvgCube(theta_dry,ny,yc,ar,hc);
[temp_zav_dry,mskzon,ylat,areazon]=calcZonalAvgCube(temp_dry,ny,yc,ar,hc);
[uv_ed_zav_dry,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ed_dry,ny,yc,ar,hc);
[vt_ed_zav_dry,mskzon,ylat,areazon]=calcZonalAvgCube(vt_ed_dry,ny,yc,ar,hc);
[w_zav_dry,mskzon,ylat,areazon]=calcZonalAvgCube(w_dry,ny,yc,ar,hc);
[q_zav_dry,mskzon,ylat,areazon]=calcZonalAvgCube(q_dry,ny,yc,ar,hc);
[htrt_zav_dry,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_dry,ny,yc,ar,hc);
[radht_zav_dry,mskzon,ylat,areazon]=calcZonalAvgCube(radht_dry,ny,yc,ar,hc);
[cndht_zav_dry,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_dry,ny,yc,ar,hc);
[cnvht_zav_dry,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_dry,ny,yc,ar,hc);
[difht_zav_dry,mskzon,ylat,areazon]=calcZonalAvgCube(difht_dry,ny,yc,ar,hc);


%hemispherically average

for i=1:45

uE_hzav_wet(46-i,:) = (uE_zav_wet(i,:) + uE_zav_wet(91-i,:))./2;
uE_hzav_dry(46-i,:) = (uE_zav_dry(i,:) + uE_zav_dry(91-i,:))./2;

vN_hzav_wet(46-i,:) = (-1*vN_zav_wet(i,:) + vN_zav_wet(91-i,:))./2;
vN_hzav_dry(46-i,:) = (-1*vN_zav_dry(i,:) + vN_zav_dry(91-i,:))./2;

theta_hzav_wet(46-i,:) = (theta_zav_wet(i,:) + theta_zav_wet(91-i,:))./2;
theta_hzav_dry(46-i,:) = (theta_zav_dry(i,:) + theta_zav_dry(91-i,:))./2;

temp_hzav_wet(46-i,:) = (temp_zav_wet(i,:) + temp_zav_wet(91-i,:))./2;
temp_hzav_dry(46-i,:) = (temp_zav_dry(i,:) + temp_zav_dry(91-i,:))./2;

uv_ed_hzav_wet(46-i,:) = (-1*uv_ed_zav_wet(i,:) + uv_ed_zav_wet(91-i,:))./2;
uv_ed_hzav_dry(46-i,:) = (-1*uv_ed_zav_dry(i,:) + uv_ed_zav_dry(91-i,:))./2;

vt_ed_hzav_wet(46-i,:) = (-1*vt_ed_zav_wet(i,:) + vt_ed_zav_wet(91-i,:))./2;
vt_ed_hzav_dry(46-i,:) = (-1*vt_ed_zav_dry(i,:) + vt_ed_zav_dry(91-i,:))./2;

w_hzav_wet(46-i,:) = (w_zav_wet(i,:) + w_zav_wet(91-i,:))./2;
w_hzav_dry(46-i,:) = (w_zav_dry(i,:) + w_zav_dry(91-i,:))./2;

q_hzav_wet(46-i,:) = (q_zav_wet(i,:) + q_zav_wet(91-i,:))./2;
q_hzav_dry(46-i,:) = (q_zav_dry(i,:) + q_zav_dry(91-i,:))./2;

htrt_hzav_wet(46-i,:) = (htrt_zav_wet(i,:) + htrt_zav_wet(91-i,:))./2;
htrt_hzav_dry(46-i,:) = (htrt_zav_dry(i,:) + htrt_zav_dry(91-i,:))./2;

radht_hzav_wet(46-i,:) = (radht_zav_wet(i,:) + radht_zav_wet(91-i,:))./2;
radht_hzav_dry(46-i,:) = (radht_zav_dry(i,:) + radht_zav_dry(91-i,:))./2;

cndht_hzav_wet(46-i,:) = (cndht_zav_wet(i,:) + cndht_zav_wet(91-i,:))./2;
cndht_hzav_dry(46-i,:) = (cndht_zav_dry(i,:) + cndht_zav_dry(91-i,:))./2;

cnvht_hzav_wet(46-i,:) = (cnvht_zav_wet(i,:) + cnvht_zav_wet(91-i,:))./2;
cnvht_hzav_dry(46-i,:) = (cnvht_zav_dry(i,:) + cnvht_zav_dry(91-i,:))./2;

difht_hzav_wet(46-i,:) = (difht_zav_wet(i,:) + difht_zav_wet(91-i,:))./2;
difht_hzav_dry(46-i,:) = (difht_zav_dry(i,:) + difht_zav_dry(91-i,:))./2;

end


%take difference

uE_hzav_wtd = uE_hzav_wet - uE_hzav_dry;
vN_hzav_wtd = vN_hzav_wet - vN_hzav_dry;
theta_hzav_wtd = theta_hzav_wet - theta_hzav_dry;
temp_hzav_wtd = temp_hzav_wet - temp_hzav_dry;
uv_ed_hzav_wtd = uv_ed_hzav_wet - uv_ed_hzav_dry;
vt_ed_hzav_wtd = vt_ed_hzav_wet - vt_ed_hzav_dry;
w_hzav_wtd = w_hzav_wet - w_hzav_dry;
q_hzav_wtd = q_hzav_wet - q_hzav_dry;
htrt_hzav_wtd = htrt_hzav_wet - htrt_hzav_dry;
radht_hzav_wtd = radht_hzav_wet - radht_hzav_dry;
cndht_hzav_wtd = cndht_hzav_wet - cndht_hzav_dry;
cnvht_hzav_wtd = cnvht_hzav_wet - cnvht_hzav_dry;
difht_hzav_wtd = difht_hzav_wet - difht_hzav_dry;

%plot

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

%for each need to add: contours, colormaps, contour labelling

%PLOT 1

v=-25:2.5:45;
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,uE_hzav_dry',v);
colorbar;
colormap(b2r(-25,45));
set(gca,'YDir','reverse')
%hold on
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Zonal wind: ctrl, m/s'])
name=['best_plots.ps'];

%PLOT 2
v=-6:0.3:6;
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,vN_hzav_dry',v);
colorbar;
colormap(b2r(-6,6));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
freezeColors
cbfreeze(colorbar);
title(['Meridional wind: ctrl, m/s'])



v=-25:2.5:45;
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,uE_hzav_wet',v,'k');
colorbar;
colormap(b2r(-25,45));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Zonal wind: pert, m/s'])

%PLOT 4
v=-6:0.3:6;
axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,vN_hzav_wet',v,'k');
colorbar;
colormap(b2r(-6,6));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
title(['Meridional wind: pert, m/s'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
v=-10:2:30;
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,uE_hzav_wtd',v);
colorbar;
colormap(b2r(-10,30));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Zonal wind: pert - ctrl, m/s'])

%PLOT 6
v=-4:0.25:2;
axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,vN_hzav_wtd',v);
colorbar;
colormap(b2r(-4,2));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
freezeColors
cbfreeze(colorbar);
title(['Meridional wind: pert - ctrl, m/s'])

print('-dpsc',name)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if page2

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%for each need to add: contours, colormaps, contour labelling

%PLOT 1
v(1:21) = 250:5:350;
v(22:29) = 400:50:750;
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,theta_hzav_dry',v);
colorbar;
caxis([250 750])
clabel(C,h);
set(gca,'YDir','reverse')
%hold on
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Potential Temperature: ctrl, K'])
name=['best_plots.ps'];

%PLOT 2
v=175:5:300;
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,temp_hzav_dry',v);
colorbar;
caxis([175 300])
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
freezeColors
cbfreeze(colorbar);
title(['Temperature: ctrl, K'])


v(1:21) = 250:5:350;
v(22:29) = 400:50:750;
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,theta_hzav_wet',v,'k');
colorbar;
caxis([250 750])
clabel(C,h);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Potential Temperature: pert, K'])

%PLOT 4
v=175:5:300;
axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,temp_hzav_wet',20,'k');
colorbar;
caxis([175 300])
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
title(['Temperature: pert, K'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
v=-10:2.5:40;
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,theta_hzav_wtd',v);
colorbar;
clabel(C,h);
colormap(b2r(-10,40));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Potential Temperature: pert - ctrl, K'])

%PLOT 6
v=-5:2.5:30;
axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,temp_hzav_wtd',v);
colorbar;
clabel(C,h);
colormap(b2r(-5,30));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
freezeColors
cbfreeze(colorbar);
title(['Temperature: pert - ctrl, K'])

print('-dpsc',name,'-append')

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 3%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if page3 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%for each need to add: contours, colormaps, contour labelling

%PLOT 1
v= -50:5:50;
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,uv_ed_hzav_dry',v);
colorbar;
colormap(b2r(-50,50));
set(gca,'YDir','reverse')
%hold on
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Horiz eddy mom flux: ctrl, m^{2}/s^{2}'])
name=['best_plots.ps'];

%PLOT 2
v=-26:2:26;
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,vt_ed_hzav_dry',v);
colorbar;
colormap(b2r(-25,25));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
freezeColors
cbfreeze(colorbar);
title(['Meridional eddy theta trans: ctrl, Km/s'])

 %PLOT 3
v= -50:5:50;
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,uv_ed_hzav_wet',v,'k');
colorbar;
colormap(b2r(-50,50));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Horiz eddy mom flux: pert, m^{2}/s^{2}'])

%PLOT 4
v=-26:2:26;
axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,vt_ed_hzav_wet',v,'k');
colorbar;
colormap(b2r(-25,25));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
title(['Meridional eddy theta trans: pert, Km/s'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
v=-20:2:20;
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,uv_ed_hzav_wtd',v);
colorbar;
colormap(b2r(-20,20));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Horiz eddy mom flux: pert - ctrl, m^{2}/s^{2}'])

%PLOT 6
v=-5:1.25:15;
axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,vt_ed_hzav_wtd',v);
colorbar;
colormap(b2r(-5,15));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
freezeColors
cbfreeze(colorbar);
title(['Meridional eddy theta trans: pert - ctrl, Km/s'])



print('-dpsc',name,'-append')

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 4%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if page4

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%for each need to add: contours, colormaps, contour labelling

%PLOT 1
v=-0.2:0.02:0.1;
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,w_hzav_dry',v);
colorbar;
colormap(b2r(-0.2,0.1));
set(gca,'YDir','reverse')
%hold on
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Vertical wind: ctrl, m/s'])
name=['best_plots.ps'];

%PLOT 2
v=0:1e-3:20e-3;
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,q_hzav_dry',v);
colorbar;
colormap('default')
caxis([0 20e-3])
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
freezeColors
cbfreeze(colorbar);
title(['Specific humidity: ctrl, kg/kg'])

%PLOT 3
v=-0.2:0.02:0.1;
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,w_hzav_wet',v,'k');
colorbar;
colormap(b2r(-0.2,0.1));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Vertical wind: pert, m/s'])

%PLOT 4
v=0:1e-3:20e-3;
axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,q_hzav_wet',v);
colorbar;
colormap('default')
caxis([0 20e-3])
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
title(['Specific humidity: pert, kg/kg'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
v=-0.13:0.02:0.08;
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,w_hzav_wtd',v);
colorbar;
colormap(b2r(-0.13,0.08));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Vertical wind: pert - ctrl, m/s'])

%PLOT 6
v=0:1e-3:20e-3;
axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,q_hzav_wtd',v);
colorbar;
colormap(b2r(0.,20e-3));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
freezeColors
cbfreeze(colorbar);
title(['Specific humidity: pert - ctrl, kg/kg'])



print('-dpsc',name,'-append')

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 5%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if page5 


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%for each need to add: contours, colormaps, contour labelling

%PLOT 1
v=-4:0.2:0.6;
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,radht_hzav_dry',v);
colorbar;
colormap(b2r(-4,0.6));
set(gca,'YDir','reverse')
%hold on
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Radiative heating: ctrl, K/day'])
name=['best_plots.ps'];

%PLOT 2
v=-2:0.25:4;
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,difht_hzav_dry',v);
colorbar;
colormap(b2r(-2,4));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
freezeColors
cbfreeze(colorbar);
title(['Diffusive heating: ctrl, K/day'])

%PLOT 3
v=-4:0.2:0.6;
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,radht_hzav_wet',v,'k');
colorbar;
colormap(b2r(-4,0.6));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Radiative heating: pert, K/day'])

%PLOT 4
%v=-2:0.25:4;
axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,difht_hzav_wet',v,'k');
colorbar;
colormap(b2r(-2,4));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
title(['Diffusive heating: pert, K/day'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
v=-2.6:0.2:1.6;
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,radht_hzav_wtd',v);
colorbar;
colormap(b2r(-2.6,1.6));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Radiative heating: pert - ctrl, K/day'])

%PLOT 6
v=-4:0.25:1;
axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,difht_hzav_wtd',v);
colorbar;
colormap(b2r(-4,1));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
freezeColors
cbfreeze(colorbar);
title(['Diffusive heating: pert - ctrl, K/day'])

print('-dpsc',name,'-append')


end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 6%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if page6

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%for each need to add: contours, colormaps, contour labelling

%PLOT 1
v=0:0.15:6;
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,cndht_hzav_dry',v);
colorbar;
colormap(b2r(0,6));
set(gca,'YDir','reverse')
%hold on
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Condensational heating: ctrl, K/day'])
name=['best_plots.ps'];

%PLOT 2
v=-1:0.125:1.5;
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,cnvht_hzav_dry',v);
colorbar;
colormap(b2r(-1,1.5));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
freezeColors
cbfreeze(colorbar);
title(['Convective heating: ctrl, K/day'])

%PLOT 3
v=0:0.5:6;
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,cndht_hzav_wet',v);
colorbar;
colormap(b2r(0,6));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Condensational heating: pert, K/day'])

%PLOT 4
v=-1:0.125:1.5;
axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,cnvht_hzav_wet',v);
colorbar;
colormap(b2r(-1,1.5));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
title(['Convective heating: pert, K/day'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
v=0:0.5:6;
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,cndht_hzav_wtd',v);
colorbar;
colormap(b2r(0,6));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Condensational heating: pert - ctrl, K/day'])

%PLOT 6
v=-1:0.125:1.5;
axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,cnvht_hzav_wtd',v);
colorbar;
colormap(b2r(-1,1.5));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
freezeColors
cbfreeze(colorbar);
title(['Convective heating: pert - ctrl, K/day'])



 print('-dpsc',name,'-append')

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 7%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if page7

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%for each need to add: contours, colormaps, contour labelling

%PLOT 1
v=-2:0.5:6.5;
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,htrt_hzav_dry',v);
colorbar;
colormap(b2r(-2,6.5));
set(gca,'YDir','reverse')
%hold on
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Total heating: ctrl, K/day'])
name=['best_plots.ps'];

%PLOT 2
%axes('position',[pos2x pos2y xSize_sub ySize_sub])
%[C,h]=contourf(ylat(46:90),rC./100.,vN_hzav_dry',v);
%colorbar;
%set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
%freezeColors
%cbfreeze(colorbar);
%title(['Meridional wind: ctrl, m/s'])

%PLOT 3
v=-2:0.5:6.5;
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,htrt_hzav_wet',v);
colorbar;
colormap(b2r(-2,6.5));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Total heating: pert, K/day'])

%PLOT 4
%axes('position',[pos4x pos4y xSize_sub ySize_sub])
%[C,h]=contourf(ylat(46:90),rC./100.,vN_hzav_wet',20,'k');
%colorbar;
%set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
%title(['Meridional wind: pert, m/s'])
%freezeColors
%cbfreeze(colorbar);

%PLOT 5
v=-2:0.5:6;
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat(46:90),rC./100.,htrt_hzav_wtd',v);
colorbar;
colormap(b2r(-2,6));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Total heating: pert - ctrl, K/day'])

%PLOT 6
%axes('position',[pos6x pos6y xSize_sub ySize_sub])
%[C,h]=contourf(ylat(46:90),rC./100.,vN_hzav_wtd',v);
%colorbar;
%set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
%xlabel('Latitude')
%freezeColors
%cbfreeze(colorbar);
%title(['Meridional wind: pert - ctrl, m/s'])



print('-dpsc',name,'-append')

end

return


