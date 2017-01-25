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



load('/project/rg312/mat_files/var_eq_000.mat')
vth_ed_000 = vth_ed; 
dthdy_000 = dthdy; 
wth_ed_000 = wth_ed;
dthdp_000 = dthdp; 
qth_ed_000 = qth_ed;

load('/project/rg312/mat_files/var_eq_010.mat')
vth_ed_010 = vth_ed; 
dthdy_010 = dthdy; 
wth_ed_010 = wth_ed;
dthdp_010 = dthdp; 
qth_ed_010 = qth_ed;

load('/project/rg312/mat_files/var_eq_025.mat')
vth_ed_025 = vth_ed; 
dthdy_025 = dthdy; 
wth_ed_025 = wth_ed;
dthdp_025 = dthdp; 
qth_ed_025 = qth_ed;

load('/project/rg312/mat_files/var_eq_050.mat')
vth_ed_050 = vth_ed; 
dthdy_050 = dthdy; 
wth_ed_050 = wth_ed;
dthdp_050 = dthdp; 
qth_ed_050 = qth_ed;

load('/project/rg312/mat_files/var_eq_075.mat')
vth_ed_075 = vth_ed; 
dthdy_075 = dthdy; 
wth_ed_075 = wth_ed;
dthdp_075 = dthdp; 
qth_ed_075 = qth_ed;

load('/project/rg312/mat_files/var_eq_100.mat')
vth_ed_100 = vth_ed; 
dthdy_100 = dthdy; 
wth_ed_100 = wth_ed;
dthdp_100 = dthdp; 
qth_ed_100 = qth_ed;




v=-5e-4:1e-5:2e-4;

figure
[C,h] = contourf(yi,rC,vth_ed_000'.*dthdy_100',v);
colorbar
caxis([-5e-4 2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vth_ed_dthdy_000_fg.png')


figure
[C,h] = contourf(yi,rC,vth_ed_010'.*dthdy_100',v);
colorbar
caxis([-5e-4 2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vth_ed_dthdy_010_fg.png')


figure
[C,h] = contourf(yi,rC,vth_ed_025'.*dthdy_100',v);
colorbar
caxis([-5e-4 2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vth_ed_dthdy_025_fg.png')


figure
[C,h] = contourf(yi,rC,vth_ed_050'.*dthdy_100',v);
colorbar
caxis([-5e-4 2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vth_ed_dthdy_050_fg.png')


figure
[C,h] = contourf(yi,rC,vth_ed_075'.*dthdy_100',v);
colorbar
caxis([-5e-4 2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vth_ed_dthdy_075_fg.png')


figure
[C,h] = contourf(yi,rC,vth_ed_100'.*dthdy_100',v);
colorbar
caxis([-5e-4 2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vth_ed_dthdy_100_fg.png')







v=-5e-4:1e-5:2e-4;

figure
[C,h] = contourf(yi,rC,vth_ed_100'.*dthdy_000',v);
colorbar
caxis([-5e-4 2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vth_ed_dthdy_000_fb.png')


figure
[C,h] = contourf(yi,rC,vth_ed_100'.*dthdy_010',v);
colorbar
caxis([-5e-4 2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vth_ed_dthdy_010_fb.png')


figure
[C,h] = contourf(yi,rC,vth_ed_100'.*dthdy_025',v);
colorbar
caxis([-5e-4 2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vth_ed_dthdy_025_fb.png')


figure
[C,h] = contourf(yi,rC,vth_ed_100'.*dthdy_050',v);
colorbar
caxis([-5e-4 2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vth_ed_dthdy_050_fb.png')


figure
[C,h] = contourf(yi,rC,vth_ed_100'.*dthdy_075',v);
colorbar
caxis([-5e-4 2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vth_ed_dthdy_075_fb.png')


figure
[C,h] = contourf(yi,rC,vth_ed_100'.*dthdy_100',v);
colorbar
caxis([-5e-4 2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vth_ed_dthdy_100_fb.png')













v=-2.5e-4:1e-5:3.2e-4;

figure
[C,h] = contourf(yi,rC,wth_ed_000'.*dthdp_100',v);
colorbar
caxis([-2.5e-4 3.2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','wth_ed_dthdp_000_fg.png')


figure
[C,h] = contourf(yi,rC,wth_ed_010'.*dthdp_100',v);
colorbar
caxis([-2.5e-4 3.2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','wth_ed_dthdp_010_fg.png')


figure
[C,h] = contourf(yi,rC,wth_ed_025'.*dthdp_100',v);
colorbar
caxis([-2.5e-4 3.2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','wth_ed_dthdp_025_fg.png')


figure
[C,h] = contourf(yi,rC,wth_ed_050'.*dthdp_100',v);
colorbar
caxis([-2.5e-4 3.2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','wth_ed_dthdp_050_fg.png')


figure
[C,h] = contourf(yi,rC,wth_ed_075'.*dthdp_100',v);
colorbar
caxis([-2.5e-4 3.2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','wth_ed_dthdp_075_fg.png')


figure
[C,h] = contourf(yi,rC,wth_ed_100'.*dthdp_100',v);
colorbar
caxis([-2.5e-4 3.2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','wth_ed_dthdp_100_fg.png')








figure
[C,h] = contourf(yi,rC,wth_ed_100'.*dthdp_000',v);
colorbar
caxis([-2.5e-4 3.2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','wth_ed_dthdp_000_fb.png')


figure
[C,h] = contourf(yi,rC,wth_ed_100'.*dthdp_010',v);
colorbar
caxis([-2.5e-4 3.2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','wth_ed_dthdp_010_fb.png')


figure
[C,h] = contourf(yi,rC,wth_ed_100'.*dthdp_025',v);
colorbar
caxis([-2.5e-4 3.2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','wth_ed_dthdp_025_fb.png')


figure
[C,h] = contourf(yi,rC,wth_ed_100'.*dthdp_050',v);
colorbar
caxis([-2.5e-4 3.2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','wth_ed_dthdp_050_fb.png')


figure
[C,h] = contourf(yi,rC,wth_ed_100'.*dthdp_075',v);
colorbar
caxis([-2.5e-4 3.2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','wth_ed_dthdp_075_fb.png')


figure
[C,h] = contourf(yi,rC,wth_ed_100'.*dthdp_100',v);
colorbar
caxis([-2.5e-4 3.2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','wth_ed_dthdp_100_fb.png')



