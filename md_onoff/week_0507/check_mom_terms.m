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
J=find(strcmp(fldList,'TOTUTEND'));
totutend = dyn(:,:,:,J);
J=find(strcmp(fldList,'TOTVTEND'));
totvtend = dyn(:,:,:,J);
J=find(strcmp(fldList,'AB_gU   '));
abgu = dyn(:,:,:,J);
J=find(strcmp(fldList,'AB_gV   '));
abgv = dyn(:,:,:,J);
J=find(strcmp(fldList,'Um_Diss '));
um_diss = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_Diss '));
vm_diss = dyn(:,:,:,J);
J=find(strcmp(fldList,'Um_dPHdx'));
um_dphdx = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_dPHdy'));
vm_dphdy = dyn(:,:,:,J);
J=find(strcmp(fldList,'Um_Ext  '));
um_ext = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_Ext  '));
vm_ext = dyn(:,:,:,J);
J=find(strcmp(fldList,'Um_Advec'));
um_advec = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_Advec'));
vm_advec = dyn(:,:,:,J);
J=find(strcmp(fldList,'Um_AdvZ3'));
um_advz3 = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvZ3'));
vm_advz3 = dyn(:,:,:,J);
J=find(strcmp(fldList,'Um_AdvRe'));
um_advre = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvRe'));
vm_advre = dyn(:,:,:,J);
J=find(strcmp(fldList,'SHAP_dU '));
shap_du = dyn(:,:,:,J);
J=find(strcmp(fldList,'SHAP_dV '));
shap_dv = dyn(:,:,:,J);

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'ETAN    '));
etan= surf(:,:,J);


sum = abgu + um_dphdx + um_ext + um_advec + shap_du; 


[totuEtend,totvNtend] = rotate_uv2uvEN(totutend,totvtend,AngleCS,AngleSN,Grid);
[abguE,abgvN] = rotate_uv2uvEN(abgu,abgv,AngleCS,AngleSN,Grid);
[uEm_dphdx,vNm_dphdy] = rotate_uv2uvEN(um_dphdx,vm_dphdy ,AngleCS,AngleSN,Grid);
[uEm_ext,vNm_ext] = rotate_uv2uvEN(um_ext,vm_ext,AngleCS,AngleSN,Grid);
[uEm_advec,vNm_advec] = rotate_uv2uvEN(um_advec,vm_advec,AngleCS,AngleSN,Grid);
[uEm_advz3,vNm_advz3] = rotate_uv2uvEN(um_advz3,vm_advz3,AngleCS,AngleSN,Grid);
[uEm_advre,vNm_advre] = rotate_uv2uvEN(um_advre,vm_advre,AngleCS,AngleSN,Grid);
[shap_duE,shap_dvN] = rotate_uv2uvEN(shap_du,shap_dv,AngleCS,AngleSN,Grid);

totuEtend_ll = cube2latlon(xc,yc,totuEtend,xi,yi);
totvNtend_ll = cube2latlon(xc,yc,totvNtend,xi,yi);
abguE_ll = cube2latlon(xc,yc,abguE,xi,yi);
abgvN_ll = cube2latlon(xc,yc,abgvN,xi,yi);
uEm_dphdx_ll = cube2latlon(xc,yc,uEm_dphdx,xi,yi);
vNm_dphdy_ll = cube2latlon(xc,yc,vNm_dphdy,xi,yi);
uEm_ext_ll = cube2latlon(xc,yc,uEm_ext,xi,yi);
vNm_ext_ll = cube2latlon(xc,yc,vNm_ext,xi,yi);
uEm_advec_ll = cube2latlon(xc,yc,uEm_advec,xi,yi);
vNm_advec_ll = cube2latlon(xc,yc,vNm_advec,xi,yi);
uEm_advz3_ll = cube2latlon(xc,yc,uEm_advz3,xi,yi);
vNm_advz3_ll = cube2latlon(xc,yc,vNm_advz3,xi,yi);
uEm_advre_ll = cube2latlon(xc,yc,uEm_advre,xi,yi);
vNm_advre_ll = cube2latlon(xc,yc,vNm_advre,xi,yi);
shap_duE_ll = cube2latlon(xc,yc,shap_duE,xi,yi);
shap_dvN_ll = cube2latlon(xc,yc,shap_dvN,xi,yi);
etan_ll = cube2latlon(xc,yc,etan,xi,yi);

radius = 6371.0e3;
coslat = repmat(cos(yi.*pi./180),[180,1]);
detan_ll_dx = gradient(etan_ll',2)./radius./coslat';


