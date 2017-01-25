%best_plots_novt.m
%Produce good 10 yr av plots of u,v,w,uv,vT,T,theta,q,heat rates

%Read in iteration number, directory, MITgcm output and grid details

function plotout = best_plots_fn_novt(start,step,last);

rDir='./';

%Create reference label to identify run plot is for!
directory = pwd;
lastslash = max(findstr(directory,'/'));
dir_label = directory(lastslash:max(size(directory)));
dir_label = strrep(dir_label,'_','-');

%read in tropopause of control run
%load('/disk1/rg312/run_daily_swwv/tropopause.mat')

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

%step= 2400;
%start = 86400;
%last = 235200;
nos = (last - start)./step +1;

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


cntrs = -25:5:70;
%subplot(3,2,1)
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,uE_mean',cntrs);
label = -25:5:70;
clabel(C,h,label);
%-22.4913
%35.4518
colormap(b2r(-25,70));
colorbar;
set(gca,'YDir','reverse')
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Zonal wind, m/s - ', dir_label])
name=['best_plots.ps'];

cntrs = -6:0.5:6;
%subplot(3,2,2)
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,vN_mean',cntrs);
label = -6:1:6;
clabel(C,h,label);
%-4.3643
%4.3637
colormap(b2r(-6,6));
colorbar;
set(gca,'YDir','reverse')
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%xlabel('Latitude')
%ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Meridional wind, m/s'])

cntrs = [270:10:330,360:30:900];
%subplot(3,2,3)
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,theta_mean',cntrs,'k');
label = [270:20:330,360:60:900];
clabel(C,h,label);
%272.0406
%794.0503
colormap('default');
caxis([270 900]) 
colorbar;
set(gca,'YDir','reverse')
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Potential temperature, K'])


cntrs = 200:5:300;
%subplot(3,2,4)
axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,temp_mean',cntrs,'k');
label = 200:10:300;
clabel(C,h,label);
%203.6881
%299.7349
colormap('default');
caxis([200 300]) 
colorbar;
set(gca,'YDir','reverse')
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%xlabel('Latitude')
%ylabel('Pressure, hPa')
title(['Temperature, K'])
freezeColors
cbfreeze(colorbar);


cntrs = -55:5:55;
%subplot(3,2,5)
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,uv_ed_mean',cntrs);
label = -55:5:55;
clabel(C,h,label);
%-42.3304
%43.3374
colormap(b2r(-55,55));
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
%[C,h]=contourf(ylat,rC./100.,vt_ed_mean',cntrs);
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


cntrs = -0.18:0.01:0.04;
%subplot(3,2,1)
%axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,w_mean',cntrs);
label = -0.18:0.02:0.04;
clabel(C,h,label);
%-0.1714
%0.0417
colormap(b2r(-0.18,0.04));
colorbar;
set(gca,'YDir','reverse')
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Vertical wind, Pa/s'])
print('-dpsc',name)

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')
cntrs = 0:0.001:0.021;
%subplot(3,2,2)
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,q_mean',cntrs,'k');
label = 0:0.002:0.021;
clabel(C,h,label);
%1.42e-8
%0.01
colormap(b2r(0,0.021));
colorbar;
set(gca,'YDir','reverse')
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%xlabel('Latitude')
%ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Specific humidity, kg/kg - ', dir_label])



cntrs = -2:0.5:7;
%subplot(3,2,3)
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,htrt_mean',cntrs);
label = -2:1:7;
clabel(C,h,label);
%-1.2273
%5.3463
colormap(b2r(-2,7));
colorbar;
set(gca,'YDir','reverse')
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Total heating (\theta), K/s'])


cntrs = -4:0.25:1;
%subplot(3,2,4)
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,radht_mean',cntrs);
label = -4:0.5:1;
clabel(C,h,label);
%-2.5753
%0.5839
colormap(b2r(-4,1));
colorbar;
set(gca,'YDir','reverse')
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
%xlabel('Latitude')
%ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Radiative heating (\theta), K/s'])


cntrs = 0:0.3:6.6;
%subplot(3,2,5)
axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,cndht_mean',cntrs);
label = 0:0.6:6.6;
clabel(C,h,label);
%0
%5.6922
colormap(b2r(0,6.6));
colorbar;
set(gca,'YDir','reverse')
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Lsc heating (\theta), K/s'])


cntrs = -1:0.2:2;
%subplot(3,2,6)
axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,cnvht_mean',cntrs);
label = -1:0.2:2;
clabel(C,h,label);
%-0.9920
%1.1004
colormap(b2r(-1,2));
colorbar;
set(gca,'YDir','reverse')
%hold on
%plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
xlabel('Latitude')
%ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);
title(['Cnv heating (\theta), K/s'])

%print('-dpsc',name,'-append')

%hFig = figure('Menubar','none');
%# figure size printed on paper
%set(hFig, 'PaperUnits','centimeters')
%set(hFig, 'PaperSize',[X Y])
%set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
%set(hFig, 'PaperOrientation','portrait')
cntrs = -1.6:0.2:2.8;
%subplot(3,2,1)
axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h]=contourf(ylat,rC./100.,difht_mean',cntrs);
label = -1.6:0.4:2.8;
clabel(C,h,label);
%-1.4969
%2.7463
colormap(b2r(-1.6,2.8));
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

