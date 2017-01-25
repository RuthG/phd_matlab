%Correlate EKE at peak with W at 700mb

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

%Load up 20 days EKE data and W data

i=0;
for nit = 605040:240:691200
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'WVEL    '));
w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSQ  '));
vsq(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELSQ  '));
usq(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

end

%Calculate EKE and W on lat-lon grid

ke = usq + vsq;

xi=-179:2:180;yi=-89:2:90;
kell=single(cube2latlon(xc,yc,ke,xi,yi));
wll = single(cube2latlon(xc,yc,w,xi,yi));

[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE,ny,yc,ar,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN,ny,yc,ar,hc);
[w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w,ny,yc,ar,hc);

for i=1:180
ketemp(:,:,:) = kell(i,:,:,:);
wtemp(:,:,:) = wll(i,:,:,:);
eke(i,:,:,:) = ketemp - uE_zav.^2 - vN_zav.^2;
wed(i,:,:,:) = wtemp - w_zav;
end

%Split into 2 hemispheres to get more data for avs
eke_h1 = eke(:,46:90,:,:);
eke_h2 = flipdim(eke(:,1:45,:,:),2);
wed_h1 = wed(:,46:90,:,:);
wed_h2 = flipdim(wed(:,1:45,:,:),2);

% <(EKE)(W')>
% Want to find correlations between EKE and lower level w. Likely to be shifted in space and time. 

%Work up to it. First Correlate EKE at one point with EKE at other points

for j=1:360
ekecovar_h1(:,:,j) = eke_h1(85,19,18,j).*eke_h1(:,:,18,j);
wcovar_h1(:,:,j) = wed_h1(85,19,8,j).*wed_h1(:,:,8,j);
ekewcovar_h1(:,:,j) = eke_h1(85,19,18,j).*wed_h1(:,:,8,j);
ekecovar_h2(:,:,j) = eke_h2(85,19,18,j).*eke_h2(:,:,18,j);
wcovar_h2(:,:,j) = wed_h2(85,19,8,j).*wed_h2(:,:,8,j);
ekewcovar_h2(:,:,j) = eke_h2(85,19,18,j).*wed_h2(:,:,8,j);
end

for j=1:359
ekelag1_h1(:,:,j) = eke_h1(85,19,18,j+1).*eke_h1(:,:,18,j);
wlag1_h1(:,:,j) = wed_h1(85,19,8,j+1).*wed_h1(:,:,8,j);
ekewlag1_h1(:,:,j) = eke_h1(85,19,18,j+1).*wed_h1(:,:,8,j);
ekelag1_h2(:,:,j) = eke_h2(85,19,18,j+1).*eke_h2(:,:,18,j);
wlag1_h2(:,:,j) = wed_h2(85,19,8,j+1).*wed_h2(:,:,8,j);
ekewlag1_h2(:,:,j) = eke_h2(85,19,18,j+1).*wed_h2(:,:,8,j);
end

for j=1:358
ekelag2_h1(:,:,j) = eke_h1(85,19,18,j+2).*eke_h1(:,:,18,j);
wlag2_h1(:,:,j) = wed_h1(85,19,8,j+2).*wed_h1(:,:,8,j);
ekewlag2_h1(:,:,j) = eke_h1(85,19,18,j+2).*wed_h1(:,:,8,j);
ekelag2_h2(:,:,j) = eke_h2(85,19,18,j+2).*eke_h2(:,:,18,j);
wlag2_h2(:,:,j) = wed_h2(85,19,8,j+2).*wed_h2(:,:,8,j);
ekewlag2_h2(:,:,j) = eke_h2(85,19,18,j+2).*wed_h2(:,:,8,j);
end

for j=1:357
ekelag3_h1(:,:,j) = eke_h1(85,19,18,j+3).*eke_h1(:,:,18,j);
wlag3_h1(:,:,j) = wed_h1(85,19,8,j+3).*wed_h1(:,:,8,j);
ekewlag3_h1(:,:,j) = eke_h1(85,19,18,j+3).*wed_h1(:,:,8,j);
ekelag3_h2(:,:,j) = eke_h2(85,19,18,j+3).*eke_h2(:,:,18,j);
wlag3_h2(:,:,j) = wed_h2(85,19,8,j+3).*wed_h2(:,:,8,j);
ekewlag3_h2(:,:,j) = eke_h2(85,19,18,j+3).*wed_h2(:,:,8,j);
end

for j=1:356
ekelag4_h1(:,:,j) = eke_h1(85,19,18,j+4).*eke_h1(:,:,18,j);
wlag4_h1(:,:,j) = wed_h1(85,19,8,j+4).*wed_h1(:,:,8,j);
ekewlag4_h1(:,:,j) = eke_h1(85,19,18,j+4).*wed_h1(:,:,8,j);
ekelag4_h2(:,:,j) = eke_h2(85,19,18,j+4).*eke_h2(:,:,18,j);
wlag4_h2(:,:,j) = wed_h2(85,19,8,j+4).*wed_h2(:,:,8,j);
ekewlag4_h2(:,:,j) = eke_h2(85,19,18,j+4).*wed_h2(:,:,8,j);
end

for j=1:355
ekelag5_h1(:,:,j) = eke_h1(85,19,18,j+5).*eke_h1(:,:,18,j);
wlag5_h1(:,:,j) = wed_h1(85,19,8,j+5).*wed_h1(:,:,8,j);
ekewlag5_h1(:,:,j) = eke_h1(85,19,18,j+5).*wed_h1(:,:,8,j);
ekelag5_h2(:,:,j) = eke_h2(85,19,18,j+5).*eke_h2(:,:,18,j);
wlag5_h2(:,:,j) = wed_h2(85,19,8,j+5).*wed_h2(:,:,8,j);
ekewlag5_h2(:,:,j) = eke_h2(85,19,18,j+5).*wed_h2(:,:,8,j);
end

for j=1:354
ekelag6_h1(:,:,j) = eke_h1(85,19,18,j+6).*eke_h1(:,:,18,j);
wlag6_h1(:,:,j) = wed_h1(85,19,8,j+6).*wed_h1(:,:,8,j);
ekewlag6_h1(:,:,j) = eke_h1(85,19,18,j+6).*wed_h1(:,:,8,j);
ekelag6_h2(:,:,j) = eke_h2(85,19,18,j+6).*eke_h2(:,:,18,j);
wlag6_h2(:,:,j) = wed_h2(85,19,8,j+6).*wed_h2(:,:,8,j);
ekewlag6_h2(:,:,j) = eke_h2(85,19,18,j+6).*wed_h2(:,:,8,j);
end

for j=1:353
ekelag7_h1(:,:,j) = eke_h1(85,19,18,j+7).*eke_h1(:,:,18,j);
wlag7_h1(:,:,j) = wed_h1(85,19,8,j+7).*wed_h1(:,:,8,j);
ekewlag7_h1(:,:,j) = eke_h1(85,19,18,j+7).*wed_h1(:,:,8,j);
ekelag7_h2(:,:,j) = eke_h2(85,19,18,j+7).*eke_h2(:,:,18,j);
wlag7_h2(:,:,j) = wed_h2(85,19,8,j+7).*wed_h2(:,:,8,j);
ekewlag7_h2(:,:,j) = eke_h2(85,19,18,j+7).*wed_h2(:,:,8,j);
end

for j=1:352
ekelag8_h1(:,:,j) = eke_h1(85,19,18,j+8).*eke_h1(:,:,18,j);
wlag8_h1(:,:,j) = wed_h1(85,19,8,j+8).*wed_h1(:,:,8,j);
ekewlag8_h1(:,:,j) = eke_h1(85,19,18,j+8).*wed_h1(:,:,8,j);
ekelag8_h2(:,:,j) = eke_h2(85,19,18,j+8).*eke_h2(:,:,18,j);
wlag8_h2(:,:,j) = wed_h2(85,19,8,j+8).*wed_h2(:,:,8,j);
ekewlag8_h2(:,:,j) = eke_h2(85,19,18,j+8).*wed_h2(:,:,8,j);
end

for j=1:351
ekelag9_h1(:,:,j) = eke_h1(85,19,18,j+9).*eke_h1(:,:,18,j);
wlag9_h1(:,:,j) = wed_h1(85,19,8,j+9).*wed_h1(:,:,8,j);
ekewlag9_h1(:,:,j) = eke_h1(85,19,18,j+9).*wed_h1(:,:,8,j);
ekelag9_h2(:,:,j) = eke_h2(85,19,18,j+9).*eke_h2(:,:,18,j);
wlag9_h2(:,:,j) = wed_h2(85,19,8,j+9).*wed_h2(:,:,8,j);
ekewlag9_h2(:,:,j) = eke_h2(85,19,18,j+9).*wed_h2(:,:,8,j);
end

for j=1:350
ekelag10_h1(:,:,j) = eke_h1(85,19,18,j+10).*eke_h1(:,:,18,j);
wlag10_h1(:,:,j) = wed_h1(85,19,8,j+10).*wed_h1(:,:,8,j);
ekewlag10_h1(:,:,j) = eke_h1(85,19,18,j+10).*wed_h1(:,:,8,j);
ekelag10_h2(:,:,j) = eke_h2(85,19,18,j+10).*eke_h2(:,:,18,j);
wlag10_h2(:,:,j) = wed_h2(85,19,8,j+10).*wed_h2(:,:,8,j);
ekewlag10_h2(:,:,j) = eke_h2(85,19,18,j+10).*wed_h2(:,:,8,j);
end

ekemcovar = (mean(ekecovar_h1,3) + mean(ekecovar_h2,3))./2;
wmcovar = (mean(wcovar_h1,3) + mean(wcovar_h2,3))./2;
ekewmcovar = (mean(ekewcovar_h1,3) + mean(ekewcovar_h2,3))./2;

ekemlag1 = (mean(ekelag1_h1,3) + mean(ekelag1_h2,3))./2;
wmlag1 = (mean(wlag1_h1,3) + mean(wlag1_h2,3))./2;
ekewmlag1 = (mean(ekewlag1_h1,3) + mean(ekewlag1_h2,3))./2;

ekemlag2 = (mean(ekelag2_h1,3) + mean(ekelag2_h2,3))./2;
wmlag2 = (mean(wlag2_h1,3) + mean(wlag2_h2,3))./2;
ekewmlag2 = (mean(ekewlag2_h1,3) + mean(ekewlag2_h2,3))./2;

ekemlag3 = (mean(ekelag3_h1,3) + mean(ekelag3_h2,3))./2;
wmlag3 = (mean(wlag3_h1,3) + mean(wlag3_h2,3))./2;
ekewmlag3 = (mean(ekewlag3_h1,3) + mean(ekewlag3_h2,3))./2;

ekemlag4 = (mean(ekelag4_h1,3) + mean(ekelag4_h2,3))./2;
wmlag4 = (mean(wlag4_h1,3) + mean(wlag4_h2,3))./2;
ekewmlag4 = (mean(ekewlag4_h1,3) + mean(ekewlag4_h2,3))./2;

ekemlag5 = (mean(ekelag5_h1,3) + mean(ekelag5_h2,3))./2;
wmlag5 = (mean(wlag5_h1,3) + mean(wlag5_h2,3))./2;
ekewmlag5 = (mean(ekewlag5_h1,3) + mean(ekewlag5_h2,3))./2;

ekemlag6 = (mean(ekelag6_h1,3) + mean(ekelag6_h2,3))./2;
wmlag6 = (mean(wlag6_h1,3) + mean(wlag6_h2,3))./2;
ekewmlag6 = (mean(ekewlag6_h1,3) + mean(ekewlag6_h2,3))./2;

ekemlag7 = (mean(ekelag7_h1,3) + mean(ekelag7_h2,3))./2;
wmlag7 = (mean(wlag7_h1,3) + mean(wlag7_h2,3))./2;
ekewmlag7 = (mean(ekewlag7_h1,3) + mean(ekewlag7_h2,3))./2;

ekemlag8 = (mean(ekelag8_h1,3) + mean(ekelag8_h2,3))./2;
wmlag8 = (mean(wlag8_h1,3) + mean(wlag8_h2,3))./2;
ekewmlag8 = (mean(ekewlag8_h1,3) + mean(ekewlag8_h2,3))./2;

ekemlag9 = (mean(ekelag9_h1,3) + mean(ekelag9_h2,3))./2;
wmlag9 = (mean(wlag9_h1,3) + mean(wlag9_h2,3))./2;
ekewmlag9 = (mean(ekewlag9_h1,3) + mean(ekewlag9_h2,3))./2;

ekemlag10 = (mean(ekelag10_h1,3) + mean(ekelag10_h2,3))./2;
wmlag10 = (mean(wlag10_h1,3) + mean(wlag10_h2,3))./2;
ekewmlag10 = (mean(ekewlag10_h1,3) + mean(ekewlag10_h2,3))./2;


[C,h] = contourf(xi,yi(46:90),wmcovar'./wmcovar(85,19));
xlabel('Longitude');
ylabel('Latitude');
colorbar;
title('W Covariance');
hold on
plot(-11,37,'xk','MarkerSize',20','LineWidth',3)
hold off
print('-dpng','wcovar.png');

[C,h] = contourf(xi,yi(46:90),ekemcovar'./ekemcovar(85,19));
xlabel('Longitude');
ylabel('Latitude');
colorbar;
title('EKE Covariance');
hold on
plot(-11,37,'xk','MarkerSize',20','LineWidth',3)
hold off
print('-dpng','ekecovar.png');

v = -7:1:7;
[C,h] = contourf(xi,yi(46:90),ekewmcovar'./ekewmcovar(85,19),v);
xlabel('Longitude');
ylabel('Latitude');
colorbar;
caxis([-7 7]);
title('Covariance between EKE at 300hPa and W at 700hPa');
hold on
plot(-11,37,'xk','MarkerSize',20','LineWidth',3)
hold off
print('-dpng','ekewcovar.png');

v = -7:1:7;
[C,h] = contourf(xi,yi(46:90),ekewmlag1'./ekewmcovar(85,19),v);
xlabel('Longitude');
ylabel('Latitude');
colorbar;
caxis([-7 7]);
title('Lag covariance between EKE at 300hPa and W (1 day before) at 700hPa');
hold on
plot(-11,37,'xk','MarkerSize',20','LineWidth',3)
hold off
print('-dpng','ekewlag1.png');

v = -7:1:7;
[C,h] = contourf(xi,yi(46:90),ekewmlag2'./ekewmcovar(85,19),v);
xlabel('Longitude');
ylabel('Latitude');
colorbar;
caxis([-7 7]);
title('Lag covariance between EKE at 300hPa and W (2 days before) at 700hPa');
hold on
plot(-11,37,'xk','MarkerSize',20','LineWidth',3)
hold off
print('-dpng','ekewlag2.png');

v = -7:1:7;
[C,h] = contourf(xi,yi(46:90),ekewmlag3'./ekewmcovar(85,19),v);
xlabel('Longitude');
ylabel('Latitude');
colorbar;
caxis([-7 7]);
title('Lag covariance between EKE at 300hPa and W (3 days before) at 700hPa');
hold on
plot(-11,37,'xk','MarkerSize',20','LineWidth',3)
hold off
print('-dpng','ekewlag3.png');

v = -7:1:7;
[C,h] = contourf(xi,yi(46:90),ekewmlag4'./ekewmcovar(85,19),v);
xlabel('Longitude');
ylabel('Latitude');
colorbar;
caxis([-7 7]);
title('Lag covariance between EKE at 300hPa and W (4 days before) at 700hPa');
hold on
plot(-11,37,'xk','MarkerSize',20','LineWidth',3)
hold off
print('-dpng','ekewlag4.png');

v = -7:1:7;
[C,h] = contourf(xi,yi(46:90),ekewmlag5'./ekewmcovar(85,19),v);
xlabel('Longitude');
ylabel('Latitude');
colorbar;
caxis([-7 7]);
title('Lag covariance between EKE at 300hPa and W (5 days before) at 700hPa');
hold on
plot(-11,37,'xk','MarkerSize',20','LineWidth',3)
hold off
print('-dpng','ekewlag5.png');

v = -7:1:7;
[C,h] = contourf(xi,yi(46:90),ekewmlag6'./ekewmcovar(85,19),v);
xlabel('Longitude');
ylabel('Latitude');
colorbar;
caxis([-7 7]);
title('Lag covariance between EKE at 300hPa and W (6 days before) at 700hPa');
hold on
plot(-11,37,'xk','MarkerSize',20','LineWidth',3)
hold off
print('-dpng','ekewlag6.png');

v = -7:1:7;
[C,h] = contourf(xi,yi(46:90),ekewmlag7'./ekewmcovar(85,19),v);
xlabel('Longitude');
ylabel('Latitude');
colorbar;
caxis([-7 7]);
title('Lag covariance between EKE at 300hPa and W (7 days before) at 700hPa');
hold on
plot(-11,37,'xk','MarkerSize',20','LineWidth',3)
hold off
print('-dpng','ekewlag7.png');

v = -7:1:7;
[C,h] = contourf(xi,yi(46:90),ekewmlag8'./ekewmcovar(85,19),v);
xlabel('Longitude');
ylabel('Latitude');
colorbar;
caxis([-7 7]);
title('Lag covariance between EKE at 300hPa and W (8 days before) at 700hPa');
hold on
plot(-11,37,'xk','MarkerSize',20','LineWidth',3)
hold off
print('-dpng','ekewlag8.png');

v = -7:1:7;
[C,h] = contourf(xi,yi(46:90),ekewmlag9'./ekewmcovar(85,19),v);
xlabel('Longitude');
ylabel('Latitude');
colorbar;
caxis([-7 7]);
title('Lag covariance between EKE at 300hPa and W (9 days before) at 700hPa');
hold on
plot(-11,37,'xk','MarkerSize',20','LineWidth',3)
hold off
print('-dpng','ekewlag9.png');

v = -7:1:7;
[C,h] = contourf(xi,yi(46:90),ekewmlag10'./ekewmcovar(85,19),v);
xlabel('Longitude');
ylabel('Latitude');
colorbar;
caxis([-7 7]);
title('Lag covariance between EKE at 300hPa and W (10 days before) at 700hPa');
hold on
plot(-11,37,'xk','MarkerSize',20','LineWidth',3)
hold off
print('-dpng','ekewlag10.png');
