load('/project/rg312/mat_files/htrt_hists_asym_000.mat')

figure
bar(xbins,htrt_hist)
ylim([0 0.35])
xlim([-20 20])
title('0.0 es0, full histogram of heatrates')
xlabel('Diabatic heatrate, K/day')
ylabel('Probability')
print('-dpng','htrt_full_000.png')

figure
plot(xbins,htrt_hist)
set(gca,'YScale','log')
ylim([0 0.35])
xlim([-45 45])
title('0.0 es0, full pdf of heatrates')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','htrt_logscale_000.png')

figure
bar(xbins,htrt_hist_asym)
ylim([-0.04 0.04])
xlim([-20 20])
title('0.0 es0, asymmetric part of histogram of heatrates')
xlabel('Diabatic heatrate, K/day')
ylabel('Probability')
print('-dpng','htrt_asym_000.png')

figure
bar(xbins,htrt_hist_sym)
ylim([0 0.35])
xlim([-20 20])
title('0.0 es0, symmetric part of histogram of heatrates')
xlabel('Diabatic heatrate, K/day')
ylabel('Probability')
print('-dpng','htrt_sym_000.png')



load('/project/rg312/mat_files/htrt_hists_asym_010.mat')

figure
bar(xbins,htrt_hist)
ylim([0 0.35])
xlim([-20 20])
title('0.1 es0, full histogram of heatrates')
xlabel('Diabatic heatrate, K/day')
ylabel('Probability')
print('-dpng','htrt_full_010.png')

figure
plot(xbins,htrt_hist)
set(gca,'YScale','log')
ylim([0 0.35])
xlim([-45 45])
title('0.1 es0, full pdf of heatrates')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','htrt_logscale_010.png')

figure
bar(xbins,htrt_hist_asym)
ylim([-0.04 0.04])
xlim([-20 20])
title('0.1 es0, asymmetric part of histogram of heatrates')
xlabel('Diabatic heatrate, K/day')
ylabel('Probability')
print('-dpng','htrt_asym_010.png')

figure
bar(xbins,htrt_hist_sym)
ylim([0 0.35])
xlim([-20 20])
title('0.1 es0, symmetric part of histogram of heatrates')
xlabel('Diabatic heatrate, K/day')
ylabel('Probability')
print('-dpng','htrt_sym_010.png')



load('/project/rg312/mat_files/htrt_hists_asym_025.mat')

figure
bar(xbins,htrt_hist)
ylim([0 0.35])
xlim([-20 20])
title('0.25 es0, full histogram of heatrates')
xlabel('Diabatic heatrate, K/day')
ylabel('Probability')
print('-dpng','htrt_full_025.png')

figure
plot(xbins,htrt_hist)
set(gca,'YScale','log')
ylim([0 0.35])
xlim([-45 45])
title('0.25 es0, full pdf of heatrates')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','htrt_logscale_025.png')

figure
bar(xbins,htrt_hist_asym)
ylim([-0.04 0.04])
xlim([-20 20])
title('0.25 es0, asymmetric part of histogram of heatrates')
xlabel('Diabatic heatrate, K/day')
ylabel('Probability')
print('-dpng','htrt_asym_025.png')

figure
bar(xbins,htrt_hist_sym)
ylim([0 0.35])
xlim([-20 20])
title('0.25 es0, symmetric part of histogram of heatrates')
xlabel('Diabatic heatrate, K/day')
ylabel('Probability')
print('-dpng','htrt_sym_025.png')



load('/project/rg312/mat_files/htrt_hists_asym_050.mat')

figure
bar(xbins,htrt_hist)
ylim([0 0.35])
xlim([-20 20])
title('0.5 es0, full histogram of heatrates')
xlabel('Diabatic heatrate, K/day')
ylabel('Probability')
print('-dpng','htrt_full_050.png')

figure
plot(xbins,htrt_hist)
set(gca,'YScale','log')
ylim([0 0.35])
xlim([-45 45])
title('0.5 es0, full pdf of heatrates')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','htrt_logscale_050.png')

figure
bar(xbins,htrt_hist_asym)
ylim([-0.04 0.04])
xlim([-20 20])
title('0.5 es0, asymmetric part of histogram of heatrates')
xlabel('Diabatic heatrate, K/day')
ylabel('Probability')
print('-dpng','htrt_asym_050.png')

figure
bar(xbins,htrt_hist_sym)
ylim([0 0.35])
xlim([-20 20])
title('0.5 es0, symmetric part of histogram of heatrates')
xlabel('Diabatic heatrate, K/day')
ylabel('Probability')
print('-dpng','htrt_sym_050.png')



load('/project/rg312/mat_files/htrt_hists_asym_075.mat')

figure
bar(xbins,htrt_hist)
ylim([0 0.35])
xlim([-20 20])
title('0.75 es0, full histogram of heatrates')
xlabel('Diabatic heatrate, K/day')
ylabel('Probability')
print('-dpng','htrt_full_075.png')

figure
plot(xbins,htrt_hist)
set(gca,'YScale','log')
ylim([0 0.35])
xlim([-45 45])
title('0.75 es0, full pdf of heatrates')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','htrt_logscale_075.png')

figure
bar(xbins,htrt_hist_asym)
ylim([-0.04 0.04])
xlim([-20 20])
title('0.75 es0, asymmetric part of histogram of heatrates')
xlabel('Diabatic heatrate, K/day')
ylabel('Probability')
print('-dpng','htrt_asym_075.png')

figure
bar(xbins,htrt_hist_sym)
ylim([0 0.35])
xlim([-20 20])
title('0.75 es0, symmetric part of histogram of heatrates')
xlabel('Diabatic heatrate, K/day')
ylabel('Probability')
print('-dpng','htrt_sym_075.png')



load('/project/rg312/mat_files/htrt_hists_asym_100.mat')

figure
bar(xbins,htrt_hist)
ylim([0 0.35])
xlim([-20 20])
title('1.0 es0, full histogram of heatrates')
xlabel('Diabatic heatrate, K/day')
ylabel('Probability')
print('-dpng','htrt_full_100.png')

figure
plot(xbins,htrt_hist)
set(gca,'YScale','log')
ylim([0 0.35])
xlim([-45 45])
title('1.0 es0, full pdf of heatrates')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','htrt_logscale_100.png')

figure
bar(xbins,htrt_hist_asym)
ylim([-0.04 0.04])
xlim([-20 20])
title('1.0 es0, asymmetric part of histogram of heatrates')
xlabel('Diabatic heatrate, K/day')
ylabel('Probability')
print('-dpng','htrt_asym_100.png')

figure
bar(xbins,htrt_hist_sym)
ylim([0 0.35])
xlim([-20 20])
title('1.0 es0, symmetric part of histogram of heatrates')
xlabel('Diabatic heatrate, K/day')
ylabel('Probability')
print('-dpng','htrt_sym_100.png')
