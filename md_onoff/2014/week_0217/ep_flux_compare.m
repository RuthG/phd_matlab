%ep_flux_compare
%load up ep fluxes and subtract. plot

load('ep_fluxeswv_on_rad_off_run_quarterwv.mat')

Fphi_scaled_q = Fphi_scaled;
Fp_scaled_q = Fp_scaled;
fluxdiv_q = fluxdiv;
uE_zav_q = uE_zav;

load('ep_fluxeswv_on_rad_off_run_halfwv.mat')

Fphi_scaled_h = Fphi_scaled;
Fp_scaled_h = Fp_scaled;
fluxdiv_h = fluxdiv;
uE_zav_h = uE_zav;

load('ep_fluxeswv_on_rad_off_run_5year_c.mat')

Fphi_scaled_f = Fphi_scaled;
Fp_scaled_f = Fp_scaled;
fluxdiv_f = fluxdiv;
uE_zav_f = uE_zav;

figure
v=-5e16:0.2e16:5e16;
[C,h] = contourf(ylat,rC,fluxdiv_f' - fluxdiv_h',v);
colorbar
colormap(b2r(-5e16,5e16));
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, Pa')
name = ['ep_flux_div_diff.png'];
print('-dpng',name)

figure
labelling = num2str(shiftdim([0:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*(Fphi_scaled_f'-Fphi_scaled_h'),1.6e-20.*(Fp_scaled_f'-Fp_scaled_h'),'k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
hold on
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
name = ['ep_flux_diff.png'];
print('-dpng',name)

figure
v=-7:1:15;
[C,h] = contourf(ylat,rC./10^3,uE_zav_f' - uE_zav_h',v);
colormap(b2r(-7,15));
colorbar
set(gca,'YDir','reverse')
labelling = num2str(shiftdim([0:10000:100000],1));
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
hold on
quiver(ylat,rC./10^3,1e-14.*(Fphi_scaled_f'-Fphi_scaled_h'),1.6e-20.*(Fp_scaled_f'-Fp_scaled_h'),'k','AutoScale','off');
xlabel('Latitude')
ylabel('Pressure, Pa')
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off
name = ['ep_flux_u_diff.png'];
print('-dpng',name)



%%%%%Repeat for h and q

figure
v=-5e16:0.2e16:5e16;
[C,h] = contourf(ylat,rC,fluxdiv_h' - fluxdiv_q',v);
colorbar
colormap(b2r(-5e16,5e16));
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, Pa')
name = ['ep_flux_div_diffhq.png'];
print('-dpng',name)

figure
labelling = num2str(shiftdim([0:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*(Fphi_scaled_h'-Fphi_scaled_q'),1.6e-20.*(Fp_scaled_h'-Fp_scaled_q'),'k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
hold on
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
name = ['ep_flux_diffhq.png'];
print('-dpng',name)

figure
v=-7:1:15;
[C,h] = contourf(ylat,rC./10^3,uE_zav_h' - uE_zav_q',v);
colormap(b2r(-7,15));
colorbar
set(gca,'YDir','reverse')
labelling = num2str(shiftdim([0:10000:100000],1));
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
hold on
quiver(ylat,rC./10^3,1e-14.*(Fphi_scaled_h'-Fphi_scaled_q'),1.6e-20.*(Fp_scaled_h'-Fp_scaled_q'),'k','AutoScale','off');
xlabel('Latitude')
ylabel('Pressure, Pa')
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off
name = ['ep_flux_u_diffhq.png'];
print('-dpng',name)



