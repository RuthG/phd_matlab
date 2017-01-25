%Read in u, v, ut, vt, theta
%calc v', v't'
%use chang 93 regression to get maps

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_2yearsdaily_pert/';

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

i=0;
for nit = 777840:240:864000
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'UVELTH  '));
uthcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vthcs(:,:,:,i) = dyn(:,:,:,J);
[uEth(:,:,:,i),vNth(:,:,:,i)] = rotate_uv2uvEN(uthcs(:,:,:,i),vthcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i) = dyn(:,:,:,J);

end

xi=-179:2:180;yi=-89:2:90;
vNll=single(cube2latlon(xc,yc,vN,xi,yi));
vNthll=single(cube2latlon(xc,yc,vNth,xi,yi));

[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN,ny,yc,ar,hc);
[theta_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta,ny,yc,ar,hc);

for i=1:180

vN_temp(:,:,:) = vNll(i,:,:,:);
vNth_temp(:,:,:) = vNthll(i,:,:,:);
vN_ed(i,:,:,:) = vN_temp(:,:,:) - vN_zav(:,:,:);
vNth_ed(i,:,:,:) = vNth_temp(:,:,:) - vN_zav(:,:,:).*theta_zav(:,:,:);

end

ved_var = mean( (vN_ed(90,64,10,:) - mean(vN_ed(90,64,10,:))).^2);
ved_ref = vN_ed(90,64,10,:)./sqrt(ved_var);

for i=1:180
  for j=1:90
    y = vN_ed(i,j,19,:);
    b1(i,j) = sum(  y.* ved_ref)./360.;
    y = vN_ed(i,j,4,:);
    b2(i,j) = sum(  y.* ved_ref)./360.;
    y = vNth_ed(i,j,4,:);
    b3(i,j) = sum(  y.* ved_ref)./360.;
  end
end

save('v_correlation_new_off_p.mat','b1','b2','b3','xi','yi')
