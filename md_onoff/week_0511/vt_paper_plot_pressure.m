load('/project/rg312/mat_files/vNt_coldwarm_data.mat')

es0 = [0, 0.1, 0.25, 0.5, 0.75, 1, 1.25, 1.5];

vt_vals_neg(1,:) = vt_ed_tzav_neg_000;
vt_vals_neg(2,:) = vt_ed_tzav_neg_010;
vt_vals_neg(3,:) = vt_ed_tzav_neg_025;
vt_vals_neg(4,:) = vt_ed_tzav_neg_050;
vt_vals_neg(5,:) = vt_ed_tzav_neg_075;
vt_vals_neg(6,:) = vt_ed_tzav_neg_100;
vt_vals_neg(7,:) = vt_ed_tzav_neg_125;
vt_vals_neg(8,:) = vt_ed_tzav_neg_150;

vt_vals_pos(1,:) = vt_ed_tzav_pos_000;
vt_vals_pos(2,:) = vt_ed_tzav_pos_010;
vt_vals_pos(3,:) = vt_ed_tzav_pos_025;
vt_vals_pos(4,:) = vt_ed_tzav_pos_050;
vt_vals_pos(5,:) = vt_ed_tzav_pos_075;
vt_vals_pos(6,:) = vt_ed_tzav_pos_100;
vt_vals_pos(7,:) = vt_ed_tzav_pos_125;
vt_vals_pos(8,:) = vt_ed_tzav_pos_150;

vt_vals(1,:) = vt_ed_tzav_000;
vt_vals(2,:) = vt_ed_tzav_010;
vt_vals(3,:) = vt_ed_tzav_025;
vt_vals(4,:) = vt_ed_tzav_050;
vt_vals(5,:) = vt_ed_tzav_075;
vt_vals(6,:) = vt_ed_tzav_100;
vt_vals(7,:) = vt_ed_tzav_125;
vt_vals(8,:) = vt_ed_tzav_150;

rC=980:-40:20;

for i=1:25

figure
plot(es0,vt_vals_neg(:,i),'b','Linewidth',2)
hold on
plot(es0,vt_vals_pos(:,i),'r','Linewidth',2)
plot(es0,vt_vals(:,i),'k','Linewidth',2)
set(gca,'FontSize',15);
ylim([0 20])
xlabel('Reference es_0 fraction')
ylabel('Zonal mean v''T'' Km/s')
title([num2str(rC(i)) ' hPa'])
name = ['vt_plot_l' num2str(i) '.png'];
print('-dpng',name)

end

