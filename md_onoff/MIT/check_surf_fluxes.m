%load in surface flux SBDART predictions, compare with predictions of other schemes

%SBDART LW fluxes
load('~/md_onoff/radiation_chapter_beginning/lw_sbdart.mat')

%3-band fluxes
load('/project/rg312/mat_files/radiation_chapter/heating_myscheme.mat')

yi = -89:2:89;

%sum up SBDART flux components
fxdn_lw_tot = fxdn_lw_l + fxdn_lw_u + fxdn_win;
fxup_lw_tot = fxup_lw_l + fxup_lw_u + fxup_win;

%plot surface lw fluxes (direction downwards)
load('/project/rg312/mat_files/radiation_chapter/tdt_lw_frierson.mat')
figure
plot(yi(2:89),-1.*net(2:89,26))
hold on
load('/project/rg312/mat_files/radiation_chapter/tdt_lw_byrne.mat')
plot(yi(2:89),-1.*net(2:89,26),'g')
plot(yi(2:89),down(2:89,26)-up(2:89,26),'k')
plot(yi(2:89),fxdn_lw_tot(2:89,26) - fxup_lw_tot(2:89,26),'r')
xlabel('Latitude')
ylabel('Radiative flux, W/m^{2}')
legend('Frierson 06','B+OG 13','3-band','SBDART')
print('-dpng','surface_lw_fluxes.png')

%plot TOA lw fluxes (direction upward)
load('/project/rg312/mat_files/radiation_chapter/tdt_lw_frierson.mat')
figure
plot(yi(2:89),net(2:89,1))
hold on
load('/project/rg312/mat_files/radiation_chapter/tdt_lw_byrne.mat')
plot(yi(2:89),net(2:89,1),'g')
plot(yi(2:89),-down(2:89,1)+up(2:89,1),'k')
plot(yi(2:89), - fxdn_lw_tot(2:89,1) + fxup_lw_tot(2:89,1),'r')
xlabel('Latitude')
ylabel('Radiative flux, W/m^{2}')
legend('Frierson 06','B+OG 13','3-band','SBDART')
print('-dpng','toa_lw_fluxes.png')




%Shortwave

load('~/md_onoff/radiation_chapter_beginning/sw_sbdart.mat')

%change insolation
for i=1:25
trans(:,i) = fxdn_sw(:,i+1)./fxdn_sw(:,1);
end
lat = (-89:2:89).*pi./180;
solar_constant 	= 1360.0;
ss = sin(lat);
p2 = (1. - 3.*ss.^2)./4;
del_sol = 1.4;
solar = repmat(0.25.*solar_constant.*(1.0 + del_sol.*p2'),[1,25]);
mitflux(:,1) = solar(:,1);
mitflux(:,2:26) = solar.*trans;

%plot net sw surface fluxes (direction downward)
figure
plot(yi(2:89),solar_down(2:89,1).*(1-0.06))
hold on
plot(yi(2:89),solar_down(2:89,26).*(1-0.06),'k')
plot(yi(2:89),mitflux(2:89,26).*(1-0.06),'r')
xlabel('Latitude')
ylabel('Radiative flux, W/m^{2}')
legend('Frierson 06,B+OG 13','3-band','SBDART')
print('-dpng','surf_sw_fluxes.png')


