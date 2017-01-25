%plot up meridional and vertical heat transport terms for tropheat3 experiment

%load up v, w, theta data
%calculate zon avs and eddy components
%differentiate w.r.t p, lat


load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0303/tendayavs_control.mat')

uE_c = uE;
vN_c = vN;
w_c = w;
theta_c = theta;

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0303/tendayavs_tropheat3.mat')

[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE,ny,yc,ar,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN,ny,yc,ar,hc);
[w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w,ny,yc,ar,hc);
[theta_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta,ny,yc,ar,hc);

[uE_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(uE_c,ny,yc,ar,hc);
[vN_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(vN_c,ny,yc,ar,hc);
[w_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(w_c,ny,yc,ar,hc);
[theta_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(theta_c,ny,yc,ar,hc);

xi=-179:2:180;yi=-89:2:90;
uE_ll=cube2latlon(xc,yc,uE,xi,yi);
vN_ll=cube2latlon(xc,yc,vN,xi,yi);
w_ll=cube2latlon(xc,yc,w,xi,yi);
theta_ll=cube2latlon(xc,yc,theta,xi,yi);

uE_ll_c=cube2latlon(xc,yc,uE_c,xi,yi);
vN_ll_c=cube2latlon(xc,yc,vN_c,xi,yi);
w_ll_c=cube2latlon(xc,yc,w_c,xi,yi);
theta_ll_c=cube2latlon(xc,yc,theta_c,xi,yi);

for i=1:180
tem(:,:,:) = uE_ll(i,:,:,:);
uE_ed(i,:,:,:) = tem(:,:,:) - uE_zav(:,:,:);
tem(:,:,:) = vN_ll(i,:,:,:);
vN_ed(i,:,:,:) = tem(:,:,:) - vN_zav(:,:,:);
tem(:,:,:) = w_ll(i,:,:,:);
w_ed(i,:,:,:) = tem(:,:,:) - w_zav(:,:,:);
tem(:,:,:) = theta_ll(i,:,:,:);
theta_ed(i,:,:,:) = tem(:,:,:) - theta_zav(:,:,:);

tem(:,:,:) = uE_ll_c(i,:,:,:);
uE_ed_c(i,:,:,:) = tem(:,:,:) - uE_zav_c(:,:,:);
tem(:,:,:) = vN_ll_c(i,:,:,:);
vN_ed_c(i,:,:,:) = tem(:,:,:) - vN_zav_c(:,:,:);
tem(:,:,:) = w_ll_c(i,:,:,:);
w_ed_c(i,:,:,:) = tem(:,:,:) - w_zav_c(:,:,:);
tem(:,:,:) = theta_ll_c(i,:,:,:);
theta_ed_c(i,:,:,:) = tem(:,:,:) - theta_zav_c(:,:,:);
end

[dthetadp,b,c] = gradient(theta_zav, -4000);
[a,b,dtheta_eddp,d] = gradient(theta_ed,-4000);

[dthetadp_c,b,c] = gradient(theta_zav_c, -4000);
[a,b,dtheta_eddp_c,d] = gradient(theta_ed_c,-4000);

[a,dthetady,c] = gradient(theta_zav, 2.*pi./180);
[dtheta_eddy,b,c,d] = gradient(theta_ed, 2.*pi./180);
[a,dthetady_c,c] = gradient(theta_zav_c, 2.*pi./180);
[dtheta_eddy_c,b,c,d] = gradient(theta_ed_c, 2.*pi./180);

a = 6371.0e3;		%radius of the earth
dthetady = dthetady/a;
dtheta_eddy = dtheta_eddy/a;
dthetady_c = dthetady_c/a;
dtheta_eddy_c = dtheta_eddy_c/a;

for i=1:180

tem(:,:,:) = vN_ed(i,:,:,:);
veddth(i,:,:,:) = tem.*dthetady(:,:,:);
tem(:,:,:) = dtheta_eddy(i,:,:,:);
vdthed(i,:,:,:) = vN_zav(:,:,:).*tem;

tem(:,:,:) = w_ed(i,:,:,:);
weddth(i,:,:,:) = tem.*dthetadp(:,:,:);
tem(:,:,:) = dtheta_eddp(i,:,:,:);
wdthed(i,:,:,:) = w_zav(:,:,:).*tem;

tem(:,:,:) = vN_ed_c(i,:,:,:);
veddth_c(i,:,:,:) = tem.*dthetady_c(:,:,:);
tem(:,:,:) = dtheta_eddy_c(i,:,:,:);
vdthed_c(i,:,:,:) = vN_zav_c(:,:,:).*tem;

tem(:,:,:) = w_ed_c(i,:,:,:);
weddth_c(i,:,:,:) = tem.*dthetadp_c(:,:,:);
tem(:,:,:) = dtheta_eddp_c(i,:,:,:);
wdthed_c(i,:,:,:) = w_zav_c(:,:,:).*tem;

end

%try zon averaging
veddth_zav(:,:,:) = mean(veddth,1);
vdthed_zav(:,:,:) = mean(vdthed,1);
weddth_zav(:,:,:) = mean(weddth,1);
wdthed_zav(:,:,:) = mean(wdthed,1);

veddth_zav_c(:,:,:) = mean(veddth_c,1);
vdthed_zav_c(:,:,:) = mean(vdthed_c,1);
weddth_zav_c(:,:,:) = mean(weddth_c,1);
wdthed_zav_c(:,:,:) = mean(wdthed_c,1);


%looks like it goes a bit zeroy, not a surprise...
%what am I meant to be doing again...?

for i=1:6
veddth_tzav(:,:,i) = mean(veddth_zav(:,:,i*10-9:i*10),3);
vdthed_tzav(:,:,i) = mean(vdthed_zav(:,:,i*10-9:i*10),3);
weddth_tzav(:,:,i) = mean(weddth_zav(:,:,i*10-9:i*10),3);
wdthed_tzav(:,:,i) = mean(wdthed_zav(:,:,i*10-9:i*10),3);

veddth_tzav_c(:,:,i) = mean(veddth_zav_c(:,:,i*10-9:i*10),3);
vdthed_tzav_c(:,:,i) = mean(vdthed_zav_c(:,:,i*10-9:i*10),3);
weddth_tzav_c(:,:,i) = mean(weddth_zav_c(:,:,i*10-9:i*10),3);
wdthed_tzav_c(:,:,i) = mean(wdthed_zav_c(:,:,i*10-9:i*10),3);
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

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-5e-6: 1e-6 : 5e-6;
[C,h] = contourf(ylat,rC,veddth_tzav(:,:,1)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(ylat,rC,veddth_tzav(:,:,2)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contourf(ylat,rC,veddth_tzav(:,:,3)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contourf(ylat,rC,veddth_tzav(:,:,4)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')

axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contourf(ylat,rC,veddth_tzav(:,:,5)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contourf(ylat,rC,veddth_tzav(:,:,6)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')





hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-5e-6: 1e-6 : 5e-6;
[C,h] = contourf(ylat,rC,vdthed_tzav(:,:,1)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(ylat,rC,vdthed_tzav(:,:,2)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contourf(ylat,rC,vdthed_tzav(:,:,3)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contourf(ylat,rC,vdthed_tzav(:,:,4)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')

axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contourf(ylat,rC,vdthed_tzav(:,:,5)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contourf(ylat,rC,vdthed_tzav(:,:,6)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')







hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-5e-6: 1e-6 : 5e-6;
[C,h] = contourf(ylat,rC,weddth_tzav(:,:,1)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(ylat,rC,weddth_tzav(:,:,2)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contourf(ylat,rC,weddth_tzav(:,:,3)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contourf(ylat,rC,weddth_tzav(:,:,4)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')

axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contourf(ylat,rC,weddth_tzav(:,:,5)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contourf(ylat,rC,weddth_tzav(:,:,6)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')










hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-5e-6: 1e-6 : 5e-6;
[C,h] = contourf(ylat,rC,wdthed_tzav(:,:,1)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(ylat,rC,wdthed_tzav(:,:,2)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contourf(ylat,rC,wdthed_tzav(:,:,3)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contourf(ylat,rC,wdthed_tzav(:,:,4)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')

axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contourf(ylat,rC,wdthed_tzav(:,:,5)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contourf(ylat,rC,wdthed_tzav(:,:,6)',v);
colorbar;
colormap(b2r(-5e-6,5e-6));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);
xlabel('Latitude')
ylabel('Pressure, Pa')
