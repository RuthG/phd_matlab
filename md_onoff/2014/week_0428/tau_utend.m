% load up tau and dUdt from atmphys, double check.

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';

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

%Load in U, V, UV, Tau

%read fields
i=0;
for nit = 259200:86400:604800;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdUdt'));
ducs_ctrl(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdVdt'));
dvcs_ctrl(:,:,:,i) = dyn(:,:,:,J);
[duE_ctrl(:,:,:,i),dvN_ctrl(:,:,:,i)] = rotate_uv2uvEN(ducs_ctrl(:,:,:,i),dvcs_ctrl(:,:,:,i),AngleCS,AngleSN,Grid);


[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhTauX'));
tauxcs_ctrl(:,:,i) = surf(:,:,J);
J=find(strcmp(fldList,'AtPhTauY'));
tauycs_ctrl(:,:,i) = surf(:,:,J);
[tauE_ctrl(:,:,i),tauN_ctrl(:,:,i)] = rotate_uv2uvEN(tauxcs_ctrl(:,:,i),tauycs_ctrl(:,:,i),AngleCS,AngleSN,Grid);

end

%Take zonal averages
[duE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(duE_ctrl,ny,yc,ar,hc);
[dvN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(dvN_ctrl,ny,yc,ar,hc);
[tauE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tauE_ctrl,ny,yc,ar,hc);
[tauN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tauN_ctrl,ny,yc,ar,hc);


duE_vint = sum(duE_zav.*4000,2)./9.81;


duE_mean = mean(duE_vint,3);
tauE_mean = mean(tauE_zav,2);
