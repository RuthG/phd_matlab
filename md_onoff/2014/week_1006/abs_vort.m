%calculate absolute vorticity for different runs


rDir='/project/rg312/wv_on_rad_off/run_1yeardaily_c/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
drC=squeeze(rdmds([rDir,'DRC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
ny=90;

%read files
%nit_s = 605040-240;
nit_d = 605040-240;
nit_vw = 72000;

for i = 1:60;
i
nit_d = nit_d + 240;
nit_vw = nit_vw + 240;

rDir='/project/rg312/wv_on_rad_off/run_1yeardaily_c/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit_d);  
eval(M);


J=find(strcmp(fldList,'UVEL    '));
ucs_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_d(:,:,:,i) = dyn(:,:,:,J);
[uE_d(:,:,:,i),vN_d(:,:,:,i)] = rotate_uv2uvEN(ucs_d(:,:,:,i),vcs_d(:,:,:,i),AngleCS,AngleSN,Grid);


rDir='/project/rg312/run_radon_varyingwin/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit_vw);  
eval(M);


J=find(strcmp(fldList,'UVEL    '));
ucs_vw(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_vw(:,:,:,i) = dyn(:,:,:,J);
[uE_vw(:,:,:,i),vN_vw(:,:,:,i)] = rotate_uv2uvEN(ucs_vw(:,:,:,i),vcs_vw(:,:,:,i),AngleCS,AngleSN,Grid);

end

nit=432000;
rDir='/project/rg312/run_radon_doshallower/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_orig = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_orig = dyn(:,:,:,J);
[uE_orig,vN_orig] = rotate_uv2uvEN(ucs_orig,vcs_orig,AngleCS,AngleSN,Grid);

uE_vw_mean = mean(uE_vw,4);
uE_d_mean = mean(uE_d,4);
vN_vw_mean = mean(vN_vw,4);
vN_d_mean = mean(vN_d,4);


xi=-179:2:180;yi=-89:2:90;
uEll_vw=cube2latlon(xc,yc,uE_vw_mean,xi,yi);
uEll_d=cube2latlon(xc,yc,uE_d_mean,xi,yi);
uEll_orig=cube2latlon(xc,yc,uE_orig,xi,yi);
vNll_vw=cube2latlon(xc,yc,vN_vw_mean,xi,yi);
vNll_d=cube2latlon(xc,yc,vN_d_mean,xi,yi);
vNll_orig=cube2latlon(xc,yc,vN_orig,xi,yi);

uE_vw_zav(:,:) = mean(uEll_vw,1);
uE_d_zav(:,:) = mean(uEll_d,1);
uE_orig_zav(:,:) = mean(uEll_orig,1);
vN_vw_zav(:,:) = mean(vNll_vw,1);
vN_d_zav(:,:) = mean(vNll_d,1);
vN_orig_zav(:,:) = mean(vNll_orig,1);

g=9.81;
a=6371.0e3;
omega = 7.292e-5;
rd = 287;
cosphi = zeros(90,25);
sinphi = zeros(90,25);
for k=1:25
cosphi(:,k) = cos(yi.*pi./180);
sinphi(:,k) = sin(yi.*pi./180);
end
f = 2.*omega.*sinphi;

bottom = a.*cosphi;
[b,top_vw] = gradient(uE_vw_zav.*cosphi,pi./90);
dudy_vw = top_vw./bottom;
[b,top_d] = gradient(uE_d_zav.*cosphi,pi./90);
dudy_d = top_d./bottom;
[b,top_orig] = gradient(uE_orig_zav.*cosphi,pi./90);
dudy_orig = top_orig./bottom;

absvort_vw = f - dudy_vw;
absvort_d = f - dudy_d;
absvort_orig = f - dudy_orig;

absvortv_vw = absvort_vw.*vN_vw_zav;
absvortv_d = absvort_d.*vN_d_zav;
absvortv_orig = absvort_orig.*vN_orig_zav;

angmom_vw = (omega.*a.*cosphi + uE_vw_zav).*a.*cosphi;
angmom_d = (omega.*a.*cosphi + uE_d_zav).*a.*cosphi;
angmom_orig = (omega.*a.*cosphi + uE_orig_zav).*a.*cosphi;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 21.0;                  %# A4 paper size
X = 29.7;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 2*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 2*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.3; %0.4;
xSize_sub = 1./2-0.1;

pos1x = 0.1 ; 	pos1y = 0.45; %1/2+0.05;
pos2x = 0.55;	pos2y = 0.45; %1/2+0.05;
pos3x = 0.1; 	pos3y = 0.05;
pos4x = 0.55; 	pos4y = 0.05;

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v = -6e-5:0.5e-5:6e-5;
[C,h] = contourf(yi(35:56),rC./100,absvort_d(35:56,:)',v);
caxis([-6e-5 6e-5]);
colorbar
ylabel('Pressure, hPa')
xlabel('Latitude')
set(gca,'YDir','reverse')
title('Absolute vorticity, deep convection only')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v = -6e-5:0.5e-5:6e-5;
[C,h] = contourf(yi(35:56),rC./100,absvort_vw(35:56,:)',v);
caxis([-6e-5 6e-5]);
colorbar
ylabel('Pressure, hPa')
xlabel('Latitude')
set(gca,'YDir','reverse')
title('Absolute vorticity, shallow convection, vw')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v = 8:0.1:11;
[C,h] = contourf(yi(35:56),rC./100,angmom_d(35:56,:)'./(0.1*omega.*a^2),v);
caxis([8 11]);
colorbar
ylabel('Pressure, hPa')
xlabel('Latitude')
set(gca,'YDir','reverse')
title('Angular momentum, deep convection only')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v = 8:0.1:11;
[C,h] = contourf(yi(35:56),rC./100,angmom_vw(35:56,:)'./(0.1*omega.*a^2),v);
caxis([8 11]);
colorbar
ylabel('Pressure, hPa')
xlabel('Latitude')
set(gca,'YDir','reverse')
title('Angular momentum, shallow convection, vw')

print('-dpdf','compare_vort_am.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v = -6e-5:0.5e-5:6e-5;
[C,h] = contourf(yi(35:56),rC./100,absvort_orig(35:56,:)',v);
caxis([-6e-5 6e-5]);
colorbar
ylabel('Pressure, hPa')
xlabel('Latitude')
set(gca,'YDir','reverse')
title('Absolute vorticity, shallow convection')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v = 8:0.1:11;
[C,h] = contourf(yi(35:56),rC./100,angmom_orig(35:56,:)'./(0.1*omega.*a^2),v);
caxis([8 11]);
colorbar
ylabel('Pressure, hPa')
xlabel('Latitude')
set(gca,'YDir','reverse')
title('Angular momentum, shallow convection')

print('-dpdf','compare_vort_am_shallow.pdf')
