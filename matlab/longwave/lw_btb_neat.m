%lw_btb_neat.m
%load in fluxes, try to fit polynomials

load('sbdart_lw.mat')
index=9;
p	= 2000:4000:98000;
p_half 	= 0:4000:100000;
t	= t_mit(:,index);
stefan 	= 5.67e-8;
grav 	= 9.81;
RDGAS  	= 287.04;
KAPPA  	= 2./7.;
cp_air 	= RDGAS/KAPPA;
spd 	= 86400;


%Read in results of lw runs
for i = 1:9
output_lw(:,:,i) = dlmread(['~/matlab/longwave/check_window/OUTPUT_lw' num2str(91-i*10)]);
output_lw_nowv(:,:,i) = dlmread(['~/matlab/longwave/nowv/OUTPUT_lw_nowv' num2str(91-i*10)]);
end

%translate fluxes onto half layers as in MITgcm
for i=1:9
fxdn(:,i)  = output_lw(2:26,3,i);
fxup(:,i)  = output_lw(2:26,4,i);
heat(:,i)  = output_lw(2:26,7,i);
fxdn_nw(:,i)  = output_lw_nowv(2:26,3,i);
fxup_nw(:,i)  = output_lw_nowv(2:26,4,i);
heat_nw(:,i)  = output_lw_nowv(2:26,7,i);
end

fxdn_half = interp1(p,fxdn,p_half,'linear','extrap');
fxup_half = interp1(p,fxup,p_half,'linear','extrap');
t_mit_half = interp1(p,t_mit,p_half,'linear','extrap');

fxdn_half_nw = interp1(p,fxdn_nw,p_half,'linear','extrap');
fxup_half_nw = interp1(p,fxup_nw,p_half,'linear','extrap');

b = stefan*t_mit.^4;

for i=1:25
dfxdn(i,:) = fxdn_half(i+1,:) - fxdn_half(i,:);
dfxup(i,:) = fxup_half(i,:) -fxup_half(i+1,:);
dtau_dn(i,:) = dfxdn(i,:)./(b(i,:) - fxdn_half(i,:));
%dtau_up(i,:) = dfxup(i,:)./(b(i,:) - fxup_half(i+1,:));
dtau_up(i,:) = (b(i,:).*dtau_dn(i,:) - dfxup(i,:))./fxup_half(i+1,:);

dfxdn_nw(i,:) = fxdn_half_nw(i+1,:) - fxdn_half_nw(i,:);
dfxup_nw(i,:) = fxup_half_nw(i,:) -fxup_half_nw(i+1,:);
dtau_dn_nw(i,:) = dfxdn_nw(i,:)./(b(i,:) - fxdn_half_nw(i,:));
dtau_up_nw(i,:) = (b(i,:).*dtau_dn_nw(i,:) - dfxup_nw(i,:))./fxup_half_nw(i+1,:);
end

%plot(q_mit,dtau_dn,'x')
%set(gca,'YDir','reverse')
%xlabel('q, kg/kg')
%ylabel('dtau_{dn} v q')
%name=['dtau_dn.png']
%print('-dpng',name) 

%plot(q_mit,dtau_up,'x')
%set(gca,'YDir','reverse')
%xlabel('q, kg/kg')
%ylabel('dtau_{up} v q')
%name=['dtau_up.png']
%print('-dpng',name) 

dsigma = 0.04;
dtds_dn = dtau_dn./dsigma;
dtds_up = dtau_up./dsigma;
dtds_dn_nw = dtau_dn_nw./dsigma;
dtds_up_nw = dtau_up_nw./dsigma;

%merge q and dtds_dn profs

for i=1:9
merger((1:25)+(i-1)*25,1) = q_mit(:,i);
merger((1:25)+(i-1)*25,2) = dtds_dn(:,i);
merger((1:25)+(i-1)*25,3) = dtds_up(:,i);
merger((1:25)+(i-1)*25,4) = fxdn(:,i);
merger((1:25)+(i-1)*25,5) = fxup(:,i);
end
clear merger
for i=1:9
merger((1:17)+(i-1)*17,1) = q_mit(9:25,i);
merger((1:17)+(i-1)*17,2) = dtds_dn(9:25,i);
merger((1:17)+(i-1)*17,3) = dtds_up(9:25,i);
merger((1:17)+(i-1)*17,4) = fxdn(9:25,i);
merger((1:17)+(i-1)*17,5) = fxup(9:25,i);
end
[trysort,isort]=sort(merger(:,1),1);
data=merger(isort,:);

%try fitting
pars_dn = polyfit(data(:,1),data(:,2).*dsigma,1);
vals_dn = polyval(pars_dn,q_mit(:,9));
plot(q_mit(:,9),dtau_dn(:,9));
hold on
plot(q_mit(:,9),vals_dn);

pars_up = polyfit(data(:,1),data(:,3).*dsigma,1);
vals_up = polyval(pars_up,q_mit(:,9));
plot(q_mit(:,9),dtau_up(:,9));
hold on
plot(q_mit(:,9),vals_up);


%check fit
dt_dn = polyval(c(1:2),q_mit) ;%.*dsigma;
dt_up = polyval(pars_up,q_mit); %.*dsigma;

dt_mit = (0.8678 + 1.9929e3.*q_mit).*dsigma;


down = zeros(26,9);
up = zeros(26,9);
up(26,:) = fxup_half(26,:) ; %stefan.*t_mit_half(26,:).^4;
up_mit(26,:) = fxup_half(26,:) ;
%down(1,:) = fxdn_half(1,:);
down_mit(1,:) = fxdn_half(1,:);
for i=1:25
down(i+1,:) = down(i,:).*(1-dt_dn(i,:)) + b(i,:).*dt_dn(i,:);
down_mit(i+1,:) = down_mit(i,:).*(1-dt_mit(i,:)) + b(i,:).*dt_mit(i,:);
end

for i=25:-1:1
up(i,:) = up(i+1,:).*(1-c(3).*dt_dn(i,:)) + 1.*b(i,:).*dt_dn(i,:);
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

%hold off
plot(heat(:,9),p,'b');
hold on
plot(heating(:,9),p,'g');


options = optimset('lsqcurvefit');
options = optimset(options,'TolFun',1e-10,'TolX',1e-10,'MaxFunEvals',1000);

x0=[1.,1.,1.]
[c,resnorm] = lsqcurvefit(@lw_btb_neat_fun,x0,q_mit(:,9),heat(9:25,9),[-100.,0.,0.],[100.,100.,100.],options) ; 


