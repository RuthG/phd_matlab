%fit generic shapes to q and t profiles

%read in doherty profile
doherty = dlmread('~/obs_wv');

p_doh = doherty(:,1)/doherty(1,1);
t_doh = doherty(:,2);
q_doh = doherty(:,3)/1000;

clear X
%look for best index for p/ps to fit q
j=0;
for i=1:0.1:4
j=j+1;
X(:,1) = p_doh.^i;
doh_regress = regress(q_doh,X);
kaicheck(j) = sum((((p_doh.^i)*doh_regress) - q_doh).^2);
end

% find the regression value this corresponds to and check fit
X(:,1) = p_doh.^2.7;
doh_regress = regress(q_doh,X)
plot(q_doh,p_doh)
hold on
plot(doh_regress*p_doh.^2.7 , p_doh,'r')

% do similar for exp fit to p/ps to fit q
clear X
clear kaicheck
j=0;
for i=3.6:0.01:4
j=j+1;
X(:,1) = exp(p_doh.*i);
doh_regress = regress(q_doh,X);
kaicheck(j) = sum(((doh_regress*exp(p_doh.*i)) - q_doh).^2);
end

% find the regression value this corresponds to and check fit
X(:,1) = exp(3.82*p_doh);
doh_regress = regress(q_doh,X)
plot(q_doh,p_doh)
hold on
plot(doh_regress*exp(3.82*p_doh) , p_doh,'g')
hold off

%fit t to logp
clear X
clear kaicheck
X(:,1) = log(p_doh(1:9));
X(:,2) = ones(1,9);
doh_regress = regress(t_doh(1:9),X);

plot(t_doh,p_doh)
hold on
plot(doh_regress(1)*log(p_doh(1:9)) +doh_regress(2) , p_doh(1:9),'r')


%read in MITgcm profile
nit=69120*5;
rDir='/disk1/rg312/run_swtest_0111/';
ny=91;
yc=rdmds([rDir,'YC']);
hc=rdmds([rDir,'hFacC']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
Grid='C';

p_mit = rC/max(rC);

ttave=rdmds([rDir,'Ttave'],nit);
[fldzont,mskzon,ylat,areazon]=calcZonalAvgCube(ttave,ny,yc,ar,hc);
theta_mit = fldzont(46,:);
convthetatoT=(rC/rC(1)).^(2./7.);
t_mit=theta_mit'.*convthetatoT;


stave=rdmds([rDir,'Stave'],nit);
[fldzonq,mskzon,ylat,areazon]=calcZonalAvgCube(stave,ny,yc,ar,hc);
q_mit(:,1) = fldzonq(46,:);

clear X
clear kaicheck
%look for best index for p/ps
j=0;
for i=4:0.1:6
j=j+1;
X(:,1) = p_mit.^i;
mit_regress = regress(q_mit,X);
kaicheck(j) = sum((((p_mit.^i)*mit_regress) - q_mit).^2);
end

% find the regression value this corresponds to and check fit
X(:,1) = p_mit.^4.8;
mit_regress = regress(q_mit,X)
plot(q_mit,p_mit)
hold on
plot(mit_regress*p_mit.^2.7 , p_mit,'r')

% do similar for exp fit to p/ps

clear kaicheck
clear X
j=0;
for i=5.4:0.01:5.8
j=j+1;
X(:,1) = exp(p_mit.*i);
mit_regress = regress(q_mit,X);
kaicheck(j) = sum(((mit_regress*exp(p_mit.*i)) - q_mit).^2);
end

% find the regression value this corresponds to and check fit
X(:,1) = exp(5.61*p_mit);
mit_regress = regress(q_mit,X)
plot(q_mit,p_mit)
hold on
plot(mit_regress*exp(5.61*p_mit) , p_mit,'g')


%fit t to logp
clear X
clear kaicheck
X(:,1) = log(p_mit(1:21));
X(:,2) = ones(1,21);
mit_regress = regress(t_mit(1:21),X);

plot(t_mit,p_mit)
hold on
plot(mit_regress(1)*log(p_mit(1:21)) +mit_regress(2) , p_mit(1:21),'r')




