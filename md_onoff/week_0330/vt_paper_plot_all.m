%load in data generated for v'T' plot and plot up...

load('/project/rg312/mat_files/vt_lats_best.mat')

load('/project/rg312/mat_files/vt_paper_plot_000.mat')

vNt_ed_pzints(1) = (vNt_ed_pzint_tzav(x000n,1) - vNt_ed_pzint_tzav(x000s,1))./2;
vNt_ed_pzints_tneg(1) = (vNt_ed_pzint_tzav_tneg(x000n,1) - vNt_ed_pzint_tzav_tneg(x000s,1))./2;
vNt_ed_pzints_tpos(1) = (vNt_ed_pzint_tzav_tpos(x000n,1) - vNt_ed_pzint_tzav_tpos(x000s,1))./2;


vNt_ed_pzint_sdevs(1) = sqrt((vNt_ed_pzint_var(x000n,1) + vNt_ed_pzint_var(x000s,1))./2)./sqrt(1440) ;
vNt_ed_pzint_sdevs_tneg(1) = sqrt((vNt_ed_pzint_var_tneg(x000n,1) + vNt_ed_pzint_var_tneg(x000s,1))./2)./sqrt(1440) ;
vNt_ed_pzint_sdevs_tpos(1) = sqrt((vNt_ed_pzint_var_tpos(x000n,1) + vNt_ed_pzint_var_tpos(x000s,1))./2)./sqrt(1440) ;



load('/project/rg312/mat_files/vt_paper_plot_010.mat')

vNt_ed_pzints(2) = (vNt_ed_pzint_tzav(x010n,1) - vNt_ed_pzint_tzav(x010s,1))./2;
vNt_ed_pzints_tneg(2) = (vNt_ed_pzint_tzav_tneg(x010n,1) - vNt_ed_pzint_tzav_tneg(x010s,1))./2;
vNt_ed_pzints_tpos(2) = (vNt_ed_pzint_tzav_tpos(x010n,1) - vNt_ed_pzint_tzav_tpos(x010s,1))./2;


vNt_ed_pzint_sdevs(2) = sqrt((vNt_ed_pzint_var(x010n,1) + vNt_ed_pzint_var(x010s,1))./2)./sqrt(1440) ;
vNt_ed_pzint_sdevs_tneg(2) = sqrt((vNt_ed_pzint_var_tneg(x010n,1) + vNt_ed_pzint_var_tneg(x010s,1))./2)./sqrt(1440) ;
vNt_ed_pzint_sdevs_tpos(2) = sqrt((vNt_ed_pzint_var_tpos(x010n,1) + vNt_ed_pzint_var_tpos(x010s,1))./2)./sqrt(1440) ;




load('/project/rg312/mat_files/vt_paper_plot_025.mat')

vNt_ed_pzints(3) = (vNt_ed_pzint_tzav(x025n,1) - vNt_ed_pzint_tzav(x025s,1))./2;
vNt_ed_pzints_tneg(3) = (vNt_ed_pzint_tzav_tneg(x025n,1) - vNt_ed_pzint_tzav_tneg(x025s,1))./2;
vNt_ed_pzints_tpos(3) = (vNt_ed_pzint_tzav_tpos(x025n,1) - vNt_ed_pzint_tzav_tpos(x025s,1))./2;


vNt_ed_pzint_sdevs(3) = sqrt((vNt_ed_pzint_var(x025n,1) + vNt_ed_pzint_var(x025s,1))./2)./sqrt(1440) ;
vNt_ed_pzint_sdevs_tneg(3) = sqrt((vNt_ed_pzint_var_tneg(x025n,1) + vNt_ed_pzint_var_tneg(x025s,1))./2)./sqrt(1440) ;
vNt_ed_pzint_sdevs_tpos(3) = sqrt((vNt_ed_pzint_var_tpos(x025n,1) + vNt_ed_pzint_var_tpos(x025s,1))./2)./sqrt(1440) ;



load('/project/rg312/mat_files/vt_paper_plot_050.mat')

