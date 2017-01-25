%load rhines and rossby wavenos, overplot plus subtract to see if separable...


load('/project/rg312/mat_files/rhines_scale.mat')
load('/project/rg312/mat_files/rossby_rad.mat')
yi = -89:2:89;

plot(yi,kd_000)
hold on
plot(yi,kbeta_000,'--')

figure
plot(yi,abs(kd_000 - kbeta_000))
hold on
plot(yi,abs(kd_010 - kbeta_010),'g')
plot(yi,abs(kd_025 - kbeta_025),'r')
plot(yi,abs(kd_050 - kbeta_050),'m')
plot(yi,abs(kd_075 - kbeta_075),'c')
plot(yi,abs(kd_100 - kbeta_100),'k')
plot(yi,abs(kd_th - kbeta_th),'m--')
ylim([0 2])
legend('0es0','0.1es0','0.25es0','0.5es0','0.75es0','1.0es0','tropheat')
xlabel('Latitude')
ylabel('Wavenumber difference')
title('Absolute difference between Rhines and Rossby wavenumbers')
print('-dpng','kbetamd.png')


