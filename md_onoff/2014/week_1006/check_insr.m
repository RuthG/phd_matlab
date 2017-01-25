%check the incident shortwave radiation in our seasonal run!

rDir='/project/rg312/run_delsol1.8/';
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
i=0;
nit = 172800;
i=i+1

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhInSR'));
swin_18(:,:,i)=surf(:,:,J);

nit=432240;
rDir='/project/rg312/run_oneday/';
[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhInSR'));
swin_o(:,:,i)=surf(:,:,J);

xi=-179:2:180;yi=-89:2:90;

swinll_o=cube2latlon(xc,yc,swin_o,xi,yi);

swinll_18=cube2latlon(xc,yc,swin_18,xi,yi);

return

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'AtPhdTcv'));
cnvht(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'AtPhdTcd'));
cndht(:,:,:,i) = dyn(:,:,:,J);

    convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
      t(:,:,k,i)=theta(:,:,k,i).*convthetatoT(k,1);
    end




xi=-179:2:180;yi=-89:2:90;
swinll=cube2latlon(xc,yc,swin,xi,yi);
uEll=cube2latlon(xc,yc,uE,xi,yi);
vNll=cube2latlon(xc,yc,vN,xi,yi);
tll=cube2latlon(xc,yc,t,xi,yi);
cnvhtll=cube2latlon(xc,yc,cnvht,xi,yi);
cndhtll=cube2latlon(xc,yc,cndht,xi,yi);

uEll_djf = (sum(uEll(:,:,:,331:360),4) + sum(uEll(:,:,:,1:60),4))./90;
uEll_mam = mean(uEll(:,:,:,61:150),4);
uEll_jja = mean(uEll(:,:,:,151:240),4);
uEll_son = mean(uEll(:,:,:,241:330),4);

tll_djf = (sum(tll(:,:,:,331:360),4) + sum(tll(:,:,:,1:60),4))./90;
tll_mam = mean(tll(:,:,:,61:150),4);
tll_jja = mean(tll(:,:,:,151:240),4);
tll_son = mean(tll(:,:,:,241:330),4);


uEll_djf_zav(:,:) = mean(uEll_djf,1);
uEll_mam_zav(:,:) = mean(uEll_mam,1);
uEll_jja_zav(:,:) = mean(uEll_jja,1);
uEll_son_zav(:,:) = mean(uEll_son,1);

tll_djf_zav(:,:) = mean(tll_djf,1);
tll_mam_zav(:,:) = mean(tll_mam,1);
tll_jja_zav(:,:) = mean(tll_jja,1);
tll_son_zav(:,:) = mean(tll_son,1);




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

v=190:10:300;
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi,rC,tll_djf_zav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
ylabel('Pressure, Pa')
title('DJF')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi,rC,tll_mam_zav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
title('MAM')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi,rC,tll_jja_zav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
ylabel('Pressure, Pa')
xlabel('Latitude')
title('JJA')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi,rC,tll_son_zav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
title('SON')

print('-dpdf','t_seasonal.pdf')

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

v=-20:5:50;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi,rC,uEll_djf_zav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
ylabel('Pressure, Pa')
title('DJF')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi,rC,uEll_mam_zav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
title('MAM')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi,rC,uEll_jja_zav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
ylabel('Pressure, Pa')
xlabel('Latitude')
title('JJA')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi,rC,uEll_son_zav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
title('SON')

print('-dpdf','uE_seasonal.pdf')