vNt_ed_pzints(4) = (vNt_ed_pzint_tzav(x050n,1) - vNt_ed_pzint_tzav(x050s,1))./2;
vNt_ed_pzints_tneg(4) = (vNt_ed_pzint_tzav_tneg(x050n,1) - vNt_ed_pzint_tzav_tneg(x050s,1))./2;
vNt_ed_pzints_tpos(4) = (vNt_ed_pzint_tzav_tpos(x050n,1) - vNt_ed_pzint_tzav_tpos(x050s,1))./2;


vNt_ed_pzint_sdevs(4) = sqrt((vNt_ed_pzint_var(x050n,1) + vNt_ed_pzint_var(x050s,1))./2)./sqrt(1440) ;
vNt_ed_pzint_sdevs_tneg(4) = sqrt((vNt_ed_pzint_var_tneg(x050n,1) + vNt_ed_pzint_var_tneg(x050s,1))./2)./sqrt(1440) ;
vNt_ed_pzint_sdevs_tpos(4) = sqrt((vNt_ed_pzint_var_tpos(x050n,1) + vNt_ed_pzint_var_tpos(x050s,1))./2)./sqrt(1440) ;



load('/project/rg312/mat_files/vt_paper_plot_075.mat')

vNt_ed_pzints(5) = (vNt_ed_pzint_tzav(x075n,1) - vNt_ed_pzint_tzav(x075s,1))./2;
vNt_ed_pzints_tneg(5) = (vNt_ed_pzint_tzav_tneg(x075n,1) - vNt_ed_pzint_tzav_tneg(x075s,1))./2;
vNt_ed_pzints_tpos(5) = (vNt_ed_pzint_tzav_tpos(x075n,1) - vNt_ed_pzint_tzav_tpos(x075s,1))./2;


vNt_ed_pzint_sdevs(5) = sqrt((vNt_ed_pzint_var(x075n,1) + vNt_ed_pzint_var(x075s,1))./2)./sqrt(1440) ;
vNt_ed_pzint_sdevs_tneg(5) = sqrt((vNt_ed_pzint_var_tneg(x075n,1) + vNt_ed_pzint_var_tneg(x075s,1))./2)./sqrt(1440) ;
vNt_ed_pzint_sdevs_tpos(5) = sqrt((vNt_ed_pzint_var_tpos(x075n,1) + vNt_ed_pzint_var_tpos(x075s,1))./2)./sqrt(1440) ;




load('/project/rg312/mat_files/vt_paper_plot_100.mat')

vNt_ed_pzints(6) = (vNt_ed_pzint_tzav(x100n,1) - vNt_ed_pzint_tzav(x100s,1))./2;
vNt_ed_pzints_tneg(6) = (vNt_ed_pzint_tzav_tneg(x100n,1) - vNt_ed_pzint_tzav_tneg(x100s,1))./2;
vNt_ed_pzints_tpos(6) = (vNt_ed_pzint_tzav_tpos(x100n,1) - vNt_ed_pzint_tzav_tpos(x100s,1))./2;


vNt_ed_pzint_sdevs(6) = sqrt((vNt_ed_pzint_var(x100n,1) + vNt_ed_pzint_var(x100s,1))./2)./sqrt(1440) ;
vNt_ed_pzint_sdevs_tneg(6) = sqrt((vNt_ed_pzint_var_tneg(x100n,1) + vNt_ed_pzint_var_tneg(x100s,1))./2)./sqrt(1440) ;
vNt_ed_pzint_sdevs_tpos(6) = sqrt((vNt_ed_pzint_var_tpos(x100n,1) + vNt_ed_pzint_var_tpos(x100s,1))./2)./sqrt(1440) ;




load('/project/rg312/mat_files/vt_paper_plot_125.mat')

