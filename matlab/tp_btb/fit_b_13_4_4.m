%fit polynomials in 1/tau to b_mit, b_doh

load('tau_wv_final.mat')

tau = taumit(2:25);
logb=log(b_mit);
%tau_complete(1:24,1)=taumit(2:25);
%tau_complete(25:48,1)=taudoh(2:25);
%b_complete(1:24,1)=b_mit(1:24);
%b_complete(25:48,1)=b_doh(1:24);
%[trysort,isort]=sort(tau_complete,1);
%tau_complete=tau_complete(isort,:);
%b_complete=b_complete(isort,:);

%Try two functions with different complexities
plot(tau,b_mit,'+')
hold on
plot(taudoh(2:25),b_doh,'+r')
x0=[1.,1.,1.,1.]
fun3 = @(x,tau) x(1)./(tau + x(2)) + x(3)./(tau + x(4)).^2;
[c,resnorm] = lsqcurvefit(fun3,x0,tau,logb)
plot(tau,exp(fun3(c,tau)))
plot(taudoh(2:25),exp(fun3(c,taudoh(2:25))),'r')
xlabel('Tau')
ylabel('b')
hold off

plot(tau,b_mit,'+')
hold on
plot(taudoh(2:25),b_doh,'+r')
x0=[-5.,2.,0.04]
fun4 = @(x,tau) log((x(1).*tau + x(2))./(tau.^2 +x(3).*tau)); 
[d,resnorm] = lsqcurvefit(fun4,x0,tau,logb)
plot(tau,exp(fun4(d,tau)))
plot(taudoh(2:25),exp(fun4(d,taudoh(2:25))),'r')
xlabel('Tau')
ylabel('b')

mitprof=exp(fun4(d,tau));
dohprof=exp(fun4(d,taudoh(2:25)));

%load up other parts of data from tau_wv_final
load('tau_wv_final_allelse.mat')

hold off
%try to find p dependence
%Get b/bmit and pressure for optical depths of taumit to allow checks for 2nd order tau dependence 
for i=1:19
for j=1:15
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
lev1n(:,2)=reshape(blev1,285,1);
lev3n(:,2)=reshape(blev3,285,1);
lev4n(:,2)=reshape(blev4,285,1);
lev5n(:,2)=reshape(blev5,285,1);
lev6n(:,2)=reshape(blev6,285,1);
lev7n(:,2)=reshape(blev7,285,1);
lev8n(:,2)=reshape(blev8,285,1);
lev9n(:,2)=reshape(blev9,285,1);
lev10n(:,2)=reshape(blev10,285,1);
lev11n(:,2)=reshape(blev11,285,1);
lev12n(:,2)=reshape(blev12,285,1);
lev13n(:,2)=reshape(blev13,285,1);
lev14n(:,2)=reshape(blev14,285,1);
lev15n(:,2)=reshape(blev15,285,1);
lev20n(:,2)=reshape(blev20,285,1);
lev24n(:,2)=reshape(blev24,285,1);
lev1n(:,1)=reshape(plev1,285,1);
lev3n(:,1)=reshape(plev3,285,1);
lev4n(:,1)=reshape(plev4,285,1);
lev5n(:,1)=reshape(plev5,285,1);
lev6n(:,1)=reshape(plev6,285,1);
lev7n(:,1)=reshape(plev7,285,1);
lev8n(:,1)=reshape(plev8,285,1);
lev9n(:,1)=reshape(plev9,285,1);
lev10n(:,1)=reshape(plev10,285,1);
lev11n(:,1)=reshape(plev11,285,1);
lev12n(:,1)=reshape(plev12,285,1);
lev13n(:,1)=reshape(plev13,285,1);
lev14n(:,1)=reshape(plev14,285,1);
lev15n(:,1)=reshape(plev15,285,1);
lev20n(:,1)=reshape(plev20,285,1);
lev24n(:,1)=reshape(plev24,285,1);

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

%Check what range of values of b/b_mit we need to worry about for 'realistic' wv profiles
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

