%radiation_mod.m
%load up modtran profiles and run through MITgcm radiation code translated into matlab

function tdt_lw = radiation_mod_fun(profile,lwout1,lwout2);

%load profiles
load('~/matlab/sbdart_ozone/standard_profs.mat')
%profile = 6

q = flipud(h2o_q_ml(:,profile));
t = flipud(t_ml(:,profile));
p = 100.*flipud(p_ml);
p_half = 0.:4000:100000;
yy=lat(:,profile)*90/60*pi/180;
sinyy=sin(yy);
sst=27*(1-sinyy.*sinyy);
sst(find(abs(lat(:,profile))>=60))=0;
t_surf=[299.70 , 294.20 , 272.20 , 287.20 , 257.20 , 288.20]; %sst+273.15;

%define constants
solar_constant 	= 1360.0;
del_sol		= 1.4;
del_sw 		= 0.;
ir_tau_eq	= 6.;
ir_tau_pole 	= 1.5;
linear_tau 	= 0.1;
ir_tau_co2 	= 2.2291;
ir_tau_wv 	= 298.6535;
atm_abs 	= 0.;
sw_diff 	= 0.0;
albedo_value 	= 0.06;
window 		= 0.;
wv_exponent 	= 0.0;
solar_exponent 	= 0.0;
sw_co2 		= 0.0596;
ozone_a 	= 5.787e-6;
ozone_b 	= -300.;
ozone_c 	= 0.001;
ozone_d 	= 0.;
sizep 		= 90.;
l_trop 		= zeros(91);
p_trop 		= zeros(90);
heat_pert 	= 0.; %3e-6;
deg_to_rad 	= pi./180.;
grav 		= 9.8;
cp_air 		= 287.04./(2./7);
lat		= lat(:,profile).*deg_to_rad;
stefan 	= 5.6734e-8;

n = size(p,1);


ss = sin(lat);
p2 = (1. - 3.*ss.^2)./4;
solar = 0.25.*solar_constant.*(1.0 + del_sol.*p2 + del_sw.*ss);
tau_0 = ir_tau_eq + (ir_tau_pole - ir_tau_eq).*ss.^2;

albedo = albedo_value;

solar_tau = zeros(n);
solar_tau(1) = 0.;
mag_fac = 1.; % 35.0./sqrt(1224.*cos(lat).^2 +1);

if solar_exponent == 0.
  for k=1:n;
   sw_wv = exp(0.01887./(solar_tau(k) + 0.009522) + 1.603./((solar_tau(k) + 0.5194).^2));
   del_sol_tau = ( sw_co2 + sw_wv.*q(k) ) .* mag_fac .* (p_half(k+1) - p_half(k))./p_half(n+1);
   solar_tau(k+1) = solar_tau(k) + del_sol_tau;
   dtrans_sol(k) = exp( -del_sol_tau);
  end

else
  solar_tau_0 = (1. - sw_diff.*ss.^2).*atm_abs;
  k=1;
  solar_tau(k) = solar_tau_0.*(p_half(k)./p_half(n+1)).^solar_exponent;
  for k=1:n+1
      solar_tau(k) = solar_tau_0.*(p_half(k)./p_half(n+1)).^solar_exponent;
      dtrans_sol(k-1) = exp(-(solar_tau(k) - solar_tau(k-1)));
  end
end

if wv_exponent == 0.
window = 168.6363./451.8591;  %window = 0.3732;
  for k= 1:n
    %del_tau = (ir_tau_co2 + ir_tau_wv.*q(k)).*(p_half(k+1) - p_half(k))./p_half(n+1);
    del_tau_win = (1.0814e4 .* q(k).^2 + 147.11 .* q(k) + 0.2150).*(p_half(k+1) - p_half(k))./p_half(n+1);
    dtrans_win(k) = exp(-del_tau_win);
   % del_tau = (464.788 .* q(k).^0.5 -1.60346).*(p_half(k+1) - p_half(k))./p_half(n+1);
   % del_tau = (351.48 .* q(k).^0.5 + 0.154925).*(p_half(k+1) - p_half(k))./p_half(n+1);
    del_tau = (lwout1 .* q(k).^0.5 + lwout2).*(p_half(k+1) - p_half(k))./p_half(n+1);
    dtrans(k) = exp(-del_tau);
  end

