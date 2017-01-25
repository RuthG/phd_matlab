load('/project/rg312/mat_files/tottend_advtend_hists_000')

figure
bar(xbins,totttend_hist)
ylim([0 0.35])
xlim([-20 20])
title('0.0 es0, full histogram of heatrates')
xlabel('Total heating, K/day')
ylabel('Probability')
print('-dpng','totttend_000.png')

figure
bar(xbins,advtend_hist)
ylim([0 0.35])
xlim([-20 20])
title('0.0 es0, full histogram of heatrates')
xlabel('Advective heating, K/day')
ylabel('Probability')
print('-dpng','advtend_000.png')


load('/project/rg312/mat_files/tottend_advtend_hists_010')

figure
bar(xbins,totttend_hist)
ylim([0 0.35])
xlim([-20 20])
title('0.1 es0, full histogram of heatrates')
xlabel('Total heating, K/day')
ylabel('Probability')
print('-dpng','totttend_010.png')

figure
bar(xbins,advtend_hist)
ylim([0 0.35])
xlim([-20 20])
title('0.1 es0, full histogram of heatrates')
xlabel('Advective heating, K/day')
ylabel('Probability')
print('-dpng','advtend_010.png')



load('/project/rg312/mat_files/tottend_advtend_hists_025')

figure
bar(xbins,totttend_hist)
ylim([0 0.35])
xlim([-20 20])
title('0.25 es0, full histogram of heatrates')
xlabel('Total heating, K/day')
ylabel('Probability')
print('-dpng','totttend_025.png')

figure
bar(xbins,advtend_hist)
ylim([0 0.35])
xlim([-20 20])
title('0.25 es0, full histogram of heatrates')
xlabel('Advective heating, K/day')
ylabel('Probability')
print('-dpng','advtend_025.png')



load('/project/rg312/mat_files/tottend_advtend_hists_050')

figure
bar(xbins,totttend_hist)
ylim([0 0.35])
xlim([-20 20])
title('0.5 es0, full histogram of heatrates')
xlabel('Total heating, K/day')
ylabel('Probability')
print('-dpng','totttend_050.png')

figure
bar(xbins,advtend_hist)
ylim([0 0.35])
xlim([-20 20])
title('0.5 es0, full histogram of heatrates')
xlabel('Advective heating, K/day')
ylabel('Probability')
print('-dpng','advtend_050.png')



load('/project/rg312/mat_files/tottend_advtend_hists_075')

figure
bar(xbins,totttend_hist)
ylim([0 0.35])
xlim([-20 20])
title('0.75 es0, full histogram of heatrates')
xlabel('Total heating, K/day')
ylabel('Probability')
print('-dpng','totttend_075.png')

figure
bar(xbins,advtend_hist)
ylim([0 0.35])
xlim([-20 20])
title('0.75 es0, full histogram of heatrates')
xlabel('Advective heating, K/day')
ylabel('Probability')
print('-dpng','advtend_075.png')



load('/project/rg312/mat_files/tottend_advtend_hists_100')

figure
bar(xbins,totttend_hist)
ylim([0 0.35])
xlim([-20 20])
title('1.0 es0, full histogram of heatrates')
xlabel('Total heating, K/day')
ylabel('Probability')
print('-dpng','totttend_100.png')

figure
bar(xbins,advtend_hist)
ylim([0 0.35])
xlim([-20 20])
title('1.0 es0, full histogram of heatrates')
xlabel('Advective heating, K/day')
ylabel('Probability')
print('-dpng','advtend_100.png')


