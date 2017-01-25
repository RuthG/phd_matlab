%Plot up the ke change as the heat pert is changed

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_2yeardaily_pert_2014/';

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

i=0;
for nit = 691440:240:864000;
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

save('ke_change_onoff.mat')

ke = uucs + vvcs;
ke_sum = sum(sum(sum(ke,1),2),3);
ke_sum = reshape(ke_sum,[720,1]);

plot(ke_sum)

