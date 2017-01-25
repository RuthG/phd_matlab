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
ny=90;
xi=-179:2:180;yi=-89:2:90;

load('/project/rg312/mat_files/front_diag.mat')

load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat')
t_000_ll = cube2latlon(xc,yc,t_000(:,:,:,360),xi,yi);
t_010_ll = cube2latlon(xc,yc,t_010(:,:,:,360),xi,yi);
t_025_ll = cube2latlon(xc,yc,t_025(:,:,:,360),xi,yi);
t_050_ll = cube2latlon(xc,yc,t_050(:,:,:,360),xi,yi);
t_075_ll = cube2latlon(xc,yc,t_075(:,:,:,360),xi,yi);
t_100_ll = cube2latlon(xc,yc,t_100(:,:,:,360),xi,yi);
clear('t_000','t_010','t_025','t_050','t_075','t_100')

load('/project/rg312/mat_files/snapshot_data/q_snapshots.mat')
q_000_ll = cube2latlon(xc,yc,q_000(:,:,:,360),xi,yi);
q_010_ll = cube2latlon(xc,yc,q_010(:,:,:,360),xi,yi);
q_025_ll = cube2latlon(xc,yc,q_025(:,:,:,360),xi,yi);
q_050_ll = cube2latlon(xc,yc,q_050(:,:,:,360),xi,yi);
q_075_ll = cube2latlon(xc,yc,q_075(:,:,:,360),xi,yi);
q_100_ll = cube2latlon(xc,yc,q_100(:,:,:,360),xi,yi);
clear('q_000','q_010','q_025','q_050','q_075','q_100')


[a,b,dlnTdp_000] = gradient(log(t_000_ll),-4000);
[a,b,dlnTdp_010] = gradient(log(t_010_ll),-4000);
[a,b,dlnTdp_025] = gradient(log(t_025_ll),-4000);
[a,b,dlnTdp_050] = gradient(log(t_050_ll),-4000);
[a,b,dlnTdp_075] = gradient(log(t_075_ll),-4000);
[a,b,dlnTdp_100] = gradient(log(t_100_ll),-4000);

g=9.81;
cp=1005;
L=2.5e6;
Ra=287.04;
Rv=461.50;
epsilon = Ra/Rv;
T0 = 273.16;

prefac_lin(1,1,:) = rC.*g./Ra;
prefac = repmat(prefac_lin,[180,90,1]);


dTdz_000 = prefac.*dlnTdp_000.*1000;
dTdz_010 = prefac.*dlnTdp_010.*1000;
dTdz_025 = prefac.*dlnTdp_025.*1000;
dTdz_050 = prefac.*dlnTdp_050.*1000;
dTdz_075 = prefac.*dlnTdp_075.*1000;
dTdz_100 = prefac.*dlnTdp_100.*1000;


%now try again with calculating saturated lapse rate...

%want mus, need sat vapour pressure first:

es_000 = 0.*610.78.*exp((L./Rv).*(1./T0 - 1./t_000_ll));
es_010 = 0.1.*610.78.*exp((L./Rv).*(1./T0 - 1./t_010_ll));
es_025 = 0.25.*610.78.*exp((L./Rv).*(1./T0 - 1./t_025_ll));
es_050 = 0.5.*610.78.*exp((L./Rv).*(1./T0 - 1./t_050_ll));
es_075 = 0.75.*610.78.*exp((L./Rv).*(1./T0 - 1./t_075_ll));
es_100 = 1.*610.78.*exp((L./Rv).*(1./T0 - 1./t_100_ll));

for i=1:25
mus_000(:,:,i) = epsilon.*es_000(:,:,i)./(rC(i)-es_000(:,:,i)); 
mus_010(:,:,i) = epsilon.*es_010(:,:,i)./(rC(i)-es_010(:,:,i)); 
mus_025(:,:,i) = epsilon.*es_025(:,:,i)./(rC(i)-es_025(:,:,i)); 
mus_050(:,:,i) = epsilon.*es_050(:,:,i)./(rC(i)-es_050(:,:,i)); 
mus_075(:,:,i) = epsilon.*es_075(:,:,i)./(rC(i)-es_075(:,:,i)); 
mus_100(:,:,i) = epsilon.*es_100(:,:,i)./(rC(i)-es_100(:,:,i)); 
end

relhum_000 = q_000_ll./mus_000;
relhum_010 = q_010_ll./mus_010;
relhum_025 = q_025_ll./mus_025;
relhum_050 = q_050_ll./mus_050;
relhum_075 = q_075_ll./mus_075;
relhum_100 = q_100_ll./mus_100;


