%relevant sbdart output is stored in week_0922
%load this up and plot up heat rate based on their optical depths calculated from downwelling fluxes, and our insolation.

load('~/md_onoff/week_0922/sw_sbdart.mat')

for i=1:25
trans(:,i) = fxdn_sw(:,i+1)./fxdn_sw(:,1);
end

lat = (-89:2:89).*pi./180;
solar_constant 	= 1360.0;

ss = sin(lat);
p2 = (1. - 3.*ss.^2)./4;
del_sol = 1.4;
solar = repmat(0.25.*solar_constant.*(1.0 + del_sol.*p2'),[1,25]);

mitflux(:,1) = solar(:,1);
mitflux(:,2:26) = solar.*trans;

p_half = 0:4000:100000;
p = 2000:4000:98000;
grav = 9.8;
cp_air 		= 287.04./(2./7);

for k=1:25
   tdt_sw(:,k) = -(mitflux(:,k+1) - mitflux (:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
   tdt_dn(:,k) = -(fxdn_sw(:,k+1) - fxdn_sw (:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
   tdt_up(:,k) = (fxup_sw(:,k+1) - fxup_sw (:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
end

yi = -89:2:89;

figure
v=0:0.1:1.6;
label = 0:0.2:1.6;
[C,h] = contour(yi(2:89),p./100,tdt_sw(2:89,:)'.*86400,v,'k');
clabel(C,h,label);
set(gca,'YDir','reverse')
title('SBDART SW heating')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','sbdart_sw_heat.png')

figure
v=0:0.5:3.5;
label = 0:0.5:3.5;
[C,h] = contour(yi(2:89),p./100,tdt_dn(2:89,:)'.*86400,v,'k');
clabel(C,h,label);
set(gca,'YDir','reverse')
title('SBDART SW heating')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','sbdart_sw_heatdn.png')

figure
v=-3.5:0.5:3.5;
label = -3.5:0.5:3.5;
[C,h] = contour(yi(2:89),p./100,tdt_up(2:89,:)'.*86400,v,'k');
clabel(C,h,label);
set(gca,'YDir','reverse')
title('SBDART SW heating')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','sbdart_sw_heatup.png')

figure
v=0:0.5:3.5;
label = 0:0.5:3.5;
[C,h] = contour(yi(2:89),p./100,heat_sw(2:89,:)',v,'k');
clabel(C,h,label);
set(gca,'YDir','reverse')
title('SBDART SW heating')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','sbdart_sw_heattot.png')
