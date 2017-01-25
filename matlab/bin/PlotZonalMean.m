%PlotZonalMean.m
%Plot zonal mean MITgcm results

%Read in iteration number, directory, MITgcm output and grid details

nit=518400;
rDir='./';

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

eta=rdmds([rDir,'Eta'],nit);
q=rdmds([rDir,'S'],nit);
ucs=rdmds([rDir,'U'],nit);
vcs=rdmds([rDir,'V'],nit);
w=rdmds([rDir,'W'],nit);
ph=rdmds([rDir,'PH'],nit);
t=rdmds([rDir,'T'],nit);

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);
eval(M);
J=find(strcmp(fldList,'AtPhTauX'));
taux=surf(:,:,J);

J=find(strcmp(fldList,'AtPhTauY'));
tauy=surf(:,:,J);

J=find(strcmp(fldList,'AtPhInSR'));
swin=surf(:,:,J);

J=find(strcmp(fldList,'AtPhOLR '));
lwout=surf(:,:,J);

J=find(strcmp(fldList,'AtPhNSSR'));
s_sw_dwn=surf(:,:,J);

J=find(strcmp(fldList,'AtPhDSLR'));
s_lw_dwn=surf(:,:,J);

J=find(strcmp(fldList,'AtPhUSLR'));
flux_r=surf(:,:,J);

J=find(strcmp(fldList,'MYPaCprc'));
J=find(strcmp(fldList,'AtPhCnvP'));
convPrec=surf(:,:,J);
J=find(strcmp(fldList,'MYPaLprc'));
J=find(strcmp(fldList,'AtPhLscP'));
lscPrec=surf(:,:,J);

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'AtPhLWD '));
lwd=dyn(:,:,:,J);

J=find(strcmp(fldList,'AtPhSWD '));
swd=dyn(:,:,:,J);

J=find(strcmp(fldList,'AtPhLWN '));
lwn=dyn(:,:,:,J);

J=find(strcmp(fldList,'AtPhSWN '));
swn=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdt'));
htrt=dyn(:,:,:,J);
J=find(strcmp(fldList,'UDIAG1  '));
lwht=dyn(:,:,:,J);
J=find(strcmp(fldList,'UDIAG2  '));
cnvht=dyn(:,:,:,J);
J=find(strcmp(fldList,'UDIAG3  '));
cndht=dyn(:,:,:,J);
J=find(strcmp(fldList,'UDIAG4  '));
difht=dyn(:,:,:,J);

Grid='C';
[uE,vN] = rotate_uv2uvEN(ucs,vcs,AngleCS,AngleSN,Grid);

[fldzon,mskzon,ylat,areazon]=calcZonalAvgCube(difht,ny,yc,ar,hc);

%plot(ylat,fldzon)
%xlabel('Latitude')
%ylabel('Surface LW Up')


[C,h]=contourf(ylat,rC,fldzon',15);
colorbar
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, Pa')

return

var=eta;
k=8;
figure(1);clf;
%var=uE(:,:,k);
%var=q(:,:,k);
%var(:,:,1)=lscPrec;
%subplot(211);

var=vN(:,:,k);
%var(:,:,1)=convPrec;
subplot(212);
%title(['wind @ k= ',int2str(k)]);

