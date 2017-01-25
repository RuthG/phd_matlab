% sbdart_output.m
% read in sbdart output
% compare and plot sbdart and MITgcm longwave radiative fluxes, shortwave optical depths, and longwave, shortwave, and total heating rates

%Read in longwave sbdart output
output = dlmread('OUTPUT_LW_DOH');
z     = output(2:26,1);
p     = output(2:26,2);
fxdnlw  = output(2:26,3);
fxuplw  = output(2:26,4);
fxdirlw = output(2:26,5);
dfdzlw  = output(2:26,6);
heatlw  = output(2:26,7);

%Read in shortwave sbdart output
outputsw = dlmread('OUTPUT_SW_DOH');
fxdnsw  = outputsw(2:26,3);
fxupsw  = outputsw(2:26,4);
fxdirsw = outputsw(2:26,5);
dfdzsw  = outputsw(2:26,6);
heatsw  = outputsw(2:26,7);

heattot = heatsw + heatlw;

%Calculate net fluxes and total flux

fxnetlw = fxuplw - fxdnlw;
fxnetsw = fxupsw - fxdnsw;
fxnettot = fxnetlw + fxnetsw;

%Read in MITgcm data

%Grid
nit=69120*4;
rDir='/disk1/rg312/run_swlin/';
ny=91;
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

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

%LW downward flux
J=find(strcmp(fldList,'AtPhLWD '));
lwd=dyn(:,:,:,J);
[fldzon,mskzon,ylat,areazon]=calcZonalAvgCube(lwd,ny,yc,ar,hc);
mitlwd=fliplr(fldzon(46,:));

%LW net flux
J=find(strcmp(fldList,'AtPhLWN '));
lwn=dyn(:,:,:,J);
[fldzon,mskzon,ylat,areazon]=calcZonalAvgCube(lwn,ny,yc,ar,hc);
mitlwn=fliplr(fldzon(46,:));

%Radiative heating rate in K/day
J=find(strcmp(fldList,'UDIAG1  '));
mitht=dyn(:,:,:,J);
mitht=mitht*86400.;
[fldzon,mskzon,ylat,areazon]=calcZonalAvgCube(mitht,ny,yc,ar,hc);
mitheat=fliplr(fldzon(46,:));

%SW downward flux
J=find(strcmp(fldList,'AtPhSWD '));
swd=dyn(:,:,:,J);
[fldzon,mskzon,ylat,areazon]=calcZonalAvgCube(swd,ny,yc,ar,hc);
mitswd=fliplr(fldzon(46,:));

%SW net flux
J=find(strcmp(fldList,'AtPhSWN '));
swn=dyn(:,:,:,J);
[fldzon,mskzon,ylat,areazon]=calcZonalAvgCube(swn,ny,yc,ar,hc);
mitswn=fliplr(fldzon(46,:));

mitlwup = mitlwn + mitlwd;
mitswup = mitswn + mitswd;

mitnet = mitswn + mitlwn;

g=9.8;
rdgas=287.04;
kappa=2./7.;
cp = rdgas/kappa;

p_h=40:40:960;
for i=1:24
mitswheat(i) = 86400.*g*(mitswn(i+1)-mitswn(i))/(cp*4000.);
mitlwheat(i) = 86400.*g*(mitlwn(i+1)-mitlwn(i))/(cp*4000.);
checkheat(i) = 86400.*g*(mitnet(i+1)-mitnet(i))/(cp*4000.);
end

plot(mitswd,p)
set(gca,'YDir','reverse')
xlabel('Downward SW flux')
ylabel('Pressure')
name=['mitswd.png']
print('-dpng',name) 
plot(mitswup,p)
set(gca,'YDir','reverse')
xlabel('Upward SW flux')
ylabel('Pressure')
name=['mitswup.png']
print('-dpng',name) 
plot(mitswn,p)
set(gca,'YDir','reverse')
xlabel('Net SW flux')
ylabel('Pressure')
name=['mitswn.png']
print('-dpng',name) 
plot(fxdnsw,p,'r')
set(gca,'YDir','reverse')
xlabel('Downward SW flux')
ylabel('Pressure')
name=['fxdnsw.png']
print('-dpng',name) 
plot(fxnetsw,p,'r')
set(gca,'YDir','reverse')
xlabel('Net SW flux')
ylabel('Pressure')
name=['fxnetsw.png']
print('-dpng',name) 
plot(fxupsw,p,'r')
set(gca,'YDir','reverse')
xlabel('Upward SW flux')
ylabel('Pressure')
name=['fxupsw.png']
print('-dpng',name) 

hold off
plot(mitlwd,p)
hold on
plot(fxdnlw,p,'r')
set(gca,'YDir','reverse')
xlabel('Downward LW flux')
ylabel('Pressure')
name=['lwd_ms.png']
print('-dpng',name) 

hold off 
plot(mitlwup,p)
hold on
plot(fxuplw,p,'r')
set(gca,'YDir','reverse')
xlabel('Upward LW flux')
ylabel('Pressure')
name=['lwu_ms.png']
print('-dpng',name) 

hold off 
plot(mitlwn,p)
hold on
plot(fxnetlw,p,'r')
set(gca,'YDir','reverse')
xlabel('Net LW flux')
ylabel('Pressure')
name=['lwn_ms.png']
print('-dpng',name) 

hold off 
plot(checkheat,p_h)
hold on
plot(heattot,p,'r')
set(gca,'YDir','reverse')
xlabel('Radiative heating rate')
ylabel('Pressure')
name=['heat_ms.png']
print('-dpng',name) 

hold off 
plot(mitswheat,p_h)
hold on
plot(heatsw,p,'r')
set(gca,'YDir','reverse')
xlabel('SW heating rate')
ylabel('Pressure')
name=['swheat_ms.png']
print('-dpng',name) 

hold off 
plot(mitlwheat,p_h)
hold on
plot(heatlw,p,'r')
set(gca,'YDir','reverse')
xlabel('LW heating rate')
ylabel('Pressure')
name=['lwheat_ms.png']
print('-dpng',name) 

%Calculate solar tau from data and compare with our values

;tauso=0.2231;
;taus=tauso*(p/p(25)).^4;
taus=log(mitswd(1)./mitswd);

tausbdart=log(fxdnsw(1)./fxdnsw);

hold off
plot(taus,p)
hold on
plot(tausbdart,p,'r')
set(gca,'YDir','reverse')
xlabel('Solar optical depth')
ylabel('Pressure')
name=['sw_tau.png']
print('-dpng',name) 



