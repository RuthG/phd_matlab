load('/project/rg312/mat_files/vNt_paper_plot_data_seca.mat')
vNt_ed_pzints_a = vNt_ed_pzints;
vNt_ed_pzints_tpos_a = vNt_ed_pzints_tpos;
vNt_ed_pzints_tneg_a = vNt_ed_pzints_tneg;

load('/project/rg312/mat_files/vNt_paper_plot_data_secb.mat')


es0 = [0,0.1,0.25,0.5,0.75,1,1.25,1.5];


figure
plot(es0,(vNt_ed_pzints + vNt_ed_pzints_a)./2,'k','Linewidth',2);
hold on
plot(es0,(vNt_ed_pzints_tpos + vNt_ed_pzints_tpos_a)./2,'r','Linewidth',2);
plot(es0,(vNt_ed_pzints_tneg + vNt_ed_pzints_tneg_a)./2,'b','Linewidth',2);
hold off
ylim([2 16])
set(gca,'FontSize',15);
xlabel('Reference es_{0} fraction')
ylabel('Zonal mean pressure averaged v''T'', Km/s ')
legend('Total','+ve T''','-ve T''','Location','northwest')
print('-dpng','vt_paper_plot_trop.png')

