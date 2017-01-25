%produce snapshots of temp evolution (10 day avs) to get idea of how long to run to check total T change

load('means_ctrl.mat')

rDir = '/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_twoyrdaily_pert_new_heating/';

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


%read fields
i=0;
for nit = 691440:240:864000;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp(:,:,j,i)=theta(:,:,j,i).*convthetatoT(j,1);
end

end

for i=1:72
temp_tav(:,:,:,i) = mean(temp(:,:,:, (i-1).*10 + (1:10) ),4);
[temp_ztav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(temp_tav(:,:,:,i),ny,yc,ar,hc);
end

[temp_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(temp_ctrl_mean,ny,yc,ar,hc);

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PAGE 1

unix('rm -r temp_ev_new.ps')

for i=1:12

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%for each need to add: contours, colormaps, contour labelling

%PLOT 1
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,(i-1)*6+1)'-temp_zav_c',20);
colorbar;caxis([0 10]);
set(gca,'YDir','reverse')
%hold on
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
name=['temp_ev_new.ps'];

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,(i-1)*6+2)'-temp_zav_c',20);
colorbar;caxis([0 10]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
freezeColors
cbfreeze(colorbar);

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,(i-1)*6+3)'-temp_zav_c',20,'k');
colorbar;caxis([0 10]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);

%PLOT 4
axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,(i-1)*6+4)'-temp_zav_c',20,'k');
colorbar;caxis([0 10]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
freezeColors
cbfreeze(colorbar);

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,(i-1)*6+5)'-temp_zav_c',20);
colorbar;caxis([0 10]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,(i-1)*6+6)'-temp_zav_c',20);
colorbar;caxis([0 10]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
freezeColors
cbfreeze(colorbar);



print('-dpsc',name,'-append')

end

return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PAGE 2

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%for each need to add: contours, colormaps, contour labelling

%PLOT 1
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,7)'-temp_zav_c',20);
colorbar;caxis([0 10]);
set(gca,'YDir','reverse')
%hold on
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 61-70, K'])
name=['best_plots.ps'];

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,8)'-temp_zav_c',20);
colorbar;caxis([0 10]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 71-80, K'])

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,9)'-temp_zav_c',20,'k');
colorbar;caxis([0 10]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 81-90, K'])

%PLOT 4
axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,10)'-temp_zav_c',20,'k');
colorbar;caxis([0 10]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
title(['Temperature: days 91-100, K'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,11)'-temp_zav_c',20);
colorbar;caxis([0 10]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 101-110, K'])

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,12)'-temp_zav_c',20);
colorbar;caxis([0 10]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 111-120, K'])

print('-dpsc',name,'-append')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PAGE 3

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%for each need to add: contours, colormaps, contour labelling

%PLOT 1
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,13)'-temp_zav_c',20);
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%hold on
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 121-130, K'])
name=['best_plots.ps'];

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,14)'-temp_zav_c',20);
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 131-140, K'])

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,15)'-temp_zav_c',20,'k');
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 141-150, K'])

%PLOT 4
axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,16)'-temp_zav_c',20,'k');
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
title(['Temperature: days 151-160, K'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,17)'-temp_zav_c',20);
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 161-170, K'])

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,18)'-temp_zav_c',20);
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 171-180, K'])

print('-dpsc',name,'-append')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PAGE 3

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%for each need to add: contours, colormaps, contour labelling

%PLOT 1
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,19)'-temp_zav_c',20);
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%hold on
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 181-190, K'])
name=['best_plots.ps'];

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,20)'-temp_zav_c',20);
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 191-200, K'])

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,21)'-temp_zav_c',20,'k');
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 201-210, K'])

%PLOT 4
axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,22)'-temp_zav_c',20,'k');
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
title(['Temperature: days 211-220, K'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,23)'-temp_zav_c',20);
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 221-230, K'])

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,24)'-temp_zav_c',20);
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 231-240, K'])

print('-dpsc',name,'-append')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PAGE 3

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%for each need to add: contours, colormaps, contour labelling

%PLOT 1
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,25)'-temp_zav_c',20);
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%hold on
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 241-250, K'])
name=['best_plots.ps'];

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,26)'-temp_zav_c',20);
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 251-260, K'])

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,27)'-temp_zav_c',20,'k');
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 261-270, K'])

%PLOT 4
axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,28)'-temp_zav_c',20,'k');
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
title(['Temperature: days 271-280, K'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,29)'-temp_zav_c',20);
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 281-290, K'])

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,30)'-temp_zav_c',20);
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 291-300, K'])

print('-dpsc',name,'-append')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PAGE 3

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%for each need to add: contours, colormaps, contour labelling

%PLOT 1
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,31)'-temp_zav_c',20);
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%hold on
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 301-310, K'])
name=['best_plots.ps'];

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,32)'-temp_zav_c',20);
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 311-320, K'])

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,33)'-temp_zav_c',20,'k');
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 321-330, K'])

%PLOT 4
axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,34)'-temp_zav_c',20,'k');
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
title(['Temperature: days 331-340, K'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,35)'-temp_zav_c',20);
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 341-350, K'])

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_ztav(:,:,36)'-temp_zav_c',20);
colorbar;caxis([0 35]);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
freezeColors
cbfreeze(colorbar);
title(['Temperature: days 351-360, K'])

print('-dpsc',name,'-append')


