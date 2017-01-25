

xbins=-700:5:700;

[advtendth_hist_000, totttendth_hist_000] = advtendth_hist_latrange_fun('000');

bar(xbins, advtendth_hist_000)
set(gca,'FontSize',15)
xlabel('Q_{a}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.0 e_{s0}','FontSize',15)
print('-dpng','advtendth_hist_latrange_000.png')

bar(xbins, totttendth_hist_000)
set(gca,'FontSize',15)
xlabel('Q_{t}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.0 e_{s0}','FontSize',15)
print('-dpng','totttendth_hist_latrange_000.png')



[advtendth_hist_010, totttendth_hist_010] = advtendth_hist_latrange_fun('010');

bar(xbins, advtendth_hist_010)
set(gca,'FontSize',15)
xlabel('Q_{a}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.1 e_{s0}','FontSize',15)
print('-dpng','advtendth_hist_latrange_010.png')

bar(xbins, totttendth_hist_010)
set(gca,'FontSize',15)
xlabel('Q_{t}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.1 e_{s0}','FontSize',15)
print('-dpng','totttendth_hist_latrange_010.png')



[advtendth_hist_025, totttendth_hist_025] = advtendth_hist_latrange_fun('025');

bar(xbins, advtendth_hist_025)
set(gca,'FontSize',15)
xlabel('Q_{a}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.25 e_{s0}','FontSize',15)
print('-dpng','advtendth_hist_latrange_025.png')

bar(xbins, totttendth_hist_025)
set(gca,'FontSize',15)
xlabel('Q_{t}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.25 e_{s0}','FontSize',15)
print('-dpng','totttendth_hist_latrange_025.png')



[advtendth_hist_050, totttendth_hist_050] = advtendth_hist_latrange_fun('050');

bar(xbins, advtendth_hist_050)
set(gca,'FontSize',15)
xlabel('Q_{a}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.5 e_{s0}','FontSize',15)
print('-dpng','advtendth_hist_latrange_050.png')

bar(xbins, totttendth_hist_050)
set(gca,'FontSize',15)
xlabel('Q_{t}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.5 e_{s0}','FontSize',15)
print('-dpng','totttendth_hist_latrange_050.png')




[advtendth_hist_075, totttendth_hist_075] = advtendth_hist_latrange_fun('075');

bar(xbins, advtendth_hist_075)
set(gca,'FontSize',15)
xlabel('Q_{a}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.75 e_{s0}','FontSize',15)
print('-dpng','advtendth_hist_latrange_075.png')


bar(xbins, totttendth_hist_075)
set(gca,'FontSize',15)
xlabel('Q_{t}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.75 e_{s0}','FontSize',15)
print('-dpng','totttendth_hist_latrange_075.png')




[advtendth_hist_100, totttendth_hist_100] = advtendth_hist_latrange_fun('100');

bar(xbins, advtendth_hist_100)
set(gca,'FontSize',15)
xlabel('Q_{a}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('1.0 e_{s0}','FontSize',15)
print('-dpng','advtendth_hist_latrange_100.png')

bar(xbins, totttendth_hist_100)
set(gca,'FontSize',15)
xlabel('Q_{t}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('1.0 e_{s0}','FontSize',15)
print('-dpng','totttendth_hist_latrange_100.png')




