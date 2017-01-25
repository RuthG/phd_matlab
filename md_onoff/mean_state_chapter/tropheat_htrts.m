
rDir='/project/rg312/final_runs/run_050_final_tropheat/';
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
xi=-179:2:179;
yi=-89:2:89;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_050_tropheat.mat')
htrt_ll=cube2latlon(xc,yc,htrt_tav,xi,yi);
htrt_zav(:,:) = mean(htrt_ll,1).*86400;
cnvht_ll=cube2latlon(xc,yc,cnvht_tav,xi,yi);
cnvht_zav(:,:) = mean(cnvht_ll,1).*86400;
cndht_ll=cube2latlon(xc,yc,cndht_tav,xi,yi);
cndht_zav(:,:) = mean(cndht_ll,1).*86400;
difht_ll=cube2latlon(xc,yc,difht_tav,xi,yi);
difht_zav(:,:) = mean(difht_ll,1).*86400;
radht_tav = htrt_tav-cnvht_tav-cndht_tav-difht_tav;
radht_ll=cube2latlon(xc,yc,radht_tav,xi,yi);
radht_zav(:,:) = mean(radht_ll,1).*86400;

for i=1:45
htrt_hzav(i,:) = (htrt_zav(i+45,:) + htrt_zav(46-i,:))./2;
cnvht_hzav(i,:) = (cnvht_zav(i+45,:) + cnvht_zav(46-i,:))./2;
cndht_hzav(i,:) = (cndht_zav(i+45,:) + cndht_zav(46-i,:))./2;
radht_hzav(i,:) = (radht_zav(i+45,:) + radht_zav(46-i,:))./2;
difht_hzav(i,:) = (difht_zav(i+45,:) + difht_zav(46-i,:))./2;
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 0*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.15; 
xSize_sub = 0.17; 

pos1x = 0.07 ; 	pos1y = 0.75; 
pos2x = 0.29 ; 	pos2y = 0.75; 
pos3x = 0.51 ; 	pos3y = 0.75; 
pos4x = 0.73 ; 	pos4y = 0.75; 
pos5x = 0.07 ; 	pos5y = 0.55; 
pos6x = 0.29 ; 	pos6y = 0.55; 
pos7x = 0.51 ; 	pos7y = 0.55; 
pos8x = 0.73 ; 	pos8y = 0.55; 


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

v=-4:0.5:8;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,htrt_hzav',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-4,8));
[C,h] = contour(yi(46:90),rC./100,htrt_hzav',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
title('Total diabatic heating rate K/day')
freezeColors

axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,radht_hzav',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-4,8));
[C,h] = contour(yi(46:90),rC./100,radht_hzav',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
title('Radiative heating rate, K/day')
freezeColors

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,difht_hzav',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-4,8));
[C,h] = contour(yi(46:90),rC./100,difht_hzav',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
title('Diffusive heating rate, K/day')
freezeColors

axes('position',[pos7x pos7y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,cnvht_hzav',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-4,8));
[C,h] = contour(yi(46:90),rC./100,cnvht_hzav',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
title('Convective heating rate, K/day')
freezeColors


axes('position',[pos8x pos8y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,cndht_hzav',v);
hold on
originalSize = get(gca, 'Position');
%colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-4,8));
[C,h] = contour(yi(46:90),rC./100,cndht_hzav',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
title('Large-scale condensation heating rate, K/day')
freezeColors

print('-dpdf','tropheat_htrts.pdf')