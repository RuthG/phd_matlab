%load in total heating and vTheta and see if these balance?


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
ny=90;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%

niti = 62640;
nits = 240;
nitt = 86400;

var(1,:) = 'UVEL    ';
var(2,:) = 'THETA   ';
var(3,:) = 'UVELTH  ';
var(4,:) = 'WVELTH  ';
var(5,:) = 'AtPhdTdt';
var(6,:) = 'AtPhdTrd';
var(7,:) = 'AtPhdTdf';
var(8,:) = 'AtPhdTcv';
var(9,:) = 'AtPhdTcd';


varv(1,:) = 'VVEL    ';
varv(2,:) = '        ';
varv(3,:) = 'VVELTH  ';
varv(4:9,1:8) = ' ';

clear rDir
rDir(1,:)=cellstr('/project/rg312/run_radon_varyingwin/');
rDir(2,:)=cellstr('/project/rg312/run_radon_cwnp/');
[tzav,tzavv] = mit_zavs(rDir,var,niti,nitt,nits,'varv',varv);

clear rDir
rDir=cellstr('/project/rg312/run_radon_doshallower/');
[tzav_orig,tzavv_orig] = mit_zavs(rDir,var,432000,'varv',varv);


vNth_zon_vw = tzav(:,:,2,1).*tzavv(:,:,1,1);
vNth_ed_vw = tzavv(:,:,3,1) - vNth_zon_vw;
vNth_zon_np = tzav(:,:,2,2).*tzavv(:,:,1,2);
vNth_ed_np = tzavv(:,:,3,2) - vNth_zon_np;
vNth_zon_orig = tzav_orig(:,:,2,1).*tzavv_orig(:,:,1,1);
vNth_ed_orig = tzavv_orig(:,:,3,1) - vNth_zon_orig;

yi = -89:2:90;
vNth_vw_conv = -dlat(tzavv(:,:,3,1),yi);
vNth_np_conv = -dlat(tzavv(:,:,3,2),yi);
vNth_orig_conv = -dlat(tzavv_orig(:,:,3,1),yi);
vNth_zon_vw_conv = -dlat(vNth_zon_vw,yi);
vNth_zon_np_conv = -dlat(vNth_zon_np,yi);
vNth_zon_orig_conv = -dlat(vNth_zon_orig,yi);
vNth_ed_vw_conv = -dlat(vNth_ed_vw,yi);
vNth_ed_np_conv = -dlat(vNth_ed_np,yi);
vNth_ed_orig_conv = -dlat(vNth_ed_orig,yi);


%density weighted height integral = pressure integral/g
%cp puts this into W/m-2
g=9.81;
cp=1004.64;
intfac = 4000.*cp./g;
a=6371.0e3;

%vertically integrate vNth conv
vNth_vw_vint = intfac.*sum(vNth_vw_conv,2);
vNth_np_vint = intfac.*sum(vNth_np_conv,2);
vNth_orig_vint = intfac.*sum(vNth_orig_conv,2);

vNth_ed_vw_vint = intfac.*sum(vNth_ed_vw_conv,2);
vNth_ed_np_vint = intfac.*sum(vNth_ed_np_conv,2);
vNth_ed_orig_vint = intfac.*sum(vNth_ed_orig_conv,2);

vNth_zon_vw_vint = intfac.*sum(vNth_zon_vw_conv,2);
vNth_zon_np_vint = intfac.*sum(vNth_zon_np_conv,2);
vNth_zon_orig_vint = intfac.*sum(vNth_zon_orig_conv,2);


htrt_vw_vint = sum(tzav(:,:,5,1),2).*intfac;
radht_vw_vint = sum(tzav(:,:,6,1),2).*intfac;
difht_vw_vint = sum(tzav(:,:,7,1),2).*intfac;
cnvht_vw_vint = sum(tzav(:,:,8,1),2).*intfac;
cndht_vw_vint = sum(tzav(:,:,9,1),2).*intfac;

htrt_np_vint = sum(tzav(:,:,5,2),2).*intfac;
radht_np_vint = sum(tzav(:,:,6,2),2).*intfac;
difht_np_vint = sum(tzav(:,:,7,2),2).*intfac;
cnvht_np_vint = sum(tzav(:,:,8,2),2).*intfac;
cndht_np_vint = sum(tzav(:,:,9,2),2).*intfac;


htrt_orig_vint = sum(tzav_orig(:,:,5),2).*intfac;
radht_orig_vint = sum(tzav_orig(:,:,6),2).*intfac;
difht_orig_vint = sum(tzav_orig(:,:,7),2).*intfac;
cnvht_orig_vint = sum(tzav_orig(:,:,8),2).*intfac;
cndht_orig_vint = sum(tzav_orig(:,:,9),2).*intfac;





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


axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi,htrt_np_vint,'k')
hold on
xlabel('Latitude')
ylabel('Vertically integrated heating rate, Wm^{-2}')
title('Const Window, Improved Fit')
plot(yi,-vNth_np_vint,'c')
plot(yi,-vNth_np_vint-htrt_np_vint,'r')
ylim([-150 550])
xlim([-90 90])

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi,htrt_vw_vint,'k')
hold on
title('Varying Window Frac')
plot(yi,-vNth_vw_vint,'c')
plot(yi,-vNth_vw_vint-htrt_vw_vint,'r')
ylim([-150 550])
xlim([-90 90])

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi,htrt_orig_vint,'k')
hold on
ylabel('Vertically integrated heating rate, Wm^{-2}')
title('Original Radiation Scheme')
plot(yi,-vNth_orig_vint,'c')
plot(yi,-vNth_orig_vint-htrt_orig_vint,'r')
ylim([-150 550])
xlim([-90 90])

print('-dpdf','vertheat_check.pdf')




hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi,htrt_np_vint,'k')
hold on
xlabel('Latitude')
ylabel('Vertically integrated heating rate, Wm^{-2}')
title('0.5xwv')
plot(yi,cndht_np_vint+cnvht_np_vint)
plot(yi,radht_np_vint,'g')
plot(yi,difht_np_vint,'r')
%plot(yi,-vNth_np_vint,'c')
%plot(yi,-vNth_ed_np_vint,'c')
%plot(yi,-vNth_zon_np_vint,'c--')
ylim([-150 450])
xlim([-90 90])

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi,htrt_vw_vint,'k')
hold on
title('0.25xwv')
plot(yi,cndht_vw_vint+cnvht_vw_vint)
plot(yi,radht_vw_vint,'g')
plot(yi,difht_vw_vint,'r')
%plot(yi,-vNth_vw_vint,'c')
%plot(yi,-vNth_ed_vw_vint,'c')
%plot(yi,-vNth_zon_vw_vint,'c--')
ylim([-150 450])
xlim([-90 90])

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi,htrt_orig_vint,'k')
hold on
ylabel('Vertically integrated heating rate, Wm^{-2}')
title('0xwv')
plot(yi,cndht_orig_vint+cnvht_orig_vint)
plot(yi,radht_orig_vint,'g')
plot(yi,difht_orig_vint,'r')
%plot(yi,-vNth_orig_vint,'c')
%plot(yi,-vNth_ed_orig_vint,'c')
%plot(yi,-vNth_zon_orig_vint,'c--')
ylim([-150 450])
xlim([-90 90])
h=legend('Q_{diabatic}','Q_{latent}','Q_{radiative}','Q_{sensible}'); %,'v''\theta'' Divergence');

print('-dpdf','vertheat.pdf')

