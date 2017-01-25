%load in t profile and calculate the lw cooling that would result using optical depths calculated in the original Frierson way

load('tq_zav.mat')

t_zav = flipdim(t_zav,2);

yi = -89:2:89;
ss = sin(yi.*pi./180);
rC = 0:4000:100000;

linear_tau = 0.1;
ir_tau_pole = 1.5;
ir_tau_eq = 6.0;
stefan 	= 5.6734e-8;
grav 		= 9.8;
cp_air 		= 287.04./(2./7);

tau_0 = ir_tau_eq + (ir_tau_pole - ir_tau_eq).*ss.^2;

for i=1:26
  tau(:,i) = tau_0(:) .* (linear_tau.* rC(i)./100000 + (1 - linear_tau).* (rC(i)./100000).^4);
end
 
for i=1:25
  dtrans(:,i) = exp( -(tau(:,i+1) - tau(:,i)) );
end

b = stefan.*t_zav.^4;
down(1:90,1) = 0.0;

for k = 1:25
  down(:,k+1) = down(:,k).*dtrans(:,k) + b(:,k).*(1.0 - dtrans(:,k));
end 

yy=yi*90/60*pi/180;
sinyy=sin(yy);
sst=27*(1-sinyy.*sinyy);
sst(find(abs(yi)>=60))=0;
t_surf=sst+273.15;

b_surf = stefan*t_surf.^4;

up(:,26) = b_surf;

for k = 25:-1:1
  up(:,k) = up(:,k+1).*dtrans(:,k) + b(:,k).*(1.0 - dtrans(:,k));
end

net = up - down;


for k=1:25
   tdt_lw(:,k) = (net(:,k+1) - net(:,k)).*grav./(cp_air.*(rC(k+1) - rC(k)));

end

save('tdt_lw_frierson.mat','tdt_lw','net')