else
  k=1;
  tau_kp = tau_0.*(linear_tau.*p_half(k)./p_half(n+1) + (1. - linear_tau).*(p_half(k)./p_half(n+1)).^wv_exponent);
  for k=1:n
    tau_km = tau_kp;
    tau_kp = tau_0.*(linear_tau.*p_half(k+1)./p_half(n+1) + (1. - linear_tau).*(p_half(k+1)./p_half(n+1)).^wv_exponent);
    dtrans(k) = exp(-(tau_kp - tau_km));
  end
end

b = (1. - window).*stefan.*t.^4;
b_win = (window).*stefan.*t.^4;

down(1) = 0.;
down_win(1) = 0.;
for k=1:n
  down(k+1) = down(k).*dtrans(k) + b(k).*(1. - dtrans(k));
  down_win(k+1) = down_win(k).*dtrans_win(k) + b_win(k).*(1. - dtrans_win(k));
end

%down = down + down_win; 

solar_down(1) = solar;
for k = 1:n
  solar_down(k+1) = solar_down(k).*dtrans_sol(k);
end

surf_lw_down = down(n+1);
net_surf_sw_down = solar_down(n+1).*(1.-albedo);


%radiation_up

b_surf = stefan.*t_surf.^4;  %stefan.*t(25).^4;  

up(n+1) = b_surf(profile).*(1.-window);
up_win(n+1) = b_surf(profile).*(window);

for k=n:-1:1
  up(k) = up(k+1).*dtrans(k) + b(k).*(1. - dtrans(k));
  up_win(k) = up_win(k+1).*dtrans_win(k) + b_win(k).*(1. - dtrans_win(k));
end

%for k = 1:n+1
%  up(k) = up(k) + b_surf.*window;
%end

%up = up_win + up; 

for k=1:n+1
  net(k) = up(k) - down(k);
  flux_sw(k) = albedo.*solar_down(n+1) - solar_down(k);
  flux_rad(k) = net(k) + flux_sw(k);
end

l_trop_rad = l_trop.*deg_to_rad;
trop_press = p_trop(min(find(lat >= l_trop_rad)));
  

%longwave heating
tdt_lw(1) = (net(2) - net(1)).*grav./(cp_air.*(p_half(2) - p_half(1)));
if tdt_lw(1) > 0.
  tdt_lw(1) = 0.;
end

tdt_sw(1) = 0.;
%tdt_sw(1) = (flux_sw(2) - flux_sw(1)).*grav./(cp_air.*(p_half(2) - p_half(1)));

ozone_heat(1) = ozone_a.*exp(ozone_b.*((p_half(1) + p_half(2))./(2.*p_half(n+1)) - ozone_c).^2) + ozone_d;

tdt_pert = zeros(size(n));
tdt_pert(find(trop_press >= (p_half(1) + p_half(2))./2)) = heat_pert;

for k=1:n
  tdt_lw(k) = (net(k+1) - net(k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
  %if tdt_lw(k) > 0.
  %  tdt_lw(k) = 0.;
  %end

  tdt_sw(k) = (flux_sw(k+1) - flux_sw(k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));

  ozone_heat(k) = ozone_a.*exp(ozone_b.*((p_half(k) + p_half(k+1))./(2.*p_half(n+1)) - ozone_c).^2) + ozone_d;

  tdt_pert(find(trop_press >= (p_half(k) + p_half(k+1))./2)) = heat_pert;

end


tdt_radscheme = tdt_lw + tdt_sw + tdt_pert + ozone_heat;


olr = up(1);
