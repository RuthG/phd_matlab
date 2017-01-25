%load in v'T' and v' and T', calculate the correlation for the wet run
%recalculate v'T' for each using this fixed correlation 

load('/project/rg312/mat_files/vt_corr_vals_cold.mat');

vt_000_mag = t_sd_000 .*vN_sd_000;
vt_010_mag = t_sd_010 .*vN_sd_010;
vt_025_mag = t_sd_025 .*vN_sd_025;
vt_050_mag = t_sd_050 .*vN_sd_050;
vt_075_mag = t_sd_075 .*vN_sd_075;
vt_100_mag = t_sd_100 .*vN_sd_100;

load('/project/rg312/mat_files/vt_lats_best.mat');
load('/project/rg312/mat_files/blayer_trop_levs.mat');


t_sd(:,1) = t_sd_000(x000n,:);
t_sd(:,2) = t_sd_010(x010n,:);
t_sd(:,3) = t_sd_025(x025n,:);
t_sd(:,4) = t_sd_050(x050n,:);
t_sd(:,5) = t_sd_075(x075n,:);
t_sd(:,6) = t_sd_100(x100n,:);

v_sd(:,1) = vN_sd_000(x000n,:);
v_sd(:,2) = vN_sd_010(x010n,:);
v_sd(:,3) = vN_sd_025(x025n,:);
v_sd(:,4) = vN_sd_050(x050n,:);
v_sd(:,5) = vN_sd_075(x075n,:);
v_sd(:,6) = vN_sd_100(x100n,:);

vt_mag(:,1) = vt_000_mag(x000n,:);
vt_mag(:,2) = vt_010_mag(x010n,:);
vt_mag(:,3) = vt_025_mag(x025n,:);
vt_mag(:,4) = vt_050_mag(x050n,:);
vt_mag(:,5) = vt_075_mag(x075n,:);
vt_mag(:,6) = vt_100_mag(x100n,:);


vt_corr(:,1) = vt_corr_000(x000n,:);
vt_corr(:,2) = vt_corr_010(x010n,:);
vt_corr(:,3) = vt_corr_025(x025n,:);
vt_corr(:,4) = vt_corr_050(x050n,:);
vt_corr(:,5) = vt_corr_075(x075n,:);
vt_corr(:,6) = vt_corr_100(x100n,:);

rC=980:-40:20;

blayer(1) = rC(b_lev_000(x000n));
blayer(2) = rC(b_lev_010(x010n));
blayer(3) = rC(b_lev_025(x025n));
blayer(4) = rC(b_lev_050(x050n));
blayer(5) = rC(b_lev_075(x075n));
blayer(6) = rC(b_lev_100(x100n));

es0 = [0,0.1,0.25,0.5,0.75,1];

v=0:0.1:1;
[C,h] = contourf(es0,rC,vt_corr,v);
hold on
plot(es0,blayer,'k','Linewidth',2);
colorbar
caxis([0 1])
set(gca,'YDir','reverse');
xlabel('Saturation vapour pressure fraction')
ylabel('Pressure, hPa')
print('-dpng','vt_corr_es0_cold.png')

figure
v=0:5:70;
[C,h] = contourf(es0,rC,vt_mag,v);
colorbar
hold on
caxis([0 70])
plot(es0,blayer,'k','Linewidth',2);
set(gca,'YDir','reverse');
xlabel('Saturation vapour pressure fraction')
ylabel('Pressure, hPa')
print('-dpng','vt_mag_es0_cold.png')


figure
v=0.5:0.25:4.5;
[C,h] = contourf(es0,rC,t_sd,v);
colorbar
hold on
caxis([0.5 4.5])
plot(es0,blayer,'k','Linewidth',2);
set(gca,'YDir','reverse');
xlabel('Saturation vapour pressure fraction')
ylabel('Pressure, hPa')
print('-dpng','t_sd_es0_cold.png')



figure
v=0:1:16;
[C,h] = contourf(es0,rC,v_sd,v);
colorbar
hold on
caxis([0 16])
plot(es0,blayer,'k','Linewidth',2);
set(gca,'YDir','reverse');
xlabel('Saturation vapour pressure fraction')
ylabel('Pressure, hPa')
print('-dpng','v_sd_es0_cold.png')


figure
v=0:1:18;
[C,h] = contourf(es0,rC,vt_mag.*vt_corr,v);
colorbar
hold on
caxis([0 18])
plot(es0,blayer,'k','Linewidth',2);
set(gca,'YDir','reverse');
xlabel('Saturation vapour pressure fraction')
ylabel('Pressure, hPa')
print('-dpng','vt_es0_cold.png')




return

vt_000_fc = vt_corr_100 .* t_sd_000 .*vN_sd_000;

vt_010_fc = vt_corr_100 .* t_sd_010 .*vN_sd_010;

vt_025_fc = vt_corr_100 .* t_sd_025 .*vN_sd_025;

vt_050_fc = vt_corr_100 .* t_sd_050 .*vN_sd_050;

vt_075_fc = vt_corr_100 .* t_sd_075 .*vN_sd_075;

vt_100_fc = vt_corr_100 .* t_sd_100 .*vN_sd_100;


vt_000_fm = vt_corr_000 .* t_sd_100 .*vN_sd_100;

vt_010_fm = vt_corr_010 .* t_sd_100 .*vN_sd_100;

vt_025_fm = vt_corr_025 .* t_sd_100 .*vN_sd_100;

vt_050_fm = vt_corr_050 .* t_sd_100 .*vN_sd_100;

vt_075_fm = vt_corr_075 .* t_sd_100 .*vN_sd_100;

vt_100_fm = vt_corr_100 .* t_sd_100 .*vN_sd_100;

