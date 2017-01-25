
%load T, u, v data
%take dTdx dTdy
%calculate time means and eddies, and dT'/dt 

% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_doshallower10/';
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
yi = -89:2:89;


radius = 6371.0e3;
omega = 2.*pi./24./60./60;
f = 2.*omega.*sin(yi.*pi./180);
load('/project/rg312/mat_files/vt_lats.mat')

load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/theta_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/uE_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/w_snapshots.mat')


%transfer t to ll
xi=-179:2:180;yi=-89:2:90;

theta_100_ll = cube2latlon(xc,yc,theta_100(:,:,:,360),xi,yi);
clear('theta_000','theta_010','theta_025','theta_050','theta_075','theta_100')

w_100_ll = cube2latlon(xc,yc,w_100(:,:,:,360),xi,yi);
w_100_ll_tav = cube2latlon(xc,yc,mean(w_100,4),xi,yi);
w_ed_100_ll = cube2latlon(xc,yc,w_100(:,:,:,360),xi,yi) - w_100_ll_tav;
clear('w_000','w_010','w_025','w_050','w_075','w_100')

t_100_ll = cube2latlon(xc,yc,t_100(:,:,:,360),xi,yi);
t_100_ll_tav = cube2latlon(xc,yc,mean(t_100,4),xi,yi);
t_ed_100_ll = cube2latlon(xc,yc,t_100(:,:,:,360),xi,yi) - t_100_ll_tav;
t_100_ll_m = cube2latlon(xc,yc,t_100(:,:,:,359),xi,yi);
t_100_ll_p = cube2latlon(xc,yc,t_100(:,:,:,361),xi,yi);
clear('t_000','t_010','t_025','t_050','t_075','t_100')

uE_100_ll = cube2latlon(xc,yc,uE_100(:,:,:,360),xi,yi);
uE_100_ll_tav = cube2latlon(xc,yc,mean(uE_100,4),xi,yi);
uE_ed_100_ll = cube2latlon(xc,yc,uE_100(:,:,:,360),xi,yi) - uE_100_ll_tav;
clear('uE_000','uE_010','uE_025','uE_050','uE_075','uE_100')

vN_100_ll = cube2latlon(xc,yc,vN_100(:,:,:,360),xi,yi);
vN_100_ll_tav = cube2latlon(xc,yc,mean(vN_100,4),xi,yi);
vN_ed_100_ll = cube2latlon(xc,yc,vN_100(:,:,:,360),xi,yi) - vN_100_ll_tav;
clear('vN_000','vN_010','vN_025','vN_050','vN_075','vN_100')


load('/project/rg312/mat_files/heat_rates.mat')
convtheta(1,1,:,1)=(rC/101325.0).^(2./7.);
convthetatoT = repmat(convtheta,[180,90,1]);

htrt_100_ll = cube2latlon(xc,yc,htrt_100(:,:,:,360),xi,yi).*86400.*convthetatoT;
htrt_100_ll_tav = cube2latlon(xc,yc,mean(htrt_100,4),xi,yi).*86400.*convthetatoT;
htrt_ed_100_ll = htrt_100_ll - htrt_100_ll_tav;
clear('htrt_000','htrt_010','htrt_025','htrt_050','htrt_075','htrt_100')

radht_100_ll = cube2latlon(xc,yc,radht_100(:,:,:,360),xi,yi).*86400.*convthetatoT;
radht_100_ll_tav = cube2latlon(xc,yc,mean(radht_100,4),xi,yi).*86400.*convthetatoT;
radht_ed_100_ll = radht_100_ll - radht_100_ll_tav;
clear('radht_000','radht_010','radht_025','radht_050','radht_075','radht_100')

difht_100_ll = cube2latlon(xc,yc,difht_100(:,:,:,360),xi,yi).*86400.*convthetatoT;
difht_100_ll_tav = cube2latlon(xc,yc,mean(difht_100,4),xi,yi).*86400.*convthetatoT;
difht_ed_100_ll = difht_100_ll - difht_100_ll_tav;
clear('difht_000','difht_010','difht_025','difht_050','difht_075','difht_100')

cndht_100_ll = cube2latlon(xc,yc,cndht_100(:,:,:,360),xi,yi).*86400.*convthetatoT;
cndht_100_ll_tav = cube2latlon(xc,yc,mean(cndht_100,4),xi,yi).*86400.*convthetatoT;
cndht_ed_100_ll = cndht_100_ll - cndht_100_ll_tav;
clear('cndht_000','cndht_010','cndht_025','cndht_050','cndht_075','cndht_100')

cnvht_100_ll = cube2latlon(xc,yc,cnvht_100(:,:,:,360),xi,yi).*86400.*convthetatoT;
cnvht_100_ll_tav = cube2latlon(xc,yc,mean(cnvht_100,4),xi,yi).*86400.*convthetatoT;
cnvht_ed_100_ll = cnvht_100_ll - cnvht_100_ll_tav;
clear('cnvht_000','cnvht_010','cnvht_025','cnvht_050','cnvht_075','cnvht_100')




