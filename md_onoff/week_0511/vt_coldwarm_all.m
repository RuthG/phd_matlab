%load in data generated for v'T' plot and plot up...


%[vt_ed_tzav_000,vt_ed_tzav_neg_000,vt_ed_tzav_pos_000]=vt_coldwarm_ratio_fun('000');

'000 done'

%[vt_ed_tzav_010,vt_ed_tzav_neg_010,vt_ed_tzav_pos_010]=vt_coldwarm_ratio_fun('010');

'010 done'

%[vt_ed_tzav_025,vt_ed_tzav_neg_025,vt_ed_tzav_pos_025]=vt_coldwarm_ratio_fun('025');

'025 done'

%[vt_ed_tzav_050,vt_ed_tzav_neg_050,vt_ed_tzav_pos_050]=vt_coldwarm_ratio_fun('050');

'050 done'

%[vt_ed_tzav_075,vt_ed_tzav_neg_075,vt_ed_tzav_pos_075]=vt_coldwarm_ratio_fun('075');

'075 done'

%[vt_ed_tzav_100,vt_ed_tzav_neg_100,vt_ed_tzav_pos_100]=vt_coldwarm_ratio_fun('100');

'100 done'

%[vt_ed_tzav_125,vt_ed_tzav_neg_125,vt_ed_tzav_pos_125]=vt_coldwarm_ratio_fun('125');

'125 done'

%[vt_ed_tzav_150,vt_ed_tzav_neg_150,vt_ed_tzav_pos_150]=vt_coldwarm_ratio_fun('150');

'150 done'

load('/project/rg312/mat_files/vNt_coldwarm_data.mat')

rC=980:-40:20;


figure
plot(vt_ed_tzav_neg_000+vt_ed_tzav_pos_000,rC,'k','Linewidth',2);
hold on
plot(vt_ed_tzav_neg_010+vt_ed_tzav_pos_010,rC,'r','Linewidth',2);
plot(vt_ed_tzav_neg_025+vt_ed_tzav_pos_025,rC,'b','Linewidth',2);
plot(vt_ed_tzav_neg_050+vt_ed_tzav_pos_050,rC,'g','Linewidth',2);
plot(vt_ed_tzav_neg_075+vt_ed_tzav_pos_075,rC,'m','Linewidth',2);
plot(vt_ed_tzav_neg_100+vt_ed_tzav_pos_100,rC,'c','Linewidth',2);
plot(vt_ed_tzav_neg_125+vt_ed_tzav_pos_125,rC,'y','Linewidth',2);
plot(vt_ed_tzav_neg_150+vt_ed_tzav_pos_150,rC,'k--','Linewidth',2);
hold off
set(gca,'FontSize',15);
set(gca,'YDir','reverse');
xlabel('Zonal mean v''T''')
ylabel('Pressure, hPa')
print('-dpng','vt_height.png')


return

figure
plot(vt_ed_tzav_neg_000./vt_ed_tzav_pos_000,rC,'k','Linewidth',2);
hold on
plot(vt_ed_tzav_neg_010./vt_ed_tzav_pos_010,rC,'r','Linewidth',2);
plot(vt_ed_tzav_neg_025./vt_ed_tzav_pos_025,rC,'b','Linewidth',2);
plot(vt_ed_tzav_neg_050./vt_ed_tzav_pos_050,rC,'g','Linewidth',2);
plot(vt_ed_tzav_neg_075./vt_ed_tzav_pos_075,rC,'m','Linewidth',2);
plot(vt_ed_tzav_neg_100./vt_ed_tzav_pos_100,rC,'c','Linewidth',2);
plot(vt_ed_tzav_neg_125./vt_ed_tzav_pos_125,rC,'y','Linewidth',2);
plot(vt_ed_tzav_neg_150./vt_ed_tzav_pos_150,rC,'k--','Linewidth',2);
hold off
set(gca,'FontSize',15);
set(gca,'YDir','reverse');
xlabel('Zonal mean v''T''')
ylabel('Pressure, hPa')
print('-dpng','vt_coldvswarm.png')


figure
plot(vt_ed_tzav_neg_000,rC,'k','Linewidth',2);
hold on
plot(vt_ed_tzav_neg_010,rC,'r','Linewidth',2);
plot(vt_ed_tzav_neg_025,rC,'b','Linewidth',2);
plot(vt_ed_tzav_neg_050,rC,'g','Linewidth',2);
plot(vt_ed_tzav_neg_075,rC,'m','Linewidth',2);
plot(vt_ed_tzav_neg_100,rC,'c','Linewidth',2);
plot(vt_ed_tzav_neg_125,rC,'y','Linewidth',2);
plot(vt_ed_tzav_neg_150,rC,'k--','Linewidth',2);
hold off
set(gca,'FontSize',15);
set(gca,'YDir','reverse');
xlabel('Zonal mean v''T''')
ylabel('Pressure, hPa')
print('-dpng','vt_cold.png')



figure
plot(vt_ed_tzav_pos_000,rC,'k','Linewidth',2);
hold on
plot(vt_ed_tzav_pos_010,rC,'r','Linewidth',2);
plot(vt_ed_tzav_pos_025,rC,'b','Linewidth',2);
plot(vt_ed_tzav_pos_050,rC,'g','Linewidth',2);
plot(vt_ed_tzav_pos_075,rC,'m','Linewidth',2);
plot(vt_ed_tzav_pos_100,rC,'c','Linewidth',2);
plot(vt_ed_tzav_pos_125,rC,'y','Linewidth',2);
plot(vt_ed_tzav_pos_150,rC,'k--','Linewidth',2);
hold off
set(gca,'FontSize',15);
set(gca,'YDir','reverse');
xlabel('Zonal mean v''T''')
ylabel('Pressure, hPa')
print('-dpng','vt_warm.png')


