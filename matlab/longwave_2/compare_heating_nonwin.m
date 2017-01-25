%compare_heating.m
%compare heating rates predicted by sbdart with those from our radiation scheme

spd = 24.*60.*60.;
load('radiation_mod1.mat')
mit_fxdn_sw(:,1) = solar_down;
mit_heat_sw(:,1) = tdt_sw.*spd;
mit_fxdn_lw(:,1) = down;
mit_fxup_lw(:,1) = up;
mit_heat_lw(:,1) = tdt_lw.*spd;
mit_heat_o3(:,1) = ozone_heat.*spd;
lats(:,1) = lat./deg_to_rad;
mit_solar(:,1) = solar;
load('radiation_mod2.mat')
mit_fxdn_sw(:,2) = solar_down;
mit_heat_sw(:,2) = tdt_sw.*spd;
mit_fxdn_lw(:,2) = down;
mit_fxup_lw(:,2) = up;
mit_heat_lw(:,2) = tdt_lw.*spd;
mit_heat_o3(:,2) = ozone_heat.*spd;
lats(:,2) = lat./deg_to_rad;
mit_solar(:,2) = solar;
load('radiation_mod3.mat')
mit_fxdn_sw(:,3) = solar_down;
mit_heat_sw(:,3) = tdt_sw.*spd;
mit_fxdn_lw(:,3) = down;
mit_fxup_lw(:,3) = up;
mit_heat_lw(:,3) = tdt_lw.*spd;
mit_heat_o3(:,3) = ozone_heat.*spd;
lats(:,3) = lat./deg_to_rad;
mit_solar(:,3) = solar;
load('radiation_mod4.mat')
mit_fxdn_sw(:,4) = solar_down;
mit_heat_sw(:,4) = tdt_sw.*spd;
mit_fxdn_lw(:,4) = down;
mit_fxup_lw(:,4) = up;
mit_heat_lw(:,4) = tdt_lw.*spd;
mit_heat_o3(:,4) = ozone_heat.*spd;
lats(:,4) = lat./deg_to_rad;
mit_solar(:,4) = solar;
load('radiation_mod5.mat')
mit_fxdn_sw(:,5) = solar_down;
mit_heat_sw(:,5) = tdt_sw.*spd;
mit_fxdn_lw(:,5) = down;
mit_fxup_lw(:,5) = up;
mit_heat_lw(:,5) = tdt_lw.*spd;
mit_heat_o3(:,5) = ozone_heat.*spd;
lats(:,5) = lat./deg_to_rad;
mit_solar(:,5) = solar;
load('radiation_mod6.mat')
mit_fxdn_sw(:,6) = solar_down;
mit_heat_sw(:,6) = tdt_sw.*spd;
mit_fxdn_lw(:,6) = down;
mit_fxup_lw(:,6) = up;
mit_heat_lw(:,6) = tdt_lw.*spd;
mit_heat_o3(:,6) = ozone_heat.*spd;
lats(:,6) = lat./deg_to_rad;
mit_solar(:,6) = solar;

output_sw1 = dlmread('~/matlab/radscheme_checks/out/OUTPUT_sw1');
output_sw2 = dlmread('~/matlab/radscheme_checks/out/OUTPUT_sw2');
output_sw3 = dlmread('~/matlab/radscheme_checks/out/OUTPUT_sw3');
output_sw4 = dlmread('~/matlab/radscheme_checks/out/OUTPUT_sw4');
output_sw5 = dlmread('~/matlab/radscheme_checks/out/OUTPUT_sw5');
output_sw6 = dlmread('~/matlab/radscheme_checks/out/OUTPUT_sw6');

