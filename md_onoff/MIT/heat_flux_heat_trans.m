
rDir='/project/rg312/final_runs/run_100_final/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
yi=-89:2:89;
xi = -179:2:179;
A=0.06;
L = 2.500e6;
cp = 287.04./(2./7.);
g=9.8;
a=6371.0e3;

oht = sin(yi.*pi./180).*cos(yi.*pi./180).^4;
oht_mag = 2e15./max(oht);
oht = oht_mag.*oht;

q_flux = oht_mag./(2.*pi.*a.^2) .* cos(yi.*pi./180).^3 .*(cos(yi.*pi./180).^2 - 5.*sin(yi.*pi./180).^2);

load('/project/rg312/mat_files/snapshot_data_final/run_100/toa_surf_heat_100_1.mat')

sens_ll = squeeze(cube2latlon(xc,yc,mean(sens_100,3),xi,yi));
evap_ll = 2.5e6.*squeeze(cube2latlon(xc,yc,mean(evap_100,3),xi,yi));
nssr_ll = squeeze(cube2latlon(xc,yc,mean(nssr_100,3),xi,yi));
dslr_ll = squeeze(cube2latlon(xc,yc,mean(dslr_100,3),xi,yi));
uslr_ll = squeeze(cube2latlon(xc,yc,mean(uslr_100,3),xi,yi));
olr_ll = squeeze(cube2latlon(xc,yc,mean(olr_100,3),xi,yi));
insr_ll = squeeze(cube2latlon(xc,yc,mean(insr_100,3),xi,yi));

sens_mean = sum(sum(mean(sens_100,3).*ar))/sum(sum(ar));
evap_mean = 2.5e6.*sum(sum(mean(evap_100,3).*ar))/sum(sum(ar));
nssr_mean = sum(sum(mean(nssr_100,3).*ar))/sum(sum(ar));
dslr_mean = sum(sum(mean(dslr_100,3).*ar))/sum(sum(ar));
uslr_mean = sum(sum(mean(uslr_100,3).*ar))/sum(sum(ar));
olr_mean = sum(sum(mean(olr_100,3).*ar))/sum(sum(ar));
insr_mean = sum(sum(mean(insr_100,3).*ar))/sum(sum(ar));

%surface fluxes +ve direction downward
surf_budg_ll = nssr_ll + dslr_ll - uslr_ll - sens_ll - evap_ll;
surf_budg_zav = squeeze(mean(surf_budg_ll,1));

%toa fluxes +ve direction downward
toa_budg_ll = insr_ll - olr_ll - A*nssr_ll/(1-A);
toa_budg_zav = squeeze(mean(toa_budg_ll,1));

surface_budget = nssr_mean + dslr_mean - uslr_mean - sens_mean - evap_mean

toa_budget = insr_mean - olr_mean - A*nssr_mean/(1-A)

imbalance = toa_budget - surface_budget

unaccounted_sw_energy=insr_mean - nssr_mean/(1-A);
unaccounted_lw_energy=olr_mean-(uslr_mean-dslr_mean)-sens_mean-evap_mean;

atmos_energy = toa_budg_zav - surf_budg_zav;

for i=1:90
toa_budg_ll_cos(i) = toa_budg_zav(i).*cos(yi(i).*pi./180).*2.*pi.*a^2 .* pi./90;
surf_budg_ll_cos(i) = surf_budg_zav(i).*cos(yi(i).*pi./180).*2.*pi.*a^2 .* pi./90;
atmos_energy_cos(i) = atmos_energy(i).*cos(yi(i).*pi./180).*2.*pi.*a^2 .* pi./90;
end


figure
plot(yi,surf_budg_zav)
hold on
plot(yi,toa_budg_zav,'r')
xlabel('Latitude')
ylabel('Heat flux, W/m^{2}')
legend('Surface','TOA')
print('-dpng','net_surf_and_toa.png')

figure
plot(yi,toa_budg_zav - surf_budg_zav)
xlabel('Latitude')
ylabel('Heat flux, W/m^{2}')
print('-dpng','toa_minus_surf.png')

figure
plot(yi(2:89),cumsum(atmos_energy_cos(2:89))./10^15)
xlabel('Latitude')
ylabel('Heat transport, PW')
print('-dpng','heat_trans_fluxes.png')
