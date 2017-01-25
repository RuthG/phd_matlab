%load lwin and normal lw data and hope to god the incident amount doesn't matter too much at the surface!

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0922/radmod_lw_lwin.mat')

down_lwin = down;

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0915/radmod_lw.mat')


load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0922/lw_sbdart.mat')
p_half = 0.:4000:100000;
fxdn_lw_tot = fxdn_lw_u + fxdn_lw_l + fxdn_win;

figure
plot(fxdn_lw_tot(46,:), p_half,'r')
set(gca,'YDir','reverse')
hold on
plot(down(46,:),p_half,'r--')
plot(down_lwin(46,:),p_half,'r:')
ylabel('Pressure, Pa')
xlabel('Flux, Wm^{-2}')
title('Total Longwave Fluxes')
print('-dpdf','lw_flux_eq_wlin.pdf')
