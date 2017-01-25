%load in data generated for v'T' plot and plot up...


[vNt_ed(1), vNt_ed_warm(1), vNt_ed_cold(1), vNt_ed_serr(1), vNt_ed_warm_serr(1), vNt_ed_cold_serr(1)] = vt_paper_plot_fun_blayer_final('000');

'000 done'

[vNt_ed(2), vNt_ed_warm(2), vNt_ed_cold(2), vNt_ed_serr(2), vNt_ed_warm_serr(2), vNt_ed_cold_serr(2)] = vt_paper_plot_fun_blayer_final('010');

'010 done'

[vNt_ed(3), vNt_ed_warm(3), vNt_ed_cold(3), vNt_ed_serr(3), vNt_ed_warm_serr(3), vNt_ed_cold_serr(3)] = vt_paper_plot_fun_blayer_final('025');

'025 done'

[vNt_ed(4), vNt_ed_warm(4), vNt_ed_cold(4), vNt_ed_serr(4), vNt_ed_warm_serr(4), vNt_ed_cold_serr(4)] = vt_paper_plot_fun_blayer_final('050');

'050 done'

[vNt_ed(5), vNt_ed_warm(5), vNt_ed_cold(5), vNt_ed_serr(5), vNt_ed_warm_serr(5), vNt_ed_cold_serr(5)] = vt_paper_plot_fun_blayer_final('075');

'075 done'

[vNt_ed(6), vNt_ed_warm(6), vNt_ed_cold(6), vNt_ed_serr(6), vNt_ed_warm_serr(6), vNt_ed_cold_serr(6)] = vt_paper_plot_fun_blayer_final('100');

'100 done'

[vNt_ed(7), vNt_ed_warm(7), vNt_ed_cold(7), vNt_ed_serr(7), vNt_ed_warm_serr(7), vNt_ed_cold_serr(7)] = vt_paper_plot_fun_blayer_final('125');

'125 done'


[vNt_ed(8), vNt_ed_warm(8), vNt_ed_cold(8), vNt_ed_serr(8), vNt_ed_warm_serr(8), vNt_ed_cold_serr(8)] = vt_paper_plot_fun_blayer_final('150');

'150 done'

save('/project/rg312/mat_files/vNt_paper_plot_data_blayer_final.mat')


es0 = [0,0.1,0.25,0.5,0.75,1,1.25,1.5];

filles0 = [es0, fliplr(es0)];
fillerrors = [vNt_ed+2.*vNt_ed_serr, fliplr(vNt_ed-2.*vNt_ed_serr)];

fillerrors_warm = [vNt_ed_warm+2.*vNt_ed_warm_serr, fliplr(vNt_ed_warm -2.*vNt_ed_warm_serr)];
fillerrors_cold = [vNt_ed_cold+2.*vNt_ed_cold_serr, fliplr(vNt_ed_cold -2.*vNt_ed_cold_serr)];

figure
plot(es0,vNt_ed,'k','Linewidth',2);
hold on
plot(es0,vNt_ed_warm,'r','Linewidth',2);
plot(es0,vNt_ed_cold,'b','Linewidth',2);
fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)
hold off
ylim([2 16])
set(gca,'FontSize',15);
xlabel('Reference e_{s0} fraction')
ylabel('Zonal mean pressure averaged v''T'', Km/s ')
legend('Total','+ve T''','-ve T''','Location','northwest')
print('-depsc2','-r300','vt_paper_plot_blayer_final.eps')




