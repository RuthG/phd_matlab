%load in the boundary layer v'T' and the troposphere v'T' plot bits, and get the boundary layer height up
%take mean of troposphere bit, and then redo surface-troposphere plot using the boundary layer height and v'T' bits... Does it look like the total at all?

load('/project/rg312/mat_files/vNt_paper_plot_data_blayer.mat')
vNt_pzints_blayer = vNt_ed_pzints;
vNt_pzints_tneg_blayer = vNt_ed_pzints_tneg;
vNt_pzints_tpos_blayer = vNt_ed_pzints_tpos;
vNt_ed_pzint_sdevs_blayer = vNt_ed_pzint_sdevs;
vNt_ed_pzint_sdevs_tneg_blayer = vNt_ed_pzint_sdevs_tneg;
vNt_ed_pzint_sdevs_tpos_blayer = vNt_ed_pzint_sdevs_tpos;

load('/project/rg312/mat_files/vNt_paper_plot_data_trop.mat')
vNt_pzints_trop = vNt_ed_pzints;
vNt_pzints_tneg_trop = vNt_ed_pzints_tneg;
vNt_pzints_tpos_trop = vNt_ed_pzints_tpos;
vNt_ed_pzint_sdevs_trop = vNt_ed_pzint_sdevs;
vNt_ed_pzint_sdevs_tneg_trop = vNt_ed_pzint_sdevs_tneg;
vNt_ed_pzint_sdevs_tpos_trop = vNt_ed_pzint_sdevs_tpos;

load('/project/rg312/mat_files/vNt_paper_plot_data_troplid.mat')
vNt_pzints_troplid = vNt_ed_pzints;
vNt_pzints_tneg_troplid = vNt_ed_pzints_tneg;
vNt_pzints_tpos_troplid = vNt_ed_pzints_tpos;
vNt_ed_pzint_sdevs_troplid = vNt_ed_pzint_sdevs;
vNt_ed_pzint_sdevs_tneg_troplid = vNt_ed_pzint_sdevs_tneg;
vNt_ed_pzint_sdevs_tpos_troplid = vNt_ed_pzint_sdevs_tpos;

load('/project/rg312/mat_files/blayer_trop_levs.mat');
load('/project/rg312/mat_files/vt_lats_best.mat');

h(1) = b_lev_000(x000n);
h(2) = b_lev_010(x010n);
h(3) = b_lev_025(x025n);
h(4) = b_lev_050(x050n);
h(5) = b_lev_075(x075n);
h(6) = b_lev_100(x100n);

ht(1) = trop_lev_000(x000n);
ht(2) = trop_lev_010(x010n);
ht(3) = trop_lev_025(x025n);
ht(4) = trop_lev_050(x050n);
ht(5) = trop_lev_075(x075n);
ht(6) = trop_lev_100(x100n);


vNt_pzints_av_trop = (vNt_pzints_tneg_trop + vNt_pzints_tpos_trop)./2;
vNt_pzint_sdev_av_trop = sqrt(vNt_ed_pzint_sdevs_tneg_trop.^2 + vNt_ed_pzint_sdevs_tneg_trop.^2)./2;

es0 = [0,0.1,0.25,0.5,0.75,1];

vNt_pzints_tneg_est = vNt_pzints_tneg_blayer.*h/20 + vNt_pzints_av_trop.*(20-h)./20;
vNt_pzint_sdev_tneg_est = sqrt( (vNt_ed_pzint_sdevs_tneg_blayer.*h/20).^2 + (vNt_pzint_sdev_av_trop.*(20-h)./20).^2 );

vNt_pzints_tpos_est = vNt_pzints_tpos_blayer.*h/20 + vNt_pzints_av_trop.*(20-h)./20;
vNt_pzint_sdev_tpos_est = sqrt( (vNt_ed_pzint_sdevs_tpos_blayer.*h/20).^2 + (vNt_pzint_sdev_av_trop.*(20-h)./20).^2 );


filles0 = [es0, fliplr(es0)];
fillerrors_tl = [vNt_pzints_troplid+2.*vNt_ed_pzint_sdevs_troplid, fliplr(vNt_pzints_troplid-2.*vNt_ed_pzint_sdevs_troplid)];

fillerrors_tl_tneg = [vNt_pzints_tneg_troplid+2.*vNt_ed_pzint_sdevs_tneg_troplid, fliplr(vNt_pzints_tneg_troplid -2.*vNt_ed_pzint_sdevs_tneg_troplid)];
fillerrors_tl_tpos = [vNt_pzints_tpos_troplid+2.*vNt_ed_pzint_sdevs_tpos_troplid, fliplr(vNt_pzints_tpos_troplid -2.*vNt_ed_pzint_sdevs_tpos_troplid)];


fillerrors_est_tneg = [vNt_pzints_tneg_est+2.*vNt_pzint_sdev_tneg_est, fliplr(vNt_pzints_tneg_est -2.*vNt_pzint_sdev_tneg_est)];
fillerrors_est_tpos = [vNt_pzints_tpos_est+2.*vNt_pzint_sdev_tpos_est, fliplr(vNt_pzints_tpos_est -2.*vNt_pzint_sdev_tpos_est)];



figure
plot(es0,vNt_pzints_troplid,'k','Linewidth',2);
hold on
plot(es0,vNt_pzints_tpos_troplid,'r','Linewidth',2);
plot(es0,vNt_pzints_tneg_troplid,'b','Linewidth',2);
fill(filles0,fillerrors_tl,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_tl_tneg,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_tl_tpos,'r','FaceAlpha',0.25)

plot(es0,vNt_pzints_tpos_est,'r--','Linewidth',2);
plot(es0,vNt_pzints_tneg_est,'b--','Linewidth',2);
fill(filles0,fillerrors_est_tneg,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_est_tpos,'r','FaceAlpha',0.25)

hold off
ylim([2 16])
set(gca,'FontSize',15);
xlabel('Reference es_{0} fraction')
ylabel('Zonal mean pressure averaged v''T'', Km/s ')
legend('Total','+ve T''','-ve T''','Location','northwest')
print('-dpng','vt_paper_plot_estimate.png')




plot(es0,vNt_pzints_av_tneg_full,'b--')
hold on
plot(es0,vNt_pzints_av_tpos_full,'r--')
plot(es0,vNt_pzints_tneg_troplid,'b')
plot(es0,vNt_pzints_tpos_troplid,'r')
plot(es0,vNt_pzints_troplid,'k')




