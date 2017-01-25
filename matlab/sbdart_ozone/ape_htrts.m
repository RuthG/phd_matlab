%ape_htrts.m
%load in output from ape, try to translate into MITgcm heating rate profiles

load('heating_rates_sbdart_ozone.mat')

for i=1:90
tau_sw(i,:) = -log(fxdn_sw(i,:)./fxdn_sw(i,1));
tau_sw_nw(i,:) = -log(fxdn_sw_nw(i,:)./fxdn_sw_nw(i,1));
end

sinlat = sin(ylat*pi./180.);
p2 = (1-3*sinlat.^2)./4.;
solar = 0.25.*1360.0.*(1+1.4*p2);
for i=1:90                                  
newfxdn(i,:) = solar(i).*exp(-1*tau_sw(i,:));
newfxdn_nw(i,:) = solar(i).*exp(-1*tau_sw_nw(i,:));
end

for i=1:24
htrt_new(:,i) = (-newfxdn(:,i+1) +newfxdn(:,i)).*86400.*9.81./(1004.64.*(rC(i+1)-rC(i)));
htrt_new_nw(:,i) = (-newfxdn_nw(:,i+1) +newfxdn_nw(:,i)).*86400.*9.81./(1004.64.*(rC(i+1)-rC(i)));
end

