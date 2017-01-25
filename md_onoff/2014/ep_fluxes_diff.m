load('/disk1/MITgcm/verification/atm_gray_ruth/matlab_diags/ep_flux_ctrl.mat')

Fp_scaled_ctrl = Fp_scaled;
Fphi_scaled_ctrl = Fphi_scaled;

load('/disk1/MITgcm/verification/atm_gray_ruth/matlab_diags/ep_flux_pert.mat')

Fp_scaled_pert = Fp_scaled;
Fphi_scaled_pert = Fphi_scaled;

for i=1:36
Fp_scaled_ctrl_hzav(i,:) = (Fp_scaled_ctrl(i,:) + Fp_scaled_ctrl(73-i,:))./2;
Fphi_scaled_ctrl_hzav(i,:) = (Fphi_scaled_ctrl(i,:) + Fphi_scaled_ctrl(73-i,:))./2;
Fp_scaled_pert_hzav(i,:) = (Fp_scaled_pert(i,:) + Fp_scaled_pert(73-i,:))./2;
Fphi_scaled_pert_hzav(i,:) = (Fphi_scaled_pert(i,:) + Fphi_scaled_pert(73-i,:))./2;
end


figure
labelling = num2str(shiftdim([0:10000:100000],1));
quiver(ylat,rC./10^3,1e-13.*(Fphi_scaled_pert-Fphi_scaled_ctrl)',8e-19.*(Fp_scaled_pert-Fp_scaled_ctrl)','k','AutoScale','off');
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

figure
labelling = num2str(shiftdim([0:10000:100000],1));
quiver(ylat(1:36),rC./10^3,1e-13.*(Fphi_scaled_pert_hzav-Fphi_scaled_ctrl_hzav)',8e-19.*(Fp_scaled_pert_hzav-Fp_scaled_ctrl_hzav)','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 0])
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
print('-dpng','EP_flux_diff_offoff_hzav.png')