%will a fit of -f(tau)/(sigma-g(tau)) fit the data well? Use lsqcurvefit to investigate

%investigate different sigma dependencies

%x0=[0.23,0.75];
%fun = @(x,data) x(1)./(data - x(2)).^2;
x0=[-0.83,-0.23,0.75]
fun = @(x,data) (x(1)*data + x(2))./(data - x(3));

%logf3 = log(data3(:,2));
% h(1,:)=polyfit(data3(:,1),logf3,2); 
%plot(data3(:,1),logf3,'+');
%hold on
%vals=polyval(h(1,:),data3(:,1));
%plot(data3(:,1),vals);
logf4 = log(data4(:,2));
 h(2,:)=polyfit(data4(:,1),logf4,1) ;
plot(data4(:,1),logf4,'+');
hold on
vals=polyval(h(2,:),data4(:,1));
plot(data4(:,1),vals,'k','LineWidth',3);
logf5 = log(data5(:,2));
 h(3,:)=polyfit(data5(:,1),logf5,1) ;
plot(data5(:,1),logf5,'+');
hold on
vals=polyval(h(3,:),data5(:,1));
plot(data5(:,1),vals,'k','LineWidth',3);
logf6 = log(data6(:,2));
 h(4,:)=polyfit(data6(:,1),logf6,1) ;
plot(data6(:,1),logf6,'+');
hold on
vals=polyval(h(4,:),data6(:,1));
plot(data6(:,1),vals,'k','LineWidth',3);
logf7 = log(data7(:,2));
 h(5,:)=polyfit(data7(:,1),logf7,1) ;
plot(data7(:,1),logf7,'+');
hold on
vals=polyval(h(5,:),data7(:,1));
plot(data7(:,1),vals,'k','LineWidth',3);
logf8 = log(data8(:,2));
 h(6,:)=polyfit(data8(:,1),logf8,1) ;
plot(data8(:,1),logf8,'+');
hold on
vals=polyval(h(6,:),data8(:,1));
plot(data8(:,1),vals,'k','LineWidth',3);
logf9 = log(data9(:,2));
 h(7,:)=polyfit(data9(:,1),logf9,1) ;
plot(data9(:,1),logf9,'+');
hold on
vals=polyval(h(7,:),data9(:,1));
plot(data9(:,1),vals,'k','LineWidth',3);
logf10 = log(data10(:,2));
 h(8,:)=polyfit(data10(:,1),logf10,1) ;
plot(data10(:,1),logf10,'+');
hold on
vals=polyval(h(8,:),data10(:,1));
plot(data10(:,1),vals,'k','LineWidth',3);
logf11 = log(data11(:,2));
 h(9,:)=polyfit(data11(:,1),logf11,1) ;
plot(data11(:,1),logf11,'+');
hold on
vals=polyval(h(9,:),data11(:,1));
plot(data11(:,1),vals,'k','LineWidth',3);
logf12 = log(data12(:,2));
 h(10,:)=polyfit(data12(:,1),logf12,1) ;
plot(data12(:,1),logf12,'+');
hold on
vals=polyval(h(10,:),data12(:,1));
plot(data12(:,1),vals,'k','LineWidth',3);
logf13 = log(data13(:,2));
 h(11,:)=polyfit(data13(2:285,1),logf13(2:285),1) ;
plot(data13(:,1),logf13,'+');
hold on
vals=polyval(h(11,:),data13(:,1));
plot(data13(:,1),vals,'k','LineWidth',3);
logf14 = log(data14(:,2));
 h(12,:)=polyfit(data14(2:277,1),logf14(2:277),1) ;
plot(data14(:,1),logf14,'+');
hold on
vals=polyval(h(12,:),data14(:,1));
plot(data14(:,1),vals,'k','LineWidth',3);
logf15 = log(data15(:,2));
 h(13,:)=polyfit(data15(2:270,1),logf15(2:270),1) ;
