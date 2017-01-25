%lw_fun.m

function tdt_rad=lw_fn(x,q);
%function [down,up,tdt_rad]=lw_fn(a,b);

load('sbdart_lw.mat')

ir_tau_co2 	= x(1) ;%0.8678;
ir_tau_wv 	= x(2) ;%1.9979e+3;
ir_tau_wvsq	= 0. ; %x(3) ;
q 		= q ;q_mit;
p		= 2000:4000:98000;
p_half 	= 0:4000:100000;
window 	= 0.0;
t		= atm(:,3);
t_coeff = 0.0 ;%x(3);
stefan 	= 5.67e-8;
t_surf 	= 300.15;
grav 		= 9.81;
RDGAS  	= 287.04;
KAPPA  	= 2./7.;
cp_air 	= RDGAS/KAPPA;
spd 		= 86400;

for k = 1:25
    del_tau(k)    = ( ir_tau_co2 + ir_tau_wv * q(k) + t_coeff * t(k)) * ( p_half(k+1)-p_half(k) ) / p_half(26);
    dtrans(k) = exp( - del_tau(k));
end

b = (1.0-window).*stefan.*t.^4;

down = zeros(1,26);
down(1,1) = 0.0;

for k = 1:25
  down(k+1) = down(k).*dtrans(k) + b(k).*(1.0 - dtrans(k));
end

surf_lw_down     = down(26);

%total flux from surface
b_surf = stefan*t_surf.^4;

% first deal with non-window upward flux
up(26) = b_surf*(1.0-window);
for k = 25:-1:1
  up(k) = up(k+1)*dtrans(k) + b(k)*(1.0 - dtrans(k));
end

% add upward flux in spectral window
for k = 1:26
  up(k) = up(k) + b_surf.*window;
end

for k = 1:26
  net(k) = up(k)-down(k);
end

for k = 1:25
  tdt_rad(k,1) = (net(k+1) - net(k)).*grav.*spd/(cp_air.*(p_half(k+1)-p_half(k))) ;
end
