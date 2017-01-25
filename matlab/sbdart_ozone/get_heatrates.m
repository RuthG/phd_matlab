%get_heatrates.m
%Load up results from oz_sbdart.m and produce heating rates to put into SBDART
%Compare wv+oz with ozwv to check how good assumption that htrates are additive is, think about best solution


%Load up SBDART output
p_levs(1,1) = 17.63;
p_levs(2:26,1) = 20:40:980;
output_lw_oz_1 = dlmread('~/matlab/sbdart_ozone/sbdart_oz/OUTPUT_ozlw1');
output_sw_oz_1 = dlmread('~/matlab/sbdart_ozone/sbdart_oz/OUTPUT_ozsw1');
output_lw_wv_1 = dlmread('~/matlab/sbdart_ozone/sbdart_wvonly/OUTPUT_lw1');
output_sw_wv_1 = dlmread('~/matlab/sbdart_ozone/sbdart_wvonly/OUTPUT_sw1');
output_lw_wvoz_1 = dlmread('~/matlab/sbdart_ozone/sbdart_ozwv/OUTPUT_ozwvlw1');
output_sw_wvoz_1 = dlmread('~/matlab/sbdart_ozone/sbdart_ozwv/OUTPUT_ozwvsw1');
output_lw_cl_1 = dlmread('~/matlab/sbdart_ozone/sbdart_cl/OUTPUT_cllw1');
output_sw_cl_1 = dlmread('~/matlab/sbdart_ozone/sbdart_cl/OUTPUT_clsw1');
output_lw_oz_2 = dlmread('~/matlab/sbdart_ozone/sbdart_oz/OUTPUT_ozlw2');
output_sw_oz_2 = dlmread('~/matlab/sbdart_ozone/sbdart_oz/OUTPUT_ozsw2');
output_lw_wv_2 = dlmread('~/matlab/sbdart_ozone/sbdart_wvonly/OUTPUT_lw2');
output_sw_wv_2 = dlmread('~/matlab/sbdart_ozone/sbdart_wvonly/OUTPUT_sw2');
output_lw_wvoz_2 = dlmread('~/matlab/sbdart_ozone/sbdart_ozwv/OUTPUT_ozwvlw2');
output_sw_wvoz_2 = dlmread('~/matlab/sbdart_ozone/sbdart_ozwv/OUTPUT_ozwvsw2');
output_lw_cl_2 = dlmread('~/matlab/sbdart_ozone/sbdart_cl/OUTPUT_cllw2');
output_sw_cl_2 = dlmread('~/matlab/sbdart_ozone/sbdart_cl/OUTPUT_clsw2');
output_lw_oz_3 = dlmread('~/matlab/sbdart_ozone/sbdart_oz/OUTPUT_ozlw3');
output_sw_oz_3 = dlmread('~/matlab/sbdart_ozone/sbdart_oz/OUTPUT_ozsw3');
output_lw_wv_3 = dlmread('~/matlab/sbdart_ozone/sbdart_wvonly/OUTPUT_lw3');
output_sw_wv_3 = dlmread('~/matlab/sbdart_ozone/sbdart_wvonly/OUTPUT_sw3');
output_lw_wvoz_3 = dlmread('~/matlab/sbdart_ozone/sbdart_ozwv/OUTPUT_ozwvlw3');
output_sw_wvoz_3 = dlmread('~/matlab/sbdart_ozone/sbdart_ozwv/OUTPUT_ozwvsw3');
output_lw_cl_3 = dlmread('~/matlab/sbdart_ozone/sbdart_cl/OUTPUT_cllw3');
output_sw_cl_3 = dlmread('~/matlab/sbdart_ozone/sbdart_cl/OUTPUT_clsw3');

%save more sensibly!

