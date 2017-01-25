%fit polynomials in 1/tau to b_mit, b_doh

tau=taumit(2:25);
plot(tau,logb)
xlabel('Tau')
ylabel('b')
hold on
x0=[1.,1.,1.]
fun = @(x,tau) x(1).*tau./(tau.^2 + x(2).*tau + x(3));
[a,resnorm] = lsqcurvefit(fun,x0,tau,logb)
plot(tau,fun(a,tau),'r')

x0=[1.,0.1,0.,0.]
fun2 = @(x,tau) x(1)./(tau + x(2)) +x(3)./(tau + x(4));
[b,resnorm] = lsqcurvefit(fun2,x0,tau,logb)
plot(tau,fun2(b,tau),'g')

x0=[1.,1.,1.,1.]
fun3 = @(x,tau) x(1)./(tau + x(2)) + x(3)./(tau + x(4)).^2;
[c,resnorm] = lsqcurvefit(fun3,x0,tau,logb)
plot(tau,fun3(c,tau),'k')

x0=[-10.,10.,10.,10.]
fun4 = @(x,tau) (x(1).*tau + x(2))./(tau.^2 +x(3).*tau) 
[d,resnorm] = lsqcurvefit(fun4,x0,tau,logb)
plot(tau,fun4(d,tau),'k')


%try log
x0=[1.,1.,1.]
fun = @(x,tau) log(x(1).*tau./(tau.^2 + x(2).*tau + x(3)));
[a,resnorm] = lsqcurvefit(fun,x0,tau,logb)
plot(tau,fun(a,tau),'r')

x0=[1.,0.1,0.,0.]
fun2 = @(x,tau) log(x(1)./(tau + x(2)) + x(3)) ; +x(3)./(tau + x(4)));
[b,resnorm] = lsqcurvefit(fun2,x0,tau,logb)
plot(tau,fun2(b,tau),'g')

x0=[1.,1.,1.,1.]
fun3 = @(x,tau) log(x(1)./(tau + x(2)) + x(3)./(tau + x(4)).^2);
[c,resnorm] = lsqcurvefit(fun3,x0,tau,logb)
plot(tau,fun3(c,tau),'k')

%tau_complete(1:24,1)=taumit(2:25);
%tau_complete(25:48,1)=taudoh(2:25);
%b_complete(1:24,1)=b_mit(1:24);
%b_complete(25:48,1)=b_doh(1:24);
%[trysort,isort]=sort(tau_complete,1);
%tau_complete=tau_complete(isort,:);
%b_complete=b_complete(isort,:);


plot(tau,b_mit,'+')
hold on
plot(taudoh(2:25),b_doh,'+r')
x0=[-10.,10.,10.,10.]
fun4 = @(x,tau) log((x(1).*tau + x(2))./(tau.^2 +x(3).*tau)); 
[d,resnorm] = lsqcurvefit(fun4,x0,tau,logb)
plot(tau,exp(fun4(d,tau)))
plot(taudoh(2:25),exp(fun4(d,taudoh(2:25))),'r')





load('tau_wv_final.mat')

j=1./taumit(2:25);
k=1./taudoh(2:25);

pfm=polyfit(j,b_mit,7);
pfd=polyfit(k,b_doh,7);

ym=polyval(pfm,j);
yd=polyval(pfd,k);
yd_m=interp1(taudoh(2:25),yd,taumit(2:25));
ym_d=interp1(taumit(2:25),ym,taudoh(2:25));

plot(taumit(2:25),b_mit,'x')
hold on
plot(taudoh(2:25),b_doh,'xg')
plot(taumit(2:25),ym)
plot(taudoh(2:25),yd,'g')
set(gca,'YScale','log')
xlabel('Tau')
ylabel('b')
hold off
return
name=['fits.png']
print('-dpng',name) 

%ok fit for order 7

%load up other parts of data from tau_wv_final
load('tau_wv_final_allelse.mat')


%try to find p dependence
%Get b/bmit and pressure for optical depths of taumit to allow checks for 2nd order tau dependence 
for i=1:20
for j=1:18
vec1(:,1)=b(i,j,:);
vec2(:,1)=taureal(i,j,2:25);
b_m(:,1)=interp1(vec2,vec1,taumit(2:25));
p_m(:,1)=interp1(vec2,sigma_half,taumit(2:25));

