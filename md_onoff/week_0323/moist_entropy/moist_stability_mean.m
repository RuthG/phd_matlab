%plot up mean moist stability


rDir='/project/rg312/wv_on_rad_off/run_000_best/';
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
yi = -89:2:89;
xi = -179:2:179;

load('/project/rg312/mat_files/snapshot_data/mtheta_snapshots_best.mat')

moisttheta_000_tav = mean(moisttheta_000,4);
clear moisttheta_000
moisttheta_ll_000_tav = cube2latlon(xc,yc,moisttheta_000_tav,xi,yi);
clear moisttheta_000_tav
moisttheta_000_tzav = squeeze(mean(moisttheta_ll_000_tav,1));

moisttheta_010_tav = mean(moisttheta_010,4);
clear moisttheta_010
moisttheta_ll_010_tav = cube2latlon(xc,yc,moisttheta_010_tav,xi,yi);
clear moisttheta_010_tav
moisttheta_010_tzav = squeeze(mean(moisttheta_ll_010_tav,1));

moisttheta_025_tav = mean(moisttheta_025,4);
clear moisttheta_025
moisttheta_ll_025_tav = cube2latlon(xc,yc,moisttheta_025_tav,xi,yi);
clear moisttheta_025_tav
moisttheta_025_tzav = squeeze(mean(moisttheta_ll_025_tav,1));

moisttheta_050_tav = mean(moisttheta_050,4);
clear moisttheta_050
moisttheta_ll_050_tav = cube2latlon(xc,yc,moisttheta_050_tav,xi,yi);
clear moisttheta_050_tav
moisttheta_050_tzav = squeeze(mean(moisttheta_ll_050_tav,1));

moisttheta_075_tav = mean(moisttheta_075,4);
clear moisttheta_075
moisttheta_ll_075_tav = cube2latlon(xc,yc,moisttheta_075_tav,xi,yi);
clear moisttheta_075_tav
moisttheta_075_tzav = squeeze(mean(moisttheta_ll_075_tav,1));

moisttheta_100_tav = mean(moisttheta_100,4);
clear moisttheta_100
moisttheta_ll_100_tav = cube2latlon(xc,yc,moisttheta_100_tav,xi,yi);
clear moisttheta_100_tav
moisttheta_100_tzav = squeeze(mean(moisttheta_ll_100_tav,1));

moisttheta_125_tav = mean(moisttheta_125,4);
clear moisttheta_125
moisttheta_ll_125_tav = cube2latlon(xc,yc,moisttheta_125_tav,xi,yi);
clear moisttheta_125_tav
moisttheta_125_tzav = squeeze(mean(moisttheta_ll_125_tav,1));

moisttheta_150_tav = mean(moisttheta_150,4);
clear moisttheta_150
moisttheta_ll_150_tav = cube2latlon(xc,yc,moisttheta_150_tav,xi,yi);
clear moisttheta_150_tav
moisttheta_150_tzav = squeeze(mean(moisttheta_ll_150_tav,1));

v = 270:10:400
figure
[C,h] = contour(yi,rC./100,moisttheta_000_tzav',v,'k');
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
set(gca,'YDir','reverse')
print('-dpng','moisttheta_000.png')

figure
[C,h] = contour(yi,rC./100,moisttheta_010_tzav',v,'k');
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
set(gca,'YDir','reverse')
print('-dpng','moisttheta_010.png')

figure
[C,h] = contour(yi,rC./100,moisttheta_025_tzav',v,'k');
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
set(gca,'YDir','reverse')
print('-dpng','moisttheta_025.png')

figure
[C,h] = contour(yi,rC./100,moisttheta_050_tzav',v,'k');
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
set(gca,'YDir','reverse')
print('-dpng','moisttheta_050.png')

figure
[C,h] = contour(yi,rC./100,moisttheta_075_tzav',v,'k');
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
set(gca,'YDir','reverse')
print('-dpng','moisttheta_075.png')

figure
[C,h] = contour(yi,rC./100,moisttheta_100_tzav',v,'k');
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
set(gca,'YDir','reverse')
print('-dpng','moisttheta_100.png')

figure
[C,h] = contour(yi,rC./100,moisttheta_125_tzav',v,'k');
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
set(gca,'YDir','reverse')
print('-dpng','moisttheta_125.png')

figure
[C,h] = contour(yi,rC./100,moisttheta_150_tzav',v,'k');
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
set(gca,'YDir','reverse')
print('-dpng','moisttheta_150.png')