oz_sw_dwn(:,1) = output_sw_oz_1(2:27,3);
oz_sw_dwn(:,2) = output_sw_oz_2(2:27,3);
oz_sw_dwn(:,3) = output_sw_oz_3(2:27,3);
oz_sw_up(:,1) = output_sw_oz_1(2:27,4);
oz_sw_up(:,2) = output_sw_oz_2(2:27,4);
oz_sw_up(:,3) = output_sw_oz_3(2:27,4);
oz_sw_dwndir(:,1) = output_sw_oz_1(2:27,5);
oz_sw_dwndir(:,2) = output_sw_oz_2(2:27,5);
oz_sw_dwndir(:,3) = output_sw_oz_3(2:27,5);
oz_sw_dfdz(:,1) = output_sw_oz_1(2:27,6);
oz_sw_dfdz(:,2) = output_sw_oz_2(2:27,6);
oz_sw_dfdz(:,3) = output_sw_oz_3(2:27,6);
oz_sw_heat(:,1) = output_sw_oz_1(2:27,7);
oz_sw_heat(:,2) = output_sw_oz_2(2:27,7);
oz_sw_heat(:,3) = output_sw_oz_3(2:27,7);

oz_lw_dwn(:,1) = output_lw_oz_1(2:27,3);
oz_lw_dwn(:,2) = output_lw_oz_2(2:27,3);
oz_lw_dwn(:,3) = output_lw_oz_3(2:27,3);
oz_lw_up(:,1) = output_lw_oz_1(2:27,4);
oz_lw_up(:,2) = output_lw_oz_2(2:27,4);
oz_lw_up(:,3) = output_lw_oz_3(2:27,4);
oz_lw_dwndir(:,1) = output_lw_oz_1(2:27,5);
oz_lw_dwndir(:,2) = output_lw_oz_2(2:27,5);
oz_lw_dwndir(:,3) = output_lw_oz_3(2:27,5);
oz_lw_dfdz(:,1) = output_lw_oz_1(2:27,6);
oz_lw_dfdz(:,2) = output_lw_oz_2(2:27,6);
oz_lw_dfdz(:,3) = output_lw_oz_3(2:27,6);
oz_lw_heat(:,1) = output_lw_oz_1(2:27,7);
oz_lw_heat(:,2) = output_lw_oz_2(2:27,7);
oz_lw_heat(:,3) = output_lw_oz_3(2:27,7);

return
wv_sw_dwn(:,1) = output_sw_wv_1(2:27,3);
wv_sw_dwn(:,2) = output_sw_wv_2(2:27,3);
wv_sw_dwn(:,3) = output_sw_wv_3(2:27,3);
wv_sw_up(:,1) = output_sw_wv_1(2:27,4);
wv_sw_up(:,2) = output_sw_wv_2(2:27,4);
wv_sw_up(:,3) = output_sw_wv_3(2:27,4);
wv_sw_dwndir(:,1) = output_sw_wv_1(2:27,5);
wv_sw_dwndir(:,2) = output_sw_wv_2(2:27,5);
wv_sw_dwndir(:,3) = output_sw_wv_3(2:27,5);
wv_sw_dfdz(:,1) = output_sw_wv_1(2:27,6);
wv_sw_dfdz(:,2) = output_sw_wv_2(2:27,6);
wv_sw_dfdz(:,3) = output_sw_wv_3(2:27,6);
wv_sw_heat(:,1) = output_sw_wv_1(2:27,7);
wv_sw_heat(:,2) = output_sw_wv_2(2:27,7);
wv_sw_heat(:,3) = output_sw_wv_3(2:27,7);

wv_lw_dwn(:,1) = output_lw_wv_1(2:27,3);
wv_lw_dwn(:,2) = output_lw_wv_2(2:27,3);
wv_lw_dwn(:,3) = output_lw_wv_3(2:27,3);
wv_lw_up(:,1) = output_lw_wv_1(2:27,4);
wv_lw_up(:,2) = output_lw_wv_2(2:27,4);
wv_lw_up(:,3) = output_lw_wv_3(2:27,4);
wv_lw_dwndir(:,1) = output_lw_wv_1(2:27,5);
wv_lw_dwndir(:,2) = output_lw_wv_2(2:27,5);
wv_lw_dwndir(:,3) = output_lw_wv_3(2:27,5);
wv_lw_dfdz(:,1) = output_lw_wv_1(2:27,6);
wv_lw_dfdz(:,2) = output_lw_wv_2(2:27,6);
wv_lw_dfdz(:,3) = output_lw_wv_3(2:27,6);
wv_lw_heat(:,1) = output_lw_wv_1(2:27,7);
wv_lw_heat(:,2) = output_lw_wv_2(2:27,7);
wv_lw_heat(:,3) = output_lw_wv_3(2:27,7);

