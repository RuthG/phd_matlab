%check the momentum terms being output, try to check we get everything


% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_updates_080515/';
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

nit = 167040;

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
uvel = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vvel = dyn(:,:,:,J);

J=find(strcmp(fldList,'SALT    '));
q = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta = dyn(:,:,:,J);

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPh_SST'));
sst = surf(:,:,J);

[AtPh,iter,M]=rdmds([rDir,'AtPhDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhTrLW'));
trlw = AtPh(:,:,:,J);
J=find(strcmp(fldList,'AtPhTrSW'));
trsw = AtPh(:,:,:,J);
J=find(strcmp(fldList,'AtPhTrWI'));
trwi = AtPh(:,:,:,J);

[uE,vN] = rotate_uv2uvEN(uvel,vvel,AngleCS,AngleSN,Grid);

uE_ll = cube2latlon(xc,yc,uE,xi,yi);
vN_ll = cube2latlon(xc,yc,vN,xi,yi);
theta_ll = cube2latlon(xc,yc,theta,xi,yi);
q_ll = cube2latlon(xc,yc,q,xi,yi);
trlw_ll = cube2latlon(xc,yc,trlw,xi,yi);
trsw_ll = cube2latlon(xc,yc,trsw,xi,yi);
trwi_ll = cube2latlon(xc,yc,trwi,xi,yi);
sst_ll = cube2latlon(xc,yc,sst,xi,yi);

return


