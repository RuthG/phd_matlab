%Read in full (ie all wavelengths all levels) output data for sbdart


lamdas = 4.005:0.005:100.000;
nlamdas = max(size(lamdas));

output=dlmread('check_window/OUTPUT_lw_eqfull');

alt = zeros(25,1);
fdird = zeros(25,nlamdas);
fdifd = zeros(25,nlamdas);
flxdn = zeros(25,nlamdas);
flxup = zeros(25,nlamdas);

alt(1:10) = output(2,:);
alt(11:20) = output(3,:);
alt(21:25) = output(4,1:5);

for i=1:nlamdas
fdird(1:10,i) = output(5+16*(i-1),:);
fdird(11:20,i) = output(6+16*(i-1),:);
fdird(21:25,i) = output(7+16*(i-1),1:5);

fdifd(1:10,i) = output(8+16*(i-1),:);
fdifd(11:20,i) = output(9+16*(i-1),:);
fdifd(21:25,i) = output(10+16*(i-1),1:5);

flxdn(1:10,i) = output(11+16*(i-1),:);
flxdn(11:20,i) = output(12+16*(i-1),:);
flxdn(21:25,i) = output(13+16*(i-1),1:5);

flxup(1:10,i) = output(14+16*(i-1),:);
flxup(11:20,i) = output(15+16*(i-1),:);
flxup(21:25,i) = output(16+16*(i-1),1:5);

end

clear output
return
for i=1: nlamdas
transmission(:,i)=flxdn(:,i)/flxdn(1,i);
end
contourf(lamdas(1:751),p,transmission(:,1:751))

%for i=2:25
%plot(lamdas(1,1:751),flxdn(1,1:751))
%hold on
%plot(lamdas(1,1:751),flxdn(i,1:751),'g')
%xlabel('Wavelength (microns)')
%ylabel('Watts per square metre per 0.005 microns')
%name=['sw_spectrum_' num2str(i) '.png']
%print('-dpng',name)
%hold off
%end


plot(lamdas(1,1:751),fdird(1,1:751))
hold on
plot(lamdas(1,1:751),fdird(25,1:751),'g')
xlabel('Wavelength (microns)')
ylabel('Watts per square metre per 0.005 microns')
name=['sw_direct_spectrum.png']
print('-dpng',name)
hold off

plot(lamdas(1,1:751),fdifd(1,1:751))
hold on
plot(lamdas(1,1:751),fdifd(25,1:751),'g')
xlabel('Wavelength (microns)')
ylabel('Watts per square metre per 0.005 microns')
name=['sw_diffuse_spectrum.png']
print('-dpng',name)
hold off

load('prof_doherty.mat')
%calculate dp, dz, and halfway values for pressure and height levels
p=doherty(2:26,2);
z=doherty(2:26,1);
for i=1:24
dp(i,1)=p(i+1)-p(i);
dz(i,1)=z(i+1)-z(i);
z_dz(i,1)=(z(i+1)+z(i))/2.;
p_dp(i,1)=(p(i+1)+p(i))/2.;
end

flux_diff=flxdn(1,1:751)-flxdn(25,1:751);
lower_1=find(flux_diff==(min(flux_diff(191:231))))
lamdas(lower_1)

lower_2=find(flux_diff==(min(flux_diff(231:311))))
lamdas(lower_2)

lower_3=find(flux_diff==(min(flux_diff(311:451))))
lamdas(lower_3)

upper_3=find(flux_diff==(min(flux_diff(451:751))))
lamdas(upper_3)

lower_0=find(flux_diff==(min(flux_diff(131:180))))
lamdas(lower_0)

fullbeam=sum(flxdn(1,1:751));
band_1=sum(flxdn(:,lower_1:lower_2),2);
frac_1=band_1(1)/fullbeam
band_2=sum(flxdn(:,lower_2:lower_3),2);
frac_2=band_2(1)/fullbeam
band_3=sum(flxdn(:,lower_3:upper_3),2);
frac_3=band_3(1)/fullbeam
lower_band=sum(flxdn(1,1:lower_1));
frac_lower=lower_band/fullbeam

band_0=sum(flxdn(:,lower_0:lower_1),2);

plot(band_1,p);
hold on
set(gca,'YDir','reverse')
plot(band_2,p);
plot(band_3,p);
hold off

