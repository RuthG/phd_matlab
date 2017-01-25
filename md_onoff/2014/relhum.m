%calculate relative humidity

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_wvspinup/';

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
load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/means_firstten.mat')
load('/disk1/MITgcm/verification/atm_gray_ruth/md_offoff/means_ctrl.mat')

Rd = 287.04;
Rv = 461.5;
Lv = 2.5e6;
T0 = 273.16;
e0 = 610.78;


for i=1:10
for j=1:25
q_sat(:,:,j) = Rd./(Rv.*rC(j)).*e0.*exp(-Lv./Rv.*(1./temp_firstten(:,:,j,i) - 1./T0));
end
RH(:,:,:,i) = q_firstten(:,:,:,i)./q_sat;
[RH_zav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(RH(:,:,:,i),ny,yc,ar,hc);

for k=1:45
RH_hzav(46-k,:,i) = (RH_zav(k,:,i) + RH_zav(91-k,:,i))./2.;
end

v=0:0.1:2;
[C,h]=contourf(ylat(46:90),rC,RH_hzav(:,:,i)',v);
colorbar
caxis([0 2])
xlabel('Latitude')
ylabel('Pressure, Pa')
title(['Day' num2str(i)]);
set(gca,'YDir','reverse')
print('-dpng',['/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/pngs/relhum_day' num2str(i) '.png'])
end


[RH_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(RH,ny,yc,ar,hc);

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/means_ctrl.mat')

for i=1:25
q_sat(:,:,i) = Rd./(Rv.*rC(i)).*e0.*exp(-Lv./Rv.*(1./temp_ctrl_mean(:,:,i,1) - 1./T0));
end
RH_ctrl_mean = q_ctrl_mean(:,:,:)./q_sat;
[RH_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(RH_ctrl_mean,ny,yc,ar,hc);

for k=1:45
RH_hzav_c(46-k,:) = (RH_zav_c(k,:) + RH_zav_c(91-k,:))./2.;
end

[C,h]=contourf(ylat(46:90),rC,RH_hzav_c',v);
colorbar
caxis([0 2])
xlabel('Latitude')
ylabel('Pressure, Pa')
title(['Equilibrium']);
set(gca,'YDir','reverse')
print('-dpng',['/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/pngs/relhum_mean.png'])
