load('/project/rg312/mat_files/heatbudg_100.mat')


figure
h=bar(-25:0.5:15,total_ed_ttend_hist);
ylim([0 0.6])
set(gca,'FontSize',15);
xlabel('Total T tendency calc, K/day')
ylabel('Probability')
print('-dpng','ttend_hist_100.png')

figure
h=bar(-33:0.5:14,htrt_hist);
ylim([0 0.5]);
set(gca,'FontSize',15);
xlabel('Total diabatic heating, K/day')
ylabel('Probability')
print('-dpng','htrt_hist_100.png')

figure
h=bar(-13:0.13:13,udtheta_ed_hist);
ylim([0 0.6])
set(gca,'FontSize',15);
xlabel('<u>d\Theta''/dx, K/day')
ylabel('Probability')
print('-dpng','udthetapdx_hist_100.png')

figure
h=bar(-13:0.13:13,v_ed_dthetady_hist);
ylim([0 0.35])
set(gca,'FontSize',15);
xlabel('v''d\Theta/dy, K/day')
ylabel('Probability')
print('-dpng','vpdthetady_hist_100.png')

figure
h=bar(-20:0.2:20,w_ed_dthetadp_hist);
ylim([0 0.5])
set(gca,'FontSize',15);
xlabel('w''d\Theta/dp, K/day')
ylabel('Probability')
print('-dpng','wpdthetadp_hist_100.png')


return
for i=1:90
%include lat weighting too
i
xbins = -20:0.2:20;
total_adv_heat_counts = hist(reshape(total_adv_heat,[numel(total_adv_heat),1]),xbins);
total_adv_heat_counts_cos(i,:) = total_adv_heat_counts.*cos(yi(i).*pi./180);

xbins = -20:0.2:20;
w_ed_dthetadp_counts = hist(reshape(w_ed_dthetadp_100,[numel(w_ed_dthetadp_100),1]),xbins);
w_ed_dthetadp_counts_cos(i,:) = w_ed_dthetadp_counts.*cos(yi(i).*pi./180);

end

total_adv_heat_hist = sum(total_adv_heat_counts_cos,1)./sum(sum(total_adv_heat_counts_cos));
w_ed_dthetadp_hist = sum(w_ed_dthetadp_counts_cos,1)./sum(sum(w_ed_dthetadp_counts_cos));

save('/project/rg312/mat_files/heatbudg_100.mat','w_ed_dthetadp_hist','-append')

figure
h=bar(-20:0.2:20,total_adv_heat_hist);
ylim([0 0.4])
set(gca,'FontSize',15);
xlabel('Total of advective heating terms, K/day')
ylabel('Probability')
print('-dpng','total_adv_heat_hist_100.png')
