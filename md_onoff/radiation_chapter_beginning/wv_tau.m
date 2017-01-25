%wv_tau.m
%Read in results of runs for wv profile, plot b vs tau

load('sw_sbdart.mat')
load('/project/rg312/mat_files/radiation_chapter/uvwqt_tav_radon.mat','q_tav','theta_tav')

rDir='/project/rg312/final_runs/run_100_rad_on/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
drC=squeeze(rdmds([rDir,'DRC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
xi=-179:2:179;
yi=-89:2:89;


    convthetatoT=(rC/100000.0).^(2./7.);
    for k=1:size(rC)
      t_tav(:,:,k)=theta_tav(:,:,k).*convthetatoT(k,1);
    end


q_ll=cube2latlon(xc,yc,q_tav,xi,yi);
%theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
t_ll=cube2latlon(xc,yc,t_tav,xi,yi);

q_zav(:,:) = mean(q_ll,1);
%theta_zav(:,:) = mean(theta_ll,1);
t_zav(:,:) = mean(t_ll,1);

t_zav = flipdim(t_zav,2);
q_zav = flipdim(q_zav,2);





%tau on flux levels

for i=1:26
tau(:,i) = -log(fxdn_sw(:,i)./fxdn_sw(:,1));
end

%calculate dtau/sigma - amu
dsigma = 0.04;

%dtau between flux levels
for k=1:25
dtau(:,k)=tau(:,k+1)-tau(:,k);
end

dtaudsigma = dtau./dsigma;

%dtaudsigma = amu + b(tau)*q

%q_mit = specific humidity kg/kg

%want q on dtaudsigma layers

amu = 0.0596;

b = (dtaudsigma - amu)./q_zav;

b_est = exp(0.01887./(tau + 0.009522) + 1.603./(tau+0.5194).^2);



return
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


