%load up diabatic heating and calculate eddy part


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

convtheta(1,1,:)=(rC/101325.0).^(2./7.);
convthetatoT=repmat(convtheta,[180,90,1]);

load('/project/rg312/mat_files/heat_rates.mat')
htrt_000_ll = cube2latlon(xc,yc,htrt_000(:,:,:,360),xi,yi).*86400.*convthetatoT;
htrt_010_ll = cube2latlon(xc,yc,htrt_010(:,:,:,360),xi,yi).*86400.*convthetatoT;
htrt_025_ll = cube2latlon(xc,yc,htrt_025(:,:,:,360),xi,yi).*86400.*convthetatoT;
htrt_050_ll = cube2latlon(xc,yc,htrt_050(:,:,:,360),xi,yi).*86400.*convthetatoT;
htrt_075_ll = cube2latlon(xc,yc,htrt_075(:,:,:,360),xi,yi).*86400.*convthetatoT;
htrt_100_ll = cube2latlon(xc,yc,htrt_100(:,:,:,360),xi,yi).*86400.*convthetatoT;

htrt_000_ll_tav = cube2latlon(xc,yc,mean(htrt_000,4),xi,yi).*86400.*convthetatoT;
htrt_010_ll_tav = cube2latlon(xc,yc,mean(htrt_010,4),xi,yi).*86400.*convthetatoT;
htrt_025_ll_tav = cube2latlon(xc,yc,mean(htrt_025,4),xi,yi).*86400.*convthetatoT;
htrt_050_ll_tav = cube2latlon(xc,yc,mean(htrt_050,4),xi,yi).*86400.*convthetatoT;
htrt_075_ll_tav = cube2latlon(xc,yc,mean(htrt_075,4),xi,yi).*86400.*convthetatoT;
htrt_100_ll_tav = cube2latlon(xc,yc,mean(htrt_100,4),xi,yi).*86400.*convthetatoT;

htrt_ed_000_ll = htrt_000_ll - htrt_000_ll_tav;
htrt_ed_010_ll = htrt_010_ll - htrt_010_ll_tav;
htrt_ed_025_ll = htrt_025_ll - htrt_025_ll_tav;
htrt_ed_050_ll = htrt_050_ll - htrt_050_ll_tav;
htrt_ed_075_ll = htrt_075_ll - htrt_075_ll_tav;
htrt_ed_100_ll = htrt_100_ll - htrt_100_ll_tav;

clear('htrt_000','htrt_010','htrt_025','htrt_050','htrt_075','htrt_100')

radht_000_ll = cube2latlon(xc,yc,radht_000(:,:,:,360),xi,yi).*86400.*convthetatoT;
radht_010_ll = cube2latlon(xc,yc,radht_010(:,:,:,360),xi,yi).*86400.*convthetatoT;
radht_025_ll = cube2latlon(xc,yc,radht_025(:,:,:,360),xi,yi).*86400.*convthetatoT;
radht_050_ll = cube2latlon(xc,yc,radht_050(:,:,:,360),xi,yi).*86400.*convthetatoT;
radht_075_ll = cube2latlon(xc,yc,radht_075(:,:,:,360),xi,yi).*86400.*convthetatoT;
radht_100_ll = cube2latlon(xc,yc,radht_100(:,:,:,360),xi,yi).*86400.*convthetatoT;

radht_000_ll_tav = cube2latlon(xc,yc,mean(radht_000,4),xi,yi).*86400.*convthetatoT;
radht_010_ll_tav = cube2latlon(xc,yc,mean(radht_010,4),xi,yi).*86400.*convthetatoT;
radht_025_ll_tav = cube2latlon(xc,yc,mean(radht_025,4),xi,yi).*86400.*convthetatoT;
radht_050_ll_tav = cube2latlon(xc,yc,mean(radht_050,4),xi,yi).*86400.*convthetatoT;
radht_075_ll_tav = cube2latlon(xc,yc,mean(radht_075,4),xi,yi).*86400.*convthetatoT;
radht_100_ll_tav = cube2latlon(xc,yc,mean(radht_100,4),xi,yi).*86400.*convthetatoT;

radht_ed_000_ll = radht_000_ll - radht_000_ll_tav;
radht_ed_010_ll = radht_010_ll - radht_010_ll_tav;
radht_ed_025_ll = radht_025_ll - radht_025_ll_tav;
radht_ed_050_ll = radht_050_ll - radht_050_ll_tav;
radht_ed_075_ll = radht_075_ll - radht_075_ll_tav;
radht_ed_100_ll = radht_100_ll - radht_100_ll_tav;