vNt_ed_pzints(7) = (vNt_ed_pzint_tzav(x125n,1) - vNt_ed_pzint_tzav(x125s,1))./2;
vNt_ed_pzints_tneg(7) = (vNt_ed_pzint_tzav_tneg(x125n,1) - vNt_ed_pzint_tzav_tneg(x125s,1))./2;
vNt_ed_pzints_tpos(7) = (vNt_ed_pzint_tzav_tpos(x125n,1) - vNt_ed_pzint_tzav_tpos(x125s,1))./2;


vNt_ed_pzint_sdevs(7) = sqrt((vNt_ed_pzint_var(x125n,1) + vNt_ed_pzint_var(x125s,1))./2)./sqrt(1440) ;
vNt_ed_pzint_sdevs_tneg(7) = sqrt((vNt_ed_pzint_var_tneg(x125n,1) + vNt_ed_pzint_var_tneg(x125s,1))./2)./sqrt(1440) ;
vNt_ed_pzint_sdevs_tpos(7) = sqrt((vNt_ed_pzint_var_tpos(x125n,1) + vNt_ed_pzint_var_tpos(x125s,1))./2)./sqrt(1440) ;



load('/project/rg312/mat_files/vt_paper_plot_150.mat')

vNt_ed_pzints(8) = (vNt_ed_pzint_tzav(x150n,1) - vNt_ed_pzint_tzav(x150s,1))./2;
vNt_ed_pzints_tneg(8) = (vNt_ed_pzint_tzav_tneg(x150n,1) - vNt_ed_pzint_tzav_tneg(x150s,1))./2;
vNt_ed_pzints_tpos(8) = (vNt_ed_pzint_tzav_tpos(x150n,1) - vNt_ed_pzint_tzav_tpos(x150s,1))./2;


vNt_ed_pzint_sdevs(8) = sqrt((vNt_ed_pzint_var(x150n,1) + vNt_ed_pzint_var(x150s,1))./2)./sqrt(1440) ;
vNt_ed_pzint_sdevs_tneg(8) = sqrt((vNt_ed_pzint_var_tneg(x150n,1) + vNt_ed_pzint_var_tneg(x150s,1))./2)./sqrt(1440) ;
vNt_ed_pzint_sdevs_tpos(8) = sqrt((vNt_ed_pzint_var_tpos(x150n,1) + vNt_ed_pzint_var_tpos(x150s,1))./2)./sqrt(1440) ;



es0 = [0,0.1,0.25,0.5,0.75,1,1.25,1.5];

filles0 = [es0, fliplr(es0)];
fillerrors = [vNt_ed_pzints+vNt_ed_pzint_sdevs, fliplr(vNt_ed_pzints-vNt_ed_pzint_sdevs)];

fillerrors_tneg = [vNt_ed_pzints_tneg+2.*vNt_ed_pzint_sdevs_tneg, fliplr(vNt_ed_pzints_tneg -2.*vNt_ed_pzint_sdevs_tneg)];
fillerrors_tpos = [vNt_ed_pzints_tpos+2.*vNt_ed_pzint_sdevs_tpos, fliplr(vNt_ed_pzints_tpos -2.*vNt_ed_pzint_sdevs_tpos)];

figure
plot(es0,vNt_ed_pzints,'Linewidth',2);
hold on
plot(es0,vNt_ed_pzints_tpos,'g','Linewidth',2);
plot(es0,vNt_ed_pzints_tneg,'r','Linewidth',2);
fill(filles0,fillerrors,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_tneg,'r','FaceAlpha',0.25)
fill(filles0,fillerrors_tpos,'g','FaceAlpha',0.25)
hold off
set(gca,'FontSize',15);
xlabel('Reference es_{0} fraction')
ylabel('Zonal mean pressure averaged v''T'', Km/s ')
legend('Total','+ve T''','-ve T''','Location','northwest')
print('-dpng','vt_paper_plot_attempt.png')


vNt_tot_incr = vNt_ed_pzints(6) - vNt_ed_pzints(1);
vNt_neg_incr = vNt_ed_pzints_tneg(6) - vNt_ed_pzints_tneg(1);
vNt_pos_incr = vNt_ed_pzints_tpos(6) - vNt_ed_pzints_tpos(1);



