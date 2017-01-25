yc=-89:2:89;

yy=yc*90/60*pi/180;
sinyy=sin(yy);
sst=27*(1-sinyy.*sinyy);
sst(find(abs(yc)>=60))=0;
sst=sst+273.15;

yy=yc*90/55*pi/180;
sinyy=sin(yy);
sst2=27*(1-sinyy.*sinyy);
sst2(find(abs(yc)>=55))=0;
sst2=sst2+273.15;

yy=yc*90/65*pi/180;
sinyy=sin(yy);
sst3=27*(1-sinyy.*sinyy);
sst3(find(abs(yc)>=65))=0;
sst3=sst3+273.15;

%1KEQ anomaly
yy=yc*90/10*pi/180;
cosyy=cos(yy);
ssta= -0.75*cosyy.*cosyy;
ssta(find(abs(yc)>=10))=0;

yy=yc*90/10*pi/180;
cosyy=cos(yy);
ssta2= 0.75*cosyy.*cosyy;
ssta2(find(abs(yc)>=10))=0;

sstgrad = gradient(sst,2.*pi./180);
sstgrad2 = gradient(sst2,2.*pi./180);
sstgrad3 = gradient(sst3,2.*pi./180);

plot(yc,sst)
hold on
plot(yc,sst2,'r')
plot(yc,sst3,'g')
print('-dpng','midlat_ssts.png')

figure
plot(yc,sstgrad)
hold on
plot(yc,sstgrad2,'r')
plot(yc,sstgrad3,'g')
print('-dpng','midlat_ssts_grad.png')

figure
plot(yc,sst)
hold on
plot(yc,sst+ssta,'r')
plot(yc,sst+ssta2,'g')
print('-dpng','tropical_ssts.png')
