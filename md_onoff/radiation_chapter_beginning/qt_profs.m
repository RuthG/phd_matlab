%load in q and t data used to demonstrate parameterisations and plot

%radiation_mod.m
%load up modtran profiles and run through MITgcm radiation code translated into matlab
% choose directory, load grid
rDir='/project/rg312/final_runs/run_100_rad_on/';
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


load('/project/rg312/mat_files/radiation_chapter/uvwqt_tav_radon.mat','uE_tav','vN_tav','w_tav','q_tav','theta_tav')

    convthetatoT=(rC/100000.0).^(2./7.);
    for k=1:size(rC)
      t_tav(:,:,k)=theta_tav(:,:,k).*convthetatoT(k,1);
    end


q_ll=cube2latlon(xc,yc,q_tav,xi,yi);
%theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
t_ll=cube2latlon(xc,yc,t_tav,xi,yi);

q_zav(:,:) = mean(q_ll,1);
%theta_zav(:,:) = mean(theta_ll,1);
t_zav(:,:) = mean(t_ll,1);



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
v = 200:10:300;
[C,h] = contour(yi,rC./100,t_zav',v,'k');
set(gca,'FontSize',10);
label = 200:20:300;
clabel(C,h,'FontSize',10);
xlim([-90 90])
set(gca,'YDir','reverse')
ylabel('Pressure, hPa','FontSize',12);
xlabel('Latitude','FontSize',12);
%title('T profile, K')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v= 0:2:20;
[C,h] = contour(yi,rC./100,q_zav'.*1000,v,'k');
set(gca,'FontSize',10);
label = 0:4:20;
clabel(C,h,'FontSize',10);
xlim([-90 90])
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',12);
%title('q profile, g/kg')

print('-dpdf','qt_profs.pdf')


