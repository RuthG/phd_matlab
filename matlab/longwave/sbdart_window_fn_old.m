%sbdart_window_fn.m
%Try to change window param to see if SBDART data gives more similar dtau up and down

function diff_tau=sbdart_window_fn(x,q);
load('sbdart_lw.mat')


q_mit 	= q; %atm(:,4); %q ;q_mit;
p	= 2000:4000:98000;
p_half 	= 0:4000:100000;
window 	= x(1);
t_mit	= atm(:,3);
stefan 	= 5.67e-8;
t_surf 	= 300.15;
grav 	= 9.81;
RDGAS  	= 287.04;
KAPPA  	= 2./7.;
cp_air 	= RDGAS/KAPPA;
spd 	= 86400;


%Read in results of lw runs
output_lw = dlmread('~/matlab/longwave/OUTPUT_lw');


b_surf = stefan*t_surf.^4;

fxdn  = output_lw(2:26,3);
fxup  = output_lw(2:26,4);
heat  = output_lw(2:26,7);
fxdn_half = interp1(p,fxdn,p_half,'linear','extrap');
fxup_half = interp1(p,fxup,p_half,'linear','extrap');
q_mit_half = interp1(p,q_mit,p_half,'linear','extrap');
t_mit_half = interp1(p,t_mit,p_half,'linear','extrap');


%try inverting MITgcm formula

fxup = fxup - b_surf*window;

for i=1:24
b(i) = (1-window).*stefan*t_mit(i).^4;
dtrans_dn(i) = (fxdn(i+1)-b(i))./(fxdn(i)-b(i));
dtrans_up(i) = (fxup(i)-b(i))./(fxup(i+1)-b(i));
del_tau_dn(i) = -log(dtrans_dn(i));
del_tau_up(i) = -log(dtrans_up(i));
end

output_lwnowv = dlmread('~/matlab/longwave/OUTPUT_lwnowv');
fxdn_nw  = output_lwnowv(2:26,3);
fxup_nw  = output_lwnowv(2:26,4);
heat_nw  = output_lwnowv(2:26,7);
for i=1:24
b(i) = (1-window).*stefan*t_mit(i).^4;
dtrans_dnnw(i) = (fxdn_nw(i+1)-b(i))./(fxdn_nw(i)-b(i));
dtrans_upnw(i) = (fxup_nw(i)-b(i))./(fxup_nw(i+1)-b(i));
del_tau_dnnw(i) = -log(dtrans_dnnw(i));
del_tau_upnw(i) = -log(dtrans_upnw(i));
end


diff_tau = del_tau_dn - del_tau_up;

