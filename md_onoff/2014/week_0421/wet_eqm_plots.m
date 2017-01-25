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

psi_diff = psi_w_yzav - psi_c_yzav;
uE_diff = uE_w_yzav - uE_c_yzav;
theta_diff = theta_w_yzav - theta_c_yzav;
htrt_diff = htrt_w_yzav - htrt_c_yzav;
Fphi_diff = Fphi_scaled_w_yzav - Fphi_scaled_c_yzav;
Fp_diff = Fp_scaled_w_yzav - Fp_scaled_c_yzav;
fluxdiv_diff = fluxdiv_w_yzav - fluxdiv_c_yzav;
eke_diff = eke_w_yzav - eke_c_yzav;
qgref_diff = masking.*(qgref_w_yzav - qgref_c_yzav);
vt_ed_diff = vt_ed_w_yzav - vt_ed_c_yzav;

figure
v=[0,1];
[C,h]=contourf(ylat(46:90),rC./100.,vt_ed_w_shad_y',v);
set(h,'edgecolor','none') 
colormap(flipud(gray)) ;
caxis([0 5])
hold on
v=-10:1:0;
[C,h]=contour(ylat(46:90),rC./100.,vt_ed_diff',v,'k--');
clabel(C,h);
hold on
v=0:1:10;
[C,h]=contour(ylat(46:90),rC./100.,vt_ed_diff',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
print('-dpdf','vt_wet_eqm.pdf')
return




figure
v=[0,1];
[C,h]=contourf(ylat(46:90),rC./100.,uE_w_shad_y',v);
set(h,'edgecolor','none') 
colormap(flipud(gray)) ;
caxis([0 5])
hold on
v=-10:2:0;
[C,h]=contour(ylat(46:90),rC./100.,uE_diff',v,'k--');
clabel(C,h);
hold on
v=0:2:10;
[C,h]=contour(ylat(46:90),rC./100.,uE_diff',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
print('-dpdf','u_wet_eqm.pdf')

figure
v=[0,1];
[C,h]=contourf(ylat(46:90),rC./100.,psi_w_shad_y',v);
set(h,'edgecolor','none') 
colormap(flipud(gray)) ;
caxis([0 5])
hold on
v=-100:25:0;
[C,h]=contour(ylat(46:90),rC./100.,psi_diff'./1e9,v,'k--');
clabel(C,h);
hold on
v=0:25:200;
[C,h]=contour(ylat(46:90),rC./100.,psi_diff'./1e9,v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
print('-dpdf','psi_wet_eqm.pdf')

figure
v=[0,1];
[C,h]=contourf(ylat(46:90),rC./100.,theta_w_shad_y',v);
set(h,'edgecolor','none') 
colormap(flipud(gray)) ;
caxis([0 5])
hold on
v=-10:2:0;
[C,h]=contour(ylat(46:90),rC./100.,theta_diff',v,'k--');
clabel(C,h);
hold on
v=0:2:20;
[C,h]=contour(ylat(46:90),rC./100.,theta_diff',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
print('-dpdf','theta_wet_eqm.pdf')

figure
v=[0,1];
[C,h]=contourf(ylat(46:90),rC./100.,htrt_w_shad_y',v);
set(h,'edgecolor','none') 
colormap(flipud(gray)) ;
caxis([0 5])
hold on
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,htrt_diff',v,'k--');
clabel(C,h);
hold on
v=0:1:20;
[C,h]=contour(ylat(46:90),rC./100.,htrt_diff',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
print('-dpdf','htrt_wet_eqm.pdf')


%%% test regridding
for i=1:23
for j=1:13
Fphi_diff_red(i,j,:) = Fphi_diff(i*2 -1, j*2 -1,:);
Fp_diff_red(i,j,:) = Fp_diff(i*2 -1, j*2 -1,:);
xspaces(i) = ylat(i*2+44 );
yspaces(j) = rC(j*2-1 );
end
end


figure
v=-400:50:400;
contourf(ylat(46:90),rC./10^3,qgref_diff',v)
colormap(b2r(-400,400));
colorbar
caxis([-400 400]);
hold on
labelling = num2str(shiftdim([200:200:1000],1));
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_diff_red',1.6e-20.*Fp_diff_red','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
quiver(68, 21, 10, 0,'b');
text(68, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(68, 15, 0, -8,'b');
text(69, 12, '\fontsize{8}5E20 M3(PA)');
hold off
print('-dpdf','qgref_wet_eqm.pdf')

figure
v=[0,1];
[C,h]=contourf(ylat(46:90),rC./100.,eke_w_shad_y',v);
set(h,'edgecolor','none') 
colormap(flipud(gray)) ;
caxis([0 5])
hold on
v=-100:10:0;
[C,h]=contour(ylat(46:90),rC./100.,eke_diff',v,'k--');
clabel(C,h);
hold on
v=0:10:125;
[C,h]=contour(ylat(46:90),rC./100.,eke_diff',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
print('-dpdf','eke_wet_eqm.pdf')

figure
v=0:0.25:5;
[C,h] = contour(ylat(46:90),rC./10^3,fluxdiv_diff'./1e16,v,'k');
clabel(C,h);
hold on
v=-5:0.25:0;
[C,h] = contour(ylat(46:90),rC./10^3,fluxdiv_diff'./1e16,v,'k--');
clabel(C,h);
labelling = num2str(shiftdim([200:200:1000],1));
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_diff_red',1.6e-20.*Fp_diff_red','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, hPa')
quiver(68, 21, 10, 0,'b');
text(68, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(68, 15, 0, -8,'b');
text(69, 12, '\fontsize{8}5E20 M3(PA)');
hold off
print('-dpdf','epflux_wet_eqm.pdf')
