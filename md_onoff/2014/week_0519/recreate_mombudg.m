%try to recreate the mitgcm momentum diags so you can figure out what goes into them and how to use the output right!


% choose directory, load grid
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_mombudg_2/';
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


%start reading files: u, v, w
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


J=find(strcmp(fldList,'Um_AdvZ3'));
uzcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvZ3'));
vzcs(:,:,:,i) = dyn(:,:,:,J);
[uzE(:,:,:,i),vzN(:,:,:,i)] = rotate_uv2uvEN(uzcs(:,:,:,i),vzcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'Um_AdvRe'));
urcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvRe'));
vrcs(:,:,:,i) = dyn(:,:,:,J);
[urE(:,:,:,i),vrN(:,:,:,i)] = rotate_uv2uvEN(urcs(:,:,:,i),vrcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'Um_Advec'));
uadvcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_Advec'));
vadvcs(:,:,:,i) = dyn(:,:,:,J);
[uadvE(:,:,:,i),vadvN(:,:,:,i)] = rotate_uv2uvEN(uadvcs(:,:,:,i),vadvcs(:,:,:,i),AngleCS,AngleSN,Grid);


end


omega = 7.292e-5;
f = 2.*omega.*sin(yg.*pi./180);


for j=1:32
for i=1:192
dyv(i,j,:,:) = dyc(i,j).*vcs(i,j,:,:)./arz(i,j);
dxu(i,j,:,:) = dxc(i,j).*ucs(i,j,:,:)./arz(i,j);
end 
end

wucs = w.*ucs;

[dyvdy,dyvdx,dyvdz,dyvdt] = gradient(dyv);
[dxudy,dxudx,dxudz,dxudt] = gradient(dxu);
[dvcsdy,dvcsdx,dvcsdz,dvcsdt] = gradient(vcs,-1);
[ducsdy,ducsdx,ducsdz,ducsdt] = gradient(ucs,-1);

[dwucsdy,dwucsdx,dwucsdz,dwucsdt] = gradient(wucs);

zeta3 = dyvdx - dxudy;

for k=1:25
for tstep=1:360

gufvzv(:,:,k,tstep) = 1./dxc .* (f + zeta3(:,:,k,tstep))./hc(:,:,k) .* dxg .* hs(:,:,k) .* vcs(:,:,k,tstep);

gvfuzu(:,:,k,tstep) = -1./dyc .* (f + zeta3(:,:,k,tstep))./hc(:,:,k) .* dyg .* hw(:,:,k) .* ucs(:,:,k,tstep);

guzw(:,:,k,tstep) = 1./(drf(k).*hw(:,:,k)) .* w(:,:,k,tstep) .* ducsdz(:,:,k,tstep);

gvzw(:,:,k,tstep) = -1./(drf(k).*hs(:,:,k)) .*w(:,:,k,tstep) .* dvcsdz(:,:,k,tstep);

fvcs(:,:,k,tstep) = f.*vcs(:,:,k,tstep);

end
end


gufvzv_mean = mean(gufvzv,4);
gvfuzu_mean = mean(gvfuzu,4);
guzw_mean = mean(guzw,4);
gvzw_mean = mean(gvzw,4);
uzcs_mean = mean(uzcs,4);
urcs_mean = mean(urcs,4);
uadvcs_mean = mean(uadvcs,4);
vzcs_mean = mean(vzcs,4);
vrcs_mean = mean(vrcs,4);
vadvcs_mean = mean(vadvcs,4);
w_mean = mean(w,4);
ucs_mean = mean(ucs,4);
ducsdz_mean = mean(ducsdz,4);
dwucsdz_mean = mean(dwucsdz,4);
fvcs_mean = mean(fvcs,4);
urE_mean = mean(urE,4);
uzE_mean = mean(uzE,4);
uadvE_mean = mean(uadvE,4);
vrN_mean = mean(vrN,4);
vzN_mean = mean(vzN,4);
vadvN_mean = mean(vadvN,4);
uE_mean = mean(uE,4);
vN_mean = mean(vN,4);


[gufvzv_zav,mskzon,ylat,areazon]=calcZonalAvgCube(gufvzv_mean,ny,yc,arc,hc);
[gvfuzu_zav,mskzon,ylat,areazon]=calcZonalAvgCube(gvfuzu_mean,ny,yc,arc,hc);
[guzw_zav,mskzon,ylat,areazon]=calcZonalAvgCube(guzw_mean,ny,yc,arc,hc);
[gvzw_zav,mskzon,ylat,areazon]=calcZonalAvgCube(gvzw_mean,ny,yc,arc,hc);
[uzcs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uzcs_mean,ny,yc,arc,hc);
[urcs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(urcs_mean,ny,yc,arc,hc);
[uadvcs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uadvcs_mean,ny,yc,arc,hc);
[vzcs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vzcs_mean,ny,yc,arc,hc);
[vrcs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vrcs_mean,ny,yc,arc,hc);
[vadvcs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vadvcs_mean,ny,yc,arc,hc);
[w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_mean,ny,yc,arc,hc);
[ucs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(ucs_mean,ny,yc,arc,hc);
[ducsdz_zav,mskzon,ylat,areazon]=calcZonalAvgCube(ducsdz_mean,ny,yc,arc,hc);
[dwucsdz_zav,mskzon,ylat,areazon]=calcZonalAvgCube(dwucsdz_mean,ny,yc,arc,hc);
[fvcs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(fvcs_mean,ny,yc,arc,hc);
[urE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(urE_mean,ny,yc,arc,hc);
[uzE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uzE_mean,ny,yc,arc,hc);
[uadvE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uadvE_mean,ny,yc,arc,hc);
[vrN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vrN_mean,ny,yc,arc,hc);
[vzN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vzN_mean,ny,yc,arc,hc);
[vadvN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vadvN_mean,ny,yc,arc,hc);
[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_mean,ny,yc,arc,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_mean,ny,yc,arc,hc);
[hc_zav,mskzon,ylat,areazon]=calcZonalAvgCube(hc,ny,yc,arc,hc);

[duEdz,duEdy] = gradient(uE_zav);


%gufvzv = 1./dxc .* (f+zeta3)./hc .* dxg.*hs.*vcs;

%gvfuzu = -1./dyc .* (f+zeta3)./hc .* dyg.*hw.*ucs;

%am assuming eta nh = 0, probs not, check. Have also assumed typo in manual as eqns do not seem to make sense!

%guzw = 1./(arw.*drf.*hw) .* arc.*w .* (ucs(:,:,k+1) - ucs(:,:,k));

%gvzw = -1./(ars.*drf.*hs) .* arc.*w .*(vcs(:,:,k+1) - vcs(:,:,k));