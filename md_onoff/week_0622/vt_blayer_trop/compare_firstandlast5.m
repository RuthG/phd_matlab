

load('/project/rg312/mat_files/vNH_paper_plot_data_trop_final_last5.mat')
es0 = [0,0.1,0.25,0.5,0.75,1,1.25,1.5];

filles0 = [es0, fliplr(es0)];
fillerrors = [vNH_ed+2.*vNH_ed_serr.*sqrt(10), fliplr(vNH_ed-2.*vNH_ed_serr.*sqrt(10))];

fillerrors_warm = [vNH_ed_warm+2.*vNH_ed_warm_serr.*sqrt(10), fliplr(vNH_ed_warm -2.*vNH_ed_warm_serr.*sqrt(10))];
fillerrors_cold = [vNH_ed_cold+2.*vNH_ed_cold_serr.*sqrt(10), fliplr(vNH_ed_cold -2.*vNH_ed_cold_serr.*sqrt(10))];

figure
plot(es0,vNH_ed,'k','Linewidth',2);
hold on
plot(es0,vNH_ed_warm,'r','Linewidth',2);
plot(es0,vNH_ed_cold,'b','Linewidth',2);
fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)
%hold off
ylim([0.2e4 2.2e4])
set(gca,'FontSize',15);
xlabel('Reference e_{s0} fraction')
ylabel('Zonal mean pressure averaged v''H'', Wm/kg ')
legend('Total','+ve T''','-ve T''','Location','northwest')
print('-dpng','vH_paper_plot_trop_final_last5.png')

load('/project/rg312/mat_files/vNH_paper_plot_data_trop_final_first5.mat')

filles0 = [es0, fliplr(es0)];
fillerrors = [vNH_ed+2.*vNH_ed_serr.*sqrt(10), fliplr(vNH_ed-2.*vNH_ed_serr.*sqrt(10))];

fillerrors_warm = [vNH_ed_warm+2.*vNH_ed_warm_serr.*sqrt(10), fliplr(vNH_ed_warm -2.*vNH_ed_warm_serr.*sqrt(10))];
fillerrors_cold = [vNH_ed_cold+2.*vNH_ed_cold_serr.*sqrt(10), fliplr(vNH_ed_cold -2.*vNH_ed_cold_serr.*sqrt(10))];

plot(es0,vNH_ed,'k','Linewidth',2);
hold on
plot(es0,vNH_ed_warm,'r','Linewidth',2);
plot(es0,vNH_ed_cold,'b','Linewidth',2);
fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)

print('-dpng','vH_paper_plot_trop_final_firstvslast.png')
