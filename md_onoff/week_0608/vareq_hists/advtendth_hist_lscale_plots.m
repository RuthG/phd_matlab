
tick = [1e-7; 1e-5; 1e-3; 1e-1; 1];
test=num2str(tick);

xbins=-700:5:700;

[advtendth_hist_000, totttendth_hist_000] = advtendth_hist_latrange_fun('000');

advtendth_hist_000 = advtendth_hist_000.*10.^7;
totttendth_hist_000 = totttendth_hist_000.*10.^7;

bar(xbins, advtendth_hist_000)
xlim([-700 700])
ylim([1 1e7]);
set(gca,'Yscale','log')
set(gca,'YTickLabel',test)
set(gca,'FontSize',15)
xlabel('Q_{a}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.0 e_{s0}','FontSize',15)
print('-dpng','advtendth_hist_lscale_000.png')

bar(xbins, totttendth_hist_000)
xlim([-700 700])
ylim([1 1e7]);
set(gca,'Yscale','log')
set(gca,'YTickLabel',test)
set(gca,'FontSize',15)
xlabel('Q_{t}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.0 e_{s0}','FontSize',15)
print('-dpng','totttendth_hist_lscale_000.png')



[advtendth_hist_010, totttendth_hist_010] = advtendth_hist_latrange_fun('010');

advtendth_hist_010 = advtendth_hist_010.*10.^7;
totttendth_hist_010 = totttendth_hist_010.*10.^7;

bar(xbins, advtendth_hist_010)
xlim([-700 700])
ylim([1 1e7]);
set(gca,'Yscale','log')
set(gca,'YTickLabel',test)
set(gca,'FontSize',15)
xlabel('Q_{a}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.1 e_{s0}','FontSize',15)
print('-dpng','advtendth_hist_lscale_010.png')

bar(xbins, totttendth_hist_010)
xlim([-700 700])
ylim([1 1e7]);
set(gca,'Yscale','log')
set(gca,'YTickLabel',test)
set(gca,'FontSize',15)
xlabel('Q_{t}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.1 e_{s0}','FontSize',15)
print('-dpng','totttendth_hist_lscale_010.png')



[advtendth_hist_025, totttendth_hist_025] = advtendth_hist_latrange_fun('025');

advtendth_hist_025 = advtendth_hist_025.*10.^7;
totttendth_hist_025 = totttendth_hist_025.*10.^7;

bar(xbins, advtendth_hist_025)
xlim([-700 700])
ylim([1 1e7]);
set(gca,'Yscale','log')
set(gca,'YTickLabel',test)
set(gca,'FontSize',15)
xlabel('Q_{a}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.25 e_{s0}','FontSize',15)
print('-dpng','advtendth_hist_lscale_025.png')

bar(xbins, totttendth_hist_025)
xlim([-700 700])
ylim([1 1e7]);
set(gca,'Yscale','log')
set(gca,'YTickLabel',test)
set(gca,'FontSize',15)
xlabel('Q_{t}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.25 e_{s0}','FontSize',15)
print('-dpng','totttendth_hist_lscale_025.png')



[advtendth_hist_050, totttendth_hist_050] = advtendth_hist_latrange_fun('050');

advtendth_hist_050 = advtendth_hist_050.*10.^7;
totttendth_hist_050 = totttendth_hist_050.*10.^7;

bar(xbins, advtendth_hist_050)
xlim([-700 700])
ylim([1 1e7]);
set(gca,'Yscale','log')
set(gca,'YTickLabel',test)
set(gca,'FontSize',15)
xlabel('Q_{a}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.5 e_{s0}','FontSize',15)
print('-dpng','advtendth_hist_lscale_050.png')

bar(xbins, totttendth_hist_050)
xlim([-700 700])
ylim([1 1e7]);
set(gca,'Yscale','log')
set(gca,'YTickLabel',test)
set(gca,'FontSize',15)
xlabel('Q_{t}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.5 e_{s0}','FontSize',15)
print('-dpng','totttendth_hist_lscale_050.png')




[advtendth_hist_075, totttendth_hist_075] = advtendth_hist_latrange_fun('075');

advtendth_hist_075 = advtendth_hist_075.*10.^7;
totttendth_hist_075 = totttendth_hist_075.*10.^7;

bar(xbins, advtendth_hist_075)
xlim([-700 700])
ylim([1 1e7]);
set(gca,'Yscale','log')
set(gca,'YTickLabel',test)
set(gca,'FontSize',15)
xlabel('Q_{a}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.75 e_{s0}','FontSize',15)
print('-dpng','advtendth_hist_lscale_075.png')


bar(xbins, totttendth_hist_075)
xlim([-700 700])
ylim([1 1e7]);
set(gca,'Yscale','log')
set(gca,'YTickLabel',test)
set(gca,'FontSize',15)
xlabel('Q_{t}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('0.75 e_{s0}','FontSize',15)
print('-dpng','totttendth_hist_lscale_075.png')




[advtendth_hist_100, totttendth_hist_100] = advtendth_hist_latrange_fun('100');

advtendth_hist_100 = advtendth_hist_100.*10.^7;
totttendth_hist_100 = totttendth_hist_100.*10.^7;

bar(xbins, advtendth_hist_100)
xlim([-700 700])
ylim([1 1e7]);
set(gca,'Yscale','log')
set(gca,'YTickLabel',test)
set(gca,'FontSize',15)
xlabel('Q_{a}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('1.0 e_{s0}','FontSize',15)
print('-dpng','advtendth_hist_lscale_100.png')

bar(xbins, totttendth_hist_100)
xlim([-700 700])
ylim([1 1e7]);
set(gca,'Yscale','log')
set(gca,'YTickLabel',test)
set(gca,'FontSize',15)
xlabel('Q_{t}''\Theta''','FontSize',15)
ylabel('Probability','FontSize',15)
title('1.0 e_{s0}','FontSize',15)
print('-dpng','totttendth_hist_lscale_100.png')




