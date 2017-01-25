%subtract EP and QG ref for tropheat3 and control, plot and print

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0324/qg_10days_control.mat')
qg_control = qgref;
dqdphi_control = dqdphi;
qg_c2_control = qgref_c2;
qg_c12_control = qgref_c12;
qg_k2_control = qgref_k2;
qg_k12_control = qgref_k12;

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0324/qg_10days_tropheat3.mat')
qg_tropheat3 = qgref;
dqdphi_tropheat3 = dqdphi;
qg_c2_tropheat3 = qgref_c2;
qg_c12_tropheat3 = qgref_c12;
qg_k2_tropheat3 = qgref_k2;
qg_k12_tropheat3 = qgref_k12;

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0324/ep_fluxdiffs_tropheat3.mat')

qg_diff = qg_tropheat3 - qg_control;
qg_c2_diff = qg_c2_tropheat3 - qg_c2_control;
qg_c12_diff = qg_c12_tropheat3 - qg_c12_control;
qg_k2_diff = qg_k2_tropheat3 - qg_k2_control;
qg_k12_diff = qg_k12_tropheat3 - qg_k12_control;

masking = zeros(90,25,6);
masking_load = zeros(90,25);
masking_c2 = zeros(90,25,6);
masking_c2_load = zeros(90,25);
masking_c12 = zeros(90,25,6);
masking_c12_load = zeros(90,25);
masking_k2 = zeros(90,25,6);
masking_k2_load = zeros(90,25);
masking_k12 = zeros(90,25,6);
masking_k12_load = zeros(90,25);

for i=1:6
masking_load(find(qg_tropheat3(:,:,i) >= 0 & qg_control(:,:,i) >=0)) = 1;
masking(:,:,i) = masking_load;

masking_c2_load(find(qg_c2_tropheat3(:,:,i) >= 0 & qg_c2_control(:,:,i) >=0)) = 1;
masking_c2(:,:,i) = masking_c2_load;
masking_c12_load(find(qg_c12_tropheat3(:,:,i) >= 0 & qg_c12_control(:,:,i) >=0)) = 1;
masking_c12(:,:,i) = masking_c12_load;
masking_k2_load(find(qg_k2_tropheat3(:,:,i) >= 0 & qg_k2_control(:,:,i) >=0)) = 1;
masking_k2(:,:,i) = masking_k2_load;
masking_k12_load(find(qg_k12_tropheat3(:,:,i) >= 0 & qg_k12_control(:,:,i) >=0)) = 1;
masking_k12(:,:,i) = masking_k12_load;

end

qg_diff_masked = qg_diff.*masking;
qg_diff_masked_c2 = qg_c2_diff.*masking_c2;
qg_diff_masked_c12 = qg_c12_diff.*masking_c12;
qg_diff_masked_k2 = qg_k2_diff.*masking_k2;
qg_diff_masked_k12 = qg_k12_diff.*masking_k12;

for i=1:6
v=-400:50:400;
contourf(ylat,rC./10^3,qg_diff_masked(:,:,i)',v)
colormap(b2r(-400,400));
colorbar
caxis([-400 400]);
hold on
labelling = num2str(shiftdim([10000:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*(Fphi_scaled_diff(:,:,i)') ,1.6e-20.*(Fp_scaled_diff(:,:,i)') ,'k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
name = ['QG refractive index with EP flux - Tropheat3 - Control Run, ' num2str(i)]
title(name)
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off
name = ['qg_diffs_tropheat3' num2str(i) '.png']
print('-dpng',name)
end


for i=1:6
v=-400:50:400;
contourf(ylat,rC./10^3,qg_diff_masked_c2(:,:,i)',v)
colormap(b2r(-400,400));
colorbar
caxis([-400 400]);
hold on
labelling = num2str(shiftdim([10000:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*(Fphi_scaled_diff(:,:,i)') ,1.6e-20.*(Fp_scaled_diff(:,:,i)') ,'k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
name = ['QG refractive index with EP flux - Tropheat3 - Control Run, ' num2str(i)]
title(name)
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off
name = ['qg_diffs_tropheat3_c2' num2str(i) '.png']
print('-dpng',name)
end


for i=1:6
v=-400:50:400;
contourf(ylat,rC./10^3,qg_diff_masked_c12(:,:,i)',v)
colormap(b2r(-400,400));
colorbar
caxis([-400 400]);
hold on
labelling = num2str(shiftdim([10000:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*(Fphi_scaled_diff(:,:,i)') ,1.6e-20.*(Fp_scaled_diff(:,:,i)') ,'k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
name = ['QG refractive index with EP flux - Tropheat3 - Control Run, ' num2str(i)]
title(name)
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off
name = ['qg_diffs_tropheat3_c12' num2str(i) '.png']
print('-dpng',name)
end


for i=1:6
v=-400:50:400;
contourf(ylat,rC./10^3,qg_diff_masked_k2(:,:,i)',v)
colormap(b2r(-400,400));
colorbar
caxis([-400 400]);
hold on
labelling = num2str(shiftdim([10000:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*(Fphi_scaled_diff(:,:,i)') ,1.6e-20.*(Fp_scaled_diff(:,:,i)') ,'k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
name = ['QG refractive index with EP flux - Tropheat3 - Control Run, ' num2str(i)]
title(name)
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off
name = ['qg_diffs_tropheat3_k2' num2str(i) '.png']
print('-dpng',name)
end


for i=1:6
v=-400:50:400;
contourf(ylat,rC./10^3,qg_diff_masked_k12(:,:,i)',v)
colormap(b2r(-400,400));
colorbar
caxis([-400 400]);
hold on
labelling = num2str(shiftdim([10000:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*(Fphi_scaled_diff(:,:,i)') ,1.6e-20.*(Fp_scaled_diff(:,:,i)') ,'k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
name = ['QG refractive index with EP flux - Tropheat3 - Control Run, ' num2str(i)]
title(name)
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off
name = ['qg_diffs_tropheat3_k12' num2str(i) '.png']
print('-dpng',name)
end
