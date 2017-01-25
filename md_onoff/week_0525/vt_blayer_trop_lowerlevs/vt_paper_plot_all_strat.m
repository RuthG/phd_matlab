%load in data generated for v'T' plot and plot up...


[vNt_ed_pzints(1), vNt_ed_pzints_tneg(1), vNt_ed_pzints_tpos(1), vNt_ed_pzint_sdevs(1), vNt_ed_pzint_sdevs_tneg(1), vNt_ed_pzint_sdevs_tpos(1)] = vt_paper_plot_fun_strat('000');

'000 done'

[vNt_ed_pzints(2), vNt_ed_pzints_tneg(2), vNt_ed_pzints_tpos(2), vNt_ed_pzint_sdevs(2), vNt_ed_pzint_sdevs_tneg(2), vNt_ed_pzint_sdevs_tpos(2)] = vt_paper_plot_fun_strat('010');

'010 done'

[vNt_ed_pzints(3), vNt_ed_pzints_tneg(3), vNt_ed_pzints_tpos(3), vNt_ed_pzint_sdevs(3), vNt_ed_pzint_sdevs_tneg(3), vNt_ed_pzint_sdevs_tpos(3)] = vt_paper_plot_fun_strat('025');

'025 done'

[vNt_ed_pzints(4), vNt_ed_pzints_tneg(4), vNt_ed_pzints_tpos(4), vNt_ed_pzint_sdevs(4), vNt_ed_pzint_sdevs_tneg(4), vNt_ed_pzint_sdevs_tpos(4)] = vt_paper_plot_fun_strat('050');

'050 done'

[vNt_ed_pzints(5), vNt_ed_pzints_tneg(5), vNt_ed_pzints_tpos(5), vNt_ed_pzint_sdevs(5), vNt_ed_pzint_sdevs_tneg(5), vNt_ed_pzint_sdevs_tpos(5)] = vt_paper_plot_fun_strat('075');

'075 done'

[vNt_ed_pzints(6), vNt_ed_pzints_tneg(6), vNt_ed_pzints_tpos(6), vNt_ed_pzint_sdevs(6), vNt_ed_pzint_sdevs_tneg(6), vNt_ed_pzint_sdevs_tpos(6)] = vt_paper_plot_fun_strat('100');

'100 done'


save('/project/rg312/mat_files/vNt_paper_plot_data_strat.mat')

%load('/project/rg312/mat_files/vNt_paper_plot_data_strat.mat')

es0 = [0,0.1,0.25,0.5,0.75,1];

filles0 = [es0, fliplr(es0)];
fillerrors = [vNt_ed_pzints+vNt_ed_pzint_sdevs, fliplr(vNt_ed_pzints-vNt_ed_pzint_sdevs)];

fillerrors_tneg = [vNt_ed_pzints_tneg+2.*vNt_ed_pzint_sdevs_tneg, fliplr(vNt_ed_pzints_tneg -2.*vNt_ed_pzint_sdevs_tneg)];
fillerrors_tpos = [vNt_ed_pzints_tpos+2.*vNt_ed_pzint_sdevs_tpos, fliplr(vNt_ed_pzints_tpos -2.*vNt_ed_pzint_sdevs_tpos)];

figure
plot(es0,vNt_ed_pzints,'k','Linewidth',2);
hold on
plot(es0,vNt_ed_pzints_tpos,'r','Linewidth',2);
plot(es0,vNt_ed_pzints_tneg,'b','Linewidth',2);
fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_tneg,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_tpos,'r','FaceAlpha',0.25)
hold off
ylim([2 16])
set(gca,'FontSize',15);
xlabel('Reference es_{0} fraction')
ylabel('Zonal mean pressure averaged v''T'', Km/s ')
legend('Total','+ve T''','-ve T''','Location','northwest')
print('-dpng','vt_paper_plot_strat.png')


vNt_tot_incr = vNt_ed_pzints(6) - vNt_ed_pzints(1);
vNt_neg_incr = vNt_ed_pzints_tneg(6) - vNt_ed_pzints_tneg(1);
vNt_pos_incr = vNt_ed_pzints_tpos(6) - vNt_ed_pzints_tpos(1);



