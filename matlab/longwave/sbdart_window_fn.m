%sbdart_window_fn.m
%Try to change window param to see if SBDART data gives more similar dtau up and down

function out=sbdart_window_fn(x); %diff_tau=sbdart_window_fn(x,index);
load('sbdart_lw.mat')
index=9;
p	= 2000:4000:98000;
p_half 	= 0:4000:100000;
window 	= x(1);
t	= t_mit(:,index);
stefan 	= 5.67e-8;
grav 	= 9.81;
RDGAS  	= 287.04;
KAPPA  	= 2./7.;
cp_air 	= RDGAS/KAPPA;
spd 	= 86400;


%Read in results of lw runs
output_lw = dlmread(['~/matlab/longwave/check_window/OUTPUT_lw' num2str(91-index*10)]);


%yy=(91-index*10)*90/60*pi/180;
%sinyy=sin(yy);
%sst=27*(1-sinyy.*sinyy);
%t_surf=sst+273.15; 

%translate fluxes onto half layers as in MITgcm
fxdn  = output_lw(2:26,3);
fxup  = output_lw(2:26,4);
heat  = output_lw(2:26,7);
fxdn_half = interp1(p,fxdn,p_half,'linear','extrap');
fxup_half = interp1(p,fxup,p_half,'linear','extrap');
t_mit_half = interp1(p,t_mit,p_half,'linear','extrap');

%approximate MITgcm bcs
fxdn_half(1) = 0.;
b_surf = fxup_half(1,26)./(1-window); 	%stefan*t_surf.^4;

%try inverting MITgcm formula

%fxup_half = fxup_half - b_surf*window;

for i=1:25
b(i) = (1-window).*stefan*t(i).^4;
dtrans_dn(i) = (fxdn_half(i+1)-b(i))./(fxdn_half(i)-b(i));
dtrans_up(i) = (fxup_half(i)-b(i))./(fxup_half(i+1)-b(i));
del_tau_dn(i) = -log(dtrans_dn(i));
del_tau_up(i) = -log(dtrans_up(i));
end
plot(dtrans_dn)
hold on
plot(dtrans_up,'r')

%output_lwnowv = dlmread('~/matlab/longwave/OUTPUT_lwnowv');
%fxdn_nw  = output_lwnowv(2:26,3);
%fxup_nw  = output_lwnowv(2:26,4);
%heat_nw  = output_lwnowv(2:26,7);
%for i=1:24
%b(i) = (1-window).*stefan*t_mit(i).^4;
%dtrans_dnnw(i) = (fxdn_nw(i+1)-b(i))./(fxdn_nw(i)-b(i));
%dtrans_upnw(i) = (fxup_nw(i)-b(i))./(fxup_nw(i+1)-b(i));
%del_tau_dnnw(i) = -log(dtrans_dnnw(i));
%del_tau_upnw(i) = -log(dtrans_upnw(i));
%end


diff_tau = del_tau_dn(find(dtrans_up>0. & dtrans_up<1.)) - del_tau_up(find(dtrans_up>0. & dtrans_up<1.));

plot(del_tau_dn,p,'b')
hold on
plot(del_tau_up,p,'r')

out = sum(diff_tau.*diff_tau);
