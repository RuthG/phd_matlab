%load wu wv and so calculate variance of w and u


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

J=find(strcmp(fldList,'WU_VEL  '));
wucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WV_VEL  '));
wvcs(:,:,:,i) = dyn(:,:,:,J);
[wuE(:,:,:,i),wvN(:,:,:,i)] = rotate_uv2uvEN(wucs(:,:,:,i),wvcs(:,:,:,i),AngleCS,AngleSN,Grid);

end


wuE_daily = uE.*w;

wuE_trans = wuE - uE.*w;

wuE_mean = mean(wuE,4);
w_mean = mean(w,4);
uE_mean = mean(uE,4);
wuE_trans_mean = mean(wuE_trans,4);

[w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_mean,ny,yc,arc,hc);
[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_mean,ny,yc,arc,hc);
[wuE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(wuE_mean,ny,yc,arc,hc);
[wuE_trans_zav,mskzon,ylat,areazon]=calcZonalAvgCube(wuE_trans_mean,ny,yc,arc,hc);

wuE_ed_zav = wuE_zav - w_zav.*uE_zav;


