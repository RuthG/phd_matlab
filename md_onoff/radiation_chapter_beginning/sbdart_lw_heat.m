%relevant sbdart output is stored in week_0922
%load this up and plot up heat rate based on their optical depths calculated from downwelling fluxes, and our insolation.

load('~/md_onoff/week_0922/lw_sbdart.mat')

yi = -89:2:89;
p=20:40:1000;

heat_lw = heat_lw_u+ heat_lw_l + heat_win;

figure
v=-3:0.25:0;
label = -3:0.25:0;
[C,h] = contour(yi(2:89),p,heat_lw(2:89,:)',v,'k');
clabel(C,h,label);
set(gca,'YDir','reverse')
title('SBDART LW heating')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','sbdart_lw_heat.png')

