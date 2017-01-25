%load in data generated for v'T' plot and plot up...


[vNph_ed(1), vNph_ed_warm(1), vNph_ed_cold(1), vNph_ed_serr(1), vNph_ed_warm_serr(1), vNph_ed_cold_serr(1)] = vgz_paper_plot_fun_freetrop_final('000');

'000 done'

[vNph_ed(2), vNph_ed_warm(2), vNph_ed_cold(2), vNph_ed_serr(2), vNph_ed_warm_serr(2), vNph_ed_cold_serr(2)] = vgz_paper_plot_fun_freetrop_final('010');

'010 done'

[vNph_ed(3), vNph_ed_warm(3), vNph_ed_cold(3), vNph_ed_serr(3), vNph_ed_warm_serr(3), vNph_ed_cold_serr(3)] = vgz_paper_plot_fun_freetrop_final('025');

'025 done'

[vNph_ed(4), vNph_ed_warm(4), vNph_ed_cold(4), vNph_ed_serr(4), vNph_ed_warm_serr(4), vNph_ed_cold_serr(4)] = vgz_paper_plot_fun_freetrop_final('050');

'050 done'

[vNph_ed(5), vNph_ed_warm(5), vNph_ed_cold(5), vNph_ed_serr(5), vNph_ed_warm_serr(5), vNph_ed_cold_serr(5)] = vgz_paper_plot_fun_freetrop_final('075');

'075 done'

[vNph_ed(6), vNph_ed_warm(6), vNph_ed_cold(6), vNph_ed_serr(6), vNph_ed_warm_serr(6), vNph_ed_cold_serr(6)] = vgz_paper_plot_fun_freetrop_final('100');

'100 done'

[vNph_ed(7), vNph_ed_warm(7), vNph_ed_cold(7), vNph_ed_serr(7), vNph_ed_warm_serr(7), vNph_ed_cold_serr(7)] = vgz_paper_plot_fun_freetrop_final('125');

'125 done'


[vNph_ed(8), vNph_ed_warm(8), vNph_ed_cold(8), vNph_ed_serr(8), vNph_ed_warm_serr(8), vNph_ed_cold_serr(8)] = vgz_paper_plot_fun_freetrop_final('150');

'150 done'

save('/project/rg312/mat_files/vNph_paper_plot_data_freetrop_final.mat')


es0 = [0,0.1,0.25,0.5,0.75,1,1.25,1.5];

filles0 = [es0, fliplr(es0)];
fillerrors = [vNph_ed+2.*vNph_ed_serr, fliplr(vNph_ed-2.*vNph_ed_serr)];

fillerrors_warm = [vNph_ed_warm+2.*vNph_ed_warm_serr, fliplr(vNph_ed_warm -2.*vNph_ed_warm_serr)];
fillerrors_cold = [vNph_ed_cold+2.*vNph_ed_cold_serr, fliplr(vNph_ed_cold -2.*vNph_ed_cold_serr)];

figure
plot(es0,vNph_ed,'k','Linewidth',2);
hold on
plot(es0,vNph_ed_warm,'r','Linewidth',2);
plot(es0,vNph_ed_cold,'b','Linewidth',2);
fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)
hold off
ylim([-700 500])
set(gca,'FontSize',15);
xlabel('Reference e_{s0} fraction')
ylabel('Zonal mean pressure averaged v''\Phi'', Wm/kg ')
legend('Total','+ve T''','-ve T''','Location','northwest')
print('-depsc2','-r300','vgz_paper_plot_freetrop_final.eps')




