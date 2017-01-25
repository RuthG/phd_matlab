tic
t_ac_000 = t_autocorr_fun('000');
toc
'000'
t_ac_010 = t_autocorr_fun('010');
'010'
t_ac_025 = t_autocorr_fun('025');
'025'
t_ac_050 = t_autocorr_fun('050');
'050'
t_ac_075 = t_autocorr_fun('075');
'075'
t_ac_100 = t_autocorr_fun('100');
'100'



xi=-179:2:179;
yi=-89:2:89;
load('/project/rg312/mat_files/vt_lats_best.mat')

v=-1:0.1:1;
for i=1:21
figure
[C,h] = contourf(xi,yi,t_ac_000(:,:,1,i)',v);
colorbar
caxis([-1 1])
hold on
plot(xi(90),yi(x000n),'xk','MarkerSize',10,'LineWidth',2)
xlabel('Longitude')
ylabel('Latitude')
print('-dpng',['t_ac_000_' num2str(i) '.png'])

figure
[C,h] = contourf(xi,yi,t_ac_010(:,:,1,i)',v);
colorbar
caxis([-1 1])
hold on
plot(xi(90),yi(x010n),'xk','MarkerSize',10,'LineWidth',2)
xlabel('Longitude')
ylabel('Latitude')
print('-dpng',['t_ac_010_' num2str(i) '.png'])

figure
[C,h] = contourf(xi,yi,t_ac_025(:,:,1,i)',v);
colorbar
caxis([-1 1])
hold on
plot(xi(90),yi(x025n),'xk','MarkerSize',10,'LineWidth',2)
xlabel('Longitude')
ylabel('Latitude')
print('-dpng',['t_ac_025_' num2str(i) '.png'])

figure
[C,h] = contourf(xi,yi,t_ac_050(:,:,1,i)',v);
colorbar
caxis([-1 1])
hold on
plot(xi(90),yi(x050n),'xk','MarkerSize',10,'LineWidth',2)
xlabel('Longitude')
ylabel('Latitude')
print('-dpng',['t_ac_050_' num2str(i) '.png'])

figure
[C,h] = contourf(xi,yi,t_ac_075(:,:,1,i)',v);
colorbar
caxis([-1 1])
hold on
plot(xi(90),yi(x075n),'xk','MarkerSize',10,'LineWidth',2)
xlabel('Longitude')
ylabel('Latitude')
print('-dpng',['t_ac_075_' num2str(i) '.png'])

figure
[C,h] = contourf(xi,yi,t_ac_100(:,:,1,i)',v);
colorbar
caxis([-1 1])
hold on
plot(xi(90),yi(x100n),'xk','MarkerSize',10,'LineWidth',2)
xlabel('Longitude')
ylabel('Latitude')
print('-dpng',['t_ac_100_' num2str(i) '.png'])

close all

end