wvoz_sw_dwn(:,1) = output_sw_wvoz_1(2:27,3);
wvoz_sw_dwn(:,2) = output_sw_wvoz_2(2:27,3);
wvoz_sw_dwn(:,3) = output_sw_wvoz_3(2:27,3);
wvoz_sw_up(:,1) = output_sw_wvoz_1(2:27,4);
wvoz_sw_up(:,2) = output_sw_wvoz_2(2:27,4);
wvoz_sw_up(:,3) = output_sw_wvoz_3(2:27,4);
wvoz_sw_dwndir(:,1) = output_sw_wvoz_1(2:27,5);
wvoz_sw_dwndir(:,2) = output_sw_wvoz_2(2:27,5);
wvoz_sw_dwndir(:,3) = output_sw_wvoz_3(2:27,5);
wvoz_sw_dfdz(:,1) = output_sw_wvoz_1(2:27,6);
wvoz_sw_dfdz(:,2) = output_sw_wvoz_2(2:27,6);
wvoz_sw_dfdz(:,3) = output_sw_wvoz_3(2:27,6);
wvoz_sw_heat(:,1) = output_sw_wvoz_1(2:27,7);
wvoz_sw_heat(:,2) = output_sw_wvoz_2(2:27,7);
wvoz_sw_heat(:,3) = output_sw_wvoz_3(2:27,7);

wvoz_lw_dwn(:,1) = output_lw_wvoz_1(2:27,3);
wvoz_lw_dwn(:,2) = output_lw_wvoz_2(2:27,3);
wvoz_lw_dwn(:,3) = output_lw_wvoz_3(2:27,3);
wvoz_lw_up(:,1) = output_lw_wvoz_1(2:27,4);
wvoz_lw_up(:,2) = output_lw_wvoz_2(2:27,4);
wvoz_lw_up(:,3) = output_lw_wvoz_3(2:27,4);
wvoz_lw_dwndir(:,1) = output_lw_wvoz_1(2:27,5);
wvoz_lw_dwndir(:,2) = output_lw_wvoz_2(2:27,5);
wvoz_lw_dwndir(:,3) = output_lw_wvoz_3(2:27,5);
wvoz_lw_dfdz(:,1) = output_lw_wvoz_1(2:27,6);
wvoz_lw_dfdz(:,2) = output_lw_wvoz_2(2:27,6);
wvoz_lw_dfdz(:,3) = output_lw_wvoz_3(2:27,6);
wvoz_lw_heat(:,1) = output_lw_wvoz_1(2:27,7);
wvoz_lw_heat(:,2) = output_lw_wvoz_2(2:27,7);
wvoz_lw_heat(:,3) = output_lw_wvoz_3(2:27,7);

cl_sw_dwn(:,1) = output_sw_cl_1(2:27,3);
cl_sw_dwn(:,2) = output_sw_cl_2(2:27,3);
cl_sw_dwn(:,3) = output_sw_cl_3(2:27,3);
cl_sw_up(:,1) = output_sw_cl_1(2:27,4);
cl_sw_up(:,2) = output_sw_cl_2(2:27,4);
cl_sw_up(:,3) = output_sw_cl_3(2:27,4);
cl_sw_dwndir(:,1) = output_sw_cl_1(2:27,5);
cl_sw_dwndir(:,2) = output_sw_cl_2(2:27,5);
cl_sw_dwndir(:,3) = output_sw_cl_3(2:27,5);
cl_sw_dfdz(:,1) = output_sw_cl_1(2:27,6);
cl_sw_dfdz(:,2) = output_sw_cl_2(2:27,6);
cl_sw_dfdz(:,3) = output_sw_cl_3(2:27,6);
cl_sw_heat(:,1) = output_sw_cl_1(2:27,7);
cl_sw_heat(:,2) = output_sw_cl_2(2:27,7);
cl_sw_heat(:,3) = output_sw_cl_3(2:27,7);

