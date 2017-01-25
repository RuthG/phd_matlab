%load in data generated for v'T' plot and plot up...


%[vNvN_ed_pzints(1), vNvN_ed_pzints_tneg(1), vNvN_ed_pzints_tpos(1), vNvN_ed_pzint_sdevs(1), vNvN_ed_pzint_sdevs_tneg(1), vNvN_ed_pzint_sdevs_tpos(1)] = vv_paper_plot_fun_blayer('000');

'000 done'

%[vNvN_ed_pzints(2), vNvN_ed_pzints_tneg(2), vNvN_ed_pzints_tpos(2), vNvN_ed_pzint_sdevs(2), vNvN_ed_pzint_sdevs_tneg(2), vNvN_ed_pzint_sdevs_tpos(2)] = vv_paper_plot_fun_blayer('010');

'010 done'

%[vNvN_ed_pzints(3), vNvN_ed_pzints_tneg(3), vNvN_ed_pzints_tpos(3), vNvN_ed_pzint_sdevs(3), vNvN_ed_pzint_sdevs_tneg(3), vNvN_ed_pzint_sdevs_tpos(3)] = vv_paper_plot_fun_blayer('025');

'025 done'

%[vNvN_ed_pzints(4), vNvN_ed_pzints_tneg(4), vNvN_ed_pzints_tpos(4), vNvN_ed_pzint_sdevs(4), vNvN_ed_pzint_sdevs_tneg(4), vNvN_ed_pzint_sdevs_tpos(4)] = vv_paper_plot_fun_blayer('050');

'050 done'

%[vNvN_ed_pzints(5), vNvN_ed_pzints_tneg(5), vNvN_ed_pzints_tpos(5), vNvN_ed_pzint_sdevs(5), vNvN_ed_pzint_sdevs_tneg(5), vNvN_ed_pzint_sdevs_tpos(5)] = vv_paper_plot_fun_blayer('075');

'075 done'

%[vNvN_ed_pzints(6), vNvN_ed_pzints_tneg(6), vNvN_ed_pzints_tpos(6), vNvN_ed_pzint_sdevs(6), vNvN_ed_pzint_sdevs_tneg(6), vNvN_ed_pzint_sdevs_tpos(6)] = vv_paper_plot_fun_blayer('100');

'100 done'


%save('/project/rg312/mat_files/vNvN_paper_plot_data_blayer_vm.mat')

load('/project/rg312/mat_files/vNvN_paper_plot_data_blayer_vm.mat')

es0 = [0,0.1,0.25,0.5,0.75,1];

filles0 = [es0, fliplr(es0)];
fillerrors = [vNvN_ed_pzints+vNvN_ed_pzint_sdevs, fliplr(vNvN_ed_pzints-vNvN_ed_pzint_sdevs)];

fillerrors_tneg = [vNvN_ed_pzints_tneg+2.*vNvN_ed_pzint_sdevs_tneg, fliplr(vNvN_ed_pzints_tneg -2.*vNvN_ed_pzint_sdevs_tneg)];
fillerrors_tpos = [vNvN_ed_pzints_tpos+2.*vNvN_ed_pzint_sdevs_tpos, fliplr(vNvN_ed_pzints_tpos -2.*vNvN_ed_pzint_sdevs_tpos)];

figure
plot(es0,vNvN_ed_pzints,'k','Linewidth',2);
hold on
plot(es0,vNvN_ed_pzints_tpos,'r','Linewidth',2);
plot(es0,vNvN_ed_pzints_tneg,'b','Linewidth',2);
fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_tneg,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_tpos,'r','FaceAlpha',0.25)
hold off
ylim([0 160])
set(gca,'FontSize',15);
xlabel('Reference es_{0} fraction')
ylabel('Zonal mean pressure averaged variance of v, m^2/s^2 ')
legend('Total','+ve v''','-ve v''','Location','northwest')
print('-dpng','vv_paper_plot_blayer.png')


vNvN_tot_incr = vNvN_ed_pzints(6) - vNvN_ed_pzints(1);
vNvN_neg_incr = vNvN_ed_pzints_tneg(6) - vNvN_ed_pzints_tneg(1);
vNvN_pos_incr = vNvN_ed_pzints_tpos(6) - vNvN_ed_pzints_tpos(1);



