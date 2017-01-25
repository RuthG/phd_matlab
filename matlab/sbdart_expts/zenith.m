%zenith.m

%Investigate importance of changes in tau with zenith angle and parameterise

load('~/matlab/tp_btb/tau_wv_final.mat')
load('~/matlab/tp_btb/tau_wv_final_allelse.mat')

szen = [0,10,20,30,40,50,60,70,80,82,84,86,88,89,90];

for i=1:15

filename = ['~/matlab/sbdart_expts/OUTPUT_zenith_nowv' num2str(szen(i))];

output_zenith = dlmread(filename);
p = output_zenith(2:26,2);
fxdn_zenith(:,i)  = output_zenith(2:26,3);
tau_zenith(:,i) = -log(fxdn_zenith(:,i)./fxdn_zenith(1,i));

end

plot(tau_zenith,p)
set(gca,'YDir','reverse')
xlabel('Tau')
ylabel('Pressure, Pa')

for i=1:24
dtaudsigma_z(i,:) = (tau_zenith(i+1,:)-tau_zenith(i,:))./((p(i+1)-p(i))./1000);
p_half(i) = (p(i)+p(i+1))/2;
end

plot(dtaudsigma_z,p_half)
set(gca,'YDir','reverse')
xlabel('dtaudsigma')
ylabel('Pressure, Pa')

for i=1:15
dtds_norm(:,i) = dtaudsigma_z(:,i)./dtaudsigma_z(:,1);
tau_zenith_norm_n(:,i) = tau_zenith(:,i)./tau_zenith(:,1);
end

a=dtds_norm(1,:);
c=dtds_norm(24,:);

mag(1,:) = 35./(sqrt(1224*cos(szen*pi/180).^2 +1));

%mag(2,:) = 35./(sqrt(1224*cos(szen*pi/180).^2 sin(szen*pi/180) +1));
%mag(3,:) = 25./(sqrt(624*cos(szen*pi/180).^2 +1));
%mag(2,:) = 30./(sqrt(899*cos(szen*pi/180).^2 +1));

plot(szen,mag,'r')
hold on
plot(szen,a)
plot(szen,c,'g')
ylabel('Magnification factor from refraction etc')
xlabel('Solar zenith angle')


%try fitting

options = optimset('lsqcurvefit');
options = optimset(options,'TolFun',1e-10) 

plot(szen(1:14),a(1:14),'+')
hold on
plot(szen,mag(1,:),'r')

x0=[1,1];
%fun3 = @(x,szen) (x(1)+x(2)+x(3))./((x(1)) * cos(szen*pi/180).^2 + x(2)*cos(szen*pi/180) +x(3))  ; 
fun3 = @(x,szen) (x(1)+x(2))./( x(1)*cos(szen*pi/180) +x(2) )  ; 
[c,resnorm] = lsqcurvefit(fun3,x0,szen(1:14),a(1:14),0,5,options);
check=fun3(c,szen(1:14));
plot(szen(1:14),fun3(c,szen(1:14)))
xlabel('Solar zenith angle')
ylabel('Magnification factor at top level')
hold off

resnorm_mag = sum((mag(1:14) - a(1:14)).^2)
resnorm_check = sum((check(1:14) - a(1:14)).^2)

return

c=zeros(11,11,2);
for i=2:10:102
i
for j=2:10:102
x0=[i,j];
iind=(i+8)/10
jind=(j+8)/10
fun3 = @(x,szen) (x(1)+x(2))./( x(1)*cos(szen*pi/180) +x(2) )  ; 
[c(iind,jind,:),resnorm(iind,jind)] = lsqcurvefit(fun3,x0,szen(1:14),a(1:14));
end
end

plot(szen(1:14),fun3(c(2,2,:),szen(1:14)))
xlabel('Solar zenith angle')
ylabel('Magnification factor at top level')
hold off

return
dsigma = 0.0400;

tau_0(1)=0.;
tau_10(1)=0.;
tau_20(1)=0.;
tau_30(1)=0.;
tau_40(1)=0.;
tau_50(1)=0.;
tau_60(1)=0.;
tau_70(1)=0.;
tau_80(1)=0.;
tau_82(1)=0.;
tau_84(1)=0.;
tau_86(1)=0.;
tau_88(1)=0.;
tau_89(1)=0.;
tau_90(1)=0.;


%set factor for background gases
co2 = 0.0596;

for i=1:24

