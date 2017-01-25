%load up KE and calculate rhines scale

load('/project/rg312/mat_files/eke_loaded.mat')
load('/project/rg312/mat_files/toulouse_poster/fft_poster.mat')
load('/project/rg312/mat_files/rossby_rad.mat')

vrms_000 = sqrt(eke_000_zav);
vrms_010 = sqrt(eke_010_zav);
vrms_025 = sqrt(eke_025_zav);
vrms_050 = sqrt(eke_050_zav);
vrms_075 = sqrt(eke_075_zav);
vrms_100 = sqrt(eke_100_zav);
vrms_th = sqrt(eke_th_zav);

Ra = 287.04;
g= 9.81;
omega = 2.*pi./24./60./60;
yi = -89:2:90;
radius=6371.0e3;

beta = 2.*omega./radius.*cos(yi.*pi./180);

for i=1:90
lbeta_000_a(i,:) = 2.*pi.*sqrt(vrms_000(i,:)./beta(i));
lbeta_010_a(i,:) = 2.*pi.*sqrt(vrms_010(i,:)./beta(i));
lbeta_025_a(i,:) = 2.*pi.*sqrt(vrms_025(i,:)./beta(i));
lbeta_050_a(i,:) = 2.*pi.*sqrt(vrms_050(i,:)./beta(i));
lbeta_075_a(i,:) = 2.*pi.*sqrt(vrms_075(i,:)./beta(i));
lbeta_100_a(i,:) = 2.*pi.*sqrt(vrms_100(i,:)./beta(i));
lbeta_th_a(i,:) = 2.*pi.*sqrt(vrms_th(i,:)./beta(i));
end

lbeta_000 = mean(lbeta_000_a,2);
lbeta_010 = mean(lbeta_010_a,2);
lbeta_025 = mean(lbeta_025_a,2);
lbeta_050 = mean(lbeta_050_a,2);
lbeta_075 = mean(lbeta_075_a,2);
lbeta_100 = mean(lbeta_100_a,2);
lbeta_th = mean(lbeta_th_a,2);

vrms_000_pav = mean(sqrt(vrms_000),2);
vrms_010_pav = mean(sqrt(vrms_010),2);
vrms_025_pav = mean(sqrt(vrms_025),2);
vrms_050_pav = mean(sqrt(vrms_050),2);
vrms_075_pav = mean(sqrt(vrms_075),2);
vrms_100_pav = mean(sqrt(vrms_100),2);
vrms_th_pav = mean(sqrt(vrms_th),2);


figure
plot(yi(46:90),radius.*cos(yi(46:90).*pi./180).*sqrt(beta(46:90)))
xlabel('Latitude')
ylabel('a sqrt(\beta) cos(\theta)')
title('Geometric factors')
print('-dpng','geometry_facs.png')

figure
plot(yi(46:90),1./beta(46:90))
xlabel('Latitude')
ylabel('1/Beta, m/s')
title('1/Beta')
print('-dpng','beta.png')

figure
plot(yi(46:90),vrms_000(46:90))
hold on
plot(yi(46:90),vrms_010(46:90),'g')
plot(yi(46:90),vrms_025(46:90),'r')
plot(yi(46:90),vrms_050(46:90),'m')
plot(yi(46:90),vrms_075(46:90),'c')
plot(yi(46:90),vrms_100(46:90),'k')
plot(yi(46:90),vrms_th(46:90),'m--')
legend('0es0','0.1es0','0.25es0','0.5es0','0.75es0','1.0es0','tropheat')
xlabel('Latitude')
ylabel('sqrt RMS V, m/s')
title('V rms')
print('-dpng','vrms.png')

kbeta_000 = 2.*pi.*radius.*cos(yi.*pi./180)./lbeta_000';
kbeta_010 = 2.*pi.*radius.*cos(yi.*pi./180)./lbeta_010';
kbeta_025 = 2.*pi.*radius.*cos(yi.*pi./180)./lbeta_025';
kbeta_050 = 2.*pi.*radius.*cos(yi.*pi./180)./lbeta_050';
kbeta_075 = 2.*pi.*radius.*cos(yi.*pi./180)./lbeta_075';
kbeta_100 = 2.*pi.*radius.*cos(yi.*pi./180)./lbeta_100';
kbeta_th = 2.*pi.*radius.*cos(yi.*pi./180)./lbeta_th';


