%load up 'ensemble runs' take diffs from equiv control years and av results

load('ensemble_load_1.mat')

theta_diff_1 = theta_diff;
temp_diff_1 = temp_diff;
uE_diff_1 = uE_diff;
vN_diff_1 = vN_diff;
w_diff_1 = w_diff;
Fphi_scaled_diff_1 = Fphi_scaled_diff;
Fp_scaled_diff_1 = Fp_scaled_diff;


load('ensemble_load_2.mat')

theta_diff_2 = theta_diff;
temp_diff_2 = temp_diff;
uE_diff_2 = uE_diff;
vN_diff_2 = vN_diff;
w_diff_2 = w_diff;
Fphi_scaled_diff_2 = Fphi_scaled_diff;
Fp_scaled_diff_2 = Fp_scaled_diff;


%load('ensemble_load_3.mat')

%theta_diff_3 = theta_diff;
%temp_diff_3 = temp_diff;
%uE_diff_3 = uE_diff;
%vN_diff_3 = vN_diff;
%w_diff_3 = w_diff;
%Fphi_scaled_diff_3 = Fphi_scaled_diff;
%Fp_scaled_diff_3 = Fp_scaled_diff;


theta_diff_av = (theta_diff_1 + theta_diff_2)./2; % + theta_diff_3)./3;
temp_diff_av = (temp_diff_1 + temp_diff_2)./2; % + temp_diff_3)./3;
uE_diff_av = (uE_diff_1 + uE_diff_2)./2; % + uE_diff_3)./3;
vN_diff_av = (vN_diff_1 + vN_diff_2)./2; % + vN_diff_3)./3;
w_diff_av = (w_diff_1 + w_diff_2)./2; % + w_diff_3)./3;
Fphi_scaled_diff_av = (Fphi_scaled_diff_1 + Fphi_scaled_diff_2)./2; % + Fphi_scaled_diff_3)./3;
Fp_scaled_diff_av = (Fp_scaled_diff_1 + Fp_scaled_diff_2)./2; % + Fp_scaled_diff_3)./3;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% Plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



