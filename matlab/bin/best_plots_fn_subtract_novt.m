%best_plots_fn_subtract.m
%Produce good difference plots of u,v,w,uv,vT,T,theta,q,heat rates

%Read in iteration number, directory, MITgcm output and grid details

function plotout = best_plots_fn_subtract_novt(dir1,dir2,start,step,last);

rDir=dir1;

%Create reference label to identify run plot is for!
directory = dir1;
lastslash = max(findstr(directory,'/'));
dir_label = directory(lastslash:max(size(directory)));
dir_label = strrep(dir_label,'_','-');

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

for nit = start:step:last;

ucs=rdmds([rDir,'uVeltave'],nit);
vcs=rdmds([rDir,'vVeltave'],nit);
[uE,vN] = rotate_uv2uvEN(ucs,vcs,AngleCS,AngleSN,Grid);
uEvN=uE.*vN;
[vN_ctrl(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(vN,ny,yc,ar,hc);
[uE_ctrl(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(uE,ny,yc,ar,hc);

t=rdmds([rDir,'Ttave'],nit);
[theta_ctrl(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(t,ny,yc,ar,hc);

convthetatoT=(rC/rC(1)).^(2./7.);
for j=1:size(rC)
realt(:,:,j)=t(:,:,j).*convthetatoT(j,1);
end
[temp_ctrl(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(realt,ny,yc,ar,hc);

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UV_VEL_C'));
uv = dyn(:,:,:,J);
uv_ed = uv - uEvN;
[uv_ed_zc(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(uv_ed,ny,yc,ar,hc);

%J=find(strcmp(fldList,'VVELTH  '));
%vt_av = dyn(:,:,:,J);
%J=find(strcmp(fldList,'UVELTH  '));
%ut_av = dyn(:,:,:,J);
%[uEt_av,vNt_av] = rotate_uv2uvEN(ut_av,vt_av,AngleCS,AngleSN,Grid);

%vt = vN.*t;
%vt_ed = vNt_av - vt;
%[vt_ed_zc(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(vt_ed,ny,yc,ar,hc);


w=rdmds([rDir,'wVeltave'],nit);
[w_ctrl(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(w,ny,yc,ar,hc);

q=rdmds([rDir,'Stave'],nit);
[q_ctrl(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(q,ny,yc,ar,hc);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt=dyn(:,:,:,J);
htrt=htrt*86400.;
[htrt_ctrl(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(htrt,ny,yc,ar,hc);


J=find(strcmp(fldList,'AtPhdTrd'));
radht=dyn(:,:,:,J);
radht=radht*86400.;
[radht_ctrl(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(radht,ny,yc,ar,hc);


J=find(strcmp(fldList,'AtPhdTcd'));
cndht=dyn(:,:,:,J);
cndht=cndht*86400.;
[cndht_ctrl(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(cndht,ny,yc,ar,hc);


J=find(strcmp(fldList,'AtPhdTdf'));
difht=dyn(:,:,:,J);
difht=difht*86400.;
[difht_ctrl(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(difht,ny,yc,ar,hc);


J=find(strcmp(fldList,'AtPhdTcv'));
cnvht=dyn(:,:,:,J);
cnvht=cnvht*86400.;
[cnvht_ctrl(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(cnvht,ny,yc,ar,hc);

end

rDir = dir2;

for nit = start:step:last;

ucs=rdmds([rDir,'uVeltave'],nit);
vcs=rdmds([rDir,'vVeltave'],nit);
[uE,vN] = rotate_uv2uvEN(ucs,vcs,AngleCS,AngleSN,Grid);
uEvN=uE.*vN;
[vN_ctrl_2(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(vN,ny,yc,ar,hc);
[uE_ctrl_2(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(uE,ny,yc,ar,hc);

t=rdmds([rDir,'Ttave'],nit);
[theta_ctrl_2(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(t,ny,yc,ar,hc);

convthetatoT=(rC/rC(1)).^(2./7.);
for j=1:size(rC)
realt(:,:,j)=t(:,:,j).*convthetatoT(j,1);
end
[temp_ctrl_2(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(realt,ny,yc,ar,hc);

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UV_VEL_C'));
uv = dyn(:,:,:,J);
uv_ed = uv - uEvN;
[uv_ed_zc_2(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(uv_ed,ny,yc,ar,hc);

%J=find(strcmp(fldList,'VVELTH  '));
%vt_av = dyn(:,:,:,J);
%J=find(strcmp(fldList,'UVELTH  '));
%ut_av = dyn(:,:,:,J);
%[uEt_av,vNt_av] = rotate_uv2uvEN(ut_av,vt_av,AngleCS,AngleSN,Grid);

%vt = vN.*t;
%vt_ed = vNt_av - vt;
%[vt_ed_zc_2(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(vt_ed,ny,yc,ar,hc);


w=rdmds([rDir,'wVeltave'],nit);
[w_ctrl_2(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(w,ny,yc,ar,hc);

q=rdmds([rDir,'Stave'],nit);
[q_ctrl_2(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(q,ny,yc,ar,hc);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt=dyn(:,:,:,J);
htrt=htrt*86400.;
[htrt_ctrl_2(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(htrt,ny,yc,ar,hc);


J=find(strcmp(fldList,'AtPhdTrd'));
radht=dyn(:,:,:,J);
radht=radht*86400.;
[radht_ctrl_2(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(radht,ny,yc,ar,hc);


J=find(strcmp(fldList,'AtPhdTcd'));
cndht=dyn(:,:,:,J);
cndht=cndht*86400.;
[cndht_ctrl_2(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(cndht,ny,yc,ar,hc);


J=find(strcmp(fldList,'AtPhdTdf'));
difht=dyn(:,:,:,J);
difht=difht*86400.;
[difht_ctrl_2(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(difht,ny,yc,ar,hc);


J=find(strcmp(fldList,'AtPhdTcv'));
cnvht=dyn(:,:,:,J);
cnvht=cnvht*86400.;
[cnvht_ctrl_2(:,:,(nit-start)./step + 1),mskzon,ylat,areazon]=calcZonalAvgCube(cnvht,ny,yc,ar,hc);

end



uE_mean = mean(uE_ctrl,3);
vN_mean = mean(vN_ctrl,3);
theta_mean = mean(theta_ctrl,3);
temp_mean = mean(temp_ctrl,3);
uv_ed_mean = mean(uv_ed_zc,3);
%vt_ed_mean = mean(vt_ed_zc,3);
w_mean = mean(w_ctrl,3);
q_mean = mean(q_ctrl,3);
htrt_mean = mean(htrt_ctrl,3);
radht_mean = mean(radht_ctrl,3);
cndht_mean = mean(cndht_ctrl,3);
cnvht_mean = mean(cnvht_ctrl,3);
difht_mean = mean(difht_ctrl,3);

uE_mean_2 = mean(uE_ctrl_2,3);
vN_mean_2 = mean(vN_ctrl_2,3);
theta_mean_2 = mean(theta_ctrl_2,3);
temp_mean_2 = mean(temp_ctrl_2,3);
uv_ed_mean_2 = mean(uv_ed_zc_2,3);
%vt_ed_mean_2 = mean(vt_ed_zc_2,3);
w_mean_2 = mean(w_ctrl_2,3);
q_mean_2 = mean(q_ctrl_2,3);
htrt_mean_2 = mean(htrt_ctrl_2,3);
radht_mean_2 = mean(radht_ctrl_2,3);
cndht_mean_2 = mean(cndht_ctrl_2,3);
cnvht_mean_2 = mean(cnvht_ctrl_2,3);
difht_mean_2 = mean(difht_ctrl_2,3);

uE_diff = uE_mean - uE_mean_2;
vN_diff = vN_mean - vN_mean_2;
theta_diff = theta_mean - theta_mean_2;
temp_diff = temp_mean - temp_mean_2;
uv_ed_diff = uv_ed_mean - uv_ed_mean_2;
%vt_ed_diff = vt_ed_mean - vt_ed_mean_2;
w_diff = w_mean - w_mean_2;
q_diff = q_mean - q_mean_2;
htrt_diff = htrt_mean - htrt_mean_2;
radht_diff = radht_mean - radht_mean_2;
cndht_diff = cndht_mean - cndht_mean_2;
cnvht_diff = cnvht_mean - cnvht_mean_2;
difht_diff = difht_mean - difht_mean_2;

%set up plotting
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

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


cntrs = -10:1:10;
%subplot(3,2,1)
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,uE_diff',cntrs);
label = -10:1:10;
clabel(C,h,label);
%-22.4913
%35.4518
colormap(b2r(-10,10));
colorbar;
set(gca,'YDir','reverse')
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Zonal wind, m/s - ', dir_label])
name=['best_plots_diff.ps'];

cntrs = -1.:0.1:1.;
%subplot(3,2,2)
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,vN_diff',cntrs);
label = -1.:0.1:1.;
clabel(C,h,label);
%-4.3643
%4.3637
colormap(b2r(-1,1));
colorbar;
set(gca,'YDir','reverse')
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%xlabel('Latitude')
%ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Meridional wind, m/s'])

cntrs = [-10:1:10];
%subplot(3,2,3)
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,theta_diff',cntrs,'k');
label = [-10:1:10];
clabel(C,h,label);
colormap(b2r(-10,10));
colorbar;
set(gca,'YDir','reverse')
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Potential temperature, K'])


cntrs = -10:0.25:10;
%subplot(3,2,4)
axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_diff',cntrs,'k');
label = -10:0.5:10;
clabel(C,h,label);
colormap(b2r(-10,10));
colorbar;
set(gca,'YDir','reverse')
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%xlabel('Latitude')
%ylabel('Pressure, hPa')
title(['Temperature, K'])
freezeColors
cbfreeze(colorbar);


cntrs = -20:2:20;
%subplot(3,2,5)
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,uv_ed_diff',cntrs);
label = -20:2:20;
clabel(C,h,label);
%-42.3304
%43.3374
colormap(b2r(-20,20));
colorbar;
set(gca,'YDir','reverse')
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Horiz eddy mom, m^{2}/s^{2} - ', dir_label])

%cntrs = -32:4:32;
%subplot(3,2,6)
axes('position',[pos6x pos6y xSize_sub ySize_sub])
%[C,h]=contourf(ylat,rC./100.,vt_ed_diff',cntrs);
%label = -32:8:32;
%clabel(C,h,label);
%colormap(b2r(-32,32));
%colorbar;
%set(gca,'YDir','reverse')
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%xlabel('Latitude')
%ylabel('Pressure, hPa')
%freezeColors
%cbfreeze(colorbar);
%title(['Eddy heat trans, K*m/s'])
%print('-dpsc',name)


cntrs = -0.02:0.002:0.02;
%subplot(3,2,1)
%axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,w_diff',cntrs);
label = -0.02:0.004:0.02;
clabel(C,h,label);
colormap(b2r(-0.02,0.02));
colorbar;
set(gca,'YDir','reverse')
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Vertical wind, Pa/s - ', dir_label])
print('-dpsc',name)

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')
cntrs = -0.002:0.0005:0.002;
%subplot(3,2,2)
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,q_diff',cntrs,'k');
label = -0.0020:0.001:0.0020;
clabel(C,h,label);
colormap(b2r(-0.002,0.002));
colorbar;
set(gca,'YDir','reverse')
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%xlabel('Latitude')
%ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Specific humidity, kg/kg'])



cntrs = -1:0.1:1;
%subplot(3,2,3)
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,htrt_diff',cntrs);
label = -1:0.1:1;
clabel(C,h,label);
colormap(b2r(-1,1));
colorbar;
set(gca,'YDir','reverse')
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Total heating (\theta), K/s'])


cntrs = -1:0.1:1;
%subplot(3,2,4)
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,radht_diff',cntrs);
label = -1:0.1:1;
clabel(C,h,label);
%-2.5753
%0.5839
colormap(b2r(-1,1));
colorbar;
set(gca,'YDir','reverse')
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%xlabel('Latitude')
%ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Radiative heating (\theta), K/s'])


cntrs = -1:0.1:1;
%subplot(3,2,5)
axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,cndht_diff',cntrs);
label = -1:0.01:1;
clabel(C,h,label);
%0
%5.6922
colormap(b2r(-1,1));
colorbar;
set(gca,'YDir','reverse')
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Lsc heating (\theta), K/s'])


cntrs = -1:0.1:1;
%subplot(3,2,6)
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,cnvht_diff',cntrs);
label = -1:0.01:1;
clabel(C,h,label);
colormap(b2r(-1,1));
colorbar;
set(gca,'YDir','reverse')
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
xlabel('Latitude')
%ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Cnv heating (\theta), K/s'])

cntrs = -1:0.1:1;
%subplot(3,2,1)
axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,difht_diff',cntrs);
label = -1:0.01:1;
clabel(C,h,label);
%-1.4969
%2.7463
colormap(b2r(-1,1));
colorbar;
set(gca,'YDir','reverse')
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Diffusive heating (\theta), K/s - ', dir_label])

print('-dpsc',name,'-append')



return

