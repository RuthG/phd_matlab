%lw_fit_trop.m
%load up lw sbdart output, try to get decent fit in equatorial troposphere, check with other profiles

load('sbdart_lw.mat')
p	= 2000:4000:98000;
p_half 	= 0:4000:100000;
t	= t_mit(:,9);
stefan 	= 5.67e-8;
grav 	= 9.81;
RDGAS  	= 287.04;
KAPPA  	= 2./7.;
cp_air 	= RDGAS/KAPPA;
spd 	= 86400;


%Read in results of lw runs
for i = 1:9
output_lw(:,:,i) = dlmread(['~/matlab/longwave/check_window/OUTPUT_lw' num2str(91-i*10)]);
end

%translate fluxes onto half layers as in MITgcm
for i=1:9
fxdn(:,i)  = output_lw(2:26,3,i);
fxup(:,i)  = output_lw(2:26,4,i);
heat(:,i)  = output_lw(2:26,7,i);
end

fxdn_half = interp1(p,fxdn,p_half,'linear','extrap');
fxup_half = interp1(p,fxup,p_half,'linear','extrap');
t_mit_half = interp1(p,t_mit,p_half,'linear','extrap');

%calc bbody emission, use to find dtaus and dtaudsigma
b = stefan*t_mit.^4;

for i=1:25
dfxdn(i,:) = fxdn_half(i+1,:) - fxdn_half(i,:);
dfxup(i,:) = fxup_half(i,:) -fxup_half(i+1,:);
dtau_dn(i,:) = dfxdn(i,:)./(b(i,:) - fxdn_half(i,:));
dtau_up_compare(i,:) = dfxup(i,:)./(b(i,:) - fxup_half(i+1,:));
dtau_up(i,:) = (b(i,:).*dtau_dn(i,:) - dfxup(i,:))./fxup_half(i+1,:);
end

dsigma = 0.04;
dtds_dn = dtau_dn./dsigma;
dtds_up = dtau_up./dsigma;
dt_mit = (0.8678 + 1.9929e3.*q_mit).*dsigma;

%Try to fit polynomials to tropospheric dtaus
pars_dn = polyfit(q_mit(8:25,9),dtds_dn(8:25,9),1)
pars_dn(2) = 3.;
for i=1:9
vals_dn(:,i) = polyval(pars_dn,q_mit(:,i));
end
plot(q_mit(:,9),dtau_dn(:,9),'r');
hold on
plot(q_mit(:,9),vals_dn(:,9)*dsigma);

pars_up = polyfit(q_mit(8:25,9),dtds_up(8:25,9),1);
for i=1:9
vals_up(:,i) = polyval(pars_up,q_mit(:,i));
end
plot(q_mit(:,9),dtau_up(:,9),'r');
hold on
plot(q_mit(:,9),vals_up(:,9)*dsigma);

dt_dn = vals_dn*dsigma;
dt_up = vals_up*dsigma;

%Calculate corresponding emission
down = zeros(26,9);
up = zeros(26,9);
%up(26,:) = fxup_half(26,:) ; %
up(26,:) = stefan.*t_mit_half(26,:).^4;
up_mit(26,:) = fxup_half(26,:) ;
%down(1,:) = fxdn_half(1,:);
down_mit(1,:) = fxdn_half(1,:);
for i=1:25
down(i+1,:) = down(i,:).*(1-dt_dn(i,:)) + b(i,:).*dt_dn(i,:);
down_mit(i+1,:) = down_mit(i,:).*(1-dt_mit(i,:)) + b(i,:).*dt_mit(i,:);
end

for i=25:-1:1
up(i,:) = up(i+1,:).*(1-dt_dn(i,:)) + b(i,:).*dt_dn(i,:);
up_mit(i,:) = up_mit(i+1,:).*(1-dt_mit(i,:)) + 1.*b(i,:).*dt_mit(i,:);
end

net = up-down;
net_sb = fxup_half - fxdn_half;
net_mit = up_mit-down_mit;

for i=1:25
heating(i,:) = (net(i+1,:) - net(i,:)).*spd.*grav./(cp_air*(p_half(i+1)-p_half(i)));
heating_mit(i,:) = (net_mit(i+1,:) - net_mit(i,:)).*spd.*grav./(cp_air*(p_half(i+1)-p_half(i)));
heating_sb(i,:) = (net_sb(i+1,:) - net_sb(i,:)).*spd.*grav./(cp_air*(p_half(i+1)-p_half(i)));
end

heating(find(heating>0))=0.;

for i=1:2:9
plot(heat(1:25,i),p(1:25),'b');
hold on
plot(heating(1:25,i),p(1:25),'g');
plot(heating_mit(1:25,i),p(1:25),'r');
xlim([-6,0])
ylim([0.,10e4])
xlabel('Heating rate, K/day')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
name=['plots/heating_rate' num2str(91-i*10) '.png']
print('-dpng',name) 
hold off
end
return
for i=1:2:9
plot(heat(8:25,i),p(8:25),'b');
hold on
plot(heating_mit(8:25,i),p(8:25),'r');
xlabel('Heating rate, K/day')
ylabel('Pressure, Pa')
set(gca,'YDir','reverse')
name=['plots/heating_rate_mit' num2str(91-i*10) '.png']
print('-dpng',name) 
hold off
end

%plot(heating_mit,p,'r');

return
%try fitting
options = optimset('lsqcurvefit');
options = optimset(options,'TolFun',1e-10,'TolX',1e-10,'MaxFunEvals',1000);

x0=[1.,1.,1.]
[c,resnorm] = lsqcurvefit(@lw_btb_neat_fun,x0,q_mit(:,9),heat(8:25,9),[0.,0.,0.],[300.,10.,10.],options)

plot(lw_btb_neat_fun(c,q_mit(:,9)),p(8:25),'m')

