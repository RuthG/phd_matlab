%plot up convection flag for each run 


% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_000_best/';
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
xi=-179:2:179;

nit = 172800;

rDir='/project/rg312/wv_on_rad_off/run_000_best/';
[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhConv'));
conv_000 = surf(:,:,J);
conv_000_ll = cube2latlon(xc,yc,conv_000,xi,yi);
J=find(strcmp(fldList,'AtPhKlzb'));
klzb_000 = surf(:,:,J);
klzb_000_ll = cube2latlon(xc,yc,klzb_000,xi,yi);

rDir='/project/rg312/wv_on_rad_off/run_010_best/';
[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhConv'));
conv_010 = surf(:,:,J);
conv_010_ll = cube2latlon(xc,yc,conv_010,xi,yi);
J=find(strcmp(fldList,'AtPhKlzb'));
klzb_010 = surf(:,:,J);
klzb_010_ll = cube2latlon(xc,yc,klzb_010,xi,yi);

rDir='/project/rg312/wv_on_rad_off/run_025_best/';
[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhConv'));
conv_025 = surf(:,:,J);
conv_025_ll = cube2latlon(xc,yc,conv_025,xi,yi);
J=find(strcmp(fldList,'AtPhKlzb'));
klzb_025 = surf(:,:,J);
klzb_025_ll = cube2latlon(xc,yc,klzb_025,xi,yi);

rDir='/project/rg312/wv_on_rad_off/run_050_best/';
[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhConv'));
conv_050 = surf(:,:,J);
conv_050_ll = cube2latlon(xc,yc,conv_050,xi,yi);
J=find(strcmp(fldList,'AtPhKlzb'));
klzb_050 = surf(:,:,J);
klzb_050_ll = cube2latlon(xc,yc,klzb_050,xi,yi);

rDir='/project/rg312/wv_on_rad_off/run_075_best/';
[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhConv'));
conv_075 = surf(:,:,J);
conv_075_ll = cube2latlon(xc,yc,conv_075,xi,yi);
J=find(strcmp(fldList,'AtPhKlzb'));
klzb_075 = surf(:,:,J);
klzb_075_ll = cube2latlon(xc,yc,klzb_075,xi,yi);

rDir='/project/rg312/wv_on_rad_off/run_100_best/';
[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhConv'));
conv_100 = surf(:,:,J);
conv_100_ll = cube2latlon(xc,yc,conv_100,xi,yi);
J=find(strcmp(fldList,'AtPhKlzb'));
klzb_100 = surf(:,:,J);
klzb_100_ll = cube2latlon(xc,yc,klzb_100,xi,yi);



load('/project/rg312/mat_files/front_diag_full_000_best.mat')
front_diag_000 = arnaud_diag_000(:,:,360); 
clear('arnaud_diag_000');

load('/project/rg312/mat_files/front_diag_full_010_best.mat')
front_diag_010 = arnaud_diag_010(:,:,360); 
clear('arnaud_diag_010');

load('/project/rg312/mat_files/front_diag_full_025_best.mat')
front_diag_025 = arnaud_diag_025(:,:,360); 
clear('arnaud_diag_025');

load('/project/rg312/mat_files/front_diag_full_050_best.mat')
front_diag_050 = arnaud_diag_050(:,:,360); 
clear('arnaud_diag_050');

load('/project/rg312/mat_files/front_diag_full_075_best.mat')
front_diag_075 = arnaud_diag_075(:,:,360); 
clear('arnaud_diag_075');

load('/project/rg312/mat_files/front_diag_full_100_best.mat')
front_diag_100 = arnaud_diag_100(:,:,360); 
clear('arnaud_diag_100');


figure
v=0:0.5:2;
[C,h] = contourf(xi,yi,conv_000_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_000',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
caxis([0 2])
xlim([-180 180])
ylim([0 90])
colorbar('FontSize',15)
ylabel('Latitude')
xlabel('Longitude')
title('Convection flag, daily mean')
print('-dpng','conv_000.png')


figure
v=0:1:25;
[C,h] = contourf(xi,yi,klzb_000_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_000',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
caxis([0 25])
xlim([-180 180])
ylim([0 90])
colorbar('FontSize',15)
ylabel('Latitude')
xlabel('Longitude')
title('LZB index')
print('-dpng','klzb_000.png')



figure
v=0:0.5:2;
[C,h] = contourf(xi,yi,conv_010_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_010',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
caxis([0 2])
xlim([-180 180])
ylim([0 90])
colorbar('FontSize',15)
ylabel('Latitude')
xlabel('Longitude')
title('Convection flag, daily mean')
print('-dpng','conv_010.png')


figure
v=0:1:25;
[C,h] = contourf(xi,yi,klzb_010_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_010',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
caxis([0 25])
xlim([-180 180])
ylim([0 90])
colorbar('FontSize',15)
ylabel('Latitude')
xlabel('Longitude')
title('LZB index')
print('-dpng','klzb_010.png')




figure
v=0:0.5:2;
[C,h] = contourf(xi,yi,conv_025_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_025',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
caxis([0 2])
xlim([-180 180])
ylim([0 90])
colorbar('FontSize',15)
ylabel('Latitude')
xlabel('Longitude')
title('Convection flag, daily mean')
print('-dpng','conv_025.png')


figure
v=0:1:25;
[C,h] = contourf(xi,yi,klzb_025_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_025',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
caxis([0 25])
xlim([-180 180])
ylim([0 90])
colorbar('FontSize',15)
ylabel('Latitude')
xlabel('Longitude')
title('LZB index')
print('-dpng','klzb_025.png')





figure
v=0:0.5:2;
[C,h] = contourf(xi,yi,conv_050_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_050',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
caxis([0 2])
xlim([-180 180])
ylim([0 90])
colorbar('FontSize',15)
ylabel('Latitude')
xlabel('Longitude')
title('Convection flag, daily mean')
print('-dpng','conv_050.png')


figure
v=0:1:25;
[C,h] = contourf(xi,yi,klzb_050_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_050',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
caxis([0 25])
xlim([-180 180])
ylim([0 90])
colorbar('FontSize',15)
ylabel('Latitude')
xlabel('Longitude')
title('LZB index')
print('-dpng','klzb_050.png')





figure
v=0:0.5:2;
[C,h] = contourf(xi,yi,conv_075_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_075',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
caxis([0 2])
xlim([-180 180])
ylim([0 90])
colorbar('FontSize',15)
ylabel('Latitude')
xlabel('Longitude')
title('Convection flag, daily mean')
print('-dpng','conv_075.png')


figure
v=0:1:25;
[C,h] = contourf(xi,yi,klzb_075_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_075',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
caxis([0 25])
xlim([-180 180])
ylim([0 90])
colorbar('FontSize',15)
ylabel('Latitude')
xlabel('Longitude')
title('LZB index')
print('-dpng','klzb_075.png')





figure
v=0:0.5:2;
[C,h] = contourf(xi,yi,conv_100_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_100',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
caxis([0 2])
xlim([-180 180])
ylim([0 90])
colorbar('FontSize',15)
ylabel('Latitude')
xlabel('Longitude')
title('Convection flag, daily mean')
print('-dpng','conv_100.png')


figure
v=0:1:25;
[C,h] = contourf(xi,yi,klzb_100_ll',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1;
[C,h] = contour(xi,yi,front_diag_100',v,'Color',[0.6,0.6,0.6],'LineWidth',2);
caxis([0 25])
xlim([-180 180])
ylim([0 90])
colorbar('FontSize',15)
ylabel('Latitude')
xlabel('Longitude')
title('LZB index')
print('-dpng','klzb_100.png')





