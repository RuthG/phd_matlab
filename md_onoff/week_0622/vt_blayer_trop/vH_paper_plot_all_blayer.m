%load in data generated for v'T' plot and plot up...


[vNH_ed(1), vNH_ed_warm(1), vNH_ed_cold(1), vNH_ed_serr(1), vNH_ed_warm_serr(1), vNH_ed_cold_serr(1)] = vH_paper_plot_fun_blayer_final('000');

'000 done'

[vNH_ed(2), vNH_ed_warm(2), vNH_ed_cold(2), vNH_ed_serr(2), vNH_ed_warm_serr(2), vNH_ed_cold_serr(2)] = vH_paper_plot_fun_blayer_final('010');

'010 done'

[vNH_ed(3), vNH_ed_warm(3), vNH_ed_cold(3), vNH_ed_serr(3), vNH_ed_warm_serr(3), vNH_ed_cold_serr(3)] = vH_paper_plot_fun_blayer_final('025');

'025 done'

[vNH_ed(4), vNH_ed_warm(4), vNH_ed_cold(4), vNH_ed_serr(4), vNH_ed_warm_serr(4), vNH_ed_cold_serr(4)] = vH_paper_plot_fun_blayer_final('050');

'050 done'

[vNH_ed(5), vNH_ed_warm(5), vNH_ed_cold(5), vNH_ed_serr(5), vNH_ed_warm_serr(5), vNH_ed_cold_serr(5)] = vH_paper_plot_fun_blayer_final('075');

'075 done'

[vNH_ed(6), vNH_ed_warm(6), vNH_ed_cold(6), vNH_ed_serr(6), vNH_ed_warm_serr(6), vNH_ed_cold_serr(6)] = vH_paper_plot_fun_blayer_final('100');

'100 done'

[vNH_ed(7), vNH_ed_warm(7), vNH_ed_cold(7), vNH_ed_serr(7), vNH_ed_warm_serr(7), vNH_ed_cold_serr(7)] = vH_paper_plot_fun_blayer_final('125');

'125 done'

[vNH_ed(8), vNH_ed_warm(8), vNH_ed_cold(8), vNH_ed_serr(8), vNH_ed_warm_serr(8), vNH_ed_cold_serr(8)] = vH_paper_plot_fun_blayer_final('150');

'150 done'

save('/project/rg312/mat_files/vNH_paper_plot_data_blayer_final.mat')


es0 = [0,0.1,0.25,0.5,0.75,1,1.25,1.5];

filles0 = [es0, fliplr(es0)];
fillerrors = [vNH_ed+2.*vNH_ed_serr, fliplr(vNH_ed-2.*vNH_ed_serr)];

fillerrors_warm = [vNH_ed_warm+2.*vNH_ed_warm_serr, fliplr(vNH_ed_warm -2.*vNH_ed_warm_serr)];
fillerrors_cold = [vNH_ed_cold+2.*vNH_ed_cold_serr, fliplr(vNH_ed_cold -2.*vNH_ed_cold_serr)];

figure
plot(es0,vNH_ed,'k','Linewidth',2);
hold on
plot(es0,vNH_ed_warm,'r','Linewidth',2);
plot(es0,vNH_ed_cold,'b','Linewidth',2);
fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)
hold off
ylim([0.2e4 2.2e4])
set(gca,'FontSize',15);
xlabel('Reference e_{s0} fraction')
ylabel('Zonal mean pressure averaged v''H'', Wm/kg ')
legend('Total','+ve T''','-ve T''','Location','northwest')
print('-depsc2','-r300','vH_paper_plot_blayer_final.eps')




