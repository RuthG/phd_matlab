%redo calc with year avs, does similar decrease happen to signal? If so rerun outputting each tstep for 1 day and go from there...

rDir='/disk1/MITgcm/verification/atm_gray_ruth/run/';
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
for nit = 604801:1:605040;
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

J=find(strcmp(fldList,'Um_AdvRe'));
urcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvRe'));
vrcs(:,:,:,i) = dyn(:,:,:,J);
[urE(:,:,:,i),vrN(:,:,:,i)] = rotate_uv2uvEN(urcs(:,:,:,i),vrcs(:,:,:,i),AngleCS,AngleSN,Grid);

end

%take hour means
for i=1:24
ucs_hourly(:,:,:,i) = mean(ucs(:,:,:, 10.*i -9 : 10.*i)  , 4);
vcs_hourly(:,:,:,i) = mean(vcs(:,:,:, 10.*i -9 : 10.*i)  , 4);
vN_hourly(:,:,:,i) = mean(vN(:,:,:, 10.*i -9 : 10.*i)  , 4);
w_hourly(:,:,:,i) = mean(w(:,:,:, 10.*i -9 : 10.*i)  , 4);
end

%take half day means
ucs_halfday(:,:,:,1) = mean(ucs(:,:,:, 1:120),4);
ucs_halfday(:,:,:,2) = mean(ucs(:,:,:, 121:240),4);
vcs_halfday(:,:,:,1) = mean(vcs(:,:,:, 1:120),4);
vcs_halfday(:,:,:,2) = mean(vcs(:,:,:, 121:240),4);
vN_halfday(:,:,:,1) = mean(vN(:,:,:, 1:120),4);
vN_halfday(:,:,:,2) = mean(vN(:,:,:, 121:240),4);
w_halfday(:,:,:,1) = mean(w(:,:,:, 1:120),4);
w_halfday(:,:,:,2) = mean(w(:,:,:, 121:240),4);

vN_mean = mean(vN,4);
w_mean = mean(w,4);
uE_mean = mean(uE,4);
urE_mean = mean(urE,4);

[dvcsdy,dvcsdx,dvcsdz,dvcsdt] = gradient(vcs,1);
[ducsdy,ducsdx,ducsdz,ducsdt] = gradient(ucs,1);

[dvcsdy_hly,dvcsdx_hly,dvcsdz_hly,dvcsdt_hly] = gradient(vcs_hourly,1);
[ducsdy_hly,ducsdx_hly,ducsdz_hly,ducsdt_hly] = gradient(ucs_hourly,1);

[dvcsdy_hd,dvcsdx_hd,dvcsdz_hd,dvcsdt_hd] = gradient(vcs_halfday,1);
[ducsdy_hd,ducsdx_hd,ducsdz_hd,ducsdt_hd] = gradient(ucs_halfday,1);

[duEdy_yav,duEdx_yav,duEdz_yav] = gradient(uE_mean,4000);

for k=1:25
for tstep=1:240
guzw(:,:,k,tstep) = 1./drf(k) .* w(:,:,k,tstep) .* ducsdz(:,:,k,tstep);
gvzw(:,:,k,tstep) = 1./drf(k) .* w(:,:,k,tstep) .* dvcsdz(:,:,k,tstep);
end

for tstep = 1:24
guzw_hly(:,:,k,tstep) = 1./drf(k) .* w_hourly(:,:,k,tstep) .* ducsdz_hly(:,:,k,tstep);
gvzw_hly(:,:,k,tstep) = 1./drf(k) .* w_hourly(:,:,k,tstep) .* dvcsdz_hly(:,:,k,tstep);
end

for tstep = 1:2
guzw_hd(:,:,k,tstep) = 1./drf(k) .* w_halfday(:,:,k,tstep) .* ducsdz_hd(:,:,k,tstep);
gvzw_hd(:,:,k,tstep) = 1./drf(k) .* w_halfday(:,:,k,tstep) .* dvcsdz_hd(:,:,k,tstep);
end

end

guEzw_yav = w_mean.*duEdz_yav;

guzw_mean = mean(guzw,4);
gvzw_mean = mean(gvzw,4);

guzw_hly_mean = mean(guzw_hly,4);
gvzw_hly_mean = mean(gvzw_hly,4);

guzw_hd_mean = mean(guzw_hd,4);
gvzw_hd_mean = mean(gvzw_hd,4);

[duEdz,dvNdz] = rotate_uv2uvEN(ducsdz,dvcsdz,AngleCS,AngleSN,Grid);
[guEzw_mean,gvNzw_mean] = rotate_uv2uvEN(guzw_mean,gvzw_mean,AngleCS,AngleSN,Grid);
[guEzw_hly_mean,gvNzw_hly_mean] = rotate_uv2uvEN(guzw_hly_mean,gvzw_hly_mean,AngleCS,AngleSN,Grid);
[guEzw_hd_mean,gvNzw_hd_mean] = rotate_uv2uvEN(guzw_hd_mean,gvzw_hd_mean,AngleCS,AngleSN,Grid);

[guEzw_zav,mskzon,ylat,areazon]=calcZonalAvgCube(guEzw_mean,ny,yc,arc,hc);
[guEzw_hly_zav,mskzon,ylat,areazon]=calcZonalAvgCube(guEzw_hly_mean,ny,yc,arc,hc);
[guEzw_hd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(guEzw_hd_mean,ny,yc,arc,hc);
[guEzw_yzav,mskzon,ylat,areazon]=calcZonalAvgCube(guEzw_yav,ny,yc,arc,hc);

[duEdz_zav,mskzon,ylat,areazon]=calcZonalAvgCube(duEdz,ny,yc,arc,hc);
[urE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(urE_mean,ny,yc,arc,hc);
[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_mean,ny,yc,arc,hc);
[duEdz_yzav,mskzon,ylat,areazon]=calcZonalAvgCube(duEdz_yav,ny,yc,arc,hc);
[w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_mean,ny,yc,arc,hc);
[w_zav_full,mskzon,ylat,areazon]=calcZonalAvgCube(w,ny,yc,arc,hc);

v=-4e-5:0.2e-5:4e-4;
figure
contourf(guEzw_zav',v);
caxis([-4e-5 4e-5]);

figure
contourf(guEzw_hly_zav',v);
caxis([-4e-5 4e-5]);

figure
contourf(guEzw_hd_zav',v);
caxis([-4e-5 4e-5]);

figure
contourf(guEzw_yzav',v);
caxis([-4e-5 4e-5]);

figure
contourf(urE_zav',v);
caxis([-4e-5 4e-5]);

