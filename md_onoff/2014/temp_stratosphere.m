%Plot the temperature profile with focus on the stratosphere.

load('means_ctrl.mat')
load('means_pert.mat')

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


[temp_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(temp_ctrl_mean,ny,yc,ar,hc);
[temp_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(temp_pert_mean,ny,yc,ar,hc);

for i=1:45
temp_hzav_c(46-i,:) = (temp_zav_c(i,:) + temp_zav_c(91-i,:))./2;
temp_hzav_p(46-i,:) = (temp_zav_p(i,:) + temp_zav_p(91-i,:))./2;
end



v=-1:0.5:8;
[C,h]=contourf(ylat(46:90),rC./100.,temp_hzav_p'-temp_hzav_c',v);
%set(h,'edgecolor','none')
clabel(C,h);
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,temp_hzav_p'-temp_hzav_c',v,'k:');
colorbar;
colormap(b2r(-0.4,8));
set(gca,'YDir','reverse')
title(['Temperature, K'])
%hold on
%v=175:5:300;
%[C,h]=contour(ylat(46:90),rC./100.,temp_hzav_c',v,'k');
%clabel(C,h);
hold off

print('-dpng','temp_strat.png')
