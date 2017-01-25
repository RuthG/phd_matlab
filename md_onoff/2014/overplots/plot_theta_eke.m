rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%

i=0;
for nit = 259200:86400:604800;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'UVELSQ  '));
uucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSQ  '));
vvcs(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp(:,:,j,i)=theta(:,:,j,i).*convthetatoT(j,1);
end

end

%calculate local |v^2|
ke = uucs + vvcs;

%calculate zonal average of u, v, and |v^2|
[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE,ny,yc,ar,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN,ny,yc,ar,hc);
[ke_zav,mskzon,ylat,areazon]=calcZonalAvgCube(ke,ny,yc,ar,hc);
[theta_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta,ny,yc,ar,hc);
[temp_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp,ny,yc,ar,hc);

%calculate <v'^2> = <|v^2|> - <|v|>^2 (<> zon av)

eke_zav = ke_zav - uE_zav.^2 - vN_zav.^2;

%take time mean
eke_tzav = mean(eke_zav,3);
uE_tzav = mean(uE_zav,3);
theta_tzav = mean(theta_zav,3);
temp_tzav = mean(temp_zav,3);
for i=1:90
eke_wt(i,:) = eke_tzav(i,:).*cos(ylat(i).*pi./180);
end

v = 250:10:650;
[C,h] = contourf(ylat,rC,theta_tzav',v);
set(h,'edgecolor','none')
caxis([250 650])
colorbar
hold on
v = 0:40:400;
[C,h] = contour(ylat,rC,eke_tzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
hold off
print('-dpng','eke_over_theta.png')


figure
v = 200:5:300;
[C,h] = contourf(ylat,rC,temp_tzav',v);
set(h,'edgecolor','none')
caxis([200 300])
colorbar
hold on
v = 0:40:400;
[C,h] = contour(ylat,rC,eke_tzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
hold off
print('-dpng','eke_over_temp.png')
