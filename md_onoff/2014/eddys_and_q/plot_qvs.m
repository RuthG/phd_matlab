%Plot es0 vs: EKE, MAPE, ~MAPE, components of ~MAPE

es0 = [0, 305.39, 610.78];

load('eke_data.mat')
load('mape_data.mat')

eke = [eke_diag_d, eke_diag_h, eke_diag_f];
mape = [mape_d, mape_h, mape_f];
approx_mape = [approx_mape_d, approx_mape_h, approx_mape_f];
gamma = [gamma_d_vav, gamma_h_vav, gamma_f_vav];
dtempdy = [dtempdy_d_bvav.^2, dtempdy_h_bvav.^2, dtempdy_f_bvav.^2];
sigma_diff = [sigma_diff_d, sigma_diff_h, sigma_diff_f];

plot(es0,eke,'x-')
title('EKE vs es0')
xlabel('e_{s0}, Pa')
ylabel('Eddy Kinetic Energy, Jm^{-2}')
print('-dpng','ekevses0.png')

figure
plot(es0,mape,'x-')
title('MAPE vs es0')
xlabel('e_{s0}, Pa')
ylabel('Mean Available Potential Energy, Jm^{-2}')
print('-dpng','mapevses0.png')

figure
plot(es0,approx_mape,'x-')
title('Approx MAPE vs es0')
xlabel('e_{s0}, Pa')
ylabel('Approx Mean Available Potential Energy, Jm^{-2}')
print('-dpng','approxmapevses0.png')

figure
plot(mape,eke,'x-')
title('EKE vs MAPE')
ylabel('Eddy Kinetic Energy, Jm^{-2}')
xlabel('Approx Mean Available Potential Energy, Jm^{-2}')
print('-dpng','ekevsmape.png')

figure
plot(es0,gamma./gamma(3),'x-')
title('Gamma vs es0')
xlabel('e_{s0}, Pa')
ylabel('Gamma, %')
print('-dpng','gammavses0.png')

figure
plot(es0,dtempdy./dtempdy(3),'x-')
title('dTdy^2 vs es0')
xlabel('e_{s0}, Pa')
ylabel('dTdy^2, %')
print('-dpng','dtdyvses0.png')

figure
plot(es0,sigma_diff./sigma_diff(3),'x-')
title('Sigma diff vs es0')
xlabel('e_{s0}, Pa')
ylabel('Sigma diff, %')
print('-dpng','sigvses0.png')

