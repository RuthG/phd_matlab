%fit_lw.m
%Try to fit params in dtau/dsigma = amu + bq so we have 2 fits for window and non-window wavelengths

load('~/matlab/sbdart_ozone/standard_profs.mat')
t_surf = [299.70 , 294.20 , 272.20 , 287.20 , 257.20 , 288.20];
p = flipud(p_ml);
p_half = 0:40:1000;
t = flipud(t_ml);
q = flipud(h2o_q_ml);

for i = 1:6
output_lw1(:,:,i) = dlmread(['~/matlab/longwave_2/out/OUTPUT_lw1' num2str(i)]);
output_lw2(:,:,i) = dlmread(['~/matlab/longwave_2/out/OUTPUT_lw2' num2str(i)]);
output_win(:,:,i) = dlmread(['~/matlab/longwave_2/out/OUTPUT_win' num2str(i)]);
end

%translate fluxes onto half layers as in MITgcm
for i=1:6
fxdn_lw1(:,i)  = output_lw1(2:26,3,i);
fxup_lw1(:,i)  = output_lw1(2:26,4,i);
heat_lw1(:,i)  = output_lw1(2:26,7,i);
fxdn_lw2(:,i)  = output_lw2(2:26,3,i);
fxup_lw2(:,i)  = output_lw2(2:26,4,i);
heat_lw2(:,i)  = output_lw2(2:26,7,i);
fxdn_win(:,i)  = output_win(2:26,3,i);
fxup_win(:,i)  = output_win(2:26,4,i);
heat_win(:,i)  = output_win(2:26,7,i);
end

fxdn_half_lw1 = interp1(p,fxdn_lw1,p_half,'linear','extrap');
fxup_half_lw1 = interp1(p,fxup_lw1,p_half,'linear','extrap');

fxdn_half_lw2 = interp1(p,fxdn_lw2,p_half,'linear','extrap');
fxup_half_lw2 = interp1(p,fxup_lw2,p_half,'linear','extrap');

fxdn_half_win = interp1(p,fxdn_win,p_half,'linear','extrap');
fxup_half_win = interp1(p,fxup_win,p_half,'linear','extrap');

stefan 	= 5.6734e-8;
b = stefan*t.^4;
b_surf = stefan*t_surf.^4;


fxdn_half = fxdn_half_lw1 + fxdn_half_lw2;
fxup_half = fxup_half_lw1 + fxup_half_lw2;

fxdn_total = fxdn_half + fxdn_half_win;
fxup_total = fxup_half + fxup_half_win;


%estimate fraction of radiation in window
%total upward flux at equator for the MITgcm profile used for 'check_window.m' is: 451.8591
%in window flux is: 168.6363
window = 168.6363./451.8591;  %window = 0.3732;

for i=1:6
for k=1:25

dtrans_dn_tot(k,i) = (fxdn_total(k+1,i) - b(k,i))./(fxdn_total(k,i) - b(k,i));
dtrans_up_tot(k,i) = (fxup_total(k,i) - b(k,i))./(fxup_total(k+1,i) - b(k,i));

dtrans_dn(k,i) = (fxdn_half(k+1,i) - (1-window).*b(k,i))./(fxdn_half(k,i) - (1-window).*b(k,i));
dtrans_up(k,i) = (fxup_half(k,i) - (1-window).*b(k,i))./(fxup_half(k+1,i)-(1-window).*b(k,i));

dtrans_dn_win(k,i) = (fxdn_half_win(k+1,i) - window.*b(k,i))./(fxdn_half_win(k,i) - window.*b(k,i));
dtrans_up_win(k,i) = (fxup_half_win(k,i) - window.*b(k,i))./(fxup_half_win(k+1,i) - window.*b(k,i));

dtrans_dn_lw1(k,i) = (fxdn_half_lw1(k+1,i) - 0.14.*b(k,i))./(fxdn_half_lw1(k,i) - 0.14.*b(k,i));
dtrans_up_lw1(k,i) = (fxup_half_lw1(k,i) - 0.14.*b(k,i))./(fxup_half_lw1(k+1,i)-0.14.*b(k,i));

dtrans_dn_lw2(k,i) = (fxdn_half_lw2(k+1,i) - 0.4868.*b(k,i))./(fxdn_half_lw2(k,i) - 0.4868.*b(k,i));
dtrans_up_lw2(k,i) = (fxup_half_lw2(k,i) - 0.4868.*b(k,i))./(fxup_half_lw2(k+1,i)-0.4868.*b(k,i));

del_tau_dn_tot(k,i) = -log(dtrans_dn_tot(k,i));
del_tau_up_tot(k,i) = -log(dtrans_up_tot(k,i));

del_tau_dn(k,i) = -log(dtrans_dn(k,i));
del_tau_up(k,i) = -log(dtrans_up(k,i));

del_tau_dn_win(k,i) = -log(dtrans_dn_win(k,i));
del_tau_up_win(k,i) = -log(dtrans_up_win(k,i));

del_tau_dn_lw1(k,i) = -log(dtrans_dn_lw1(k,i));
del_tau_up_lw1(k,i) = -log(dtrans_up_lw1(k,i));

del_tau_dn_lw2(k,i) = -log(dtrans_dn_lw2(k,i));
del_tau_up_lw2(k,i) = -log(dtrans_up_lw2(k,i));

end
end