ylat = -89:2:89;
rC = 98000:-4000:2000;

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
v=-10:1:10.;
[C,h]=contourf(ylat,rC./100.,uE_diff_av(:,:,1)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,uE_diff_av(:,:,1)',v,'k:');
colorbar;
colormap(b2r(-10,10.5));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Zonal wind, m/s, 1st Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);
name=['uE_ens.ps'];

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-10:1:10.5;
[C,h]=contourf(ylat,rC./100.,uE_diff_av(:,:,2)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,uE_diff_av(:,:,2)',v,'k:');
colorbar;
colormap(b2r(-10,10.5));
set(gca,'YDir','reverse')
title(['Zonal wind, m/s, 2nd Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-10:1:10.5;
[C,h]=contourf(ylat,rC./100.,uE_diff_av(:,:,3)',v);
hold on
v=-1000:1000:1000;
[C,h]=contour(ylat,rC./100.,uE_diff_av(:,:,3)',v,'k:');
colorbar;
colormap(b2r(-10,10.5));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Zonal wind, m/s, 3rd Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 4
axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-10:1:10.5;
[C,h]=contourf(ylat,rC./100.,uE_diff_av(:,:,4)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,uE_diff_av(:,:,4)',v,'k:');
colorbar;
colormap(b2r(-10,10.5));
set(gca,'YDir','reverse')
title(['Zonal wind, m/s, 4th Ten Days'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
v=-10:1:10.5;
[C,h]=contourf(ylat,rC./100.,uE_diff_av(:,:,5)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,uE_diff_av(:,:,5)',v,'k:');
colorbar;
colormap(b2r(-10,10.5));
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title(['Zonal wind, m/s, 5th Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
v=-10:1:10.5;
[C,h]=contourf(ylat,rC./100.,uE_diff_av(:,:,6)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,uE_diff_av(:,:,6)',v,'k:');
colorbar;
colormap(b2r(-10,10.5));
set(gca,'YDir','reverse')
xlabel('Latitude')
title(['Zonal wind, m/s, 6th Ten Days'])
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


%PLOT 1
axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-3:0.3:3;
[C,h]=contourf(ylat,rC./100.,vN_diff_av(:,:,1)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,vN_diff_av(:,:,1)',v,'k:');
colorbar;
colormap(b2r(-3,3));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Meridional wind, m/s, 1st Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);
name=['vN_ens.ps'];

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-3:0.3:3;
[C,h]=contourf(ylat,rC./100.,vN_diff_av(:,:,2)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,vN_diff_av(:,:,2)',v,'k:');
colorbar;
colormap(b2r(-3,3));
set(gca,'YDir','reverse')
title(['Meridional wind, m/s, 2nd Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-3:0.3:3;
[C,h]=contourf(ylat,rC./100.,vN_diff_av(:,:,3)',v);
hold on
v=-1000:1000:1000;
[C,h]=contour(ylat,rC./100.,vN_diff_av(:,:,3)',v,'k:');
colorbar;
colormap(b2r(-3,3));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Meridional wind, m/s, 3rd Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 4
axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-3:0.3:3;
[C,h]=contourf(ylat,rC./100.,vN_diff_av(:,:,4)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,vN_diff_av(:,:,4)',v,'k:');
colorbar;
colormap(b2r(-3,3));
set(gca,'YDir','reverse')
title(['Meridional wind, m/s, 4th Ten Days'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
v=-3:0.3:3;
[C,h]=contourf(ylat,rC./100.,vN_diff_av(:,:,5)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,vN_diff_av(:,:,5)',v,'k:');
colorbar;
colormap(b2r(-3,3));
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title(['Meridional wind, m/s, 5th Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
v=-3:0.3:3;
[C,h]=contourf(ylat,rC./100.,vN_diff_av(:,:,6)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,vN_diff_av(:,:,6)',v,'k:');
colorbar;
colormap(b2r(-3,3));
set(gca,'YDir','reverse')
xlabel('Latitude')
title(['Meridional wind, m/s, 6th Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);


 print('-dpsc',name)



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
v=-4:0.5:10;
[C,h]=contourf(ylat,rC./100.,temp_diff_av(:,:,1)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,temp_diff_av(:,:,1)',v,'k:');
colorbar;
colormap(b2r(-4,10));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Temperature, K, 1st Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);
name=['temp_ens.ps'];

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-4:0.5:10;
[C,h]=contourf(ylat,rC./100.,temp_diff_av(:,:,2)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,temp_diff_av(:,:,2)',v,'k:');
colorbar;
colormap(b2r(-4,10));
set(gca,'YDir','reverse')
title(['Temperature, K, 2nd Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-4:0.5:10;
[C,h]=contourf(ylat,rC./100.,temp_diff_av(:,:,3)',v);
hold on
v=-1000:1000:1000;
[C,h]=contour(ylat,rC./100.,temp_diff_av(:,:,3)',v,'k:');
colorbar;
colormap(b2r(-4,10));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Temperature, K, 3rd Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 4
axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-4:0.5:10;
[C,h]=contourf(ylat,rC./100.,temp_diff_av(:,:,4)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,temp_diff_av(:,:,4)',v,'k:');
colorbar;
colormap(b2r(-4,10));
set(gca,'YDir','reverse')
title(['Temperature, K, 4th Ten Days'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
v=-4:0.5:10;
[C,h]=contourf(ylat,rC./100.,temp_diff_av(:,:,5)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,temp_diff_av(:,:,5)',v,'k:');
colorbar;
colormap(b2r(-4,10));
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title(['Temperature, K, 5th Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
v=-4:0.5:10;
[C,h]=contourf(ylat,rC./100.,temp_diff_av(:,:,6)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,temp_diff_av(:,:,6)',v,'k:');
colorbar;
colormap(b2r(-4,10));
set(gca,'YDir','reverse')
xlabel('Latitude')
title(['Temperature, K, 6th Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);


 print('-dpsc',name)




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

labelling = num2str(shiftdim([10000:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*(Fphi_scaled_diff_av(:,:,1)') ,1.6e-20.*(Fp_scaled_diff_av(:,:,1)') ,'k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
title(['EP Flux diff, 1st Ten Days'])
hold on
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off
name=['ep_ens.ps'];

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
labelling = num2str(shiftdim([10000:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*(Fphi_scaled_diff_av(:,:,2)') ,1.6e-20.*(Fp_scaled_diff_av(:,:,2)') ,'k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
title(['EP Flux diff, 2nd Ten Days'])
hold on
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
labelling = num2str(shiftdim([10000:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*(Fphi_scaled_diff_av(:,:,3)') ,1.6e-20.*(Fp_scaled_diff_av(:,:,3)') ,'k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
title(['EP Flux diff, 3rd Ten Days'])
hold on
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off

%PLOT 4
axes('position',[pos4x pos4y xSize_sub ySize_sub])
labelling = num2str(shiftdim([10000:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*(Fphi_scaled_diff_av(:,:,4)') ,1.6e-20.*(Fp_scaled_diff_av(:,:,4)') ,'k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
title(['EP Flux diff, 4th Ten Days'])
hold on
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
labelling = num2str(shiftdim([10000:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*(Fphi_scaled_diff_av(:,:,5)') ,1.6e-20.*(Fp_scaled_diff_av(:,:,5)') ,'k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
title(['EP Flux diff, 5th Ten Days'])
hold on
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
labelling = num2str(shiftdim([10000:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*(Fphi_scaled_diff_av(:,:,6)') ,1.6e-20.*(Fp_scaled_diff_av(:,:,6)') ,'k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
title(['EP Flux diff, 6th Ten Days'])
hold on
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off


 print('-dpsc',name)
