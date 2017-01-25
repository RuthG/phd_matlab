%load in different heating terms for averages and plot nicely!


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';
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
for nit = 432000:86400:604800;
i=i+1
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_c(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_c(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_c(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_c(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_c(:,:,:,i)=dyn(:,:,:,J);



rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv_tropheat3eq/';
nit_q = nit + 518400;
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit_q);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_th(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_th(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_th(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_th(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_th(:,:,:,i)=dyn(:,:,:,J);



rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_w(:,:,:,i)=dyn(:,:,:,J);

end

%calc zon, time, hzav

[htrt_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_c,ny,yc,ar,hc);
[difht_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_c,ny,yc,ar,hc);
[radht_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_c,ny,yc,ar,hc);
[cndht_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_c,ny,yc,ar,hc);
[cnvht_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_c,ny,yc,ar,hc);

[htrt_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_th,ny,yc,ar,hc);
[difht_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_th,ny,yc,ar,hc);
[radht_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_th,ny,yc,ar,hc);
[cndht_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_th,ny,yc,ar,hc);
[cnvht_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_th,ny,yc,ar,hc);

[htrt_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_w,ny,yc,ar,hc);
[difht_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_w,ny,yc,ar,hc);
[radht_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_w,ny,yc,ar,hc);
[cndht_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_w,ny,yc,ar,hc);
[cnvht_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_w,ny,yc,ar,hc);


for i=1:45

htrt_c_hzav(i,:,:) = (htrt_c_zav(46-i,:,:) + htrt_c_zav(45+i,:,:))./2;
difht_c_hzav(i,:,:) = (difht_c_zav(46-i,:,:) + difht_c_zav(45+i,:,:))./2;
radht_c_hzav(i,:,:) = (radht_c_zav(46-i,:,:) + radht_c_zav(45+i,:,:))./2;
cndht_c_hzav(i,:,:) = (cndht_c_zav(46-i,:,:) + cndht_c_zav(45+i,:,:))./2;
cnvht_c_hzav(i,:,:) = (cnvht_c_zav(46-i,:,:) + cnvht_c_zav(45+i,:,:))./2;

htrt_th_hzav(i,:,:) = (htrt_th_zav(46-i,:,:) + htrt_th_zav(45+i,:,:))./2;
difht_th_hzav(i,:,:) = (difht_th_zav(46-i,:,:) + difht_th_zav(45+i,:,:))./2;
radht_th_hzav(i,:,:) = (radht_th_zav(46-i,:,:) + radht_th_zav(45+i,:,:))./2;
cndht_th_hzav(i,:,:) = (cndht_th_zav(46-i,:,:) + cndht_th_zav(45+i,:,:))./2;
cnvht_th_hzav(i,:,:) = (cnvht_th_zav(46-i,:,:) + cnvht_th_zav(45+i,:,:))./2;

htrt_w_hzav(i,:,:) = (htrt_w_zav(46-i,:,:) + htrt_w_zav(45+i,:,:))./2;
difht_w_hzav(i,:,:) = (difht_w_zav(46-i,:,:) + difht_w_zav(45+i,:,:))./2;
radht_w_hzav(i,:,:) = (radht_w_zav(46-i,:,:) + radht_w_zav(45+i,:,:))./2;
cndht_w_hzav(i,:,:) = (cndht_w_zav(46-i,:,:) + cndht_w_zav(45+i,:,:))./2;
cnvht_w_hzav(i,:,:) = (cnvht_w_zav(46-i,:,:) + cnvht_w_zav(45+i,:,:))./2;

end

htrt_c_mean = mean(htrt_c_hzav,3).*86400;
difht_c_mean = mean(difht_c_hzav,3).*86400;
radht_c_mean = mean(radht_c_hzav,3).*86400;
cndht_c_mean = mean(cndht_c_hzav,3).*86400;
cnvht_c_mean = mean(cnvht_c_hzav,3).*86400;

htrt_th_mean = mean(htrt_th_hzav,3).*86400;
difht_th_mean = mean(difht_th_hzav,3).*86400;
radht_th_mean = mean(radht_th_hzav,3).*86400;
cndht_th_mean = mean(cndht_th_hzav,3).*86400;
cnvht_th_mean = mean(cnvht_th_hzav,3).*86400;

htrt_w_mean = mean(htrt_w_hzav,3).*86400;
difht_w_mean = mean(difht_w_hzav,3).*86400;
radht_w_mean = mean(radht_w_hzav,3).*86400;
cndht_w_mean = mean(cndht_w_hzav,3).*86400;
cnvht_w_mean = mean(cnvht_w_hzav,3).*86400;


%First plot up control, then diffs


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

axes('position',[posx(1) posy(1) xSize_sub ySize_sub])
v=-6:0.5:0;
[C,h]=contour(ylat(46:90),rC./100.,htrt_c_mean',v,'k--');
clabel(C,h);
hold on
v=0:0.5:20;
[C,h]=contour(ylat(46:90),rC./100.,htrt_c_mean',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title('Total Diabatic Heating')
hold off


axes('position',[posx(2) posy(2) xSize_sub ySize_sub])
v=-6:0.5:0;
[C,h]=contour(ylat(46:90),rC./100.,cndht_c_mean',v,'k--');
clabel(C,h);
hold on
v=0:0.5:20;
[C,h]=contour(ylat(46:90),rC./100.,cndht_c_mean',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
set(gca, 'YTickLabel', []);
title('Condensational Heating')
hold off


axes('position',[posx(3) posy(3) xSize_sub ySize_sub])
v=-6:0.2:0;
[C,h]=contour(ylat(46:90),rC./100.,cnvht_c_mean',v,'k--');
clabel(C,h);
hold on
v=0:0.2:20;
[C,h]=contour(ylat(46:90),rC./100.,cnvht_c_mean',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title('Convective Heating')
hold off


axes('position',[posx(4) posy(4) xSize_sub ySize_sub])
v=-6:0.2:0;
[C,h]=contour(ylat(46:90),rC./100.,radht_c_mean',v,'k--');
clabel(C,h);
hold on
v=0:0.2:20;
[C,h]=contour(ylat(46:90),rC./100.,radht_c_mean',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
set(gca, 'YTickLabel', []);
title('Radiative Heating')
hold off


axes('position',[posx(5) posy(5) xSize_sub ySize_sub])
v=-6:0.2:0;
[C,h]=contour(ylat(46:90),rC./100.,difht_c_mean',v,'k--');
clabel(C,h);
hold on
v=0:0.2:20;
[C,h]=contour(ylat(46:90),rC./100.,difht_c_mean',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title('Diffusive Heating')
hold off

print('-dpdf','diabatic_ctrl.pdf')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[posx(1) posy(1) xSize_sub ySize_sub])
v=-6:0.5:0;
[C,h]=contour(ylat(46:90),rC./100.,htrt_th_mean'-htrt_c_mean',v,'k--');
clabel(C,h);
hold on
v=0:0.5:20;
[C,h]=contour(ylat(46:90),rC./100.,htrt_th_mean'-htrt_c_mean',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title('Total Diabatic Heating')
hold off


axes('position',[posx(2) posy(2) xSize_sub ySize_sub])
v=-6:0.5:0;
[C,h]=contour(ylat(46:90),rC./100.,cndht_th_mean'-cndht_c_mean',v,'k--');
clabel(C,h);
hold on
v=0:0.5:20;
[C,h]=contour(ylat(46:90),rC./100.,cndht_th_mean'-cndht_c_mean',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
set(gca, 'YTickLabel', []);
title('Condensational Heating')
hold off


axes('position',[posx(3) posy(3) xSize_sub ySize_sub])
v=-6:0.2:0;
[C,h]=contour(ylat(46:90),rC./100.,cnvht_th_mean'-cnvht_c_mean',v,'k--');
clabel(C,h);
hold on
v=0:0.2:20;
[C,h]=contour(ylat(46:90),rC./100.,cnvht_th_mean'-cnvht_c_mean',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title('Convective Heating')
hold off


axes('position',[posx(4) posy(4) xSize_sub ySize_sub])
v=-6:0.2:0;
[C,h]=contour(ylat(46:90),rC./100.,radht_th_mean'-radht_c_mean',v,'k--');
clabel(C,h);
hold on
v=0:0.2:20;
[C,h]=contour(ylat(46:90),rC./100.,radht_th_mean'-radht_c_mean',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
set(gca, 'YTickLabel', []);
title('Radiative Heating')
hold off


axes('position',[posx(5) posy(5) xSize_sub ySize_sub])
v=-6:0.2:0;
[C,h]=contour(ylat(46:90),rC./100.,difht_th_mean'-difht_c_mean',v,'k--');
clabel(C,h);
hold on
v=0:0.2:20;
[C,h]=contour(ylat(46:90),rC./100.,difht_th_mean'-difht_c_mean',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title('Diffusive Heating')
hold off


print('-dpdf','diabatic_thmctrl.pdf')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 3%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[posx(1) posy(1) xSize_sub ySize_sub])
v=-6:0.5:0;
[C,h]=contour(ylat(46:90),rC./100.,htrt_w_mean'-htrt_c_mean',v,'k--');
clabel(C,h);
hold on
v=0:0.5:20;
[C,h]=contour(ylat(46:90),rC./100.,htrt_w_mean'-htrt_c_mean',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title('Total Diabatic Heating')
hold off


axes('position',[posx(2) posy(2) xSize_sub ySize_sub])
v=-6:0.5:0;
[C,h]=contour(ylat(46:90),rC./100.,cndht_w_mean'-cndht_c_mean',v,'k--');
clabel(C,h);
hold on
v=0:0.5:20;
[C,h]=contour(ylat(46:90),rC./100.,cndht_w_mean'-cndht_c_mean',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
set(gca, 'YTickLabel', []);
title('Condensational Heating')
hold off


axes('position',[posx(3) posy(3) xSize_sub ySize_sub])
v=-6:0.2:0;
[C,h]=contour(ylat(46:90),rC./100.,cnvht_w_mean'-cnvht_c_mean',v,'k--');
clabel(C,h);
hold on
v=0:0.2:20;
[C,h]=contour(ylat(46:90),rC./100.,cnvht_w_mean'-cnvht_c_mean',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title('Convective Heating')
hold off


axes('position',[posx(4) posy(4) xSize_sub ySize_sub])
v=-6:0.2:0;
[C,h]=contour(ylat(46:90),rC./100.,radht_w_mean'-radht_c_mean',v,'k--');
clabel(C,h);
hold on
v=0:0.2:20;
[C,h]=contour(ylat(46:90),rC./100.,radht_w_mean'-radht_c_mean',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
set(gca, 'YTickLabel', []);
title('Radiative Heating')
hold off


axes('position',[posx(5) posy(5) xSize_sub ySize_sub])
v=-6:0.2:0;
[C,h]=contour(ylat(46:90),rC./100.,difht_w_mean'-difht_c_mean',v,'k--');
clabel(C,h);
hold on
v=0:0.2:20;
[C,h]=contour(ylat(46:90),rC./100.,difht_w_mean'-difht_c_mean',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title('Diffusive Heating')
hold off


print('-dpdf','diabatic_wmctrl.pdf')
