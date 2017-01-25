%load in data generated for v'T' plot and plot up...


[vNPHI_ed_pzints(1), vNPHI_ed_pzints_tneg(1), vNPHI_ed_pzints_tpos(1), vNPHI_ed_pzint_sdevs(1), vNPHI_ed_pzint_sdevs_tneg(1), vNPHI_ed_pzint_sdevs_tpos(1)] = vPHI_paper_plot_fun_strat('000');

'000 done'

[vNPHI_ed_pzints(2), vNPHI_ed_pzints_tneg(2), vNPHI_ed_pzints_tpos(2), vNPHI_ed_pzint_sdevs(2), vNPHI_ed_pzint_sdevs_tneg(2), vNPHI_ed_pzint_sdevs_tpos(2)] = vPHI_paper_plot_fun_strat('010');

'010 done'

[vNPHI_ed_pzints(3), vNPHI_ed_pzints_tneg(3), vNPHI_ed_pzints_tpos(3), vNPHI_ed_pzint_sdevs(3), vNPHI_ed_pzint_sdevs_tneg(3), vNPHI_ed_pzint_sdevs_tpos(3)] = vPHI_paper_plot_fun_strat('025');

'025 done'

[vNPHI_ed_pzints(4), vNPHI_ed_pzints_tneg(4), vNPHI_ed_pzints_tpos(4), vNPHI_ed_pzint_sdevs(4), vNPHI_ed_pzint_sdevs_tneg(4), vNPHI_ed_pzint_sdevs_tpos(4)] = vPHI_paper_plot_fun_strat('050');

'050 done'

[vNPHI_ed_pzints(5), vNPHI_ed_pzints_tneg(5), vNPHI_ed_pzints_tpos(5), vNPHI_ed_pzint_sdevs(5), vNPHI_ed_pzint_sdevs_tneg(5), vNPHI_ed_pzint_sdevs_tpos(5)] = vPHI_paper_plot_fun_strat('075');

'075 done'

[vNPHI_ed_pzints(6), vNPHI_ed_pzints_tneg(6), vNPHI_ed_pzints_tpos(6), vNPHI_ed_pzint_sdevs(6), vNPHI_ed_pzint_sdevs_tneg(6), vNPHI_ed_pzint_sdevs_tpos(6)] = vPHI_paper_plot_fun_strat('100');

'100 done'


save('/project/rg312/mat_files/vNPHI_paper_plot_data_strat.mat')

%load('/project/rg312/mat_files/vNPHI_paper_plot_data_strat.mat')

es0 = [0,0.1,0.25,0.5,0.75,1];

filles0 = [es0, fliplr(es0)];
fillerrors = [vNPHI_ed_pzints+vNPHI_ed_pzint_sdevs, fliplr(vNPHI_ed_pzints-vNPHI_ed_pzint_sdevs)];

fillerrors_tneg = [vNPHI_ed_pzints_tneg+2.*vNPHI_ed_pzint_sdevs_tneg, fliplr(vNPHI_ed_pzints_tneg -2.*vNPHI_ed_pzint_sdevs_tneg)];
fillerrors_tpos = [vNPHI_ed_pzints_tpos+2.*vNPHI_ed_pzint_sdevs_tpos, fliplr(vNPHI_ed_pzints_tpos -2.*vNPHI_ed_pzint_sdevs_tpos)];

figure
plot(es0,vNPHI_ed_pzints,'k','Linewidth',2);
hold on
plot(es0,vNPHI_ed_pzints_tpos,'r','Linewidth',2);
plot(es0,vNPHI_ed_pzints_tneg,'b','Linewidth',2);
fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_tneg,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_tpos,'r','FaceAlpha',0.25)
hold off
ylim([0.2e4 2.2e4])
set(gca,'FontSize',15);
xlabel('Reference es_{0} fraction')
ylabel('Zonal mean pressure averaged v''T'', Km/s ')
legend('Total','+ve T''','-ve T''','Location','northwest')
print('-dpng','vPHI_paper_plot_strat.png')


vNPHI_tot_incr = vNPHI_ed_pzints(6) - vNPHI_ed_pzints(1);
vNPHI_neg_incr = vNPHI_ed_pzints_tneg(6) - vNPHI_ed_pzints_tneg(1);
vNPHI_pos_incr = vNPHI_ed_pzints_tpos(6) - vNPHI_ed_pzints_tpos(1);



