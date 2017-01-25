%load in quasi-geostrophic refractive index and eliassen palm fluxes and see if these look at least roughly consistent.

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0310/qg_control.mat')
qg_control = qgref;
dqdphi_control = dqdphi;

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0310/qg_quarter.mat')
qg_quarter = qgref;
dqdphi_quarter = dqdphi;

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0310/qg_half.mat')
qg_half = qgref;
dqdphi_half = dqdphi;

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0310/qg_dry.mat')
qg_dry = qgref;
dqdphi_dry = dqdphi;

ylat_qg = ylat;

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0217/ep_fluxeswv_on_rad_off_run_5year_c.mat')
Fp_scaled_control = Fp_scaled;
Fphi_scaled_control = Fphi_scaled;

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0217/ep_fluxeswv_on_rad_off_run_halfwv.mat')
Fp_scaled_half = Fp_scaled;
Fphi_scaled_half = Fphi_scaled;

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0217/ep_fluxeswv_on_rad_off_run_quarterwv.mat')
Fp_scaled_quarter = Fp_scaled;
Fphi_scaled_quarter = Fphi_scaled;

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0217/ep_fluxeswv_off_rad_off_run_5year_c.mat')
Fp_scaled_dry = Fp_scaled;
Fphi_scaled_dry = Fphi_scaled;

%figure
%v=0:50:400;
%[C,h] = contour(ylat_qg,rC./10^3,qg_control',v,'k');
%clabel(C,h);
%set(gca,'YDir','reverse')

%figure
%labelling = num2str(shiftdim([10000:10000:100000],1));
%quiver(ylat,rC./10^3,1e-14.*Fphi_scaled_control(:,:)' ,1.6e-20.*Fp_scaled_control(:,:)' ,'k','AutoScale','off');
%hold on
%set(gca,'YDir','reverse')
%xlim([-90 90])
%ylim([rC(25)./10^3 rC(1)./10^3])
%set(gca,'YTickLabel',labelling)
%xlabel('Latitude')
%ylabel('Pressure, Pa')
%quiver(-85, 16, 10, 0,'b');
%text(-85, 20, '1E15 M3(RAD)');
%quiver(-85, 12, 0, -8,'b');
%text(-84, 12, '5E20 M3(PA)');
%hold off


 figure('Color',[1 1 1]);
v=0:50:400;
[C,h] = contourf(ylat_qg,rC./10^3,qg_control',v,'k'); 
set(gca,'Color',[1 0.95 0.87]);
colorbar
caxis([0 400]);
colormap('gray');
%clabel(C,h);
hold on
labelling = num2str(shiftdim([10000:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*Fphi_scaled_control(:,:)' ,1.6e-20.*Fp_scaled_control(:,:)' ,'Color',[0.64,0.36,0],'AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
title('QG refractive index with EP flux - Control run')
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off
 set(gcf,'InvertHardcopy','off')
print('-dpng','qg_control.png')

 figure('Color',[1 1 1]);
v=0:50:400;
[C,h] = contourf(ylat_qg,rC./10^3,qg_half',v,'k');
set(gca,'Color',[1 0.95 0.87]);
colorbar
caxis([0 400]);
colormap('gray');
%clabel(C,h);
hold on
labelling = num2str(shiftdim([10000:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*Fphi_scaled_half(:,:)' ,1.6e-20.*Fp_scaled_half(:,:)' ,'Color',[0.64,0.36,0],'AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
title('QG refractive index with EP flux - Half wv run')
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off
 set(gcf,'InvertHardcopy','off')
print('-dpng','qg_half.png')

 figure('Color',[1 1 1]);
v=0:50:400;
[C,h] = contourf(ylat_qg,rC./10^3,qg_quarter',v,'k');
set(gca,'Color',[1 0.95 0.87]);
colorbar
caxis([0 400]);
colormap('gray');
%clabel(C,h);
hold on
labelling = num2str(shiftdim([10000:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*Fphi_scaled_quarter(:,:)' ,1.6e-20.*Fp_scaled_quarter(:,:)' ,'Color',[0.64,0.36,0],'AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
title('QG refractive index with EP flux - Quarter wv run')
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off
 set(gcf,'InvertHardcopy','off')
print('-dpng','qg_quarter.png')


 figure('Color',[1 1 1]);
v=0:50:400;
[C,h] = contourf(ylat_qg,rC./10^3,qg_dry',v,'k');
set(gca,'Color',[1 0.95 0.87]);
colorbar
caxis([0 400]);
colormap('gray');
%clabel(C,h);
hold on
labelling = num2str(shiftdim([10000:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*Fphi_scaled_dry(:,:)' ,1.6e-20.*Fp_scaled_dry(:,:)' ,'Color',[0.64,0.36,0],'AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
title('QG refractive index with EP flux - Dry run')
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off
 set(gcf,'InvertHardcopy','off')
print('-dpng','qg_dry.png')
