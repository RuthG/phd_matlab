%Try evaluating vorticity advection using the area method for a) cube grid b) lat lon grid

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

J=find(strcmp(fldList,'Um_AdvZ3'));
uzcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvZ3'));
vzcs(:,:,:,i) = dyn(:,:,:,J);
[uzE(:,:,:,i),vzN(:,:,:,i)] = rotate_uv2uvEN(uzcs(:,:,:,i),vzcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'Um_AdvRe'));
urcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvRe'));
vrcs(:,:,:,i) = dyn(:,:,:,J);
[urE(:,:,:,i),vrN(:,:,:,i)] = rotate_uv2uvEN(urcs(:,:,:,i),vrcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'Um_Advec'));
uadvcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_Advec'));
vadvcs(:,:,:,i) = dyn(:,:,:,J);
[uadvE(:,:,:,i),vadvN(:,:,:,i)] = rotate_uv2uvEN(uadvcs(:,:,:,i),vadvcs(:,:,:,i),AngleCS,AngleSN,Grid);
end

%calculate f
omega = 7.292e-5;
f = 2.*omega.*sin(yg.*pi./180);

%take time averages of loaded terms
ucs_mean = mean(ucs,4);
vcs_mean = mean(vcs,4);
uadvcs_mean = mean(uadvcs,4);
vadvcs_mean = mean(vadvcs,4);
urcs_mean = mean(urcs,4);
vrcs_mean = mean(vrcs,4);
uzcs_mean = mean(uzcs,4);
vzcs_mean = mean(vzcs,4);
uE_mean = mean(uE,4);
vN_mean = mean(vN,4);
uadvE_mean = mean(uadvE,4);
vadvN_mean = mean(vadvN,4);
uzE_mean = mean(uzE,4);
vzN_mean = mean(vzN,4);
urE_mean = mean(urE,4);
vrN_mean = mean(vrN,4);
w_mean = mean(w,4);

