
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


rDir='/project/rg312/wv_on_rad_off/run_000_best/';
nit = 172800;
[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhDifT'));
dift_000 = snap(:,:,:,J);
dift_000_ll = squeeze(cube2latlon(xc,yc,dift_000,xi,yi));

theta_000 = rdmds([rDir,'T'],nit);
theta_000_ll = squeeze(cube2latlon(xc,yc,theta_000,xi,yi));


rDir='/project/rg312/wv_on_rad_off/run_100_best/';
[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhDifT'));
dift_100 = snap(:,:,:,J);
dift_100_ll = squeeze(cube2latlon(xc,yc,dift_100,xi,yi));

theta_100 = rdmds([rDir,'T'],nit);
theta_100_ll = squeeze(cube2latlon(xc,yc,theta_100,xi,yi));


convthetatoT=(rC/100000.0).^(2./7.);
for j=1:size(rC)
t_000_ll(:,:,j,:)=theta_000_ll(:,:,j,:).*convthetatoT(j,1);
t_100_ll(:,:,j,:)=theta_100_ll(:,:,j,:).*convthetatoT(j,1);
end

for i=1:25
rho_000(:,:,i) = rC(i)./Rd./t_000_ll(:,:,i);
rho_100(:,:,i) = rC(i)./Rd./t_100_ll(:,:,i);
end

[a,b,dthetadp_000] = gradient(theta_000_ll,-4000);
dthetadz_000 = -rho_000.*g.*dthetadp_000;

[a,b,dthetadzdp_000] = gradient(dthetadz_000,-4000);
kdthetadzdz_000 = -dift_000_ll.*rho_000.*g.*dthetadzdp_000;

[a,b,dkdp_000] = gradient(dift_000_ll,-4000);
dkdz_000 = -rho_000.*g.*dkdp_000;

dkdzdthetadz_000 = dkdz_000.*dthetadz_000;


[a,b,dthetadp_100] = gradient(theta_100_ll,-4000);
dthetadz_100 = -rho_000.*g.*dthetadp_100;

[a,b,dthetadzdp_100] = gradient(dthetadz_100,-4000);
kdthetadzdz_100 = -dift_100_ll.*rho_100.*g.*dthetadzdp_100;

[a,b,dkdp_100] = gradient(dift_100_ll,-4000);
dkdz_100 = -rho_100.*g.*dkdp_100;

dkdzdthetadz_100 = dkdz_100.*dthetadz_100;


v=-10:1:10;
figure
[C,h] = contourf(xi,yi,dkdzdthetadz_000(:,:,2)'.*86400,v);
colorbar
caxis([-10 10])
xlabel('Longitude')
ylabel('Latitude')
title('dkdz*d\Theta dz 0es0, 940hPa')
print('-dpng','dkdzdthetadz_000_l2.png')

figure
[C,h] = contourf(xi,yi,kdthetadzdz_000(:,:,2)'.*86400,v);
colorbar
caxis([-10 10])
xlabel('Longitude')
ylabel('Latitude')
title('kd^2 \Theta dz^2 0es0, 940hPa')
print('-dpng','kdthetadzdz_000_l2.png')

figure
[C,h] = contourf(xi,yi,dkdzdthetadz_100(:,:,2)'.*86400,v);
colorbar
caxis([-10 10])
xlabel('Longitude')
ylabel('Latitude')
title('dkdz*d\Theta dz 1es0, 940hPa')
print('-dpng','dkdzdthetadz_100_l2.png')

figure
[C,h] = contourf(xi,yi,kdthetadzdz_100(:,:,2)'.*86400,v);
colorbar
caxis([-10 10])
xlabel('Longitude')
ylabel('Latitude')
title('kd^2 \Theta dz^2 1es0, 940hPa')
print('-dpng','kdthetadzdz_100_l2.png')






figure
[C,h] = contourf(xi,yi,dkdzdthetadz_000(:,:,5)'.*86400,v);
colorbar
caxis([-10 10])
xlabel('Longitude')
ylabel('Latitude')
title('dkdz*d\Theta dz 0es0, 820hPa')
print('-dpng','dkdzdthetadz_000_l5.png')

figure
[C,h] = contourf(xi,yi,kdthetadzdz_000(:,:,5)'.*86400,v);
colorbar
caxis([-10 10])
xlabel('Longitude')
ylabel('Latitude')
title('kd^2 \Theta dz^2 0es0, 820hPa')
print('-dpng','kdthetadzdz_000_l5.png')

figure
[C,h] = contourf(xi,yi,dkdzdthetadz_100(:,:,5)'.*86400,v);
colorbar
caxis([-10 10])
xlabel('Longitude')
ylabel('Latitude')
title('dkdz*d\Theta dz 1es0, 820hPa')
print('-dpng','dkdzdthetadz_100_l5.png')

figure
[C,h] = contourf(xi,yi,kdthetadzdz_100(:,:,5)'.*86400,v);
colorbar
caxis([-10 10])
xlabel('Longitude')
ylabel('Latitude')
title('kd^2 \Theta dz^2 1es0, 820hPa')
print('-dpng','kdthetadzdz_100_l5.png')