cl_lw_dwn(:,1) = output_lw_cl_1(2:27,3);
cl_lw_dwn(:,2) = output_lw_cl_2(2:27,3);
cl_lw_dwn(:,3) = output_lw_cl_3(2:27,3);
cl_lw_up(:,1) = output_lw_cl_1(2:27,4);
cl_lw_up(:,2) = output_lw_cl_2(2:27,4);
cl_lw_up(:,3) = output_lw_cl_3(2:27,4);
cl_lw_dwndir(:,1) = output_lw_cl_1(2:27,5);
cl_lw_dwndir(:,2) = output_lw_cl_2(2:27,5);
cl_lw_dwndir(:,3) = output_lw_cl_3(2:27,5);
cl_lw_dfdz(:,1) = output_lw_cl_1(2:27,6);
cl_lw_dfdz(:,2) = output_lw_cl_2(2:27,6);
cl_lw_dfdz(:,3) = output_lw_cl_3(2:27,6);
cl_lw_heat(:,1) = output_lw_cl_1(2:27,7);
cl_lw_heat(:,2) = output_lw_cl_2(2:27,7);
cl_lw_heat(:,3) = output_lw_cl_3(2:27,7);

%Calculate wv+oz heatrates compared with ozwv, how different are these

diff_wo_lw = wv_lw_heat + oz_lw_heat - wvoz_lw_heat;
diff_wo_sw = wv_sw_heat + oz_sw_heat - wvoz_sw_heat;

plot(diff_wo_lw,p_levs(1:26));
hold on
plot(diff_wo_sw,p_levs(1:26));

plot(wvoz_sw_heat - wv_sw_heat, p_levs);
hold on
plot(wvoz_lw_heat - wv_lw_heat, p_levs);
hold off

s(1) = subplot(3,2,1)
plot(oz_lw_heat(:,1),p_levs)
hold on
plot(wv_lw_heat(:,1),p_levs,'r')
plot(wvoz_lw_heat(:,1),p_levs,'g')
plot(cl_lw_heat(:,1),p_levs,'k')
hold off
title(s(1),'60^{\circ}, LW')
xlabel('Heating rate, K/day')
ylabel('Pressure, hPa')
set(gca,'YDir','reverse')

s(2) = subplot(3,2,2)
plot(oz_sw_heat(:,1),p_levs)
hold on
plot(wv_sw_heat(:,1),p_levs,'r')
plot(wvoz_sw_heat(:,1),p_levs,'g')
plot(cl_sw_heat(:,1),p_levs,'k')
hold off
title(s(2),'60^{\circ}, SW')
xlabel('Heating rate, K/day')
ylabel('Pressure, hPa')
set(gca,'YDir','reverse')

s(3) = subplot(3,2,3)
plot(oz_lw_heat(:,2),p_levs)
hold on
plot(wv_lw_heat(:,2),p_levs,'r')
plot(wvoz_lw_heat(:,2),p_levs,'g')
plot(cl_lw_heat(:,2),p_levs,'k')
hold off
title(s(3),'45^{\circ}, LW')
xlabel('Heating rate, K/day')
ylabel('Pressure, hPa')
set(gca,'YDir','reverse')

s(4) = subplot(3,2,4)
plot(oz_sw_heat(:,2),p_levs)
hold on
plot(wv_sw_heat(:,2),p_levs,'r')
plot(wvoz_sw_heat(:,2),p_levs,'g')
plot(cl_sw_heat(:,2),p_levs,'k')
hold off
title(s(4),'45^{\circ}, SW')
xlabel('Heating rate, K/day')
ylabel('Pressure, hPa')
set(gca,'YDir','reverse')

s(5) = subplot(3,2,5)
plot(oz_lw_heat(:,3),p_levs)
hold on
plot(wv_lw_heat(:,3),p_levs,'r')
plot(wvoz_lw_heat(:,3),p_levs,'g')
plot(cl_lw_heat(:,3),p_levs,'k')
hold off
title(s(5),'15^{\circ}, LW')
legend('oz','wv','oz+wv','ctrl','Location','NorthWest')
xlabel('Heating rate, K/day')
ylabel('Pressure, hPa')
set(gca,'YDir','reverse')

