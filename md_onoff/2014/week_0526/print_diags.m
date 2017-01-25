%load up and print plots of all diags 


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_diag_testing/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
dxc=rdmds([rDir,'DXC']);
dyc=rdmds([rDir,'DYC']);
dxg=rdmds([rDir,'DXG']);
dyg=rdmds([rDir,'DYG']);
drf=rdmds([rDir,'DRF']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
arc=rdmds([rDir,'RAC']);
ars=rdmds([rDir,'RAS']);
arw=rdmds([rDir,'RAW']);
arz=rdmds([rDir,'RAZ']);
rC=squeeze(rdmds([rDir,'RC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
ny=90;
a=6371.0e3;

i=0;
for nit = 605040:240:691200;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'WVEL    '));
w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
t(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdt'));
dTdt(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdQdt'));
dqdt(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdtQg'));
dtqg(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhDifT'));
dift(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhDifM'));
difm(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
dtrd(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
dtdf(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
dtcv(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
dtcd(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'THETASQ '));
tsq(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'SALTSQ  '));
qsq(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELSQ  '));
usq(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSQ  '));
vsq(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVELSQ  '));
wsq(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UV_VEL_C'));
uv(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'momKE   '));
KE(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'momVort3'));
vort3(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'PHIHYD  '));
gz(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'Um_AdvRe'));
urcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvRe'));
vrcs(:,:,:,i) = dyn(:,:,:,J);
[urE(:,:,:,i),vrN(:,:,:,i)] = rotate_uv2uvEN(urcs(:,:,:,i),vrcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'Um_AdvZ3'));
uzcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvZ3'));
vzcs(:,:,:,i) = dyn(:,:,:,J);
[uzE(:,:,:,i),vzN(:,:,:,i)] = rotate_uv2uvEN(uzcs(:,:,:,i),vzcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'Um_Advec'));
uadvcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_Advec'));
vadvcs(:,:,:,i) = dyn(:,:,:,J);
[uadvE(:,:,:,i),vadvN(:,:,:,i)] = rotate_uv2uvEN(uadvcs(:,:,:,i),vadvcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'WU_VEL  '));
uwcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WV_VEL  '));
vwcs(:,:,:,i) = dyn(:,:,:,J);
[uwE(:,:,:,i),vwN(:,:,:,i)] = rotate_uv2uvEN(uwcs(:,:,:,i),vwcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'AtPhdUdt'));
dudtcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdVdt'));
dvdtcs(:,:,:,i) = dyn(:,:,:,J);
[dudtE(:,:,:,i),dvdtN(:,:,:,i)] = rotate_uv2uvEN(dudtcs(:,:,:,i),dvdtcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'UVELTH  '));
uthcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vthcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVELTH  '));
wth(:,:,:,i) = dyn(:,:,:,J);
[uthE(:,:,:,i),vthN(:,:,:,i)] = rotate_uv2uvEN(uthcs(:,:,:,i),vthcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'UVELSLT '));
uqcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSLT '));
vqcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVELSLT '));
wq(:,:,:,i) = dyn(:,:,:,J);
[uqE(:,:,:,i),vqN(:,:,:,i)] = rotate_uv2uvEN(uqcs(:,:,:,i),vqcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'ADVx_TH '));
advthxcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'ADVy_TH '));
advthycs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'ADVr_TH '));
advthr(:,:,:,i) = dyn(:,:,:,J);
[advthE(:,:,:,i),advthN(:,:,:,i)] = rotate_uv2uvEN(advthxcs(:,:,:,i),advthycs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'ADVx_SLT'));
advqxcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'ADVy_SLT'));
advqycs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'ADVr_SLT'));
advqr(:,:,:,i) = dyn(:,:,:,J);
[advqE(:,:,:,i),advqN(:,:,:,i)] = rotate_uv2uvEN(advqxcs(:,:,:,i),advqycs(:,:,:,i),AngleCS,AngleSN,Grid);

end


uE_mean = mean(uE,4);
vN_mean = mean(vN,4);
q_mean = mean(q,4);
t_mean = mean(t,4);
w_mean = mean(w,4);

advqE_mean = mean(advqE,4);
advqN_mean = mean(advqN,4);
advqr_mean = mean(advqr,4);

advthE_mean = mean(advthE,4);
advthN_mean = mean(advthN,4);
advthr_mean = mean(advthr,4);

uqE_mean = mean(uqE,4);
vqN_mean = mean(vqN,4);
wq_mean = mean(wq,4);

uthE_mean = mean(uthE,4);
vthN_mean = mean(vthN,4);
wth_mean = mean(wth,4);

dudtE_mean = mean(dudtE,4);
dvdtN_mean = mean(dvdtN,4);

uv_mean = mean(uv,4);
uwE_mean = mean(uwE,4);
vwN_mean = mean(vwN,4);

uadvE_mean = mean(uadvE,4);
vadvN_mean = mean(uadvE,4);

uzE_mean = mean(uzE,4);
vzN_mean = mean(uzE,4);

urE_mean = mean(urE,4);
vrN_mean = mean(urE,4);

