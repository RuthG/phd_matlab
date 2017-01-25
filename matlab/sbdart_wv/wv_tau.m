%wv_tau.m
%Read in results of runs for wv profile, plot b vs tau

%Read in results
output_mit = dlmread('~/matlab/sbdart_wv/OUTPUT_wv_mit');

%load up data from wv_expts.m
load('wv_expts.mat')

fxdn_mit  = output_mit(2:26,3);
tau_mit = -log(fxdn_mit(:)./fxdn_mit(1));

%calculate dtau/sigma - amu

for k=1:24
dsigma_mit(k) = (p_mit(k+1)-p_mit(k))./1000.;
dtau_mit(k)=tau_mit(k+1)-tau_mit(k);
dtaudsigma_mit(k) = dtau_mit(k)./dsigma_mit(k);
sigma_half_mit(k) = (p_mit(k)+p_mit(k+1))./2000;

end


%dtaudsigma = amu + b(tau)*q

%q_mit = specific humidity kg/kg


for i=1:24
q_mit_h(i) = (q_mit(i)+q_mit(i+1))./2.;
end

amu = 0.0596;

b_mit = (dtaudsigma_mit - amu)./q_mit_h;

plot(tau_mit(1:24),b_mit);

%fit tau_mit to b_mit

logb = log(b_mit);
tau(1,:) = tau_mit(2:25);

plot(tau,b_mit,'+')
hold on
x0=[1.,1.,1.,1.]
fun3 = @(x,tau) x(1)./(tau + x(2)) + x(3)./(tau + x(4)).^2;
[c,resnorm] = lsqcurvefit(fun3,x0,tau,logb)
plot(tau,exp(fun3(c,tau)))
xlabel('Tau')
ylabel('b')
hold off

%compare parameterisation predictions with SBDART predictions
tau_test(1) = 0.0;

for i=1:24
b_check(i) = exp(c(1)./(tau_test(i)+c(2)) +c(3)./(tau_test(i)+c(4)).^2) ;
%del_tau_check = b_check.*q_check + amu
del_tau_check(i) = b_check(i).*q_mit(i) + amu;
tau_test(i+1) = tau_test(i) + del_tau_check(i).*dsigma_mit(i);
end

plot(tau_mit,p_mit)
hold on
plot(tau_test,p_mit,'r')
set(gca,'YDir','reverse')
xlabel('Tau')
ylabel('Pressure, mb')
name=['tau_fixed.png']
print('-dpng',name) 
hold off

%Calculate heating rates for comparison
%Use incident solar of 1360 Wm-2 as in SBDART
insol = 1360.0;
grav=9.81;
cp_air = 1004.64;
spd = 86400;

trans_sb = exp(-1.*tau_mit)
sol_dwn_sb = insol.*trans_sb
trans_ch = exp(-1.*tau_test)
sol_dwn_ch = insol.*trans_ch

for i=1:24
htrt_sb(i) = (-sol_dwn_sb(i+1) + sol_dwn_sb(i)).*spd.*grav./(cp_air*100.*(p_mit(i+1)-p_mit(i)));
htrt_ch(i) = (-sol_dwn_ch(i+1) + sol_dwn_ch(i)).*spd.*grav./(cp_air*100.*(p_mit(i+1)-p_mit(i)));
end

plot(htrt_sb,sigma_half_mit)
hold on
plot(htrt_ch,sigma_half_mit,'r')
set(gca,'YDir','reverse')
xlabel('Heat Rate K/day')
ylabel('Sigma')
name=['htrt_fixed.png']
print('-dpng',name) 
