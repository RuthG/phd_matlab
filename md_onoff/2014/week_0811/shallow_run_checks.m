%load in data from shallow fixed rad run.
%check transmittances are correct etc etc.


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
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

%read fields
i=0;
for nit = 259200:86400:432000;
i=i+1
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'AtPhTrLW'));
trlw(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhTrSW'));
trsw(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhTrWI'));
trwi(:,:,:,i) = dyn(:,:,:,J);

end

[trlw_zav,mskzon,ylat,areazon]=calcZonalAvgCube(trlw,ny,yc,ar,hc);
[trsw_zav,mskzon,ylat,areazon]=calcZonalAvgCube(trsw,ny,yc,ar,hc);
[trwi_zav,mskzon,ylat,areazon]=calcZonalAvgCube(trwi,ny,yc,ar,hc);
