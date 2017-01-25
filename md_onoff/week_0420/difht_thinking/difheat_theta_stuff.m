%load up theta profiles and check how laplacian of these compare to difht profiles



rDir='/project/rg312/wv_on_rad_off/run_000_best/';
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
xi = -179:2:179;

Rd = 287.04;
g = 9.81;

load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat','theta_000')
theta_000_ll = squeeze(cube2latlon(xc,yc,theta_000(:,:,:,360),xi,yi));
clear('theta_000')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_000')
t_000_ll = squeeze(cube2latlon(xc,yc,t_000(:,:,:,360),xi,yi));
clear('t_000')

load('/project/rg312/mat_files/heat_rates_best.mat','difht_000')
difht_000_ll = squeeze(cube2latlon(xc,yc,difht_000(:,:,:,360),xi,yi)).*86400;
clear('difht_000')

for i=1:25
rho_000(:,:,i) = rC(i)./Rd./t_000_ll(:,:,i);
end

[a,b,dthetadp_000] = gradient(theta_000_ll,-4000);
dthetadz_000 = rho_000.*g.*dthetadp_000;
[a,b,d2thetadzdp_000] = gradient(dthetadz_000,-4000);
d2thetadz2_000 = rho_000.*g.*d2thetadzdp_000;

[a,b,dtdp_000] = gradient(t_000_ll,-4000);
dtdz_000 = rho_000.*g.*dtdp_000;
[a,b,d2tdzdp_000] = gradient(dtdz_000,-4000);
d2tdz2_000 = rho_000.*g.*d2tdzdp_000;



rDir='/project/rg312/wv_on_rad_off/run_000_best/';
nit = 172800;
[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhDifT'));
dift_000 = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhDifM'));
difm_000 = snap(:,:,:,J);
dift_000_ll = squeeze(cube2latlon(xc,yc,dift_000,xi,yi));
difm_000_ll = squeeze(cube2latlon(xc,yc,difm_000,xi,yi));


load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat','theta_100')
theta_100_ll = squeeze(cube2latlon(xc,yc,theta_100(:,:,:,360),xi,yi));
clear('theta_100')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_100')
t_100_ll = squeeze(cube2latlon(xc,yc,t_100(:,:,:,360),xi,yi));
clear('t_100')

load('/project/rg312/mat_files/heat_rates_best.mat','difht_100')
difht_100_ll = squeeze(cube2latlon(xc,yc,difht_100(:,:,:,360),xi,yi)).*86400;
clear('difht_100')

yy=yi*90/60*pi/180;
sinyy=sin(yy);
sst=27*(1-sinyy.*sinyy);
sst(find(abs(yi)>=60))=0;
sst=sst+273.15;




figure
[C,h] = contourf(xi,yi,difht_000_ll(:,:,5)');
colorbar
ylabel('Latitude')
xlabel('Longitude')
hold on
plot(xi(1),yi(30),'xk','MarkerSize',10,'LineWidth',3) 
plot(xi(100),yi(25),'xr','MarkerSize',10,'LineWidth',3) 
print('-dpng','difht_snap.png')

figure
[C,h] = contourf(xi,yi,t_000_ll(:,:,5)');
colorbar
ylabel('Latitude')
xlabel('Longitude')
hold on
plot(xi(1),yi(30),'xk','MarkerSize',10,'LineWidth',3) 
plot(xi(100),yi(25),'xr','MarkerSize',10,'LineWidth',3) 
print('-dpng','t_snap.png')

figure
plot(squeeze(difht_000_ll(1,30,1:7)),rC(1:7)./100);
hold on
plot(squeeze(difht_000_ll(100,25,1:7)),rC(1:7)./100,'r');
set(gca,'YDir','reverse');
xlabel('Diffusive heating rate, K/day')
ylabel('Pressure, hPa')
print('-dpng','difht_profs.png')

figure
plot(squeeze(theta_000_ll(1,30,1:7)),rC(1:7)./100);
hold on
plot(squeeze(theta_000_ll(100,25,1:7)),rC(1:7)./100,'r');
set(gca,'YDir','reverse');
xlabel('Potential temperature, K')
ylabel('Pressure, hPa')
print('-dpng','theta_profs.png')

figure
plot(squeeze(t_000_ll(1,30,1:7)),rC(1:7)./100);
hold on
plot(squeeze(t_000_ll(100,25,1:7)),rC(1:7)./100,'r');
set(gca,'YDir','reverse');
xlabel('Temperature, K')
ylabel('Pressure, hPa')
print('-dpng','t_profs.png')

return

for i=1:25
rho_100(:,:,i) = rC(i)./Rd./t_100_ll(:,:,i);
end

[a,b,dthetadp_100] = gradient(theta_100_ll,-4000);
dthetadz_100 = rho_100.*g.*dthetadp_100;
[a,b,d2thetadzdp_100] = gradient(dthetadz_100,-4000);
d2thetadz2_100 = rho_100.*g.*d2thetadzdp_100;

[a,b,dtdp_100] = gradient(t_100_ll,-4000);
dtdz_100 = rho_100.*g.*dtdp_100;
[a,b,d2tdzdp_100] = gradient(dtdz_100,-4000);
d2tdz2_100 = rho_100.*g.*d2tdzdp_100;

rDir='/project/rg312/wv_on_rad_off/run_100_best/';
nit = 172800;
[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhDifT'));
dift_100 = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhDifM'));
difm_100 = snap(:,:,:,J);
dift_100_ll = squeeze(cube2latlon(xc,yc,dift_100,xi,yi));
difm_100_ll = squeeze(cube2latlon(xc,yc,difm_100,xi,yi));


figure
plot(squeeze(d2thetadz2_000(1,60,1:10)),rC(1:10),'r')
hold on
plot(squeeze(d2thetadz2_100(1,60,1:10)),rC(1:10))

figure
plot(squeeze(difht_000_ll(1,60,1:10)),rC(1:10),'r')
hold on
plot(squeeze(difht_100_ll(1,60,1:10)),rC(1:10))
