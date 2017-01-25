%compare fractions of descent to ascent in snapshots


% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_doshallower_5year/';
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%

niti = 259200;
nits = 86400;
nitt = 432000;



var(1,:) = 'WVEL    ';
var(2,:) = 'WVELSQ  ';
varv(1,:) = '        ';
varv(2,:) = '        ';

clear rDir
rDir(1,:)=cellstr('/project/rg312/wv_on_rad_off/run_doshallower_5year/');
rDir(2,:)=cellstr('/project/rg312/wv_on_rad_off/run_doshallower_5yearh/');
rDir(3,:)=cellstr('/project/rg312/wv_on_rad_off/run_doshallower_5yearq/');
rDir(4,:)=cellstr('/project/rg312/wv_on_rad_off/run_doshallower_5yeard/');
rDir(5,:)=cellstr('/project/rg312/wv_on_rad_off/run_doshallower_5yearth/');

tzav = mit_zavs(rDir,var,niti,nitt,nits,'varv',varv);

i=0
for nit = 259200:86400:432000;
i=i+1
rDir='/project/rg312/wv_on_rad_off/run_doshallower_5year/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);
J=find(strcmp(fldList,'WVEL    '));
w_av_w(:,:,:,i) = dyn(:,:,:,J);
w_w(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir='/project/rg312/wv_on_rad_off/run_doshallower_5yearh/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);
J=find(strcmp(fldList,'WVEL    '));
w_av_h(:,:,:,i) = dyn(:,:,:,J);
w_h(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir='/project/rg312/wv_on_rad_off/run_doshallower_5yearq/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);
J=find(strcmp(fldList,'WVEL    '));
w_av_q(:,:,:,i) = dyn(:,:,:,J);
w_q(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir='/project/rg312/wv_on_rad_off/run_doshallower_5yeard/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);
J=find(strcmp(fldList,'WVEL    '));
w_av_d(:,:,:,i) = dyn(:,:,:,J);
w_d(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir='/project/rg312/wv_on_rad_off/run_doshallower_5yearth/';[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);
J=find(strcmp(fldList,'WVEL    '));
w_av_th(:,:,:,i) = dyn(:,:,:,J);
w_th(:,:,:,i)=rdmds([rDir,'W'],nit);

end


xi=-179:2:180;yi=-89:2:90;
wll_av_w = cube2latlon(xc,yc,w_av_w,xi,yi);
wll_av_h = cube2latlon(xc,yc,w_av_h,xi,yi);
wll_av_q = cube2latlon(xc,yc,w_av_q,xi,yi);
wll_av_d = cube2latlon(xc,yc,w_av_d,xi,yi);
wll_av_th = cube2latlon(xc,yc,w_av_th,xi,yi);
wll_w = cube2latlon(xc,yc,w_w,xi,yi);
wll_h = cube2latlon(xc,yc,w_h,xi,yi);
wll_q = cube2latlon(xc,yc,w_q,xi,yi);
wll_d = cube2latlon(xc,yc,w_d,xi,yi);
wll_th = cube2latlon(xc,yc,w_th,xi,yi);


wsq_ed_zav = tzav(:,:,2,:) - tzav(:,:,1,:).^2;


latmask = (abs(yc(:,:)) > 20); % & abs(yc(:,:) < 60));

for i=1:3
area_asc_w(:,:,i) = latmask.*(w_w(:,:,13,i) < 0).*ar;
area_asc_h(:,:,i) = latmask.*(w_h(:,:,13,i) < 0).*ar;
area_asc_q(:,:,i) = latmask.*(w_q(:,:,13,i) < 0).*ar;
area_asc_d(:,:,i) = latmask.*(w_d(:,:,13,i) < 0).*ar;
area_asc_th(:,:,i) = latmask.*(w_th(:,:,13,i) < 0).*ar;
end

total_area(1,:) = squeeze(sum(sum(area_asc_w,1),2))./sum(sum(ar));
total_area(2,:) = squeeze(sum(sum(area_asc_h,1),2))./sum(sum(ar));
total_area(3,:) = squeeze(sum(sum(area_asc_q,1),2))./sum(sum(ar));
total_area(4,:) = squeeze(sum(sum(area_asc_d,1),2))./sum(sum(ar));
total_area(5,:) = squeeze(sum(sum(area_asc_th,1),2))./sum(sum(ar));

mean_area = mean(total_area,2)

%FOURIER TRANSFORM START, NEEDS WORK! 
%Need to check waveno comes out correctly and think

x_w = wll_w(:,61,13,1);
x_h = wll_h(:,61,13,1);
x_q = wll_q(:,61,13,1);
x_d = wll_d(:,61,13,1);

fftx_w = fft(x_w);
fftx_h = fft(x_h);
fftx_q = fft(x_q);
fftx_d = fft(x_d);

return
figure
plot([1,0.5,0.25,0,0.5],total_area,'xr');
hold on
plot([1,0.5,0.25,0,0.5],mean_area,'x');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%

%# centimeters units
Y = 21.0;                  %# A4 paper size
X = 29.7;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 2*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 2*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.3; %0.4;
xSize_sub = 1./2-0.1;

pos1x = 0.1 ; 	pos1y = 0.45; %1/2+0.05;
pos2x = 0.55;	pos2y = 0.45; %1/2+0.05;
pos3x = 0.1; 	pos3y = 0.05;
pos4x = 0.55; 	pos4y = 0.05;

v=-0.1:0.01:0.05;

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,tzav(:,:,1,4)',v,'k');
clabel(C,h);
title(['0xwv'])
ylabel('Pressure, hPa')
set(gca,'YDir','reverse')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,tzav(:,:,1,3)',v,'k');
clabel(C,h);
title(['0.25xwv'])
set(gca,'YDir','reverse')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,tzav(:,:,1,2)',v,'k');
clabel(C,h);
title(['0.5xwv'])
ylabel('Pressure, hPa')
xlabel('Latitude')
set(gca,'YDir','reverse') 

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,tzav(:,:,1,1)',v,'k');
clabel(C,h);
title(['1xwv'])
xlabel('Latitude')
set(gca,'YDir','reverse')

print('-dpdf','w.pdf')






v=-0.01:0.005:0.05;

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,tzav(:,:,1,4)',v,'k');
clabel(C,h);
title(['0xwv'])
ylabel('Pressure, hPa')
set(gca,'YDir','reverse')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,tzav(:,:,1,3)',v,'k');
clabel(C,h);
title(['0.25xwv'])
set(gca,'YDir','reverse')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,tzav(:,:,1,2)',v,'k');
clabel(C,h);
title(['0.5xwv'])
ylabel('Pressure, hPa')
xlabel('Latitude')
set(gca,'YDir','reverse') 

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,tzav(:,:,1,1)',v,'k');
clabel(C,h);
title(['1xwv'])
xlabel('Latitude')
set(gca,'YDir','reverse')

print('-dpdf','w_storm_track.pdf')

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,tzav(:,:,1,5)',v,'k');
clabel(C,h);
title(['0.5xwv + tropheat'])
ylabel('Pressure, hPa')
xlabel('Latitude')
set(gca,'YDir','reverse')







v=0:0.005:0.06;

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,wsq_ed_zav(:,:,1,4)',v,'k');
clabel(C,h);
title(['0xwv'])
ylabel('Pressure, hPa')
set(gca,'YDir','reverse')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,wsq_ed_zav(:,:,1,3)',v,'k');
clabel(C,h);
title(['0.25xwv'])
set(gca,'YDir','reverse')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,wsq_ed_zav(:,:,1,2)',v,'k');
clabel(C,h);
title(['0.5xwv'])
ylabel('Pressure, hPa')
xlabel('Latitude')
set(gca,'YDir','reverse') 

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,wsq_ed_zav(:,:,1,1)',v,'k');
clabel(C,h);
title(['1xwv'])
xlabel('Latitude')
set(gca,'YDir','reverse')

print('-dpdf','wsq_ed_storm_track.pdf')



return

for i=1:25

v=-0.8:0.05:0.8;

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi,wll_d(:,:,i,1)',v,'k');
caxis([-0.8 0.8])
colorbar
title(['0xwv'])
ylabel('Latitude')
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi,wll_q(:,:,i,1)',v,'k');
caxis([-0.8 0.8])
colorbar
title(['0.25xwv'])
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi,wll_h(:,:,i,1)',v,'k');
caxis([-0.8 0.8])
colorbar
title(['0.5xwv'])
ylabel('Latitude')
xlabel('Longitude')
set(gca,'YDir','reverse') 
freezeColors
cbfreeze(colorbar);

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contourf(xi,yi,wll_w(:,:,i,1)',v,'k');
caxis([-0.8 0.8])
colorbar
title(['1xwv'])
xlabel('Longitude')
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);

name = ['w_snapshots_' num2str(rC(i)./100) '.png'];
print('-dpng',name)

close all

end
