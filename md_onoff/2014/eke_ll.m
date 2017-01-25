%load up data for 1st ten days after wv switched on
%calculate EKE in lat lon coords
%plot up

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_wvspinup/';

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Load data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=system('find ekell_data.mat');

if a > 0

i=0;
for nit = 775440:240:777600;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'UVELSQ  '));
uucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSQ  '));
vvcs(:,:,:,i) = dyn(:,:,:,J);

end

save('ekell_data.mat')

else

load('ekell_data.mat')

end

ke = uucs + vvcs;

[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE,ny,yc,ar,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN,ny,yc,ar,hc);

xi=-179:2:180;yi=-89:2:90;

for i=1:10
uEuE_zav(:,:,i) = uE_zav(:,:,i).^2;
vNvN_zav(:,:,i) = vN_zav(:,:,i).^2;

kell(:,:,:,i)=cube2latlon(xc,yc,ke(:,:,:,i),xi,yi);
end

for i=1:180

kell_h(:,:,:) = kell(i,:,:,:);

ekell(i,:,:,:) = kell_h(:,:,:) - uEuE_zav(:,:,:) - vNvN_zav(:,:,:);

end


