%Try to clean up lapse rate plot calculations

%1) calculate and plot dthetadp for each model (automatically compared with the dry lapse rate)

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

load('/project/rg312/mat_files/snapshot_data/theta_snapshots.mat')
theta_000_ll = cube2latlon(xc,yc,theta_000(:,:,:,360),xi,yi);
theta_010_ll = cube2latlon(xc,yc,theta_010(:,:,:,360),xi,yi);
theta_025_ll = cube2latlon(xc,yc,theta_025(:,:,:,360),xi,yi);
theta_050_ll = cube2latlon(xc,yc,theta_050(:,:,:,360),xi,yi);
theta_075_ll = cube2latlon(xc,yc,theta_075(:,:,:,360),xi,yi);
theta_100_ll = cube2latlon(xc,yc,theta_100(:,:,:,360),xi,yi);
clear('theta_000','theta_010','theta_025','theta_050','theta_075','theta_100')

[a,b,dthetadp_000] = gradient(theta_000_ll,-4000);
[a,b,dthetadp_010] = gradient(theta_010_ll,-4000);
[a,b,dthetadp_025] = gradient(theta_025_ll,-4000);
[a,b,dthetadp_050] = gradient(theta_050_ll,-4000);
[a,b,dthetadp_075] = gradient(theta_075_ll,-4000);
[a,b,dthetadp_100] = gradient(theta_100_ll,-4000);



load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat')
t_000_ll = cube2latlon(xc,yc,t_000(:,:,:,360),xi,yi);
t_010_ll = cube2latlon(xc,yc,t_010(:,:,:,360),xi,yi);
t_025_ll = cube2latlon(xc,yc,t_025(:,:,:,360),xi,yi);
t_050_ll = cube2latlon(xc,yc,t_050(:,:,:,360),xi,yi);
t_075_ll = cube2latlon(xc,yc,t_075(:,:,:,360),xi,yi);
t_100_ll = cube2latlon(xc,yc,t_100(:,:,:,360),xi,yi);
clear('t_000','t_010','t_025','t_050','t_075','t_100')


g=9.81;
cp=1005;
L=2.5e6;
Ra=287.04;
Rv=461.50;
epsilon = Ra/Rv;
T0 = 273.16;
convtheta(1,1,:,1)=(rC/101325.0).^(2./7.);
convthetatoT = repmat(convtheta,[180,90,1]);

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


gamma_s_000 = g./cp .* (1 + L.*mus_000./(Ra.*t_000_ll))./(1+ L^2.*mus_000./(cp.*Rv.*t_000_ll.^2));
gamma_s_010 = g./cp .* (1 + L.*mus_010./(Ra.*t_010_ll))./(1+ L^2.*mus_010./(cp.*Rv.*t_010_ll.^2));
gamma_s_025 = g./cp .* (1 + L.*mus_025./(Ra.*t_025_ll))./(1+ L^2.*mus_025./(cp.*Rv.*t_025_ll.^2));
gamma_s_050 = g./cp .* (1 + L.*mus_050./(Ra.*t_050_ll))./(1+ L^2.*mus_050./(cp.*Rv.*t_050_ll.^2));
gamma_s_075 = g./cp .* (1 + L.*mus_075./(Ra.*t_075_ll))./(1+ L^2.*mus_075./(cp.*Rv.*t_075_ll.^2));
gamma_s_100 = g./cp .* (1 + L.*mus_100./(Ra.*t_100_ll))./(1+ L^2.*mus_100./(cp.*Rv.*t_100_ll.^2));

