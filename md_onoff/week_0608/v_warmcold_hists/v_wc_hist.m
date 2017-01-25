
xbins=-70:0.5:70;

for lev=1:25
lev
[vN_hist_warm_000,vN_hist_cold_000] = v_wc_hist_fun('000',lev);
[vN_hist_warm_100,vN_hist_cold_100] = v_wc_hist_fun('100',lev);

figure
h_000=bar(xbins,vN_hist_warm_000,'r');
hold on;
h_100=bar(xbins,vN_hist_warm_100);
alpha(get(h_000,'children'),.5);
alpha(get(h_100,'children'),.25);
set(h_000,'EdgeColor','none')
ylim([0 0.12])
xlim([-70 70])
set(gca,'FontSize',15);
xlabel('v'' associated with warm sector, m/s')
ylabel('Probability')
title('v'' associated with positive T'' in the dry and wet models')
dryleg = ['Dry'];
wetleg = ['Wet'];
legend(dryleg, wetleg)
name=['v_hist_warm' num2str(lev) '.png'];
print('-dpng',name)



figure
h_000=bar(xbins,vN_hist_cold_000,'r');
hold on;
h_100=bar(xbins,vN_hist_cold_100);
alpha(get(h_000,'children'),.5);
alpha(get(h_100,'children'),.25);
set(h_000,'EdgeColor','none')
ylim([0 0.12])
xlim([-70 70])
set(gca,'FontSize',15);
xlabel('v'' associated with cold sector, m/s')
ylabel('Probability')
title('v'' associated with negative T'' in the dry and wet models')
dryleg = ['Dry'];
wetleg = ['Wet'];
legend(dryleg, wetleg)
name=['v_hist_cold' num2str(lev) '.png'];
print('-dpng',name)

close all

end