tsq_mean = mean(tsq,4);
qsq_mean = mean(qsq,4);
usq_mean = mean(usq,4);
vsq_mean = mean(vsq,4);
wsq_mean = mean(wsq,4);
KE_mean = mean(KE,4);
vort3_mean = mean(vort3,4);
gz_mean = mean(gz,4);
dTdt_mean = mean(dTdt,4);
dqdt_mean = mean(dqdt,4);
dtqg_mean = mean(dtqg,4);
dift_mean = mean(dift,4);
difm_mean = mean(difm,4);
dtrd_mean = mean(dtrd,4);
dtdf_mean = mean(dtdf,4);
dtcv_mean = mean(dtcv,4);
dtcd_mean = mean(dtcd,4);


[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_mean,ny,yc,arc,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_mean,ny,yc,arc,hc);
[w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_mean,ny,yc,arc,hc);
[q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(q_mean,ny,yc,arc,hc);
[t_zav,mskzon,ylat,areazon]=calcZonalAvgCube(t_mean,ny,yc,arc,hc);
[usq_zav,mskzon,ylat,areazon]=calcZonalAvgCube(usq_mean,ny,yc,arc,hc);
[vsq_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vsq_mean,ny,yc,arc,hc);
[wsq_zav,mskzon,ylat,areazon]=calcZonalAvgCube(wsq_mean,ny,yc,arc,hc);
[tsq_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tsq_mean,ny,yc,arc,hc);
[qsq_zav,mskzon,ylat,areazon]=calcZonalAvgCube(qsq_mean,ny,yc,arc,hc);
[uv_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_mean,ny,yc,arc,hc);
[KE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(KE_mean,ny,yc,arc,hc);
[vort3_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vort3_mean,ny,yc,arc,hc);
[gz_zav,mskzon,ylat,areazon]=calcZonalAvgCube(gz_mean,ny,yc,arc,hc);
[uqE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uqE_mean,ny,yc,arc,hc);
[vqN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vqN_mean,ny,yc,arc,hc);
[wq_zav,mskzon,ylat,areazon]=calcZonalAvgCube(wq_mean,ny,yc,arc,hc);
[uthE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uthE_mean,ny,yc,arc,hc);
[vthN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vthN_mean,ny,yc,arc,hc);
[wth_zav,mskzon,ylat,areazon]=calcZonalAvgCube(wth_mean,ny,yc,arc,hc);
[uwE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uwE_mean,ny,yc,arc,hc);
[vwN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vwN_mean,ny,yc,arc,hc);
[uadvE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uadvE_mean,ny,yc,arc,hc);
[vadvN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vadvN_mean,ny,yc,arc,hc);
[uzE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uzE_mean,ny,yc,arc,hc);
[vzN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vzN_mean,ny,yc,arc,hc);
[urE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(urE_mean,ny,yc,arc,hc);
[vrN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vrN_mean,ny,yc,arc,hc);
[dudtE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(dudtE_mean,ny,yc,arc,hc);
[dvdtN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(dvdtN_mean,ny,yc,arc,hc);
[advqE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(advqE_mean,ny,yc,arc,hc);
[advqN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(advqN_mean,ny,yc,arc,hc);
[advqr_zav,mskzon,ylat,areazon]=calcZonalAvgCube(advqr_mean,ny,yc,arc,hc);
[advthE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(advthE_mean,ny,yc,arc,hc);
[advthN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(advthN_mean,ny,yc,arc,hc);
[advthr_zav,mskzon,ylat,areazon]=calcZonalAvgCube(advthr_mean,ny,yc,arc,hc);
[dtrd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(dtrd_mean,ny,yc,arc,hc);
[dtdf_zav,mskzon,ylat,areazon]=calcZonalAvgCube(dtdf_mean,ny,yc,arc,hc);
[dtcd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(dtcd_mean,ny,yc,arc,hc);
[dtcv_zav,mskzon,ylat,areazon]=calcZonalAvgCube(dtcv_mean,ny,yc,arc,hc);
[dTdt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(dTdt_mean,ny,yc,arc,hc);
[dqdt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(dqdt_mean,ny,yc,arc,hc);
[dtqg_zav,mskzon,ylat,areazon]=calcZonalAvgCube(dtqg_mean,ny,yc,arc,hc);
[dift_zav,mskzon,ylat,areazon]=calcZonalAvgCube(dift_mean,ny,yc,arc,hc);
[difm_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difm_mean,ny,yc,arc,hc);

f_zav = zeros(90,25);
rotrat = 2.*pi./(24.*60.*60);
for i=1:90
f_zav(i,:) = 2.*rotrat.*sin(ylat(i).*pi./180);
end

[C,h] = contourf(ylat,rC,uE_zav');
clabel(C,h);

[C,h] = contourf(ylat,rC,vN_zav');
clabel(C,h);

[C,h] = contourf(ylat,rC,w_zav');
clabel(C,h);

[C,h] = contourf(ylat,rC,q_zav');
clabel(C,h);

[C,h] = contourf(ylat,rC,t_zav');
clabel(C,h);

[C,h] = contourf(ylat,rC,qsq_zav');
clabel(C,h);

[C,h] = contourf(ylat,rC,tsq_zav');
clabel(C,h);

[C,h] = contourf(ylat,rC,usq_zav');
clabel(C,h);

[C,h] = contourf(ylat,rC,vsq_zav');
clabel(C,h);

[C,h] = contourf(ylat,rC,wsq_zav');
clabel(C,h);

[C,h] = contourf(ylat,rC,uv_zav');
clabel(C,h);

[C,h] = contourf(ylat,rC,KE_zav');
clabel(C,h);
