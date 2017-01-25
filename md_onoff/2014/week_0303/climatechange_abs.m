%check whether sst changes have had any effect on climate...
%Plot:
%E-P fluxes
%U
%V
%W
%T
%compare with control run

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_accidentalcontrol/';

slashes = findstr(rDir,'/');
point1 = slashes(max(size(slashes))-2);
dir_label = rDir(point1+1:max(size(rDir))-1);
dir_label = strrep(dir_label,'/','_');

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

i=0;
for nit=691440:240:705600
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'WVEL    '));
w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i) = dyn(:,:,:,J);
convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp(:,:,j,i)=theta(:,:,j,i).*convthetatoT(j,1);
end
J=find(strcmp(fldList,'UV_VEL_C'));
uv(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vt_av(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av(:,:,:,i) = dyn(:,:,:,J);
[uEt_av(:,:,:,i),vNt_av(:,:,:,i)] = rotate_uv2uvEN(ut_av(:,:,:,i),vt_av(:,:,:,i),AngleCS,AngleSN,Grid);

%take zonal mean eddy fluxes of momentum and heat
[uE_zav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(uE(:,:,:,i),ny,yc,ar,hc);
[vN_zav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(vN(:,:,:,i),ny,yc,ar,hc);
[theta_zav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(theta(:,:,:,i),ny,yc,ar,hc);
[w_zav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(w(:,:,:,i),ny,yc,ar,hc);
[uv_zav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(uv(:,:,:,i),ny,yc,ar,hc);
[vt_zav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av(:,:,:,i),ny,yc,ar,hc);
[temp_zav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(temp(:,:,:,i),ny,yc,ar,hc);

end

uv_ed_zav = uv_zav - uE_zav.*vN_zav;
vt_ed_zav = vt_zav - vN_zav.*theta_zav;
dthetadp = gradient(theta_zav,-4000.);

ylat_radians = ylat.*pi./180;

a = 6371.0e3;		%radius of the earth
costhi = cos(ylat_radians);
omega = 2*pi/(24*60*60);
f = 2*omega*sin(ylat_radians);
g=9.81;

prefactor = costhi.*2.*pi.*a.^2./g;

%Calculate fluxes and scaled fluxes (Edmon 1980)
for i=1:90
Fphi(i,:,:) = -1.*a.*costhi(i).*uv_ed_zav(i,:,:);
Fp(i,:,:)   = a.*f(i).*costhi(i).*vt_ed_zav(i,:,:)./dthetadp(i,:,:);
Fphi_scaled(i,:,:) = Fphi(i,:,:).*prefactor(i)./a;
Fp_scaled(i,:,:) = Fp(i,:,:).*prefactor(i); 
end


for i=1:6
theta_tav(:,:,i) = mean(theta_zav(:,:, 10*i-9:10*i),3);
temp_tav(:,:,i) = mean(temp_zav(:,:, 10*i-9:10*i),3);
uE_tav(:,:,i) = mean(uE_zav(:,:,10*i-9:10*i),3);
vN_tav(:,:,i) = mean(vN_zav(:,:,10*i-9:10*i),3);
w_tav(:,:,i) = mean(w_zav(:,:,10*i-9:10*i),3);
Fphi_scaled_tav(:,:,i) = mean(Fphi_scaled(:,:, 10*i-9:10*i),3);
Fp_scaled_tav(:,:,i) = mean(Fp_scaled(:,:,10*i-9:10*i),3);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% Plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





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
v=-20:5:50.;
[C,h]=contourf(ylat,rC./100.,uE_tav(:,:,1)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,uE_tav(:,:,1)',v,'k:');
colorbar;
colormap(b2r(-20,50));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Zonal wind, m/s, 1st Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);
name=['uE_avs_abs.ps'];

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-20:5:50.;
[C,h]=contourf(ylat,rC./100.,uE_tav(:,:,2)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,uE_tav(:,:,2)',v,'k:');
colorbar;
colormap(b2r(-20,50));
set(gca,'YDir','reverse')
title(['Zonal wind, m/s, 2nd Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-20:5:50.;
[C,h]=contourf(ylat,rC./100.,uE_tav(:,:,3)',v);
hold on
v=-1000:1000:1000;
[C,h]=contour(ylat,rC./100.,uE_tav(:,:,3)',v,'k:');
colorbar;
colormap(b2r(-20,50));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Zonal wind, m/s, 3rd Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 4
axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-20:5:50.;
[C,h]=contourf(ylat,rC./100.,uE_tav(:,:,4)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,uE_tav(:,:,4)',v,'k:');
colorbar;
colormap(b2r(-20,50));
set(gca,'YDir','reverse')
title(['Zonal wind, m/s, 4th Ten Days'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
v=-20:5:50.;
[C,h]=contourf(ylat,rC./100.,uE_tav(:,:,5)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,uE_tav(:,:,5)',v,'k:');
colorbar;
colormap(b2r(-20,50));
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title(['Zonal wind, m/s, 5th Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
v=-20:5:50.;
[C,h]=contourf(ylat,rC./100.,uE_tav(:,:,6)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,uE_tav(:,:,6)',v,'k:');
colorbar;
colormap(b2r(-20,50));
set(gca,'YDir','reverse')
xlabel('Latitude')
title(['Zonal wind, m/s, 6th Ten Days'])
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


%PLOT 1
axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-6:0.5:6;
[C,h]=contourf(ylat,rC./100.,vN_tav(:,:,1)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,vN_tav(:,:,1)',v,'k:');
colorbar;
colormap(b2r(-6,6));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Meridional wind, m/s, 1st Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);
name=['vN_avs_abs.ps'];

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-6:0.5:6;
[C,h]=contourf(ylat,rC./100.,vN_tav(:,:,2)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,vN_tav(:,:,2)',v,'k:');
colorbar;
colormap(b2r(-6,6));
set(gca,'YDir','reverse')
title(['Meridional wind, m/s, 2nd Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-6:0.5:6;
[C,h]=contourf(ylat,rC./100.,vN_tav(:,:,3)',v);
hold on
v=-1000:1000:1000;
[C,h]=contour(ylat,rC./100.,vN_tav(:,:,3)',v,'k:');
colorbar;
colormap(b2r(-6,6));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Meridional wind, m/s, 3rd Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 4
axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-6:0.5:6;
[C,h]=contourf(ylat,rC./100.,vN_tav(:,:,4)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,vN_tav(:,:,4)',v,'k:');
colorbar;
colormap(b2r(-6,6));
set(gca,'YDir','reverse')
title(['Meridional wind, m/s, 4th Ten Days'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
v=-6:0.5:6;
[C,h]=contourf(ylat,rC./100.,vN_tav(:,:,5)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,vN_tav(:,:,5)',v,'k:');
colorbar;
colormap(b2r(-6,6));
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title(['Meridional wind, m/s, 5th Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
v=-6:0.5:6;
[C,h]=contourf(ylat,rC./100.,vN_tav(:,:,6)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,vN_tav(:,:,6)',v,'k:');
colorbar;
colormap(b2r(-6,6));
set(gca,'YDir','reverse')
xlabel('Latitude')
title(['Meridional wind, m/s, 6th Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);


 print('-dpsc',name)



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
v=200:5:300;
[C,h]=contourf(ylat,rC./100.,temp_tav(:,:,1)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,temp_tav(:,:,1)',v,'k:');
colorbar;
colormap('default');
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Temperature, K, 1st Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);
name=['temp_avs_abs.ps'];

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=200:5:300;
[C,h]=contourf(ylat,rC./100.,temp_tav(:,:,2)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,temp_tav(:,:,2)',v,'k:');
colorbar;
colormap('default');
set(gca,'YDir','reverse')
title(['Temperature, K, 2nd Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=200:5:300;
[C,h]=contourf(ylat,rC./100.,temp_tav(:,:,3)',v);
hold on
v=-1000:1000:1000;
[C,h]=contour(ylat,rC./100.,temp_tav(:,:,3)',v,'k:');
colorbar;
colormap('default');
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['Temperature, K, 3rd Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 4
axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=200:5:300;
[C,h]=contourf(ylat,rC./100.,temp_tav(:,:,4)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,temp_tav(:,:,4)',v,'k:');
colorbar;
colormap('default');
set(gca,'YDir','reverse')
title(['Temperature, K, 4th Ten Days'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
v=200:5:300;
[C,h]=contourf(ylat,rC./100.,temp_tav(:,:,5)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,temp_tav(:,:,5)',v,'k:');
colorbar;
colormap('default');
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title(['Temperature, K, 5th Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
v=200:5:300;
[C,h]=contourf(ylat,rC./100.,temp_tav(:,:,6)',v);
hold on
v=-300:300:300;
[C,h]=contour(ylat,rC./100.,temp_tav(:,:,6)',v,'k:');
colorbar;
colormap('default');
set(gca,'YDir','reverse')
xlabel('Latitude')
title(['Temperature, K, 6th Ten Days'])
hold off
freezeColors
cbfreeze(colorbar);


 print('-dpsc',name)




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

labelling = num2str(shiftdim([10000:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*Fphi_scaled_tav(:,:,1)' ,1.6e-20.*Fp_scaled_tav(:,:,1)' ,'k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
title(['EP Flux diff, 1st Ten Days'])
hold on
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off
name=['ep_avs_abs.ps'];

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
labelling = num2str(shiftdim([10000:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*Fphi_scaled_tav(:,:,2)' ,1.6e-20.*Fp_scaled_tav(:,:,2)' ,'k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
title(['EP Flux diff, 2nd Ten Days'])
hold on
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
labelling = num2str(shiftdim([10000:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*Fphi_scaled_tav(:,:,3)' ,1.6e-20.*Fp_scaled_tav(:,:,3)' ,'k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
title(['EP Flux diff, 3rd Ten Days'])
hold on
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off

%PLOT 4
axes('position',[pos4x pos4y xSize_sub ySize_sub])
labelling = num2str(shiftdim([10000:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*Fphi_scaled_tav(:,:,4)' ,1.6e-20.*Fp_scaled_tav(:,:,4)' ,'k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
title(['EP Flux diff, 4th Ten Days'])
hold on
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
labelling = num2str(shiftdim([10000:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*Fphi_scaled_tav(:,:,5)' ,1.6e-20.*Fp_scaled_tav(:,:,5)' ,'k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
title(['EP Flux diff, 5th Ten Days'])
hold on
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
labelling = num2str(shiftdim([10000:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*Fphi_scaled_tav(:,:,6)' ,1.6e-20.*Fp_scaled_tav(:,:,6)' ,'k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
title(['EP Flux diff, 6th Ten Days'])
hold on
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off


 print('-dpsc',name)
