%tau_wv_final.m
%Use sbdart output to calculate and scatter plot tau vs (dtau/dsigma-amu)/q for a range of profiles. 


%load up values for q_surf, q_prof, t_prof, and t, w, p and z profiles
load('~/matlab/tau_parameterisation/profiles.mat')
doh = dlmread('~/matlab/sbdart/atms_profiles/atms_doh.dat');
z=doh(2:26,1);
p=doh(2:26,2);

%calculate dp, dsigma and halfway values for pressure and height levels
for i=1:24
dp(i,1)=p(i+1)-p(i);
sigma=p/(max(p)+dp(1)/2);
dsigma(i,1)=sigma(i+1)-sigma(i);
p_dp(i,1)=(p(i+1)+p(i))/2.;
end

tau_q=zeros(20,20,36,25);

for i=1:20  
for j=1:20

%load in all SBDART results
name=['~/matlab/tau_parameterisation/results_SAVE/tau_results' num2str(i) '_' num2str(j) '.mat'];
load(name);

tau(i,j,:,:)=tau_rec(:,:);

%calcuate dtau and dtaudsigma
for k=1:24
dtau(i,j,:,k)=tau(i,j,:,k+1)-tau(i,j,:,k);
dtaudsigma(i,j,:,k) = shiftdim(dtau(i,j,:,k),2)./dsigma(k,1);
end

end
end

%load sbdart wv free profiles and parameterise effect of 'background' gases
%load('~/matlab/tp_btb/results_keep/tau_results_nowv.mat') use other data, this has unrealistic temp profile
outputnowv = dlmread('~/matlab/sbdart/output/OUTPUT_SW_NOWV');
fxdnsw  = outputnowv(2:26,3);
%calculate tau
tausbdart2=log(fxdnsw(1)./fxdnsw);
for k=1:24
dtausbdart2dsig(k,1)=(tausbdart2(k+1)-tausbdart2(k))/dsigma(k);
end
amu=regress(tausbdart2,sigma)

%remove from dtau/dsigma
dtaudsigma=dtaudsigma-amu;

%for some 'realistic' wv profiles (all except q_prof=1,1.5) calculate b=(dtau/dsigma-amu)/q and pair with tau for the layers above
dtdsreal(:,:,:)=dtaudsigma(:,3:20,4,:);
taureal(:,:,:)=tau(:,3:20,4,:);

q_half=shiftdim(interp1(p,shiftdim(q,2),p_dp),1);

b(:,:,:)=dtdsreal./q_half(:,3:20,:);

%plot b vs tau
for i=1:20
for k=1:24
v1(:,1)=taureal(i,:,k+1);
v2(:,1)=b(i,:,k);
plot(v1,v2,'xk')
hold on
end
end
set(gca,'YScale','log')
xlabel('Tau')
ylabel('b')


%same for doherty prof

load('~/matlab/tau_parameterisation/prof_doherty.mat')
%Read in shortwave sbdart output
outputsw = dlmread('~/matlab/sbdart/output/OUTPUT_SW_DOH');
fxdnsw_doh  = outputsw(2:26,3);
taudoh=log(fxdnsw_doh(1)./fxdnsw_doh);
check=taudoh-tausbdart2;
load('~/wv_doh.mat')
wv=flipud(wv);
wv_half=interp1(p,wv,p_dp);

for k=1:24
dtaudoh(k,1)=taudoh(k+1)-taudoh(k);
dtaudohdsigma(k,1) = dtaudoh(k)./dsigma(k,1);
dcheck(k,1)=check(k+1)-check(k);
dcheckdsigma(k,1) = dcheck(k)./dsigma(k,1);
end

b_doh=(dtaudohdsigma-amu)./wv_half;
b_check=(dcheckdsigma)./wv_half;
plot(taudoh(2:25),b_doh,'r','Linewidth',2)

%same for mit prof

outputswm = dlmread('~/matlab/sbdart/output/OUTPUT_3');
fxdnsw_mit  = outputswm(2:26,3);
taumit=log(fxdnsw_mit(1)./fxdnsw_mit);
load('/disk1/rg312/run_swtest_0111/sbdartprof.mat')
q_mit=flipud(shiftdim(qprof));
q_mit_half=interp1(p,q_mit,p_dp);

for k=1:24
dtaumit(k,1)=taumit(k+1)-taumit(k);
dtaumitdsigma(k,1) = dtaumit(k)./dsigma(k,1);

end

b_mit=(dtaumitdsigma-amu)./q_mit_half;
plot(taumit(2:25),b_mit,'g','Linewidth',2)

name=['bvstau.png']
print('-dpng',name) 

hold off
subplot(3,1,1), plot(taumit(2:25),b_mit,'g')
hold on
plot(taudoh(2:25),b_doh,'r')
%set(gca,'YScale','log')
xlabel('Tau')
ylabel('b')
hold off
subplot(3,1,2), plot(taumit(2:25),b_mit-b_doh,'b')
hold on
%plot(taudoh(2:25),b_doh,'r')
%set(gca,'YScale','log')
xlabel('Tau')
ylabel('b_mit-b_doh')
hold off
subplot(3,1,3), plot(q_mit,p,'g')
set(gca,'YDir','reverse')
hold on
plot(wv,p,'r')
xlabel('q, kg/kg')
ylabel('P, mb')
hold off

name=['bvstau_and_q.png']
print('-dpng',name) 