plot(data15(:,1),logf15,'+');
hold on
vals=polyval(h(13,:),data15(:,1));
plot(data15(:,1),vals,'k','LineWidth',3);

x0=[-0.83,0.75]
fun = @(x,data) (x(1)*data -0.25)./(data - x(2));

[coeff,resnorm] = lsqcurvefit(fun,x0,data7(2:size(data7,1),1),data7(2:size(data7,1),2))
store(5,:)=coeff;
plot(data7(2:size(data7,1),1),data7(2:size(data7,1),2),'+r')
hold on
plot(data7(2:size(data7,1),1),fun(coeff,data7(2:size(data7,1),1)),'k')

a=min(find(data4(:,2)>=5.))
%x0=[0.23,0.23]
%fun = @(x,data) x(1)./(data - x(2)).^2;
%x0=[-0.83,0.75]
%fun = @(x,data) (x(1)*data -0.25)./(data - x(2));
x0=[0.23,0.23,1.]
fun = @(x,data) exp(x(1)*data - x(2)) + x(3) ;
[coeff,resnorm] = lsqcurvefit(fun,x0,data4(2:a,1),data4(2:a,2))
plot(data4(2:a,1),data4(2:a,2),'+g')
hold on
plot(data4(2:a,1),fun(coeff,data4(2:a,1)),'k')

%find left over tau dep for these

a=min(find(data3(2:size(data3,1),2)<0.))
%x0=[0.23,0.23]
%fun = @(x,data) x(1)./(data - x(2)).^2;
%x0=[-0.83,0.75]
%fun = @(x,data) (x(1)*data -0.25)./(data - x(2));
x0=[0.23,0.23,1.]
fun = @(x,data) exp(x(1)*data - x(2)) + x(3) ;
[coeff,resnorm] = lsqcurvefit(fun,x0,data3(2:a,1),data3(2:a,2))
store(1,:)=coeff;
plot(data3(2:a,1),data3(2:a,2),'+')
hold on
plot(data3(2:a,1),fun(coeff,data3(2:a,1)),'k')

a=min(find(data4(:,2)>=5.))
%x0=[0.23,0.3];
%fun = @(x,data) x(1)./(data - x(2)).^2;
%x0=[-0.83,0.75]
%fun = @(x,data) (x(1)*data -0.25)./(data - x(2));
x0=[0.23,0.23,1.]
fun = @(x,data) exp(x(1)*data - x(2)) + x(3) ;
[coeff,resnorm] = lsqcurvefit(fun,x0,data4(2:a,1),data4(2:a,2));
store(2,:)=coeff;
plot(data4(2:a,1),data4(2:a,2),'+g')
hold on
plot(data4(2:a,1),fun(coeff,data4(2:a,1)),'k')

a=min(find(data5(:,2)>=5.))
%x0=[0.23,0.43];
%fun = @(x,data) x(1)./(data - x(2)).^2;
%x0=[-0.83,0.75]
%fun = @(x,data) (x(1)*data -0.25)./(data - x(2));
x0=[0.23,0.23,1.]
fun = @(x,data) exp(x(1)*data - x(2)) + x(3) ;
[coeff,resnorm] = lsqcurvefit(fun,x0,data5(2:a,1),data5(2:a,2))
store(3,:)=coeff;
plot(data5(2:a,1),data5(2:a,2),'+k')
hold on
plot(data5(2:a,1),fun(coeff,data5(2:a,1)),'k')
plot(data5(2:a,1),(10.38*taumit(6) - 0.1038)./(data5(2:a,1) - (-68.8*taumit(6).^2+21.34*taumit(6)+0.02).^2));


%x0=[0.23,0.6];
%fun = @(x,data) x(1)./(data - x(2)).^2;
%x0=[-0.83,0.75]
%fun = @(x,data) (x(1)*data -0.25)./(data - x(2));
x0=[0.23,0.23,1.]
fun = @(x,data) exp(x(1)*data - x(2)) + x(3) ;
[coeff,resnorm] = lsqcurvefit(fun,x0,data6(2:size(data6,1),1),data6(2:size(data6,1),2))
store(4,:)=coeff;
plot(data6(2:size(data6,1),1),data6(2:size(data6,1),2),'+y')
hold on
plot(data6(2:size(data6,1),1),fun(coeff,data6(2:size(data6,1),1)),'k')

