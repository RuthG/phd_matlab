

xbins=-700:5:700;

htrtth_hist_000 = htrtth_hist_latrange_fun('000');

bar(xbins, htrtth_hist_000)
set(gca,'FontSize',15)
xlabel('Q_{d}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.0 e_{s0}','FontSize',15)
print('-dpng','htrtth_hist_latrange_000.png')


htrtth_hist_010 = htrtth_hist_latrange_fun('010');

bar(xbins, htrtth_hist_010)
set(gca,'FontSize',15)
xlabel('Q_{d}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.1 e_{s0}','FontSize',15)
print('-dpng','htrtth_hist_latrange_010.png')

htrtth_hist_025 = htrtth_hist_latrange_fun('025');

bar(xbins, htrtth_hist_025)
set(gca,'FontSize',15)
xlabel('Q_{d}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.25 e_{s0}','FontSize',15)
print('-dpng','htrtth_hist_latrange_025.png')


htrtth_hist_050 = htrtth_hist_latrange_fun('050');

bar(xbins, htrtth_hist_050)
set(gca,'FontSize',15)
xlabel('Q_{d}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.5 e_{s0}','FontSize',15)
print('-dpng','htrtth_hist_latrange_050.png')


htrtth_hist_075 = htrtth_hist_latrange_fun('075');

bar(xbins, htrtth_hist_075)
set(gca,'FontSize',15)
xlabel('Q_{d}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.75 e_{s0}','FontSize',15)
print('-dpng','htrtth_hist_latrange_075.png')


htrtth_hist_100 = htrtth_hist_latrange_fun('100');

bar(xbins, htrtth_hist_100)
set(gca,'FontSize',15)
xlabel('Q_{d}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('1.0 e_{s0}','FontSize',15)
print('-dpng','htrtth_hist_latrange_100.png')
