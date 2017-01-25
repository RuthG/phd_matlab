%use areas method to test shear term analagously to vorticity advection term.


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_mombudg_2/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
dxc=rdmds([rDir,'DXC']);
dyc=rdmds([rDir,'DYC']);
dxg=rdmds([rDir,'DXG']);
dyg=rdmds([rDir,'DYG']);
drf=rdmds([rDir,'DRF']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
arc=rdmds([rDir,'RAC']);
ars=rdmds([rDir,'RAS']);
arw=rdmds([rDir,'RAW']);
arz=rdmds([rDir,'RAZ']);
rC=squeeze(rdmds([rDir,'RC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
ny=90;
a=6371.0e3;

%start reading files: u, v, w, momentum budget terms
i=0;
for nit = 605040:240:691200;
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

J=find(strcmp(fldList,'Um_AdvRe'));
urcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvRe'));
vrcs(:,:,:,i) = dyn(:,:,:,J);
[urE(:,:,:,i),vrN(:,:,:,i)] = rotate_uv2uvEN(urcs(:,:,:,i),vrcs(:,:,:,i),AngleCS,AngleSN,Grid);

end

%convert to lat lon grid
xi=-179:2:180;yi=-89:2:90;
uEll=cube2latlon(xc,yc,uE,xi,yi);
vNll=cube2latlon(xc,yc,vN,xi,yi);
wll=cube2latlon(xc,yc,w,xi,yi);

[dvcsdy,dvcsdx,dvcsdz,dvcsdt] = gradient(vcs,1);
[ducsdy,ducsdx,ducsdz,ducsdt] = gradient(ucs,1);

[dvNdy,dvNdx,dvNdz,dvNdt] = gradient(vNll,1);
[duEdy,duEdx,duEdz,duEdt] = gradient(uEll,1);


for k=1:25
for tstep=1:360

guzw(:,:,k,tstep) = 1./drf(k) .* w(:,:,k,tstep) .* ducsdz(:,:,k,tstep);
gvzw(:,:,k,tstep) = 1./drf(k) .* w(:,:,k,tstep) .* dvcsdz(:,:,k,tstep);
guzwll(:,:,k,tstep) = 1./drf(k) .* wll(:,:,k,tstep) .* duEdz(:,:,k,tstep);
gvzwll(:,:,k,tstep) = 1./drf(k) .* wll(:,:,k,tstep) .* dvNdz(:,:,k,tstep);

end
end

guzw_mean = mean(guzw,4);
gvzw_mean = mean(gvzw,4);
guzwll_mean = mean(guzwll,4);
gvzwll_mean = mean(gvzwll,4);
urcs_mean = mean(urcs,4);
vrcs_mean = mean(vrcs,4);
urE_mean = mean(urE,4);
vrN_mean = mean(vrN,4);
temp_mean = mean(temp,4);

[guzwE_mean,gvzwN_mean] = rotate_uv2uvEN(guzw_mean,gvzw_mean,AngleCS,AngleSN,Grid);

[guzw_zav,mskzon,ylat,areazon]=calcZonalAvgCube(guzw_mean,ny,yc,arc,hc);
[gvzw_zav,mskzon,ylat,areazon]=calcZonalAvgCube(gvzw_mean,ny,yc,arc,hc);
[guzwE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(guzwE_mean,ny,yc,arc,hc);
[gvzwN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(gvzwN_mean,ny,yc,arc,hc);
guzwll_zav(:,:) = mean(guzwll_mean,1);
gvzwll_zav(:,:) = mean(gvzwll_mean,1);
[urcs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(urcs_mean,ny,yc,arc,hc);
[vrcs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vrcs_mean,ny,yc,arc,hc);
[urE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(urE_mean,ny,yc,arc,hc);
[vrN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vrN_mean,ny,yc,arc,hc);
[temp_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_mean,ny,yc,arc,hc);

Ra = 287;
for i=1:25
rho(:,i) = rC(i)./(Ra.*temp_zav(:,i));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PLOT UP DIFFERENT VERSIONS OF GU


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
v=-2e-4:0.2e-4:2e-4;
[C,h]=contourf(ylat,rC./100.,guzwll_zav',v);
colorbar;
colormap(b2r(-2e-4,2e-4));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title('Lat-lon method')
freezeColors
cbfreeze(colorbar);

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-2e-4:0.2e-4:2e-4;
[C,h]=contourf(ylat,rC./100.,guzwE_zav',v);
colorbar;
colormap(b2r(-2e-4,2e-4));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['Cube sphere method'])
freezeColors
cbfreeze(colorbar);

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-2e-4:0.2e-4:2e-4;
[C,h]=contourf(ylat,rC./100.,urE_zav',v);
colorbar;
colormap(b2r(-2e-4,2e-4));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['MITgcm output'])
freezeColors
cbfreeze(colorbar);

%PLOT 4
axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-2e-4:0.2e-4:2e-4;
[C,h]=contourf(ylat,rC./100.,guzw_zav',v);
colorbar;
colormap(b2r(-2e-4,2e-4));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['Cube sphere method, not transformed'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
v=-2e-4:0.2e-4:2e-4;
[C,h]=contourf(ylat,rC./100.,urcs_zav',v);
colorbar;
colormap(b2r(-2e-4,2e-4));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['MITgcm output, not transformed'])
freezeColors
cbfreeze(colorbar);



 print('-dpdf','gu_shear_checks.pdf')