%x0=[0.23,0.75];
%fun = @(x,data) x(1)./(data - x(2)).^2;
%x0=[-0.83,0.75]
%fun = @(x,data) (x(1)*data -0.25)./(data - x(2));
x0=[0.23,0.23,1.]
fun = @(x,data) exp(x(1)*data - x(2)) + x(3) ;
[coeff,resnorm] = lsqcurvefit(fun,x0,data7(2:size(data7,1),1),data7(2:size(data7,1),2))
store(5,:)=coeff;
plot(data7(2:size(data7,1),1),data7(2:size(data7,1),2),'+r')
hold on
plot(data7(2:size(data7,1),1),fun(coeff,data7(2:size(data7,1),1)),'k')

%x0=[0.23,0.9];
%fun = @(x,data) x(1)./(data - x(2)).^2;
%x0=[-0.83,1.]
%fun = @(x,data) (x(1)*data -0.25)./(data - x(2));
x0=[0.23,0.23,1.]
fun = @(x,data) exp(x(1)*data - x(2)) + x(3) ;
[coeff,resnorm] = lsqcurvefit(fun,x0,data8(2:size(data8,1),1),data8(2:size(data8,1),2))
store(6,:)=coeff;
plot(data8(2:size(data8,1),1),data8(2:size(data8,1),2),'+')
hold on
plot(data8(2:size(data8,1),1),fun(coeff,data8(2:size(data8,1),1)),'k')

%x0=[0.23,1.]
%fun = @(x,data) x(1)./(data - x(2)).^2;
%x0=[-0.83,1.]
%fun = @(x,data) (x(1)*data -0.25)./(data - x(2));
x0=[0.23,0.23,1.]
fun = @(x,data) exp(x(1)*data - x(2)) + x(3) ;
[coeff,resnorm] = lsqcurvefit(fun,x0,data9(2:size(data9,1),1),data9(2:size(data9,1),2))
store(7,:)=coeff;
plot(data9(2:size(data9,1),1),data9(2:size(data9,1),2),'+g')
hold on
plot(data9(2:size(data9,1),1),fun(coeff,data9(2:size(data9,1),1)),'k')

%x0=[0.23,1.2];
%fun = @(x,data) x(1)./(data - x(2)).^2;
%x0=[-0.83,1.]
%fun = @(x,data) (x(1)*data -0.25)./(data - x(2));
x0=[0.23,0.23,1.]
fun = @(x,data) exp(x(1)*data - x(2)) + x(3) ;
[coeff,resnorm] = lsqcurvefit(fun,x0,data10(2:size(data10,1),1),data10(2:size(data10,1),2))
store(8,:)=coeff;
plot(data10(2:size(data10,1),1),data10(2:size(data10,1),2),'+k')
hold on
plot(data10(2:size(data10,1),1),fun(coeff,data10(2:size(data10,1),1)),'k')

%x0=[0.23,1.2];
%fun = @(x,data) x(1)./(data - x(2)).^2;
%x0=[-0.83,1.]
%fun = @(x,data) (x(1)*data -0.25)./(data - x(2));
x0=[0.23,0.23,1.]
fun = @(x,data) exp(x(1)*data - x(2)) + x(3) ;
[coeff,resnorm] = lsqcurvefit(fun,x0,data11(2:size(data11,1),1),data11(2:size(data11,1),2))
store(9,:)=coeff;
plot(data11(2:size(data11,1),1),data11(2:size(data11,1),2),'+y')
hold on
plot(data11(2:size(data11,1),1),fun(coeff,data11(2:size(data11,1),1)),'k')

