
rDir='/project/rg312/final_runs/run_100_final/';
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



rDir='/project/rg312/final_runs/run_000_final_noshallow/';
nit = 172800;
[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhDifT'));
dift_000 = snap(:,:,:,J);
dift_000_ll = squeeze(cube2latlon(xc,yc,dift_000,xi,yi));
J=find(strcmp(fldList,'AtPhdTdf'));
dtdf_000 = snap(:,:,:,J);
dtdf_000_ll = squeeze(cube2latlon(xc,yc,dtdf_000,xi,yi));

J=find(strcmp(fldList,'AtPhDifM'));
difm_000 = snap(:,:,:,J);
difm_000_ll = squeeze(cube2latlon(xc,yc,difm_000,xi,yi));

J=find(strcmp(fldList,'AtPhdUdt'));
dudt_000 = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdVdt'));
dvdt_000 = snap(:,:,:,J);
[duEdt_000,dvNdt_000] = rotate_uv2uvEN(dudt_000,dvdt_000,AngleCS,AngleSN,Grid);

theta_000 = rdmds([rDir,'T'],nit);
ucs_000 = rdmds([rDir,'U'],nit);
vcs_000 = rdmds([rDir,'V'],nit);
[uE_000,vN_000] = rotate_uv2uvEN(ucs_000,vcs_000,AngleCS,AngleSN,Grid);
vN_000_ll = squeeze(cube2latlon(xc,yc,vN_000,xi,yi));
theta_000_ll = squeeze(cube2latlon(xc,yc,theta_000,xi,yi));
dvNdt_000_ll = squeeze(cube2latlon(xc,yc,dvNdt_000,xi,yi));


rDir='/project/rg312/final_runs/run_100_final/';
nit = 172800;
[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhDifT'));
dift_100 = snap(:,:,:,J);
dift_100_ll = squeeze(cube2latlon(xc,yc,dift_100,xi,yi));
J=find(strcmp(fldList,'AtPhdTdf'));
dtdf_100 = snap(:,:,:,J);
dtdf_100_ll = squeeze(cube2latlon(xc,yc,dtdf_100,xi,yi));

J=find(strcmp(fldList,'AtPhDifM'));
difm_100 = snap(:,:,:,J);
difm_100_ll = squeeze(cube2latlon(xc,yc,difm_100,xi,yi));

J=find(strcmp(fldList,'AtPhdUdt'));
dudt_100 = snap(:,:,:,J);
J=find(strcmp(fldList,'AtPhdVdt'));
dvdt_100 = snap(:,:,:,J);
[duEdt_100,dvNdt_100] = rotate_uv2uvEN(dudt_100,dvdt_100,AngleCS,AngleSN,Grid);

theta_100 = rdmds([rDir,'T'],nit);
ucs_100 = rdmds([rDir,'U'],nit);
vcs_100 = rdmds([rDir,'V'],nit);
[uE_100,vN_100] = rotate_uv2uvEN(ucs_100,vcs_100,AngleCS,AngleSN,Grid);
vN_100_ll = squeeze(cube2latlon(xc,yc,vN_100,xi,yi));
theta_100_ll = squeeze(cube2latlon(xc,yc,theta_100,xi,yi));
dvNdt_100_ll = squeeze(cube2latlon(xc,yc,dvNdt_100,xi,yi));


convthetatoT=(rC/100000.0).^(2./7.);
for j=1:size(rC)
t_000_ll(:,:,j,:)=theta_000_ll(:,:,j,:).*convthetatoT(j,1);
t_100_ll(:,:,j,:)=theta_100_ll(:,:,j,:).*convthetatoT(j,1);
end

for i=1:25
rho_000(:,:,i) = rC(i)./Rd./t_000_ll(:,:,i);
rho_100(:,:,i) = rC(i)./Rd./t_100_ll(:,:,i);
end



[a,b,dvNdp_000] = gradient(vN_000_ll,-4000);
dvNdz_000 = -rho_000.*g.*dvNdp_000;

kdvNdz_000 = difm_000_ll.*dvNdp_000;
[a,b,dkdvNdzdp_000] = gradient(kdvNdz_000,-4000);
dkdvNdzdz_000 = -dkdvNdzdp_000.*rho_000.*g;

[a,b,dvNdzdp_000] = gradient(dvNdz_000,-4000);
kdvNdzdz_000 = -difm_000_ll.*rho_000.*g.*dvNdzdp_000;

[a,b,dkdp_000] = gradient(difm_000_ll,-4000);
dkdz_000 = -rho_000.*g.*dkdp_000;

dkdzdvNdz_000 = dkdz_000.*dvNdz_000;




[a,b,dvNdp_100] = gradient(vN_100_ll,-4000);
dvNdz_100 = -rho_100.*g.*dvNdp_100;

kdvNdz_100 = difm_100_ll.*dvNdp_100;
[a,b,dkdvNdzdp_100] = gradient(kdvNdz_100,-4000);
dkdvNdzdz_100 = -dkdvNdzdp_100.*rho_100.*g;

[a,b,dvNdzdp_100] = gradient(dvNdz_100,-4000);
kdvNdzdz_100 = -difm_100_ll.*rho_100.*g.*dvNdzdp_100;

[a,b,dkdp_100] = gradient(difm_100_ll,-4000);
dkdz_100 = -rho_100.*g.*dkdp_100;

dkdzdvNdz_100 = dkdz_100.*dvNdz_100;






[a,b,dthetadp_000] = gradient(theta_000_ll,-4000);
dthetadz_000 = -rho_000.*g.*dthetadp_000;
kdthetadz_000 = dift_000_ll.*dthetadz_000;
[a,b,dkdthetadzdp_000] = gradient(kdthetadz_000,-4000);
dkdthetadzdz_000 = -rho_000.*g.*dkdthetadzdp_000;

return

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


