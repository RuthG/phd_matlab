%blend_tau.m

%calculate taus from blended mitgcm/'standard' pressure level profiles, try to work out ozone relation!

%Read in results
output_eq_blend = dlmread('~/matlab/sbdart_ozone/standard_profs_oz_out_blend/OUTPUT_blend1');
output_eq_blend5 = dlmread('~/matlab/sbdart_ozone/standard_profs_oz_out_blend/OUTPUT_blend51');

%use sw downward fluxes to calculate optical depth
fxdn_eq_blend  = output_eq_blend(2:50,3);
fxdn_eq_blend5  = output_eq_blend5(2:50,3);
tau_eq_blend = -log(fxdn_eq_blend(:)./fxdn_eq_blend(1));
tau_eq_blend5 = -log(fxdn_eq_blend5(:)./fxdn_eq_blend5(1)); 

load('glmlblend.mat')

p_blend = flipud(p_blend);
t_blend = flipud(t_blend);
o_dens_blend = flipud(o_dens_blend);
o_mix_blend = flipud(o_mix_blend);
alts_blend = flipud(alts_blend);

%calculate dtau/sigma - amu

for k=1:48
dsigma_blend(k,1) = (p_blend(k+1)-p_blend(k))./1000.;
dtau_eq_blend(k,1)=tau_eq_blend(k+1)-tau_eq_blend(k);
dtaudsigma_eq_blend(k,1) = dtau_eq_blend(k)./dsigma_blend(k);
dtau_eq_blend5(k,1)=tau_eq_blend5(k+1)-tau_eq_blend5(k);
dtaudsigma_eq_blend5(k,1) = dtau_eq_blend5(k)./dsigma_blend(k);
end
for k=1:48
p_half_blend(k,:) = (p_blend(k,:)+p_blend(k+1,:))./2;
end

for j=1:6
o_mix_half_blend(:,j) = interp1(p_blend(:,j),o_mix_blend(:,j),p_half_blend(:,j));
end