%x0=[0.23,1.2];
%fun = @(x,data) x(1)./(data - x(2)).^2;
%x0=[-0.83,1.]
%fun = @(x,data) (x(1)*data -0.25)./(data - x(2));
x0=[0.23,0.23,1.]
fun = @(x,data) exp(x(1)*data - x(2)) + x(3) ;
[coeff,resnorm] = lsqcurvefit(fun,x0,data12(2:size(data12,1),1),data12(2:size(data12,1),2))
store(10,:)=coeff;
plot(data12(2:size(data12,1),1),data12(2:size(data12,1),2),'+r')
hold on
plot(data12(2:size(data12,1),1),fun(coeff,data12(2:size(data12,1),1)),'k')

%x0=[0.23,1.2];
%fun = @(x,data) x(1)./(data - x(2)).^2;
%x0=[-0.83,1.]
%fun = @(x,data) (x(1)*data -0.25)./(data - x(2));
x0=[0.23,0.23,1.]
fun = @(x,data) exp(x(1)*data - x(2)) + x(3) ;
[coeff,resnorm] = lsqcurvefit(fun,x0,data13(2:285,1),data13(2:285,2))
store(11,:)=coeff;
plot(data13(2:285,1),data13(2:285,2),'+')
hold on
plot(data13(2:285,1),fun(coeff,data13(2:285,1)),'k')

%x0=[0.23,1.5];
%fun = @(x,data) x(1)./(data - x(2)).^2;
%x0=[-0.83,1.]
%fun = @(x,data) (x(1)*data -0.25)./(data - x(2));
x0=[0.23,0.23,1.]
fun = @(x,data) exp(x(1)*data - x(2)) + x(3) ;
[coeff,resnorm] = lsqcurvefit(fun,x0,data14(2:277,1),data14(2:277,2))
store(12,:)=coeff;
plot(data14(2:277,1),data14(2:277,2),'+g')
hold on
plot(data14(2:277,1),fun(coeff,data14(2:277,1)),'k')

%x0=[0.23,2.];
%fun = @(x,data) x(1)./(data - x(2)).^2;
%x0=[-0.83,1.]
%fun = @(x,data) (x(1)*data -0.25)./(data - x(2));
x0=[0.23,0.23,1.]
fun = @(x,data) exp(x(1)*data - x(2)) + x(3) ;
[coeff,resnorm] = lsqcurvefit(fun,x0,data15(2:270,1),data15(2:270,2))
store(13,:)=coeff;
plot(data15(2:270,1),data15(2:270,2),'+k')
hold on
plot(data15(2:270,1),fun(coeff,data15(2:270,1)),'k')
ylabel('b/b_{mit}')                
xlabel('Sigma')
name=['p_fits.png']
print('-dpng',name) 

%x0=[0.23,3.];
%fun = @(x,data) x(1)./(data - x(2)).^2;
%[x,fval] = fminsearch(f,x0)

hold off
plot(taumit(4:16),store(:,1))
h=polyfit(taumit(4:16),store(:,1),3)
vals=polyval(h,taumit(4:16));
hold on
plot(taumit(4:16),vals,'r')
plot(taumit(4:16),store(:,2))
h=polyfit(taumit(4:16),store(:,2),2)
vals=polyval(h,taumit(4:16));
plot(taumit(4:16),vals,'r')
xlabel('Tau')
ylabel('Coefficient of sigma fit')
name=['coeff_tau.png']
print('-dpng',name) 

return

%Check how fits perform for different wv profiles
subplot(2,1,1), plot(dtaumitdsigma,sigma_half)
hold on
plot(mitprof.*q_mit_half+amu,sigma_half,'g')  

set(gca,'YDir','reverse')
xlabel('dtaudsigma mit')                
ylabel('Sigma')

subplot(2,1,2), plot(dtaudohdsigma,sigma_half)
hold on
plot(dohprof.*wv_half+amu,sigma_half,'g')  

set(gca,'YDir','reverse')
xlabel('dtaudsigma doh')                
ylabel('Sigma')
name=['dtaudsigma_fits_expfrac.png']

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

