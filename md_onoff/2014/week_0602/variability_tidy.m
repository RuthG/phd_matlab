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

J=find(strcmp(fldList,'momVort3'));
vort3(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'Um_AdvZ3'));
uzcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvZ3'));
vzcs(:,:,:,i) = dyn(:,:,:,J);
[uzE(:,:,:,i),vzN(:,:,:,i)] = rotate_uv2uvEN(uzcs(:,:,:,i),vzcs(:,:,:,i),AngleCS,AngleSN,Grid);

end

%take hour means
for i=1:24
ucs_hourly(:,:,:,i) = mean(ucs(:,:,:, 10.*i -9 : 10.*i)  , 4);
vcs_hourly(:,:,:,i) = mean(vcs(:,:,:, 10.*i -9 : 10.*i)  , 4);
vN_hourly(:,:,:,i) = mean(vN(:,:,:, 10.*i -9 : 10.*i)  , 4);
vort3_hourly(:,:,:,i) = mean(vort3(:,:,:, 10.*i -9 : 10.*i)  , 4);
end

%take half day means
ucs_halfday(:,:,:,1) = mean(ucs(:,:,:, 1:120),4);
ucs_halfday(:,:,:,2) = mean(ucs(:,:,:, 121:240),4);
vcs_halfday(:,:,:,1) = mean(vcs(:,:,:, 1:120),4);
vcs_halfday(:,:,:,2) = mean(vcs(:,:,:, 121:240),4);
vN_halfday(:,:,:,1) = mean(vN(:,:,:, 1:120),4);
vN_halfday(:,:,:,2) = mean(vN(:,:,:, 121:240),4);
vort3_halfday(:,:,:,1) = mean(vort3(:,:,:, 1:120),4);
vort3_halfday(:,:,:,2) = mean(vort3(:,:,:, 121:240),4);

vN_mean = mean(vN,4);
vort3_mean = mean(vort3,4);

for k=1:25
for tstep=1:240
gu_rel_mit_cs(:,:,k,tstep) = 1./dxc .* (vort3(:,:,k,tstep)) .* dxg .* vcs(:,:,k,tstep);
gv_rel_mit_cs(:,:,k,tstep) = -1./dyc .* (vort3(:,:,k,tstep)) .* dyg .* ucs(:,:,k,tstep);
end

for tstep = 1:24
gu_rel_mit_cs_hly(:,:,k,tstep) = 1./dxc .* (vort3_hourly(:,:,k,tstep)) .* dxg .* vcs_hourly(:,:,k,tstep);
gv_rel_mit_cs_hly(:,:,k,tstep) = -1./dyc .* (vort3_hourly(:,:,k,tstep)) .* dyg .* ucs_hourly(:,:,k,tstep);
end

for tstep = 1:2
gu_rel_mit_cs_hd(:,:,k,tstep) = 1./dxc .* (vort3_halfday(:,:,k,tstep)) .* dxg .* vcs_halfday(:,:,k,tstep);
gv_rel_mit_cs_hd(:,:,k,tstep) = -1./dyc .* (vort3_halfday(:,:,k,tstep)) .* dyg .* ucs_halfday(:,:,k,tstep);
end

end

gu_rel_mit_cs_yav = vort3_mean.*vN_mean;

gu_rel_mit_cs_mean = mean(gu_rel_mit_cs,4);
gv_rel_mit_cs_mean = mean(gv_rel_mit_cs,4);

gu_rel_mit_cs_hly_mean = mean(gu_rel_mit_cs_hly,4);
gv_rel_mit_cs_hly_mean = mean(gv_rel_mit_cs_hly,4);

gu_rel_mit_cs_hd_mean = mean(gu_rel_mit_cs_hd,4);
gv_rel_mit_cs_hd_mean = mean(gv_rel_mit_cs_hd,4);

uzE_mean = mean(uzE,4);

[guE_rel_mit_cs_mean,gvN_rel_mit_cs_mean] = rotate_uv2uvEN(gu_rel_mit_cs_mean,gv_rel_mit_cs_mean,AngleCS,AngleSN,Grid);
[guE_rel_mit_cs_hly_mean,gvN_rel_mit_cs_hly_mean] = rotate_uv2uvEN(gu_rel_mit_cs_hly_mean,gv_rel_mit_cs_hly_mean,AngleCS,AngleSN,Grid);
[guE_rel_mit_cs_hd_mean,gvN_rel_mit_cs_hd_mean] = rotate_uv2uvEN(gu_rel_mit_cs_hd_mean,gv_rel_mit_cs_hd_mean,AngleCS,AngleSN,Grid);

[guE_rel_mit_cs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(guE_rel_mit_cs_mean,ny,yc,arc,hc);
[gu_rel_mit_cs_yzav,mskzon,ylat,areazon]=calcZonalAvgCube(gu_rel_mit_cs_yav,ny,yc,arc,hc);
[guE_rel_mit_cs_hly_zav,mskzon,ylat,areazon]=calcZonalAvgCube(guE_rel_mit_cs_hly_mean,ny,yc,arc,hc);
[guE_rel_mit_cs_hd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(guE_rel_mit_cs_hd_mean,ny,yc,arc,hc);

[uzE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uzE_mean,ny,yc,arc,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_mean,ny,yc,arc,hc);

%calculate f
omega = 7.292e-5;

f = zeros(90,25);

for i=1:25
f(:,i) = 2.*omega.*sin(ylat.*pi./180);
end

guE_abs_mit_cs_zav = guE_rel_mit_cs_zav + f.*vN_zav;
guE_abs_mit_cs_hly_zav = guE_rel_mit_cs_hly_zav + f.*vN_zav;
guE_abs_mit_cs_hd_zav = guE_rel_mit_cs_hd_zav + f.*vN_zav;
gu_abs_mit_cs_yzav = gu_rel_mit_cs_yzav + f.*vN_zav;

v=-4e-4:0.2e-4:4e-4;
figure
contourf(guE_abs_mit_cs_zav',v);
caxis([-4e-4 4e-4]);

figure
contourf(guE_abs_mit_cs_hly_zav',v);
caxis([-4e-4 4e-4]);

figure
contourf(guE_abs_mit_cs_hd_zav',v);
caxis([-4e-4 4e-4]);

figure
contourf(gu_abs_mit_cs_yzav',v);
caxis([-4e-4 4e-4]);

figure
contourf(uzE_zav',v);
caxis([-4e-4 4e-4]);

