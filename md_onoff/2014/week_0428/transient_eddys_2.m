%Play with trying to split up v and u into 4 eddy fluxes instead of 2 using daily data.


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_1yeardaily_c/';

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
for nit = 605040:240:691200;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_ctrl(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_ctrl(:,:,:,i) = dyn(:,:,:,J);
[uE_ctrl(:,:,:,i),vN_ctrl(:,:,:,i)] = rotate_uv2uvEN(ucs_ctrl(:,:,:,i),vcs_ctrl(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_ctrl(:,:,:,i) = dyn(:,:,:,J);

end

uv_ctrl_tav = mean(uv_ctrl,4);
uE_ctrl_tav = mean(uE_ctrl,4);
vN_ctrl_tav = mean(vN_ctrl,4);

[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_ctrl,ny,yc,ar,hc);
[uE_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_ctrl_tav,ny,yc,ar,hc);

[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_ctrl,ny,yc,ar,hc);
[vN_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_ctrl_tav,ny,yc,ar,hc);

[uv_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ctrl,ny,yc,ar,hc);
[uv_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ctrl_tav,ny,yc,ar,hc);


%without time averaging first

uv_ed_notav = uv_zav - uE_zav.*vN_zav;

%with time av

uv_ed_tav = uv_tzav - uE_tzav.*vN_tzav;

uv_ed_notav_tav = mean(uv_ed_notav,3);