blev1(i,j)=b_m(1)./b_mit(1);
plev1(i,j)=p_m(1);
blev3(i,j)=b_m(3)./b_mit(3);
plev3(i,j)=p_m(3);
blev4(i,j)=b_m(4)./b_mit(4);
plev4(i,j)=p_m(4);
blev5(i,j)=b_m(5)./b_mit(5);
plev5(i,j)=p_m(5);
blev6(i,j)=b_m(6)./b_mit(6);
plev6(i,j)=p_m(6);
blev7(i,j)=b_m(7)./b_mit(7);
plev7(i,j)=p_m(7);
blev8(i,j)=b_m(8)./b_mit(8);
plev8(i,j)=p_m(8);
blev9(i,j)=b_m(9)./b_mit(9);
plev9(i,j)=p_m(9);
blev10(i,j)=b_m(10)./b_mit(10);
plev10(i,j)=p_m(10);
blev11(i,j)=b_m(11)./b_mit(11);
plev11(i,j)=p_m(11);
blev12(i,j)=b_m(12)./b_mit(12);
plev12(i,j)=p_m(12);
blev13(i,j)=b_m(13)./b_mit(13);
plev13(i,j)=p_m(13);
blev14(i,j)=b_m(14)./b_mit(14);
plev14(i,j)=p_m(14);
blev15(i,j)=b_m(15)./b_mit(15);
plev15(i,j)=p_m(15);
blev20(i,j)=b_m(20)./b_mit(20);
plev20(i,j)=p_m(20);
blev24(i,j)=b_m(24)./b_mit(24);
plev24(i,j)=p_m(24);

plot(p_m(1:24),b_m(1:24)./b_mit(1:24),'+k')

hold on
end
end
%reshape into vector shape
lev1n(:,2)=reshape(blev1,342,1);
lev3n(:,2)=reshape(blev3,342,1);
lev4n(:,2)=reshape(blev4,342,1);
lev5n(:,2)=reshape(blev5,342,1);
lev6n(:,2)=reshape(blev6,342,1);
lev7n(:,2)=reshape(blev7,342,1);
lev8n(:,2)=reshape(blev8,342,1);
lev9n(:,2)=reshape(blev9,342,1);
lev10n(:,2)=reshape(blev10,342,1);
lev11n(:,2)=reshape(blev11,342,1);
lev12n(:,2)=reshape(blev12,342,1);
lev13n(:,2)=reshape(blev13,342,1);
lev14n(:,2)=reshape(blev14,342,1);
lev15n(:,2)=reshape(blev15,342,1);
lev20n(:,2)=reshape(blev20,342,1);
lev24n(:,2)=reshape(blev24,342,1);
lev1n(:,1)=reshape(plev1,342,1);
lev3n(:,1)=reshape(plev3,342,1);
lev4n(:,1)=reshape(plev4,342,1);
lev5n(:,1)=reshape(plev5,342,1);
lev6n(:,1)=reshape(plev6,342,1);
lev7n(:,1)=reshape(plev7,342,1);
lev8n(:,1)=reshape(plev8,342,1);
lev9n(:,1)=reshape(plev9,342,1);
lev10n(:,1)=reshape(plev10,342,1);
lev11n(:,1)=reshape(plev11,342,1);
lev12n(:,1)=reshape(plev12,342,1);
lev13n(:,1)=reshape(plev13,342,1);
lev14n(:,1)=reshape(plev14,342,1);
lev15n(:,1)=reshape(plev15,342,1);
lev20n(:,1)=reshape(plev20,342,1);
lev24n(:,1)=reshape(plev24,342,1);

