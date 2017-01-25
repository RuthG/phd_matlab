%load in diabatic heating fields for a day 60 of each run, pick a level, and plot a snapshot of the heating


rDir='/disk1/MITgcm/verification/atm_gray_ruth/ensemble_control/';

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

nit = 726000;
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdTdt'));
htrt_c=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_c=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_c=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_c=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_c=dyn(:,:,:,J);


rDir = '/disk1/MITgcm/verification/atm_gray_ruth/ensemble/run_start_648000/';
nit = 662400;
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdTdt'));
htrt_th=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_th=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_th=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_th=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_th=dyn(:,:,:,J);

rDir = '/disk1/MITgcm/verification/atm_gray_ruth/ensemble_wet/run_start_705600/';
nit = 720000;
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdTdt'));
htrt_w=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_w=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_w=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_w=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_w=dyn(:,:,:,J);


xi=-179:2:180;yi=-89:2:90;

htrt_c_ll=cube2latlon(xc,yc,htrt_c,xi,yi).*86400;
cndht_c_ll=cube2latlon(xc,yc,cndht_c,xi,yi).*86400;
cnvht_c_ll=cube2latlon(xc,yc,cnvht_c,xi,yi).*86400;
radht_c_ll=cube2latlon(xc,yc,radht_c,xi,yi).*86400;
difht_c_ll=cube2latlon(xc,yc,difht_c,xi,yi).*86400;

htrt_th_ll=cube2latlon(xc,yc,htrt_th,xi,yi).*86400;
cndht_th_ll=cube2latlon(xc,yc,cndht_th,xi,yi).*86400;
cnvht_th_ll=cube2latlon(xc,yc,cnvht_th,xi,yi).*86400;
radht_th_ll=cube2latlon(xc,yc,radht_th,xi,yi).*86400;
difht_th_ll=cube2latlon(xc,yc,difht_th,xi,yi).*86400;

htrt_w_ll=cube2latlon(xc,yc,htrt_w,xi,yi).*86400;
cndht_w_ll=cube2latlon(xc,yc,cndht_w,xi,yi).*86400;
cnvht_w_ll=cube2latlon(xc,yc,cnvht_w,xi,yi).*86400;
radht_w_ll=cube2latlon(xc,yc,radht_w,xi,yi).*86400;
difht_w_ll=cube2latlon(xc,yc,difht_w,xi,yi).*86400;

heat_budg_c(:,:,1) = htrt_c_ll(:,:,6);
heat_budg_c(:,:,2) = cndht_c_ll(:,:,6);
heat_budg_c(:,:,3) = cnvht_c_ll(:,:,6);
heat_budg_c(:,:,4) = radht_c_ll(:,:,6);
heat_budg_c(:,:,5) = difht_c_ll(:,:,6);

heat_budg_th(:,:,1) = htrt_th_ll(:,:,6);
heat_budg_th(:,:,2) = cndht_th_ll(:,:,6);
heat_budg_th(:,:,3) = cnvht_th_ll(:,:,6);
heat_budg_th(:,:,4) = radht_th_ll(:,:,6);
heat_budg_th(:,:,5) = difht_th_ll(:,:,6);

heat_budg_w(:,:,1) = htrt_w_ll(:,:,6);
heat_budg_w(:,:,2) = cndht_w_ll(:,:,6);
heat_budg_w(:,:,3) = cnvht_w_ll(:,:,6);
heat_budg_w(:,:,4) = radht_w_ll(:,:,6);
heat_budg_w(:,:,5) = difht_w_ll(:,:,6);

title_array(1,:) = 'Total heating         ';
title_array(2,:) = 'Condensational heating';
title_array(3,:) = 'Convective heating    ';
title_array(4,:) = 'Radiative heating     ';
title_array(5,:) = 'Diffusive heating     ';

levels_array(1,:) = -10.5:1.5:19.5;
levels_array(2,:) = 0:1:20;
levels_array(3,:) = -10:1:10;
levels_array(4,:) = -5.6:0.4:2.4;
levels_array(5,:) = -10:1:10;

