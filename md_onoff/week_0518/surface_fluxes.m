

% choose directory, load grid
rDir='/project/MITgcm/MITgcm_150518/verification/atm_gray_ruth/run/';
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
xi=-179:2:180;yi=-89:2:90;



rDir='/project/rg312/wv_on_rad_off/run_000_best/';
nit = 172800;
[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhSens'));
sens_000 = surf(:,:,J);
sens_000_ll = cube2latlon(xc,yc,sens_000,xi,yi);
J=find(strcmp(fldList,'AtPhEvap'));
evap_000 = surf(:,:,J)*2.5e6;;
evap_000_ll = cube2latlon(xc,yc,evap_000,xi,yi);



rDir='/project/rg312/wv_on_rad_off/run_100_best/';
[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhSens'));
sens_100 = surf(:,:,J);
sens_100_ll = cube2latlon(xc,yc,sens_100,xi,yi);
J=find(strcmp(fldList,'AtPhEvap'));
evap_100 = surf(:,:,J)*2.5e6;;
evap_100_ll = cube2latlon(xc,yc,evap_100,xi,yi);



load('/project/rg312/mat_files/front_diag_full_000_best.mat')
front_diag_000 = arnaud_diag_000(:,:,360); 
clear('arnaud_diag_000');

load('/project/rg312/mat_files/front_diag_full_100_best.mat')
front_diag_100 = arnaud_diag_100(:,:,360); 
clear('arnaud_diag_100');


figure
v=-175:25:175;
[C,h] = contourf(xi,yi,sens_000_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_000',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
colormap(b2r(-175,175));
xlim([-180 180])
ylim([0 90])
colorbar('FontSize',15)
ylabel('Latitude')
xlabel('Longitude')
title('Surface sensible heat flux, W/m^2')
print('-dpng','sens_000.png')



figure
v=-175:25:175;
[C,h] = contourf(xi,yi,sens_100_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_100',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
colormap(b2r(-175,175));
xlim([-180 180])
ylim([0 90])
colorbar('FontSize',15)
ylabel('Latitude')
xlabel('Longitude')
title('Surface sensible heat flux, W/m^2')
print('-dpng','sens_100.png')



figure
v=-50:25:400;
[C,h] = contourf(xi,yi,evap_000_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_000',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
colormap(b2r(-50,400));
xlim([-180 180])
ylim([0 90])
colorbar('FontSize',15)
ylabel('Latitude')
xlabel('Longitude')
title('Surface evaporation, W/m^2')
print('-dpng','evap_000.png')



figure
v=-50:25:400;
[C,h] = contourf(xi,yi,evap_100_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_100',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
colormap(b2r(-50,400));
xlim([-180 180])
ylim([0 90])
colorbar('FontSize',15)
ylabel('Latitude')
xlabel('Longitude')
title('Surface evaporation, W/m^2')
print('-dpng','evap_100.png')