%reorder by pressure to allow pressure fits
[trysort,isort]=sort(lev3n(:,1),1);
data3=lev3n(isort,:);
[trysort,isort]=sort(lev4n(:,1),1);
data4=lev4n(isort,:);
[trysort,isort]=sort(lev5n(:,1),1);
data5=lev5n(isort,:);
[trysort,isort]=sort(lev6n(:,1),1);
data6=lev6n(isort,:);
[trysort,isort]=sort(lev7n(:,1),1);
data7=lev7n(isort,:);
[trysort,isort]=sort(lev8n(:,1),1);
data8=lev8n(isort,:);
[trysort,isort]=sort(lev9n(:,1),1);
data9=lev9n(isort,:);
[trysort,isort]=sort(lev10n(:,1),1);
data10=lev10n(isort,:);
[trysort,isort]=sort(lev11n(:,1),1);
data11=lev11n(isort,:);
[trysort,isort]=sort(lev12n(:,1),1);
data12=lev12n(isort,:);
[trysort,isort]=sort(lev13n(:,1),1);
data13=lev13n(isort,:);
[trysort,isort]=sort(lev14n(:,1),1);
data14=lev14n(isort,:);
[trysort,isort]=sort(lev15n(:,1),1);
data15=lev15n(isort,:);
[trysort,isort]=sort(lev20n(:,1),1);
data20=lev20n(isort,:);
[trysort,isort]=sort(lev24n(:,1),1);
data24=lev24n(isort,:);

%try plotting the results!
hold on
%plot(data1(:,1),data1(:,2),'+')
plot(data5(:,1),data5(:,2),'+r')
plot(data10(:,1),data10(:,2),'+g')
plot(data15(:,1),data15(:,2),'+k')
plot(data20(:,1),data20(:,2),'+y')
plot(data24(:,1),data24(:,2),'o')

hold on
vec1(:,1)=b(7,3,:);
vec2(:,1)=taureal(7,3,2:25);
b_m(:,1)=interp1(vec2,vec1,taumit(2:25));
p_m(:,1)=interp1(vec2,sigma_half,taumit(2:25));
plot(p_m(4:24),b_m(4:24)./b_mit(4:24),'+')
vec1(:,1)=b(4,4,:);
vec2(:,1)=taureal(4,4,2:25);
b_m(:,1)=interp1(vec2,vec1,taumit(2:25));
p_m(:,1)=interp1(vec2,sigma_half,taumit(2:25));
plot(p_m(4:24),b_m(4:24)./b_mit(4:24),'+k')
vec1(:,1)=b(3,5,:);
vec2(:,1)=taureal(3,5,2:25);
b_m(:,1)=interp1(vec2,vec1,taumit(2:25));
p_m(:,1)=interp1(vec2,sigma_half,taumit(2:25));
plot(p_m(4:24),b_m(4:24)./b_mit(4:24),'+g')
vec1(:,1)=b(3,6,:);
vec2(:,1)=taureal(3,6,2:25);
b_m(:,1)=interp1(vec2,vec1,taumit(2:25));
p_m(:,1)=interp1(vec2,sigma_half,taumit(2:25));
plot(p_m(4:24),b_m(4:24)./b_mit(4:24),'+r')

