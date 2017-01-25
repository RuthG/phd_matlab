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


psi_diff = psi_thd_ezav - psi_c_ezav;
uE_diff = uE_thd_ezav - uE_c_ezav;
theta_diff = theta_thd_ezav - theta_c_ezav;
htrt_diff = htrt_thd_ezav - htrt_c_ezav;
Fphi_diff = Fphi_scaled_thd_ezav - Fphi_scaled_c_ezav;
Fp_diff = Fp_scaled_thd_ezav - Fp_scaled_c_ezav;
fluxdiv_diff = fluxdiv_thd_ezav - fluxdiv_c_ezav;
eke_diff = eke_thd_ezav - eke_c_ezav;
qgref_diff = masking.*(qgref_thd_ezav - qgref_c_ezav);
vt_ed_diff = vt_ed_thd_ezav - vt_ed_c_ezav;




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
[C,h]=contourf(ylat(46:90),rC./100.,vt_ed_thd_shad(:,:,i)',v);
set(h,'edgecolor','none') 
colormap(flipud(gray)) ;
caxis([0 5])
hold on
v=-10:1:0;
[C,h]=contour(ylat(46:90),rC./100.,vt_ed_diff(:,:,i)',v,'k--');
clabel(C,h);
hold on
v=0:1:10;
[C,h]=contour(ylat(46:90),rC./100.,vt_ed_diff(:,:,i)',v,'k');
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

print('-dpdf','vt_tropheat10.pdf')


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
[C,h]=contourf(ylat(46:90),rC./100.,uE_thd_shad(:,:,i)',v);
set(h,'edgecolor','none') 
colormap(flipud(gray)) ;
caxis([0 5])
hold on
v=-10:2:0;
[C,h]=contour(ylat(46:90),rC./100.,uE_diff(:,:,i)',v,'k--');
clabel(C,h);
hold on
v=0:2:10;
[C,h]=contour(ylat(46:90),rC./100.,uE_diff(:,:,i)',v,'k');
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

print('-dpdf','u_tropheat10.pdf')

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
[C,h]=contourf(ylat(46:90),rC./100.,psi_thd_shad(:,:,i)',v);
set(h,'edgecolor','none') 
colormap(flipud(gray)) ;
caxis([0 5])
hold on
v=-100:25:0;
[C,h]=contour(ylat(46:90),rC./100.,psi_diff(:,:,i)'./1e9,v,'k--');
clabel(C,h);
hold on
v=0:25:200;
[C,h]=contour(ylat(46:90),rC./100.,psi_diff(:,:,i)'./1e9,v,'k');
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

print('-dpdf','psi_tropheat10.pdf')

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
[C,h]=contourf(ylat(46:90),rC./100.,theta_thd_shad(:,:,i)',v);
set(h,'edgecolor','none') 
colormap(flipud(gray)) ;
caxis([0 5])
hold on
v=-10:2:0;
[C,h]=contour(ylat(46:90),rC./100.,theta_diff(:,:,i)',v,'k--');
clabel(C,h);
hold on
v=0:2:20;
[C,h]=contour(ylat(46:90),rC./100.,theta_diff(:,:,i)',v,'k');
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

print('-dpdf','theta_tropheat10.pdf')

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
[C,h]=contourf(ylat(46:90),rC./100.,htrt_thd_shad(:,:,i)',v);
set(h,'edgecolor','none') 
colormap(flipud(gray)) ;
caxis([0 5])
hold on
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,htrt_diff(:,:,i)',v,'k--');
clabel(C,h);
hold on
v=0:1:20;
[C,h]=contour(ylat(46:90),rC./100.,htrt_diff(:,:,i)',v,'k');
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

print('-dpdf','htrt_tropheat10.pdf')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 5%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%%% test regridding
for i=1:23
for j=1:13
Fphi_diff_red(i,j,:) = Fphi_diff(i*2 -1, j*2 -1,:);
Fp_diff_red(i,j,:) = Fp_diff(i*2 -1, j*2 -1,:);
xspaces(i) = ylat(i*2+44 );
yspaces(j) = rC(j*2-1 );
end
end


for i=1:6
axes('position',[posx(i) posy(i) xSize_sub ySize_sub])
v=-400:50:400;
contourf(ylat(46:90),rC./10^3,qgref_diff(:,:,i)',v)
colormap(b2r(-400,400));
colorbar
caxis([-400 400]);
hold on
labelling = num2str(shiftdim([200:200:1000],1));
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_diff_red(:,:,i)',1.6e-20.*Fp_diff_red(:,:,i)','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
if rem(i,2) == 0 ; 
set(gca, 'YTickLabel', []);
else
ylabel('Pressure, hPa')
end
quiver(68, 21, 10, 0,'b');
text(68, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(68, 15, 0, -8,'b');
text(69, 12, '\fontsize{8}5E20 M3(PA)');
hold off
freezeColors
cbfreeze(colorbar);
end



print('-dpdf','qgref_tropheat10.pdf')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 6%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


for i=1:6
axes('position',[posx(i) posy(i) xSize_sub ySize_sub])
v=[0,1];
[C,h]=contourf(ylat(46:90),rC./100.,eke_thd_shad(:,:,i)',v);
set(h,'edgecolor','none') 
colormap(flipud(gray)) ;
caxis([0 5])
hold on
v=-100:10:0;
[C,h]=contour(ylat(46:90),rC./100.,eke_diff(:,:,i)',v,'k--');
clabel(C,h);
hold on
v=0:10:125;
[C,h]=contour(ylat(46:90),rC./100.,eke_diff(:,:,i)',v,'k');
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

print('-dpdf','eke_tropheat10.pdf')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 7%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%%% test regridding
for i=1:23
for j=1:13
Fphi_diff_red(i,j,:) = Fphi_diff(i*2 -1, j*2 -1,:);
Fp_diff_red(i,j,:) = Fp_diff(i*2 -1, j*2 -1,:);
xspaces(i) = ylat(i*2+44 );
yspaces(j) = rC(j*2-1 );
end
end


for i=1:6
axes('position',[posx(i) posy(i) xSize_sub ySize_sub])
v=[0,1];
[C,h]=contourf(ylat(46:90),rC./10^3.,Fp_thd_shad(:,:,i)',v);
set(h,'edgecolor','none') 
colormap(flipud(gray)) ;
caxis([0 5])
hold on
v=0:0.25:5;
[C,h] = contour(ylat(46:90),rC./10^3,fluxdiv_diff(:,:,i)'./1e16,v,'k');
clabel(C,h);
hold on
v=-5:0.25:0;
[C,h] = contour(ylat(46:90),rC./10^3,fluxdiv_diff(:,:,i)'./1e16,v,'k--');
clabel(C,h);
labelling = num2str(shiftdim([200:200:1000],1));
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_diff_red(:,:,i)',1.6e-20.*Fp_diff_red(:,:,i)','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
if rem(i,2) == 0 ; 
set(gca, 'YTickLabel', []);
else
ylabel('Pressure, hPa')
end
quiver(68, 21, 10, 0,'b');
text(68, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(68, 15, 0, -8,'b');
text(69, 12, '\fontsize{8}5E20 M3(PA)');
hold off
freezeColors
end


print('-dpdf','epflux_tropheat10.pdf')