maxmin(1,:) = [-10.5,19.4];
maxmin(2,:) = [0,20];
maxmin(3,:) = [-10,10];
maxmin(4,:) = [-5.6,2.4];
maxmin(5,:) = [-10,10];


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

posx = [0.1,0.55,0.1,0.55,0.1,0.55];
posy = [2/3+0.05,2/3+0.05,1/3+0.05,1/3+0.05,0.05,0.05];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Control%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

for i=1:5
v=levels_array(i,:);
axes('position',[posx(i) posy(i) xSize_sub ySize_sub])
[C,h] = contourf(xi,yi,heat_budg_c(:,:,i)');
title(title_array(i,:));
colorbar
colormap(b2r(maxmin(i,1),maxmin(i,2)));
freezeColors
cbfreeze(colorbar);
end

print('-dpdf','heat_snapshot_ctrl.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

for i=1:5
v=levels_array(i,:);
axes('position',[posx(i) posy(i) xSize_sub ySize_sub])
[C,h] = contourf(xi,yi,heat_budg_th(:,:,i)');
title(title_array(i,:));
colorbar
colormap(b2r(maxmin(i,1),maxmin(i,2)));
freezeColors
cbfreeze(colorbar);
end

print('-dpdf','heat_snapshot_th.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

for i=1:5
v=levels_array(i,:);
axes('position',[posx(i) posy(i) xSize_sub ySize_sub])
[C,h] = contourf(xi,yi,heat_budg_w(:,:,i)');
title(title_array(i,:));
colorbar
colormap(b2r(maxmin(i,1),maxmin(i,2)));
freezeColors
cbfreeze(colorbar);
end

print('-dpdf','heat_snapshot_w.pdf')


return


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

posx = [0.1,0.55,0.1,0.55,0.1,0.55];
posy = [2/3+0.05,2/3+0.05,1/3+0.05,1/3+0.05,0.05,0.05];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%RADHT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for j=1:5

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

for i= 1:5  
axes('position',[posx(i) posy(i) xSize_sub ySize_sub])

v=-6:0.5:2;
[C,h] = contourf(xi,yi,radht_c_ll(:,:,i + (j-1)*5 )',v);
colorbar;
colormap(b2r(-6,2));
freezeColors
cbfreeze(colorbar);

end
name = ['radht.ps']
 print('-dpsc',name,'-append')
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%CNDHT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for j=1:5

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

for i= 1:5  
axes('position',[posx(i) posy(i) xSize_sub ySize_sub])

v=0:2:20;
[C,h] = contourf(xi,yi,cndht_c_ll(:,:,i + (j-1)*5 )',v);
colorbar;
colormap(b2r(0,20));
freezeColors
cbfreeze(colorbar);

end
name = ['cndht.ps']
 print('-dpsc',name,'-append')
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%CNVHT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for j=1:5

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

for i= 1:5  
axes('position',[posx(i) posy(i) xSize_sub ySize_sub])

v=-10:1:10;
[C,h] = contourf(xi,yi,cnvht_c_ll(:,:,i + (j-1)*5 )',v);
colorbar;
colormap(b2r(-10,10));
freezeColors
cbfreeze(colorbar);

end
name = ['cnvht.ps']
 print('-dpsc',name,'-append')
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%DIFHT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for j=1:5

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

for i= 1:5  
axes('position',[posx(i) posy(i) xSize_sub ySize_sub])

v=-10:1:10;
[C,h] = contourf(xi,yi,difht_c_ll(:,:,i + (j-1)*5 )',v);
colorbar;
colormap(b2r(-10,10));
freezeColors
cbfreeze(colorbar);

end
name = ['difht.ps']
 print('-dpsc',name,'-append')
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%DIFHT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for j=1:5

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

for i= 1:5  
axes('position',[posx(i) posy(i) xSize_sub ySize_sub])

v=-10:1:20;
[C,h] = contourf(xi,yi,htrt_c_ll(:,:,i + (j-1)*5 )',v);
colorbar;
colormap(b2r(-10,20));
freezeColors
cbfreeze(colorbar);

end
name = ['htrt.ps']
 print('-dpsc',name,'-append')
end