%will a fit of -f(tau)/(sigma-g(tau)) fit the data well? Use fminsearch to investigate
a=max(find(data3(:,2)>0.))
x0=[0.23,0.23];
f = @(x) sum((data3(1:a,2) - (x(1)./(data3(1:a,1) - x(2)).^2)).^2.);
[x,fval] = fminsearch(f,x0)
record(1,:)=x;
plot(data3(:,1),data3(:,2),'+')
hold on
plot(data3(:,1),x(1)./(data3(:,1) - x(2)).^2,'k')
a=min(find(data4(:,2)>=5.))
x0=[0.23,0.3];
f = @(x) sum((data4(1:a,2) - (x(1)./(data4(1:a,1) - x(2)).^2)).^2.);
[x,fval] = fminsearch(f,x0)
record(2,:)=x;
plot(data4(:,1),data4(:,2),'+g')
plot(data4(:,1),x(1)./(data4(:,1) - x(2)).^2,'k')
a=min(find(data5(:,2)>=5.))
x0=[0.23,0.43];
f = @(x) sum((data5(1:a,2) - (x(1)./(data5(1:a,1) - x(2)).^2)).^2.);
[x,fval] = fminsearch(f,x0)
record(3,:)=x;
plot(data5(:,1),data5(:,2),'+k')
plot(data5(:,1),x(1)./(data5(:,1) - x(2)).^2,'k')
x0=[0.23,0.6];
f = @(x) sum((data6(:,2) - (x(1)./(data6(:,1) - x(2)).^2)).^2.);
[x,fval] = fminsearch(f,x0)
record(4,:)=x;
plot(data6(:,1),data6(:,2),'+y')
plot(data6(:,1),x(1)./(data6(:,1) - x(2)).^2,'k')
x0=[0.23,0.75];
f = @(x) sum((data7(:,2) - (x(1)./(data7(:,1) - x(2)).^2)).^2.);
[x,fval] = fminsearch(f,x0)
record(5,:)=x;
plot(data7(:,1),data7(:,2),'o')
plot(data7(:,1),x(1)./(data7(:,1) - x(2)).^2,'k')
x0=[0.23,0.9];
f = @(x) sum((data8(:,2) - (x(1)./(data8(:,1) - x(2)).^2)).^2.);
[x,fval] = fminsearch(f,x0)
record(6,:)=x;
plot(data8(:,1),data8(:,2),'og')
plot(data8(:,1),x(1)./(data8(:,1) - x(2)).^2,'k')
x0=[0.23,1.]
f = @(x) sum((data9(:,2) - (x(1)./(data9(:,1) - x(2)).^2)).^2.);
[x,fval] = fminsearch(f,x0)
record(7,:)=x;
plot(data9(:,1),data9(:,2),'ok')
plot(data9(:,1),x(1)./(data9(:,1) - x(2)).^2,'k')
x0=[0.23,1.2];
f = @(x) sum((data10(:,2) - (x(1)./(data10(:,1) - x(2)).^2)).^2);
[x,fval] = fminsearch(f,x0)
record(8,:)=x;
plot(data10(:,1),data10(:,2),'oy')
plot(data10(:,1),x(1)./(data10(:,1) - x(2)).^2,'k')
x0=[0.23,1.2];
f = @(x) sum((data11(:,2) - (x(1)./(data11(:,1) - x(2)).^2)).^2);
[x,fval] = fminsearch(f,x0)
record(9,:)=x;
plot(data11(:,1),data11(:,2),'x')
plot(data11(:,1),x(1)./(data11(:,1) - x(2)).^2,'k')
x0=[0.23,1.2];
f = @(x) sum((data12(:,2) - (x(1)./(data12(:,1) - x(2)).^2)).^2);
[x,fval] = fminsearch(f,x0)
record(10,:)=x;
plot(data12(:,1),data12(:,2),'xg')
plot(data12(:,1),x(1)./(data12(:,1) - x(2)).^2,'k')
x0=[0.23,1.2];
f = @(x) sum((data13(1:339,2) - (x(1)./(data13(1:339,1) - x(2)).^2)).^2);
[x,fval] = fminsearch(f,x0)
record(11,:)=x;
plot(data13(:,1),data13(:,2),'xk')
plot(data13(:,1),x(1)./(data13(:,1) - x(2)).^2,'k')
x0=[0.23,1.5];
f = @(x) sum((data14(1:331,2) - (x(1)./(data14(1:331,1) - x(2)).^2)).^2);
[x,fval] = fminsearch(f,x0)
record(12,:)=x;
plot(data14(:,1),data14(:,2),'xy')
plot(data14(:,1),x(1)./(data14(:,1) - x(2)).^2,'k')
x0=[0.23,2.];
f = @(x) sum((data15(1:321,2) - (x(1)./(data15(1:321,1) - x(2)).^2)).^2);
[x,fval] = fminsearch(f,x0)
record(13,:)=x;
plot(data15(:,1),data15(:,2),'xr')
plot(data15(:,1),x(1)./(data15(:,1) - x(2)).^2,'k')
xlabel('b/b_{mit}')                
ylabel('Sigma')
name=['p_fits.png']
print('-dpng',name) 

x0=[0.23,3.];
f = @(x) sum((data20(:,2) - (x(1)./(data20(:,1) - x(2)).^2)).^2);
[x,fval] = fminsearch(f,x0)

hold off
plot(taumit(4:16),record(:,1))
h=polyfit(taumit(4:16),record(:,1),3)
vals=polyval(h,taumit(4:16));
hold on
plot(taumit(4:16),vals,'r')
plot(taumit(4:16),record(:,2))
h=polyfit(taumit(4:16),record(:,2),1)
vals=polyval(h,taumit(4:16));
plot(taumit(4:16),vals,'r')
xlabel('Tau')
ylabel('Coefficient of sigma fit')
name=['coeff_tau.png']
print('-dpng',name) 

