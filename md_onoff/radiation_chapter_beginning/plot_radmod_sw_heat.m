%load in radmod sw heating and plot up to compare with SBDART

load('/project/rg312/mat_files/heating_myscheme.mat') 

yi = -89:2:89;
p = 2000:4000:98000;

figure
v=0:0.1:1.6;
label = 0:0.2:1.6;
[C,h] = contour(yi(2:89),p./100,tdt_sw(2:89,:)'.*86400,v,'k');
clabel(C,h,label);
set(gca,'YDir','reverse')
title('RadMod SW heating')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','radmod_sw_heat.png')
