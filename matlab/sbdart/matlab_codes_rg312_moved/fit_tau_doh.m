%fit_tau_doh.m
%find a polynomial to relate pressure to tau using 'textbook' Dopplick data.

%Read in shortwave sbdart output
outputsw = dlmread('OUTPUT_SW_DOH');
z     = outputsw(2:26,1);
p     = outputsw(2:26,2);
fxdnsw  = outputsw(2:26,3);
fxupsw  = outputsw(2:26,4);
fxdirsw = outputsw(2:26,5);
dfdzsw  = outputsw(2:26,6);
heatsw  = outputsw(2:26,7);

%calculate tau
tausbdart=log(fxdnsw(1)./fxdnsw);

%calculate p/ps
pscale=p/p(25);


%try polynomial fits to whole thing

fit_1 = polyfit(pscale,tausbdart,1)
check_1 = fit_1(1)*pscale + fit_1(2);

fit_2 = polyfit(pscale,tausbdart,2)
check_2 = fit_2(1)*pscale.^2 + fit_2(2)*pscale + fit_2(3);

fit_3 = polyfit(pscale,tausbdart,3)
check_3 = fit_3(1)*pscale.^3 + fit_3(2)*pscale.^2 + fit_3(3)*pscale + fit_3(4);

fit_4 = polyfit(pscale,tausbdart,4)
check_4 = fit_4(1)*pscale.^4 + fit_4(2)*pscale.^3 +fit_4(3)*pscale.^2 + fit_4(4)*pscale + fit_4(5);

%try polynomial fits under 260mb

fit_low_1 = polyfit(pscale(7:25),tausbdart(7:25),1)
check_low_1 = fit_low_1(1)*pscale + fit_low_1(2);

fit_low_2 = polyfit(pscale(7:25),tausbdart(7:25),2)
check_low_2 = fit_low_2(1)*pscale.^2 + fit_low_2(2)*pscale + fit_low_2(3);

fit_low_3 = polyfit(pscale(7:25),tausbdart(7:25),3)
check_low_3 = fit_low_3(1)*pscale.^3 + fit_low_3(2)*pscale.^2 + fit_low_3(3)*pscale + fit_low_3(4);

fit_low_4 = polyfit(pscale(7:25),tausbdart(7:25),4)
check_low_4 = fit_low_4(1)*pscale.^4 + fit_low_4(2)*pscale.^3 +fit_low_4(3)*pscale.^2 + fit_low_4(4)*pscale + fit_low_4(5);

%try regression in quartic and linear terms

X(:,1)=ones(25,1);
X(:,2)=pscale;
X(:,3)=pscale.^4;

fit_regress = regress(tausbdart,X)
check_regress= fit_regress(1)*X(:,1) + fit_regress(2)*X(:,2) + fit_regress(3)*X(:,3);
plot(tausbdart,p,'r')
hold on
plot(check_regress,p,'g')
set(gca,'YDir','reverse')
xlabel('Solar optical depth')
ylabel('Pressure')
name=['regress.png']
print('-dpng',name) 
hold off

fit_regress_low = regress(tausbdart(7:25),X(7:25,:))
check_regress_low= fit_regress_low(1)*X(:,1) + fit_regress_low(2)*X(:,2) + fit_regress_low(3)*X(:,3);
plot(tausbdart,p,'r')
hold on
plot(check_regress_low,p,'g')
set(gca,'YDir','reverse')
xlabel('Solar optical depth')
ylabel('Pressure')
name=['regress_low.png']
print('-dpng',name) 
hold off

kai_regress = mean((check_regress - tausbdart).^2)*1000000
kai_regress_low = mean((check_regress_low(7:25) - tausbdart(7:25)).^2)*1000000

plot(tausbdart,p,'r')
hold on
plot(check_1,p,'g')
set(gca,'YDir','reverse')
xlabel('Solar optical depth')
ylabel('Pressure')
name=['linear.png']
print('-dpng',name) 
hold off
plot(tausbdart,p,'r')
hold on
plot(check_2,p,'g')
set(gca,'YDir','reverse')
xlabel('Solar optical depth')
ylabel('Pressure')
name=['quadratic.png']
print('-dpng',name) 
hold off
plot(tausbdart,p,'r')
hold on
plot(check_3,p,'g')
set(gca,'YDir','reverse')
xlabel('Solar optical depth')
ylabel('Pressure')
name=['cubic.png']
print('-dpng',name) 
hold off
plot(tausbdart,p,'r')
hold on
plot(check_4,p,'g')
set(gca,'YDir','reverse')
xlabel('Solar optical depth')
ylabel('Pressure')
name=['quartic.png']
print('-dpng',name) 
hold off

kai_1 = mean((check_1 - tausbdart).^2)*1000000
kai_2 = mean((check_2 - tausbdart).^2)*1000000
kai_3 = mean((check_3 - tausbdart).^2)*1000000
kai_4 = mean((check_4 - tausbdart).^2)*1000000

kai_low_1 = mean((check_low_1(7:25) - tausbdart(7:25)).^2)*1000000
kai_low_2 = mean((check_low_2(7:25) - tausbdart(7:25)).^2)*1000000
kai_low_3 = mean((check_low_3(7:25) - tausbdart(7:25)).^2)*1000000
kai_low_4 = mean((check_low_4(7:25) - tausbdart(7:25)).^2)*1000000

