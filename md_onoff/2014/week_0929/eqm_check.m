%check if model is at equilibrium


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
drC=squeeze(rdmds([rDir,'DRC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
ny=90;

%read files
i=0;
for nit = 240:240:86400;

i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVELSQ  '));
uvelsq(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSQ  '));
vvelsq(:,:,:,i)=dyn(:,:,:,J);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);

end

eke = uvelsq + vvelsq - ucs.^2 - vcs.^2;

xi=-179:2:180;yi=-89:2:90;
ekell=cube2latlon(xc,yc,eke,xi,yi);

eke_zav(:,:,:) = mean(ekell,1);

eke_tseries = shiftdim(eke_zav(57,21,:),1);

