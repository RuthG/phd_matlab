%Test sw model in tau and sigma predictions of dtau/dsigma, tau, heating rates

load('tau_wv_final.mat')
load('tau_wv_final_allelse.mat')


%Work using 
%log(b(tau)= 
% 0.0254/(tau-0.00814) +1.07/(tau-0.378).^2 

%set initial tau values to zero
clear tau_45 tau_35 tau_25 tau_15 tau_m;
tau_45(1) = 0.0;
tau_35(1) = 0.0;
tau_25(1) = 0.0;
tau_15(1) = 0.0;
tau_m(1) = 0.0;

%set factor for background gases
amu = 0.0596;

%choose q profiles similar to MITgcm output at different lats"
q_check_45=q_surf(3)*sigma_half.^q_prof(8);
q_check_35=q_surf(3)*sigma_half.^q_prof(7);
q_check_25=q_surf(4)*sigma_half.^q_prof(6);
q_check_15=q_surf(7)*sigma_half.^q_prof(5);

%run model for all profiles
for i=1:24

b_check_45(i) = exp(0.0254./(tau_45(i)+0.00814) +1.07./(tau_45(i)+0.378).^2) ;
b_check_35(i) = exp(0.0254./(tau_35(i)+0.00814) +1.07./(tau_35(i)+0.378).^2) ;
b_check_25(i) = exp(0.0254./(tau_25(i)+0.00814) +1.07./(tau_25(i)+0.378).^2) ;
b_check_15(i) = exp(0.0254./(tau_15(i)+0.00814) +1.07./(tau_15(i)+0.378).^2) ;
b_mit_check(i) = exp(0.0254./(tau_m(i)+0.00814) +1.07./(tau_m(i)+0.378).^2) ;
%f(i) = exp(0.2289*sigma_half(i)./(tau-0.0023) - 0.0248./tau -1.0766);

%del_tau_check = b_check.*q_check + amu
del_tau_45(i) = b_check_45(i).*q_check_45(i) + amu;
del_tau_35(i) = b_check_35(i).*q_check_35(i) + amu;
del_tau_25(i) = b_check_25(i).*q_check_25(i) + amu;
del_tau_15(i) = b_check_15(i).*q_check_15(i) + amu;
del_tau_m(i) = b_mit_check(i).*q_mit_half(i) + amu;

tau_45(i+1) = tau_45(i) + del_tau_45(i).*dsigma(i);
tau_35(i+1) = tau_35(i) + del_tau_35(i).*dsigma(i);
tau_25(i+1) = tau_25(i) + del_tau_25(i).*dsigma(i);
tau_15(i+1) = tau_15(i) + del_tau_15(i).*dsigma(i);
tau_m(i+1) = tau_m(i) + del_tau_m(i).*dsigma(i);

end

%Find SBDART output for comparison
dtdscheck_45(:,1)=dtdsreal(3,6,:);
dtdscheck_35(:,1)=dtdsreal(3,5,:);
dtdscheck_25(:,1)=dtdsreal(4,4,:);
dtdscheck_15(:,1)=dtdsreal(7,3,:);
taucheck_45(:,1)=taureal(3,6,:);
taucheck_35(:,1)=taureal(3,5,:);
taucheck_25(:,1)=taureal(4,4,:);
taucheck_15(:,1)=taureal(7,3,:);

%Plot up results
subplot(2,3,1)
plot(dtdscheck_45,sigma_half)
hold on
plot(del_tau_45,sigma_half,'r');
set(gca,'YDir','reverse')
xlabel('dtaudsigma (45)')                
ylabel('Sigma')
hold off

subplot(2,3,2)
plot(dtdscheck_35,sigma_half)
hold on
plot(del_tau_35,sigma_half,'r');
set(gca,'YDir','reverse')
xlabel('dtaudsigma (35)')                
ylabel('Sigma')
hold off

subplot(2,3,3)
plot(dtdscheck_25,sigma_half)
hold on
plot(del_tau_25,sigma_half,'r');
set(gca,'YDir','reverse')
xlabel('dtaudsigma (25)')                
ylabel('Sigma')
hold off

subplot(2,3,4)
plot(dtdscheck_15,sigma_half)
hold on
plot(del_tau_15,sigma_half,'r');
set(gca,'YDir','reverse')
xlabel('dtaudsigma (15)')                
ylabel('Sigma')
hold off

subplot(2,3,5)
plot(dtaumitdsigma,sigma_half)
hold on
plot(del_tau_m,sigma_half,'r');
set(gca,'YDir','reverse')
xlabel('dtaudsigma (eq)')                
ylabel('Sigma')
hold off
name=['dtaudsigma_model.png']
print('-dpng',name) 
hold off

subplot(2,3,1)
plot(taucheck_45,sigma)
hold on
plot(tau_45,sigma,'r');
set(gca,'YDir','reverse')
xlabel('Tau (45)')                
ylabel('Sigma')
hold off

subplot(2,3,2)
plot(taucheck_35,sigma)
hold on
plot(tau_35,sigma,'r');
set(gca,'YDir','reverse')
xlabel('Tau (35)')                
ylabel('Sigma')
hold off

subplot(2,3,3)
plot(taucheck_25,sigma)
hold on
plot(tau_25,sigma,'r');
set(gca,'YDir','reverse')
xlabel('Tau (25)')                
ylabel('Sigma')
hold off

subplot(2,3,4)
plot(taucheck_15,sigma)
hold on
plot(tau_15,sigma,'r');
set(gca,'YDir','reverse')
xlabel('Tau (15)')                
ylabel('Sigma')
hold off

subplot(2,3,5)
plot(taumit,sigma)
hold on
plot(tau_m,sigma,'r');
set(gca,'YDir','reverse')
xlabel('Tau (eq)')                
ylabel('Sigma')
hold off
name=['tau_model.png']
print('-dpng',name) 

%Calculate heating rates for comparison
%Use incident solar of 1360 Wm-2 as in SBDART
insol = 1360.0;
grav=9.81;
cp_air = 1004.64;
spd = 86400;

trans_45 = exp(-1.*tau_45)
sol_dwn_45 = insol.*trans_45
trans_35 = exp(-1.*tau_35)
sol_dwn_35 = insol.*trans_35
trans_25 = exp(-1.*tau_25)
sol_dwn_25 = insol.*trans_25
trans_15 = exp(-1.*tau_15)
sol_dwn_15 = insol.*trans_15
trans_m = exp(-1.*tau_m)
sol_dwn_m = insol.*trans_m

trans_45_check = exp(-1.*taucheck_45)
sol_dwn_45_check = insol.*trans_45_check
trans_35_check = exp(-1.*taucheck_35)
sol_dwn_35_check = insol.*trans_35_check
trans_25_check = exp(-1.*taucheck_25)
sol_dwn_25_check = insol.*trans_25_check
trans_15_check = exp(-1.*taucheck_15)
sol_dwn_15_check = insol.*trans_15_check
trans_m_check = exp(-1.*taumit)
sol_dwn_m_check = insol.*trans_m_check

for i=1:24
htrt_45(i) = (-sol_dwn_45(i+1) + sol_dwn_45(i)).*spd.*grav./(cp_air*100.*(p(i+1)-p(i)));
htrt_35(i) = (-sol_dwn_35(i+1) + sol_dwn_35(i)).*spd.*grav./(cp_air*100.*(p(i+1)-p(i)));
htrt_25(i) = (-sol_dwn_25(i+1) + sol_dwn_25(i)).*spd.*grav./(cp_air*100.*(p(i+1)-p(i)));
htrt_15(i) = (-sol_dwn_15(i+1) + sol_dwn_15(i)).*spd.*grav./(cp_air*100.*(p(i+1)-p(i)));
htrt_m(i) = (-sol_dwn_m(i+1) + sol_dwn_m(i)).*spd.*grav./(cp_air*100.*(p(i+1)-p(i)));
htrt_45_check(i) = (-sol_dwn_45_check(i+1) + sol_dwn_45_check(i)).*spd.*grav./(cp_air*100.*(p(i+1)-p(i)));
htrt_35_check(i) = (-sol_dwn_35_check(i+1) + sol_dwn_35_check(i)).*spd.*grav./(cp_air*100.*(p(i+1)-p(i)));
htrt_25_check(i) = (-sol_dwn_25_check(i+1) + sol_dwn_25_check(i)).*spd.*grav./(cp_air*100.*(p(i+1)-p(i)));
htrt_15_check(i) = (-sol_dwn_15_check(i+1) + sol_dwn_15_check(i)).*spd.*grav./(cp_air*100.*(p(i+1)-p(i)));
htrt_m_check(i) = (-sol_dwn_m_check(i+1) + sol_dwn_m_check(i)).*spd.*grav./(cp_air*100.*(p(i+1)-p(i)));
end

load('~/matlab/sbdart_expts/heat_rates.mat')

subplot(2,3,1)
plot(htrt_45_check,sigma_half)
hold on
plot(htrt_45,sigma_half,'r');
plot(heat_45(2:25),sigma_half,'g')
set(gca,'YDir','reverse')
xlabel('Heating rate (45), K/day')                
ylabel('Sigma')
hold off

subplot(2,3,2)
plot(htrt_35_check,sigma_half)
hold on
plot(htrt_35,sigma_half,'r');
plot(heat_35(2:25),sigma_half,'g')
set(gca,'YDir','reverse')
xlabel('Heating rate (35), K/day')                
ylabel('Sigma')
hold off

subplot(2,3,3)
plot(htrt_25_check,sigma_half)
hold on
plot(htrt_25,sigma_half,'r');
plot(heat_25(2:25),sigma_half,'g')
set(gca,'YDir','reverse')
xlabel('Heating rate (25), K/day')                
ylabel('Sigma')
hold off

subplot(2,3,4)
plot(htrt_15_check,sigma_half)
hold on
plot(htrt_15,sigma_half,'r');
plot(heat_15(2:25),sigma_half,'g')
set(gca,'YDir','reverse')
xlabel('Heating rate (15), K/day')                
ylabel('Sigma')
hold off

subplot(2,3,5)
plot(htrt_m_check,sigma_half)
hold on
plot(htrt_m,sigma_half,'r');
plot(heat_mit(2:25),sigma_half,'g')
set(gca,'YDir','reverse')
xlabel('Heating rate (eq), K/day')                
ylabel('Sigma')
hold off
name=['htrt_model.png']
print('-dpng',name) 
