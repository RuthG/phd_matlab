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
ny=90;

load('/project/rg312/mat_files/vt_lats.mat')

load('/project/rg312/mat_files/snapshot_data/vt_ed_data.mat')
vt_ed_000_ss = vt_ed_000n(:,:,:,91);
vt_ed_010_ss = vt_ed_010n(:,:,:,658);
vt_ed_025_ss = vt_ed_025n(:,:,:,455);
vt_ed_050_ss = vt_ed_050n(:,:,:,70);
vt_ed_075_ss = vt_ed_075n(:,:,:,201);
vt_ed_100_ss = vt_ed_100n(:,:,:,394);

load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat')

xi=-179:2:180;yi=-89:2:90;
t_000_ll = cube2latlon(xc,yc,t_000(:,:,:,91),xi,yi);
clear t_000
t_010_ll = cube2latlon(xc,yc,t_010(:,:,:,658),xi,yi);
clear t_010
t_025_ll = cube2latlon(xc,yc,t_025(:,:,:,455),xi,yi);
clear t_025
t_050_ll = cube2latlon(xc,yc,t_050(:,:,:,70),xi,yi);
clear t_050
t_075_ll = cube2latlon(xc,yc,t_075(:,:,:,201),xi,yi);
clear t_075
t_100_ll = cube2latlon(xc,yc,t_100(:,:,:,394),xi,yi);
clear t_100



Ra = 287.04;
g= 9.81;
omega = 2.*pi./24./60./60;

for i=1:25
rho_000(:,:,i) = rC(i)./Ra./t_000_ll(:,:,i);
rho_010(:,:,i) = rC(i)./Ra./t_010_ll(:,:,i);
rho_025(:,:,i) = rC(i)./Ra./t_025_ll(:,:,i);
rho_050(:,:,i) = rC(i)./Ra./t_050_ll(:,:,i);
rho_075(:,:,i) = rC(i)./Ra./t_075_ll(:,:,i);
rho_100(:,:,i) = rC(i)./Ra./t_100_ll(:,:,i);
end

%clear('t_000_ll','t_010_ll','t_025_ll','t_050_ll','t_075_ll','t_100_ll')


load('/project/rg312/mat_files/snapshot_data/uE_snapshots.mat')


uE_000_ll = cube2latlon(xc,yc,uE_000(:,:,:,91),xi,yi);
clear uE_000
uE_010_ll = cube2latlon(xc,yc,uE_010(:,:,:,658),xi,yi);
clear uE_010
uE_025_ll = cube2latlon(xc,yc,uE_025(:,:,:,455),xi,yi);
clear uE_025
uE_050_ll = cube2latlon(xc,yc,uE_050(:,:,:,70),xi,yi);
clear uE_050
uE_075_ll = cube2latlon(xc,yc,uE_075(:,:,:,201),xi,yi);
clear uE_075
uE_100_ll = cube2latlon(xc,yc,uE_100(:,:,:,394),xi,yi);
clear uE_100

[a,b,dudp_000] = gradient(uE_000_ll,-4000);
clear uE_000_ll
[a,b,dudp_010] = gradient(uE_010_ll,-4000);
clear uE_010_ll
[a,b,dudp_025] = gradient(uE_025_ll,-4000);
clear uE_025_ll
[a,b,dudp_050] = gradient(uE_050_ll,-4000);
clear uE_050_ll
[a,b,dudp_075] = gradient(uE_075_ll,-4000);
clear uE_075_ll
[a,b,dudp_100] = gradient(uE_100_ll,-4000);
clear uE_100_ll

clear('a','b','d')

dudz_000 = -g.*rho_000.*dudp_000;
%clear('dudp_000','rho_000')
dudz_010 = -g.*rho_010.*dudp_010;
%clear('dudp_010','rho_010')
dudz_025 = -g.*rho_025.*dudp_025;
%clear('dudp_025','rho_025')
dudz_050 = -g.*rho_050.*dudp_050;
%clear('dudp_050','rho_050')
dudz_075 = -g.*rho_075.*dudp_075;
%clear('dudp_075','rho_075')
dudz_100 = -g.*rho_100.*dudp_100;
%clear('dudp_100','rho_100')

load('/project/rg312/mat_files/snapshot_data/theta_snapshots.mat')