for i=1:25
dtheta_satdp_000(:,:,i) = Ra.*t_000_ll(:,:,i)./rC(i) .* (gamma_s_000(:,:,i)./g - 1./cp) ./ convthetatoT(:,:,i);
dtheta_satdp_010(:,:,i) = Ra.*t_010_ll(:,:,i)./rC(i) .* (gamma_s_010(:,:,i)./g - 1./cp) ./ convthetatoT(:,:,i);
dtheta_satdp_025(:,:,i) = Ra.*t_025_ll(:,:,i)./rC(i) .* (gamma_s_025(:,:,i)./g - 1./cp) ./ convthetatoT(:,:,i);
dtheta_satdp_050(:,:,i) = Ra.*t_050_ll(:,:,i)./rC(i) .* (gamma_s_050(:,:,i)./g - 1./cp) ./ convthetatoT(:,:,i);
dtheta_satdp_075(:,:,i) = Ra.*t_075_ll(:,:,i)./rC(i) .* (gamma_s_075(:,:,i)./g - 1./cp) ./ convthetatoT(:,:,i);
dtheta_satdp_100(:,:,i) = Ra.*t_100_ll(:,:,i)./rC(i) .* (gamma_s_100(:,:,i)./g - 1./cp) ./ convthetatoT(:,:,i);
end



figure
v=-0.0013:0.0001:0;
[C,h] = contourf(xi,yi,dthetadp_000(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-0.0013 0]);
colorbar
title('d\Theta/dp, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthetadp_000.png')


figure
v=-0.0013:0.0001:0;
[C,h] = contourf(xi,yi,dthetadp_010(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-0.0013 0]);
colorbar
title('d\Theta/dp, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthetadp_010.png')


figure
v=-0.0013:0.0001:0;
[C,h] = contourf(xi,yi,dthetadp_025(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-0.0013 0]);
colorbar
title('d\Theta/dp, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthetadp_025.png')


figure
v=-0.0013:0.0001:0;
[C,h] = contourf(xi,yi,dthetadp_050(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-0.0013 0]);
colorbar
title('d\Theta/dp, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthetadp_050.png')


figure
v=-0.0013:0.0001:0;
[C,h] = contourf(xi,yi,dthetadp_075(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-0.0013 0]);
colorbar
title('d\Theta/dp, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthetadp_075.png')


figure
v=-0.0013:0.0001:0;
[C,h] = contourf(xi,yi,dthetadp_100(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-0.0013 0]);
colorbar
title('d\Theta/dp, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthetadp_100.png')




figure
v=-0.0013:0.0001:0;
[C,h] = contourf(xi,yi,dthetadp_000(:,:,5)' - dtheta_satdp_000(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-0.0013 0]);
colorbar
title('d\Theta/dp - d\Theta/dp_{sat}, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthetadpmsat_000.png')


figure
v=-0.0013:0.0001:0;
[C,h] = contourf(xi,yi,dthetadp_010(:,:,5)' - dtheta_satdp_010(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-0.0013 0]);
colorbar
title('d\Theta/dp - d\Theta/dp_{sat}, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthetadpmsat_010.png')


figure
v=-0.0013:0.0001:0;
[C,h] = contourf(xi,yi,dthetadp_025(:,:,5)' - dtheta_satdp_025(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-0.0013 0]);
colorbar
title('d\Theta/dp - d\Theta/dp_{sat}, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthetadpmsat_025.png')


figure
v=-0.0013:0.0001:0;
[C,h] = contourf(xi,yi,dthetadp_050(:,:,5)' - dtheta_satdp_050(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-0.0013 0]);
colorbar
title('d\Theta/dp - d\Theta/dp_{sat}, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthetadpmsat_050.png')


figure
v=-0.0013:0.0001:0;
[C,h] = contourf(xi,yi,dthetadp_075(:,:,5)' - dtheta_satdp_075(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-0.0013 0]);
colorbar
title('d\Theta/dp - d\Theta/dp_{sat}, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthetadpmsat_075.png')


figure
v=-0.0013:0.0001:0;
[C,h] = contourf(xi,yi,dthetadp_100(:,:,5)' - dtheta_satdp_100(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-0.0013 0]);
colorbar
title('d\Theta/dp - d\Theta/dp_{sat}, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','dthetadpmsat_100.png')




