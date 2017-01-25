%lacis_hansen.m
%For idealised water vapour profiles, work out absorption using formula of lacis and hansen

%load profiles
load('~/matlab/sbdart_ozone/standard_profs.mat')

alts_ml = flipud(alts_ml);
p_ml = flipud(p_ml);
h2o_dens_ml = flipud(h2o_dens_ml);
h2o_q_ml = flipud(h2o_q_ml);
t_ml = flipud(t_ml);

for i=1:24
alts_half(i,:) = (alts_ml(i,:) + alts_ml(i+1,:)) ./2;
dalts(i,:) = (alts_ml(i,:) - alts_ml(i+1,:)).*1000.;
dp(i,1) = (p_ml(i+1) - p_ml(i));
p_half_p(i,1) = (p_ml(i) + p_ml(i+1))./2;
end

for i=1:6
h2o_dens_half(:,i) = interp1(alts_ml(:,i),h2o_dens_ml(:,i),alts_half(:,i));
h2o_q_half(:,i) = interp1(alts_ml(:,i),h2o_q_ml(:,i),alts_half(:,i));
p_half(:,i) = interp1(alts_ml(:,i),p_ml(:,1),alts_half(:,i));
t_half(:,i) = interp1(alts_ml(:,i),t_ml(:,i),alts_half(:,i)); 
end

grav=9.8;
spd = 24.*60.*60;
cp_air = 287.04./(2./7);
mag = 35./(1224.*(cos(lat.*pi./180.)).^2 + 1).^0.5;

for j=1:6
for i=1:24
pw(i,j) = h2o_dens_half(i,j).*dalts(i,j).*100./1000000.;
pw_eff(i,j) = mag(1,j).*h2o_dens_half(i,j).*dalts(i,j).*100./1000000.*(p_half(i,j)./1013).*(273./t_half(i,j)).^0.5;
pw_alt(i,j) = h2o_q_half(i,j).*(p_half_p(i,1)./1013).*(273./t_half(i,j)).^0.5.*dp(i,1)./grav;
end
end

pw_int = cumsum(pw,1);
pw_int_eff = cumsum(pw_eff,1);
pw_int_alt = cumsum(pw_alt,1);


abs_yam = 2.9.*pw_int./((1 + 141.5.*pw_int).^0.635 + 5.925.*pw_int);
abs_lh = 2.9.*pw_int_eff./((1 + 141.5.*pw_int_eff).^0.635 + 5.925.*pw_int_eff);

abs_fowl = 0.0946.*pw_int.^0.303;

log102abskorb = -0.74 + 0.347.*log10(pw_int) - 0.056.*(log10(pw_int)).^2 - 0.006*(log10(pw_int)).^3;
abs_korb = 0.5.*10.^log102abskorb;

plot(log10(pw_int),abs_yam,'k')
hold on
plot(log10(pw_int),abs_fowl,'k.')
plot(log10(pw_int),abs_korb,'k--')
%plot(log10(pw_int),abs_lh,'r')
hold off

return
solar_constant = 1360.;
ss = sin(lat*pi./180.);
p2 = (1. - 3.*ss.^2)./4;
solar = 0.25.*solar_constant.*(1.0 + 1.4.*p2);
sw_down_yam(1,:) = solar;
sw_down_lh(1,:) = solar;
sw_down_fowl(1,:) = solar;
sw_down_korb(1,:) = solar;

trans_yam = 1-abs_yam;
trans_lh = 1-abs_lh;
trans_fowl = 1-abs_fowl;
trans_korb = 1-abs_korb;

for i=1:6
sw_down_yam(2:25,i) = solar(1,i).*trans_yam(1:24,i);
sw_down_lh(2:25,i) = solar(1,i).*trans_lh(1:24,i);
sw_down_fowl(2:25,i) = solar(1,i).*trans_fowl(1:24,i);
sw_down_korb(2:25,i) = solar(1,i).*trans_korb(1:24,i);

end


for k=1:24
  tdt_sw_yam(k,:) = -spd.*(sw_down_yam(k+1,:) - sw_down_yam(k,:)).*grav./(cp_air.*100.*(p_ml(k+1,:) - p_ml(k,:)));
  tdt_sw_lh(k,:) = -spd.*(sw_down_lh(k+1,:) - sw_down_lh(k,:)).*grav./(cp_air.*100.*(p_ml(k+1,:) - p_ml(k,:)));
  tdt_sw_fowl(k,:) = -spd.*(sw_down_fowl(k+1,:) - sw_down_fowl(k,:)).*grav./(cp_air.*100.*(p_ml(k+1,:) - p_ml(k,:)));
  tdt_sw_korb(k,:) = -spd.*(sw_down_korb(k+1,:) - sw_down_korb(k,:)).*grav./(cp_air.*100.*(p_ml(k+1,:) - p_ml(k,:)));

end

plot(tdt_sw_yam(:,1)./cos(lat(1)*pi./180),p_half(:,1),'k')
hold on
plot(tdt_sw_lh(:,1)./cos(lat(1)*pi./180),p_half(:,1),'r')
plot(tdt_sw_fowl(:,1),p_half(:,1),'k.')
plot(tdt_sw_korb(:,1),p_half(:,1),'k--')
set(gca,'YDir','reverse')
xlabel('SW heating, K/day')
ylabel('Pressure, Pa')
