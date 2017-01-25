yi = -89:2:89;

yy=yi*90/60*pi/180;
sinyy=sin(yy);
sst=27*(1-sinyy.*sinyy);
sst(find(abs(yi)>=60))=0;
sst=sst+273.15;

yy=yi*90/70*pi/180;
sinyy=sin(yy);
sst_70=27*(1-sinyy.*sinyy);
sst_70(find(abs(yi)>=70))=0;
sst_70=sst_70+273.15;

figure
plot(yi,sst)
hold on
plot(yi,sst_70,'r')
xlabel('Latitude')
ylabel('SST, K')
print('-dpng','ssts.png')