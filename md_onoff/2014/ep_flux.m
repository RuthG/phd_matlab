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

%%%%%%%%%%%%%%%%%%%%%Perturbed %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

% Load save file from best_plots.m which contains time mean fields
load('means_pert.mat')

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
Fphi_p(i,:) = -1.*a.*costhi(i).*uv_ed_zav_p(i,:);
Fp_p(i,:)   = a.*f(i).*costhi(i).*vt_ed_zav_p(i,:)./dthetadp(i,:);

Fphi_scaled_p(i,:) = Fphi_p(i,:).*costhi(i).*2.*pi.*a./g;
Fp_scaled_p(i,:) = Fp_p(i,:).*costhi(i).*2.*pi.*a.^2./g; 

end

fluxdiv_p_p = gradient(Fp_scaled_p,-4000);
fluxdiv_phi_p = shiftdim(gradient(Fphi_scaled_p',2.5*pi./180.),1);

fluxdiv_p = fluxdiv_p_p + fluxdiv_phi_p;


figure
[C,h] = contourf(Fphi_scaled_p(:,2:25)');

figure
v=-5e20:1e20:5e20;
[C,h] = contourf(Fp_scaled_p(:,2:25)');

figure
v=-5e16:0.2e16:5e16;
[C,h] = contourf(ylat,rC,fluxdiv_p',v);
colorbar
colormap(b2r(-5e16,5e16));
%caxis([-5e16 5e16])
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, Pa')
title('Total E-P Flux Divergence (Perturbed)')
print('-dpng','EP_flux_div_pert.png')

figure
labelling = num2str(shiftdim([0:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*Fphi_scaled_p',1.6e-20.*Fp_scaled_p','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
title('E-P Flux Perturbed')
hold on
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');

print('-dpng','EP_flux_pert.png')



%%%%%%%%%%%%%%%%%%%%%Control %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load save file from best_plots.m which contains time mean fields
load('means_ctrl.mat')

%take zonal mean eddy fluxes of momentum and heat
[uv_ed_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ed_ctrl_mean,ny,yc,ar,hc);
[vt_ed_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(vt_ed_ctrl_mean,ny,yc,ar,hc);
[theta_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(theta_ctrl_mean,ny,yc,ar,hc);


ylat_radians = ylat.*pi./180;

a = 6371.0e3;		%radius of the earth
costhi = cos(ylat_radians);
omega = 2*pi/(24*60*60);
f = 2*omega*sin(ylat_radians);
g=9.81;

rC_half = 100000:-4000:0;

%Find dthetadp
dthetadp = gradient(theta_zav_c,-4000.);

%Calculate fluxes and scaled fluxes (Edmon 1980)
for i=1:72%90
Fphi_c(i,:) = -1.*a.*costhi(i).*uv_ed_zav_c(i,:);
Fp_c(i,:)   = a.*f(i).*costhi(i).*vt_ed_zav_c(i,:)./dthetadp(i,:);

Fphi_scaled_c(i,:) = Fphi_c(i,:).*costhi(i).*2.*pi.*a./g;
Fp_scaled_c(i,:) = Fp_c(i,:).*costhi(i).*2.*pi.*a.^2./g; 

end

fluxdiv_p_c = gradient(Fp_scaled_c,-4000);
fluxdiv_phi_c = shiftdim(gradient(Fphi_scaled_c',2.5*pi./180.),1);

fluxdiv_c = fluxdiv_p_c + fluxdiv_phi_c;


figure
[C,h] = contourf(Fphi_scaled_c(:,2:25)');

figure
v=-5e20:1e20:5e20;
[C,h] = contourf(Fp_scaled_c(:,2:25)');

figure
v=-5e16:0.2e16:5e16;
[C,h] = contourf(ylat,rC,fluxdiv_c',v);
colorbar
colormap(b2r(-5e16,5e16));
%caxis([-5e16 5e16])
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, Pa')
title('Total E-P Flux Divergence (Control)')
print('-dpng','EP_flux_div_ctrl.png')

figure
labelling = num2str(shiftdim([0:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*Fphi_scaled_c',1.6e-20.*Fp_scaled_c','k','AutoScale','off');
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

print('-dpng','EP_flux_ctrl.png')

save('ep_fluxes.mat')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%Differences %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
labelling = num2str(shiftdim([0:10000:100000],1));
quiver(ylat,rC./10^3,1e-13.*(Fphi_scaled_p-Fphi_scaled_c)',8e-19.*(Fp_scaled_p-Fp_scaled_c)','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
title('E-P Flux (pert-ctrl)')
hold on
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E14 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '1E19 M3(PA)');
print('-dpng','EP_flux_diff_onoff.png')