output_lw11 = dlmread('~/matlab/longwave_2/out/OUTPUT_lw11') ;%('~/matlab/radscheme_checks/out/OUTPUT_lw1');
output_lw12 = dlmread('~/matlab/longwave_2/out/OUTPUT_lw12') ;%('~/matlab/radscheme_checks/out/OUTPUT_lw2');
output_lw13 = dlmread('~/matlab/longwave_2/out/OUTPUT_lw13') ;%('~/matlab/radscheme_checks/out/OUTPUT_lw3');
output_lw14 = dlmread('~/matlab/longwave_2/out/OUTPUT_lw14') ;%('~/matlab/radscheme_checks/out/OUTPUT_lw4');
output_lw15 = dlmread('~/matlab/longwave_2/out/OUTPUT_lw15') ;%('~/matlab/radscheme_checks/out/OUTPUT_lw5');
output_lw16 = dlmread('~/matlab/longwave_2/out/OUTPUT_lw16') ;%('~/matlab/radscheme_checks/out/OUTPUT_lw6');

output_lw21 = dlmread('~/matlab/longwave_2/out/OUTPUT_lw21') ;%('~/matlab/radscheme_checks/out/OUTPUT_lw1');
output_lw22 = dlmread('~/matlab/longwave_2/out/OUTPUT_lw22') ;%('~/matlab/radscheme_checks/out/OUTPUT_lw2');
output_lw23 = dlmread('~/matlab/longwave_2/out/OUTPUT_lw23') ;%('~/matlab/radscheme_checks/out/OUTPUT_lw3');
output_lw24 = dlmread('~/matlab/longwave_2/out/OUTPUT_lw24') ;%('~/matlab/radscheme_checks/out/OUTPUT_lw4');
output_lw25 = dlmread('~/matlab/longwave_2/out/OUTPUT_lw25') ;%('~/matlab/radscheme_checks/out/OUTPUT_lw5');
output_lw26 = dlmread('~/matlab/longwave_2/out/OUTPUT_lw26') ;%('~/matlab/radscheme_checks/out/OUTPUT_lw6');

fxdn_sw(:,1)  = output_sw1(2:26,3);
fxdn_sw(:,2)  = output_sw2(2:26,3);
fxdn_sw(:,3)  = output_sw3(2:26,3);
fxdn_sw(:,4)  = output_sw4(2:26,3);
fxdn_sw(:,5)  = output_sw5(2:26,3);
fxdn_sw(:,6)  = output_sw6(2:26,3);

for i=1:6
tau_sw(:,i) = -log(fxdn_sw(:,i)./fxdn_sw(1,i));
ms_fxdn_sw(:,i) = mit_solar(:,i).*exp(-tau_sw(:,i));
end

