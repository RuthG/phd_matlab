%load up qg and ep fluxes for full and half wv runs and take differences

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0310/qg_control.mat')
qg_control = qgref;
dqdphi_control = dqdphi;

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0310/qg_half.mat')
qg_half = qgref;
dqdphi_half = dqdphi;

ylat_qg = ylat;

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0217/ep_fluxeswv_on_rad_off_run_5year_c.mat')
Fp_scaled_control = Fp_scaled;
Fphi_scaled_control = Fphi_scaled;

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0217/ep_fluxeswv_on_rad_off_run_halfwv.mat')
Fp_scaled_half = Fp_scaled;
Fphi_scaled_half = Fphi_scaled;

masking = zeros(90,25);

masking(find(qg_half >= 0 & qg_control >=0)) = 1;

qg_control_masked = qg_control.*masking;
qg_half_masked = qg_half.*masking;

v=-200:20:200;
contourf(ylat_qg,rC./10^3,qg_control_masked' - qg_half_masked',v)
colormap(b2r(-200,200));
colorbar
caxis([-200 200]);
hold on
labelling = num2str(shiftdim([10000:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*(Fphi_scaled_control'-Fphi_scaled_half') ,1.6e-20.*(Fp_scaled_control'-Fp_scaled_half') ,'k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
title('QG refractive index with EP flux - Control run - Half wv run')
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off
print('-dpng','qg_diffs.png')
