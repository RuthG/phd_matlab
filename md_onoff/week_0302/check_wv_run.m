%load in q data for a day, check mag looks ok


rDir='/project/rg312/MITgcm/verification/atm_gray_ruth/run/';
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
yi = -89:2:89;
xi = -179:2:179;

nit=172800;
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'SALT    '));
q = dyn(:,:,:,J);

q_ll = cube2latlon(xc,yc,q,xi,yi);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_dav = dyn(:,:,:,J);
htrt_dav_ll = cube2latlon(xc,yc,htrt_dav,xi,yi);

nit=172800;
[dyn,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt = dyn(:,:,:,J);
htrt_ll = cube2latlon(xc,yc,htrt,xi,yi);