plot(band_1/band_1(1),p);
hold on
set(gca,'YDir','reverse')
plot(band_2/band_2(1),p,'g');
plot(band_3/band_3(1),p,'r');
b=sum(flxdn(:,1:190),2);
plot(b/b(1),p,'k');
xlabel('Transmission')
ylabel('Pressure, mb')
name=['trans_bands.png']
print('-dpng',name)
hold off

tau_b1(:,1)=log(band_1(1)./band_1);
tau_b2(:,1)=log(band_2(1)./band_2);
tau_b3(:,1)=log(band_3(1)./band_3);
tau_tot(:,1)=log(b(1)./b);
tau_b0(:,1)=log(band_0(1)./band_0);

for k=1:24
dtau_b1(k)=tau_b1(k+1)-tau_b1(k);
dtau_b2(k)=tau_b2(k+1)-tau_b2(k);
dtau_b3(k)=tau_b3(k+1)-tau_b3(k);
dtau_tot(k)=tau_tot(k+1)-tau_tot(k);
dtau_b0(k)=tau_b0(k+1)-tau_b0(k);
dtaudp_b0(k) = dtau_b0(k)./dp(k);

dtaudz_b1(k) = dtau_b1(k)./dz(k);
dtaudp_b1(k) = dtau_b1(k)./dp(k);
dtaudz_b2(k) = dtau_b2(k)./dz(k);
dtaudp_b2(k) = dtau_b2(k)./dp(k);
dtaudz_b3(k) = dtau_b3(k)./dz(k);
dtaudp_b3(k) = dtau_b3(k)./dp(k);
dtaudz_tot(k) = dtau_tot(k)./dz(k);
dtaudp_tot(k) = dtau_tot(k)./dp(k);
end

plot(tau_b1,p);
hold on
set(gca,'YDir','reverse')
plot(tau_b2,p,'g');
plot(tau_b3,p,'r');
plot(tau_tot,p,'k');
xlabel('Optical depth')
ylabel('Pressure, mb')
name=['tau_bands.png']
print('-dpng',name)
hold off

plot(dtaudp_b1,p_dp);
hold on
set(gca,'YDir','reverse')
plot(dtaudp_b2,p_dp,'g');
plot(dtaudp_b3,p_dp,'r');
plot(dtaudp_tot,p_dp,'k');
xlabel('dtaudp')
ylabel('Pressure, mb')
name=['dtaudp_bands.png']
print('-dpng',name)
hold off

return


tausbdart=zeros(25,nlamdas);
for i=1:490
temp = flxdn(:,i);
tausbdart(:,i)=log(temp(1)./temp(:));
end
clear temp

for k=1:24
dtau(k,:)=tausbdart(k+1,:)-tausbdart(k,:);
dtaudz(k,:) = dtau(k,:)./dz(k);
dtaudp(k,:) = dtau(k,:)./dp(k);
end

dtaudp(find(dtaudp==Inf))=0.;

clear i
for i=1:20
plot(dtaudp(:,i*10),p_dp,'k')
set(gca,'YDir','reverse')
hold on
end
for i=20:27
plot(dtaudp(:,i*10),p_dp)
set(gca,'YDir','reverse')
hold on
end
for i=28:38
plot(dtaudp(:,i*10),p_dp,'g')
set(gca,'YDir','reverse')
hold on
end
for i=39:75
plot(dtaudp(:,i*10),p_dp,'r')
set(gca,'YDir','reverse')
hold on
end
xlabel('dtaudp')
ylabel('Pressure, mb')
name=['dtaudp_indiv.png']
print('-dpng',name)

hold off

for i=1:20
plot(transmission(:,i*10),p,'k')
set(gca,'YDir','reverse')
hold on
end
for i=20:27
plot(transmission(:,i*10),p)
set(gca,'YDir','reverse')
hold on
end
for i=28:38
plot(transmission(:,i*10),p,'g')
set(gca,'YDir','reverse')
hold on
end
for i=39:75
plot(transmission(:,i*10),p,'r')
set(gca,'YDir','reverse')
hold on
end
xlabel('Transmission')
ylabel('Pressure, mb')
name=['transmission_indiv.png']
print('-dpng',name)


for i=1:75
plot(doherty(2:26,4)*i,p)
set(gca,'YDir','reverse')
hold on
end

[C,h]=contourf(lamdas(1:751),doherty(2:26,2),tausbdart(:,1:751));
set(h,'edgecolor','none')
colorbar
set(gca,'YDir','reverse')
%set(gca,'XScale','log')
xlabel('Wavelength (microns)')
ylabel('Pressure (mb)')
name=['sw_tau.png']
print('-dpng',name)
hold off

