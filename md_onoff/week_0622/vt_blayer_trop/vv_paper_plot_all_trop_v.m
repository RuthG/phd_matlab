%load in data generated for v'T' plot and plot up...


[vv_ed(1), vv_ed_warm(1), vv_ed_cold(1), vv_ed_serr(1), vv_ed_warm_serr(1), vv_ed_cold_serr(1)] = vv_paper_plot_fun_trop_final_v('000');

'000 done'

[vv_ed(2), vv_ed_warm(2), vv_ed_cold(2), vv_ed_serr(2), vv_ed_warm_serr(2), vv_ed_cold_serr(2)] = vv_paper_plot_fun_trop_final_v('010');

'010 done'

[vv_ed(3), vv_ed_warm(3), vv_ed_cold(3), vv_ed_serr(3), vv_ed_warm_serr(3), vv_ed_cold_serr(3)] = vv_paper_plot_fun_trop_final_v('025');

'025 done'

[vv_ed(4), vv_ed_warm(4), vv_ed_cold(4), vv_ed_serr(4), vv_ed_warm_serr(4), vv_ed_cold_serr(4)] = vv_paper_plot_fun_trop_final_v('050');

'050 done'

[vv_ed(5), vv_ed_warm(5), vv_ed_cold(5), vv_ed_serr(5), vv_ed_warm_serr(5), vv_ed_cold_serr(5)] = vv_paper_plot_fun_trop_final_v('075');

'075 done'

[vv_ed(6), vv_ed_warm(6), vv_ed_cold(6), vv_ed_serr(6), vv_ed_warm_serr(6), vv_ed_cold_serr(6)] = vv_paper_plot_fun_trop_final_v('100');

'100 done'

[vv_ed(7), vv_ed_warm(7), vv_ed_cold(7), vv_ed_serr(7), vv_ed_warm_serr(7), vv_ed_cold_serr(7)] = vv_paper_plot_fun_trop_final_v('125');

'125 done'

[vv_ed(8), vv_ed_warm(8), vv_ed_cold(8), vv_ed_serr(8), vv_ed_warm_serr(8), vv_ed_cold_serr(8)] = vv_paper_plot_fun_trop_final_v('150');

'150 done'

save('/project/rg312/mat_files/vv_paper_plot_data_trop_final_v.mat')


es0 = [0,0.1,0.25,0.5,0.75,1,1.25,1.5];

filles0 = [es0, fliplr(es0)];
fillerrors = [vv_ed+2.*vv_ed_serr, fliplr(vv_ed-2.*vv_ed_serr)];

fillerrors_warm = [vv_ed_warm+2.*vv_ed_warm_serr, fliplr(vv_ed_warm -2.*vv_ed_warm_serr)];
fillerrors_cold = [vv_ed_cold+2.*vv_ed_cold_serr, fliplr(vv_ed_cold -2.*vv_ed_cold_serr)];

figure
plot(es0,vv_ed,'k','Linewidth',2);
hold on
plot(es0,vv_ed_warm,'r','Linewidth',2);
plot(es0,vv_ed_cold,'b','Linewidth',2);
fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)
hold off
ylim([0 18])
set(gca,'FontSize',15);
xlabel('Reference e_{s0} fraction')
ylabel('Zonal mean pressure averaged T'' variance, (m/s)^2 ')
legend('Total','+ve T''','-ve T''','Location','northwest')
print('-depsc2','-r300','vv_paper_plot_trop_final_v.eps')