theta_000_ll = cube2latlon(xc,yc,theta_000(:,:,:,91),xi,yi);
clear theta_000
theta_010_ll = cube2latlon(xc,yc,theta_010(:,:,:,658),xi,yi);
clear theta_010
theta_025_ll = cube2latlon(xc,yc,theta_025(:,:,:,455),xi,yi);
clear theta_025
theta_050_ll = cube2latlon(xc,yc,theta_050(:,:,:,70),xi,yi);
clear theta_050
theta_075_ll = cube2latlon(xc,yc,theta_075(:,:,:,201),xi,yi);
clear theta_075
theta_100_ll = cube2latlon(xc,yc,theta_100(:,:,:,394),xi,yi);
clear theta_100


[a,b,dthetadp_000] = gradient(theta_000_ll,-4000);
[a,b,dthetadp_010] = gradient(theta_010_ll,-4000);
[a,b,dthetadp_025] = gradient(theta_025_ll,-4000);
[a,b,dthetadp_050] = gradient(theta_050_ll,-4000);
[a,b,dthetadp_075] = gradient(theta_075_ll,-4000);
[a,b,dthetadp_100] = gradient(theta_100_ll,-4000);

Nsq_000 = - g.^2 .* rho_000 .* dthetadp_000 ./theta_000_ll;
Nsq_010 = - g.^2 .* rho_010 .* dthetadp_010 ./theta_010_ll;
Nsq_025 = - g.^2 .* rho_025 .* dthetadp_025 ./theta_025_ll;
Nsq_050 = - g.^2 .* rho_050 .* dthetadp_050 ./theta_050_ll;
Nsq_075 = - g.^2 .* rho_075 .* dthetadp_075 ./theta_075_ll;
Nsq_100 = - g.^2 .* rho_100 .* dthetadp_100 ./theta_100_ll;

richardson_000 = Nsq_000./(dudz_000.^2);
richardson_010 = Nsq_010./(dudz_010.^2);
richardson_025 = Nsq_025./(dudz_025.^2);
richardson_050 = Nsq_050./(dudz_050.^2);
richardson_075 = Nsq_075./(dudz_075.^2);
richardson_100 = Nsq_100./(dudz_100.^2);

v = -1e-4:0.25e-4:3.5e-4;

