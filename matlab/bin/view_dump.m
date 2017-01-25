%view_dump.m
%function to plot dump for a given time step

function out = view_dump(nit);

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

%subplot(2,3,1)
eta=rdmds([rDir,'Eta'],nit);
[fldzon,mskzon,ylat,areazon]=calcZonalAvgCube(eta,ny,yc,ar,hc);
plot(ylat,fldzon)
xlabel('Latitude')
ylabel('Surface Pressure, Pa')
%name=['eta_dump' num2str(nit) '.png']
%print('-dpng',name) 

subplot(3,2,1)
q=rdmds([rDir,'S'],nit);
[fldzon,mskzon,ylat,areazon]=calcZonalAvgCube(q,ny,yc,ar,hc);
[C,h]=contourf(ylat,rC,fldzon',20);
%set(h,'edgecolor','none')
colorbar
set(gca,'YDir','reverse')
%%set(gca,'YScale','log')
xlabel('Latitude')
ylabel('Pressure, Pa')
%name=['q_dump' num2str(nit) '.png']
%print('-dpng',name) 

subplot(3,2,2)
ucs=rdmds([rDir,'U'],nit);
vcs=rdmds([rDir,'V'],nit);
[uE,vN] = rotate_uv2uvEN(ucs,vcs,AngleCS,AngleSN,Grid);
[fldzon,mskzon,ylat,areazon]=calcZonalAvgCube(vN,ny,yc,ar,hc);
[C,h]=contourf(ylat,rC,fldzon',20);
%set(h,'edgecolor','none')
colorbar
set(gca,'YDir','reverse')
%%set(gca,'YScale','log')
xlabel('Latitude')
ylabel('Pressure, Pa')
%name=['vN_dump' num2str(nit) '.png']
%print('-dpng',name) 

subplot(3,2,3)
[fldzon,mskzon,ylat,areazon]=calcZonalAvgCube(uE,ny,yc,ar,hc);
[C,h]=contourf(ylat,rC,fldzon',20);
%set(h,'edgecolor','none')
colorbar
set(gca,'YDir','reverse')
%%set(gca,'YScale','log')
xlabel('Latitude')
ylabel('Pressure, Pa')
%name=['uE_dump' num2str(nit) '.png']
%print('-dpng',name) 

subplot(3,2,4)
w=rdmds([rDir,'W'],nit);
[fldzon,mskzon,ylat,areazon]=calcZonalAvgCube(w,ny,yc,ar,hc);
[C,h]=contourf(ylat,rC,fldzon',20);
%set(h,'edgecolor','none')
colorbar
set(gca,'YDir','reverse')
%%set(gca,'YScale','log')
xlabel('Latitude')
ylabel('Pressure, Pa')
%name=['W_dump' num2str(nit) '.png']
%print('-dpng',name) 

subplot(3,2,5)
t=rdmds([rDir,'T'],nit);
[fldzon,mskzon,ylat,areazon]=calcZonalAvgCube(t,ny,yc,ar,hc);
[C,h]=contourf(ylat,rC,fldzon',20);
%set(h,'edgecolor','none')
colorbar
set(gca,'YDir','reverse')
%%set(gca,'YScale','log')
xlabel('Latitude')
ylabel('Pressure, Pa')
%name=['t_dump' num2str(nit) '.png']
%print('-dpng',name) 

subplot(3,2,6)
convthetatoT=(rC/rC(1)).^(2./7.);
for j=1:size(rC)
realt(:,j)=fldzon(:,j)*convthetatoT(j);
end
[C,h]=contourf(ylat,rC,realt',20);
%set(h,'edgecolor','none')
colorbar
set(gca,'YDir','reverse')
%%set(gca,'YScale','log')
xlabel('Latitude')
ylabel('Pressure, Pa')

name=['Dump' num2str(nit) '.png']
print('-dpng',name) 

out = 0.