return

%try also exp(-tau)

j=(exp(-taumit(2:25))).^0.1;
k=(exp(-taudoh(2:25))).^0.1;
pfm=polyfit(j,b_mit,5);
pfd=polyfit(k,b_doh,5);

ym=polyval(pfm,j);
yd=polyval(pfd,k);

plot(taumit(2:25),b_mit,'x')
hold on
plot(taudoh(2:25),b_doh,'xg')
plot(taumit(2:25),ym)
plot(taudoh(2:25),yd,'g')
%seems not to fit as well


%Try using fminsearch to find fit. (Left in as example of fminsearch)
x0=[1.,1.,1.,1.]
f = @(x) mean((b_mit - (x(1)./((taumit(2:25) + x(2)).^x(3)) - x(4))).^2 + (b_doh - (x(1)./((taudoh(2:25) + x(2)).^x(3)) - x(4))).^2);
[x,fval] = fminsearch(f,x0)


%investigate where need to round 7th order fit to to still be accurate enough
round1=[-6e-11,5e-08,-1e-05,2e-03,-10e-02,3.,-2.e+01,3.e+01];
round2=[-6.2e-11,4.7e-08,-1.3e-05,1.5e-03,-9.6e-02,3.4,-1.5e+01,3.0e+01];
round3=[-6.18e-11,4.74e-08,-1.26e-05,1.53e-03,-9.62e-02,3.41,-1.53e+01,2.97e+01];
round4=[-6.182e-11,4.739e-08,-1.258e-05,1.530e-03,-9.619e-02,3.412,-1.531e+01,2.966e+01];
round5=[-6.1819e-11,4.7391e-08,-1.2584e-05,1.5300e-03,-9.6187e-02,3.4120,-1.5312e+01,2.9659e+01];
round6=[-6.18192e-11,4.73907e-08,-1.25841e-05,1.53004e-03,-9.61875e-02,3.41201e+00,-1.53118e+01,2.96586e+01];
round7=[-6.181919e-11,4.739069e-08,-1.258414e-05,1.530037e-03,-9.618747e-02,3.412009e+00,-1.531176e+01,2.965860e+01];

ym1=polyval(round1,j);
mean(b_mit-ym1).^2
ym2=polyval(round2,j);
mean(b_mit-ym2).^2
ym3=polyval(round3,j);
mean(b_mit-ym3).^2
ym4=polyval(round4,j);
mean(b_mit-ym4).^2
ym5=polyval(round5,j);
mean(b_mit-ym5).^2
ym6=polyval(round6,j);
mean(b_mit-ym6).^2
ym7=polyval(round7,j);
mean(b_mit-ym7).^2

plot(taumit(2:25),b_mit,'xk')
hold on
plot(taumit(2:25),ym1,'y')
plot(taumit(2:25),ym2)
plot(taumit(2:25),ym3,'g')
plot(taumit(2:25),ym4,'r')
plot(taumit(2:25),ym5,'k')
hold off

%Check how fits perform for different wv profiles
subplot(2,1,1), plot(dtaumitdsigma,sigma_half)
hold on
plot(ym.*q_mit_half+amu,sigma_half,'g')  
plot(yd_m.*q_mit_half+amu,sigma_half,'k')
set(gca,'YDir','reverse')
xlabel('dtaudsigma mit')                
ylabel('P, mb')

subplot(2,1,2), plot(dtaudohdsigma,sigma_half)
hold on
plot(ym_d.*wv_half+amu,sigma_half,'g')  
plot(yd.*wv_half+amu,sigma_half,'k')
set(gca,'YDir','reverse')
xlabel('dtaudsigma doh')                
ylabel('Sigma')
name=['dtaudsigma_fits.png']

hold off

dtdscheck(:,1)=dtdsreal(3,6,:);
plot(dtdscheck,sigma_half)
hold on
ym_check(:,1)=interp1(taumit(2:25),ym,taureal(3,6,2:25));
q_check=q_surf(3)*sigma_half.^q_prof(8);
plot(ym_check.*q_check+amu,sigma_half,'r');
set(gca,'YDir','reverse')
xlabel('dtaudsigma')                
ylabel('Sigma')
name=['dtaudsigma_fit_pole.png']
print('-dpng',name) 

