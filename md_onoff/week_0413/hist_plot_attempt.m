%try playing with transparencies on bar plots so we can have a plot with the -4 to -3 diabatic heating range on for both dry and wet case overlaid


load('/project/rg312/mat_files/htrt_hists_trange_000.mat')
htrt_hist_4_pos_000 = htrt_hist_4_pos;
htrt_hist_4_neg_000 = htrt_hist_4_neg;


load('/project/rg312/mat_files/htrt_hists_trange_100.mat')
htrt_hist_4_pos_100 = htrt_hist_4_pos;
htrt_hist_4_neg_100 = htrt_hist_4_neg;


load('/project/rg312/mat_files/htrtmc_hists_trange_100.mat')
htrtmc_hist_4_pos_100 = htrtmc_hist_4_pos;
htrtmc_hist_4_neg_100 = htrtmc_hist_4_neg;


load('/project/rg312/mat_files/cnvpdif_hists_trange_000.mat')
cnvdifht_hist_4_pos_000 = cnvdifht_hist_4_pos;
cnvdifht_hist_4_neg_000 = cnvdifht_hist_4_neg;

load('/project/rg312/mat_files/cnvpdif_hists_trange_100.mat')
cnvdifht_hist_4_pos_100 = cnvdifht_hist_4_pos;
cnvdifht_hist_4_neg_100 = cnvdifht_hist_4_neg;

figure
h_000=bar(xbins,htrt_hist_4_pos_000,'r');
hold on;
h_100=bar(xbins,htrt_hist_4_pos_100);
alpha(get(h_000,'children'),.5);
alpha(get(h_100,'children'),.5);
set(h_000,'EdgeColor','none')
ylim([0 0.15])
xlim([-15 15])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with 3<T''<4, K/day')
ylabel('Probability')
title('Diabatic heating associated with positive T'' in the dry and wet models')
legend('Dry','Wet')
print('-dpng','htrt_hist_pos_plot.png')


figure
h_000=bar(xbins,htrt_hist_4_neg_000,'r');
hold on;
h_100=bar(xbins,htrt_hist_4_neg_100);
alpha(get(h_000,'children'),.5);
alpha(get(h_100,'children'),.5);
set(h_000,'EdgeColor','none')
ylim([0 0.15])
xlim([-15 15])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with -4<T''<-3, K/day')
ylabel('Probability')
title('Diabatic heating associated with negative T'' in the dry and wet models')
legend('Dry','Wet')
print('-dpng','htrt_hist_neg_plot.png')




figure
h_000=bar(xbins,cnvdifht_hist_4_pos_000,'r');
hold on;
h_100=bar(xbins,cnvdifht_hist_4_pos_100);
alpha(get(h_000,'children'),.5);
alpha(get(h_100,'children'),.5);
set(h_000,'EdgeColor','none')
ylim([0 0.15])
xlim([-15 15])
set(gca,'FontSize',15);
xlabel('Convective + diffusive  heating associated with 3<T''<4, K/day')
ylabel('Probability')
title('Convective + diffusive heating associated with positive T'' in the dry and wet models')
legend('Dry','Wet')
print('-dpng','cnvdifht_hist_pos_plot.png')


figure
h_000=bar(xbins,cnvdifht_hist_4_neg_000,'r');
hold on;
h_100=bar(xbins,cnvdifht_hist_4_neg_100);
alpha(get(h_000,'children'),.5);
alpha(get(h_100,'children'),.5);
set(h_000,'EdgeColor','none')
ylim([0 0.15])
xlim([-15 15])
set(gca,'FontSize',15);
xlabel('Convective + diffusive heating associated with -4<T''<-3, K/day')
ylabel('Probability')
title('Convective + diffusive heating associated with negative T'' in the dry and wet models')
legend('Dry','Wet')
print('-dpng','cnvdifht_hist_neg_plot.png')












return
figure
h_000=bar(xbins,htrt_hist_4_pos_000,'r');
hold on;
h_100=bar(xbins,htrtmc_hist_4_pos_100);
alpha(get(h_000,'children'),.5);
alpha(get(h_100,'children'),.5);
set(h_000,'EdgeColor','none')
ylim([0 0.15])
xlim([-15 15])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with 3<T''<4, K/day')
ylabel('Probability')
title('Diabatic heating associated with positive T'' in the dry and wet models')
legend('Dry','Wet')
print('-dpng','htrtmc_hist_pos_plot.png')
