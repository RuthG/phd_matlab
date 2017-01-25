rDir='/project/rg312/final_runs/run_000_final_noshallow/';
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

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050_tropheat.mat','theta_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav(:,:) = mean(theta_ll,1);
load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050_tropheat.mat','uE_tav')
uE_ll=cube2latlon(xc,yc,uE_tav,xi,yi);
uE_zav(:,:) = mean(uE_ll,1);

load('/project/rg312/mat_files/chapter2_variables/psi_tav_th.mat', 'psi_th_hzav')


load('/project/rg312/mat_files/chapter2_variables/psi_theta_th.mat', 'psi_mean')

for i=1:45
psi_hzav(i,:) = (-psi_mean(i+45,:) + psi_mean(46-i,:))./2;
theta_hzav(i,:) = (theta_zav(i+45,:) + theta_zav(46-i,:))./2;
uE_hzav(i,:) = (uE_zav(i+45,:) + uE_zav(46-i,:))./2;

end

layers=100;
mintheta = 265;
maxtheta=400.;
spacing=single((maxtheta-mintheta)/layers);
theta_layers=mintheta+spacing*(0:layers-1)+spacing/2.;	%centre of theta layers



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 0*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.225; %0.4;
xSize_sub = 0.375;

pos1x = 0.1 ; 	pos1y = 0.7; 
pos2x = 0.55;	pos2y = 0.7; 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=260:10:700;
[C,h] = contour(yi(46:90),rC./100,theta_hzav',v,'k');
clabel(C,h,'FontSize',10)
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
print('-dpdf','theta_th.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=(0.5e11:0.5e11:2.5e11)./1e9;
[C,h] = contour(yi(46:90),theta_layers,psi_hzav'./1e9,v,'k');
clabel(C,h,'FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
print('-dpdf','psi_theta_th.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

v=-20:5:45;
v_psi = [-40:10:0,30:30:180];

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,uE_hzav',v); set(h,'LineStyle','none');
set(gca,'YDir','reverse','FontSize',10)
hold on
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
x = get(c,'Position');
x(1) = 0.5; x(2) = 0.7; x(3) = 0.015; x(4) = 0.225;
set(c,'Position',x);
set(gca, 'Position', originalSize);
colormap(b2r(-20,45));
[C,h] = contour(yi(46:90),rC./100,uE_hzav',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(yi(46:90),rC./100,psi_th_hzav'./1e9,v_psi,'k');
clabel(C,h);
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
freezeColors
print('-dpdf','upsi_th.pdf')


return


