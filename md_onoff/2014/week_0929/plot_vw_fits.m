%load up data from SBDART and radiation_mod_np and plot lw heat rates


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
drC=squeeze(rdmds([rDir,'DRC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
ny=90;

xi=-179:2:180;yi=-89:2:90;
yy=yi*90/60*pi/180;
sinyy=sin(yy);
sst=27*(1-sinyy.*sinyy);
sst(find(abs(yi)>=60))=0;
t_surf=sst+273.15;
p = 2000:4000:98000;
p_half = 0.:4000:100000;
grav 		= 9.8;
cp_air 		= 287.04./(2./7);

load('../week_0929/rad_mod_param_tests/windowvarying/radmod_lw_2.mat')
tdt_lw2 = tdt_lw;
load('../week_0929/rad_mod_param_tests/windowvarying/radmod_lw_3.mat')
tdt_lw3 = tdt_lw;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-4:0.4:0.4;
[C,h] = contour(yi(2:89),p,tdt_lw2(2:89,:)'.*86400,v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title('LW heating rate, K/day (vw2)')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi(2:89),p,tdt_lw3(2:89,:)'.*86400,v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
title('LW heating rate, K/day (vw3)')

print('-dpdf','heatrates_lw_vw.pdf')