%take zonal averages of loaded terms so we can plot everything
[ucs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(ucs_mean,ny,yc,arc,hc);
[vcs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vcs_mean,ny,yc,arc,hc);
[uadvcs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uadvcs_mean,ny,yc,arc,hc);
[vadvcs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vadvcs_mean,ny,yc,arc,hc);
[urcs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(urcs_mean,ny,yc,arc,hc);
[vrcs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vrcs_mean,ny,yc,arc,hc);
[uzcs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uzcs_mean,ny,yc,arc,hc);
[vzcs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vzcs_mean,ny,yc,arc,hc);
[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_mean,ny,yc,arc,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_mean,ny,yc,arc,hc);
[uadvE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uadvE_mean,ny,yc,arc,hc);
[vadvN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vadvN_mean,ny,yc,arc,hc);
[uzE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uzE_mean,ny,yc,arc,hc);
[vzN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vzN_mean,ny,yc,arc,hc);
[urE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(urE_mean,ny,yc,arc,hc);
[vrN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vrN_mean,ny,yc,arc,hc);
[w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_mean,ny,yc,arc,hc);


%Now shift onto lat lon grid
xi=-179:2:180;yi=-89:2:90;
uEll=cube2latlon(xc,yc,uE,xi,yi);
vNll=cube2latlon(xc,yc,vN,xi,yi);

fll=zeros(180,90);
dxll = zeros(180,90);
dyll = zeros(180,90);
acos = a.*cos(yi.*pi./180);

dyll(:,:) = a.*pi./90;

for i=1:90
fll(:,i) = 2.*omega.*sin(yi(i).*pi./180);
dxll(:,i) = a.*cos(yi(i).*pi./180).*pi./90;
uEcos(:,i,:,:) = uEll(:,i,:,:).*cos(yi(i).*pi./180);
fvN(:,i,:,:) = vNll(:,i,:,:).*fll(1,i);
end

%take gradients w.r.t. y and p
[dudy_s,moo,dudp,boo] = gradient(uEcos,pi./90,1,-4000,1);
%redivide by acos(theta) to give dudy
for i=1:90
dudy(:,i,:,:) = dudy_s(:,i,:,:)./acos(i);
end
%calculate zon and time mean vorticity and coriolis terms
vdudy = -1.*mean(dudy.*vNll,4);
vdudy_zav(:,:) = mean(vdudy,1);
fvN_zav(:,:) = mean(mean(fvN,4),1);

%calculate area of grid cells
arll = dxll.*dyll;

for k=1:25
for tstep=1:360

dyv(:,:) = dyc.*vcs(:,:,k,tstep)./arz;
dxu(:,:) = dxc.*ucs(:,:,k,tstep)./arz;

dyvll(:,:) = dyll.*vNll(:,:,k,tstep)./arll;
dxull(:,:) = dxll.*uEll(:,:,k,tstep)./arll;

[dyvdy,dyvdx] = gradient(dyv);
[dxudy,dxudx] = gradient(dxu);

[dyvdyll,dyvdxll] = gradient(dyvll);
[dxudyll,dxudxll] = gradient(dxull);

zeta3(:,:,k,tstep) = dyvdx - dxudy;
zeta3ll(:,:,k,tstep) = dyvdxll - dxudyll;

gufvzv(:,:,k,tstep) = 1./dxc .* (f + zeta3(:,:,k,tstep)) .* dxg .* vcs(:,:,k,tstep);

gvfuzu(:,:,k,tstep) = -1./dyc .* (f + zeta3(:,:,k,tstep)) .* dyg .* ucs(:,:,k,tstep);

gufvzvll(:,:,k,tstep) = 1./dxll .* (fll + zeta3ll(:,:,k,tstep)) .* dxll .* vNll(:,:,k,tstep);

gvfuzull(:,:,k,tstep) = -1./dyll .* (fll + zeta3ll(:,:,k,tstep)) .* dyll .* uEll(:,:,k,tstep);

end
end

%calculate averages of above terms
gufvzv_mean = mean(gufvzv,4);
gvfuzu_mean = mean(gvfuzu,4);
gufvzvll_mean = mean(gufvzvll,4);
gvfuzull_mean = mean(gvfuzull,4);
zeta3_mean = mean(zeta3,4);
zeta3ll_mean = mean(zeta3ll,4);

%rotate non ll term to compare with ll term + av
[gufvzvE_mean,gvfuzuN_mean] = rotate_uv2uvEN(gufvzv_mean,gvfuzu_mean,AngleCS,AngleSN,Grid);

[gufvzv_zav,mskzon,ylat,areazon]=calcZonalAvgCube(gufvzv_mean,ny,yc,arc,hc);
[gvfuzu_zav,mskzon,ylat,areazon]=calcZonalAvgCube(gvfuzu_mean,ny,yc,arc,hc);
[zeta3_zav,mskzon,ylat,areazon]=calcZonalAvgCube(zeta3_mean,ny,yc,arc,hc);
gufvzvll_zav(:,:) = mean(gufvzvll_mean,1);
gvfuzull_zav(:,:) = mean(gvfuzull_mean,1);
zeta3ll_zav(:,:) = mean(zeta3ll_mean,1);
[gufvzvE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(gufvzvE_mean,ny,yc,arc,hc);
[gvfuzuN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(gvfuzuN_mean,ny,yc,arc,hc);





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
[C,h]=contourf(ylat,rC./100.,gufvzvll_zav',v);
colorbar;
colormap(b2r(-2e-4,2e-4));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title('Lat-lon circ method')
freezeColors
cbfreeze(colorbar);

%PLOT 2
axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-2e-4:0.2e-4:2e-4;
[C,h]=contourf(ylat,rC./100.,gufvzvE_zav',v);
colorbar;
colormap(b2r(-2e-4,2e-4));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['Cube sphere circ method'])
freezeColors
cbfreeze(colorbar);

%PLOT 3
axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-2e-4:0.2e-4:2e-4;
[C,h]=contourf(ylat,rC./100.,uzE_zav',v);
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
[C,h]=contourf(ylat,rC./100.,vdudy_zav'+fvN_zav',v);
colorbar;
colormap(b2r(-2e-4,2e-4));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['Gradient method'])
freezeColors
cbfreeze(colorbar);

%PLOT 5
axes('position',[pos5x pos5y xSize_sub ySize_sub])
v=-1e-3:0.1e-3:1e-3;
[C,h]=contourf(ylat,rC./100.,gufvzv_zav',v);
colorbar;
colormap(b2r(-1e-3,1e-3));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['Cube sphere circ method, not transformed'])
freezeColors
cbfreeze(colorbar);

%PLOT 6
axes('position',[pos6x pos6y xSize_sub ySize_sub])
v=-1e-3:0.1e-3:1e-3;
[C,h]=contourf(ylat,rC./100.,uzcs_zav',v);
colorbar;
colormap(b2r(-1e-3,1e-3));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['MITgcm output, not transformed'])
freezeColors
cbfreeze(colorbar);



 print('-dpdf','gu_checks.pdf')



