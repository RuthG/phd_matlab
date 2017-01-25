%produce tidy version of the heat budget terms

%calculate advective heat transport terms carefully on the lat-lon grid


% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_doshallower10/';
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

radius = 6371.0e3;

%load heat rates

load('/project/rg312/mat_files/heat_rates.mat','htrt_075','radht_075','difht_075','cndht_075','cnvht_075')
htrt_075_ll = cube2latlon(xc,yc,htrt_075(:,:,:,360),xi,yi).*86400;
htrt_075_ll_tav = cube2latlon(xc,yc,mean(htrt_075,4),xi,yi).*86400;
htrt_ed_075_ll = htrt_075_ll - htrt_075_ll_tav;
radht_075_ll = cube2latlon(xc,yc,radht_075(:,:,:,360),xi,yi).*86400;
radht_075_ll_tav = cube2latlon(xc,yc,mean(radht_075,4),xi,yi).*86400;
radht_ed_075_ll = radht_075_ll - radht_075_ll_tav;
difht_075_ll = cube2latlon(xc,yc,difht_075(:,:,:,360),xi,yi).*86400;
difht_075_ll_tav = cube2latlon(xc,yc,mean(difht_075,4),xi,yi).*86400;
difht_ed_075_ll = difht_075_ll - difht_075_ll_tav;
cndht_075_ll = cube2latlon(xc,yc,cndht_075(:,:,:,360),xi,yi).*86400;
cndht_075_ll_tav = cube2latlon(xc,yc,mean(cndht_075,4),xi,yi).*86400;
cndht_ed_075_ll = cndht_075_ll - cndht_075_ll_tav;
cnvht_075_ll = cube2latlon(xc,yc,cnvht_075(:,:,:,360),xi,yi).*86400;
cnvht_075_ll_tav = cube2latlon(xc,yc,mean(cnvht_075,4),xi,yi).*86400;
cnvht_ed_075_ll = cnvht_075_ll - cnvht_075_ll_tav;


clear('htrt_075','radht_075','difht_075','cndht_075','cnvht_075')


load('/project/rg312/mat_files/front_diag.mat')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('Total Diabatic Heating, eddy part, K/day, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrt_ed_075.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,radht_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('Radiative Heating, eddy part, K/day, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','radht_ed_075.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,difht_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('Diffusive Heating, eddy part, K/day, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','difht_ed_075.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cndht_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('Large Scale Heating, eddy part, K/day, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cndht_ed_075.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cnvht_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('Convective Heating, eddy part, K/day, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cnvht_ed_075.png')
