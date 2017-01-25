%load in data generated for v'T' plot and plot up...


%[vNH_ed_pzints(1), vNH_ed_pzints_tneg(1), vNH_ed_pzints_tpos(1), vNH_ed_pzint_sdevs(1), vNH_ed_pzint_sdevs_tneg(1), vNH_ed_pzint_sdevs_tpos(1)] = vH_paper_plot_fun_blayer('000');

'000 done'

%[vNH_ed_pzints(2), vNH_ed_pzints_tneg(2), vNH_ed_pzints_tpos(2), vNH_ed_pzint_sdevs(2), vNH_ed_pzint_sdevs_tneg(2), vNH_ed_pzint_sdevs_tpos(2)] = vH_paper_plot_fun_blayer('010');

'010 done'

%[vNH_ed_pzints(3), vNH_ed_pzints_tneg(3), vNH_ed_pzints_tpos(3), vNH_ed_pzint_sdevs(3), vNH_ed_pzint_sdevs_tneg(3), vNH_ed_pzint_sdevs_tpos(3)] = vH_paper_plot_fun_blayer('025');

'025 done'

%[vNH_ed_pzints(4), vNH_ed_pzints_tneg(4), vNH_ed_pzints_tpos(4), vNH_ed_pzint_sdevs(4), vNH_ed_pzint_sdevs_tneg(4), vNH_ed_pzint_sdevs_tpos(4)] = vH_paper_plot_fun_blayer('050');

'050 done'

%[vNH_ed_pzints(5), vNH_ed_pzints_tneg(5), vNH_ed_pzints_tpos(5), vNH_ed_pzint_sdevs(5), vNH_ed_pzint_sdevs_tneg(5), vNH_ed_pzint_sdevs_tpos(5)] = vH_paper_plot_fun_blayer('075');

'075 done'

%[vNH_ed_pzints(6), vNH_ed_pzints_tneg(6), vNH_ed_pzints_tpos(6), vNH_ed_pzint_sdevs(6), vNH_ed_pzint_sdevs_tneg(6), vNH_ed_pzint_sdevs_tpos(6)] = vH_paper_plot_fun_blayer('100');

'100 done'


%save('/project/rg312/mat_files/vNH_paper_plot_data_blayer.mat')

load('/project/rg312/mat_files/vNH_paper_plot_data_blayer.mat')

es0 = [0,0.1,0.25,0.5,0.75,1];

filles0 = [es0, fliplr(es0)];
fillerrors = [vNH_ed_pzints+vNH_ed_pzint_sdevs, fliplr(vNH_ed_pzints-vNH_ed_pzint_sdevs)];

fillerrors_tneg = [vNH_ed_pzints_tneg+2.*vNH_ed_pzint_sdevs_tneg, fliplr(vNH_ed_pzints_tneg -2.*vNH_ed_pzint_sdevs_tneg)];
fillerrors_tpos = [vNH_ed_pzints_tpos+2.*vNH_ed_pzint_sdevs_tpos, fliplr(vNH_ed_pzints_tpos -2.*vNH_ed_pzint_sdevs_tpos)];

figure
plot(es0,vNH_ed_pzints,'k','Linewidth',2);
hold on
plot(es0,vNH_ed_pzints_tpos,'r','Linewidth',2);
plot(es0,vNH_ed_pzints_tneg,'b','Linewidth',2);
fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_tneg,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_tpos,'r','FaceAlpha',0.25)
hold off
%ylim([0.2e4 2.2e4])
set(gca,'FontSize',15);
xlabel('Reference es_{0} fraction')
ylabel('Zonal mean pressure averaged v''T'', Km/s ')
legend('Total','+ve T''','-ve T''','Location','northwest')
print('-dpng','vH_paper_plot_blayer.png')


vNH_tot_incr = vNH_ed_pzints(6) - vNH_ed_pzints(1);
vNH_neg_incr = vNH_ed_pzints_tneg(6) - vNH_ed_pzints_tneg(1);
vNH_pos_incr = vNH_ed_pzints_tpos(6) - vNH_ed_pzints_tpos(1);



