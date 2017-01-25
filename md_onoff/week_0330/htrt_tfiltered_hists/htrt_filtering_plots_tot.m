%load up histograms produced in other files and plot and print nicely

load('/project/rg312/mat_files/htrt_adv_hists_trange_100_tot.mat')


xbins = -33:0.1:33;

figure
h=bar(xbins,totttend_ed_1_pos);
ylim([0 0.4])
set(gca,'FontSize',15);
xlabel('Total heating associated with 0<T''<1, K/day')
ylabel('Probability')
print('-dpng','totttend_ed_1pos_100.png')

figure
h=bar(xbins,totttend_ed_2_pos);
ylim([0 0.1])
set(gca,'FontSize',15);
xlabel('Total heating associated with 1<T''<2, K/day')
ylabel('Probability')
print('-dpng','totttend_ed_2pos_100.png')

figure
h=bar(xbins,totttend_ed_3_pos);
ylim([0 0.14])
set(gca,'FontSize',15);
xlabel('Total heating associated with 2<T''<3, K/day')
ylabel('Probability')
print('-dpng','totttend_ed_3pos_100.png')

figure
h=bar(xbins,totttend_ed_4_pos);
ylim([0 0.14])
set(gca,'FontSize',15);
xlabel('Total heating associated with 3<T''<4, K/day')
ylabel('Probability')
print('-dpng','totttend_ed_4pos_100.png')

figure
h=bar(xbins,totttend_ed_5_pos);
ylim([0 0.14])
set(gca,'FontSize',15);
xlabel('Total heating associated with 4<T''<5, K/day')
ylabel('Probability')
print('-dpng','totttend_ed_5pos_100.png')



figure
h=bar(xbins,totttend_ed_1_neg);
ylim([0 0.35])
set(gca,'FontSize',15);
xlabel('Total heating associated with -1<T''<0, K/day')
ylabel('Probability')
print('-dpng','totttend_ed_1neg_100.png')

figure
h=bar(xbins,totttend_ed_2_neg);
ylim([0 0.07])
set(gca,'FontSize',15);
xlabel('Total heating associated with -2<T''<-1, K/day')
ylabel('Probability')
print('-dpng','totttend_ed_2neg_100.png')

figure
h=bar(xbins,totttend_ed_3_neg);
ylim([0 0.05])
set(gca,'FontSize',15);
xlabel('Total heating associated with -3<T''<-2, K/day')
ylabel('Probability')
print('-dpng','totttend_ed_3neg_100.png')

figure
h=bar(xbins,totttend_ed_4_neg);
ylim([0 0.05])
set(gca,'FontSize',15);
xlabel('Total heating associated with -4<T''<-3, K/day')
ylabel('Probability')
print('-dpng','totttend_ed_4neg_100.png')

figure
h=bar(xbins,totttend_ed_5_neg);
ylim([0 0.03])
set(gca,'FontSize',15);
xlabel('Total heating associated with -5<T''<-4, K/day')
ylabel('Probability')
print('-dpng','totttend_ed_5neg_100.png')







figure
h=bar(xbins,advtend_ed_1_pos);
ylim([0 0.4])
set(gca,'FontSize',15);
xlabel('Total heating associated with 0<T''<1, K/day')
ylabel('Probability')
print('-dpng','advtend_ed_1pos_100.png')

figure
h=bar(xbins,advtend_ed_2_pos);
ylim([0 0.1])
set(gca,'FontSize',15);
xlabel('Total heating associated with 1<T''<2, K/day')
ylabel('Probability')
print('-dpng','advtend_ed_2pos_100.png')

figure
h=bar(xbins,advtend_ed_3_pos);
ylim([0 0.14])
set(gca,'FontSize',15);
xlabel('Total heating associated with 2<T''<3, K/day')
ylabel('Probability')
print('-dpng','advtend_ed_3pos_100.png')

figure
h=bar(xbins,advtend_ed_4_pos);
ylim([0 0.14])
set(gca,'FontSize',15);
xlabel('Total heating associated with 3<T''<4, K/day')
ylabel('Probability')
print('-dpng','advtend_ed_4pos_100.png')

figure
h=bar(xbins,advtend_ed_5_pos);
ylim([0 0.14])
set(gca,'FontSize',15);
xlabel('Total heating associated with 4<T''<5, K/day')
ylabel('Probability')
print('-dpng','advtend_ed_5pos_100.png')



figure
h=bar(xbins,advtend_ed_1_neg);
ylim([0 0.35])
set(gca,'FontSize',15);
xlabel('Total heating associated with -1<T''<0, K/day')
ylabel('Probability')
print('-dpng','advtend_ed_1neg_100.png')

figure
h=bar(xbins,advtend_ed_2_neg);
ylim([0 0.07])
set(gca,'FontSize',15);
xlabel('Total heating associated with -2<T''<-1, K/day')
ylabel('Probability')
print('-dpng','advtend_ed_2neg_100.png')

figure
h=bar(xbins,advtend_ed_3_neg);
ylim([0 0.05])
set(gca,'FontSize',15);
xlabel('Total heating associated with -3<T''<-2, K/day')
ylabel('Probability')
print('-dpng','advtend_ed_3neg_100.png')

figure
h=bar(xbins,advtend_ed_4_neg);
ylim([0 0.05])
set(gca,'FontSize',15);
xlabel('Total heating associated with -4<T''<-3, K/day')
ylabel('Probability')
print('-dpng','advtend_ed_4neg_100.png')

figure
h=bar(xbins,advtend_ed_5_neg);
ylim([0 0.03])
set(gca,'FontSize',15);
xlabel('Total heating associated with -5<T''<-4, K/day')
ylabel('Probability')
print('-dpng','advtend_ed_5neg_100.png')