gamma_s_000 = 1000.*g./cp .* (1 + L.*mus_000./(Ra.*t_000_ll))./(1+ L^2.*mus_000./(cp.*Rv.*t_000_ll.^2));
gamma_s_010 = 1000.*g./cp .* (1 + L.*mus_010./(Ra.*t_010_ll))./(1+ L^2.*mus_010./(cp.*Rv.*t_010_ll.^2));
gamma_s_025 = 1000.*g./cp .* (1 + L.*mus_025./(Ra.*t_025_ll))./(1+ L^2.*mus_025./(cp.*Rv.*t_025_ll.^2));
gamma_s_050 = 1000.*g./cp .* (1 + L.*mus_050./(Ra.*t_050_ll))./(1+ L^2.*mus_050./(cp.*Rv.*t_050_ll.^2));
gamma_s_075 = 1000.*g./cp .* (1 + L.*mus_075./(Ra.*t_075_ll))./(1+ L^2.*mus_075./(cp.*Rv.*t_075_ll.^2));
gamma_s_100 = 1000.*g./cp .* (1 + L.*mus_100./(Ra.*t_100_ll))./(1+ L^2.*mus_100./(cp.*Rv.*t_100_ll.^2));





figure
v=0:0.05:1;
[C,h] = contourf(xi,yi,relhum_000(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([0 1]);
colorbar
title('Relative humidity, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','relhum_000.png')


figure
v=0:0.05:1;
[C,h] = contourf(xi,yi,relhum_010(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([0 1]);
colorbar
title('Relative humidity, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','relhum_010.png')


figure
v=0:0.05:1;
[C,h] = contourf(xi,yi,relhum_025(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([0 1]);
colorbar
title('Relative humidity, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','relhum_025.png')


figure
v=0:0.05:1;
[C,h] = contourf(xi,yi,relhum_050(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([0 1]);
colorbar
title('Relative humidity, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','relhum_050.png')


figure
v=0:0.05:1;
[C,h] = contourf(xi,yi,relhum_075(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([0 1]);
colorbar
title('Relative humidity, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','relhum_075.png')


figure
v=0:0.05:1;
[C,h] = contourf(xi,yi,relhum_100(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([0 1]);
colorbar
title('Relative humidity, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','relhum_100.png')

return

figure
v=-12:0.5:0;
[C,h] = contourf(xi,yi,dTdz_000(:,:,5)' - gamma_s_000(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-12 0]);
colorbar
title('dTdz - dTdz_{dry}, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dtdzmdtdzdry_000.png')


figure
v=-12:0.5:0;
[C,h] = contourf(xi,yi,dTdz_010(:,:,5)' - gamma_s_000(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-12 0]);
colorbar
title('dTdz - dTdz_{dry}, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dtdzmdtdzdry_010.png')


figure
v=-12:0.5:0;
[C,h] = contourf(xi,yi,dTdz_025(:,:,5)' - gamma_s_000(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-12 0]);
colorbar
title('dTdz - dTdz_{dry}, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dtdzmdtdzdry_025.png')


figure
v=-12:0.5:0;
[C,h] = contourf(xi,yi,dTdz_050(:,:,5)' - gamma_s_000(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-12 0]);
colorbar
title('dTdz - dTdz_{dry}, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dtdzmdtdzdry_050.png')


figure
v=-12:0.5:0;
[C,h] = contourf(xi,yi,dTdz_075(:,:,5)' - gamma_s_000(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-12 0]);
colorbar
title('dTdz - dTdz_{dry}, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dtdzmdtdzdry_075.png')


figure
v=-12:0.5:0;
[C,h] = contourf(xi,yi,dTdz_100(:,:,5)' - gamma_s_000(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-12 0]);
colorbar
title('dTdz - dTdz_{dry}, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dtdzmdtdzdry_100.png')



figure
v=-10:0.5:4;
[C,h] = contourf(xi,yi,dTdz_000(:,:,5)' - gamma_s_000(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-10 4]);
colorbar
title('dTdz - dTdz_{sat}, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dtdzmdtdzsat_000.png')


figure
v=-10:0.5:4;
[C,h] = contourf(xi,yi,dTdz_010(:,:,5)' - gamma_s_010(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
%caxis([-12e-8 12e-8]);
colorbar
title('dTdz - dTdz_{sat}, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dtdzmdtdzsat_010.png')


figure
v=-10:0.5:4;
[C,h] = contourf(xi,yi,dTdz_025(:,:,5)' - gamma_s_025(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-10 4]);
colorbar
title('dTdz - dTdz_{sat}, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dtdzmdtdzsat_025.png')


figure
v=-10:0.5:4;
[C,h] = contourf(xi,yi,dTdz_050(:,:,5)' - gamma_s_050(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-10 4]);
colorbar
title('dTdz - dTdz_{sat}, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dtdzmdtdzsat_050.png')


figure
v=-10:0.5:4;
[C,h] = contourf(xi,yi,dTdz_075(:,:,5)' - gamma_s_075(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-10 4]);
colorbar
title('dTdz - dTdz_{sat}, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dtdzmdtdzsat_075.png')


figure
v=-10:0.5:4;
[C,h] = contourf(xi,yi,dTdz_100(:,:,5)' - gamma_s_100(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-10 4]);
colorbar
title('dTdz - dTdz_{sat}, 1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dtdzmdtdzsat_100.png')

