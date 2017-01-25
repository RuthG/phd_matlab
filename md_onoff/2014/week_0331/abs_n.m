load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0324/qg_10days_tropheat3.mat')

qg_tropheat3 = qgref;
qg_c2_tropheat3 = qgref_c2;
qg_c12_tropheat3 = qgref_c12;
qg_k2_tropheat3 = qgref_k2;
qg_k12_tropheat3 = qgref_k12;

figure
v=0:50:400;
[C,h] = contourf(ylat,rC,qg_tropheat3(:,:,6)',v,'k'); 
hold on
v=-1e20:1e20:1e20;
[C,h] = contour(ylat,rC,qg_tropheat3(:,:,6)',v,'k'); 
clabel(C,h);
colorbar
caxis([0 400]);
colormap('gray');
colormap(flipud(gray));
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, Pa')
title('QG refractive index, c=8, k=7')
print('-dpng','qg_control_c8k7.png')

figure
v=0:50:400;
[C,h] = contourf(ylat,rC,qg_c2_tropheat3(:,:,6)',v,'k'); 
hold on
v=-1e20:1e20:1e20;
[C,h] = contour(ylat,rC,qg_c2_tropheat3(:,:,6)',v,'k'); 
clabel(C,h);
colorbar
caxis([0 400]);
colormap('gray');
colormap(flipud(gray));
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, Pa')
title('QG refractive index, c=2, k=7')
print('-dpng','qg_control_c2k7.png')

figure
v=0:50:400;
[C,h] = contourf(ylat,rC,qg_c12_tropheat3(:,:,6)',v,'k'); 
hold on
v=-1e20:1e20:1e20;
[C,h] = contour(ylat,rC,qg_c12_tropheat3(:,:,6)',v,'k'); 
clabel(C,h);
colorbar
caxis([0 400]);
colormap('gray');
colormap(flipud(gray));
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, Pa')
title('QG refractive index, c=12, k=7')
print('-dpng','qg_control_c12k7.png')

figure
v=0:50:400;
[C,h] = contourf(ylat,rC,qg_k2_tropheat3(:,:,6)',v,'k'); 
hold on
v=-1e20:1e20:1e20;
[C,h] = contour(ylat,rC,qg_k2_tropheat3(:,:,6)',v,'k'); 
clabel(C,h);
colorbar
caxis([0 400]);
colormap('gray');
colormap(flipud(gray));
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, Pa')
title('QG refractive index, c=8, k=2')
print('-dpng','qg_control_c8k2.png')

figure
v=0:50:400;
[C,h] = contourf(ylat,rC,qg_k12_tropheat3(:,:,6)',v,'k'); 
hold on
v=-1e20:1e20:1e20;
[C,h] = contour(ylat,rC,qg_k12_tropheat3(:,:,6)',v,'k'); 
clabel(C,h);
colorbar
caxis([0 400]);
colormap('gray');
colormap(flipud(gray));
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, Pa')
title('QG refractive index, c=8, k=12')
print('-dpng','qg_control_c8k12.png')
