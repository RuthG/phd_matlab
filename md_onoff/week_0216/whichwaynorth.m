%load vel data and try to figure out where north is in cs coords...

load('/project/rg312/mat_files/heat_budg_fluxes.mat','uth_100')
uth_100_tav = mean(uth_100,4);

figure
contourf(uth_100_tav(1:32,:,5))
figure
contourf(uth_100_tav(33:64,:,5))
figure
contourf(uth_100_tav(65:96,:,5))
figure
contourf(uth_100_tav(97:128,:,5))
figure
contourf(uth_100_tav(129:160,:,5))
figure
contourf(uth_100_tav(161:192,:,5))