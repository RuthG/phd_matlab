%load in data generated for v'T' plot and plot up...


[tt_ed(1), tt_ed_warm(1), tt_ed_cold(1), tt_ed_serr(1), tt_ed_warm_serr(1), tt_ed_cold_serr(1)] = tt_paper_plot_fun_trop_final('000');

'000 done'

[tt_ed(2), tt_ed_warm(2), tt_ed_cold(2), tt_ed_serr(2), tt_ed_warm_serr(2), tt_ed_cold_serr(2)] = tt_paper_plot_fun_trop_final('010');

'010 done'

[tt_ed(3), tt_ed_warm(3), tt_ed_cold(3), tt_ed_serr(3), tt_ed_warm_serr(3), tt_ed_cold_serr(3)] = tt_paper_plot_fun_trop_final('025');

'025 done'

[tt_ed(4), tt_ed_warm(4), tt_ed_cold(4), tt_ed_serr(4), tt_ed_warm_serr(4), tt_ed_cold_serr(4)] = tt_paper_plot_fun_trop_final('050');

'050 done'

[tt_ed(5), tt_ed_warm(5), tt_ed_cold(5), tt_ed_serr(5), tt_ed_warm_serr(5), tt_ed_cold_serr(5)] = tt_paper_plot_fun_trop_final('075');

'075 done'

[tt_ed(6), tt_ed_warm(6), tt_ed_cold(6), tt_ed_serr(6), tt_ed_warm_serr(6), tt_ed_cold_serr(6)] = tt_paper_plot_fun_trop_final('100');

'100 done'

[tt_ed(7), tt_ed_warm(7), tt_ed_cold(7), tt_ed_serr(7), tt_ed_warm_serr(7), tt_ed_cold_serr(7)] = tt_paper_plot_fun_trop_final('125');

'125 done'

[tt_ed(8), tt_ed_warm(8), tt_ed_cold(8), tt_ed_serr(8), tt_ed_warm_serr(8), tt_ed_cold_serr(8)] = tt_paper_plot_fun_trop_final('150');

'150 done'


save('/project/rg312/mat_files/tt_paper_plot_data_trop_final.mat')


es0 = [0,0.1,0.25,0.5,0.75,1,1.25,1.5];

filles0 = [es0, fliplr(es0)];
fillerrors = [tt_ed+2.*tt_ed_serr, fliplr(tt_ed-2.*tt_ed_serr)];

fillerrors_warm = [tt_ed_warm+2.*tt_ed_warm_serr, fliplr(tt_ed_warm -2.*tt_ed_warm_serr)];
fillerrors_cold = [tt_ed_cold+2.*tt_ed_cold_serr, fliplr(tt_ed_cold -2.*tt_ed_cold_serr)];

figure
plot(es0,tt_ed,'k','Linewidth',2);
hold on
plot(es0,tt_ed_warm,'r','Linewidth',2);
plot(es0,tt_ed_cold,'b','Linewidth',2);
fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)
hold off
ylim([0 18])
set(gca,'FontSize',15);
xlabel('Reference e_{s0} fraction')
ylabel('Zonal mean pressure averaged T'' variance, K^{2}m/s ')
legend('Total','+ve T''','-ve T''','Location','northwest')
print('-depsc2','-r300','tt_paper_plot_trop_final.eps')




