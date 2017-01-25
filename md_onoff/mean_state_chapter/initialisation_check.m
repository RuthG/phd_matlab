
% choose directory, load grid
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
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
yi = -89:2:89;
xi = -179:2:179;

nit = 0;
u=rdmds([rDir,'U'],nit);
v=rdmds([rDir,'V'],nit);
theta=rdmds([rDir,'T'],nit);
q=rdmds([rDir,'S'],nit);
w=rdmds([rDir,'W'],nit);

[uE,vN] = rotate_uv2uvEN(u,v,AngleCS,AngleSN,Grid);

theta_ll = cube2latlon(xc,yc,theta,xi,yi);
q_ll = cube2latlon(xc,yc,q,xi,yi);
w_ll = cube2latlon(xc,yc,w,xi,yi);
uE_ll = cube2latlon(xc,yc,uE,xi,yi);
vN_ll = cube2latlon(xc,yc,vN,xi,yi);


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
pos3x = 0.1; 	pos3y = 0.05;
pos4x = 0.55; 	pos4y = 0.05;


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v = 200:10:600;
[C,h] = contour(yi,rC./100,squeeze(mean(theta_ll,1))',v,'k');
set(gca,'FontSize',10);
label = 200:20:300;
clabel(C,h,'FontSize',10);
xlim([-90 90])
set(gca,'YDir','reverse')
ylabel('Pressure, hPa','FontSize',12);
xlabel('Latitude','FontSize',12);

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v= 0:2:20;
[C,h] = contour(yi,rC./100,squeeze(mean(q_ll,1))'.*1000,v,'k');
set(gca,'FontSize',10);
label = 0:4:20;
clabel(C,h,'FontSize',10);
xlim([-90 90])
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',12);

print('-dpdf','qt_init.pdf')