clear('radht_000','radht_010','radht_025','radht_050','radht_075','radht_100')


difht_000_ll = cube2latlon(xc,yc,difht_000(:,:,:,360),xi,yi).*86400.*convthetatoT;
difht_010_ll = cube2latlon(xc,yc,difht_010(:,:,:,360),xi,yi).*86400.*convthetatoT;
difht_025_ll = cube2latlon(xc,yc,difht_025(:,:,:,360),xi,yi).*86400.*convthetatoT;
difht_050_ll = cube2latlon(xc,yc,difht_050(:,:,:,360),xi,yi).*86400.*convthetatoT;
difht_075_ll = cube2latlon(xc,yc,difht_075(:,:,:,360),xi,yi).*86400.*convthetatoT;
difht_100_ll = cube2latlon(xc,yc,difht_100(:,:,:,360),xi,yi).*86400.*convthetatoT;

difht_000_ll_tav = cube2latlon(xc,yc,mean(difht_000,4),xi,yi).*86400.*convthetatoT;
difht_010_ll_tav = cube2latlon(xc,yc,mean(difht_010,4),xi,yi).*86400.*convthetatoT;
difht_025_ll_tav = cube2latlon(xc,yc,mean(difht_025,4),xi,yi).*86400.*convthetatoT;
difht_050_ll_tav = cube2latlon(xc,yc,mean(difht_050,4),xi,yi).*86400.*convthetatoT;
difht_075_ll_tav = cube2latlon(xc,yc,mean(difht_075,4),xi,yi).*86400.*convthetatoT;
difht_100_ll_tav = cube2latlon(xc,yc,mean(difht_100,4),xi,yi).*86400.*convthetatoT;

difht_ed_000_ll = difht_000_ll - difht_000_ll_tav;
difht_ed_010_ll = difht_010_ll - difht_010_ll_tav;
difht_ed_025_ll = difht_025_ll - difht_025_ll_tav;
difht_ed_050_ll = difht_050_ll - difht_050_ll_tav;
difht_ed_075_ll = difht_075_ll - difht_075_ll_tav;
difht_ed_100_ll = difht_100_ll - difht_100_ll_tav;

clear('difht_000','difht_010','difht_025','difht_050','difht_075','difht_100')

cnvht_000_ll = cube2latlon(xc,yc,cnvht_000(:,:,:,360),xi,yi).*86400.*convthetatoT;
cnvht_010_ll = cube2latlon(xc,yc,cnvht_010(:,:,:,360),xi,yi).*86400.*convthetatoT;
cnvht_025_ll = cube2latlon(xc,yc,cnvht_025(:,:,:,360),xi,yi).*86400.*convthetatoT;
cnvht_050_ll = cube2latlon(xc,yc,cnvht_050(:,:,:,360),xi,yi).*86400.*convthetatoT;
cnvht_075_ll = cube2latlon(xc,yc,cnvht_075(:,:,:,360),xi,yi).*86400.*convthetatoT;
cnvht_100_ll = cube2latlon(xc,yc,cnvht_100(:,:,:,360),xi,yi).*86400.*convthetatoT;

cnvht_000_ll_tav = cube2latlon(xc,yc,mean(cnvht_000,4),xi,yi).*86400.*convthetatoT;
cnvht_010_ll_tav = cube2latlon(xc,yc,mean(cnvht_010,4),xi,yi).*86400.*convthetatoT;
cnvht_025_ll_tav = cube2latlon(xc,yc,mean(cnvht_025,4),xi,yi).*86400.*convthetatoT;
cnvht_050_ll_tav = cube2latlon(xc,yc,mean(cnvht_050,4),xi,yi).*86400.*convthetatoT;
cnvht_075_ll_tav = cube2latlon(xc,yc,mean(cnvht_075,4),xi,yi).*86400.*convthetatoT;
cnvht_100_ll_tav = cube2latlon(xc,yc,mean(cnvht_100,4),xi,yi).*86400.*convthetatoT;

cnvht_ed_000_ll = cnvht_000_ll - cnvht_000_ll_tav;
cnvht_ed_010_ll = cnvht_010_ll - cnvht_010_ll_tav;
cnvht_ed_025_ll = cnvht_025_ll - cnvht_025_ll_tav;
cnvht_ed_050_ll = cnvht_050_ll - cnvht_050_ll_tav;
cnvht_ed_075_ll = cnvht_075_ll - cnvht_075_ll_tav;
cnvht_ed_100_ll = cnvht_100_ll - cnvht_100_ll_tav;

