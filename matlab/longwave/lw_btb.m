%lw_btb.m
%Compare uni notes 'method' to find dt with results of MIT gcm inversion
%See if current formula will work with different dtaus upward to downward to account for different incident beam

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
%dtau_up_check(i,:) = dfxup(i,:)./(b(i,:) - fxup_half(i+1,:));
dtau_up(i,:) = (b(i,:).*dtau_dn(i,:) - dfxup(i,:))./fxup_half(i+1,:);
end
dfxdn_nw(i,:) = fxdn_half_nw(i+1,:) - fxdn_half_nw(i,:);
dfxup_nw(i,:) = fxup_half_nw(i,:) -fxup_half_nw(i+1,:);
dtau_dn_nw(i,:) = dfxdn_nw(i,:)./(b(i,:) - fxdn_half_nw(i,:));
dtau_up_nw(i,:) = (b(i,:).*dtau_dn_nw(i,:) - dfxup_nw(i,:))./fxup_half_nw(i+1,:);
end

check = zeros(26,9);
check(1,:) = fxdn(1,:);
for i=1:25
check(i+1,:) = check(i,:) + dfxdn(i,:);
end

check2 = zeros(25,9);
for i=1:25
check2(i,:) = dtau_dn(i,:).*(b(i,:)-fxdn_half(i,:));
end

check(1,:) = fxdn(1,:);
for i=1:25
check(i+1,:) = check(i,:) + check2(i,:);
end


%for i=1:25
%b(i) = stefan*t(i).^4;
%dtrans_dn(i) = (fxdn_half(i+1)-b(i))./(fxdn_half(i)-b(i));
%dtrans_up(i) = (fxup_half(i)-b(i))./(fxup_half(i+1)-b(i));
%del_tau_dn(i) = -log(dtrans_dn(i));
%del_tau_up(i) = -log(dtrans_up(i));
%end

plot(q_mit,dtau_dn,'x')
%set(gca,'YDir','reverse')
xlabel('q, kg/kg')
ylabel('dtau_{dn} v q')
name=['dtau_dn.png']
print('-dpng',name) 

plot(q_mit,dtau_up,'x')
%set(gca,'YDir','reverse')
xlabel('q, kg/kg')
ylabel('dtau_{up} v q')
name=['dtau_up.png']
print('-dpng',name) 

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
[trysort,isort]=sort(merger(:,1),1);
data=merger(isort,:);

par(:,1) = polyfit(data(:,1),data(:,2),1)
par(:,2) = polyfit(data(:,1),data(:,3),1)
par(:,3) = polyfit(data(208:225,1),data(208:225,3),1)

save('lw_btb.mat')

amu_dn = mean(mean(dtds_dn_nw));
amu_up = mean(mean(dtds_up_nw)); 

b_par_dn = (dtds_dn - amu_dn)./q_mit;
plot(fxdn_half(1:25,:),b_par_dn(:,:),'x');
xlabel('Downward flux, W/m^2')
ylabel('b_{down}')
name=['b_dn_v_fxdn.png']
print('-dpng',name) 
hold off

for i=1:9
fake_tau(:,i) = fxup_half(2:26,i)./fxup_half(26,i);
end
 
b_par_up = (dtds_up - amu_up)./q_mit;
plot(fake_tau(:,:),b_par_up(:,:),'x');
xlabel('Upward flux, W/m^2')
ylabel('b_{up}')
name=['b_up_v_fxup.png']
print('-dpng',name) 
return

options = optimset('lsqcurvefit');
options = optimset(options,'TolFun',1e-10,'TolX',1e-10,'MaxFunEvals',1000);
funky = @(x,q) x(1).*q.^2 +x(2) + x(3).*exp(-x(4).*q);
x0=[1.,1.,1.,1.,]
[c,resnorm] = lsqcurvefit(funky,x0,data(:,1),data(:,2)) ; %q_mit(:,9),dtau_dn(:,9))

fun3 = @(x,q) x(1).*(1-exp(-x(2).*q));
x0=[0.1,0.1]
[c,resnorm] = lsqcurvefit(fun3,x0,q_mit(1:17,9),dtau_dn(1:17,9),-1.,1.,options) ; 

pars_dn = polyfit(q_mit(:,9),dtau_dn(:,9),5);
vals_dn = polyval(pars_dn,q_mit(:,9));
plot(q_mit(:,9),vals_dn);

pars_up = polyfit(q_mit(:,9),dtau_up(:,9),5);
vals_up = polyval(pars_up,q_mit(:,9));
plot(q_mit(:,9),dtau_up(:,9));
hold on
plot(q_mit(:,9),vals_up);
