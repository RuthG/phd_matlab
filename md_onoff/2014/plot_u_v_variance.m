%load up uu vv, plot variances

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

%read fields
i=0;
for nit = 259200:86400:604800;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_ctrl(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_ctrl(:,:,:,i) = dyn(:,:,:,J);
[uE_ctrl(:,:,:,i),vN_ctrl(:,:,:,i)] = rotate_uv2uvEN(ucs_ctrl(:,:,:,i),vcs_ctrl(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'UVELSQ  '));
uucs_ctrl(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSQ  '));
vvcs_ctrl(:,:,:,i) = dyn(:,:,:,J);
[uuE_ctrl(:,:,:,i),vvN_ctrl(:,:,:,i)] = rotate_uv2uvEN(uucs_ctrl(:,:,:,i),vvcs_ctrl(:,:,:,i),AngleCS,AngleSN,Grid);

end

uuE_ed = uuE_ctrl - uE_ctrl.^2;
vvN_ed = vvN_ctrl - vN_ctrl.^2;

uuE_ed_mean = mean(uuE_ed,4);
vvN_ed_mean = mean(vvN_ed,4);
[uuE_ed_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uuE_ed_mean,ny,yc,ar,hc);
[vvN_ed_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vvN_ed_mean,ny,yc,ar,hc);

for i=1:45
uuE_ed_hzav(46-i,:) = (uuE_ed_zav(i,:) + uuE_ed_zav(91-i,:))./2;
vvN_ed_hzav(46-i,:) = (-1*vvN_ed_zav(i,:) + vvN_ed_zav(91-i,:))./2;
end