s(6) = subplot(3,2,6)
plot(oz_sw_heat(:,3),p_levs)
hold on
plot(wv_sw_heat(:,3),p_levs,'r')
plot(wvoz_sw_heat(:,3),p_levs,'g')
plot(cl_sw_heat(:,3),p_levs,'k')
hold off
title(s(6),'15^{\circ}, SW')
xlabel('Heating rate, K/day')
ylabel('Pressure, hPa')
set(gca,'YDir','reverse')

return

%Normalise SW heating so comparable with our incoming solar

%MITgcm incoming solar:
szen = [60,45,15];
ss  = sin(szen.*pi./180.);
p2 = (1. - 3.*ss.*ss)/4.;
del_sol = 1.4;
solar_constant = 1360.0;
solar = 0.25.*solar_constant.*(1.0 + del_sol.*p2);

insol_fac = 4.*solar./(wv_sw_dwn(1,:)+oz_sw_dwn(1,:)+cl_sw_dwn(1,:)+wvoz_sw_dwn(1,:));
for j=1:3
trans_swwv_15(:,j) = wv_sw_dwn(:,j)./wv_sw_dwn(1,j);
check_dwn(:,j) = solar(j).*trans_swwv_15(:,j);
grav=9.81;
cp_air = 1004.64;
spd = 86400;
for i=1:24
compare_heat(i,j) = (-check_dwn(i+1,j) + check_dwn(i,j)).*spd.*grav./(cp_air*100.*(p_levs(i+1)-p_levs(i)));
end
end
plot(compare_heat,40:40:960,'g')
hold on
for i=1:3
plot(wv_sw_heat(:,i).*insol_fac(i),p_levs)
end

insol_fac = 4.*solar./(wv_sw_dwn(1,:)+oz_sw_dwn(1,:)+cl_sw_dwn(1,:)+wvoz_sw_dwn(1,:));
for j=1:3
trans_swoz(:,j) = oz_sw_dwn(:,j)./oz_sw_dwn(1,j);
check_dwn_oz(:,j) = solar(j).*trans_swoz(:,j);
grav=9.81;
cp_air = 1004.64;
spd = 86400;
for i=1:24
compare_heat_oz(i,j) = (-check_dwn_oz(i+1,j) + check_dwn_oz(i,j)).*spd.*grav./(cp_air*100.*(p_levs(i+1)-p_levs(i)));
end
end
plot(compare_heat_oz,40:40:960,'g')
hold on
for i=1:3
plot(oz_sw_heat(:,i).*insol_fac(i),p_levs)
end

%seems ~ ok for Ozone. Use wvoz - wv to get estimate of oz effect, with heatrates normalised w insol_fac

for i=1:3
o_heat_mit_profile_sw(:,i) = (wvoz_sw_heat(:,i) - wv_sw_heat(:,i)).*insol_fac(i);
end
o_heat_mit_profile_sw(:,4) = o_heat_mit_profile_sw(:,3)
o_heat_mit_profile_sw(:,5) = o_heat_mit_profile_sw(:,2)
o_heat_mit_profile_sw(:,6) = o_heat_mit_profile_sw(:,1)
o_heat_mit_profile_lw(:,1:3) = (wvoz_lw_heat - wv_lw_heat)
o_heat_mit_profile_lw(:,4) = o_heat_mit_profile_lw(:,3)
o_heat_mit_profile_lw(:,5) = o_heat_mit_profile_lw(:,2)
o_heat_mit_profile_lw(:,6) = o_heat_mit_profile_lw(:,1)

oldlat = [-60,-45,-15,15,45,60]
ylat = -89:2:89;
o_hmp_sw_full = interp1(oldlat,o_heat_mit_profile_sw',ylat,'linear','extrap');
o_hmp_lw_full = interp1(oldlat,o_heat_mit_profile_lw',ylat,'linear','extrap');

%For fixed O3 conc, pressure, is there a simple way to scale with changing T? How important is it?




