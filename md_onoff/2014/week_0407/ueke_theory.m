%Read in iteration number, directory, MITgcm output and grid details

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Wet Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i) = dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_w(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_w(:,:,:,i),vNt_av_w(:,:,:,i)] = rotate_uv2uvEN(ut_av_w(:,:,:,i),vt_av_w(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'VVELSQ  '));
vsq_av_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELSQ  '));
usq_av_w(:,:,:,i) = dyn(:,:,:,J);

tothke_w(:,:,:,i) = vsq_av_w(:,:,:,i) + usq_av_w(:,:,:,i);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_in=dyn(:,:,:,J);
htrt_theta_w(:,:,:,i)=htrt_in*86400.;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Dry Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_d(:,:,:,i) = dyn(:,:,:,J);
[uE_d(:,:,:,i),vN_d(:,:,:,i)] = rotate_uv2uvEN(ucs_d(:,:,:,i),vcs_d(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_d(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_d(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_d(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_d(:,:,:,i),vNt_av_d(:,:,:,i)] = rotate_uv2uvEN(ut_av_d(:,:,:,i),vt_av_d(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'VVELSQ  '));
vsq_av_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELSQ  '));
usq_av_d(:,:,:,i) = dyn(:,:,:,J);

tothke_d(:,:,:,i) = vsq_av_d(:,:,:,i) + usq_av_d(:,:,:,i);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_in=dyn(:,:,:,J);
htrt_theta_d(:,:,:,i)=htrt_in*86400.;


end
