%best_plots.m
%Produce good 5 yr av plots of u,v,w,uv,vT,T,theta,q,heat rates

%Read in iteration number, directory, MITgcm output and grid details

rDir_control='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';
rDir_perturbed='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_p/';
page2 = true;   %theta and temp
page3 = true;   %u'v'  and v't'
page4 = true;   % w    and q
page5 = true;   %radht and difht
page6 = true;   %cndht and cnvht
page7 = true;   %htrt
perturbed_on = true;

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Perturbed Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if perturbed_on
rDir = rDir_perturbed;

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit + 691200);  
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
uv_ed_pert(:,:,:,i) = uv_pert(:,:,:,i) - uEvN_pert(:,:,:,i);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_pert(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_pert(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_pert(:,:,:,i),vNt_av_pert(:,:,:,i)] = rotate_uv2uvEN(ut_av_pert(:,:,:,i),vt_av_pert(:,:,:,i),AngleCS,AngleSN,Grid);

vt_pert(:,:,:,i) = vN_pert(:,:,:,i).*theta_pert(:,:,:,i);
vt_ed_pert(:,:,:,i) = vNt_av_pert(:,:,:,i) - vt_pert(:,:,:,i);

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

end

uE_ctrl_mean = mean(uE_ctrl,4);
vN_ctrl_mean = mean(vN_ctrl,4);
theta_ctrl_mean = mean(theta_ctrl,4);
temp_ctrl_mean = mean(temp_ctrl,4);
uv_ed_ctrl_mean = mean(uv_ed_ctrl,4);
vt_ed_ctrl_mean = mean(vt_ed_ctrl,4);
w_ctrl_mean = mean(w_ctrl,4);
q_ctrl_mean = mean(q_ctrl,4);
htrt_ctrl_mean = mean(htrt_theta_ctrl,4);
radht_ctrl_mean = mean(radht_theta_ctrl,4);
cndht_ctrl_mean = mean(cndht_theta_ctrl,4);
cnvht_ctrl_mean = mean(cnvht_theta_ctrl,4);
difht_ctrl_mean = mean(difht_theta_ctrl,4);

if perturbed_on
uE_pert_mean = mean(uE_pert,4);
vN_pert_mean = mean(vN_pert,4);
theta_pert_mean = mean(theta_pert,4);
temp_pert_mean = mean(temp_pert,4);
uv_ed_pert_mean = mean(uv_ed_pert,4);
vt_ed_pert_mean = mean(vt_ed_pert,4);
w_pert_mean = mean(w_pert,4);
q_pert_mean = mean(q_pert,4);
htrt_pert_mean = mean(htrt_theta_pert,4);
radht_pert_mean = mean(radht_theta_pert,4);
cndht_pert_mean = mean(cndht_theta_pert,4);
cnvht_pert_mean = mean(cnvht_theta_pert,4);
difht_pert_mean = mean(difht_theta_pert,4);
end

save('means_ctrl.mat', 'uE_ctrl_mean', 'vN_ctrl_mean', 'theta_ctrl_mean', ...
'temp_ctrl_mean', 'uv_ed_ctrl_mean', 'vt_ed_ctrl_mean', 'w_ctrl_mean', 'q_ctrl_mean', 'htrt_ctrl_mean', ... 
'radht_ctrl_mean', 'cndht_ctrl_mean', 'cnvht_ctrl_mean', 'difht_ctrl_mean');

if perturbed_on
save('means_pert.mat', 'uE_pert_mean', 'vN_pert_mean', 'theta_pert_mean', ...
'temp_pert_mean', 'uv_ed_pert_mean', 'vt_ed_pert_mean', 'w_pert_mean', 'q_pert_mean', 'htrt_pert_mean', ... 
'radht_pert_mean', 'cndht_pert_mean', 'cnvht_pert_mean', 'difht_pert_mean');
end

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

if perturbed_on
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

%for each need to add: contours, colormaps, contour labelling

%PLOT 1

v=-25:2.5:45;
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,uE_zav_c',v);
colorbar;
colormap(b2r(-25,45));
set(gca,'YDir','reverse')
%hold on
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Zonal wind: ctrl, m/s'])
name=['best_plots.ps'];

%PLOT 2
v=-6:0.3:6;
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,vN_zav_c',v);
colorbar;
colormap(b2r(-6,6));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
freezeColors
cbfreeze(colorbar);
title(['Meridional wind: ctrl, m/s'])


if perturbed_on %PLOT 3
v=-25:2.5:45;
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,uE_zav_p',v,'k');
colorbar;
colormap(b2r(-25,45));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Zonal wind: pert, m/s'])

%PLOT 4
v=-6:0.3:6;
axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,vN_zav_p',v,'k');
colorbar;
colormap(b2r(-6,6));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
title(['Meridional wind: pert, m/s'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
v=-8:0.5:2;
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,uE_zav_p'-uE_zav_c',v);
colorbar;
colormap(b2r(-8,2));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Zonal wind: pert - ctrl, m/s'])

%PLOT 6
v=-0.4:0.04:0.4;
axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,vN_zav_p'-vN_zav_c',v);
colorbar;
colormap(b2r(-0.4,0.4));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
freezeColors
cbfreeze(colorbar);
title(['Meridional wind: pert - ctrl, m/s'])

end; print('-dpsc',name)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if page2

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%for each need to add: contours, colormaps, contour labelling

%PLOT 1
v(1:21) = 250:5:350;
v(22:29) = 400:50:750;
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,theta_zav_c',v);
colorbar;
caxis([250 750])
clabel(C,h);
set(gca,'YDir','reverse')
%hold on
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Potential Temperature: ctrl, K'])
name=['best_plots.ps'];

%PLOT 2
v=175:5:300;
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_zav_c',v);
colorbar;
caxis([175 300])
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
freezeColors
cbfreeze(colorbar);
title(['Temperature: ctrl, K'])

if perturbed_on %PLOT 3
v(1:21) = 250:5:350;
v(22:29) = 400:50:750;
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,theta_zav_p',v,'k');
colorbar;
caxis([250 750])
clabel(C,h);
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Potential Temperature: pert, K'])

%PLOT 4
v=175:5:300;
axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_zav_p',20,'k');
colorbar;
caxis([175 300])
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
title(['Temperature: pert, K'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
v=0:20;
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,theta_zav_p'-theta_zav_c',v);
colorbar;
clabel(C,h);
colormap(b2r(0,20));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Potential Temperature: pert - ctrl, K'])

%PLOT 6
v=-0.4:0.2:8;
axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_zav_p'-temp_zav_c',v);
colorbar;
clabel(C,h);
colormap(b2r(-0.4,8));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
freezeColors
cbfreeze(colorbar);
title(['Temperature: pert - ctrl, K'])

end; print('-dpsc',name,'-append')

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 3%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if page3 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%for each need to add: contours, colormaps, contour labelling

%PLOT 1
v= -50:5:50;
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,uv_ed_zav_c',v);
colorbar;
colormap(b2r(-50,50));
set(gca,'YDir','reverse')
%hold on
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Horiz eddy mom flux: ctrl, m^{2}/s^{2}'])
name=['best_plots.ps'];

%PLOT 2
v=-26:2:26;
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,vt_ed_zav_c',v);
colorbar;
colormap(b2r(-25,25));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
freezeColors
cbfreeze(colorbar);
title(['Meridional eddy theta trans: ctrl, Km/s'])

if perturbed_on %PLOT 3
v= -50:5:50;
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,uv_ed_zav_p',v,'k');
colorbar;
colormap(b2r(-50,50));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Horiz eddy mom flux: pert, m^{2}/s^{2}'])

%PLOT 4
v=-26:2:26;
axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,vt_ed_zav_p',v,'k');
colorbar;
colormap(b2r(-25,25));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
title(['Meridional eddy theta trans: pert, Km/s'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
v=-5:8;
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,uv_ed_zav_p'-uv_ed_zav_c',v);
colorbar;
colormap(b2r(-5,8));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Horiz eddy mom flux: pert - ctrl, m^{2}/s^{2}'])

%PLOT 6
v=-1.5:0.15:1.5;
axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,vt_ed_zav_p'-vt_ed_zav_c',v);
colorbar;
colormap(b2r(-1.5,1.5));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
freezeColors
cbfreeze(colorbar);
title(['Meridional eddy theta trans: pert - ctrl, Km/s'])



end; print('-dpsc',name,'-append')

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 4%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if page4

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%for each need to add: contours, colormaps, contour labelling

%PLOT 1
v=-0.2:0.01:0.1;
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,w_zav_c',v);
colorbar;
colormap(b2r(-0.2,0.1));
set(gca,'YDir','reverse')
%hold on
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Vertical wind: ctrl, m/s'])
name=['best_plots.ps'];

%PLOT 2
v=0:1e-3:20e-3;
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,q_zav_c',v);
colorbar;
colormap('default')
caxis([0 20e-3])
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
freezeColors
cbfreeze(colorbar);
title(['Specific humidity: ctrl, kg/kg'])

if perturbed_on %PLOT 3
v=-0.2:0.01:0.1;
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,w_zav_p',v,'k');
colorbar;
colormap(b2r(-0.2,0.1));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Vertical wind: pert, m/s'])

%PLOT 4
v=0:1e-3:20e-3;
axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,q_zav_p',v);
colorbar;
colormap('default')
caxis([0 20e-3])
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
title(['Specific humidity: pert, kg/kg'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
v=-6e-3:0.5e-3:8e-3;
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,w_zav_p'-w_zav_c',v);
colorbar;
colormap(b2r(-6e-3,8e-3));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Vertical wind: pert - ctrl, m/s'])

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,q_zav_p'-q_zav_c',20);
colorbar;
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
freezeColors
cbfreeze(colorbar);
title(['Specific humidity: pert - ctrl, kg/kg'])



end; print('-dpsc',name,'-append')

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 5%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if page5 


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%for each need to add: contours, colormaps, contour labelling

%PLOT 1
v=-4:0.2:0.6;
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,radht_zav_c',v);
colorbar;
colormap(b2r(-4,0.6));
set(gca,'YDir','reverse')
%hold on
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Radiative heating: ctrl, K/day'])
name=['best_plots.ps'];

%PLOT 2
v=-2:0.25:4;
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,difht_zav_c',v);
colorbar;
colormap(b2r(-2,4));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
freezeColors
cbfreeze(colorbar);
title(['Diffusive heating: ctrl, K/day'])

if perturbed_on %PLOT 3
v=-4:0.2:0.6;
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,radht_zav_p',v,'k');
colorbar;
colormap(b2r(-4,0.6));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Radiative heating: pert, K/day'])

%PLOT 4
%v=-2:0.25:4;
axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,difht_zav_p',v,'k');
colorbar;
colormap(b2r(-2,4));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
title(['Diffusive heating: pert, K/day'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
v=-0.04:0.004:0.04;
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,radht_zav_p'-radht_zav_c',v);
colorbar;
colormap(b2r(-0.04,0.04));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Radiative heating: pert - ctrl, K/day'])

%PLOT 6
v=-0.1:0.01:0.1;
axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,difht_zav_p'-difht_zav_c',v);
colorbar;
colormap(b2r(-0.1,0.1));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
freezeColors
cbfreeze(colorbar);
title(['Diffusive heating: pert - ctrl, K/day'])

end; print('-dpsc',name,'-append')


end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 6%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if page6

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%for each need to add: contours, colormaps, contour labelling

%PLOT 1
v=0:0.15:6;
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,cndht_zav_c',v);
colorbar;
colormap(b2r(0,6));
set(gca,'YDir','reverse')
%hold on
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Condensational heating: ctrl, K/day'])
name=['best_plots.ps'];

%PLOT 2
v=-1:0.125:1.5;
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,cnvht_zav_c',v);
colorbar;
colormap(b2r(-1,1.5));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
freezeColors
cbfreeze(colorbar);
title(['Convective heating: ctrl, K/day'])

if perturbed_on %PLOT 3
v=0:0.15:6;
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,cndht_zav_p',v);
colorbar;
colormap(b2r(0,6));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Condensational heating: pert, K/day'])

%PLOT 4
v=-1:0.125:1.5;
axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,cnvht_zav_p',v);
colorbar;
colormap(b2r(-1,1.5));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
title(['Convective heating: pert, K/day'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,cndht_zav_p'-cndht_zav_c',20);
colorbar;
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Condensational heating: pert - ctrl, K/day'])

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,cnvht_zav_p'-cnvht_zav_c',20);
colorbar;
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
freezeColors
cbfreeze(colorbar);
title(['Convective heating: pert - ctrl, K/day'])



end; print('-dpsc',name,'-append')

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 7%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if page7

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

%for each need to add: contours, colormaps, contour labelling

%PLOT 1
v=-2:0.25:6.5;
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,htrt_zav_c',v);
colorbar;
colormap(b2r(-2,6.5));
set(gca,'YDir','reverse')
%hold on
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Total heating: ctrl, K/day'])
name=['best_plots.ps'];

%PLOT 2
%axes('position',[pos2x pos2y xSize_sub ySize_sub])
%[C,h]=contourf(ylat,rC./100.,vN_zav_c',v);
%colorbar;
%set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
%freezeColors
%cbfreeze(colorbar);
%title(['Meridional wind: ctrl, m/s'])

if perturbed_on %PLOT 3
%v=-2:0.25:6.5;
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,htrt_zav_p',v);
colorbar;
colormap(b2r(-2,6.5));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Total heating: pert, K/day'])

%PLOT 4
%axes('position',[pos4x pos4y xSize_sub ySize_sub])
%[C,h]=contourf(ylat,rC./100.,vN_zav_p',20,'k');
%colorbar;
%set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
%title(['Meridional wind: pert, m/s'])
%freezeColors
%cbfreeze(colorbar);

%PLOT 5
v=-0.1:0.01:0.1;
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,htrt_zav_p'-htrt_zav_c',v);
colorbar;
colormap(b2r(-0.1,0.1));
set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Total heating: pert - ctrl, K/day'])

%PLOT 6
%axes('position',[pos6x pos6y xSize_sub ySize_sub])
%[C,h]=contourf(ylat,rC./100.,vN_zav_p'-vN_zav_c',v);
%colorbar;
%set(gca,'YDir','reverse')
%if trop == true
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%end
%xlabel('Latitude')
%freezeColors
%cbfreeze(colorbar);
%title(['Meridional wind: pert - ctrl, m/s'])



end; print('-dpsc',name,'-append')

end

return

