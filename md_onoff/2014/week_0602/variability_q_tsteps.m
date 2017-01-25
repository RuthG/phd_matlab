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

vN_mean = mean(vN,4);
vort3_mean = mean(vort3,4);

%calculate f
omega = 7.292e-5;
f = 2.*omega.*sin(yg.*pi./180);

for k=1:25
for tstep=1:240

dyv(:,:) = dyc.*vcs(:,:,k,tstep)./arz;
dxu(:,:) = dxc.*ucs(:,:,k,tstep)./arz;

[dyvdy,dyvdx] = gradient(dyv);
[dxudy,dxudx] = gradient(dxu);

zeta3(:,:,k,tstep) = dyvdx - dxudy;

fucs = ucs(:,:,k,tstep).*f;
fvcs = vcs(:,:,k,tstep).*f;

gu_abs_mit_cs(:,:,k,tstep) = 1./dxc .* (f + vort3(:,:,k,tstep)) .* dxg .* vcs(:,:,k,tstep);
gv_abs_mit_cs(:,:,k,tstep) = -1./dyc .* (f + vort3(:,:,k,tstep)) .* dyg .* ucs(:,:,k,tstep);

gu_rel_mit_cs(:,:,k,tstep) = 1./dxc .* (vort3(:,:,k,tstep)) .* dxg .* vcs(:,:,k,tstep);
gv_rel_mit_cs(:,:,k,tstep) = -1./dyc .* (vort3(:,:,k,tstep)) .* dyg .* ucs(:,:,k,tstep);

end
end

fucs_mean = mean(fucs,4);
fvcs_mean = mean(fvcs,4);

[fuE_mean,fvN_mean] = rotate_uv2uvEN(fucs_mean,fvcs_mean,AngleCS,AngleSN,Grid);
[fvN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(fvN_mean,ny,yc,arc,hc);

gu_rel_mit_cs_yav = vort3_mean.*vN_mean;

for i=1:25
gu_abs_mit_cs_yav(:,:,i) = vort3_mean(:,:,i).*vN_mean(:,:,i) + fvN_mean;
end

gu_abs_mit_cs_mean = mean(gu_abs_mit_cs,4);
gv_abs_mit_cs_mean = mean(gv_abs_mit_cs,4);

gu_rel_mit_cs_mean = mean(gu_rel_mit_cs,4);
gv_rel_mit_cs_mean = mean(gv_rel_mit_cs,4);

uzE_mean = mean(uzE,4);

[guE_abs_mit_cs_mean,gvN_abs_mit_cs_mean] = rotate_uv2uvEN(gu_abs_mit_cs_mean,gv_abs_mit_cs_mean,AngleCS,AngleSN,Grid);
[guE_rel_mit_cs_mean,gvN_rel_mit_cs_mean] = rotate_uv2uvEN(gu_rel_mit_cs_mean,gv_rel_mit_cs_mean,AngleCS,AngleSN,Grid);

[guE_abs_mit_cs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(guE_abs_mit_cs_mean,ny,yc,arc,hc);
[guE_rel_mit_cs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(guE_rel_mit_cs_mean,ny,yc,arc,hc);
[gu_rel_mit_cs_yzav,mskzon,ylat,areazon]=calcZonalAvgCube(gu_rel_mit_cs_yav,ny,yc,arc,hc);
[gu_abs_mit_cs_yzav,mskzon,ylat,areazon]=calcZonalAvgCube(gu_abs_mit_cs_yav,ny,yc,arc,hc);

[uzE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uzE_mean,ny,yc,arc,hc);

