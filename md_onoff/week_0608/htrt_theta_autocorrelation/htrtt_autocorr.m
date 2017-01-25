tic
htrtt_ac_000 = htrtt_autocorr_l5_fun('000');
toc
'000'
htrtt_ac_010 = htrtt_autocorr_l5_fun('010');
'010'
htrtt_ac_025 = htrtt_autocorr_l5_fun('025');
'025'
htrtt_ac_050 = htrtt_autocorr_l5_fun('050');
'050'
htrtt_ac_075 = htrtt_autocorr_l5_fun('075');
'075'
htrtt_ac_100 = htrtt_autocorr_l5_fun('100');
'100'



xi=-179:2:179;
yi=-89:2:89;
load('/project/rg312/mat_files/vt_lats_best.mat')

v=-1:0.1:1;
for i=1:21
figure
[C,h] = contourf(xi,yi,htrtt_ac_000(:,:,1,i)',v);
colorbar
caxis([-1 1])
hold on
plot(xi(90),yi(x000n),'xk','MarkerSize',10,'LineWidth',2)
xlabel('Longitude')
ylabel('Latitude')
print('-dpng',['htrtt_ac_000_' num2str(i) '.png'])

figure
[C,h] = contourf(xi,yi,htrtt_ac_010(:,:,1,i)',v);
colorbar
caxis([-1 1])
hold on
plot(xi(90),yi(x010n),'xk','MarkerSize',10,'LineWidth',2)
xlabel('Longitude')
ylabel('Latitude')
print('-dpng',['htrtt_ac_010_' num2str(i) '.png'])

figure
[C,h] = contourf(xi,yi,htrtt_ac_025(:,:,1,i)',v);
colorbar
caxis([-1 1])
hold on
plot(xi(90),yi(x025n),'xk','MarkerSize',10,'LineWidth',2)
xlabel('Longitude')
ylabel('Latitude')
print('-dpng',['htrtt_ac_025_' num2str(i) '.png'])

figure
[C,h] = contourf(xi,yi,htrtt_ac_050(:,:,1,i)',v);
colorbar
caxis([-1 1])
hold on
plot(xi(90),yi(x050n),'xk','MarkerSize',10,'LineWidth',2)
xlabel('Longitude')
ylabel('Latitude')
print('-dpng',['htrtt_ac_050_' num2str(i) '.png'])

figure
[C,h] = contourf(xi,yi,htrtt_ac_075(:,:,1,i)',v);
colorbar
caxis([-1 1])
hold on
plot(xi(90),yi(x075n),'xk','MarkerSize',10,'LineWidth',2)
xlabel('Longitude')
ylabel('Latitude')
print('-dpng',['htrtt_ac_075_' num2str(i) '.png'])

figure
[C,h] = contourf(xi,yi,htrtt_ac_100(:,:,1,i)',v);
colorbar
caxis([-1 1])
hold on
plot(xi(90),yi(x100n),'xk','MarkerSize',10,'LineWidth',2)
xlabel('Longitude')
ylabel('Latitude')
print('-dpng',['htrtt_ac_100_' num2str(i) '.png'])

close all

end