[dTdy_100,dTdx_100,dTdp_100] = gradient(t_100_ll_tav,pi./90,pi./90,-4100);
[dthetady_100,dthetadx_100,dthetadp_100] = gradient(theta_100_ll,pi./90,pi./90,-4000);
clear('dthetady_100','dthetadx_100')

dTdy_100 = dTdy_100./radius;

[dT_ed_dy_100,dT_ed_dx_100,dT_ed_dp_100] = gradient(t_ed_100_ll,pi./90,pi./90,-4100);
dT_ed_dy_100 = dT_ed_dy_100./radius;




for i=1:90
dT_ed_dx_100(:,i,:) = dT_ed_dx_100(:,i,:)./cos(yi(i).*pi./180)./radius;
dTdx_100(:,i,:) = dTdx_100(:,i,:)./cos(yi(i).*pi./180)./radius;
end

vNt_ed_100_ll = vN_ed_100_ll.*t_ed_100_ll;

%evaluate horiz advection terms

udT_ed_dx_100 = -dT_ed_dx_100.*uE_100_ll_tav.*86400;
u_ed_dTdx_100 = -dTdx_100.*uE_ed_100_ll.*86400;
vdT_ed_dy_100 = -dT_ed_dx_100.*vN_100_ll_tav.*86400;
v_ed_dTdy_100 = -dTdy_100.*vN_ed_100_ll.*86400;
wdT_ed_dp_100 = -dT_ed_dp_100.*w_100_ll_tav.*86400;
w_ed_dTdp_100 = -dTdp_100.*w_ed_100_ll.*86400;

dTdt_100 = (t_100_ll_p - t_100_ll_m)./2;

save('/project/rg312/mat_files/heat_budg_lp_100.mat')

load('/project/rg312/mat_files/front_diag.mat')


