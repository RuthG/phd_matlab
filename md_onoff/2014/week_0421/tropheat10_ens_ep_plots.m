%Use ensemble data to plot tropheat spin-up

rDir='/disk1/MITgcm/verification/atm_gray_ruth/ensemble_control/';

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

load('ezav_thd.mat')
load('ezav_c.mat')
load('sig_thd.mat')

ylat = -89:2:89;

masking = zeros(45,25,6);
masking_load = zeros(45,25);

for i=1:6
masking_load(find(qgref_thd_ezav(:,:,i) >= 0 & qgref_c_ezav(:,:,i) >=0 )) = 1;
masking(:,:,i) = masking_load;
end

Fphi_diff = Fphi_scaled_thd_ezav - Fphi_scaled_c_ezav;
Fp_diff = Fp_scaled_thd_ezav - Fp_scaled_c_ezav;
fluxdiv_diff = fluxdiv_thd_ezav - fluxdiv_c_ezav;
qgref_diff = masking.*(qgref_thd_ezav - qgref_c_ezav);





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

posx = [0.1,0.55,0.1,0.55,0.1,0.55];
posy = [2/3+0.05,2/3+0.05,1/3+0.05,1/3+0.05,0.05,0.05];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

for i=1:6
axes('position',[posx(i) posy(i) xSize_sub ySize_sub])
v=[0,1];
[C,h]=contourf(ylat(46:90),rC./100.,qgref_thd_shad(:,:,i)',v);
set(h,'edgecolor','none') 
colormap(flipud(gray)) ;
caxis([0 5])
hold on
v=0:50:400;
[C,h]=contour(ylat(46:90),rC./100,qgref_diff(:,:,i)',v,'k');
clabel(C,h);
v=-400:50:0;
[C,h]=contour(ylat(46:90),rC./100,qgref_diff(:,:,i)',v,'k--');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
if rem(i,2) == 0 ; 
set(gca, 'YTickLabel', []);
else
ylabel('Pressure, hPa')
end
hold off
freezeColors
end

print('-dpdf','qgref_only_tropheat10.pdf')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

for i=1:6
axes('position',[posx(i) posy(i) xSize_sub ySize_sub])
v=[0,1];
[C,h]=contourf(ylat(46:90),rC./100.,fluxdiv_thd_shad(:,:,i)',v);
set(h,'edgecolor','none') 
colormap(flipud(gray)) ;
caxis([0 5])
hold on
v=0:0.25:5;
[C,h] = contour(ylat(46:90),rC./100,fluxdiv_diff(:,:,i)'./1e16,v,'k');
clabel(C,h);
hold on
v=-5:0.25:0;
[C,h] = contour(ylat(46:90),rC./100,fluxdiv_diff(:,:,i)'./1e16,v,'k--');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
if rem(i,2) == 0 ; 
set(gca, 'YTickLabel', []);
else
ylabel('Pressure, hPa')
end
hold off
freezeColors
end

print('-dpdf','fluxdiff_ens_tropheat10.pdf')





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 3%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

for i=1:6
axes('position',[posx(i) posy(i) xSize_sub ySize_sub])
v=[0,1];
[C,h]=contourf(ylat(46:90),rC./100.,Fp_thd_shad(:,:,i)',v);
set(h,'edgecolor','none') 
colormap(flipud(gray)) ;
caxis([0 5])
hold on
v=0:1:7;
[C,h] = contour(ylat(46:90),rC./100,Fp_diff(:,:,i)'./1e19,v,'k');
clabel(C,h);
hold on
v=-7:1:0;
[C,h] = contour(ylat(46:90),rC./100,Fp_diff(:,:,i)'./1e19,v,'k--');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
if rem(i,2) == 0 ; 
set(gca, 'YTickLabel', []);
else
ylabel('Pressure, hPa')
end
hold off
freezeColors
end

print('-dpdf','Fp_ens_tropheat10.pdf')





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 4%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

for i=1:6
axes('position',[posx(i) posy(i) xSize_sub ySize_sub])
v=[0,1];
[C,h]=contourf(ylat(46:90),rC./100.,Fphi_thd_shad(:,:,i)',v);
set(h,'edgecolor','none') 
colormap(flipud(gray)) ;
caxis([0 5])
hold on
v=0:1:6;
[C,h] = contour(ylat(46:90),rC./100,Fphi_diff(:,:,i)'./1e14,v,'k');
clabel(C,h);
hold on
v=-6:1:0;
[C,h] = contour(ylat(46:90),rC./100,Fphi_diff(:,:,i)'./1e14,v,'k--');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
if rem(i,2) == 0 ; 
set(gca, 'YTickLabel', []);
else
ylabel('Pressure, hPa')
end
hold off
freezeColors
end

print('-dpdf','Fphi_ens_tropheat10.pdf')
