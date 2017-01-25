[ed_heat_trans_000, dry_ed_heat_trans_000] = heat_transport_plot('000');

[ed_heat_trans_010, dry_ed_heat_trans_010] = heat_transport_plot('010');

[ed_heat_trans_025, dry_ed_heat_trans_025] = heat_transport_plot('025');

[ed_heat_trans_050, dry_ed_heat_trans_050] = heat_transport_plot('050');

[ed_heat_trans_075, dry_ed_heat_trans_075] = heat_transport_plot('075');

[ed_heat_trans_100, dry_ed_heat_trans_100] = heat_transport_plot('100');

save('/project/rg312/mat_files/eddy_heat_fluxes_PW.mat')

yi=-89:2:89;

figure
plot(yi,ed_heat_trans_000,'r')
set(gca,'FontSize',15)
hold on
plot(yi,ed_heat_trans_010,'r--')
plot(yi,ed_heat_trans_025,'g')
plot(yi,ed_heat_trans_050,'g--')
plot(yi,ed_heat_trans_075,'b')
plot(yi,ed_heat_trans_100,'b--')
legend('0','0.1','0.25','0.5','0.75','1.0')
xlabel('Latitude','FontSize',15)
ylabel('MSE flux, PW','FontSize',15)
print('-dpng','heat_trans_plot.png')


figure
plot(yi,ed_heat_trans_100,'k')
hold on
plot(yi,dry_ed_heat_trans_100,'r')
plot(yi,ed_heat_trans_100 - dry_ed_heat_trans_100,'b')
set(gca,'FontSize',15)
xlabel('Latitude','FontSize',15)
ylabel('Energy flux, PW','FontSize',15)
print('-dpng','heat_trans_plot_100.png')


x000n = find(dry_ed_heat_trans_000 == max(dry_ed_heat_trans_000))
x000s = find(dry_ed_heat_trans_000 == min(dry_ed_heat_trans_000))

x010n = find(dry_ed_heat_trans_010 == max(dry_ed_heat_trans_010))
x010s = find(dry_ed_heat_trans_010 == min(dry_ed_heat_trans_010))

x025n = find(dry_ed_heat_trans_025 == max(dry_ed_heat_trans_025))
x025s = find(dry_ed_heat_trans_025 == min(dry_ed_heat_trans_025))

x050n = find(dry_ed_heat_trans_050 == max(dry_ed_heat_trans_050))
x050s = find(dry_ed_heat_trans_050 == min(dry_ed_heat_trans_050))

x075n = find(dry_ed_heat_trans_075 == max(dry_ed_heat_trans_075))
x075s = find(dry_ed_heat_trans_075 == min(dry_ed_heat_trans_075))

x100n = find(dry_ed_heat_trans_100 == max(dry_ed_heat_trans_100))
x100s = find(dry_ed_heat_trans_100 == min(dry_ed_heat_trans_100))

save('/project/rg312/mat_files/PW_lats.mat', 'x000n', 'x000s', 'x010n', 'x010s', 'x025n', 'x025s', 'x050n', 'x050s', 'x075n', 'x075s', 'x100n', 'x100s')
