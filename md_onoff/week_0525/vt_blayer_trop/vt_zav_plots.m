%load in v't' and overplot with boundary layer and tropopause estimates on top

load('/project/rg312/mat_files/climatology_vars_best.mat')
load('/project/rg312/mat_files/tropopause_offline.mat')
load('/project/rg312/mat_files/blayer_offline.mat')
load('/project/rg312/mat_files/vt_lats_best.mat');

vt_ed_000 = vNt_000_zav-vN_000_zav.*t_000_zav;
vt_ed_010 = vNt_010_zav-vN_010_zav.*t_010_zav;
vt_ed_025 = vNt_025_zav-vN_025_zav.*t_025_zav;
vt_ed_050 = vNt_050_zav-vN_050_zav.*t_050_zav;
vt_ed_075 = vNt_075_zav-vN_075_zav.*t_075_zav;
vt_ed_100 = vNt_100_zav-vN_100_zav.*t_100_zav;

blayer_000 = squeeze(mean(blayer_lev_000_ll,1));
blayer_010 = squeeze(mean(blayer_lev_010_ll,1));
blayer_025 = squeeze(mean(blayer_lev_025_ll,1));
blayer_050 = squeeze(mean(blayer_lev_050_ll,1));
blayer_075 = squeeze(mean(blayer_lev_075_ll,1));
blayer_100 = squeeze(mean(blayer_lev_100_ll,1));

trop_p_000(1) = NaN; trop_p_000(90)=NaN;
trop_p_010(1) = NaN; trop_p_010(90)=NaN;
trop_p_025(1) = NaN; trop_p_025(90)=NaN;
trop_p_050(1) = NaN; trop_p_050(90)=NaN;
trop_p_075(1) = NaN; trop_p_075(90)=NaN;
trop_p_100(1) = NaN; trop_p_100(90)=NaN;

for i=1:45

vt_ed_000_hav(i,:) = (-vt_ed_000(46-i,:) + vt_ed_000(45+i,:))./2;
vt_ed_010_hav(i,:) = (-vt_ed_010(46-i,:) + vt_ed_010(45+i,:))./2;
vt_ed_025_hav(i,:) = (-vt_ed_025(46-i,:) + vt_ed_025(45+i,:))./2;
vt_ed_050_hav(i,:) = (-vt_ed_050(46-i,:) + vt_ed_050(45+i,:))./2;
vt_ed_075_hav(i,:) = (-vt_ed_075(46-i,:) + vt_ed_075(45+i,:))./2;
vt_ed_100_hav(i,:) = (-vt_ed_100(46-i,:) + vt_ed_100(45+i,:))./2;

trop_p_000_hav(i) = (trop_p_000(46-i) + trop_p_000(45+i))./200;
trop_p_010_hav(i) = (trop_p_010(46-i) + trop_p_010(45+i))./200;
trop_p_025_hav(i) = (trop_p_025(46-i) + trop_p_025(45+i))./200;
trop_p_050_hav(i) = (trop_p_050(46-i) + trop_p_050(45+i))./200;
trop_p_075_hav(i) = (trop_p_075(46-i) + trop_p_075(45+i))./200;
trop_p_100_hav(i) = (trop_p_100(46-i) + trop_p_100(45+i))./200;

blayer_000_hav(i) = (blayer_000(46-i) + blayer_000(45+i))./200;
blayer_010_hav(i) = (blayer_010(46-i) + blayer_010(45+i))./200;
blayer_025_hav(i) = (blayer_025(46-i) + blayer_025(45+i))./200;
blayer_050_hav(i) = (blayer_050(46-i) + blayer_050(45+i))./200;
blayer_075_hav(i) = (blayer_075(46-i) + blayer_075(45+i))./200;
blayer_100_hav(i) = (blayer_100(46-i) + blayer_100(45+i))./200;

end

v=-5:2.5:20;
rC = 980:-40:20;

figure
contourf(yi(46:90),rC,vt_ed_000_hav',v);
hold on
colorbar
caxis([-5 20])
plot(yi(46:90),blayer_000_hav,'k','LineWidth',2)
plot(yi(46:90),trop_p_000_hav,'k','LineWidth',2)
plot([yi(x000n) yi(x000n)],[0 1000],'k','LineWidth',2)
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'', K m/s, 0.0es0')
print('-dpng','vt_blayertrop_000.png')

figure
contourf(yi(46:90),rC,vt_ed_010_hav',v);
hold on
colorbar
caxis([-5 20])
plot(yi(46:90),blayer_010_hav,'k','LineWidth',2)
plot(yi(46:90),trop_p_010_hav,'k','LineWidth',2)
plot([yi(x010n) yi(x010n)],[0 1000],'k','LineWidth',2)
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'', K m/s, 0.1es0')
print('-dpng','vt_blayertrop_010.png')



figure
contourf(yi(46:90),rC,vt_ed_025_hav',v);
hold on
colorbar
caxis([-5 20])
plot(yi(46:90),blayer_025_hav,'k','LineWidth',2)
plot(yi(46:90),trop_p_025_hav,'k','LineWidth',2)
plot([yi(x025n) yi(x025n)],[0 1000],'k','LineWidth',2)
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'', K m/s, 0.25es0')
print('-dpng','vt_blayertrop_025.png')



figure
contourf(yi(46:90),rC,vt_ed_050_hav',v);
hold on
colorbar
caxis([-5 20])
plot(yi(46:90),blayer_050_hav,'k','LineWidth',2)
plot(yi(46:90),trop_p_050_hav,'k','LineWidth',2)
plot([yi(x050n) yi(x050n)],[0 1000],'k','LineWidth',2)
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'', K m/s, 0.5es0')
print('-dpng','vt_blayertrop_050.png')



figure
contourf(yi(46:90),rC,vt_ed_075_hav',v);
hold on
colorbar
caxis([-5 20])
plot(yi(46:90),blayer_075_hav,'k','LineWidth',2)
plot(yi(46:90),trop_p_075_hav,'k','LineWidth',2)
plot([yi(x075n) yi(x075n)],[0 1000],'k','LineWidth',2)
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'', K m/s, 0.75es0')
print('-dpng','vt_blayertrop_075.png')



figure
contourf(yi(46:90),rC,vt_ed_100_hav',v);
hold on
colorbar
caxis([-5 20])
plot(yi(46:90),blayer_100_hav,'k','LineWidth',2)
plot(yi(46:90),trop_p_100_hav,'k','LineWidth',2)
plot([yi(x100n) yi(x100n)],[0 1000],'k','LineWidth',2)
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title('v''T'', K m/s, 1.0es0')
print('-dpng','vt_blayertrop_100.png')




