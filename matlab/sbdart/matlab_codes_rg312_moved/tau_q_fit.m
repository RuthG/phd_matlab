%tau_q_fit.m

%first use sbdart run with no wv to find the 'background' parameter amu

%load in basic atmos prof
load('prof_doherty.mat')
z=doherty(2:26,1);
p=doherty(2:26,2);
t=doherty(2:26,3);

%load up data
outputnowv = dlmread('OUTPUT_SW_NOWV');
fxdnsw  = outputnowv(2:26,3);
%calculate tau
taunowv=log(fxdnsw(1)./fxdnsw);

%calculate sigma=p/ps
pscale=p/p(25);

%with no wv hope dtau/dsigma = amu where amu is const, so try linear fit and use gradient from this.
a = polyfit(pscale,taunowv,1)
amu = a(1);


%Now we have amu, load up the 'textbook' profile (numbers from Doherty paper) and use these to compute wv dependence

%load in sbdart output for doherty profile
outputsw = dlmread('OUTPUT_SW_DOH');
fxdnsw  = outputsw(2:26,3);

%also load in values from paper, quickest way to get q in correct units.
atm = dlmread('obs_wv');
press = atm(:,1);
waterv = atm(:,3);
wv = interp1(press,waterv,p);
q=wv/1000.;

%calculate tau
tausbdart=log(fxdnsw(1)./fxdnsw);
delp = (p(2)-p(1))/p(25);

%calculate dtau/dsigma
for i=2:25
dtaudsigma(i,1)=(tausbdart(i)-tausbdart(i-1))./delp;
end

%Try linear fit in q

X(:,1)=q;
X(:,2)=ones(25,1);

%b = regress(dtaudsigma,X)

b=[10.5189,0.1958];

for i=1:25
deltau(i) = (b(2)  + b(1)*q(i))*delp;
end

plot(dtaudsigma,p,'r')
hold on 
plot(deltau./delp,p)
set(gca,'YDir','reverse')
xlabel('dtaudsigma')
ylabel('Pressure, mb')
name=['dtau_lin.png']
print('-dpng',name) 
hold off

tau(1) = tausbdart(1);
for i=2:25
tau(i)=deltau(i)+tau(i-1);
end

plot(tausbdart,p,'r')
hold on 
plot(tau,p)
set(gca,'YDir','reverse')
xlabel('Optical depth')
ylabel('Pressure, mb')
name=['linq.png']
print('-dpng',name) 
hold off

%Try logarithmic fit in q

X(:,1)=log(q);
X(:,2)=ones(25,1);

%b = regress(dtaudsigma,X)

b=[0.0277,0.4406];

for i=1:25
deltau(i) = (b(2)  + b(1)*log(q(i)))*delp;
end

plot(dtaudsigma,p,'r')
hold on 
plot(deltau./delp,p)
set(gca,'YDir','reverse')
xlabel('dtaudsigma')
ylabel('Pressure, mb')
name=['dtau_log.png']
print('-dpng',name) 
hold off

tau(1) = tausbdart(1);
for i=2:25
tau(i)=deltau(i)+tau(i-1);
end

plot(tausbdart,p,'r')
hold on 
plot(tau,p)
set(gca,'YDir','reverse')
xlabel('Optical depth')
ylabel('Pressure, mb')
name=['logq.png']
print('-dpng',name) 
hold off

%Try combination

X(:,1)=log(q);
X(:,2)=q;
X(:,3)=ones(25,1);

%b = regress(dtaudsigma,X)

b=[0.0261,1.4718,0.4226];

for i=1:25
deltau(i) = (b(3) + b(2)*q(i) + b(1)*log(q(i)))*delp;
end

plot(dtaudsigma,p,'r')
hold on 
plot(deltau./delp,p)
set(gca,'YDir','reverse')
xlabel('dtaudsigma')
ylabel('Pressure, mb')
name=['dtau_comb.png']
print('-dpng',name) 
hold off

tau(1) = tausbdart(1);
for i=2:25
tau(i)=deltau(i)+tau(i-1);
end

plot(tausbdart,p,'r')
hold on 
plot(tau,p)
set(gca,'YDir','reverse')
xlabel('Optical depth')
ylabel('Pressure, mb')
name=['combq.png']
print('-dpng',name) 
hold off
