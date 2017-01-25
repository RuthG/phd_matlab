%load in data generated for v'T' plot and plot up...


%[tt_ed_pzints(1), tt_ed_pzints_tneg(1), tt_ed_pzints_tpos(1), tt_ed_pzint_sdevs(1), tt_ed_pzint_sdevs_tneg(1), tt_ed_pzint_sdevs_tpos(1)] = tt_paper_plot_fun_trop('000');

'000 done'

%[tt_ed_pzints(2), tt_ed_pzints_tneg(2), tt_ed_pzints_tpos(2), tt_ed_pzint_sdevs(2), tt_ed_pzint_sdevs_tneg(2), tt_ed_pzint_sdevs_tpos(2)] = tt_paper_plot_fun_trop('010');

'010 done'

%[tt_ed_pzints(3), tt_ed_pzints_tneg(3), tt_ed_pzints_tpos(3), tt_ed_pzint_sdevs(3), tt_ed_pzint_sdevs_tneg(3), tt_ed_pzint_sdevs_tpos(3)] = tt_paper_plot_fun_trop('025');

'025 done'

%[tt_ed_pzints(4), tt_ed_pzints_tneg(4), tt_ed_pzints_tpos(4), tt_ed_pzint_sdevs(4), tt_ed_pzint_sdevs_tneg(4), tt_ed_pzint_sdevs_tpos(4)] = tt_paper_plot_fun_trop('050');

'050 done'

%[tt_ed_pzints(5), tt_ed_pzints_tneg(5), tt_ed_pzints_tpos(5), tt_ed_pzint_sdevs(5), tt_ed_pzint_sdevs_tneg(5), tt_ed_pzint_sdevs_tpos(5)] = tt_paper_plot_fun_trop('075');

'075 done'

%[tt_ed_pzints(6), tt_ed_pzints_tneg(6), tt_ed_pzints_tpos(6), tt_ed_pzint_sdevs(6), tt_ed_pzint_sdevs_tneg(6), tt_ed_pzint_sdevs_tpos(6)] = tt_paper_plot_fun_trop('100');

'100 done'


%save('/project/rg312/mat_files/tt_paper_plot_data_trop.mat')

load('/project/rg312/mat_files/tt_paper_plot_data_trop.mat')

es0 = [0,0.1,0.25,0.5,0.75,1];

filles0 = [es0, fliplr(es0)];
fillerrors = [tt_ed_pzints+tt_ed_pzint_sdevs, fliplr(tt_ed_pzints-tt_ed_pzint_sdevs)];

fillerrors_tneg = [tt_ed_pzints_tneg+2.*tt_ed_pzint_sdevs_tneg, fliplr(tt_ed_pzints_tneg -2.*tt_ed_pzint_sdevs_tneg)];
fillerrors_tpos = [tt_ed_pzints_tpos+2.*tt_ed_pzint_sdevs_tpos, fliplr(tt_ed_pzints_tpos -2.*tt_ed_pzint_sdevs_tpos)];

figure
plot(es0,tt_ed_pzints,'k','Linewidth',2);
hold on
plot(es0,tt_ed_pzints_tpos,'r','Linewidth',2);
plot(es0,tt_ed_pzints_tneg,'b','Linewidth',2);
fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_tneg,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_tpos,'r','FaceAlpha',0.25)
hold off
ylim([0 18])
set(gca,'FontSize',15);
xlabel('Reference es_{0} fraction')
ylabel('Zonal mean pressure averaged variance of T, K^2')
legend('Total','+ve T''','-ve T''','Location','northwest')
print('-dpng','tt_paper_plot_trop.png')


tt_tot_incr = tt_ed_pzints(6) - tt_ed_pzints(1);
tt_neg_incr = tt_ed_pzints_tneg(6) - tt_ed_pzints_tneg(1);
tt_pos_incr = tt_ed_pzints_tpos(6) - tt_ed_pzints_tpos(1);



