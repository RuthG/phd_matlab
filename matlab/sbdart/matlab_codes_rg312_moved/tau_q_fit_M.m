%tau_q_fit_M.m
%As tau_q_fit but use MIT wv prof + sbdart run

%first use sbdart run with no wv to find the 'background' parameter amu

%load in basic atmos prof
load('prof_mit.mat')
z=mit(2:26,1);
p=mit(2:26,2);
t=mit(2:26,3);

%calculate sigma=p/ps
pscale=p/p(25);

%load up the mit profile and use these to compute wv dependence

nit=69120*5;
rDir='/disk1/rg312/run_swtest_0111/';
ny=91;
yc=rdmds([rDir,'YC']);
hc=rdmds([rDir,'hFacC']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));

t=rdmds([rDir,'T'],nit);
[fldzon,mskzon,ylat,areazon]=calcZonalAvgCube(t,ny,yc,ar,hc);
t=fldzon(46,:);

z=find_height(rC,t,logical(1));

q=rdmds([rDir,'Stave'],nit);
[fldzon,mskzon,ylat,areazon]=calcZonalAvgCube(q,ny,yc,ar,hc);
clear q
q(1:25,1)=fliplr(fldzon(46,:));

%load in sbdart output for mit profile
outputsw = dlmread('OUTPUT_3');
fxdnsw  = outputsw(2:26,3);


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

b = regress(dtaudsigma,X)

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

b = regress(dtaudsigma,X)

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

b = regress(dtaudsigma,X)


for i=1:25
deltau(i) = (b(3) - b(2)*q(i) + b(1)*log(q(i)))*delp;
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
