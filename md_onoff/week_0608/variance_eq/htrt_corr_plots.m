
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
yi=-89:2:89;
xi = -179:2:179;

load('/project/rg312/mat_files/htrt_theta_corr.mat')

figure
v=-1:0.1:1;
[C,h] = contourf(yi,rC,corr_000',v);
set(gca,'YDir','reverse','FontSize',15);
colormap(b2r(-1,1));
colorbar('FontSize',15)
xlabel('Latitude','FontSize',15);
ylabel('Pressure, Pa','FontSize',15);
title('0.0 es0','FontSize',15);
print('-dpng','htrtt_corr_000.png')

figure
[C,h] = contourf(yi,rC,corr_010',v);
set(gca,'YDir','reverse','FontSize',15);
colormap(b2r(-1,1));
colorbar('FontSize',15)
xlabel('Latitude','FontSize',15);
ylabel('Pressure, Pa','FontSize',15);
title('0.1 es0','FontSize',15);
print('-dpng','htrtt_corr_010.png')

figure
[C,h] = contourf(yi,rC,corr_025',v);
set(gca,'YDir','reverse','FontSize',15);
colormap(b2r(-1,1));
colorbar('FontSize',15)
xlabel('Latitude','FontSize',15);
ylabel('Pressure, Pa','FontSize',15);
title('0.25 es0','FontSize',15);
print('-dpng','htrtt_corr_025.png')

figure
[C,h] = contourf(yi,rC,corr_050',v);
set(gca,'YDir','reverse','FontSize',15);
colormap(b2r(-1,1));
colorbar('FontSize',15)
xlabel('Latitude','FontSize',15);
ylabel('Pressure, Pa','FontSize',15);
title('0.5 es0','FontSize',15);
print('-dpng','htrtt_corr_050.png')

figure
[C,h] = contourf(yi,rC,corr_075',v);
set(gca,'YDir','reverse','FontSize',15);
colormap(b2r(-1,1));
colorbar('FontSize',15)
xlabel('Latitude','FontSize',15);
ylabel('Pressure, Pa','FontSize',15);
title('0.75 es0','FontSize',15);
print('-dpng','htrtt_corr_075.png')

figure
[C,h] = contourf(yi,rC,corr_100',v);
set(gca,'YDir','reverse','FontSize',15);
colormap(b2r(-1,1));
colorbar('FontSize',15)
xlabel('Latitude','FontSize',15);
ylabel('Pressure, Pa','FontSize',15);
title('1.0 es0','FontSize',15);
print('-dpng','htrtt_corr_100.png')





figure
v=0:0.5e-5:8e-5;
[C,h] = contourf(yi,rC,htrt_sd_000',v);
set(gca,'YDir','reverse','FontSize',15);
colorbar('FontSize',15)
caxis([0 8e-5])
xlabel('Latitude','FontSize',15);
ylabel('Pressure, Pa','FontSize',15);
title('0.0 es0','FontSize',15);
print('-dpng','htrt_sd_000.png')

figure
[C,h] = contourf(yi,rC,htrt_sd_010',v);
set(gca,'YDir','reverse','FontSize',15);
colorbar('FontSize',15)
caxis([0 8e-5])
xlabel('Latitude','FontSize',15);
ylabel('Pressure, Pa','FontSize',15);
title('0.1 es0','FontSize',15);
print('-dpng','htrt_sd_010.png')

figure
[C,h] = contourf(yi,rC,htrt_sd_025',v);
set(gca,'YDir','reverse','FontSize',15);
colorbar('FontSize',15)
caxis([0 8e-5])
xlabel('Latitude','FontSize',15);
ylabel('Pressure, Pa','FontSize',15);
title('0.25 es0','FontSize',15);
print('-dpng','htrt_sd_025.png')

figure
[C,h] = contourf(yi,rC,htrt_sd_050',v);
set(gca,'YDir','reverse','FontSize',15);
colorbar('FontSize',15)
caxis([0 8e-5])
xlabel('Latitude','FontSize',15);
ylabel('Pressure, Pa','FontSize',15);
title('0.5 es0','FontSize',15);
print('-dpng','htrt_sd_050.png')

figure
[C,h] = contourf(yi,rC,htrt_sd_075',v);
set(gca,'YDir','reverse','FontSize',15);
colorbar('FontSize',15)
caxis([0 8e-5])
xlabel('Latitude','FontSize',15);
ylabel('Pressure, Pa','FontSize',15);
title('0.75 es0','FontSize',15);
print('-dpng','htrt_sd_075.png')

figure
[C,h] = contourf(yi,rC,htrt_sd_100',v);
set(gca,'YDir','reverse','FontSize',15);
colorbar('FontSize',15)
caxis([0 8e-5])
xlabel('Latitude','FontSize',15);
ylabel('Pressure, Pa','FontSize',15);
title('1.0 es0','FontSize',15);
print('-dpng','htrt_sd_100.png')








figure
v=0:1:16;
[C,h] = contourf(yi,rC,th_sd_000',v);
set(gca,'YDir','reverse','FontSize',15);
colorbar('FontSize',15)
caxis([0 16])
xlabel('Latitude','FontSize',15);
ylabel('Pressure, Pa','FontSize',15);
title('0.0 es0','FontSize',15);
print('-dpng','th_sd_000.png')

figure
[C,h] = contourf(yi,rC,th_sd_010',v);
set(gca,'YDir','reverse','FontSize',15);
colorbar('FontSize',15)
caxis([0 16])
xlabel('Latitude','FontSize',15);
ylabel('Pressure, Pa','FontSize',15);
title('0.1 es0','FontSize',15);
print('-dpng','th_sd_010.png')

figure
[C,h] = contourf(yi,rC,th_sd_025',v);
set(gca,'YDir','reverse','FontSize',15);
colorbar('FontSize',15)
caxis([0 16])
xlabel('Latitude','FontSize',15);
ylabel('Pressure, Pa','FontSize',15);
title('0.25 es0','FontSize',15);
print('-dpng','th_sd_025.png')

figure
[C,h] = contourf(yi,rC,th_sd_050',v);
set(gca,'YDir','reverse','FontSize',15);
colorbar('FontSize',15)
caxis([0 16])
xlabel('Latitude','FontSize',15);
ylabel('Pressure, Pa','FontSize',15);
title('0.5 es0','FontSize',15);
print('-dpng','th_sd_050.png')

figure
[C,h] = contourf(yi,rC,th_sd_075',v);
set(gca,'YDir','reverse','FontSize',15);
colorbar('FontSize',15)
caxis([0 16])
xlabel('Latitude','FontSize',15);
ylabel('Pressure, Pa','FontSize',15);
title('0.75 es0','FontSize',15);
print('-dpng','th_sd_075.png')

figure
[C,h] = contourf(yi,rC,th_sd_100',v);
set(gca,'YDir','reverse','FontSize',15);
colorbar('FontSize',15)
caxis([0 16])
xlabel('Latitude','FontSize',15);
ylabel('Pressure, Pa','FontSize',15);
title('1.0 es0','FontSize',15);
print('-dpng','th_sd_100.png')



