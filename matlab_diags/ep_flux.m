%ep_flux.m
%Calculate ep_fluxes from v'Th' and u'v'

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_p/';
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
ny=72;

% Load save file from best_plots.m which contains time mean fields
load('means_pert_onoff.mat')

%take zonal mean eddy fluxes of momentum and heat
[uv_ed_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ed_pert_mean,ny,yc,ar,hc);
[vt_ed_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(vt_ed_pert_mean,ny,yc,ar,hc);
[theta_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(theta_pert_mean,ny,yc,ar,hc);


ylat_radians = ylat.*pi./180;

a = 6371.0e3;		%radius of the earth
costhi = cos(ylat_radians);
omega = 2*pi/(24*60*60);
f = 2*omega*sin(ylat_radians);
g=9.81;

rC_half = 100000:-4000:0;

%Find dthetadp
dthetadp = gradient(theta_zav_p,-4000.);

%Calculate fluxes and scaled fluxes (Edmon 1980)
for i=1:72%90
Fphi(i,:) = -1.*a.*costhi(i).*uv_ed_zav_p(i,:);
Fp(i,:)   = a.*f(i).*costhi(i).*vt_ed_zav_p(i,:)./dthetadp(i,:);

Fphi_scaled(i,:) = Fphi(i,:).*costhi(i).*2.*pi.*a./g;
Fp_scaled(i,:) = Fp(i,:).*costhi(i).*2.*pi.*a.^2./g; 

end

fluxdiv_p = gradient(Fp_scaled,-4000);
fluxdiv_phi = shiftdim(gradient(Fphi_scaled',2.5*pi./180.),1);

fluxdiv = fluxdiv_p + fluxdiv_phi;


figure
[C,h] = contourf(Fphi_scaled(:,2:25)');

figure
v=-5e20:1e20:5e20;
[C,h] = contourf(Fp_scaled(:,2:25)');

figure
v=-5e16:0.2e16:5e16;
[C,h] = contourf(ylat,rC,fluxdiv',v);
colorbar
colormap(b2r(-5e16,5e16));
%caxis([-5e16 5e16])
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, Pa')
title('Total E-P Flux Divergence')
print('-dpng','EP_flux_div_pert.png')

figure
labelling = num2str(shiftdim([0:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*Fphi_scaled',1.6e-20.*Fp_scaled','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
title('E-P Flux Control')
hold on
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');

print('-dpng','EP_flux_pert.png')

save('ep_flux_pert.mat')
