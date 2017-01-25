rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_accidentalcontrol/';

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

nit=691440;

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_newgrad/';
[dyn,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPh_SST'));
sst_ng = dyn(:,:,J);
[sst_zav(:,1),mskzon,ylat,areazon]=calcZonalAvgCube(sst_ng,ny,yc,ar,hc);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_newgrad2/';
[dyn,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPh_SST'));
sst_ng2 = dyn(:,:,J);
[sst_zav(:,2),mskzon,ylat,areazon]=calcZonalAvgCube(sst_ng2,ny,yc,ar,hc);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_tropheat/';
[dyn,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPh_SST'));
sst_th = dyn(:,:,J);
[sst_zav(:,3),mskzon,ylat,areazon]=calcZonalAvgCube(sst_th,ny,yc,ar,hc);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_tropheat2/';
[dyn,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPh_SST'));
sst_th2 = dyn(:,:,J);
[sst_zav(:,4),mskzon,ylat,areazon]=calcZonalAvgCube(sst_th2,ny,yc,ar,hc);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_tropheat3/';
[dyn,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPh_SST'));
sst_th3 = dyn(:,:,J);
[sst_zav(:,5),mskzon,ylat,areazon]=calcZonalAvgCube(sst_th3,ny,yc,ar,hc);


yy=ylat*90/60*pi/180;
sinyy=sin(yy);
sst_c=27*(1-sinyy.*sinyy);
sst_c(find(abs(ylat)>=60))=0;
sst_c=sst_c+273.15;
sst_zav(:,6) = sst_c;

plot(ylat,sst_zav(:,6));
hold on
plot(ylat,sst_zav(:,5),'r');
xlabel('Latitude')
ylabel('Temperature, K')
legend('control','tropheat');
print('-dpng','SST_tropheat3.png')

return
h = plot(ylat,sst_zav);
title('SSTs used')
xlabel('Latitude')
ylabel('Temperature, K')
legend(h,'newgrad','newgrad2','tropheat','tropheat2','tropheat3','control');
print('-dpng','SST_profs.png')

[a,sstgrad] = gradient(sst_zav,2.*pi./180);
h = plot(ylat,sstgrad);
title('Gradient of SSTs')
xlabel('Latitude')
ylabel('SST gradient, K/degree')
legend(h,'newgrad','newgrad2','tropheat','tropheat2','tropheat3','control');
print('-dpng','SST_grads.png')