figure
plot(yi(46:90),kbeta_000(46:90))
hold on
plot(yi(46:90),kbeta_010(46:90),'g')
plot(yi(46:90),kbeta_025(46:90),'r')
plot(yi(46:90),kbeta_050(46:90),'m')
plot(yi(46:90),kbeta_075(46:90),'c')
plot(yi(46:90),kbeta_100(46:90),'k')
plot(yi(46:90),kbeta_th(46:90),'m--')
legend('0es0','0.1es0','0.25es0','0.5es0','0.75es0','1.0es0','tropheat')
xlabel('Latitude')
ylabel('Wavenumber')
title('Mean Wavenumber')
print('-dpng','lamda_beta.png')



points=180;
wavenos = [0:points-1]./points.*180;


[a,b]=max(mean(uE_000_zav(46:90,:),2));
y_000 = yi(b+45);
[a,b]=max(mean(uE_010_zav(46:90,:),2));
y_010 = yi(b+45);
[a,b]=max(mean(uE_025_zav(46:90,:),2));
y_025 = yi(b+45);
[a,b]=max(mean(uE_050_zav(46:90,:),2));
y_050 = yi(b+45);
[a,b]=max(mean(uE_075_zav(46:90,:),2));
y_075 = yi(b+45);
[a,b]=max(mean(uE_100_zav(46:90,:),2));
y_100 = yi(b+45);
[a,b]=max(mean(uE_th_zav(46:90,:),2));
y_th = yi(b+45);


figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_000_ss_hzav(1:21,:)',v);
hold on
plot(kbeta_000(46:90),yi(46:90),'Color',[1 1 1],'LineWidth',2)
plot(kd_000(46:90),yi(46:90),'Color',[0 0 0],'LineWidth',2)
plot([0 20],[y_000 y_000],'--','Color',[1 1 1],'LineWidth',2)
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 0.0 Pa')
print('-dpng','fft_000_pavb.png')

figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_010_ss_hzav(1:21,:)',v);
hold on
plot(kbeta_010(46:90),yi(46:90),'Color',[1 1 1],'LineWidth',2)
plot(kd_010(46:90),yi(46:90),'Color',[0 0 0],'LineWidth',2)
plot([0 20],[y_010 y_010],'--','Color',[1 1 1],'LineWidth',2)
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 61.078 Pa')
print('-dpng','fft_010_pavb.png')

figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_025_ss_hzav(1:21,:)',v);
hold on
plot(kbeta_025(46:90),yi(46:90),'Color',[1 1 1],'LineWidth',2)
plot(kd_025(46:90),yi(46:90),'Color',[0 0 0],'LineWidth',2)
plot([0 20],[y_025 y_025],'--','Color',[1 1 1],'LineWidth',2)
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 152.695 Pa')
print('-dpng','fft_025_pavb.png')

figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_050_ss_hzav(1:21,:)',v);
hold on
plot(kbeta_050(46:90),yi(46:90),'Color',[1 1 1],'LineWidth',2)
plot(kd_050(46:90),yi(46:90),'Color',[0 0 0],'LineWidth',2)
plot([0 20],[y_050 y_050],'--','Color',[1 1 1],'LineWidth',2)
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 305.39 Pa')
print('-dpng','fft_050_pavb.png')

figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_075_ss_hzav(1:21,:)',v);
hold on
plot(kbeta_075(46:90),yi(46:90),'Color',[1 1 1],'LineWidth',2)
plot(kd_075(46:90),yi(46:90),'Color',[0 0 0],'LineWidth',2)
plot([0 20],[y_075 y_075],'--','Color',[1 1 1],'LineWidth',2)
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 458.085 Pa')
print('-dpng','fft_075_pavb.png')


figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_100_ss_hzav(1:21,:)',v);
hold on
plot(kbeta_100(46:90),yi(46:90),'Color',[1 1 1],'LineWidth',2)
plot(kd_100(46:90),yi(46:90),'Color',[0 0 0],'LineWidth',2)
plot([0 20],[y_100 y_100],'--','Color',[1 1 1],'LineWidth',2)
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 610.78 Pa')
print('-dpng','fft_100_pavb.png')


figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_th_ss_hzav(1:21,:)',v);
hold on
plot(kbeta_th(46:90),yi(46:90),'Color',[1 1 1],'LineWidth',2)
plot(kd_th(46:90),yi(46:90),'Color',[0 0 0],'LineWidth',2)
plot([0 20],[y_th y_th],'--','Color',[1 1 1],'LineWidth',2)
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 305.39 Pa + tropheat')
print('-dpng','fft_th_pavb.png')


save('/project/rg312/mat_files/rhines_scale.mat','kbeta_000','kbeta_010','kbeta_025','kbeta_050','kbeta_075','kbeta_100','kbeta_th')

save('/project/rg312/mat_files/rhines_scale_plevs.mat','lbeta_000_a','lbeta_010_a','lbeta_025_a','lbeta_050_a','lbeta_075_a','lbeta_100_a','lbeta_th_a')
