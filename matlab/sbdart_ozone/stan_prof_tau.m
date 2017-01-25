%stan_prof_tau.m

%calculate taus from standard profiles, try to work out ozone relation!

%Read in results
output_eq_gl = dlmread('~/matlab/sbdart_ozone/standard_profs_oz_out/OUTPUT_gl1');
output_eq_ml = dlmread('~/matlab/sbdart_ozone/standard_profs_oz_out/OUTPUT_ml1');
output_eq_gl5 = dlmread('~/matlab/sbdart_ozone/standard_profs_oz_out/OUTPUT_gl51');
output_eq_ml5 = dlmread('~/matlab/sbdart_ozone/standard_profs_oz_out/OUTPUT_ml51');


%use sw downward fluxes to calculate optical depth
fxdn_eq_gl  = output_eq_gl(2:51,3);
fxdn_eq_ml  = output_eq_ml(2:26,3);
fxdn_eq_gl5  = output_eq_gl5(2:51,3);
fxdn_eq_ml5  = output_eq_ml5(2:26,3);
tau_eq_gl = -log(fxdn_eq_gl(:)./fxdn_eq_gl(1));     %(23));
tau_eq_ml = -log(fxdn_eq_ml(:)./fxdn_eq_ml(1));
tau_eq_gl5 = -log(fxdn_eq_gl5(:)./fxdn_eq_gl5(1));  %(23));
tau_eq_ml5 = -log(fxdn_eq_ml5(:)./fxdn_eq_ml5(1));

load('standard_profs.mat')
p_ml = flipud(p_ml);
p_gl = flipud(p_gl);
t_ml = flipud(t_ml);
t_gl = flipud(t_gl);
o_dens_ml = flipud(o_dens_ml);
o_dens_gl = flipud(o_dens_gl);
o_mix_ml = flipud(o_mix_ml);
o_mix_gl = flipud(o_mix_gl);
rhoair_ml = flipud(rhoair_ml);
rhoair_gl = flipud(rhoair_gl);
alts_ml = flipud(alts_ml);
alts = flipud(alts);
h2o_dens_ml = flipud(h2o_dens_ml);
h2o_dens_gl = flipud(h2o_dens_gl);
h2o_q_ml = flipud(h2o_q_ml);
h2o_q_gl = flipud(h2o_q_gl);

%calculate dtau/sigma - amu

for k=1:24
dsigma_ml(k,1) = (p_ml(k+1)-p_ml(k))./1000.;
dtau_eq_ml(k,1)=tau_eq_ml(k+1)-tau_eq_ml(k);
dtaudsigma_eq_ml(k,1) = dtau_eq_ml(k)./dsigma_ml(k);
dtau_eq_ml5(k,1)=tau_eq_ml5(k+1)-tau_eq_ml5(k);
dtaudsigma_eq_ml5(k,1) = dtau_eq_ml5(k)./dsigma_ml(k);
p_half_ml(k,1) = (p_ml(k)+p_ml(k+1))./2;
end

o_mix_half_ml = interp1(p_ml,o_mix_ml,p_half_ml);


for k=1:49
dsigma_gl(k,1) = (p_gl(k+1)-p_gl(k))./1000.;
dtau_eq_gl(k,1)=tau_eq_gl(k+1)-tau_eq_gl(k);
dtaudsigma_eq_gl(k,1) = dtau_eq_gl(k)./dsigma_gl(k);
dtau_eq_gl5(k,1)=tau_eq_gl5(k+1)-tau_eq_gl5(k);
dtaudsigma_eq_gl5(k,1) = dtau_eq_gl5(k)./dsigma_gl(k);
end
for k=1:49
p_half_gl(k,:) = (p_gl(k,:)+p_gl(k+1,:))./2;
end

for j=1:6
o_mix_half_gl(:,j) = interp1(p_gl(:,j),o_mix_gl(:,j),p_half_gl(:,j));
end