%Correlate EKE at peak with Phi

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_1yeardaily_c/';
slashes = findstr(rDir,'/');
point1 = slashes(max(size(slashes))-2);
dir_label = rDir(point1+1:max(size(rDir))-1);
dir_label = strrep(dir_label,'/','_');

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

%Load up 20 days EKE data and Theta data
convthetatoT=(rC/101325.0).^(2./7.);

i=0;
for nit = 605040:240:691200;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSQ  '));
vsq(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELSQ  '));
usq(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

for j=1:size(rC)
temp(:,:,j,i)=theta(:,:,j,i).*convthetatoT(j,1);
end

end

%Calculate EKE and gz on lat-lon grid
ra=287;
for i=1:25
integrand(:,:,i,:) = ra.*temp(:,:,i,:)./rC(i);
end

phi = cumsum(integrand,3).*4000;

[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE,ny,yc,ar,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN,ny,yc,ar,hc);
[temp_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp,ny,yc,ar,hc);
[phi_zav,mskzon,ylat,areazon]=calcZonalAvgCube(phi,ny,yc,ar,hc);

ke = usq + vsq;

xi=-179:2:180;yi=-89:2:90;
kell=single(cube2latlon(xc,yc,ke,xi,yi));
phill = single(cube2latlon(xc,yc,phi,xi,yi));

for i=1:180
ketemp(:,:,:) = kell(i,:,:,:);
phitemp(:,:,:) = phill(i,:,:,:);
eke(i,:,:,:) = ketemp - uE_zav.^2 - vN_zav.^2;
phied(i,:,:,:) = phitemp - phi_zav;
end

%Split into 2 hemispheres to get more data for avs
eke_h1 = eke(:,46:90,:,:);
eke_h2 = flipdim(eke(:,1:45,:,:),2);
phied_h1 = phied(:,46:90,:,:);
phied_h2 = flipdim(phied(:,1:45,:,:),2);

% <(EKE)(W')>
% Want to find correlations between EKE and lower level w. Likely to be shifted in space and time. 

%Work up to it. First Correlate EKE at one point with EKE at other points

for j=1:360
ekecovar_h1(:,:,j) = eke_h1(85,19,18,j).*eke_h1(:,:,18,j);
phicovar_h1(:,:,j) = phied_h1(85,19,8,j).*phied_h1(:,:,18,j);
ekephicovar_h1(:,:,j) = eke_h1(85,19,18,j).*phied_h1(:,:,18,j);
ekecovar_h2(:,:,j) = eke_h2(85,19,18,j).*eke_h2(:,:,18,j);
phicovar_h2(:,:,j) = phied_h2(85,19,8,j).*phied_h2(:,:,18,j);
ekephicovar_h2(:,:,j) = eke_h2(85,19,18,j).*phied_h2(:,:,18,j);
end

for j=1:359
ekelag1_h1(:,:,j) = eke_h1(85,19,18,j+1).*eke_h1(:,:,18,j);
philag1_h1(:,:,j) = phied_h1(85,19,8,j+1).*phied_h1(:,:,8,j);
ekephilag1_h1(:,:,j) = eke_h1(85,19,18,j+1).*phied_h1(:,:,8,j);
ekelag1_h2(:,:,j) = eke_h2(85,19,18,j+1).*eke_h2(:,:,18,j);
philag1_h2(:,:,j) = phied_h2(85,19,8,j+1).*phied_h2(:,:,8,j);
ekephilag1_h2(:,:,j) = eke_h2(85,19,18,j+1).*phied_h2(:,:,8,j);
end

for j=1:358
ekelag2_h1(:,:,j) = eke_h1(85,19,18,j+2).*eke_h1(:,:,18,j);
philag2_h1(:,:,j) = phied_h1(85,19,8,j+2).*phied_h1(:,:,8,j);
ekephilag2_h1(:,:,j) = eke_h1(85,19,18,j+2).*phied_h1(:,:,8,j);
ekelag2_h2(:,:,j) = eke_h2(85,19,18,j+2).*eke_h2(:,:,18,j);
philag2_h2(:,:,j) = phied_h2(85,19,8,j+2).*phied_h2(:,:,8,j);
ekephilag2_h2(:,:,j) = eke_h2(85,19,18,j+2).*phied_h2(:,:,8,j);
end

for j=1:357
ekelag3_h1(:,:,j) = eke_h1(85,19,18,j+3).*eke_h1(:,:,18,j);
philag3_h1(:,:,j) = phied_h1(85,19,8,j+3).*phied_h1(:,:,8,j);
ekephilag3_h1(:,:,j) = eke_h1(85,19,18,j+3).*phied_h1(:,:,8,j);
ekelag3_h2(:,:,j) = eke_h2(85,19,18,j+3).*eke_h2(:,:,18,j);
philag3_h2(:,:,j) = phied_h2(85,19,8,j+3).*phied_h2(:,:,8,j);
ekephilag3_h2(:,:,j) = eke_h2(85,19,18,j+3).*phied_h2(:,:,8,j);
end

ekemcovar = (mean(ekecovar_h1,3) + mean(ekecovar_h2,3))./2;
phimcovar = (mean(phicovar_h1,3) + mean(phicovar_h2,3))./2;
ekephimcovar = (mean(ekephicovar_h1,3) + mean(ekephicovar_h2,3))./2;

ekemlag1 = (mean(ekelag1_h1,3) + mean(ekelag1_h2,3))./2;
phimlag1 = (mean(philag1_h1,3) + mean(philag1_h2,3))./2;
ekephimlag1 = (mean(ekephilag1_h1,3) + mean(ekephilag1_h2,3))./2;

ekemlag2 = (mean(ekelag2_h1,3) + mean(ekelag2_h2,3))./2;
phimlag2 = (mean(philag2_h1,3) + mean(philag2_h2,3))./2;
ekephimlag2 = (mean(ekephilag2_h1,3) + mean(ekephilag2_h2,3))./2;

ekemlag3 = (mean(ekelag3_h1,3) + mean(ekelag3_h2,3))./2;
phimlag3 = (mean(philag3_h1,3) + mean(philag3_h2,3))./2;
ekephimlag3 = (mean(ekephilag3_h1,3) + mean(ekephilag3_h2,3))./2;

[C,h] = contourf(xi,yi(46:90),phimcovar'./phimcovar(85,19));
xlabel('Longitude');
ylabel('Latitude');
colorbar;
title('phi Covariance');
hold on
plot(-11,37,'xk','MarkerSize',20','LineWidth',3)
hold off
print('-dpng','phicovar.png');

v = -2:0.4:2.4;
[C,h] = contourf(xi,yi(46:90),ekephimcovar'./ekephimcovar(85,19),v);
xlabel('Longitude');
ylabel('Latitude');
colorbar;
caxis([-2 2.4]);
title('Covariance between EKE at 300hPa and Phi at 300hPa');
hold on
plot(-11,37,'xk','MarkerSize',20','LineWidth',3)
hold off
print('-dpng','ekephicovar.png');

v = -2:0.4:2.4;
[C,h] = contourf(xi,yi(46:90),ekephimlag1'./ekephimcovar(85,19),v);
xlabel('Longitude');
ylabel('Latitude');
colorbar;
caxis([-2 2.4]);
title('Lag covariance between EKE at 300hPa and Phi (1 day before) at 300hPa');
hold on
plot(-11,37,'xk','MarkerSize',20','LineWidth',3)
hold off
print('-dpng','ekephilag1.png');

v = -2:0.4:2.4;
[C,h] = contourf(xi,yi(46:90),ekephimlag2'./ekephimcovar(85,19),v);
xlabel('Longitude');
ylabel('Latitude');
colorbar;
caxis([-2 2.4]);
title('Lag covariance between EKE at 300hPa and Phi (2 days before) at 300hPa');
hold on
plot(-11,37,'xk','MarkerSize',20','LineWidth',3)
hold off
print('-dpng','ekephilag2.png');

v = -2:0.4:2.4;
[C,h] = contourf(xi,yi(46:90),ekephimlag3'./ekephimcovar(85,19),v);
xlabel('Longitude');
ylabel('Latitude');
colorbar;
caxis([-2 2.4]);
title('Lag covariance between EKE at 300hPa and Phi (3 days before) at 300hPa');
hold on
plot(-11,37,'xk','MarkerSize',20','LineWidth',3)
hold off
print('-dpng','ekephilag3.png');
