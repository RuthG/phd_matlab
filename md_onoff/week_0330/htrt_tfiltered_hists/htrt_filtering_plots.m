%load up histograms produced in other files and plot and print nicely

load('/project/rg312/mat_files/htrt_hists_trange_000.mat')


xbins = -33:0.1:8;

figure
h=bar(xbins,htrt_hist_1_pos);
ylim([0 0.4])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with 0<T''<1, K/day')
ylabel('Probability')
print('-dpng','htrt_hist_1pos_000.png')

figure
h=bar(xbins,htrt_hist_2_pos);
ylim([0 0.1])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with 1<T''<2, K/day')
ylabel('Probability')
print('-dpng','htrt_hist_2pos_000.png')

figure
h=bar(xbins,htrt_hist_3_pos);
ylim([0 0.14])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with 2<T''<3, K/day')
ylabel('Probability')
print('-dpng','htrt_hist_3pos_000.png')

figure
h=bar(xbins,htrt_hist_4_pos);
ylim([0 0.14])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with 3<T''<4, K/day')
ylabel('Probability')
print('-dpng','htrt_hist_4pos_000.png')

figure
h=bar(xbins,htrt_hist_5_pos);
ylim([0 0.14])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with 4<T''<5, K/day')
ylabel('Probability')
print('-dpng','htrt_hist_5pos_000.png')



figure
h=bar(xbins,htrt_hist_1_neg);
ylim([0 0.35])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with -1<T''<0, K/day')
ylabel('Probability')
print('-dpng','htrt_hist_1neg_000.png')

figure
h=bar(xbins,htrt_hist_2_neg);
ylim([0 0.07])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with -2<T''<-1, K/day')
ylabel('Probability')
print('-dpng','htrt_hist_2neg_000.png')

figure
h=bar(xbins,htrt_hist_3_neg);
ylim([0 0.05])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with -3<T''<-2, K/day')
ylabel('Probability')
print('-dpng','htrt_hist_3neg_000.png')

figure
h=bar(xbins,htrt_hist_4_neg);
ylim([0 0.05])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with -4<T''<-3, K/day')
ylabel('Probability')
print('-dpng','htrt_hist_4neg_000.png')

figure
h=bar(xbins,htrt_hist_5_neg);
ylim([0 0.03])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with -5<T''<-4, K/day')
ylabel('Probability')
print('-dpng','htrt_hist_5neg_000.png')





load('/project/rg312/mat_files/htrt_hists_trange_100.mat')


xbins = -33:0.1:8;

figure
h=bar(xbins,htrt_hist_1_pos);
ylim([0 0.4])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with 0<T''<1, K/day')
ylabel('Probability')
print('-dpng','htrt_hist_1pos_100.png')

figure
h=bar(xbins,htrt_hist_2_pos);
ylim([0 0.1])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with 1<T''<2, K/day')
ylabel('Probability')
print('-dpng','htrt_hist_2pos_100.png')

figure
h=bar(xbins,htrt_hist_3_pos);
ylim([0 0.14])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with 2<T''<3, K/day')
ylabel('Probability')
print('-dpng','htrt_hist_3pos_100.png')

figure
h=bar(xbins,htrt_hist_4_pos);
ylim([0 0.14])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with 3<T''<4, K/day')
ylabel('Probability')
print('-dpng','htrt_hist_4pos_100.png')

figure
h=bar(xbins,htrt_hist_5_pos);
ylim([0 0.14])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with 4<T''<5, K/day')
ylabel('Probability')
print('-dpng','htrt_hist_5pos_100.png')



figure
h=bar(xbins,htrt_hist_1_neg);
ylim([0 0.35])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with -1<T''<0, K/day')
ylabel('Probability')
print('-dpng','htrt_hist_1neg_100.png')

figure
h=bar(xbins,htrt_hist_2_neg);
ylim([0 0.07])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with -2<T''<-1, K/day')
ylabel('Probability')
print('-dpng','htrt_hist_2neg_100.png')

figure
h=bar(xbins,htrt_hist_3_neg);
ylim([0 0.05])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with -3<T''<-2, K/day')
ylabel('Probability')
print('-dpng','htrt_hist_3neg_100.png')

figure
h=bar(xbins,htrt_hist_4_neg);
ylim([0 0.05])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with -4<T''<-3, K/day')
ylabel('Probability')
print('-dpng','htrt_hist_4neg_100.png')

figure
h=bar(xbins,htrt_hist_5_neg);
ylim([0 0.03])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with -5<T''<-4, K/day')
ylabel('Probability')
print('-dpng','htrt_hist_5neg_100.png')