clear('cnvht_000','cnvht_010','cnvht_025','cnvht_050','cnvht_075','cnvht_100')

cndht_000_ll = cube2latlon(xc,yc,cndht_000(:,:,:,360),xi,yi).*86400.*convthetatoT;
cndht_010_ll = cube2latlon(xc,yc,cndht_010(:,:,:,360),xi,yi).*86400.*convthetatoT;
cndht_025_ll = cube2latlon(xc,yc,cndht_025(:,:,:,360),xi,yi).*86400.*convthetatoT;
cndht_050_ll = cube2latlon(xc,yc,cndht_050(:,:,:,360),xi,yi).*86400.*convthetatoT;
cndht_075_ll = cube2latlon(xc,yc,cndht_075(:,:,:,360),xi,yi).*86400.*convthetatoT;
cndht_100_ll = cube2latlon(xc,yc,cndht_100(:,:,:,360),xi,yi).*86400.*convthetatoT;

cndht_000_ll_tav = cube2latlon(xc,yc,mean(cndht_000,4),xi,yi).*86400.*convthetatoT;
cndht_010_ll_tav = cube2latlon(xc,yc,mean(cndht_010,4),xi,yi).*86400.*convthetatoT;
cndht_025_ll_tav = cube2latlon(xc,yc,mean(cndht_025,4),xi,yi).*86400.*convthetatoT;
cndht_050_ll_tav = cube2latlon(xc,yc,mean(cndht_050,4),xi,yi).*86400.*convthetatoT;
cndht_075_ll_tav = cube2latlon(xc,yc,mean(cndht_075,4),xi,yi).*86400.*convthetatoT;
cndht_100_ll_tav = cube2latlon(xc,yc,mean(cndht_100,4),xi,yi).*86400.*convthetatoT;

cndht_ed_000_ll = cndht_000_ll - cndht_000_ll_tav;
cndht_ed_010_ll = cndht_010_ll - cndht_010_ll_tav;
cndht_ed_025_ll = cndht_025_ll - cndht_025_ll_tav;
cndht_ed_050_ll = cndht_050_ll - cndht_050_ll_tav;
cndht_ed_075_ll = cndht_075_ll - cndht_075_ll_tav;
cndht_ed_100_ll = cndht_100_ll - cndht_100_ll_tav;

clear('cndht_000','cndht_010','cndht_025','cndht_050','cndht_075','cndht_100')

save('/project/rg312/mat_files/eddy_diabatic_heating.mat')

load('/project/rg312/mat_files/front_diag.mat')


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Total Diabatic Heating, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrtfrontdiag_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,radht_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Total Radiative Heating, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','radhtfrontdiag_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,radht_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
xlim([-90 90]);
ylim([0 90]);
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Total Radiative Heating, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','radhtfrontdiag_000.png')


return


figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrtfrontdiag_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_010_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrtfrontdiag_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_025_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrtfrontdiag_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_050_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrtfrontdiag_050.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrtfrontdiag_075.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,htrt_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrtfrontdiag_100.png')



figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cnvht_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cnvhtfrontdiag_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cnvht_ed_010_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cnvhtfrontdiag_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cnvht_ed_025_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cnvhtfrontdiag_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cnvht_ed_050_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cnvhtfrontdiag_050.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cnvht_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cnvhtfrontdiag_075.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cnvht_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cnvhtfrontdiag_100.png')






figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cndht_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cndhtfrontdiag_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cndht_ed_010_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cndhtfrontdiag_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cndht_ed_025_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cndhtfrontdiag_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cndht_ed_050_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cndhtfrontdiag_050.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cndht_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cndhtfrontdiag_075.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,cndht_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cndhtfrontdiag_100.png')





figure
v=-15:1:15;
[C,h] = contourf(xi,yi,radht_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','radhtfrontdiag_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,radht_ed_010_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','radhtfrontdiag_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,radht_ed_025_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','radhtfrontdiag_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,radht_ed_050_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','radhtfrontdiag_050.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,radht_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','radhtfrontdiag_075.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,radht_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','radhtfrontdiag_100.png')




figure
v=-15:1:15;
[C,h] = contourf(xi,yi,difht_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','difhtfrontdiag_000.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,difht_ed_010_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','difhtfrontdiag_010.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,difht_ed_025_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','difhtfrontdiag_025.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,difht_ed_050_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','difhtfrontdiag_050.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,difht_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','difhtfrontdiag_075.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,difht_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-15 15]);
colorbar
title('Front diag, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','difhtfrontdiag_100.png')


