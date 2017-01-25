%check if sst pert has accomplished anything obvious...


%ep_flux.m
%Calculate ep_fluxes from v'Th' and u'v'

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_tropheat/';

slashes = findstr(rDir,'/');
point1 = slashes(max(size(slashes))-2);
dir_label = rDir(point1+1:max(size(rDir))-1);
dir_label = strrep(dir_label,'/','_');

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

%%%%%%%%%%%%%%%%%%%%%Control %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i=0;
for nit=691440:240:705600
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
theta(:,:,:,i) = dyn(:,:,:,J);

[uE_zav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(uE(:,:,:,i),ny,yc,ar,hc);
[vN_zav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(vN(:,:,:,i),ny,yc,ar,hc);
[theta_zav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(theta(:,:,:,i),ny,yc,ar,hc);
[w_zav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(w(:,:,:,i),ny,yc,ar,hc);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp(:,:,j,i)=theta(:,:,j,i).*convthetatoT(j,1);
end

[temp_zav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(temp(:,:,:,i),ny,yc,ar,hc);

end

for i=1:6
theta_tav(:,:,i) = mean(theta_zav(:,:, 10*i-9:10*i),3);
temp_tav(:,:,i) = mean(temp_zav(:,:, 10*i-9:10*i),3);
uE_tav(:,:,i) = mean(uE_zav(:,:,10*i-9:10*i),3);
w_tav(:,:,i) = mean(w_zav(:,:,10*i-9:10*i),3);
end



for i=1:6
figure
v=200:5:300;
contourf(temp_tav(:,:,i)',v)
colorbar
end

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';

nit=604800;
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_c = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_c = dyn(:,:,:,J);
[uE_c,vN_c] = rotate_uv2uvEN(ucs,vcs,AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_c = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVEL    '));
w_c = dyn(:,:,:,J);

[uE_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(uE_c,ny,yc,ar,hc);
[vN_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(vN_c,ny,yc,ar,hc);
[theta_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(theta_c,ny,yc,ar,hc);
[w_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(w_c,ny,yc,ar,hc);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_c(:,:,j)=theta_c(:,:,j).*convthetatoT(j,1);
end
[temp_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(temp_c,ny,yc,ar,hc);

for i=1:6
figure
contourf(temp_tav(:,:,i)'-temp_zav_c')
colorbar
end

for i=1:6
figure
contourf(w_tav(:,:,i)'-w_zav_c')
colorbar
end
