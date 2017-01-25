load('/project/rg312/mat_files/t_hists_asym_000.mat')

figure
bar(xbins,t_hist)
ylim([0 0.25])
xlim([-20 20])
title('0.0 es0, full histogram of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_full_000.png')

figure
plot(xbins,t_hist)
set(gca,'YScale','log')
ylim([0 0.25])
xlim([-20 20])
title('0.0 es0, full pdf of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_logscale_000.png')

figure
bar(xbins,t_hist_asym)
ylim([-0.03 0.03])
xlim([-20 20])
title('0.0 es0, asymmetric part of histogram of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_asym_000.png')

figure
bar(xbins,t_hist_sym)
ylim([0 0.25])
xlim([-20 20])
title('0.0 es0, symmetric part of histogram of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_sym_000.png')



load('/project/rg312/mat_files/t_hists_asym_010.mat')

figure
bar(xbins,t_hist)
ylim([0 0.25])
xlim([-20 20])
title('0.1 es0, full histogram of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_full_010.png')

figure
plot(xbins,t_hist)
set(gca,'YScale','log')
ylim([0 25])
xlim([-20 20])
title('0.1 es0, full pdf of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_logscale_010.png')

figure
bar(xbins,t_hist_asym)
ylim([-0.03 0.03])
xlim([-20 20])
title('0.1 es0, asymmetric part of histogram of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_asym_010.png')

figure
bar(xbins,t_hist_sym)
ylim([0 0.25])
xlim([-20 20])
title('0.1 es0, symmetric part of histogram of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_sym_010.png')



load('/project/rg312/mat_files/t_hists_asym_025.mat')

figure
bar(xbins,t_hist)
ylim([0 0.25])
xlim([-20 20])
title('0.25 es0, full histogram of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_full_025.png')

figure
plot(xbins,t_hist)
set(gca,'YScale','log')
ylim([0 25])
xlim([-20 20])
title('0.25 es0, full pdf of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_logscale_025.png')

figure
bar(xbins,t_hist_asym)
ylim([-0.03 0.03])
xlim([-20 20])
title('0.25 es0, asymmetric part of histogram of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_asym_025.png')

figure
bar(xbins,t_hist_sym)
ylim([0 0.25])
xlim([-20 20])
title('0.25 es0, symmetric part of histogram of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_sym_025.png')



load('/project/rg312/mat_files/t_hists_asym_050.mat')

figure
bar(xbins,t_hist)
ylim([0 0.25])
xlim([-20 20])
title('0.5 es0, full histogram of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_full_050.png')

figure
plot(xbins,t_hist)
set(gca,'YScale','log')
ylim([0 25])
xlim([-20 20])
title('0.5 es0, full pdf of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_logscale_050.png')

figure
bar(xbins,t_hist_asym)
ylim([-0.03 0.03])
xlim([-20 20])
title('0.5 es0, asymmetric part of histogram of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_asym_050.png')

figure
bar(xbins,t_hist_sym)
ylim([0 0.25])
xlim([-20 20])
title('0.5 es0, symmetric part of histogram of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_sym_050.png')



load('/project/rg312/mat_files/t_hists_asym_075.mat')

figure
bar(xbins,t_hist)
ylim([0 0.25])
xlim([-20 20])
title('0.75 es0, full histogram of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_full_075.png')

figure
plot(xbins,t_hist)
set(gca,'YScale','log')
ylim([0 25])
xlim([-20 20])
title('0.75 es0, full pdf of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_logscale_075.png')

figure
bar(xbins,t_hist_asym)
ylim([-0.03 0.03])
xlim([-20 20])
title('0.75 es0, asymmetric part of histogram of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_asym_075.png')

figure
bar(xbins,t_hist_sym)
ylim([0 0.25])
xlim([-20 20])
title('0.75 es0, symmetric part of histogram of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_sym_075.png')



load('/project/rg312/mat_files/t_hists_asym_100.mat')

figure
bar(xbins,t_hist)
ylim([0 0.25])
xlim([-20 20])
title('1.0 es0, full histogram of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_full_100.png')

figure
plot(xbins,t_hist)
set(gca,'YScale','log')
ylim([0 25])
xlim([-20 20])
title('1.0 es0, full pdf of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_logscale_100.png')

figure
bar(xbins,t_hist_asym)
ylim([-0.03 0.03])
xlim([-20 20])
title('1.0 es0, asymmetric part of histogram of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_asym_100.png')

figure
bar(xbins,t_hist_sym)
ylim([0 0.25])
xlim([-20 20])
title('1.0 es0, symmetric part of histogram of temperature anomalies')
xlabel('T'', K')
ylabel('Probability')
print('-dpng','t_sym_100.png')
