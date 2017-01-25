%new_method.m
%Use downward fluxes to estimate non-window emissivity (i.e. absorption, or 1-transmission)
%Use this to recreate upward fluxes if Earth wasn't there
%Then can use remaining upward fluxes to parameterise absorpton/emission in window

load('sbdart_lw.mat')
index=9;
p	= 2000:4000:98000;
p_half 	= 0:4000:100000;
t	= t_mit(:,index);
stefan 	= 5.67e-8;
grav 	= 9.81;
RDGAS  	= 287.04;
KAPPA  	= 2./7.;
cp_air 	= RDGAS/KAPPA;
spd 	= 86400;


%Read in results of lw runs
output_lw = dlmread(['~/matlab/longwave/check_window/OUTPUT_lw' num2str(91-index*10)]);

%translate fluxes onto half layers as in MITgcm
fxdn  = output_lw(2:26,3);
fxup  = output_lw(2:26,4);
heat  = output_lw(2:26,7);
fxdn_half = interp1(p,fxdn,p_half,'linear','extrap');
fxup_half = interp1(p,fxup,p_half,'linear','extrap');
t_mit_half = interp1(p,t_mit,p_half,'linear','extrap');

%approximate MITgcm bcs
fxdn_half(1) = 0.;

for i=1:25
b(i) = stefan*t(i).^4;
dtrans_dn(i) = (fxdn_half(i+1)-b(i))./(fxdn_half(i)-b(i));
del_tau_dn(i) = -log(dtrans_dn(i));
end

E = 1-dtrans_dn;


%Use E to find upward 'Earth free' fluxes

flux_up = zeros(1,26);

for i=25:-1:1
flux_up(i) = flux_up(i+1).*(1-E(i)) + b(i).*E(i);
end

flux_earth = fxup_half-flux_up;

for i=1:25
b(i) = stefan*t(i).^4;
dtrans_up(i) = (flux_earth(i)-b(i))./(flux_earth(i+1)-b(i));
del_tau_up(i) = -log(dtrans_up(i));
end