b_check_0(i) = exp(0.0254./(tau_0(i)+0.00814) +1.07./(tau_0(i)+0.378).^2) ;
b_check_10(i) = exp(0.0254./(tau_10(i)+0.00814) +1.07./(tau_10(i)+0.378).^2) ;
b_check_20(i) = exp(0.0254./(tau_20(i)+0.00814) +1.07./(tau_20(i)+0.378).^2) ;
b_check_30(i) = exp(0.0254./(tau_30(i)+0.00814) +1.07./(tau_30(i)+0.378).^2) ;
b_check_40(i) = exp(0.0254./(tau_40(i)+0.00814) +1.07./(tau_40(i)+0.378).^2) ;
b_check_50(i) = exp(0.0254./(tau_50(i)+0.00814) +1.07./(tau_50(i)+0.378).^2) ;
b_check_60(i) = exp(0.0254./(tau_60(i)+0.00814) +1.07./(tau_60(i)+0.378).^2) ;
b_check_70(i) = exp(0.0254./(tau_70(i)+0.00814) +1.07./(tau_70(i)+0.378).^2) ;
b_check_80(i) = exp(0.0254./(tau_80(i)+0.00814) +1.07./(tau_80(i)+0.378).^2) ;
b_check_82(i) = exp(0.0254./(tau_82(i)+0.00814) +1.07./(tau_82(i)+0.378).^2) ;
b_check_84(i) = exp(0.0254./(tau_84(i)+0.00814) +1.07./(tau_84(i)+0.378).^2) ;
b_check_86(i) = exp(0.0254./(tau_86(i)+0.00814) +1.07./(tau_86(i)+0.378).^2) ;
b_check_88(i) = exp(0.0254./(tau_88(i)+0.00814) +1.07./(tau_88(i)+0.378).^2) ;
b_check_89(i) = exp(0.0254./(tau_89(i)+0.00814) +1.07./(tau_89(i)+0.378).^2) ;
b_check_90(i) = exp(0.0254./(tau_90(i)+0.00814) +1.07./(tau_90(i)+0.378).^2) ;

%del_tau_check = b_check.*q_mit + co2
del_tau_0(i) = (b_check_0(i).*q_mit(i) + co2)*check(1); % *mag(1);
del_tau_10(i) = (b_check_10(i).*q_mit(i) + co2)*check(2); % *mag(2);
del_tau_20(i) = (b_check_20(i).*q_mit(i) + co2)*check(3); % *mag(3);
del_tau_30(i) = (b_check_30(i).*q_mit(i) + co2)*check(4); % *mag(4);
del_tau_40(i) = (b_check_40(i).*q_mit(i) + co2)*check(5); % *mag(5);
del_tau_50(i) = (b_check_50(i).*q_mit(i) + co2)*check(6); % *mag(6);
del_tau_60(i) = (b_check_60(i).*q_mit(i) + co2)*check(7); % *mag(7);
del_tau_70(i) = (b_check_70(i).*q_mit(i) + co2)*check(8); % *mag(8);
del_tau_80(i) = (b_check_80(i).*q_mit(i) + co2)*check(9); % *mag(9);
del_tau_82(i) = (b_check_82(i).*q_mit(i) + co2)*check(10); % *mag(10);
del_tau_84(i) = (b_check_84(i).*q_mit(i) + co2)*check(11); % *mag(11);
del_tau_86(i) = (b_check_86(i).*q_mit(i) + co2)*check(12); % *mag(12);
del_tau_88(i) = (b_check_88(i).*q_mit(i) + co2)*check(13); % *mag(13);
del_tau_89(i) = (b_check_89(i).*q_mit(i) + co2)*check(14); % *mag(14);
del_tau_90(i) = (b_check_90(i).*q_mit(i) + co2)*check(14); % *mag(15);

tau_0(i+1) = tau_0(i) + del_tau_0(i).*dsigma;
tau_10(i+1) = tau_10(i) + del_tau_10(i).*dsigma;
tau_20(i+1) = tau_20(i) + del_tau_20(i).*dsigma;
tau_30(i+1) = tau_30(i) + del_tau_30(i).*dsigma;
tau_40(i+1) = tau_40(i) + del_tau_40(i).*dsigma;
tau_50(i+1) = tau_50(i) + del_tau_50(i).*dsigma;
tau_60(i+1) = tau_60(i) + del_tau_60(i).*dsigma;
tau_70(i+1) = tau_70(i) + del_tau_70(i).*dsigma;
tau_80(i+1) = tau_80(i) + del_tau_80(i).*dsigma;
tau_82(i+1) = tau_82(i) + del_tau_82(i).*dsigma;
tau_84(i+1) = tau_84(i) + del_tau_84(i).*dsigma;
tau_86(i+1) = tau_86(i) + del_tau_86(i).*dsigma;
tau_88(i+1) = tau_88(i) + del_tau_88(i).*dsigma;
tau_89(i+1) = tau_89(i) + del_tau_89(i).*dsigma;
tau_90(i+1) = tau_90(i) + del_tau_90(i).*dsigma;

end

dtds_mn(:,1) = del_tau_0(:)./del_tau_0(:);
dtds_mn(:,2) = del_tau_10(:)./del_tau_0(:);
dtds_mn(:,3) = del_tau_20(:)./del_tau_0(:);
dtds_mn(:,4) = del_tau_30(:)./del_tau_0(:);
dtds_mn(:,5) = del_tau_40(:)./del_tau_0(:);
dtds_mn(:,6) = del_tau_50(:)./del_tau_0(:);
dtds_mn(:,7) = del_tau_60(:)./del_tau_0(:);
dtds_mn(:,8) = del_tau_70(:)./del_tau_0(:);
dtds_mn(:,9) = del_tau_80(:)./del_tau_0(:);

a_m = dtds_mn(1,:);
c_m = dtds_mn(24,:);


