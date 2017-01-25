rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';
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
for nit = 605040:240:607200
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
ull = single(cube2latlon(xc,yc,uE,xi,yi));
vll = single(cube2latlon(xc,yc,vN,xi,yi));

[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE,ny,yc,ar,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN,ny,yc,ar,hc);

for i=1:180
ketemp(:,:,:) = kell(i,:,:,:);
eke(i,:,:,:) = ketemp - uE_zav.^2 - vN_zav.^2;
end

v=-20:4:60;
[C,h] = contourf(xi,yi,ull(:,:,20,1)',v);
set(h,'edgecolor','none')
caxis([-20 60])
colorbar
hold on
[C,h] = contour(xi,yi,eke(:,:,20,1)','k');
%clabel(C,h);
hold off
print('-dpng','eke_over_u_ll.png')

v=-30:2.5:25;
[C,h] = contourf(xi,yi,vll(:,:,20,1)',v);
set(h,'edgecolor','none')
caxis([-30 25])
colorbar
hold on
[C,h] = contour(xi,yi,eke(:,:,20,1)','k');
%clabel(C,h);
hold off
print('-dpng','eke_over_v_ll.png')

v=-30:2.5:25;
[C,h] = contourf(xi,yi,vll(:,:,20,1)',v);
set(h,'edgecolor','none')
caxis([-30 25])
colorbar
hold on
v=-20:5:60;
[C,h] = contour(xi,yi,ull(:,:,20,1)','k');
clabel(C,h);
hold off
print('-dpng','u_over_v_ll.png')