for k=1:24
ms_heat_sw(k,:) = spd.*(-ms_fxdn_sw(k+1,:) + ms_fxdn_sw(k,:)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
end

fxup_sw(:,1)  = output_sw1(2:26,4);
fxup_sw(:,2)  = output_sw2(2:26,4);
fxup_sw(:,3)  = output_sw3(2:26,4);
fxup_sw(:,4)  = output_sw4(2:26,4);
fxup_sw(:,5)  = output_sw5(2:26,4);
fxup_sw(:,6)  = output_sw6(2:26,4);
heat_sw(:,1)  = output_sw1(2:26,7);
heat_sw(:,2)  = output_sw2(2:26,7);
heat_sw(:,3)  = output_sw3(2:26,7);
heat_sw(:,4)  = output_sw4(2:26,7);
heat_sw(:,5)  = output_sw5(2:26,7);
heat_sw(:,6)  = output_sw6(2:26,7);

fxdn_lw(:,1)  = output_lw11(2:26,3) + output_lw21(2:26,3);
fxdn_lw(:,2)  = output_lw12(2:26,3) + output_lw22(2:26,3);
fxdn_lw(:,3)  = output_lw13(2:26,3) + output_lw23(2:26,3);
fxdn_lw(:,4)  = output_lw14(2:26,3) + output_lw24(2:26,3);
fxdn_lw(:,5)  = output_lw15(2:26,3) + output_lw25(2:26,3);
fxdn_lw(:,6)  = output_lw16(2:26,3) + output_lw26(2:26,3);
fxup_lw(:,1)  = output_lw11(2:26,4) + output_lw21(2:26,4);
fxup_lw(:,2)  = output_lw12(2:26,4) + output_lw22(2:26,4);
fxup_lw(:,3)  = output_lw13(2:26,4) + output_lw23(2:26,4);
fxup_lw(:,4)  = output_lw14(2:26,4) + output_lw24(2:26,4);
fxup_lw(:,5)  = output_lw15(2:26,4) + output_lw25(2:26,4);
fxup_lw(:,6)  = output_lw16(2:26,4) + output_lw26(2:26,4);
heat_lw(:,1)  = output_lw11(2:26,7) + output_lw21(2:26,7);
heat_lw(:,2)  = output_lw12(2:26,7) + output_lw22(2:26,7);
heat_lw(:,3)  = output_lw13(2:26,7) + output_lw23(2:26,7);
heat_lw(:,4)  = output_lw14(2:26,7) + output_lw24(2:26,7);
heat_lw(:,5)  = output_lw15(2:26,7) + output_lw25(2:26,7);
heat_lw(:,6)  = output_lw16(2:26,7) + output_lw26(2:26,7);

save('compare_heating.mat','t_ml','p','p_half','h2o_q_ml','o_mix_ml','o_dens_ml','fxdn_lw','fxup_lw','heat_lw','fxdn_sw','fxup_sw','heat_sw','tau_sw','lats','mit_fxdn_sw','mit_heat_sw','mit_fxdn_lw','mit_fxup_lw','mit_heat_lw','mit_solar','ms_fxdn_sw','ms_heat_sw','mit_heat_o3')
clear
load('compare_heating.mat')

subplot(2,3,1)
plot(ms_heat_sw(:,1),p_half(2:25))
hold on
plot(mit_heat_sw(:,1)+mit_heat_o3(:,1),p,'r')
set(gca,'YDir','reverse')
title(['Tropical, ' num2str(lats(1))])
xlabel('SW heating, K/day')
ylabel('Pressure, Pa')
axis([0 1.5 0 100000])
hold off

subplot(2,3,2)
plot(ms_heat_sw(:,2),p_half(2:25))
hold on
plot(mit_heat_sw(:,2)+mit_heat_o3(:,2),p,'r')
set(gca,'YDir','reverse')
title(['Midlat Summer, ' num2str(lats(2))])
xlabel('SW heating, K/day')
ylabel('Pressure, Pa')
axis([0 1.5 0 100000])
hold off

subplot(2,3,3)
plot(ms_heat_sw(:,3),p_half(2:25))
hold on
plot(mit_heat_sw(:,3)+mit_heat_o3(:,3),p,'r')
set(gca,'YDir','reverse')
title(['Midlat Winter, ' num2str(lats(3))])
xlabel('SW heating, K/day')
ylabel('Pressure, Pa')
axis([0 1.5 0 100000])
hold off

subplot(2,3,4)
plot(ms_heat_sw(:,4),p_half(2:25))
hold on
plot(mit_heat_sw(:,4)+mit_heat_o3(:,4),p,'r')
set(gca,'YDir','reverse')
title(['Subarctic Summer, ' num2str(lats(4))])
xlabel('SW heating, K/day')
ylabel('Pressure, Pa')
axis([0 1.5 0 100000])
hold off

subplot(2,3,5)
plot(ms_heat_sw(:,5),p_half(2:25))
hold on
plot(mit_heat_sw(:,5)+mit_heat_o3(:,5),p,'r')
set(gca,'YDir','reverse')
title(['Subarctic Winter, ' num2str(lats(5))])
xlabel('SW heating, K/day')
ylabel('Pressure, Pa')
axis([0 1.5 0 100000])
hold off

subplot(2,3,6)
plot(ms_heat_sw(:,6),p_half(2:25))
hold on
plot(mit_heat_sw(:,6)+mit_heat_o3(:,6),p,'r')
set(gca,'YDir','reverse')
title(['US Standard, ' num2str(lats(6))])
xlabel('SW heating, K/day')
ylabel('Pressure, Pa')
axis([0 1.5 0 100000])
hold off

name=['sw_heat_wv_o3.png']
print('-dpng',name) 


subplot(2,3,1)
plot(heat_lw(2:25,1),p(2:25))
hold on
plot(mit_heat_lw(:,1),p,'r')
set(gca,'YDir','reverse')
title(['Tropical, ' num2str(lats(1))])
xlabel('LW heating, K/day')
ylabel('Pressure, Pa')
axis([-4 1 0 100000])
hold off
subplot(2,3,2)
plot(heat_lw(2:25,2),p(2:25))
hold on
plot(mit_heat_lw(:,2),p,'r')
set(gca,'YDir','reverse')
title(['Midlat Summer, ' num2str(lats(2))])
xlabel('LW heating, K/day')
ylabel('Pressure, Pa')
axis([-4 1 0 100000])
hold off
subplot(2,3,3)
plot(heat_lw(2:25,3),p(2:25))
hold on
plot(mit_heat_lw(:,3),p,'r')
set(gca,'YDir','reverse')
title(['Midlat Winter, ' num2str(lats(3))])
xlabel('LW heating, K/day')
ylabel('Pressure, Pa')
axis([-4. 1 0 100000])
hold off
subplot(2,3,4)
plot(heat_lw(2:25,4),p(2:25))
hold on
plot(mit_heat_lw(:,4),p,'r')
set(gca,'YDir','reverse')
title(['Subarctic Summer, ' num2str(lats(4))])
xlabel('LW heating, K/day')
ylabel('Pressure, Pa')
axis([-4 1 0 100000])
hold off
subplot(2,3,5)
plot(heat_lw(2:25,5),p(2:25))
hold on
plot(mit_heat_lw(:,5),p,'r')
set(gca,'YDir','reverse')
title(['Subarctic Winter, ' num2str(lats(5))])
xlabel('LW heating, K/day')
ylabel('Pressure, Pa')
axis([-4 1 0 100000])
hold off
subplot(2,3,6)
plot(heat_lw(2:25,6),p(2:25))
hold on
plot(mit_heat_lw(:,6),p,'r')
set(gca,'YDir','reverse')
title(['US Standard, ' num2str(lats(6))])
xlabel('LW heating, K/day')
ylabel('Pressure, Pa')
axis([-4 1 0 100000])
hold off

name=['lw_heat_wv_o3.png']
print('-dpng',name) 
return

subplot(2,3,1)
plot(flipud(h2o_q_ml(:,1)),p)
set(gca,'YDir','reverse')
title(['Tropical, ' num2str(lats(1))])
xlabel('Specific humidity, kg/kg')
ylabel('Pressure, Pa')
axis([0 0.0147 0 100000])
hold off
subplot(2,3,2)
plot(flipud(h2o_q_ml(:,2)),p)
set(gca,'YDir','reverse')
title(['Midlat Summer, ' num2str(lats(2))])
xlabel('Specific humidity, kg/kg')
ylabel('Pressure, Pa')
axis([0 0.0147 0 100000])
hold off
subplot(2,3,3)
plot(flipud(h2o_q_ml(:,3)),p)
set(gca,'YDir','reverse')
title(['Midlat Winter, ' num2str(lats(3))])
xlabel('Specific humidity, kg/kg')
ylabel('Pressure, Pa')
axis([0 0.0147 0 100000])
hold off
subplot(2,3,4)
plot(flipud(h2o_q_ml(:,4)),p)
set(gca,'YDir','reverse')
title(['Subarctic Summer, ' num2str(lats(4))])
xlabel('Specific humidity, kg/kg')
ylabel('Pressure, Pa')
axis([0 0.0147 0 100000])
hold off
subplot(2,3,5)
plot(flipud(h2o_q_ml(:,5)),p)
set(gca,'YDir','reverse')
title(['Subarctic Winter, ' num2str(lats(5))])
xlabel('Specific humidity, kg/kg')
ylabel('Pressure, Pa')
axis([0 0.0147 0 100000])
hold off
subplot(2,3,6)
plot(flipud(h2o_q_ml(:,6)),p)
set(gca,'YDir','reverse')
title(['US Standard, ' num2str(lats(6))])
xlabel('Specific humidity, kg/kg')
ylabel('Pressure, Pa')
axis([0 0.0147 0 100000])
hold off
name=['wv.png']
print('-dpng',name) 

subplot(2,3,1)
plot(flipud(o_mix_ml(:,1)),p)
set(gca,'YDir','reverse')
title(['Tropical, ' num2str(lats(1))])
xlabel('Ozone mass mixing ratio, kg/kg')
ylabel('Pressure, Pa')
axis([0 1.1758e-05 0 100000])
hold off
subplot(2,3,2)
plot(flipud(o_mix_ml(:,2)),p)
set(gca,'YDir','reverse')
title(['Midlat Summer, ' num2str(lats(2))])
xlabel('Ozone mass mixing ratio, kg/kg')
ylabel('Pressure, Pa')
axis([0 1.1758e-05 0 100000])
hold off
subplot(2,3,3)
plot(flipud(o_mix_ml(:,3)),p)
set(gca,'YDir','reverse')
title(['Midlat Winter, ' num2str(lats(3))])
xlabel('Ozone mass mixing ratio, kg/kg')
ylabel('Pressure, Pa')
axis([0 1.1758e-05 0 100000])
hold off
subplot(2,3,4)
plot(flipud(o_mix_ml(:,4)),p)
set(gca,'YDir','reverse')
title(['Subarctic Summer, ' num2str(lats(4))])
xlabel('Ozone mass mixing ratio, kg/kg')
ylabel('Pressure, Pa')
axis([0 1.1758e-05 0 100000])
hold off
subplot(2,3,5)
plot(flipud(o_mix_ml(:,5)),p)
set(gca,'YDir','reverse')
title(['Subarctic Winter, ' num2str(lats(5))])
xlabel('Ozone mass mixing ratio, kg/kg')
ylabel('Pressure, Pa')
axis([0 1.1758e-05 0 100000])
hold off
subplot(2,3,6)
plot(flipud(o_mix_ml(:,6)),p)
set(gca,'YDir','reverse')
title(['US Standard, ' num2str(lats(6))])
xlabel('Ozone mass mixing ratio, kg/kg')
ylabel('Pressure, Pa')
axis([0 1.1758e-05 0 100000])
hold off
name=['o3.png']
print('-dpng',name) 

subplot(2,3,1)
plot(flipud(t_ml(:,1)),p)
set(gca,'YDir','reverse')
title(['Tropical, ' num2str(lats(1))])
xlabel('Temperature, K')
ylabel('Pressure, Pa')
axis([195 300 0 100000])
hold off
subplot(2,3,2)
plot(flipud(t_ml(:,2)),p)
set(gca,'YDir','reverse')
title(['Midlat Summer, ' num2str(lats(2))])
xlabel('Temperature, K')
ylabel('Pressure, Pa')
axis([195 300 0 100000])
hold off
subplot(2,3,3)
plot(flipud(t_ml(:,3)),p)
set(gca,'YDir','reverse')
title(['Midlat Winter, ' num2str(lats(3))])
xlabel('Temperature, K')
ylabel('Pressure, Pa')
axis([195 300 0 100000])
hold off
subplot(2,3,4)
plot(flipud(t_ml(:,4)),p)
set(gca,'YDir','reverse')
title(['Subarctic Summer, ' num2str(lats(4))])
xlabel('Temperature, K')
ylabel('Pressure, Pa')
axis([195 300 0 100000])
hold off
subplot(2,3,5)
plot(flipud(t_ml(:,5)),p)
set(gca,'YDir','reverse')
title(['Subarctic Winter, ' num2str(lats(5))])
xlabel('Temperature, K')
ylabel('Pressure, Pa')
axis([195 300 0 100000])
hold off
subplot(2,3,6)
plot(flipud(t_ml(:,6)),p)
set(gca,'YDir','reverse')
title(['US Standard, ' num2str(lats(6))])
xlabel('Temperature, K')
ylabel('Pressure, Pa')
axis([195 300 0 100000])
hold off
name=['temp.png']
print('-dpng',name) 
