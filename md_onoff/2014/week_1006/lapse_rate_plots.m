%load in theta and t for vw, np, original runs and plot cross sections at equator and in midlats to gauge effect of heating


rDir='/project/rg312/run_radon_varyingwin/';
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

xi=-179:2:180;yi=-89:2:90;

%read files

niti = 62640;
nits = 240;
nitt = 86400;

var(1,:) = 'THETA   ';
varv = zeros(size(var));

rDir = '/project/rg312/run_radon_varyingwin/';
theta_vw = mit_zavs(rDir,var,niti,86400,240,'varv',varv);

rDir = '/project/rg312/run_radon_cwnp/';
theta_np = mit_zavs(rDir,var,niti,86400,240,'varv',varv);

rDir='/project/rg312/run_radon_doshallower/';
theta_orig = mit_zavs(rDir,var,432000,'varv',varv);

rDir='/project/rg312/wv_on_rad_off/run_doshallower_5yearh/';
theta_h = mit_zavs(rDir,var,432000,'varv',varv);


convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
  t_vw(:,k)=theta_vw(:,k).*convthetatoT(k,1);
  t_np(:,k)=theta_np(:,k).*convthetatoT(k,1);
  t_orig(:,k)=theta_orig(:,k).*convthetatoT(k,1);
  t_h(:,k)=theta_h(:,k).*convthetatoT(k,1);
end









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
plot(theta_orig(46,:),rC,'k')
hold on
plot(theta_np(46,:),rC,'b')
plot(theta_vw(46,:),rC,'r')
set(gca,'YDir','reverse')
title('Theta, eq')
ylabel('Pressure, Pa')
xlabel('Potential Temperature, K')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(t_orig(46,:),rC,'k')
hold on
plot(t_np(46,:),rC,'b')
plot(t_vw(46,:),rC,'r')
set(gca,'YDir','reverse')
title('T, eq')
ylabel('Pressure, Pa')
xlabel('Temperature, K')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(theta_orig(68,:),rC,'k')
hold on
plot(theta_np(68,:),rC,'b')
plot(theta_vw(68,:),rC,'r')
set(gca,'YDir','reverse')
title('Theta, 45N')
ylabel('Pressure, Pa')
xlabel('Potential Temperature, K')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(t_orig(68,:),rC,'k')
hold on
plot(t_np(68,:),rC,'b')
plot(t_vw(68,:),rC,'r')
set(gca,'YDir','reverse')
title('T, 45N')
ylabel('Pressure, Pa')
xlabel('Temperature, K')

print('-dpdf','temperature_structure.pdf')
