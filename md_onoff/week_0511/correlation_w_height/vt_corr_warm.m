%load in v'T' and check correlation for each run; does increase come from mag or from correlation?

rDir='/project/rg312/wv_on_rad_off/run_000_best/';
rC=squeeze(rdmds([rDir,'RC']));
yi = -89:2:89;
xi = -179:2:179;

[vt_corr_000,vt_ed_000,t_sd_000,vN_sd_000] = vt_corr_fun_warm('vN_000','t_000');
'000'
[vt_corr_010,vt_ed_010,t_sd_010,vN_sd_010] = vt_corr_fun_warm('vN_010','t_010');
'010'
[vt_corr_025,vt_ed_025,t_sd_025,vN_sd_025] = vt_corr_fun_warm('vN_025','t_025');
'025'
[vt_corr_050,vt_ed_050,t_sd_050,vN_sd_050] = vt_corr_fun_warm('vN_050','t_050');
'050'
[vt_corr_075,vt_ed_075,t_sd_075,vN_sd_075] = vt_corr_fun_warm('vN_075','t_075');
'075'
[vt_corr_100,vt_ed_100,t_sd_100,vN_sd_100] = vt_corr_fun_warm('vN_100','t_100');
'100'


figure
v=-1:0.2:1;
contourf(yi,rC./100,vt_corr_000',v)
colorbar('FontSize',15)
caxis([-1 1])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v-T correlation coefficient, 0es0')
print('-dpng','vtcorr_000.png')

figure
v=-20:4:20;
contourf(yi,rC./100,vt_ed_000',v)
colorbar('FontSize',15)
caxis([-20 20])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''T'', 0es0')
print('-dpng','vt_ed_000.png')

figure
v=0:2:20;
contourf(yi,rC./100,vN_sd_000',v)
colorbar('FontSize',15)
caxis([0 20])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v s.d., 0es0')
print('-dpng','v_sd_000.png')

figure
v=0:1:10;
contourf(yi,rC./100,t_sd_000',v)
colorbar('FontSize',15)
caxis([0 10])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('T s.d., 0es0')
print('-dpng','t_sd_000.png')

figure
v=0:10:100;
contourf(yi,rC./100,t_sd_000'.*vN_sd_000',v)
colorbar('FontSize',15)
caxis([0 100])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v s.d. * T s.d., 0es0')
print('-dpng','vt_sd_000.png')







figure
v=-1:0.2:1;
contourf(yi,rC./100,vt_corr_010',v)
colorbar('FontSize',15)
caxis([-1 1])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v-T correlation coefficient, 0.1es0')
print('-dpng','vtcorr_010.png')

figure
v=-20:4:20;
contourf(yi,rC./100,vt_ed_010',v)
colorbar('FontSize',15)
caxis([-20 20])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''T'', 0.1es0')
print('-dpng','vt_ed_010.png')

figure
v=0:2:20;
contourf(yi,rC./100,vN_sd_010',v)
colorbar('FontSize',15)
caxis([0 20])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v s.d., 0.1es0')
print('-dpng','v_sd_010.png')

figure
v=0:1:10;
contourf(yi,rC./100,t_sd_010',v)
colorbar('FontSize',15)
caxis([0 10])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('T s.d., 0.1es0')
print('-dpng','t_sd_010.png')

figure
v=0:10:100;
contourf(yi,rC./100,t_sd_010'.*vN_sd_010',v)
colorbar('FontSize',15)
caxis([0 100])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v s.d. * T s.d., 0.1es0')
print('-dpng','vt_sd_010.png')









figure
v=-1:0.2:1;
contourf(yi,rC./100,vt_corr_025',v)
colorbar('FontSize',15)
caxis([-1 1])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v-T correlation coefficient, 0.25es0')
print('-dpng','vtcorr_025.png')

figure
v=-20:4:20;
contourf(yi,rC./100,vt_ed_025',v)
colorbar('FontSize',15)
caxis([-20 20])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''T'', 0.25es0')
print('-dpng','vt_ed_025.png')

figure
v=0:2:20;
contourf(yi,rC./100,vN_sd_025',v)
colorbar('FontSize',15)
caxis([0 20])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v s.d., 0.25es0')
print('-dpng','v_sd_025.png')

figure
v=0:1:10;
contourf(yi,rC./100,t_sd_025',v)
colorbar('FontSize',15)
caxis([0 10])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('T s.d., 0.25es0')
print('-dpng','t_sd_025.png')

figure
v=0:10:100;
contourf(yi,rC./100,t_sd_025'.*vN_sd_025',v)
colorbar('FontSize',15)
caxis([0 100])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v s.d. * T s.d., 0.25es0')
print('-dpng','vt_sd_025.png')










figure
v=-1:0.2:1;
contourf(yi,rC./100,vt_corr_050',v)
colorbar('FontSize',15)
caxis([-1 1])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v-T correlation coefficient, 0.5es0')
print('-dpng','vtcorr_050.png')

figure
v=-20:4:20;
contourf(yi,rC./100,vt_ed_050',v)
colorbar('FontSize',15)
caxis([-20 20])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''T'', 0.5es0')
print('-dpng','vt_ed_050.png')

figure
v=0:2:20;
contourf(yi,rC./100,vN_sd_050',v)
colorbar('FontSize',15)
caxis([0 20])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v s.d., 0.5es0')
print('-dpng','v_sd_050.png')

figure
v=0:1:10;
contourf(yi,rC./100,t_sd_050',v)
colorbar('FontSize',15)
caxis([0 10])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('T s.d., 0.5es0')
print('-dpng','t_sd_050.png')

figure
v=0:10:100;
contourf(yi,rC./100,t_sd_050'.*vN_sd_050',v)
colorbar('FontSize',15)
caxis([0 100])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v s.d. * T s.d., 0.5es0')
print('-dpng','vt_sd_050.png')









figure
v=-1:0.2:1;
contourf(yi,rC./100,vt_corr_075',v)
colorbar('FontSize',15)
caxis([-1 1])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v-T correlation coefficient, 0.75es0')
print('-dpng','vtcorr_075.png')

figure
v=-20:4:20;
contourf(yi,rC./100,vt_ed_075',v)
colorbar('FontSize',15)
caxis([-20 20])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''T'', 0.75es0')
print('-dpng','vt_ed_075.png')

figure
v=0:2:20;
contourf(yi,rC./100,vN_sd_075',v)
colorbar('FontSize',15)
caxis([0 20])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v s.d., 0.75es0')
print('-dpng','v_sd_075.png')

figure
v=0:1:10;
contourf(yi,rC./100,t_sd_075',v)
colorbar('FontSize',15)
caxis([0 10])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('T s.d., 0.75es0')
print('-dpng','t_sd_075.png')

figure
v=0:10:100;
contourf(yi,rC./100,t_sd_075'.*vN_sd_075',v)
colorbar('FontSize',15)
caxis([0 100])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v s.d. * T s.d., 0.75es0')
print('-dpng','vt_sd_075.png')











figure
v=-1:0.2:1;
contourf(yi,rC./100,vt_corr_100',v)
colorbar('FontSize',15)
caxis([-1 1])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v-T correlation coefficient, 1es0')
print('-dpng','vtcorr_100.png')

figure
v=-20:4:20;
contourf(yi,rC./100,vt_ed_100',v)
colorbar('FontSize',15)
caxis([-20 20])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v''T'', 1es0')
print('-dpng','vt_ed_100.png')

figure
v=0:2:20;
contourf(yi,rC./100,vN_sd_100',v)
colorbar('FontSize',15)
caxis([0 20])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v s.d., 1es0')
print('-dpng','v_sd_100.png')

figure
v=0:1:10;
contourf(yi,rC./100,t_sd_100',v)
colorbar('FontSize',15)
caxis([0 10])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('T s.d., 1es0')
print('-dpng','t_sd_100.png')

figure
v=0:10:100;
contourf(yi,rC./100,t_sd_100'.*vN_sd_100',v)
colorbar('FontSize',15)
caxis([0 100])
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('v s.d. * T s.d., 1es0')
print('-dpng','vt_sd_100.png')



return
