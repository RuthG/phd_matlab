load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/daily_data_psi_pressurecoords_ctrl.mat')

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/daily_data_psi_pressurecoords_pert.mat')

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_2yeardaily_pert/';
rC=squeeze(rdmds([rDir,'RC']));

%Define constants
g=9.80;					%gravity
rad=6371.0e3;				%radius of earth
dtr=pi/180;				%conversion from deg to radians
xi=-179:2:180;
yi=-89:2:90;

conts = -200:20:200;
[C,h]=contourf(yi,rC./100.,psi_ctrl'./1e9,conts) ;
caxis([-200 200]);
colormap(b2r(-200,200));
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('Mass transport: ctrl, 10^9 kg/s')
set(gca,'YDir','reverse')
colorbar 
print('psi_ctrl.png','-dpng')

conts = -200:20:200;
[C,h]=contourf(yi,rC./100.,psi_pert'./1e9,conts) ;
caxis([-200 200]);
colormap(b2r(-200,200));
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('Mass transport: pert, 10^9 kg/s')
set(gca,'YDir','reverse')
colorbar 
print('psi_pert.png','-dpng')

conts = -50:5:50;
[C,h]=contourf(yi,rC./100.,psi_pert'./1e9-psi_ctrl'./1e9,conts) ;
caxis([-50 50]);
colormap(b2r(-50,50));
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('Mass transport: pert-ctrl, 10^9 kg/s')
set(gca,'YDir','reverse')
colorbar 
print('psi_pertmctrl.png','-dpng')
