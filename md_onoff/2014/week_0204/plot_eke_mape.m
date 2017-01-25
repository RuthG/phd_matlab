%Plot up eke and mape again...

load('simp_mape_top_wv_on_rad_off_run_5year_c.mat')
smape_v(:,1) = simp_mape_vert;
smape(1) = simple_mape;
smape_v_top(1) = sum(simp_mape_vert(14:25));
smape_wvon(1) = simple_mape;
dthdysq(:,1) = dthetady_bzav.^2;
mwth(:,1) = 4000.*merid_width.^2./theta_bzav./8;
odthdz(:,1) = 1./dthetadz_bzav;

load('simp_mape_top_wv_off_rad_off_run_5year_c.mat')
smape_v(:,2) = simp_mape_vert;
smape(2) = simple_mape;
smape_v_top(2) = sum(simp_mape_vert(14:25));
dthdysq(:,2) = dthetady_bzav.^2;
mwth(:,2) = 4000.*merid_width.^2./theta_bzav./8;
odthdz(:,2) = 1./dthetadz_bzav;

load('simp_mape_top_wv_on_rad_off_run_5year_p_2014.mat')
smape_v(:,3) = simp_mape_vert;
smape(3) = simple_mape;
smape_wvon(2) = simple_mape;
smape_v_top(3) = sum(simp_mape_vert(14:25));
dthdysq(:,3) = dthetady_bzav.^2;
mwth(:,3) = 4000.*merid_width.^2./theta_bzav./8;
odthdz(:,3) = 1./dthetadz_bzav;

load('simp_mape_top_wv_on_rad_on_run_10yearradon.mat')
smape_v(:,4) = simp_mape_vert;
smape(4) = simple_mape;
smape_wvon(3) = simple_mape;
smape_v_top(4) = sum(simp_mape_vert(14:25));
dthdysq(:,4) = dthetady_bzav.^2;
mwth(:,4) = 4000.*merid_width.^2./theta_bzav./8;
odthdz(:,4) = 1./dthetadz_bzav;

load('simp_mape_top_wv_on_rad_off_run_halfwv.mat')
smape_v(:,5) = simp_mape_vert;
smape(5) = simple_mape;
smape_v_top(5) = sum(simp_mape_vert(14:25));
dthdysq(:,5) = dthetady_bzav.^2;
mwth(:,5) = 4000.*merid_width.^2./theta_bzav./8;
odthdz(:,5) = 1./dthetadz_bzav;

load('simp_mape_top_wv_on_rad_off_run_quarterwv.mat')
smape_v(:,6) = simp_mape_vert;
smape(6) = simple_mape;
smape_v_top(6) = sum(simp_mape_vert(14:25));
dthdysq(:,6) = dthetady_bzav.^2;
mwth(:,6) = 4000.*merid_width.^2./theta_bzav./8;
odthdz(:,6) = 1./dthetadz_bzav;

load('eke_top_wv_on_rad_off_run_5year_c.mat')
eke_v(:,1) = eke_vert_check;
eke_h(:,1) = eke_jm2./cos(ylat'.*pi./180);
eke(1) = eke_diag;
eke_wvon(1) = eke_diag;

load('eke_top_wv_off_rad_off_run_5year_c.mat')
eke_v(:,2) = eke_vert_check;
eke_h(:,2) = eke_jm2./cos(ylat'.*pi./180);
eke(2) = eke_diag;

load('eke_top_wv_on_rad_off_run_5year_p_2014.mat')
eke_v(:,3) = eke_vert_check;
eke_h(:,3) = eke_jm2./cos(ylat'.*pi./180);
eke(3) = eke_diag;
eke_wvon(2) = eke_diag;
                          
load('eke_top_wv_on_rad_on_run_10yearradon.mat')
eke_v(:,4) = eke_vert_check;
eke_h(:,4) = eke_jm2./cos(ylat'.*pi./180);
eke(4) = eke_diag;
eke_wvon(3) = eke_diag;
                          
load('eke_top_wv_on_rad_off_run_halfwv.mat')
eke_v(:,5) = eke_vert_check;
eke_h(:,5) = eke_jm2./cos(ylat'.*pi./180);
eke(5) = eke_diag;

load('eke_top_wv_on_rad_off_run_quarterwv.mat')
eke_v(:,6) = eke_vert_check;
eke_h(:,6) = eke_jm2./cos(ylat'.*pi./180);
eke(6) = eke_diag;

plot(eke_v,rC)
set(gca,'YDir','reverse')
xlabel('EKE, J/m^2')
ylabel('Pressure, Pa')
legend('Control','WV Off','Heat Pert','Rad on','0.5 WV','0.25 WV','Location','SouthEast')
name = ['eke_vert_allruns.png'];
print('-dpng',name)

plot(ylat,eke_h)
ylabel('EKE, J/m^2')
xlabel('Latitude')
legend('Control','WV Off','Heat Pert','Rad on','0.5 WV','0.25 WV','Location','NorthEast')
name = ['eke_horiz_allruns.png'];
print('-dpng',name)
                          
plot(smape_v,rC)
set(gca,'YDir','reverse')
xlabel('MAPE, J/m^2')
ylabel('Pressure, Pa')
legend('Control','WV Off','Heat Pert','Rad on','0.5 WV','0.25 WV','Location','NorthEast')
name = ['simp_mape_vert_allruns.png'];
print('-dpng',name)
                          
plot(smape,eke,'x')
xlabel('MAPE, J/m^2')
ylabel('EKE, J/m^2')
name = ['simp_mape_vs_eke.png'];
print('-dpng',name)

plot(smape_v_top,eke,'x')
xlabel('MAPE above 460hPa, J/m^2')
ylabel('EKE, J/m^2')
name = ['simp_mape_top_vs_eke.png'];
print('-dpng',name)
                          
plot(smape_wvon,eke_wvon,'x')
xlabel('MAPE, J/m^2')
ylabel('EKE, J/m^2')
name = ['simp_mape_vs_eke_wvon.png'];
print('-dpng',name)

plot(dthdysq,rC)
set(gca,'YDir','reverse')
xlabel('dthetady^2')
ylabel('Pressure, Pa')
legend('Control','WV Off','Heat Pert','Rad on','0.5 WV','0.25 WV','Location','NorthEast')
name = ['dthetadysq.png'];
print('-dpng',name)

plot(mwth,rC)
set(gca,'YDir','reverse')
xlabel('Meridional width sq over theta')
ylabel('Pressure, Pa')
legend('Control','WV Off','Heat Pert','Rad on','0.5 WV','0.25 WV','Location','NorthEast')
name = ['mwth.png'];
print('-dpng',name)

plot(odthdz,rC)
set(gca,'YDir','reverse')
xlabel('1 / dthetadz')
ylabel('Pressure, Pa')
legend('Control','WV Off','Heat Pert','Rad on','0.5 WV','0.25 WV','Location','NorthEast')
name = ['odthdz.png'];
print('-dpng',name)
