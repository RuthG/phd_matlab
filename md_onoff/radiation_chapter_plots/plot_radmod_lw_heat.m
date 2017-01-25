%load in radmod sw heating and plot up to compare with SBDART

load('/project/rg312/mat_files/heating_myscheme.mat') 

yi = -89:2:89;
p = 2000:4000:98000;

figure
v=-5:0.25:1.6;
label = -5:0.25:1.6;
[C,h] = contour(yi(2:89),p./100,tdt_lw(2:89,:)'.*86400,v,'k');
clabel(C,h,label);
set(gca,'YDir','reverse')
title('RadMod LW heating')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','radmod_lw_heat.png')


return
load('/project/rg312/mat_files/radmod_lw_vw.mat') 

yi = -89:2:89;
p = 2000:4000:98000;

figure
v=-5:0.25:1.6;
label = -5:0.25:1.6;
[C,h] = contour(yi(2:89),p./100,tdt_lw(2:89,:)'.*86400,v,'k');
clabel(C,h,label);
set(gca,'YDir','reverse')
title('VW LW heating')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','radmod_lw_heat_vw.png')
