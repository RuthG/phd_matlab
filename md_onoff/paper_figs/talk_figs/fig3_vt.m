load('/net/spat-nas/project/rg312/mat_files/vNt_paper_plot_data_blayer_final.mat')
vNt_ed_b = vNt_ed;
vNt_ed_cold_b = vNt_ed_cold;
vNt_ed_warm_b = vNt_ed_warm;
vNt_ed_serr_b = vNt_ed_serr;
vNt_ed_cold_serr_b = vNt_ed_cold_serr;
vNt_ed_warm_serr_b = vNt_ed_warm_serr;

load('/net/spat-nas/project/rg312/mat_files/vNt_paper_plot_data_freetrop_final.mat')
vNt_ed_ft = vNt_ed;
vNt_ed_cold_ft = vNt_ed_cold;
vNt_ed_warm_ft = vNt_ed_warm;
vNt_ed_serr_ft = vNt_ed_serr;
vNt_ed_cold_serr_ft = vNt_ed_cold_serr;
vNt_ed_warm_serr_ft = vNt_ed_warm_serr;




es0 = [0,0.1,0.25,0.5,0.75,1,1.25,1.5];
cp = 287.04./(2./7.);
filles0 = [es0, fliplr(es0)];

fillerrors = [vNt_ed_b + 2.*vNt_ed_serr_b, fliplr(vNt_ed_b - 2.*vNt_ed_serr_b)];
fillerrors_warm = [vNt_ed_warm_b + 2.*vNt_ed_warm_serr_b, fliplr(vNt_ed_warm_b - 2.*vNt_ed_warm_serr_b)];
fillerrors_cold = [vNt_ed_cold_b + 2.*vNt_ed_cold_serr_b, fliplr(vNt_ed_cold_b - 2.*vNt_ed_cold_serr_b)];

figure
plot(es0,vNt_ed_b,'k','Linewidth',2);
hold on
plot(es0,vNt_ed_warm_b,'r','Linewidth',2);
plot(es0,vNt_ed_cold_b,'b','Linewidth',2);
fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)
ylim([0 16])
hold off
set(gca,'FontSize',12);
xlabel('Reference e_{s0} fraction','FontSize',15)
ylabel('v''T'', Km/s','FontSize',15)
legend('Total','+ve T''','-ve T''','Location','northwest')
print('-dpng','vt_pbl.png')


fillerrors = [vNt_ed_ft + 2.*vNt_ed_serr_ft, fliplr(vNt_ed_ft - 2.*vNt_ed_serr_ft)];
fillerrors_warm = [vNt_ed_warm_ft + 2.*vNt_ed_warm_serr_ft, fliplr(vNt_ed_warm_ft - 2.*vNt_ed_warm_serr_ft)];
fillerrors_cold = [vNt_ed_cold_ft + 2.*vNt_ed_cold_serr_ft, fliplr(vNt_ed_cold_ft - 2.*vNt_ed_cold_serr_ft)];

figure
plot(es0,vNt_ed_ft,'k','Linewidth',2);
hold on
plot(es0,vNt_ed_warm_ft,'r','Linewidth',2);
plot(es0,vNt_ed_cold_ft,'b','Linewidth',2);
fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)
ylim([0 16])
hold off
set(gca,'FontSize',12);
xlabel('Reference e_{s0} fraction','FontSize',15)
ylabel('v''T'', Km/s','FontSize',15)
legend('Total','+ve T''','-ve T''','Location','northwest')
print('-dpng','vt_freetrop.png')



