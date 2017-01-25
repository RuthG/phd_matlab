[vNH_ed(1,:) ,vNH_ed_warm(1,:) ,vNH_ed_cold(1,:) ,vND_ed(1,:) ,vND_ed_warm(1,:) ,vND_ed_cold(1,:)] = vH_PW_fun_trop('000');

[vNH_ed(2,:) ,vNH_ed_warm(2,:) ,vNH_ed_cold(2,:) ,vND_ed(2,:) ,vND_ed_warm(2,:) ,vND_ed_cold(2,:)] = vH_PW_fun_trop('010');

[vNH_ed(3,:) ,vNH_ed_warm(3,:) ,vNH_ed_cold(3,:) ,vND_ed(3,:) ,vND_ed_warm(3,:) ,vND_ed_cold(3,:)] = vH_PW_fun_trop('025');

[vNH_ed(4,:) ,vNH_ed_warm(4,:) ,vNH_ed_cold(4,:) ,vND_ed(4,:) ,vND_ed_warm(4,:) ,vND_ed_cold(4,:)] = vH_PW_fun_trop('050');

[vNH_ed(5,:) ,vNH_ed_warm(5,:) ,vNH_ed_cold(5,:) ,vND_ed(5,:) ,vND_ed_warm(5,:) ,vND_ed_cold(5,:)] = vH_PW_fun_trop('075');

[vNH_ed(6,:) ,vNH_ed_warm(6,:) ,vNH_ed_cold(6,:) ,vND_ed(6,:) ,vND_ed_warm(6,:) ,vND_ed_cold(6,:)] = vH_PW_fun_trop('100');


es0 = [0,0.1,0.25,0.5,0.75,1];

filles0 = [es0, fliplr(es0)];
fillerrors = [vNH_ed(:,1)'+2.*vNH_ed(:,2)', fliplr(vNH_ed(:,1)'-2.*vNH_ed(:,2)')];

fillerrors_warm = [vNH_ed_warm(:,1)'+2.*vNH_ed_warm(:,2)', fliplr(vNH_ed_warm(:,1)' -2.*vNH_ed_warm(:,2)')];
fillerrors_cold = [vNH_ed_cold(:,1)'+2.*vNH_ed_cold(:,2)', fliplr(vNH_ed_cold(:,1)' -2.*vNH_ed_cold(:,2)')];

figure
plot(es0,vNH_ed(:,1)./10^15,'k','Linewidth',2);
hold on
plot(es0,vNH_ed_warm(:,1)./10^15,'r','Linewidth',2);
plot(es0,vNH_ed_cold(:,1)./10^15,'b','Linewidth',2);
fill(filles0,fillerrors./10^15,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold./10^15,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm./10^15,'r','FaceAlpha',0.25)
hold off
%ylim([0.2e4 2.2e4])
set(gca,'FontSize',15);
xlabel('Reference e_{s0} fraction')
ylabel('MSE flux, PW/Pa')
legend('Total','+ve T''','-ve T''','Location','northwest')
print('-depsc2','-r300','vH_PW_plot_trop.eps')

fillerrors = [vND_ed(:,1)'+2.*vND_ed(:,2)', fliplr(vND_ed(:,1)'-2.*vND_ed(:,2)')];

fillerrors_warm = [vND_ed_warm(:,1)'+2.*vND_ed_warm(:,2)', fliplr(vND_ed_warm(:,1)' -2.*vND_ed_warm(:,2)')];
fillerrors_cold = [vND_ed_cold(:,1)'+2.*vND_ed_cold(:,2)', fliplr(vND_ed_cold(:,1)' -2.*vND_ed_cold(:,2)')];

figure
plot(es0,vND_ed(:,1)./10^15,'k','Linewidth',2);
hold on
plot(es0,vND_ed_warm(:,1)./10^15,'r','Linewidth',2);
plot(es0,vND_ed_cold(:,1)./10^15,'b','Linewidth',2);
fill(filles0,fillerrors./10^15,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold./10^15,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm./10^15,'r','FaceAlpha',0.25)
hold off
%ylim([0.2e4 2.2e4])
set(gca,'FontSize',15);
xlabel('Reference e_{s0} fraction')
ylabel('DSE flux, PW/Pa')
legend('Total','+ve T''','-ve T''','Location','northwest')
print('-depsc2','-r300','vT_PW_plot_trop.eps')


