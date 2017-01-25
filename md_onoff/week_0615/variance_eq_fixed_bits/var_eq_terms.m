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


[vth_ed_000, dthdy_000, wth_ed_000, dthdp_000, qth_ed_000, th_var_000]=var_eq_fun('000');
'000'

[vth_ed_010, dthdy_010, wth_ed_010, dthdp_010, qth_ed_010, th_var_010]=var_eq_fun('010');
'010'

[vth_ed_025, dthdy_025, wth_ed_025, dthdp_025, qth_ed_025, th_var_025]=var_eq_fun('025');
'025'

[vth_ed_050, dthdy_050, wth_ed_050, dthdp_050, qth_ed_050, th_var_050]=var_eq_fun('050');
'050'

[vth_ed_075, dthdy_075, wth_ed_075, dthdp_075, qth_ed_075, th_var_075]=var_eq_fun('075');
'075'

[vth_ed_100, dthdy_100, wth_ed_100, dthdp_100, qth_ed_100, th_var_100]=var_eq_fun('100');
'100'

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
[C,h] = contourf(yi,rC,vth_ed_000'.*dthdy_000',v);
colorbar
caxis([-5e-4 2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vth_ed_dthdy_000.png')


figure
[C,h] = contourf(yi,rC,vth_ed_010'.*dthdy_010',v);
colorbar
caxis([-5e-4 2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vth_ed_dthdy_010.png')


figure
[C,h] = contourf(yi,rC,vth_ed_025'.*dthdy_025',v);
colorbar
caxis([-5e-4 2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vth_ed_dthdy_025.png')


figure
[C,h] = contourf(yi,rC,vth_ed_050'.*dthdy_050',v);
colorbar
caxis([-5e-4 2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vth_ed_dthdy_050.png')


figure
[C,h] = contourf(yi,rC,vth_ed_075'.*dthdy_075',v);
colorbar
caxis([-5e-4 2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vth_ed_dthdy_075.png')


figure
[C,h] = contourf(yi,rC,vth_ed_100'.*dthdy_100',v);
colorbar
caxis([-5e-4 2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vth_ed_dthdy_100.png')






v=-2.5e-4:1e-5:3.2e-4;

figure
[C,h] = contourf(yi,rC,wth_ed_000'.*dthdp_000',v);
colorbar
caxis([-2.5e-4 3.2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','wth_ed_dthdp_000.png')


figure
[C,h] = contourf(yi,rC,wth_ed_010'.*dthdp_010',v);
colorbar
caxis([-2.5e-4 3.2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','wth_ed_dthdp_010.png')


figure
[C,h] = contourf(yi,rC,wth_ed_025'.*dthdp_025',v);
colorbar
caxis([-2.5e-4 3.2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','wth_ed_dthdp_025.png')


figure
[C,h] = contourf(yi,rC,wth_ed_050'.*dthdp_050',v);
colorbar
caxis([-2.5e-4 3.2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','wth_ed_dthdp_050.png')


figure
[C,h] = contourf(yi,rC,wth_ed_075'.*dthdp_075',v);
colorbar
caxis([-2.5e-4 3.2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','wth_ed_dthdp_075.png')


figure
[C,h] = contourf(yi,rC,wth_ed_100'.*dthdp_100',v);
colorbar
caxis([-2.5e-4 3.2e-4])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','wth_ed_dthdp_100.png')







v=-5e-5:0.5e-5:1e-5;

figure
[C,h] = contourf(yi,rC,vth_ed_000'.*dthdy_000' + wth_ed_000'.*dthdp_000',v);
colorbar
caxis([-5e-5 1e-5])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vw_000.png')


figure
[C,h] = contourf(yi,rC,vth_ed_010'.*dthdy_010' + wth_ed_010'.*dthdp_010',v);
colorbar
caxis([-5e-5 1e-5])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vw_010.png')


figure
[C,h] = contourf(yi,rC,vth_ed_025'.*dthdy_025' + wth_ed_025'.*dthdp_025',v);
colorbar
caxis([-5e-5 1e-5])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vw_025.png')


figure
[C,h] = contourf(yi,rC,vth_ed_050'.*dthdy_050' + wth_ed_050'.*dthdp_050',v);
colorbar
caxis([-5e-5 1e-5])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vw_050.png')


figure
[C,h] = contourf(yi,rC,vth_ed_075'.*dthdy_075' + wth_ed_075'.*dthdp_075',v);
colorbar
caxis([-5e-5 1e-5])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vw_075.png')


figure
[C,h] = contourf(yi,rC,vth_ed_100'.*dthdy_100' + wth_ed_100'.*dthdp_100',v);
colorbar
caxis([-5e-5 1e-5])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','vw_100.png')










v=-5e-5:0.5e-5:1e-5;

figure
[C,h] = contourf(yi,rC,qth_ed_000',v);
colorbar
caxis([-5e-5 1e-5])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','htrtth_ed_000.png')


figure
[C,h] = contourf(yi,rC,qth_ed_010',v);
colorbar
caxis([-5e-5 1e-5])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','htrtth_ed_010.png')


figure
[C,h] = contourf(yi,rC,qth_ed_025',v);
colorbar
caxis([-5e-5 1e-5])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','htrtth_ed_025.png')


figure
[C,h] = contourf(yi,rC,qth_ed_050',v);
colorbar
caxis([-5e-5 1e-5])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','htrtth_ed_050.png')


figure
[C,h] = contourf(yi,rC,qth_ed_075',v);
colorbar
caxis([-5e-5 1e-5])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','htrtth_ed_075.png')


figure
[C,h] = contourf(yi,rC,qth_ed_100',v);
colorbar
caxis([-5e-5 1e-5])
xlabel('Latitude')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
print('-dpng','htrtth_ed_100.png')