figure
contourf(xi,yi(x000n-7:x000n+7),Nsq_000(:,x000n-7:x000n+7,3)',v);
colorbar
colormap(b2r(-1e-4, 3.5e-4));
print('-dpng','bvfreq_000.png')
figure
contourf(xi,yi(x010n-7:x010n+7),Nsq_010(:,x010n-7:x010n+7,3)',v);
colorbar
colormap(b2r(-1e-4, 3.5e-4));
print('-dpng','bvfreq_010.png')
figure
contourf(xi,yi(x025n-7:x025n+7),Nsq_025(:,x025n-7:x025n+7,3)',v);
colorbar
colormap(b2r(-1e-4, 3.5e-4));
print('-dpng','bvfreq_025.png')
figure
contourf(xi,yi(x050n-7:x050n+7),Nsq_050(:,x050n-7:x050n+7,3)',v);
colorbar
colormap(b2r(-1e-4, 3.5e-4));
print('-dpng','bvfreq_050.png')
figure
contourf(xi,yi(x075n-7:x075n+7),Nsq_075(:,x075n-7:x075n+7,3)',v);
colorbar
colormap(b2r(-1e-4, 3.5e-4));
print('-dpng','bvfreq_075.png')
figure
contourf(xi,yi(x100n-7:x100n+7),Nsq_100(:,x100n-7:x100n+7,3)',v);
colorbar
colormap(b2r(-1e-4, 3.5e-4));
print('-dpng','bvfreq_100.png')

v = 0:2e-5:18e-5;
figure
contourf(xi,yi(x000n-7:x000n+7),dudz_000(:,x000n-7:x000n+7,3)'.^2,v);
colorbar
caxis([0 18e-5])
print('-dpng','dudzsq_000.png')
figure
contourf(xi,yi(x010n-7:x010n+7),dudz_010(:,x010n-7:x010n+7,3)'.^2,v);
colorbar
caxis([0 18e-5])
print('-dpng','dudzsq_010.png')
figure
contourf(xi,yi(x025n-7:x025n+7),dudz_025(:,x025n-7:x025n+7,3)'.^2,v);
colorbar
caxis([0 18e-5])
print('-dpng','dudzsq_025.png')
figure
contourf(xi,yi(x050n-7:x050n+7),dudz_050(:,x050n-7:x050n+7,3)'.^2,v);
colorbar
caxis([0 18e-5])
print('-dpng','dudzsq_050.png')
figure
contourf(xi,yi(x075n-7:x075n+7),dudz_075(:,x075n-7:x075n+7,3)'.^2,v);
colorbar
caxis([0 18e-5])
print('-dpng','dudzsq_075.png')
figure
contourf(xi,yi(x100n-7:x100n+7),dudz_100(:,x100n-7:x100n+7,3)'.^2,v);
colorbar
caxis([0 18e-5])
print('-dpng','dudzsq_100.png')




v = -30:10:140;
figure
contourf(xi,yi(x000n-7:x000n+7),vt_ed_000_ss(:,:,3)');
colorbar
colormap(b2r(-30, 140));
print('-dpng','vted_000.png')
figure
contourf(xi,yi(x010n-7:x010n+7),vt_ed_010_ss(:,:,3)');
colorbar
colormap(b2r(-30, 140));
print('-dpng','vted_010.png')
figure
contourf(xi,yi(x025n-7:x025n+7),vt_ed_025_ss(:,:,3)');
colorbar
colormap(b2r(-30, 140));
print('-dpng','vted_025.png')
figure
contourf(xi,yi(x050n-7:x050n+7),vt_ed_050_ss(:,:,3)');
colorbar
colormap(b2r(-30, 140));
print('-dpng','vted_050.png')
figure
contourf(xi,yi(x075n-7:x075n+7),vt_ed_075_ss(:,:,3)');
colorbar
colormap(b2r(-30, 140));
print('-dpng','vted_075.png')
figure
contourf(xi,yi(x100n-7:x100n+7),vt_ed_100_ss(:,:,3)');
colorbar
colormap(b2r(-30, 140));
print('-dpng','vted_100.png')




figure
contourf(xi,yi(x000n-7:x000n+7),richardson_000(:,x000n-7:x000n+7,3)');
colorbar

figure
contourf(xi,yi(x000n-7:x000n+7),richardson_010(:,x010n-7:x010n+7,3)');
colorbar

figure
contourf(xi,yi(x000n-7:x000n+7),richardson_025(:,x025n-7:x025n+7,3)');
colorbar

figure
contourf(xi,yi(x000n-7:x000n+7),richardson_050(:,x050n-7:x050n+7,3)');
colorbar

figure
contourf(xi,yi(x000n-7:x000n+7),richardson_075(:,x075n-7:x075n+7,3)');
colorbar

figure
contourf(xi,yi(x000n-7:x000n+7),richardson_100(:,x100n-7:x100n+7,3)');
colorbar



figure
contourf(xi,yi(x000n-7:x000n+7),richardson_000(:,x000n-7:x000n+7,13)');
colorbar

figure
contourf(xi,yi(x000n-7:x000n+7),richardson_010(:,x010n-7:x010n+7,13)');
colorbar

figure
contourf(xi,yi(x000n-7:x000n+7),richardson_025(:,x025n-7:x025n+7,13)');
colorbar

figure
contourf(xi,yi(x000n-7:x000n+7),richardson_050(:,x050n-7:x050n+7,13)');
colorbar

figure
contourf(xi,yi(x000n-7:x000n+7),richardson_075(:,x075n-7:x075n+7,13)');
colorbar

figure
contourf(xi,yi(x000n-7:x000n+7),richardson_100(:,x100n-7:x100n+7,13)');
colorbar




figure
contourf(xi,yi(x000n-7:x000n+7),richardson_000(:,x000n-7:x000n+7,18)');
colorbar

figure
contourf(xi,yi(x000n-7:x000n+7),richardson_010(:,x010n-7:x010n+7,18)');
colorbar

figure
contourf(xi,yi(x000n-7:x000n+7),richardson_025(:,x025n-7:x025n+7,18)');
colorbar

figure
contourf(xi,yi(x000n-7:x000n+7),richardson_050(:,x050n-7:x050n+7,18)');
colorbar

figure
contourf(xi,yi(x000n-7:x000n+7),richardson_075(:,x075n-7:x075n+7,18)');
colorbar

figure
contourf(xi,yi(x000n-7:x000n+7),richardson_100(:,x100n-7:x100n+7,18)');
colorbar


