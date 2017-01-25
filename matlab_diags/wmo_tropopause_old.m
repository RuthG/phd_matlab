%wmo_tropopause.m
%use wmo definition to locate tropopause

load('means_ctrl.mat')

rDir='./';
ny=90
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


[theta_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_ctrl_mean,ny,yc,ar,hc);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
realt(:,j)=theta_zav(:,j)*convthetatoT(j);
end

theta = true;
for i=1:90
z(i,:) = find_height(rC,theta_zav(i,:),theta);
end

z=z./1000;

for i=1:24
dz_half(:,i) = z(:,i+1) - z(:,i);
dt_half(:,i) = realt(:,i+1) - realt(:,i);
rC_half(i) = (rC(i) + rC(i+1))./2.;
end

for i=1:90
dz(i,:) = interp1(rC_half,dz_half(i,:),rC,'cubic','extrap');
dt(i,:) = interp1(rC_half,dt_half(i,:),rC,'cubic','extrap');
end

dtdz = dt./dz;

for i=1:90
trop(i) = rC(min(find((dtdz(i,:) >= -2))));
end

contourf(ylat,rC,dtdz',20)   
set(gca,'YDir','reverse')
colorbar
hold on
plot(ylat,trop)
hold off

ucs=rdmds([rDir,'uVeltave'],nit);
vcs=rdmds([rDir,'vVeltave'],nit);
[uE,vN] = rotate_uv2uvEN(ucs,vcs,AngleCS,AngleSN,Grid);

[fldzon,mskzon,ylat,areazon]=calcZonalAvgCube(uE,ny,yc,ar,hc);
[C,h]=contourf(ylat,rC,fldzon',20);
colorbar
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, Pa')
hold on
plot(ylat,trop)
hold off

print('Utrop.png','-dpng')

[fldzon,mskzon,ylat,areazon]=calcZonalAvgCube(vN,ny,yc,ar,hc);
[C,h]=contourf(ylat,rC,fldzon',20);
colorbar
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, Pa')
hold on
plot(ylat,trop)
hold off

print('Vtrop.png','-dpng')
