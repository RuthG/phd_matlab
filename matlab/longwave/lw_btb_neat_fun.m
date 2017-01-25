%lw_btb_neat.m
%load in fluxes, try to fit polynomials
function heating=lw_btb_neat_fun(x,q_mit); 

load('sbdart_lw.mat')

p	= 2000:4000:98000;
p_half 	= 0:4000:100000;
stefan 	= 5.67e-8;
grav 	= 9.81;
RDGAS  	= 287.04;
KAPPA  	= 2./7.;
cp_air 	= RDGAS/KAPPA;
spd 	= 86400;


%Read in results of lw runs
for i = 1:9
output_lw(:,:,i) = dlmread(['~/matlab/longwave/check_window/OUTPUT_lw' num2str(91-i*10)]);
end

%translate fluxes onto half layers as in MITgcm
for i=1:9
fxdn(:,i)  = output_lw(2:26,3,i);
fxup(:,i)  = output_lw(2:26,4,i);
heat(:,i)  = output_lw(2:26,7,i);
end

fxdn_half = interp1(p,fxdn,p_half,'linear','extrap');
fxup_half = interp1(p,fxup,p_half,'linear','extrap');
t_mit_half = interp1(p,t_mit,p_half,'linear','extrap');

b = stefan*t_mit.^4;
dsigma = 0.04;

%try fitting

dt_dn = polyval(x(1:2),q_mit).*dsigma;

down = zeros(26,9);
up = zeros(26,9);
up(26,:) = stefan.*t_mit_half(26,:).^4;

for i=1:25
down(i+1,:) = down(i,:).*(1-dt_dn(i,:)) + b(i,:).*dt_dn(i,:);
end

for i=25:-1:1
up(i,:) = up(i+1,:).*(1-x(3).*dt_dn(i,:)) + 1.*b(i,:).*dt_dn(i,:);
end

net = up-down;

for i=1:25
heating_a(i,1) = (net(i+1,9) - net(i,9)).*spd.*grav./(cp_air*(p_half(i+1)-p_half(i)));
end

heating = heating_a(8:25);

