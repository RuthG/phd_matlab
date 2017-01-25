
rDir='/project/rg312/final_runs/run_radon_short/';
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

nit = 172800;

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhSens'));
sens = surf(:,:,J);
J=find(strcmp(fldList,'AtPhEvap'));
evap = surf(:,:,J);
J=find(strcmp(fldList,'AtPhInSR'));
insr = surf(:,:,J);
J=find(strcmp(fldList,'AtPhOLR '));
olr = surf(:,:,J);
J=find(strcmp(fldList,'AtPhNSSR'));
nssr = surf(:,:,J);
J=find(strcmp(fldList,'AtPhDSLR'));
dslr = surf(:,:,J);
J=find(strcmp(fldList,'AtPhUSLR'));
uslr = surf(:,:,J);
J=find(strcmp(fldList,'AtPhCnvP'));
cnvp = surf(:,:,J);
J=find(strcmp(fldList,'AtPhLscP'));
lscp = surf(:,:,J);


sens_ll = squeeze(cube2latlon(xc,yc,mean(sens,3),xi,yi));
evap_ll = 2.5e6.*squeeze(cube2latlon(xc,yc,mean(evap,3),xi,yi));
cnvp_ll = 2.5e6.*squeeze(cube2latlon(xc,yc,mean(cnvp,3),xi,yi));
lscp_ll = 2.5e6.*squeeze(cube2latlon(xc,yc,mean(lscp,3),xi,yi));
nssr_ll = squeeze(cube2latlon(xc,yc,mean(nssr,3),xi,yi));
dslr_ll = squeeze(cube2latlon(xc,yc,mean(dslr,3),xi,yi));
uslr_ll = squeeze(cube2latlon(xc,yc,mean(uslr,3),xi,yi));
olr_ll = squeeze(cube2latlon(xc,yc,mean(olr,3),xi,yi));
insr_ll = squeeze(cube2latlon(xc,yc,mean(insr,3),xi,yi));

sens_mean = sum(sum(mean(sens,3).*ar))/sum(sum(ar));
evap_mean = 2.5e6.*sum(sum(mean(evap,3).*ar))/sum(sum(ar));
lscp_mean = 2.5e6.*sum(sum(mean(lscp,3).*ar))/sum(sum(ar));
cnvp_mean = 2.5e6.*sum(sum(mean(cnvp,3).*ar))/sum(sum(ar));
nssr_mean = sum(sum(mean(nssr,3).*ar))/sum(sum(ar));
dslr_mean = sum(sum(mean(dslr,3).*ar))/sum(sum(ar));
uslr_mean = sum(sum(mean(uslr,3).*ar))/sum(sum(ar));
olr_mean = sum(sum(mean(olr,3).*ar))/sum(sum(ar));
insr_mean = sum(sum(mean(insr,3).*ar))/sum(sum(ar));

%surface fluxes +ve direction downward
surf_budg_ll = nssr_ll + dslr_ll - uslr_ll - sens_ll - evap_ll;
surf_budg_zav = squeeze(mean(surf_budg_ll,1));

%toa fluxes +ve direction downward
toa_budg_ll = insr_ll - olr_ll - A*nssr_ll/(1-A);
toa_budg_zav = squeeze(mean(toa_budg_ll,1));

%latent fluxes
lheat_ll = evap_ll - cnvp_ll - lscp_ll;
lheat_zav = squeeze(mean(lheat_ll,1));
evap_zav = squeeze(mean(evap_ll,1));
rain_zav = squeeze(mean(cnvp_ll+lscp_ll,1));

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
lheat_cos(i) = lheat_zav(i).*cos(yi(i).*pi./180).*2.*pi.*a^2 .* pi./90;
end


figure
plot(yi,surf_budg_zav)
hold on
plot(yi,toa_budg_zav,'r')
xlabel('Latitude')
ylabel('Heat flux, W/m^{2}')
legend('Surface','TOA')
print('-dpng','net_surf_and_toa_ro.png')

figure
plot(yi,toa_budg_zav - surf_budg_zav)
xlabel('Latitude')
ylabel('Heat flux, W/m^{2}')
print('-dpng','toa_minus_surf_ro.png')

figure
plot(yi(2:89),cumsum(atmos_energy_cos(2:89))./10^15)
xlabel('Latitude')
ylabel('Heat transport, PW')
print('-dpng','heat_trans_ro.png')

figure
plot(yi,evap_zav)
hold on
plot(yi,rain_zav)
xlabel('Latitude')
ylabel('Heat flux, W/m^{2}')
legend('Evap','Precip')
print('-dpng','evap_precip_ro.png')

figure
plot(yi(2:89),cumsum(lheat_cos(2:89))./10^15)
xlabel('Latitude')
ylabel('Latent heat transport, PW')
print('-dpng','latent_trans_ro.png')


figure
plot(yi(2:89),cumsum(atmos_energy_cos(2:89))./10^15,'k')
hold on
plot(yi(2:89),cumsum(lheat_cos(2:89))./10^15,'b')
plot(yi(2:89),cumsum(atmos_energy_cos(2:89))./10^15 - cumsum(lheat_cos(2:89))./10^15,'r')
xlabel('Latitude')
ylabel('Heat transport, PW')
legend('Total','Latent','DSE')
print('-dpng','heat_trans_parts_ro.png')
