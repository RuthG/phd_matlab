%ozone_tau.m
%Read in results of runs for ozone profile, plot c vs tau

%Read in results
output_mit = dlmread('~/matlab/sbdart_ozone/OUTPUT_ozone_mit');
output_mit5 = dlmread('~/matlab/sbdart_ozone/OUTPUT_ozone_mit5');
output_doh = dlmread('~/matlab/sbdart_ozone/OUTPUT_ozone_doh');

%load up data from ozone_expts.m
load('ozone_expts.mat')

%use sw downward fluxes to calculate optical depth
fxdn_mit  = output_mit(2:26,3);
fxdn_mit5  = output_mit5(2:26,3);
tau_mit = -log(fxdn_mit(:)./fxdn_mit(1));
tau_mit5 = -log(fxdn_mit5(:)./fxdn_mit5(1));

fxdn_doh  = output_doh(2:31,3);
tau_doh = -log(fxdn_doh(6:30)./fxdn_doh(6));

%calculate dtau/sigma - amu

for k=1:24
dsigma_mit(k) = (p_mit(k+1)-p_mit(k))./1000.;
dtau_mit(k)=tau_mit(k+1)-tau_mit(k);
dtaudsigma_mit(k) = dtau_mit(k)./dsigma_mit(k);
dtau_mit5(k)=tau_mit5(k+1)-tau_mit5(k);
dtaudsigma_mit5(k) = dtau_mit5(k)./dsigma_mit(k);
sigma_half_mit(k) = (p_mit(k)+p_mit(k+1))./2000;

j=k+5;
dsigma_doh(k) = (p_dm(j+1)-p_dm(j))./1000.;
dtau_doh(k)=tau_doh(k+1)-tau_doh(k);
dtaudsigma_doh(k) = dtau_doh(k)./dsigma_doh(k);
sigma_half_doh(k) = (p_dm(j)+p_dm(j+1))./2000;
end

%dtaudsigma = amu + c(tau)*O_3

%calculate density of air
rhoair_mit = p_mit.*100./(287.058*t_mit);
rhoair_dm = p_dm.*100./(287.058*t_dm);

%Ozone in kg/kg = (g/m3)/(kg/m3)/1000.
o_mit_kgkg = o_mit./(1000.*rhoair_mit);
o_mit_kgkg5 = o_mit.*5./(1000.*rhoair_mit);
o_dm_kgkg = o_dm(6:30)./(1000.*rhoair_dm(6:30));

%translate O3 onto half pressure levels
for i=1:24
o_mit_kgkg_h(i) = (o_mit_kgkg(i)+o_mit_kgkg(i+1))./2.
o_mit_kgkg_h5(i) = (o_mit_kgkg5(i)+o_mit_kgkg5(i+1))./2.
o_doh_kgkg_h(i) = (o_dm_kgkg(i)+o_dm_kgkg(i+1))./2.
end

%background gases
amu = 0.0596;

%calculate c
c_mit = (dtaudsigma_mit - amu)./o_mit_kgkg_h;
c_mit5 = (dtaudsigma_mit5 - amu)./o_mit_kgkg_h5;
c_doh = (dtaudsigma_doh - amu)./o_doh_kgkg_h;

%plot up both
plot(tau_mit(2:25),c_mit);
hold on
plot(tau_mit5(2:25),c_mit5);
plot(tau_doh(2:25),c_doh,'r');
