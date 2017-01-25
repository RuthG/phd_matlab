%load in data generated for v'T' plot and plot up...


[vNH_ed_pzints(1,:), vNH_ed_pzints_tneg(1,:), vNH_ed_pzints_tpos(1,:), vNH_ed_pzint_sdevs(1,:), vNH_ed_pzint_sdevs_tneg(1,:), vNH_ed_pzint_sdevs_tpos(1,:)] = vH_paper_plot_fun('000');

'000 done'

[vNH_ed_pzints(2,:), vNH_ed_pzints_tneg(2,:), vNH_ed_pzints_tpos(2,:), vNH_ed_pzint_sdevs(2,:), vNH_ed_pzint_sdevs_tneg(2,:), vNH_ed_pzint_sdevs_tpos(2,:)] = vH_paper_plot_fun('010');

'010 done'

[vNH_ed_pzints(3,:), vNH_ed_pzints_tneg(3,:), vNH_ed_pzints_tpos(3,:), vNH_ed_pzint_sdevs(3,:), vNH_ed_pzint_sdevs_tneg(3,:), vNH_ed_pzint_sdevs_tpos(3,:)] = vH_paper_plot_fun('025');

'025 done'

[vNH_ed_pzints(4,:), vNH_ed_pzints_tneg(4,:), vNH_ed_pzints_tpos(4,:), vNH_ed_pzint_sdevs(4,:), vNH_ed_pzint_sdevs_tneg(4,:), vNH_ed_pzint_sdevs_tpos(4,:)] = vH_paper_plot_fun('050');

'050 done'

[vNH_ed_pzints(5,:), vNH_ed_pzints_tneg(5,:), vNH_ed_pzints_tpos(5,:), vNH_ed_pzint_sdevs(5,:), vNH_ed_pzint_sdevs_tneg(5,:), vNH_ed_pzint_sdevs_tpos(5,:)] = vH_paper_plot_fun('075');

'075 done'

[vNH_ed_pzints(6,:), vNH_ed_pzints_tneg(6,:), vNH_ed_pzints_tpos(6,:), vNH_ed_pzint_sdevs(6,:), vNH_ed_pzint_sdevs_tneg(6,:), vNH_ed_pzint_sdevs_tpos(6,:)] = vH_paper_plot_fun('100');

'100 done'

[vNH_ed_pzints(7,:), vNH_ed_pzints_tneg(7,:), vNH_ed_pzints_tpos(7,:), vNH_ed_pzint_sdevs(7,:), vNH_ed_pzint_sdevs_tneg(7,:), vNH_ed_pzint_sdevs_tpos(7,:)] = vH_paper_plot_fun('125');

'125 done'

[vNH_ed_pzints(8,:), vNH_ed_pzints_tneg(8,:), vNH_ed_pzints_tpos(8,:), vNH_ed_pzint_sdevs(8,:), vNH_ed_pzint_sdevs_tneg(8,:), vNH_ed_pzint_sdevs_tpos(8,:)] = vH_paper_plot_fun('150');

'150 done'

save('/project/rg312/mat_files/vNH_paper_plot_data.mat')

es0 = [0,0.1,0.25,0.5,0.75,1,1.25,1.5];

filles0 = [es0, fliplr(es0)];
fillerrors_H = [vNH_ed_pzints(:,1)'+vNH_ed_pzint_sdevs(:,1)', fliplr(vNH_ed_pzints(:,1)'-vNH_ed_pzint_sdevs(:,1)')];
fillerrors_Hd = [vNH_ed_pzints(:,2)'+vNH_ed_pzint_sdevs(:,2)', fliplr(vNH_ed_pzints(:,2)'-vNH_ed_pzint_sdevs(:,2)')];

fillerrors_tneg_H = [vNH_ed_pzints_tneg(:,1)'+2.*vNH_ed_pzint_sdevs_tneg(:,1)', fliplr(vNH_ed_pzints_tneg(:,1)' -2.*vNH_ed_pzint_sdevs_tneg(:,1)')];
fillerrors_tpos_H = [vNH_ed_pzints_tpos(:,1)'+2.*vNH_ed_pzint_sdevs_tpos(:,1)', fliplr(vNH_ed_pzints_tpos(:,1)' -2.*vNH_ed_pzint_sdevs_tpos(:,1)')];

fillerrors_tneg_Hd = [vNH_ed_pzints_tneg(:,2)'+2.*vNH_ed_pzint_sdevs_tneg(:,2)', fliplr(vNH_ed_pzints_tneg(:,2)' -2.*vNH_ed_pzint_sdevs_tneg(:,2)')];
fillerrors_tpos_Hd = [vNH_ed_pzints_tpos(:,2)'+2.*vNH_ed_pzint_sdevs_tpos(:,2)', fliplr(vNH_ed_pzints_tpos(:,2)' -2.*vNH_ed_pzint_sdevs_tpos(:,2)')];

figure
plot(es0,vNH_ed_pzints(:,1),'k','Linewidth',2);
hold on
plot(es0,vNH_ed_pzints_tpos(:,1),'r','Linewidth',2);
plot(es0,vNH_ed_pzints_tneg(:,1),'b','Linewidth',2);
fill(filles0,fillerrors_H,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_tneg_H,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_tpos_H,'r','FaceAlpha',0.25)
hold off
ylim([0.2e4 1.8e4])
set(gca,'FontSize',15);
xlabel('Reference es_{0} fraction')
ylabel('Zonal mean pressure averaged v''H'', Km/s ')
legend('Total','+ve T''','-ve T''','Location','northwest')
print('-dpng','vH_paper_plot_attempt.png')


figure
plot(es0,vNH_ed_pzints(:,2),'k','Linewidth',2);
hold on
plot(es0,vNH_ed_pzints_tpos(:,2),'r','Linewidth',2);
plot(es0,vNH_ed_pzints_tneg(:,2),'b','Linewidth',2);
fill(filles0,fillerrors_Hd,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_tneg_Hd,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_tpos_Hd,'r','FaceAlpha',0.25)
hold off
ylim([0.2e4 1.8e4])
set(gca,'FontSize',15);
xlabel('Reference es_{0} fraction')
ylabel('Zonal mean pressure averaged v''Hd'', Km/s ')
legend('Total','+ve T''','-ve T''','Location','northwest')
print('-dpng','vHd_paper_plot_attempt.png')

vNt_tot_incr = vNH_ed_pzints(6) - vNH_ed_pzints(1);
vNt_neg_incr = vNH_ed_pzints_tneg(6) - vNH_ed_pzints_tneg(1);
vNt_pos_incr = vNH_ed_pzints_tpos(6) - vNH_ed_pzints_tpos(1);



