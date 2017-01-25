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

load('/project/rg312/mat_files/heat_rates.mat','htrt_100','radht_100','difht_100','cndht_100','cnvht_100')
htrt_100_ll = cube2latlon(xc,yc,htrt_100(:,:,:,360),xi,yi).*86400;
htrt_100_ll_tav = cube2latlon(xc,yc,mean(htrt_100,4),xi,yi).*86400;
htrt_ed_100_ll = htrt_100_ll - htrt_100_ll_tav;
radht_100_ll = cube2latlon(xc,yc,radht_100(:,:,:,360),xi,yi).*86400;
radht_100_ll_tav = cube2latlon(xc,yc,mean(radht_100,4),xi,yi).*86400;
radht_ed_100_ll = radht_100_ll - radht_100_ll_tav;
difht_100_ll = cube2latlon(xc,yc,difht_100(:,:,:,360),xi,yi).*86400;
difht_100_ll_tav = cube2latlon(xc,yc,mean(difht_100,4),xi,yi).*86400;
difht_ed_100_ll = difht_100_ll - difht_100_ll_tav;
cndht_100_ll = cube2latlon(xc,yc,cndht_100(:,:,:,360),xi,yi).*86400;
cndht_100_ll_tav = cube2latlon(xc,yc,mean(cndht_100,4),xi,yi).*86400;
cndht_ed_100_ll = cndht_100_ll - cndht_100_ll_tav;
cnvht_100_ll = cube2latlon(xc,yc,cnvht_100(:,:,:,360),xi,yi).*86400;
cnvht_100_ll_tav = cube2latlon(xc,yc,mean(cnvht_100,4),xi,yi).*86400;
cnvht_ed_100_ll = cnvht_100_ll - cnvht_100_ll_tav;


clear('htrt_100','radht_100','difht_100','cndht_100','cnvht_100')


load('/project/rg312/mat_files/front_diag.mat')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('Total Diabatic Heating, eddy part, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrt_ed_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,radht_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('Radiative Heating, eddy part, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','radht_ed_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,difht_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('Diffusive Heating, eddy part, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','difht_ed_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cndht_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('Large Scale Heating, eddy part, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cndht_ed_100.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cnvht_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
xlim([-90 90])
ylim([0 90])
colorbar
title('Convective Heating, eddy part, K/day, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cnvht_ed_100.png')
