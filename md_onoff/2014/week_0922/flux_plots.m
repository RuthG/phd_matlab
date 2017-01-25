% load in SBDART and radiation_mod LW fluxes
% plot vertical profiles of upward and downward fluxes for equator, including separate LW and window parts
% compare with blackbody profiles and with SBDART. Where do our differences come from?
% maybe check blackbody fraction with T vs SBDART???


% choose directory, load grid
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
drC=squeeze(rdmds([rDir,'DRC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
ny=90;

xi=-179:2:180;yi=-89:2:90;
yy=yi*90/60*pi/180;
sinyy=sin(yy);
sst=27*(1-sinyy.*sinyy);
sst(find(abs(yi)>=60))=0;
t_surf=sst+273.15;
p = 2000:4000:98000;
p_half = 0.:4000:100000;
grav 		= 9.8;
cp_air 		= 287.04./(2./7);

load('../week_0915/radmod_lw.mat')
load('../week_0922/lw_sbdart.mat')

heat_lw_tot = heat_lw_u + heat_lw_l + heat_win;
fxdn_lw_tot = fxdn_lw_u + fxdn_lw_l + fxdn_win;
fxup_lw_tot = fxup_lw_u + fxup_lw_l + fxup_win;

heat_lw = heat_lw_l + heat_lw_u;
fxdn_lw = fxdn_lw_l + fxdn_lw_u;
fxup_lw = fxup_lw_l + fxup_lw_u;

b_tot = b + b_win;

figure
plot(fxdn_lw_tot(46,:), p_half,'r')
set(gca,'YDir','reverse')
hold on
plot(fxup_lw_tot(46,:),p_half,'b')
plot(b_tot(46,:),p,'k')
plot(down(46,:),p_half,'r--')
plot(up(46,:),p_half,'b--')
ylabel('Pressure, Pa')
xlabel('Flux, Wm^{-2}')
legend('Downward LW flux','Upward LW flux','Blackbody flux','Location','SouthWest')
title('Total Longwave Fluxes')
print('-dpdf','lw_flux_eq_tot.pdf')

figure
plot(fxdn_win(46,:), p_half,'r')
set(gca,'YDir','reverse')
hold on
plot(fxup_win(46,:),p_half,'b')
plot(b_win(46,:),p,'k')
plot(down_win(46,:),p_half,'r--')
plot(up_win(46,:),p_half,'b--')
ylabel('Pressure, Pa')
xlabel('Flux, Wm^{-2}')
legend('Downward LW flux','Upward LW flux','Blackbody flux','Location','SouthWest')
title('Window Region Fluxes')
print('-dpdf','lw_flux_eq_win.pdf')

figure
plot(fxdn_lw(46,:), p_half,'r')
set(gca,'YDir','reverse')
hold on
plot(fxup_lw(46,:),p_half,'b')
plot(b(46,:),p,'k')
plot(down(46,:) - down_win(46,:),p_half,'r--')
plot(up(46,:) - up_win(46,:),p_half,'b--')
ylabel('Pressure, Pa')
xlabel('Flux, Wm^{-2}')
legend('Downward LW flux','Upward LW flux','Blackbody flux','Location','SouthWest')
title('Non-Window Region Fluxes')
print('-dpdf','lw_flux_eq_nonwin.pdf')


figure
plot(yi(2:89),fxdn_lw(2:89,1))
hold on
plot(yi(2:89),fxdn_win(2:89,1),'r')
ylabel('SBDART Downward LW Flux, Top Level, Wm^{-2}')
xlabel('Latitude')
legend('Non-window','Window')
print('-dpdf','fxdn_lw_top.pdf')




figure
plot(fxdn_lw_tot(88,:), p_half,'r')
set(gca,'YDir','reverse')
hold on
plot(fxup_lw_tot(88,:),p_half,'b')
plot(b_tot(88,:),p,'k')
plot(down(88,:),p_half,'r--')
plot(up(88,:),p_half,'b--')
ylabel('Pressure, Pa')
xlabel('Flux, Wm^{-2}')
legend('Downward LW flux','Upward LW flux','Blackbody flux','Location','SouthWest')
title('Total Longwave Fluxes')
print('-dpdf','lw_flux_eq_tot_85.pdf')

figure
plot(fxdn_win(88,:), p_half,'r')
set(gca,'YDir','reverse')
hold on
plot(fxup_win(88,:),p_half,'b')
plot(b_win(88,:),p,'k')
plot(down_win(88,:),p_half,'r--')
plot(up_win(88,:),p_half,'b--')
ylabel('Pressure, Pa')
xlabel('Flux, Wm^{-2}')
legend('Downward LW flux','Upward LW flux','Blackbody flux','Location','SouthWest')
title('Window Region Fluxes')
print('-dpdf','lw_flux_eq_win_85.pdf')

figure
plot(fxdn_lw(88,:), p_half,'r')
set(gca,'YDir','reverse')
hold on
plot(fxup_lw(88,:),p_half,'b')
plot(b(88,:),p,'k')
plot(down(88,:) - down_win(88,:),p_half,'r--')
plot(up(88,:) - up_win(88,:),p_half,'b--')
ylabel('Pressure, Pa')
xlabel('Flux, Wm^{-2}')
legend('Downward LW flux','Upward LW flux','Blackbody flux','Location','SouthWest')
title('Non-Window Region Fluxes')
print('-dpdf','lw_flux_eq_nonwin_85.pdf')



figure
plot(fxdn_lw_tot(71,:), p_half,'r')
set(gca,'YDir','reverse')
hold on
plot(fxup_lw_tot(71,:),p_half,'b')
plot(b_tot(71,:),p,'k')
plot(down(71,:),p_half,'r--')
plot(up(71,:),p_half,'b--')
ylabel('Pressure, Pa')
xlabel('Flux, Wm^{-2}')
legend('Downward LW flux','Upward LW flux','Blackbody flux','Location','SouthWest')
title('Total Longwave Fluxes')
print('-dpdf','lw_flux_eq_tot_50.pdf')

figure
plot(fxdn_win(71,:), p_half,'r')
set(gca,'YDir','reverse')
hold on
plot(fxup_win(71,:),p_half,'b')
plot(b_win(71,:),p,'k')
plot(down_win(71,:),p_half,'r--')
plot(up_win(71,:),p_half,'b--')
ylabel('Pressure, Pa')
xlabel('Flux, Wm^{-2}')
legend('Downward LW flux','Upward LW flux','Blackbody flux','Location','SouthWest')
title('Window Region Fluxes')
print('-dpdf','lw_flux_eq_win_50.pdf')

figure
plot(fxdn_lw(71,:), p_half,'r')
set(gca,'YDir','reverse')
hold on
plot(fxup_lw(71,:),p_half,'b')
plot(b(71,:),p,'k')
plot(down(71,:) - down_win(71,:),p_half,'r--')
plot(up(71,:) - up_win(71,:),p_half,'b--')
ylabel('Pressure, Pa')
xlabel('Flux, Wm^{-2}')
legend('Downward LW flux','Upward LW flux','Blackbody flux','Location','SouthWest')
title('Non-Window Region Fluxes')
print('-dpdf','lw_flux_eq_nonwin_50.pdf')








return

load('../week_0922/radmod_lw_win.mat')

figure
plot(fxdn_lw_tot(46,:), p_half,'r')
set(gca,'YDir','reverse')
hold on
plot(fxup_lw_tot(46,:),p_half,'b')
plot(b_tot(46,:),p,'k')
plot(down(46,:),p_half,'r--')
plot(up(46,:),p_half,'b--')
ylabel('Pressure, Pa')
xlabel('Flux, Wm^{-2}')
legend('Downward LW flux','Upward LW flux','Blackbody flux','Location','SouthWest')
title('Total Longwave Fluxes')
print('-dpdf','lw_flux_eq_tot_2.pdf')

figure
plot(fxdn_win(46,:), p_half,'r')
set(gca,'YDir','reverse')
hold on
plot(fxup_win(46,:),p_half,'b')
plot(b_win(46,:),p,'k')
plot(down_win(46,:),p_half,'r--')
plot(up_win(46,:),p_half,'b--')
ylabel('Pressure, Pa')
xlabel('Flux, Wm^{-2}')
legend('Downward LW flux','Upward LW flux','Blackbody flux','Location','SouthWest')
title('Window Region Fluxes')
print('-dpdf','lw_flux_eq_win_2.pdf')

figure
plot(fxdn_lw(46,:), p_half,'r')
set(gca,'YDir','reverse')
hold on
plot(fxup_lw(46,:),p_half,'b')
plot(b(46,:),p,'k')
plot(down(46,:) - down_win(46,:),p_half,'r--')
plot(up(46,:) - up_win(46,:),p_half,'b--')
ylabel('Pressure, Pa')
xlabel('Flux, Wm^{-2}')
legend('Downward LW flux','Upward LW flux','Blackbody flux','Location','SouthWest')
title('Non-Window Region Fluxes')
print('-dpdf','lw_flux_eq_nonwin_2.pdf')
