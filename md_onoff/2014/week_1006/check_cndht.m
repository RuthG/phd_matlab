%Compare latent heating structures for shallow convection, deep convection only, and shallow + new radiation runs

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
nit_orig = 432240;

for i = 1:60;
i
nit_d = nit_d + 240;
nit_vw = nit_vw + 240;

rDir='/project/rg312/wv_on_rad_off/run_1yeardaily_c/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit_d);  
eval(M);

J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_d(:,:,:,i) = dyn(:,:,:,J);

rDir='/project/rg312/run_radon_varyingwin/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit_vw);  
eval(M);

J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_vw(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_vw(:,:,:,i) = dyn(:,:,:,J);

end

rDir='/project/rg312/run_shallowconv_singleday/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit_orig);  
eval(M);

J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_orig = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_orig = dyn(:,:,:,J);

xi=-179:2:180;yi=-89:2:90;
cnvhtll_d=cube2latlon(xc,yc,cnvht_d,xi,yi);
cndhtll_d=cube2latlon(xc,yc,cndht_d,xi,yi);
latht_d = cnvhtll_d + cndhtll_d;
latht_d_tzav(:,:) = mean(mean(latht_d,4),1);

cnvhtll_vw=cube2latlon(xc,yc,cnvht_vw,xi,yi);
cndhtll_vw=cube2latlon(xc,yc,cndht_vw,xi,yi);
latht_vw = cnvhtll_vw + cndhtll_vw;
latht_vw_tzav(:,:) = mean(mean(latht_vw,4),1);

cnvhtll_orig=cube2latlon(xc,yc,cnvht_orig,xi,yi);
cndhtll_orig=cube2latlon(xc,yc,cndht_orig,xi,yi);
latht_orig = cnvhtll_orig + cndhtll_orig;
latht_orig_tzav(:,:) = mean(mean(latht_orig,4),1);

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

v=0:0.5:5;
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(xi,yi,latht_d(:,:,20,59)'.*86400,v);
caxis([0 5]);
xlabel('Longitude')
ylabel('Latitude')
title('Deep convection only, 220hPa')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(xi,yi,latht_vw(:,:,20,59)'.*86400,v);
caxis([0 5]);
xlabel('Longitude')
ylabel('Latitude')
title('Shallow convection + vw scheme, 220hPa')


axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(xi,yi,latht_d(:,:,15,59)'.*86400,v);
caxis([0 5]);
xlabel('Longitude')
ylabel('Latitude')
title('Deep convection only, 420hPa')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(xi,yi,latht_vw(:,:,15,59)'.*86400,v);
caxis([0 5]);
xlabel('Longitude')
ylabel('Latitude')
title('Shallow convection + vw scheme, 420hPa')

print('-dpdf', 'latht_structures.pdf')

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

v=0:0.5:5;
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(xi,yi,latht_orig(:,:,20)'.*86400,v);
caxis([0 5]);
xlabel('Longitude')
ylabel('Latitude')
title('Shallow convection, 220hPa')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(xi,yi,latht_orig(:,:,15)'.*86400,v);
caxis([0 5]);
xlabel('Longitude')
ylabel('Latitude')
title('Shallow convection, 420hPa')

print('-dpdf', 'latht_structures_shallow.pdf')

return


