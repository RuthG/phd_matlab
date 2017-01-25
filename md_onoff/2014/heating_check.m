rDir='/disk1/MITgcm/verification/atm_gray_ruth/run/';
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

nit = 691440;

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhPERT'));
pert = dyn(:,:,:,J);

[dyn,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhTROP'));
trop = dyn(:,:,J);

[pert_zav,mskzon,ylat,areazon]=calcZonalAvgCube(pert,ny,yc,ar,hc);
[trop_zav,mskzon,ylat,areazon]=calcZonalAvgCube(trop,ny,yc,ar,hc);

xi=-179:2:180;yi=-89:2:90;
  pertll(:,:,:)=cube2latlon(xc,yc,pert(:,:,:),xi,yi);
