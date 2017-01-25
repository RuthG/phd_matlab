%radiation_mod_vw_check.m

%calculate radiative heating expected from mitgcm using profiles at equator and 70 degrees. 



load('tq_zav.mat')

t_in = flipdim(t_zav,2);
q_in = flipdim(q_zav,2);

yi = -89:2:89;
p = 2000:4000:98000;
p_half = 0.:4000:100000;
yy=yi*90/60*pi/180;
sinyy=sin(yy);
sst=27*(1-sinyy.*sinyy);
sst(find(abs(yi)>=60))=0;
t_surf=sst+273.15;
t_surf=sst+273.15;

%define constants
solar_constant 	= 1360.0;
del_sol		= 1.4;
del_sw 		= 0.;
ir_tau_eq	= 6.;
ir_tau_pole 	= 1.5;
linear_tau 	= 0.1;
ir_tau_co2 	= 0.0540./0.04;    %0.154925; 
ir_tau_wv 	= 7.677./0.04;  %351.48; 
ir_tau_co2_win  = 0.2914;    %0.2150;
ir_tau_wv_win1  = 146.1767;  %147.11;
ir_tau_wv_win2  = 1.0433e4;  %1.0814e4;
atm_abs 	= 0.;
sw_diff 	= 0.0;
albedo_value 	= 0.06;
window = -0.0967.*(t_in./100).^2 + 0.6516.*t_in./100 - 0.7089;
%window 		= 0.3732;
wv_exponent 	= 0.0;
solar_exponent 	= 0.0;
sw_co2 		= 0.0596;
heat_pert 	= 0.;
deg_to_rad 	= pi./180.;
grav 		= 9.8;
cp_air 		= 287.04./(2./7);
lat		= yi.*deg_to_rad;
stefan 	= 5.6734e-8;

n = 25;


ss = sin(lat);
p2 = (1. - 3.*ss.^2)./4;
solar = 0.25.*solar_constant.*(1.0 + del_sol.*p2 + del_sw.*ss);
tau_0 = ir_tau_eq + (ir_tau_pole - ir_tau_eq).*ss.^2;

albedo = albedo_value;

solar_tau = zeros(90,25);
solar_tau(:,1) = 0.;
mag_fac = 1.; % 35.0./sqrt(1224.*cos(lat).^2 +1);

if solar_exponent == 0.
  for k=1:n;
   sw_wv = exp(0.01887./(solar_tau(:,k) + 0.009522) + 1.603./((solar_tau(:,k) + 0.5194).^2));
   del_sol_tau = ( sw_co2 + sw_wv.*q_in(:,k) ) .* mag_fac .* (p_half(k+1) - p_half(k))./p_half(n+1);
   solar_tau(:,k+1) = solar_tau(:,k) + del_sol_tau;
   dtrans_sol(:,k) = exp( -del_sol_tau);
  end

else
  solar_tau_0 = (1. - sw_diff.*ss.^2).*atm_abs;
  k=1;
  solar_tau(:,k) = solar_tau_0.*(p_half(k)./p_half(n+1)).^solar_exponent;
  for k=1:n+1
      solar_tau(:,k) = solar_tau_0.*(p_half(k)./p_half(n+1)).^solar_exponent;
      dtrans_sol(:,k-1) = exp(-(solar_tau(:,k) - solar_tau(:,k-1)));
  end
end

if wv_exponent == 0.
  for k= 1:n
    del_tau = (ir_tau_co2 + ir_tau_wv.*q_in(:,k).^0.5).*(p_half(k+1) - p_half(k))./p_half(n+1);
    dtrans(:,k) = exp(-del_tau);
    del_tau_win = (ir_tau_co2_win + ir_tau_wv_win1.*q_in(:,k) + ir_tau_wv_win2.*q_in(:,k).^2).*(p_half(k+1) - p_half(k))./p_half(n+1);
    dtrans_win(:,k) = exp(-del_tau_win);
  end

else
  k=1;
  tau_kp = tau_0.*(linear_tau.*p_half(k)./p_half(n+1) + (1. - linear_tau).*(p_half(k)./p_half(n+1)).^wv_exponent);
  for k=1:n
    tau_km = tau_kp;
    tau_kp = tau_0.*(linear_tau.*p_half(k+1)./p_half(n+1) + (1. - linear_tau).*(p_half(k+1)./p_half(n+1)).^wv_exponent);
    dtrans(:,k) = exp(-(tau_kp - tau_km));
  end
end

b = (1. - window).*stefan.*t_in.^4;
b_win = window.*stefan.*t_in.^4;

down = zeros(90,25);
down_win = zeros(90,25);
down(:,1) = 0.;
down_win(:,1) = 0.;
for k=1:n
  down(:,k+1) = down(:,k).*dtrans(:,k) + b(:,k).*(1. - dtrans(:,k));
  down_win(:,k+1) = down_win(:,k).*dtrans_win(:,k) + b_win(:,k).*(1. - dtrans_win(:,k));
end

down = down + down_win;

solar_down(:,1) = solar;
for k = 1:n
  solar_down(:,k+1) = solar_down(:,k).*dtrans_sol(:,k);
end

surf_lw_down = down(:,n+1);
net_surf_sw_down = solar_down(:,n+1).*(1.-albedo);


%radiation_up

b_surf = stefan.*t_surf.^4;

window_surf = -0.0967.*(t_surf./100).^2 + 0.6516.*t_surf./100 - 0.7089;

up(:,n+1) = b_surf.*(1.-window_surf);
up_win(:,n+1) = b_surf.*window_surf;

for k=n:-1:1
  up(:,k) = up(:,k+1).*dtrans(:,k) + b(:,k).*(1. - dtrans(:,k));
  up_win(:,k) = up_win(:,k+1).*dtrans_win(:,k) + b_win(:,k).*(1. - dtrans_win(:,k));
end

up = up + up_win;

for k=1:n+1
  net(:,k) = up(:,k) - down(:,k);
  net_win(:,k) = up_win(:,k) - down_win(:,k);
  flux_sw(:,k) = albedo.*solar_down(:,n+1) - solar_down(:,k);
  flux_rad(:,k) = net(:,k) + flux_sw(:,k);
end

%longwave heating

for k=1:n
   tdt_lw(:,k) = (net(:,k+1) - net(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
   tdt_win(:,k) = (net_win(:,k+1) - net_win(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
   tdt_sw(:,k) = (flux_sw(:,k+1) - flux_sw(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));

end

tdt = tdt_lw + tdt_sw;

olr = up(:,:,1);


save('/project/rg312/mat_files/radmod_lw_vw.mat','down','down_win','up','up_win','net','net_win','tdt_lw','tdt_win','dtrans','dtrans_win','b','b_win','q_in','t_in','t_surf','b_surf')
