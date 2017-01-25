%load up theta, u, u'v' and plot up for the 2 runs


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Wet Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i) = dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_w(:,:,:,i) = dyn(:,:,:,J);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Half WV Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_h(:,:,:,i) = dyn(:,:,:,J);
[uE_h(:,:,:,i),vN_h(:,:,:,i)] = rotate_uv2uvEN(ucs_h(:,:,:,i),vcs_h(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_h(:,:,:,i) = dyn(:,:,:,J);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Tropheat Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv_tropheat3eq/';
nitth = nit + 518400;
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nitth);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_th(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_th(:,:,:,i) = dyn(:,:,:,J);
[uE_th(:,:,:,i),vN_th(:,:,:,i)] = rotate_uv2uvEN(ucs_th(:,:,:,i),vcs_th(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_th(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_th(:,:,:,i) = dyn(:,:,:,J);

end


uE_w_mean = mean(uE_w,4);
vN_w_mean = mean(vN_w,4);
uv_w_mean = mean(uv_w,4);
theta_w_mean = mean(theta_w,4);

uE_h_mean = mean(uE_h,4);
vN_h_mean = mean(vN_h,4);
uv_h_mean = mean(uv_h,4);
theta_h_mean = mean(theta_h,4);

uE_th_mean = mean(uE_th,4);
vN_th_mean = mean(vN_th,4);
uv_th_mean = mean(uv_th,4);
theta_th_mean = mean(theta_th,4);

[uE_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_w_mean,ny,yc,ar,hc);
[vN_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_w_mean,ny,yc,ar,hc);
[uv_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_w_mean,ny,yc,ar,hc);
[theta_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_w_mean,ny,yc,ar,hc);

uved_w_zav = uv_w_zav - uE_w_zav.*vN_w_zav;

[uE_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_h_mean,ny,yc,ar,hc);
[vN_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_h_mean,ny,yc,ar,hc);
[uv_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_h_mean,ny,yc,ar,hc);
[theta_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_h_mean,ny,yc,ar,hc);

uved_h_zav = uv_h_zav - uE_h_zav.*vN_h_zav;

[uE_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_th_mean,ny,yc,ar,hc);
[vN_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_th_mean,ny,yc,ar,hc);
[uv_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_th_mean,ny,yc,ar,hc);
[theta_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_th_mean,ny,yc,ar,hc);

uved_th_zav = uv_th_zav - uE_th_zav.*vN_th_zav;

for i=1:45
uE_w_hzav(46-i,:) = (uE_w_zav(i,:) + uE_w_zav(91-i,:))./2;
uved_w_hzav(46-i,:) = (-1.*uved_w_zav(i,:) + uved_w_zav(91-i,:))./2;
theta_w_hzav(46-i,:) = (theta_w_zav(i,:) + theta_w_zav(91-i,:))./2;

uE_h_hzav(46-i,:) = (uE_h_zav(i,:) + uE_h_zav(91-i,:))./2;
uved_h_hzav(46-i,:) = (-1.*uved_h_zav(i,:) + uved_h_zav(91-i,:))./2;
theta_h_hzav(46-i,:) = (theta_h_zav(i,:) + theta_h_zav(91-i,:))./2;

uE_th_hzav(46-i,:) = (uE_th_zav(i,:) + uE_th_zav(91-i,:))./2;
uved_th_hzav(46-i,:) = (-1.*uved_th_zav(i,:) + uved_th_zav(91-i,:))./2;
theta_th_hzav(46-i,:) = (theta_th_zav(i,:) + theta_th_zav(91-i,:))./2;
end



%# centimeters units
X = 20.0;                  %# A4 paper size
Y = 20.0;                  %# A4 paper size
xMargin = 1;               %# left/right margins from page borders
yMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 1*yMargin;     %# figure size on paper (widht & hieght)

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%U W
%hFig = figure(1);
%set(hFig, 'Position', [360 499 420 420])
v=-8:2:20;
[C,h]=contourf(ylat(46:90),rC./100.,uE_w_hzav'-uE_h_hzav',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,uE_w_hzav'-uE_h_hzav',v,'k:');
colorbar;
colormap(b2r(-8,20));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['Zonal wind, m/s'])
v=-25:5:0;
[C,h]=contour(ylat(46:90),rC./100.,uE_h_hzav',v,'k--');
clabel(C,h);
v=0:5:45;
[C,h]=contour(ylat(46:90),rC./100.,uE_h_hzav',v,'k');
clabel(C,h);
hold off
print('-dpng','uE_w_diff.png')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')
%U TH
%hFig = figure(1);
%set(hFig, 'Position', [360 499 420 420])
v=-8:2:20;
[C,h]=contourf(ylat(46:90),rC./100.,uE_th_hzav'-uE_h_hzav',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,uE_th_hzav'-uE_h_hzav',v,'k:');
colorbar;
colormap(b2r(-8,20));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['Zonal wind, m/s'])
v=-25:5:0;
[C,h]=contour(ylat(46:90),rC./100.,uE_h_hzav',v,'k--');
clabel(C,h);
v=0:5:45;
[C,h]=contour(ylat(46:90),rC./100.,uE_h_hzav',v,'k');
clabel(C,h);
hold off
print('-dpng','uE_th_diff.png')

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')
%Theta W
%hFig = figure(1);
%set(hFig, 'Position', [360 499 420 420])
v=-4:2:22;
[C,h]=contourf(ylat(46:90),rC./100.,theta_w_hzav'-theta_h_hzav',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,theta_w_hzav'-theta_h_hzav',v,'k:');
colorbar;
colormap(b2r(-4,22));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['Potential Temperature, K'])
v = 200:30:750;
[C,h]=contour(ylat(46:90),rC./100.,theta_h_hzav',v,'k');
clabel(C,h);
hold off
print('-dpng','theta_w_diff.png')

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')
%Theta W
%hFig = figure(1);
%set(hFig, 'Position', [360 499 420 420])
v=-4:2:22;
[C,h]=contourf(ylat(46:90),rC./100.,theta_th_hzav'-theta_h_hzav',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,theta_th_hzav'-theta_h_hzav',v,'k:');
colorbar;
colormap(b2r(-4,22));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['Potential Temperature, K'])
v = 200:30:750;
[C,h]=contour(ylat(46:90),rC./100.,theta_h_hzav',v,'k');
clabel(C,h);
hold off
print('-dpng','theta_th_diff.png')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%u'v' W
%hFig = figure(1);
%set(hFig, 'Position', [360 499 420 420])
v=-20:5:40;
[C,h]=contourf(ylat(46:90),rC./100.,uved_w_hzav'-uved_h_hzav',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,uved_w_hzav'-uved_h_hzav',v,'k:');
colorbar;
colormap(b2r(-20,40));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['Eddy momentum flux, m^{2}s^{-2}'])
v = -20:10:0;
[C,h]=contour(ylat(46:90),rC./100.,uved_h_hzav',v,'k--');
clabel(C,h);
v = 0:10:50;
[C,h]=contour(ylat(46:90),rC./100.,uved_h_hzav',v,'k');
clabel(C,h);
hold off
print('-dpng','uved_w_diff.png')

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')
%u'v' TH
%hFig = figure(1);
%set(hFig, 'Position', [360 499 420 420])
v=-20:5:40;
[C,h]=contourf(ylat(46:90),rC./100.,uved_th_hzav'-uved_h_hzav',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,uved_th_hzav'-uved_h_hzav',v,'k:');
colorbar;
colormap(b2r(-20,40));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['Eddy momentum flux, m^{2}s^{-2}'])
v = -20:10:0;
[C,h]=contour(ylat(46:90),rC./100.,uved_h_hzav',v,'k--');
clabel(C,h);
v = 0:10:50;
[C,h]=contour(ylat(46:90),rC./100.,uved_h_hzav',v,'k');
clabel(C,h);
hold off
print('-dpng','uved_th_diff.png')
