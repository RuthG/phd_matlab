%best_onoff.m
%Produce good 5 yr av plots of u,v,w,uv,vT,T,theta,q,heat rates

%Read in iteration number, directory, MITgcm output and grid details

rDir_control='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';
rDir_perturbed='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_2yeardaily_pert_2014/';

wet = true;

%Create reference label to identify run plot is for!
directory = pwd;
lastslash = max(findstr(directory,'/'));
dir_label = directory(lastslash:max(size(directory)));
dir_label = strrep(dir_label,'_','-');

%read in tropopause of control run
%load('/disk1/rg312/run_daily_swwv/tropopause.mat')

rDir=rDir_control;
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
for nit = 259200:86400:604800;
i=i+1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Control Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir = rDir_control;

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_ctrl(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_ctrl(:,:,:,i) = dyn(:,:,:,J);
[uE_ctrl(:,:,:,i),vN_ctrl(:,:,:,i)] = rotate_uv2uvEN(ucs_ctrl(:,:,:,i),vcs_ctrl(:,:,:,i),AngleCS,AngleSN,Grid);
uEvN_ctrl(:,:,:,i)=uE_ctrl(:,:,:,i).*vN_ctrl(:,:,:,i);

J=find(strcmp(fldList,'THETA   '));
theta_ctrl(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_ctrl(:,:,j,i)=theta_ctrl(:,:,j,i).*convthetatoT(j,1);
end

J=find(strcmp(fldList,'UV_VEL_C'));
uv_ctrl(:,:,:,i) = dyn(:,:,:,J);
uv_ed_ctrl(:,:,:,i) = uv_ctrl(:,:,:,i) - uEvN_ctrl(:,:,:,i);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_ctrl(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_ctrl(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_ctrl(:,:,:,i),vNt_av_ctrl(:,:,:,i)] = rotate_uv2uvEN(ut_av_ctrl(:,:,:,i),vt_av_ctrl(:,:,:,i),AngleCS,AngleSN,Grid);

vt_ctrl(:,:,:,i) = vN_ctrl(:,:,:,i).*theta_ctrl(:,:,:,i);
vt_ed_ctrl(:,:,:,i) = vNt_av_ctrl(:,:,:,i) - vt_ctrl(:,:,:,i);

J=find(strcmp(fldList,'WVEL    '));
w_ctrl(:,:,:,i)=dyn(:,:,:,J);

J=find(strcmp(fldList,'SALT    '));
q_ctrl(:,:,:,i)=dyn(:,:,:,J);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_in=dyn(:,:,:,J);
htrt_theta_ctrl(:,:,:,i)=htrt_in*86400.;

J=find(strcmp(fldList,'AtPhdTrd'));
radht_in=dyn(:,:,:,J);
radht_theta_ctrl(:,:,:,i)=radht_in*86400.;

J=find(strcmp(fldList,'AtPhdTcd'));
cndht_in=dyn(:,:,:,J);
cndht_theta_ctrl(:,:,:,i)=cndht_in*86400.;

J=find(strcmp(fldList,'AtPhdTdf'));
difht_in=dyn(:,:,:,J);
difht_theta_ctrl(:,:,:,i)=difht_in*86400.;

J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_in=dyn(:,:,:,J);
cnvht_theta_ctrl(:,:,:,i)=cnvht_in*86400.;
end

i=0;
for nit = 777840:240:864000;
i=i+1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Perturbed Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rDir = rDir_perturbed;

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_pert(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_pert(:,:,:,i) = dyn(:,:,:,J);
[uE_pert(:,:,:,i),vN_pert(:,:,:,i)] = rotate_uv2uvEN(ucs_pert(:,:,:,i),vcs_pert(:,:,:,i),AngleCS,AngleSN,Grid);
uEvN_pert(:,:,:,i)=uE_pert(:,:,:,i).*vN_pert(:,:,:,i);

J=find(strcmp(fldList,'THETA   '));
theta_pert(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_pert(:,:,j,i)=theta_pert(:,:,j,i).*convthetatoT(j,1);
end

J=find(strcmp(fldList,'UV_VEL_C'));
uv_pert(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_pert(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_pert(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_pert(:,:,:,i),vNt_av_pert(:,:,:,i)] = rotate_uv2uvEN(ut_av_pert(:,:,:,i),vt_av_pert(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'WVEL    '));
w_pert(:,:,:,i)=dyn(:,:,:,J);

J=find(strcmp(fldList,'SALT    '));
q_pert(:,:,:,i)=dyn(:,:,:,J);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_in=dyn(:,:,:,J);
htrt_theta_pert(:,:,:,i)=htrt_in*86400.;

J=find(strcmp(fldList,'AtPhdTrd'));
radht_in=dyn(:,:,:,J);
radht_theta_pert(:,:,:,i)=radht_in*86400.;

J=find(strcmp(fldList,'AtPhdTcd'));
cndht_in=dyn(:,:,:,J);
cndht_theta_pert(:,:,:,i)=cndht_in*86400.;

J=find(strcmp(fldList,'AtPhdTdf'));
difht_in=dyn(:,:,:,J);
difht_theta_pert(:,:,:,i)=difht_in*86400.;

J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_in=dyn(:,:,:,J);
cnvht_theta_pert(:,:,:,i)=cnvht_in*86400.;
end


uE_ctrl_mean = mean(uE_ctrl,4);
vN_ctrl_mean = mean(vN_ctrl,4);
theta_ctrl_mean = mean(theta_ctrl,4);
temp_ctrl_mean = mean(temp_ctrl,4);
uv_ctrl_mean = mean(uv_ctrl,4);
vt_ctrl_mean = mean(vNt_av_ctrl,4);
w_ctrl_mean = mean(w_ctrl,4);
q_ctrl_mean = mean(q_ctrl,4);
htrt_ctrl_mean = mean(htrt_theta_ctrl,4);
radht_ctrl_mean = mean(radht_theta_ctrl,4);
cndht_ctrl_mean = mean(cndht_theta_ctrl,4);
cnvht_ctrl_mean = mean(cnvht_theta_ctrl,4);
difht_ctrl_mean = mean(difht_theta_ctrl,4);


uE_pert_mean = mean(uE_pert,4);
vN_pert_mean = mean(vN_pert,4);
theta_pert_mean = mean(theta_pert,4);
temp_pert_mean = mean(temp_pert,4);
uv_pert_mean = mean(uv_pert,4);
vt_pert_mean = mean(vNt_av_pert,4);
w_pert_mean = mean(w_pert,4);
q_pert_mean = mean(q_pert,4);
htrt_pert_mean = mean(htrt_theta_pert,4);
radht_pert_mean = mean(radht_theta_pert,4);
cndht_pert_mean = mean(cndht_theta_pert,4);
cnvht_pert_mean = mean(cnvht_theta_pert,4);
difht_pert_mean = mean(difht_theta_pert,4);

uv_ed_ctrl_mean = uv_ctrl_mean - uE_ctrl_mean.*vN_ctrl_mean;
vt_ed_ctrl_mean = vt_ctrl_mean - vN_ctrl_mean.*theta_ctrl_mean;
uv_ed_pert_mean = uv_pert_mean - uE_pert_mean.*vN_pert_mean;
vt_ed_pert_mean = vt_pert_mean - vN_pert_mean.*theta_pert_mean;

save('means_ctrl.mat', 'uE_ctrl_mean', 'vN_ctrl_mean', 'theta_ctrl_mean', ...
'temp_ctrl_mean', 'uv_ed_ctrl_mean', 'vt_ed_ctrl_mean', 'w_ctrl_mean', 'q_ctrl_mean', 'htrt_ctrl_mean', ... 
'radht_ctrl_mean', 'cndht_ctrl_mean', 'cnvht_ctrl_mean', 'difht_ctrl_mean');


save('means_pert.mat', 'uE_pert_mean', 'vN_pert_mean', 'theta_pert_mean', ...
'temp_pert_mean', 'uv_ed_pert_mean', 'vt_ed_pert_mean', 'w_pert_mean', 'q_pert_mean', 'htrt_pert_mean', ... 
'radht_pert_mean', 'cndht_pert_mean', 'cnvht_pert_mean', 'difht_pert_mean');


%take zonal averages for plots

[uE_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(uE_ctrl_mean,ny,yc,ar,hc);
[vN_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(vN_ctrl_mean,ny,yc,ar,hc);
[theta_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(theta_ctrl_mean,ny,yc,ar,hc);
[temp_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(temp_ctrl_mean,ny,yc,ar,hc);
[uv_ed_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ed_ctrl_mean,ny,yc,ar,hc);
[vt_ed_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(vt_ed_ctrl_mean,ny,yc,ar,hc);
[w_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(w_ctrl_mean,ny,yc,ar,hc);
[q_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(q_ctrl_mean,ny,yc,ar,hc);
[htrt_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_ctrl_mean,ny,yc,ar,hc);
[radht_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(radht_ctrl_mean,ny,yc,ar,hc);
[cndht_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_ctrl_mean,ny,yc,ar,hc);
[cnvht_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_ctrl_mean,ny,yc,ar,hc);
[difht_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(difht_ctrl_mean,ny,yc,ar,hc);


[uE_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(uE_pert_mean,ny,yc,ar,hc);
[vN_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(vN_pert_mean,ny,yc,ar,hc);
[theta_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(theta_pert_mean,ny,yc,ar,hc);
[temp_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(temp_pert_mean,ny,yc,ar,hc);
[uv_ed_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ed_pert_mean,ny,yc,ar,hc);
[vt_ed_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(vt_ed_pert_mean,ny,yc,ar,hc);
[w_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(w_pert_mean,ny,yc,ar,hc);
[q_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(q_pert_mean,ny,yc,ar,hc);
[htrt_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_pert_mean,ny,yc,ar,hc);
[radht_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(radht_pert_mean,ny,yc,ar,hc);
[cndht_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_pert_mean,ny,yc,ar,hc);
[cnvht_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_pert_mean,ny,yc,ar,hc);
[difht_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(difht_pert_mean,ny,yc,ar,hc);


%take hemisphere averages

for i=1:45

uE_hzav_c(46-i,:) = (uE_zav_c(i,:) + uE_zav_c(91-i,:))./2;
uE_hzav_p(46-i,:) = (uE_zav_p(i,:) + uE_zav_p(91-i,:))./2;

vN_hzav_c(46-i,:) = (-1*vN_zav_c(i,:) + vN_zav_c(91-i,:))./2;
vN_hzav_p(46-i,:) = (-1*vN_zav_p(i,:) + vN_zav_p(91-i,:))./2;

theta_hzav_c(46-i,:) = (theta_zav_c(i,:) + theta_zav_c(91-i,:))./2;
theta_hzav_p(46-i,:) = (theta_zav_p(i,:) + theta_zav_p(91-i,:))./2;

temp_hzav_c(46-i,:) = (temp_zav_c(i,:) + temp_zav_c(91-i,:))./2;
temp_hzav_p(46-i,:) = (temp_zav_p(i,:) + temp_zav_p(91-i,:))./2;

uv_ed_hzav_c(46-i,:) = (-1*uv_ed_zav_c(i,:) + uv_ed_zav_c(91-i,:))./2;
uv_ed_hzav_p(46-i,:) = (-1*uv_ed_zav_p(i,:) + uv_ed_zav_p(91-i,:))./2;

vt_ed_hzav_c(46-i,:) = (-1*vt_ed_zav_c(i,:) + vt_ed_zav_c(91-i,:))./2;
vt_ed_hzav_p(46-i,:) = (-1*vt_ed_zav_p(i,:) + vt_ed_zav_p(91-i,:))./2;

w_hzav_c(46-i,:) = (w_zav_c(i,:) + w_zav_c(91-i,:))./2;
w_hzav_p(46-i,:) = (w_zav_p(i,:) + w_zav_p(91-i,:))./2;

q_hzav_c(46-i,:) = (q_zav_c(i,:) + q_zav_c(91-i,:))./2;
q_hzav_p(46-i,:) = (q_zav_p(i,:) + q_zav_p(91-i,:))./2;

htrt_hzav_c(46-i,:) = (htrt_zav_c(i,:) + htrt_zav_c(91-i,:))./2;
htrt_hzav_p(46-i,:) = (htrt_zav_p(i,:) + htrt_zav_p(91-i,:))./2;

radht_hzav_c(46-i,:) = (radht_zav_c(i,:) + radht_zav_c(91-i,:))./2;
radht_hzav_p(46-i,:) = (radht_zav_p(i,:) + radht_zav_p(91-i,:))./2;

cndht_hzav_c(46-i,:) = (cndht_zav_c(i,:) + cndht_zav_c(91-i,:))./2;
cndht_hzav_p(46-i,:) = (cndht_zav_p(i,:) + cndht_zav_p(91-i,:))./2;

cnvht_hzav_c(46-i,:) = (cnvht_zav_c(i,:) + cnvht_zav_c(91-i,:))./2;
cnvht_hzav_p(46-i,:) = (cnvht_zav_p(i,:) + cnvht_zav_p(91-i,:))./2;

difht_hzav_c(46-i,:) = (difht_zav_c(i,:) + difht_zav_c(91-i,:))./2;
difht_hzav_p(46-i,:) = (difht_zav_p(i,:) + difht_zav_p(91-i,:))./2;

end

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
v=-4.25:0.25:0.5;
[C,h]=contourf(ylat(46:90),rC./100.,uE_hzav_p'-uE_hzav_c',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,uE_hzav_p'-uE_hzav_c',v,'k:');
colorbar;
colormap(b2r(-4.25,0.5));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Zonal wind, m/s'])
v=-25:2.5:0;
[C,h]=contour(ylat(46:90),rC./100.,uE_hzav_c',v,'k--');
clabel(C,h);
v=0:2.5:45;
[C,h]=contour(ylat(46:90),rC./100.,uE_hzav_c',v,'k');
clabel(C,h);
hold off
freezeColors
cbfreeze(colorbar);
name=['best_onoff_new.ps'];

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-0.4:0.04:0.4;
[C,h]=contourf(ylat(46:90),rC./100.,vN_hzav_p'-vN_hzav_c',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,vN_hzav_p'-vN_hzav_c',v,'k:');
colorbar;
colormap(b2r(-0.4,0.4));
set(gca,'YDir','reverse')
title(['Meridional wind, m/s'])
hold on
v=-6:0.3:0;
[C,h]=contour(ylat(46:90),rC./100.,vN_hzav_c',v,'k--');
clabel(C,h);
v=0:0.3:6;
[C,h]=contour(ylat(46:90),rC./100.,vN_hzav_c',v,'k');
clabel(C,h);
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=0:20;
[C,h]=contourf(ylat(46:90),rC./100.,theta_hzav_p'-theta_hzav_c',v);
set(h,'edgecolor','none')
hold on
v=-1000:1000:1000;
[C,h]=contour(ylat(46:90),rC./100.,theta_hzav_p'-theta_hzav_c',v,'k:');
colorbar;
colormap(b2r(0,20));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Potential Temperature, K'])
hold on
v(1:21) = 250:5:350;
v(22:29) = 400:50:750;
[C,h]=contour(ylat(46:90),rC./100.,theta_hzav_c',v,'k');
clabel(C,h);
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 4
axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-0.4:0.1:8;
[C,h]=contourf(ylat(46:90),rC./100.,temp_hzav_p'-temp_hzav_c',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,temp_hzav_p'-temp_hzav_c',v,'k:');
colorbar;
colormap(b2r(-0.4,0.4));
set(gca,'YDir','reverse')
title(['Temperature, K'])
hold on
v=175:5:300;
[C,h]=contour(ylat(46:90),rC./100.,temp_hzav_c',v,'k');
clabel(C,h);
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
v=-1.5:0.25:1;
[C,h]=contourf(ylat(46:90),rC./100.,uv_ed_hzav_p'-uv_ed_hzav_c',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,uv_ed_hzav_p'-uv_ed_hzav_c',v,'k:');
colorbar;
colormap(b2r(-1.5,1));
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title(['Horiz eddy mom flux, m^{2}/s^{2}'])
hold on
v= -50:5:0;
[C,h]=contour(ylat(46:90),rC./100.,uv_ed_hzav_c',v,'k--');
clabel(C,h);
v= 0:5:50;
[C,h]=contour(ylat(46:90),rC./100.,uv_ed_hzav_c',v,'k');
clabel(C,h);
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
v=-1.5:0.15:1.5;
[C,h]=contourf(ylat(46:90),rC./100.,vt_ed_hzav_p'-vt_ed_hzav_c',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,vt_ed_hzav_p'-vt_ed_hzav_c',v,'k:');
colorbar;
colormap(b2r(-1.5,1.5));
set(gca,'YDir','reverse')
xlabel('Latitude')
title(['Meridional eddy theta trans, Km/s'])
hold on
v=-26:2:0;
[C,h]=contour(ylat(46:90),rC./100.,vt_ed_hzav_c',v,'k--');
clabel(C,h);
v=0:2:26;
[C,h]=contour(ylat(46:90),rC./100.,vt_ed_hzav_c',v,'k');
clabel(C,h);
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

%for each need to add: contours, colormaps, contour labelling

%PLOT 1
axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-1.5e-3:0.25e-3:1.5e-3;
[C,h]=contourf(ylat(46:90),rC./100.,w_hzav_p'-w_hzav_c',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,w_hzav_p'-w_hzav_c',v,'k:');
colorbar;
colormap(b2r(-1.5e-3,1.5e-3));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Vertical wind, Pa/s'])
hold on
v=-0.2:0.01:0;
[C,h]=contour(ylat(46:90),rC./100.,w_hzav_c',v,'k--');
clabel(C,h);
v=0.:0.01:0.1;
[C,h]=contour(ylat(46:90),rC./100.,w_hzav_c',v,'k');
clabel(C,h);
hold off
freezeColors
cbfreeze(colorbar);
name=['best_onoff_new.ps'];

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-0.04:0.004:0.04;
[C,h]=contourf(ylat(46:90),rC./100.,radht_hzav_p'-radht_hzav_c',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,radht_hzav_p'-radht_hzav_c',v,'k:');
colorbar;
colormap(b2r(-0.04,0.04));
set(gca,'YDir','reverse')
title(['Radiative heating, K/day'])
hold on
v=-4:0.2:0;
[C,h]=contour(ylat(46:90),rC./100.,radht_hzav_c',v,'k--');
clabel(C,h);
v=0:0.2:0.6;
[C,h]=contour(ylat(46:90),rC./100.,radht_hzav_c',v,'k');
clabel(C,h);
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-0.1:0.01:0.1;
[C,h]=contourf(ylat(46:90),rC./100.,difht_hzav_p'-difht_hzav_c',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,difht_hzav_p'-difht_hzav_c',v,'k:');
colorbar;
colormap(b2r(-0.1,0.1));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Diffusive heating, K/day'])
hold on
v=-2:0.25:0;
[C,h]=contour(ylat(46:90),rC./100.,difht_hzav_c',v,'k--');
clabel(C,h);
v=0:0.25:4;
[C,h]=contour(ylat(46:90),rC./100.,difht_hzav_c',v,'k');
clabel(C,h);
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 4
axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-0.1:0.01:0.1;
[C,h]=contourf(ylat(46:90),rC./100.,htrt_hzav_p'-htrt_hzav_c',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,htrt_hzav_p'-htrt_hzav_c',v,'k:');
colorbar;
colormap(b2r(-0.1,0.1));
set(gca,'YDir','reverse')
title(['Total heating, K/day'])
hold on
v=-2:0.25:0;
[C,h]=contour(ylat(46:90),rC./100.,htrt_hzav_c',v,'k--');
clabel(C,h);
v=0:0.25:6.5;
[C,h]=contour(ylat(46:90),rC./100.,htrt_hzav_c',v,'k');
clabel(C,h);
hold off
freezeColors
cbfreeze(colorbar);

if wet ==false
print('-dpsc',name,'-append')
end

if wet

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
v = -0.15:0.025:0.1;
[C,h]=contourf(ylat(46:90),rC./100.,cndht_hzav_p'-cndht_hzav_c',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,cndht_hzav_p'-cndht_hzav_c',v,'k:');
colorbar;
colormap(b2r(-0.15,0.1));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['Condensational heating, K/day'])
hold on
v=0:0.15:6;
[C,h]=contour(ylat(46:90),rC./100.,cndht_hzav_c',v,'k');
clabel(C,h);
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
v= -0.1:0.01:0.1;
[C,h]=contourf(ylat(46:90),rC./100.,cnvht_hzav_p'-cnvht_hzav_c',20);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,cnvht_hzav_p'-cnvht_hzav_c',v,'k:');
colorbar;
colormap(b2r(-0.1,0.1));
set(gca,'YDir','reverse')
xlabel('Latitude')
title(['Convective heating, K/day'])
hold on
v=-1:0.125:0;
[C,h]=contour(ylat(46:90),rC./100.,cnvht_hzav_c',v,'k--');
clabel(C,h);
v=0:0.125:1.5;
[C,h]=contour(ylat(46:90),rC./100.,cnvht_hzav_c',v,'k');
clabel(C,h);
hold off
freezeColors
cbfreeze(colorbar);

print('-dpsc',name,'-append')


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
v=-1e-4:0.1e-4:1e-4;
[C,h]=contourf(ylat(46:90),rC./100.,q_hzav_p'-q_hzav_c',v);
set(h,'edgecolor','none')
hold on
v=-300:300:300;
[C,h]=contour(ylat(46:90),rC./100.,q_hzav_p'-q_hzav_c',v,'k:');
colorbar;
colormap(b2r(-1e-4,1e-4));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Specific humidity, kg/kg'])
hold on
v=0:1e-3:20e-3;
[C,h]=contour(ylat(46:90),rC./100.,q_hzav_c',v,'k');
clabel(C,h);
hold off
freezeColors
cbfreeze(colorbar);
name=['best_onoff_new.ps'];

print('-dpsc',name,'-append')

end

