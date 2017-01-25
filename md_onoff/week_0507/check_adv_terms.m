%check the momentum terms being output, try to check we get everything


% choose directory, load grid
rDir='/project/rg312/MITgcm_updated/verification/atm_gray_ruth/run/';
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

nit = 240;

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'TOTTTEND'));
totttend = dyn(:,:,:,J);
J=find(strcmp(fldList,'TOTSTEND'));
totstend = dyn(:,:,:,J);
J=find(strcmp(fldList,'ADVr_TH '));
advr_th = dyn(:,:,:,J);
J=find(strcmp(fldList,'ADVx_TH '));
advx_th = dyn(:,:,:,J);
J=find(strcmp(fldList,'ADVy_TH '));
advy_th = dyn(:,:,:,J);
J=find(strcmp(fldList,'ADVr_SLT'));
advr_slt = dyn(:,:,:,J);
J=find(strcmp(fldList,'ADVx_SLT'));
advx_slt = dyn(:,:,:,J);
J=find(strcmp(fldList,'ADVy_SLT'));
advy_slt = dyn(:,:,:,J);
J=find(strcmp(fldList,'DFrE_TH '));
dfre_th = dyn(:,:,:,J);
J=find(strcmp(fldList,'DFrE_SLT'));
dfre_slt = dyn(:,:,:,J);
J=find(strcmp(fldList,'WTHMASS '));
wthmass = dyn(:,:,:,J);
J=find(strcmp(fldList,'WSLTMASS'));
wsltmass = dyn(:,:,:,J);

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'oceQsw  '));
oceqsw = surf(:,:,J);
J=find(strcmp(fldList,'oceFWflx'));
ocefwflx = surf(:,:,J);


[advxE_th,advyN_th] = rotate_uv2uvEN(advx_th,advy_th,AngleCS,AngleSN,Grid);
[advxE_slt,advyN_slt] = rotate_uv2uvEN(advx_slt,advy_slt,AngleCS,AngleSN,Grid);

totttend_ll = cube2latlon(xc,yc,totttend,xi,yi);
totstend_ll = cube2latlon(xc,yc,totstend,xi,yi);

advxE_th_ll = cube2latlon(xc,yc,advxE_th,xi,yi);
advyN_th_ll = cube2latlon(xc,yc,advyN_th,xi,yi);

advxE_slt_ll = cube2latlon(xc,yc,advxE_slt,xi,yi);
advyN_slt_ll = cube2latlon(xc,yc,advyN_slt,xi,yi);


advr_th_ll = cube2latlon(xc,yc,advr_th,xi,yi);
advr_slt_ll = cube2latlon(xc,yc,advr_slt,xi,yi);

dfre_th_ll = cube2latlon(xc,yc,dfre_th,xi,yi);
dfre_slt_ll = cube2latlon(xc,yc,dfre_slt,xi,yi);

wthmass_ll = cube2latlon(xc,yc,wthmass,xi,yi);
wsltmass_ll = cube2latlon(xc,yc,wsltmass,xi,yi);

oceqsw_ll = cube2latlon(xc,yc,oceqsw,xi,yi);
ocefwflx_ll = cube2latlon(xc,yc,ocefwflx,xi,yi);



