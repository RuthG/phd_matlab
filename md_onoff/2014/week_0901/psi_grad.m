%plot psi at 500mb vs lat, see shape of increase/decrease

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
rC=squeeze(rdmds([rDir,'RC']));
yi = 1:2:89;
g=9.81;
cp=1004.64;
intfac = 4000.*cp./g;
es0(1) = 610.78;
es0(2) = 305.39;
es0(3) = 305.39./2;
es0(4) = 0;
es0(5) = 305.39;

load('heat_budg_vars.mat')
load('lapse_rates.mat')

plot(yi,psi_w_hzav(:,13))
hold on
plot(yi,psi_h_hzav(:,13),'k')
plot(yi,psi_q_hzav(:,13),'g')
plot(yi,psi_d_hzav(:,13),'r')
plot(yi,psi_th_hzav(:,13),'m')
xlabel('Latitude')
ylabel('Streamfunction magnitude')
print('-dpng','psi_grad.png')
