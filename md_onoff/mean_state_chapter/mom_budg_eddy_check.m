load('/project/rg312/mat_files/chapter2_variables/mom_budg_terms_100.mat')


figure
plot(yi(46:90), zeta3v_zon_vint)
hold on
plot(yi(46:90), zeta3v_ed_vint,'--')
plot(yi(46:90), zeta2w_ed_vint,'k--')
plot(yi(46:90), zeta2w_vint,'k')

figure
plot(yi(46:90),zeta3v_tot_vint)
hold on
plot(yi(46:90),urE_vint,'--')
plot(yi(46:90),uzE_vint,'k')

figure
plot(yi(46:90),uadvE_vint)
hold on
plot(yi(46:90),urE_vint+uzE_vint,'r')

figure
plot(yi(46:90),zeta3v_ed_vint + urE_vint)