figure
v=-0.005:0.0005:0;
[C,h]=contourf(xi,rC./100,squeeze(dthetadp_100(:,x100n,:))',v);
colorbar
clabel(C,h);
set(gca,'YDir','reverse');
title('d\Theta dp, 1.0es0');
ylabel('Pressure, hPa')
xlabel('Longitude')
print('-dpng','dthetadp_latsec_100.png')




figure
v=-20:2:20;
[C,h] = contourf(xi,yi,wdT_ed_dp_100(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('wdT''dp, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wdtpdp_100.png')

figure
v=-20:2:20;
[C,h] = contourf(xi,yi,w_ed_dTdp_100(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-20 20]);
colorbar
title('w''dTdp, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wpdtdp_100.png')


return


figure
v=-150:25:150;
[C,h] = contourf(xi,rC./100,squeeze(vNt_ed_100_ll(:,x100n,:))',v);
caxis([-150 150]);
set(gca,'YDir','reverse');
colorbar
title('v''T'', 1.0es0');
ylabel('Pressure, hPa')
xlabel('Longitude')
print('-dpng','vt_latsec_100.png')

figure
v=-30:5:30;
[C,h] = contourf(xi,rC./100,squeeze(vN_ed_100_ll(:,x100n,:))',v);
caxis([-30 30]);
set(gca,'YDir','reverse');
colorbar
title('v'', 1.0es0');
ylabel('Pressure, hPa')
xlabel('Longitude')
print('-dpng','v_latsec_100.png')


figure
v=-10:2:10;
[C,h] = contourf(xi,rC./100,squeeze(t_ed_100_ll(:,x100n,:))',v);
set(gca,'YDir','reverse');
colorbar
caxis([-10 10])
title('T'', 1.0es0');
ylabel('Pressure, hPa')
xlabel('Longitude')
print('-dpng','t_latsec_100.png')





figure
v=-20:4:20;
[C,h] = contourf(xi,rC./100,squeeze(udT_ed_dx_100(:,x100n,:))',v);
set(gca,'YDir','reverse');
colorbar
caxis([-20 20])
title('<u>dT''dx, 1.0es0');
ylabel('Pressure, hPa')
xlabel('Longitude')
print('-dpng','udtpdx_latsec_100.png')

figure
v=-20:4:20;
[C,h] = contourf(xi,rC./100,squeeze(u_ed_dTdx_100(:,x100n,:))',v);
set(gca,'YDir','reverse');
colorbar
caxis([-20 20])
title('u''d<T>dx, 1.0es0');
ylabel('Pressure, hPa')
xlabel('Longitude')
print('-dpng','updtdx_latsec_100.png')

figure
v=-20:4:20;
[C,h] = contourf(xi,rC./100,squeeze(wdT_ed_dp_100(:,x100n,:))',v);
set(gca,'YDir','reverse');
colorbar
caxis([-20 20])
title('<w>dT''dp, 1.0es0');
ylabel('Pressure, hPa')
xlabel('Longitude')
print('-dpng','wdtpdx_latsec_100.png')

figure
v=-20:4:20;
[C,h] = contourf(xi,rC./100,squeeze(w_ed_dTdp_100(:,x100n,:))',v);
set(gca,'YDir','reverse');
colorbar
caxis([-20 20])
title('w''d<T>dp, 1.0es0');
ylabel('Pressure, hPa')
xlabel('Longitude')
print('-dpng','wpdtdx_latsec_100.png')

figure
v=-20:4:20;
[C,h] = contourf(xi,rC./100,squeeze(vdT_ed_dy_100 (:,x100n,:))',v);
set(gca,'YDir','reverse');
colorbar
caxis([-20 20])
title('<v>dT''dy, 1.0es0');
ylabel('Pressure, hPa')
xlabel('Longitude')
print('-dpng','vdtpdy_latsec_100.png')

figure
v=-20:4:20;
[C,h] = contourf(xi,rC./100,squeeze(v_ed_dTdy_100 (:,x100n,:))',v);
set(gca,'YDir','reverse');
colorbar
caxis([-20 20])
title('v''dTdy, 1.0es0');
ylabel('Pressure, hPa')
xlabel('Longitude')
print('-dpng','vpdtdy_latsec_100.png')




figure
v=-20:4:20;
[C,h] = contourf(xi,rC./100,squeeze(udT_ed_dx_100(:,x100n,:))'+squeeze(v_ed_dTdy_100(:,x100n,:))',v);
set(gca,'YDir','reverse');
colorbar
caxis([-20 20])
title('v''dTdy + udT''dx, 1.0es0');
ylabel('Pressure, hPa')
xlabel('Longitude')
print('-dpng','horizdynheatsum_latsec_100.png')


figure
v=-20:4:20;
[C,h] = contourf(xi,rC./100,squeeze(udT_ed_dx_100(:,x100n,:))'+squeeze(v_ed_dTdy_100(:,x100n,:))'+squeeze(w_ed_dTdp_100(:,x100n,:))',v);
set(gca,'YDir','reverse');
colorbar
caxis([-20 20])
title('v''dTdy + udT''dx + w''dTdp, 1.0es0');
ylabel('Pressure, hPa')
xlabel('Longitude')
print('-dpng','dynheatsum_latsec_100.png')



figure
v=-0.4:0.1:0.4;
[C,h] = contourf(xi,rC./100,squeeze(w_100_ll(:,x100n,:))',v);
set(gca,'YDir','reverse');
colorbar
caxis([-0.4 0.4])
title('w, 1.0es0');
ylabel('Pressure, hPa')
xlabel('Longitude')
print('-dpng','w_latsec_100.png')



figure
v=-6:2:12;
[C,h] = contourf(xi,rC./100,squeeze(htrt_ed_100_ll(:,x100n,:))',v);
caxis([-6 12]);
set(gca,'YDir','reverse');
colorbar
title('Total diabatic heating, 1.0es0');
ylabel('Pressure, hPa')
xlabel('Longitude')
print('-dpng','htrt_latsec_100.png')


figure
v=-1.6:0.2:1;
[C,h] = contourf(xi,rC./100,squeeze(radht_ed_100_ll(:,x100n,:))',v);
caxis([-1.6 1]);
set(gca,'YDir','reverse');
colorbar
title('Radiative heating, 1.0es0');
ylabel('Pressure, hPa')
xlabel('Longitude')
print('-dpng','radht_latsec_100.png')


figure
v=-9:1:6;
[C,h] = contourf(xi,rC./100,squeeze(difht_ed_100_ll(:,x100n,:))',v);
caxis([-9 6]);
set(gca,'YDir','reverse');
colorbar
title('Diffusive heating, 1.0es0');
ylabel('Pressure, hPa')
xlabel('Longitude')
print('-dpng','difht_latsec_100.png')


figure
v=-4:1:10;
[C,h] = contourf(xi,rC./100,squeeze(cnvht_ed_100_ll(:,x100n,:))',v);
caxis([-4 10]);
set(gca,'YDir','reverse');
colorbar
title('Convective heating, 1.0es0');
ylabel('Pressure, hPa')
xlabel('Longitude')
print('-dpng','cnvht_latsec_100.png')


figure
v=-2:2:12;
[C,h] = contourf(xi,rC./100,squeeze(cndht_ed_100_ll(:,x100n,:))',v);
caxis([-2 12]);
set(gca,'YDir','reverse');
colorbar
title('Largescale latent heating, 1.0es0');
ylabel('Pressure, hPa')
xlabel('Longitude')
print('-dpng','cndht_latsec_100.png')


