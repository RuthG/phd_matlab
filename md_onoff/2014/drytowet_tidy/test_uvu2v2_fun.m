rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';

nit = 604800;
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


[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELSQ  '));
uucs(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSQ  '));
vvcs(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UV_VEL_C'));
uv(:,:,:) = dyn(:,:,:,J);

[uE,vN] = rotate_uv2uvEN(ucs,vcs,AngleCS,AngleSN,Grid);


%[UVtot,UVtrans,U2tot,U2trans,V2tot,V2trans,errFlag]=calc2ndmom(ucs,vcs,uucs,vvcs,uv);

%[UVtot_zav,mskzon,ylat,areazon]=calcZonalAvgCube(UVtot,ny,yc,ar,hc);
%[U2tot_zav,mskzon,ylat,areazon]=calcZonalAvgCube(U2tot,ny,yc,ar,hc);
%[V2tot_zav,mskzon,ylat,areazon]=calcZonalAvgCube(V2tot,ny,yc,ar,hc);
%[uvcs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uvcs,ny,yc,ar,hc);

%[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE,ny,yc,ar,hc);
%[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN,ny,yc,ar,hc);

%UV_ed = UVtot_zav - uE_zav.*vN_zav;


%looks a bit crap. Check without using matlab code possible? Try

%for i=1:25
%usq_new(:,:,i) = uucs(:,:,i).^2.*AngleCS.^2 + vvcs(:,:,i).^2.*AngleSN.^2 - 2.*uvcs(:,:,i).*AngleCS.*AngleSN;
%vsq_new(:,:,i) = vvcs(:,:,i).^2.*AngleCS.^2 + uucs(:,:,i).^2.*AngleSN.^2 + 2.*uvcs(:,:,i).*AngleCS.*AngleSN;
%end

%[usq_new_zav,mskzon,ylat,areazon]=calcZonalAvgCube(usq_new,ny,yc,ar,hc);
%[vsq_new_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vsq_new,ny,yc,ar,hc);


%similar looking but with some weird mags. oh dear.

%Found the problem: UV is actually calculated in NE coords in model. Adjusted code, try again

for k=1:25
UVcs(:,:,k) = ( uv(:,:,k) + (vvcs(:,:,k) - uucs(:,:,k)).*AngleCS.*AngleSN ) .*(AngleCS.^2 - AngleSN.^2) ...
               ./ (1 - 4.*AngleCS.*AngleCS.*AngleSN.*AngleSN);
end

ucsvcs = ucs.*vcs;
[ucsvcs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(ucsvcs,ny,yc,ar,hc);

return
[UVcs,U2tot,U2trans,V2tot,V2trans,errFlag]=calc2ndmom(ucs,vcs,uucs,vvcs,uv);

[UVcs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(UVcs,ny,yc,ar,hc);
[U2tot_zav,mskzon,ylat,areazon]=calcZonalAvgCube(U2tot,ny,yc,ar,hc);
[V2tot_zav,mskzon,ylat,areazon]=calcZonalAvgCube(V2tot,ny,yc,ar,hc);

