rDir='/disk1/MITgcm/verification/atm_gray_ruth/ensemble_control/';

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
ny=90;

load('yzav_c.mat')
load('yzav_w.mat')
load('sig_y_w.mat')

ylat = -89:2:89;

masking = zeros(45,25);

masking(find(qgref_w_yzav >= 0 & qgref_c_yzav >=0 )) = 1;

Fphi_diff = Fphi_scaled_w_yzav - Fphi_scaled_c_yzav;
Fp_diff = Fp_scaled_w_yzav - Fp_scaled_c_yzav;
fluxdiv_diff = fluxdiv_w_yzav - fluxdiv_c_yzav;
qgref_diff = masking.*(qgref_w_yzav - qgref_c_yzav);






figure
v=[0,1];
[C,h]=contourf(ylat(46:90),rC./100.,qgref_w_shad_y',v);
set(h,'edgecolor','none') 
colormap(flipud(gray)) ;
caxis([0 5])
hold on
v=0:50:400;
[C,h] = contour(ylat(46:90),rC./100,qgref_diff',v,'k');
clabel(C,h);
v=-400:50:0;
[C,h] = contour(ylat(46:90),rC./100,qgref_diff',v,'k--');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, Pa')
hold off
print('-dpdf','qgref_only_wet_eqm.pdf')


figure
v=[0,1];
[C,h]=contourf(ylat(46:90),rC./100.,fluxdiv_w_shad_y',v);
set(h,'edgecolor','none') 
colormap(flipud(gray)) ;
caxis([0 5])
hold on
v=0:0.25:5;
[C,h] = contour(ylat(46:90),rC./100,fluxdiv_diff'./1e16,v,'k');
clabel(C,h);
v=-5:0.25:0;
[C,h] = contour(ylat(46:90),rC./100,fluxdiv_diff'./1e16,v,'k--');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
print('-dpdf','fluxdiv_wet_eqm.pdf')

figure
v=[0,1];
[C,h]=contourf(ylat(46:90),rC./100.,Fp_w_shad_y',v);
set(h,'edgecolor','none') 
colormap(flipud(gray)) ;
caxis([0 5])
hold on
v=0:1:20;
[C,h] = contour(ylat(46:90),rC./100,Fp_diff'./1e19,v,'k');
clabel(C,h);
v=-20:1:0;
[C,h] = contour(ylat(46:90),rC./100,Fp_diff'./1e19,v,'k--');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
print('-dpdf','Fp_wet_eqm.pdf')

figure
v=[0,1];
[C,h]=contourf(ylat(46:90),rC./100.,Fphi_w_shad_y',v);
set(h,'edgecolor','none') 
colormap(flipud(gray)) ;
caxis([0 5])
hold on
v=0:1:6;
[C,h] = contour(ylat(46:90),rC./100,Fphi_diff'./1e14,v,'k');
clabel(C,h);
v=-6:1:0;
[C,h] = contour(ylat(46:90),rC./100,Fphi_diff'./1e14,v,'k--');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
print('-dpdf','Fphi_wet_eqm.pdf')
