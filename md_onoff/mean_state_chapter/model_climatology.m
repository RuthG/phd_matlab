%load up fields used in APE Atlas, plus momentum budget, and make nice plots for thesis


rDir='/project/rg312/final_runs/run_100_final/';
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

g=9.8;
cp = 1004.64;
L=2.5e6;
Ra=287.04;
Rv=461.50;
epsilon = Ra/Rv;
T0 = 273.16;

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_100.mat')
q_ll=cube2latlon(xc,yc,q_tav,xi,yi);
q_zav(:,:) = mean(q_ll,1).*1000;
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav(:,:) = mean(theta_ll,1);
uE_ll=cube2latlon(xc,yc,uE_tav,xi,yi);
uE_zav(:,:) = mean(uE_ll,1);
vN_ll=cube2latlon(xc,yc,vN_tav,xi,yi);
vN_zav(:,:) = mean(vN_ll,1);
w_ll=cube2latlon(xc,yc,w_tav,xi,yi);
w_zav(:,:) = mean(w_ll,1);


for i=1:90
theta_hzav(i,:) = (theta_zav(i,:) + theta_zav(91-i,:))./2;
q_hzav(i,:) = (q_zav(i,:) + q_zav(91-i,:))./2;
uE_hzav(i,:) = (uE_zav(i,:) + uE_zav(91-i,:))./2;
vN_hzav(i,:) = (vN_zav(i,:) - vN_zav(91-i,:))./2;
w_hzav(i,:) = (w_zav(i,:) + w_zav(91-i,:))./2;
end

convthetatoT=(rC/100000.0).^(2./7.);
for j=1:size(rC)
t_hzav(:,j)=theta_hzav(:,j).*convthetatoT(j,1);
end

es = 1.*610.78.*exp((L./Rv).*(1./T0 - 1./t_hzav));

for i=1:25
qs(:,i) = epsilon.*es(:,i)./(rC(i)-es(:,i)); 
end

RH = q_hzav./qs./1000;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 21;                  %# A4 paper size
X = 29.7;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 0*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.25; 
xSize_sub = 0.2; 

pos1x = 0.07 ; 	pos1y = 0.60; 
pos2x = 0.37 ; 	pos2y = 0.60; 
pos3x = 0.67 ; 	pos3y = 0.60; 
pos4x = 0.07 ; 	pos4y = 0.25; 
pos5x = 0.37 ; 	pos5y = 0.25; 
pos6x = 0.67 ; 	pos6y = 0.25; 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-20:5:45;
[C,h] = contourf(yi,rC./100,uE_hzav',v); 
set(gca,'YDir','reverse','FontSize',10,'XTick',-80:20:80)
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
x = get(c,'Position');
x(1) = 0.28; x(2) = 0.6; x(3) = 0.015; x(4) = 0.25;
set(c,'Position',x);
set(gca, 'Position', originalSize);
colormap(b2r(-20,45));
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
title('u (m/s)','FontSize',12)
xlim([-87 87])
freezeColors
cbfreeze

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v = 200:10:300;
[C,h] = contourf(yi,rC./100,t_hzav',v,'k');
%clabel(C,h,'FontSize',10)
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
x = get(c,'Position');
x(1) = 0.58; x(2) = 0.6; x(3) = 0.015; x(4) = 0.25;
set(c,'Position',x);
caxis([200 300]);
set(gca, 'Position', originalSize);
colormap(jet);
%xlim([-90 90])
set(gca,'YDir','reverse','FontSize',10,'XTick',-80:20:80)
title('T (K)','FontSize',12)
xlim([-87 87])
freezeColors
cbfreeze

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-6:0.5:6;
[C,h] = contourf(yi,rC./100,vN_hzav',v); 
set(gca,'YDir','reverse','FontSize',10)
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
x = get(c,'Position');
x(1) = 0.88; x(2) = 0.6; x(3) = 0.015; x(4) = 0.25;
set(c,'Position',x);set(gca, 'Position', originalSize);
colormap(b2r(-6,6));
set(gca,'YDir','reverse','FontSize',10,'XTick',-80:20:80)
title('v (m/s)','FontSize',12)
xlim([-87 87])
freezeColors
cbfreeze

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-85:5:30;
[C,h] = contourf(yi,rC./100,w_hzav'./100.*86400,v); 
set(gca,'YDir','reverse','FontSize',10)
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
x = get(c,'Position');
x(1) = 0.28; x(2) = 0.25; x(3) = 0.015; x(4) = 0.25;
set(c,'Position',x);
set(gca, 'Position', originalSize);
colormap(b2r(-85,30));
set(gca,'YDir','reverse','FontSize',10,'XTick',-80:20:80)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
title('\omega (hPa/day)','FontSize',12)
xlim([-87 87])
freezeColors
cbfreeze

axes('position',[pos5x pos5y xSize_sub ySize_sub])
v= 0:2:20;
[C,h] = contourf(yi,rC./100,q_hzav',v,'k');
%clabel(C,h,'FontSize',10)
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
x = get(c,'Position');
x(1) = 0.58; x(2) = 0.25; x(3) = 0.015; x(4) = 0.25;
set(c,'Position',x);
caxis([0 20])
set(gca, 'Position', originalSize);
colormap(jet);
set(gca,'YDir','reverse','FontSize',10,'XTick',-80:20:80)
xlabel('Latitude','FontSize',12)
title('q (g/kg)','FontSize',12)
xlim([-87 87])
freezeColors
cbfreeze

axes('position',[pos6x pos6y xSize_sub ySize_sub])
v=0:0.1:1.5;
[C,h] = contourf(yi,rC./100,RH',v,'k');
%clabel(C,h,'FontSize',10)
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
x = get(c,'Position');
x(1) = 0.88; x(2) = 0.25; x(3) = 0.015; x(4) = 0.25;
set(c,'Position',x);
caxis([0 1])
set(gca, 'Position', originalSize);
colormap(jet);
set(gca,'YDir','reverse','FontSize',10,'XTick',-80:20:80)
title('Relative humidity','FontSize',12)
xlabel('Latitude','FontSize',12)
xlim([-87 87])
freezeColors
cbfreeze

print('-dpdf','model_climatology.pdf')

