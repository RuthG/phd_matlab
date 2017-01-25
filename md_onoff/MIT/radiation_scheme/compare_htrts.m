%load in hires, normal htrts etc and compare structure/mag


yi = -89:2:89;
p = 2000:4000:98000;
p_hi = 1000:2000:99000;
p_lo = 5000:10000:95000;
p_half = fliplr([100000,98500,96378,93378, 89136, 83136,75336, 66236, 56836,47556, 39156, 32176, 26376, 21556, 17552,14224,11458,9160,7250, 5664,4346,3250,2340,1584,956, 434,0]);
p_b = p_half(1:26) + 0.5.*diff(p_half);

load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_hires.mat','tdt_lw','tdt_sw','solar_down','up','down')
tdt_lw_hi = tdt_lw;
tdt_sw_hi = tdt_sw;
solar_down_hi = solar_down;
up_hi = up;
down_hi = down;

load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_lores.mat','tdt_lw','tdt_sw','solar_down','up','down')
tdt_lw_lo = tdt_lw;
tdt_sw_lo = tdt_sw;
solar_down_lo = solar_down;
up_lo = up;
down_lo = down;

load('/project/rg312/mat_files/radiation_chapter/heating_myscheme_bres.mat','tdt_lw','tdt_sw','solar_down','up','down')
tdt_lw_b = tdt_lw;
tdt_sw_b = tdt_sw;
solar_down_b = solar_down;
up_b = up;
down_b = down;

load('/project/rg312/mat_files/radiation_chapter/heating_myscheme.mat','tdt_lw','tdt_sw','solar_down','up','down')



v=-10:0.5:10;

figure
[C,h] = contour(yi(2:89),p./100,tdt_lw(2:89,:)'.*86400,v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
ylim([0 1000]);
print('-dpng','lw_heat_normal.png')

figure
[C,h] = contour(yi(2:89),p_hi./100,tdt_lw_hi(2:89,:)'.*86400,v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
ylim([0 1000]);
print('-dpng','lw_heat_hi.png')


figure
[C,h] = contour(yi(2:89),p_lo./100,tdt_lw_lo(2:89,:)'.*86400,v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
ylim([0 1000]);
print('-dpng','lw_heat_lo.png')

figure
[C,h] = contour(yi(2:89),p_b./100,tdt_lw_b(2:89,:)'.*86400,v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
ylim([0 1000]);
print('-dpng','lw_heat_b.png')

v=0:0.2:1.6;

figure
[C,h] = contour(yi(2:89),p./100,tdt_sw(2:89,:)'.*86400,v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
ylim([0 1000]);
print('-dpng','sw_heat_normal.png')

figure
[C,h] = contour(yi(2:89),p_hi./100,tdt_sw_hi(2:89,:)'.*86400,v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
ylim([0 1000]);
print('-dpng','sw_heat_hi.png')

figure
[C,h] = contour(yi(2:89),p_lo./100,tdt_sw_lo(2:89,:)'.*86400,v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
ylim([0 1000]);
print('-dpng','sw_heat_lo.png')

figure
[C,h] = contour(yi(2:89),p_b./100,tdt_sw_b(2:89,:)'.*86400,v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
ylim([0 1000]);
print('-dpng','sw_heat_b.png')
