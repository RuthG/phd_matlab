%for the 4 varying water vapour climates we have, plot up one pdf of the 'key fields' and one of everything.
%key fields are u, theta, EP flux/divergence, psi, htrt, EKE
%everything is u, v, w, u'v', v'T', EKE, theta, T, q, heating terms


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

J=find(strcmp(fldList,'WVEL    '));
w_w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'SALT    '));
q_w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_w(:,:,j,i)=theta_w(:,:,j,i).*convthetatoT(j,1);
end

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

J=find(strcmp(fldList,'AtPhdTrd'));
radht_in=dyn(:,:,:,J);
radht_theta_w(:,:,:,i)=radht_in*86400.;

J=find(strcmp(fldList,'AtPhdTcd'));
cndht_in=dyn(:,:,:,J);
cndht_theta_w(:,:,:,i)=cndht_in*86400.;

J=find(strcmp(fldList,'AtPhdTdf'));
difht_in=dyn(:,:,:,J);
difht_theta_w(:,:,:,i)=difht_in*86400.;

J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_in=dyn(:,:,:,J);
cnvht_theta_w(:,:,:,i)=cnvht_in*86400.;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Half WV Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_h(:,:,:,i) = dyn(:,:,:,J);
[uE_h(:,:,:,i),vN_h(:,:,:,i)] = rotate_uv2uvEN(ucs_h(:,:,:,i),vcs_h(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'SALT    '));
q_h(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_h(:,:,j,i)=theta_h(:,:,j,i).*convthetatoT(j,1);
end

J=find(strcmp(fldList,'UV_VEL_C'));
uv_h(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_h(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_h(:,:,:,i),vNt_av_h(:,:,:,i)] = rotate_uv2uvEN(ut_av_h(:,:,:,i),vt_av_h(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'WVEL    '));
w_h(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELSQ  '));
vsq_av_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELSQ  '));
usq_av_h(:,:,:,i) = dyn(:,:,:,J);

tothke_h(:,:,:,i) = vsq_av_h(:,:,:,i) + usq_av_h(:,:,:,i);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_in=dyn(:,:,:,J);
htrt_theta_h(:,:,:,i)=htrt_in*86400.;

J=find(strcmp(fldList,'AtPhdTrd'));
radht_in=dyn(:,:,:,J);
radht_theta_h(:,:,:,i)=radht_in*86400.;

J=find(strcmp(fldList,'AtPhdTcd'));
cndht_in=dyn(:,:,:,J);
cndht_theta_h(:,:,:,i)=cndht_in*86400.;

J=find(strcmp(fldList,'AtPhdTdf'));
difht_in=dyn(:,:,:,J);
difht_theta_h(:,:,:,i)=difht_in*86400.;

J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_in=dyn(:,:,:,J);
cnvht_theta_h(:,:,:,i)=cnvht_in*86400.;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Quarter WV Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_quarterwv/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_q(:,:,:,i) = dyn(:,:,:,J);
[uE_q(:,:,:,i),vN_q(:,:,:,i)] = rotate_uv2uvEN(ucs_q(:,:,:,i),vcs_q(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'WVEL    '));
w_q(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'SALT    '));
q_q(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'THETA   '));
theta_q(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_q(:,:,j,i)=theta_q(:,:,j,i).*convthetatoT(j,1);
end

J=find(strcmp(fldList,'UV_VEL_C'));
uv_q(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_q(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_q(:,:,:,i),vNt_av_q(:,:,:,i)] = rotate_uv2uvEN(ut_av_q(:,:,:,i),vt_av_q(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'VVELSQ  '));
vsq_av_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELSQ  '));
usq_av_q(:,:,:,i) = dyn(:,:,:,J);

tothke_q(:,:,:,i) = vsq_av_q(:,:,:,i) + usq_av_q(:,:,:,i);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_in=dyn(:,:,:,J);
htrt_theta_q(:,:,:,i)=htrt_in*86400.;

J=find(strcmp(fldList,'AtPhdTrd'));
radht_in=dyn(:,:,:,J);
radht_theta_q(:,:,:,i)=radht_in*86400.;

J=find(strcmp(fldList,'AtPhdTcd'));
cndht_in=dyn(:,:,:,J);
cndht_theta_q(:,:,:,i)=cndht_in*86400.;

J=find(strcmp(fldList,'AtPhdTdf'));
difht_in=dyn(:,:,:,J);
difht_theta_q(:,:,:,i)=difht_in*86400.;

J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_in=dyn(:,:,:,J);
cnvht_theta_q(:,:,:,i)=cnvht_in*86400.;

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

J=find(strcmp(fldList,'WVEL    '));
w_d(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'SALT    '));
q_d(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'THETA   '));
theta_d(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_d(:,:,j,i)=theta_d(:,:,j,i).*convthetatoT(j,1);
end

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

J=find(strcmp(fldList,'AtPhdTrd'));
radht_in=dyn(:,:,:,J);
radht_theta_d(:,:,:,i)=radht_in*86400.;

J=find(strcmp(fldList,'AtPhdTcd'));
cndht_in=dyn(:,:,:,J);
cndht_theta_d(:,:,:,i)=cndht_in*86400.;

J=find(strcmp(fldList,'AtPhdTdf'));
difht_in=dyn(:,:,:,J);
difht_theta_d(:,:,:,i)=difht_in*86400.;

J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_in=dyn(:,:,:,J);
cnvht_theta_d(:,:,:,i)=cnvht_in*86400.;

end



%%%%%%%%%%%%%%%%%%%%%%% zavs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[uE_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_w,ny,yc,ar,hc);
[vN_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_w,ny,yc,ar,hc);
[w_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_w,ny,yc,ar,hc);
[q_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(q_w,ny,yc,ar,hc);
[theta_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_w,ny,yc,ar,hc);
[temp_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_w,ny,yc,ar,hc);
[uv_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_w,ny,yc,ar,hc);
[vt_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_w,ny,yc,ar,hc);
[htrt_theta_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_theta_w,ny,yc,ar,hc);
[radht_theta_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_theta_w,ny,yc,ar,hc);
[difht_theta_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_theta_w,ny,yc,ar,hc);
[cndht_theta_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_theta_w,ny,yc,ar,hc);
[cnvht_theta_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_theta_w,ny,yc,ar,hc);
[tothke_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tothke_w,ny,yc,ar,hc);
vt_ed_w_zav = vt_w_zav - vN_w_zav.*theta_w_zav;
uv_ed_w_zav = uv_w_zav - uE_w_zav.*vN_w_zav;
eke_w_zav = (tothke_w_zav - uE_w_zav.*uE_w_zav - vN_w_zav.*vN_w_zav)./2;

[uE_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_h,ny,yc,ar,hc);
[vN_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_h,ny,yc,ar,hc);
[w_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_h,ny,yc,ar,hc);
[q_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(q_h,ny,yc,ar,hc);
[theta_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_h,ny,yc,ar,hc);
[temp_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_h,ny,yc,ar,hc);
[uv_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_h,ny,yc,ar,hc);
[vt_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_h,ny,yc,ar,hc);
[htrt_theta_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_theta_h,ny,yc,ar,hc);
[radht_theta_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_theta_h,ny,yc,ar,hc);
[difht_theta_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_theta_h,ny,yc,ar,hc);
[cndht_theta_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_theta_h,ny,yc,ar,hc);
[cnvht_theta_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_theta_h,ny,yc,ar,hc);
[tothke_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tothke_h,ny,yc,ar,hc);
vt_ed_h_zav = vt_h_zav - vN_h_zav.*theta_h_zav;
uv_ed_h_zav = uv_h_zav - uE_h_zav.*vN_h_zav;
eke_h_zav = (tothke_h_zav - uE_h_zav.*uE_h_zav - vN_h_zav.*vN_h_zav)./2;

[uE_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_q,ny,yc,ar,hc);
[vN_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_q,ny,yc,ar,hc);[w_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_q,ny,yc,ar,hc);
[q_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(q_q,ny,yc,ar,hc);
[theta_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_q,ny,yc,ar,hc);
[temp_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_q,ny,yc,ar,hc);
[uv_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_q,ny,yc,ar,hc);
[vt_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_q,ny,yc,ar,hc);
[htrt_theta_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_theta_q,ny,yc,ar,hc);
[radht_theta_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_theta_q,ny,yc,ar,hc);
[difht_theta_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_theta_q,ny,yc,ar,hc);
[cndht_theta_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_theta_q,ny,yc,ar,hc);
[cnvht_theta_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_theta_q,ny,yc,ar,hc);
[tothke_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tothke_q,ny,yc,ar,hc);
vt_ed_q_zav = vt_q_zav - vN_q_zav.*theta_q_zav;
uv_ed_q_zav = uv_q_zav - uE_q_zav.*vN_q_zav;
eke_q_zav = (tothke_q_zav - uE_q_zav.*uE_q_zav - vN_q_zav.*vN_q_zav)./2;

[uE_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_d,ny,yc,ar,hc);
[vN_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_d,ny,yc,ar,hc);[w_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_d,ny,yc,ar,hc);
[q_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(q_d,ny,yc,ar,hc);
[theta_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_d,ny,yc,ar,hc);
[temp_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_d,ny,yc,ar,hc);
[uv_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_d,ny,yc,ar,hc);
[vt_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_d,ny,yc,ar,hc);
[htrt_theta_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_theta_d,ny,yc,ar,hc);
[radht_theta_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_theta_d,ny,yc,ar,hc);
[difht_theta_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_theta_d,ny,yc,ar,hc);
[cndht_theta_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_theta_d,ny,yc,ar,hc);
[cnvht_theta_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_theta_d,ny,yc,ar,hc);
[tothke_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tothke_d,ny,yc,ar,hc);
vt_ed_d_zav = vt_d_zav - vN_d_zav.*theta_d_zav;
uv_ed_d_zav = uv_d_zav - uE_d_zav.*vN_d_zav;
eke_d_zav = (tothke_d_zav - uE_d_zav.*uE_d_zav - vN_d_zav.*vN_d_zav)./2;


%%%%%%%%%%%%%%%%%%%%%%%% t-av/h-av %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uE_w_tzav = mean(uE_w_zav,3);
vN_w_tzav = mean(vN_w_zav,3);
w_w_tzav = mean(w_w_zav,3);
q_w_tzav = mean(q_w_zav,3);
theta_w_tzav = mean(theta_w_zav,3);
temp_w_tzav = mean(temp_w_zav,3);
htrt_w_tzav = mean(htrt_theta_w_zav,3);
radht_w_tzav = mean(radht_theta_w_zav,3);
difht_w_tzav = mean(difht_theta_w_zav,3);
cndht_w_tzav = mean(cndht_theta_w_zav,3);
cnvht_w_tzav = mean(cnvht_theta_w_zav,3);
vt_ed_w_tzav = mean(vt_ed_w_zav,3);
uv_ed_w_tzav = mean(uv_ed_w_zav,3);
eke_w_tav = mean(eke_w_zav,3);

uE_h_tzav = mean(uE_h_zav,3);
vN_h_tzav = mean(vN_h_zav,3);
w_h_tzav = mean(w_h_zav,3);
q_h_tzav = mean(q_h_zav,3);
theta_h_tzav = mean(theta_h_zav,3);
temp_h_tzav = mean(temp_h_zav,3);
htrt_h_tzav = mean(htrt_theta_h_zav,3);
radht_h_tzav = mean(radht_theta_h_zav,3);
difht_h_tzav = mean(difht_theta_h_zav,3);
cndht_h_tzav = mean(cndht_theta_h_zav,3);
cnvht_h_tzav = mean(cnvht_theta_h_zav,3);
vt_ed_h_tzav = mean(vt_ed_h_zav,3);
uv_ed_h_tzav = mean(uv_ed_h_zav,3);
eke_h_tav = mean(eke_h_zav,3);

uE_q_tzav = mean(uE_q_zav,3);
vN_q_tzav = mean(vN_q_zav,3);
w_q_tzav = mean(w_q_zav,3);
q_q_tzav = mean(q_q_zav,3);
theta_q_tzav = mean(theta_q_zav,3);
temp_q_tzav = mean(temp_q_zav,3);
htrt_q_tzav = mean(htrt_theta_q_zav,3);
radht_q_tzav = mean(radht_theta_q_zav,3);
difht_q_tzav = mean(difht_theta_q_zav,3);
cndht_q_tzav = mean(cndht_theta_q_zav,3);
cnvht_q_tzav = mean(cnvht_theta_q_zav,3);
vt_ed_q_tzav = mean(vt_ed_q_zav,3);
uv_ed_q_tzav = mean(uv_ed_q_zav,3);
eke_q_tav = mean(eke_q_zav,3);

uE_d_tzav = mean(uE_d_zav,3);
vN_d_tzav = mean(vN_d_zav,3);
w_d_tzav = mean(w_d_zav,3);
q_d_tzav = mean(q_d_zav,3);
theta_d_tzav = mean(theta_d_zav,3);
temp_d_tzav = mean(temp_d_zav,3);
htrt_d_tzav = mean(htrt_theta_d_zav,3);
radht_d_tzav = mean(radht_theta_d_zav,3);
difht_d_tzav = mean(difht_theta_d_zav,3);
cndht_d_tzav = mean(cndht_theta_d_zav,3);
cnvht_d_tzav = mean(cnvht_theta_d_zav,3);
vt_ed_d_tzav = mean(vt_ed_d_zav,3);
uv_ed_d_tzav = mean(uv_ed_d_zav,3);
eke_d_tav = mean(eke_d_zav,3);

for i=1:45
uE_w_hzav(46-i,:) = (uE_w_tzav(i,:) + uE_w_tzav(91-i,:))./2;
vN_w_hzav(46-i,:) = (-1*vN_w_tzav(i,:) + vN_w_tzav(91-i,:))./2;
w_w_hzav(46-i,:) = (w_w_tzav(i,:) + w_w_tzav(91-i,:))./2;
q_w_hzav(46-i,:) = (q_w_tzav(i,:) + q_w_tzav(91-i,:))./2;
theta_w_hzav(46-i,:) = (theta_w_tzav(i,:) + theta_w_tzav(91-i,:))./2;
temp_w_hzav(46-i,:) = (temp_w_tzav(i,:) + temp_w_tzav(91-i,:))./2;
htrt_w_hzav(46-i,:) = (htrt_w_tzav(i,:) + htrt_w_tzav(91-i,:))./2;
radht_w_hzav(46-i,:) = (radht_w_tzav(i,:) + radht_w_tzav(91-i,:))./2;
difht_w_hzav(46-i,:) = (difht_w_tzav(i,:) + difht_w_tzav(91-i,:))./2;
cnvht_w_hzav(46-i,:) = (cnvht_w_tzav(i,:) + cnvht_w_tzav(91-i,:))./2;
cndht_w_hzav(46-i,:) = (cndht_w_tzav(i,:) + cndht_w_tzav(91-i,:))./2;
uv_ed_w_hzav(46-i,:) = (-1*uv_ed_w_tzav(i,:) + uv_ed_w_tzav(91-i,:))./2;
vt_ed_w_hzav(46-i,:) = (-1*vt_ed_w_tzav(i,:) + vt_ed_w_tzav(91-i,:))./2;
eke_w_hzav(46-i,:) = (eke_w_tav(i,:) + eke_w_tav(91-i,:))./2;

uE_h_hzav(46-i,:) = (uE_h_tzav(i,:) + uE_h_tzav(91-i,:))./2;
vN_h_hzav(46-i,:) = (-1*vN_h_tzav(i,:) + vN_h_tzav(91-i,:))./2;
w_h_hzav(46-i,:) = (w_h_tzav(i,:) + w_h_tzav(91-i,:))./2;
q_h_hzav(46-i,:) = (q_h_tzav(i,:) + q_h_tzav(91-i,:))./2;
theta_h_hzav(46-i,:) = (theta_h_tzav(i,:) + theta_h_tzav(91-i,:))./2;
temp_h_hzav(46-i,:) = (temp_h_tzav(i,:) + temp_h_tzav(91-i,:))./2;
htrt_h_hzav(46-i,:) = (htrt_h_tzav(i,:) + htrt_h_tzav(91-i,:))./2;
radht_h_hzav(46-i,:) = (radht_h_tzav(i,:) + radht_h_tzav(91-i,:))./2;
difht_h_hzav(46-i,:) = (difht_h_tzav(i,:) + difht_h_tzav(91-i,:))./2;
cnvht_h_hzav(46-i,:) = (cnvht_h_tzav(i,:) + cnvht_h_tzav(91-i,:))./2;
cndht_h_hzav(46-i,:) = (cndht_h_tzav(i,:) + cndht_h_tzav(91-i,:))./2;
uv_ed_h_hzav(46-i,:) = (-1*uv_ed_h_tzav(i,:) + uv_ed_h_tzav(91-i,:))./2;
vt_ed_h_hzav(46-i,:) = (-1*vt_ed_h_tzav(i,:) + vt_ed_h_tzav(91-i,:))./2;
eke_h_hzav(46-i,:) = (eke_h_tav(i,:) + eke_h_tav(91-i,:))./2;

uE_q_hzav(46-i,:) = (uE_q_tzav(i,:) + uE_q_tzav(91-i,:))./2;
vN_q_hzav(46-i,:) = (-1*vN_q_tzav(i,:) + vN_q_tzav(91-i,:))./2;
w_q_hzav(46-i,:) = (w_q_tzav(i,:) + w_q_tzav(91-i,:))./2;
q_q_hzav(46-i,:) = (q_q_tzav(i,:) + q_q_tzav(91-i,:))./2;
theta_q_hzav(46-i,:) = (theta_q_tzav(i,:) + theta_q_tzav(91-i,:))./2;
temp_q_hzav(46-i,:) = (temp_q_tzav(i,:) + temp_q_tzav(91-i,:))./2;
htrt_q_hzav(46-i,:) = (htrt_q_tzav(i,:) + htrt_q_tzav(91-i,:))./2;
radht_q_hzav(46-i,:) = (radht_q_tzav(i,:) + radht_q_tzav(91-i,:))./2;
difht_q_hzav(46-i,:) = (difht_q_tzav(i,:) + difht_q_tzav(91-i,:))./2;
cnvht_q_hzav(46-i,:) = (cnvht_q_tzav(i,:) + cnvht_q_tzav(91-i,:))./2;
cndht_q_hzav(46-i,:) = (cndht_q_tzav(i,:) + cndht_q_tzav(91-i,:))./2;
uv_ed_q_hzav(46-i,:) = (-1*uv_ed_q_tzav(i,:) + uv_ed_q_tzav(91-i,:))./2;
vt_ed_q_hzav(46-i,:) = (-1*vt_ed_q_tzav(i,:) + vt_ed_q_tzav(91-i,:))./2;
eke_q_hzav(46-i,:) = (eke_q_tav(i,:) + eke_q_tav(91-i,:))./2;

uE_d_hzav(46-i,:) = (uE_d_tzav(i,:) + uE_d_tzav(91-i,:))./2;
vN_d_hzav(46-i,:) = (-1*vN_d_tzav(i,:) + vN_d_tzav(91-i,:))./2;
w_d_hzav(46-i,:) = (w_d_tzav(i,:) + w_d_tzav(91-i,:))./2;
q_d_hzav(46-i,:) = (q_d_tzav(i,:) + q_d_tzav(91-i,:))./2;
theta_d_hzav(46-i,:) = (theta_d_tzav(i,:) + theta_d_tzav(91-i,:))./2;
temp_d_hzav(46-i,:) = (temp_d_tzav(i,:) + temp_d_tzav(91-i,:))./2;
htrt_d_hzav(46-i,:) = (htrt_d_tzav(i,:) + htrt_d_tzav(91-i,:))./2;
radht_d_hzav(46-i,:) = (radht_d_tzav(i,:) + radht_d_tzav(91-i,:))./2;
difht_d_hzav(46-i,:) = (difht_d_tzav(i,:) + difht_d_tzav(91-i,:))./2;
cnvht_d_hzav(46-i,:) = (cnvht_d_tzav(i,:) + cnvht_d_tzav(91-i,:))./2;
cndht_d_hzav(46-i,:) = (cndht_d_tzav(i,:) + cndht_d_tzav(91-i,:))./2;
uv_ed_d_hzav(46-i,:) = (-1*uv_ed_d_tzav(i,:) + uv_ed_d_tzav(91-i,:))./2;
vt_ed_d_hzav(46-i,:) = (-1*vt_ed_d_tzav(i,:) + vt_ed_d_tzav(91-i,:))./2;
eke_d_hzav(46-i,:) = (eke_d_tav(i,:) + eke_d_tav(91-i,:))./2;

end





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 21.0;                  %# A4 paper size
X = 29.7;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 2*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 2*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.4;
xSize_sub = 1./2-0.1;

pos1x = 0.1 ; 	pos1y = 1/2+0.05;
pos2x = 0.55;	pos2y = 1/2+0.05;
pos3x = 0.1; 	pos3y = 0.05;
pos4x = 0.55; 	pos4y = 0.05;



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-25:5:0;
[C,h]=contour(ylat(46:90),rC./100.,uE_w_hzav',v,'k--');
clabel(C,h);
hold on
v=0:5:45;
[C,h]=contour(ylat(46:90),rC./100.,uE_w_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(a)'],'color','k','fontw','b')
hold off

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-25:5:0;
[C,h]=contour(ylat(46:90),rC./100.,uE_h_hzav',v,'k--');
clabel(C,h);
hold on
v=0:5:45;
[C,h]=contour(ylat(46:90),rC./100.,uE_h_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(b)'],'color','k','fontw','b')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-25:5:0;
[C,h]=contour(ylat(46:90),rC./100.,uE_q_hzav',v,'k--');
clabel(C,h);
hold on
v=0:5:45;
[C,h]=contour(ylat(46:90),rC./100.,uE_q_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(c)'],'color','k','fontw','b')
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-25:5:0;
[C,h]=contour(ylat(46:90),rC./100.,uE_d_hzav',v,'k--');
clabel(C,h);
hold on
v=0:5:45;
[C,h]=contour(ylat(46:90),rC./100.,uE_d_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(d)'],'color','k','fontw','b')
hold off

print('-dpdf','u.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,vN_w_hzav',v,'k--');
clabel(C,h);
hold on
v=0:1:6;
[C,h]=contour(ylat(46:90),rC./100.,vN_w_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(a)'],'color','k','fontw','b')
hold off

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,vN_h_hzav',v,'k--');
clabel(C,h);
hold on
v=0:1:6;
[C,h]=contour(ylat(46:90),rC./100.,vN_h_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(b)'],'color','k','fontw','b')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,vN_q_hzav',v,'k--');
clabel(C,h);
hold on
v=0:1:6;
[C,h]=contour(ylat(46:90),rC./100.,vN_q_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(c)'],'color','k','fontw','b')
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,vN_d_hzav',v,'k--');
clabel(C,h);
hold on
v=0:1:6;
[C,h]=contour(ylat(46:90),rC./100.,vN_d_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(d)'],'color','k','fontw','b')
hold off

print('-dpdf','v.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-0.2:0.02:0;
[C,h]=contour(ylat(46:90),rC./100.,w_w_hzav',v,'k--');
labels = [-0.08,-0.04,0,0.02];
clabel(C,h,labels);
hold on
v=0:0.02:0.1;
[C,h]=contour(ylat(46:90),rC./100.,w_w_hzav',v,'k');
clabel(C,h,labels);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(a)'],'color','k','fontw','b')
hold off

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-0.2:0.02:0;
[C,h]=contour(ylat(46:90),rC./100.,w_h_hzav',v,'k--');
labels = [-0.12,-0.06,0,0.02];
clabel(C,h,labels);
hold on
v=0:0.02:0.1;
[C,h]=contour(ylat(46:90),rC./100.,w_h_hzav',v,'k');
clabel(C,h,labels);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(b)'],'color','k','fontw','b')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-0.2:0.02:0;
[C,h]=contour(ylat(46:90),rC./100.,w_q_hzav',v,'k--');
labels = [-0.14,-0.06,0,0.02];
clabel(C,h,labels);
hold on
v=0:0.02:0.1;
[C,h]=contour(ylat(46:90),rC./100.,w_q_hzav',v,'k');
clabel(C,h,labels);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(c)'],'color','k','fontw','b')
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-0.2:0.02:0;
[C,h]=contour(ylat(46:90),rC./100.,w_d_hzav',v,'k--');
labels = [-0.16,-0.08,0,0.04,0.08];
clabel(C,h,labels);
hold on
v=0:0.02:0.1;
[C,h]=contour(ylat(46:90),rC./100.,w_d_hzav',v,'k');
clabel(C,h,labels);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(d)'],'color','k','fontw','b')
hold off

print('-dpdf','w.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-25:5:0;
[C,h]=contour(ylat(46:90),rC./100.,uv_ed_w_hzav',v,'k--');
clabel(C,h);
hold on
v=0:5:45;
[C,h]=contour(ylat(46:90),rC./100.,uv_ed_w_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(a)'],'color','k','fontw','b')
hold off

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-25:5:0;
[C,h]=contour(ylat(46:90),rC./100.,uv_ed_h_hzav',v,'k--');
clabel(C,h);
hold on
v=0:5:45;
[C,h]=contour(ylat(46:90),rC./100.,uv_ed_h_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(b)'],'color','k','fontw','b')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-25:5:0;
[C,h]=contour(ylat(46:90),rC./100.,uv_ed_q_hzav',v,'k--');
clabel(C,h);
hold on
v=0:5:45;
[C,h]=contour(ylat(46:90),rC./100.,uv_ed_q_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(c)'],'color','k','fontw','b')
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-25:5:0;
[C,h]=contour(ylat(46:90),rC./100.,uv_ed_d_hzav',v,'k--');
clabel(C,h);
hold on
v=0:5:45;
[C,h]=contour(ylat(46:90),rC./100.,uv_ed_d_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(d)'],'color','k','fontw','b')
hold off

print('-dpdf','uv_ed.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-4:4:0;
[C,h]=contour(ylat(46:90),rC./100.,vt_ed_w_hzav',v,'k--');
clabel(C,h);
hold on
v=0:4:30;
[C,h]=contour(ylat(46:90),rC./100.,vt_ed_w_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(a)'],'color','k','fontw','b')
hold off

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-4:4:0;
[C,h]=contour(ylat(46:90),rC./100.,vt_ed_h_hzav',v,'k--');
clabel(C,h);
hold on
v=0:4:30;
[C,h]=contour(ylat(46:90),rC./100.,vt_ed_h_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(b)'],'color','k','fontw','b')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-4:4:0;
[C,h]=contour(ylat(46:90),rC./100.,vt_ed_q_hzav',v,'k--');
clabel(C,h);
hold on
v=0:4:30;
[C,h]=contour(ylat(46:90),rC./100.,vt_ed_q_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(c)'],'color','k','fontw','b')
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-4:4:0;
[C,h]=contour(ylat(46:90),rC./100.,vt_ed_d_hzav',v,'k--');
clabel(C,h);
hold on
v=0:4:30;
[C,h]=contour(ylat(46:90),rC./100.,vt_ed_d_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(d)'],'color','k','fontw','b')
hold off

print('-dpdf','vt_ed.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v = 200:30:750;
[C,h]=contour(ylat(46:90),rC./100.,theta_w_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')
hold off


axes('position',[pos2x pos2y xSize_sub ySize_sub])
v = 200:30:750;
[C,h]=contour(ylat(46:90),rC./100.,theta_h_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v = 200:30:750;
[C,h]=contour(ylat(46:90),rC./100.,theta_q_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v = 200:30:750;
[C,h]=contour(ylat(46:90),rC./100.,theta_d_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
set(gca, 'YTickLabel', []);
hold off
%text(-.15,-0.9,['(f)'],'color','k','fontw','b')

print('-dpdf','theta.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v = 180:20:320;
[C,h]=contour(ylat(46:90),rC./100.,temp_w_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')
hold off


axes('position',[pos2x pos2y xSize_sub ySize_sub])
v = 180:20:320;
[C,h]=contour(ylat(46:90),rC./100.,temp_h_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v = 180:20:320;
[C,h]=contour(ylat(46:90),rC./100.,temp_q_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v = 180:20:320;
[C,h]=contour(ylat(46:90),rC./100.,temp_d_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
set(gca, 'YTickLabel', []);
hold off
%text(-.15,-0.9,['(f)'],'color','k','fontw','b')

print('-dpdf','temp.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=0:20:300;
[C,h]=contour(ylat(46:90),rC./100.,eke_w_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
%text(-.15,-0.9,['(c)'],'color','k','fontw','b')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=0:20:300;
[C,h]=contour(ylat(46:90),rC./100.,eke_h_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
hold off
%text(-.15,-0.9,['(c)'],'color','k','fontw','b')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=0:20:300;
[C,h]=contour(ylat(46:90),rC./100.,eke_q_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
%text(-.15,-0.9,['(c)'],'color','k','fontw','b')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=0:20:300;
[C,h]=contour(ylat(46:90),rC./100.,eke_d_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
set(gca, 'YTickLabel', []);
hold off
%text(-.15,-0.9,['(d)'],'color','k','fontw','b')

print('-dpdf','eke.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-4:0.5:0;
[C,h]=contour(ylat(46:90),rC./100.,radht_w_hzav',v,'k--');
clabel(C,h);
hold on
v=0:0.5:1;
[C,h]=contour(ylat(46:90),rC./100.,radht_w_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')


axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-4:0.5:0;
[C,h]=contour(ylat(46:90),rC./100.,radht_h_hzav',v,'k--');
clabel(C,h);
hold on
v=0:0.5:1;
[C,h]=contour(ylat(46:90),rC./100.,radht_h_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
hold off
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')


axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-4:0.5:0;
[C,h]=contour(ylat(46:90),rC./100.,radht_q_hzav',v,'k--');
clabel(C,h);
hold on
v=0:0.5:1;
[C,h]=contour(ylat(46:90),rC./100.,radht_q_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-4:0.5:0;
[C,h]=contour(ylat(46:90),rC./100.,radht_d_hzav',v,'k--');
clabel(C,h);
hold on
v=0:0.5:1;
[C,h]=contour(ylat(46:90),rC./100.,radht_d_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
set(gca, 'YTickLabel', []);
hold off
%text(-.15,-0.9,['(f)'],'color','k','fontw','b')

print('-dpdf','radht.pdf')




hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-2:0.5:0;
[C,h]=contour(ylat(46:90),rC./100.,difht_w_hzav',v,'k--');
clabel(C,h);
hold on
v=0:0.5:4;
[C,h]=contour(ylat(46:90),rC./100.,difht_w_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')


axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-2:0.5:0;
[C,h]=contour(ylat(46:90),rC./100.,difht_h_hzav',v,'k--');
clabel(C,h);
hold on
v=0:0.5:4;
[C,h]=contour(ylat(46:90),rC./100.,difht_h_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
hold off
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')


axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-2:0.5:0;
[C,h]=contour(ylat(46:90),rC./100.,difht_q_hzav',v,'k--');
clabel(C,h);
hold on
v=0:0.5:4;
[C,h]=contour(ylat(46:90),rC./100.,difht_q_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-2:0.5:0;
[C,h]=contour(ylat(46:90),rC./100.,difht_d_hzav',v,'k--');
clabel(C,h);
hold on
v=0:0.5:4;
[C,h]=contour(ylat(46:90),rC./100.,difht_d_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
set(gca, 'YTickLabel', []);
hold off
%text(-.15,-0.9,['(f)'],'color','k','fontw','b')

print('-dpdf','difht.pdf')





hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-1:0.2:0;
[C,h]=contour(ylat(46:90),rC./100.,cnvht_w_hzav',v,'k--');
clabel(C,h);
hold on
v=0:0.2:1.4;
[C,h]=contour(ylat(46:90),rC./100.,cnvht_w_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')


axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-1:0.2:0;
[C,h]=contour(ylat(46:90),rC./100.,cnvht_h_hzav',v,'k--');
clabel(C,h);
hold on
v=0:0.2:1.4;
[C,h]=contour(ylat(46:90),rC./100.,cnvht_h_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
hold off
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')


axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-1:0.2:0;
[C,h]=contour(ylat(46:90),rC./100.,cnvht_q_hzav',v,'k--');
clabel(C,h);
hold on
v=0:0.2:1.4;
[C,h]=contour(ylat(46:90),rC./100.,cnvht_q_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-1:0.2:0;
[C,h]=contour(ylat(46:90),rC./100.,cnvht_d_hzav',v,'k--');
clabel(C,h);
hold on
v=0:0.2:1.4;
[C,h]=contour(ylat(46:90),rC./100.,cnvht_d_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
set(gca, 'YTickLabel', []);
hold off
%text(-.15,-0.9,['(f)'],'color','k','fontw','b')

print('-dpdf','cnvht.pdf')





hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,cndht_w_hzav',v,'k--');
clabel(C,h);
hold on
v=0:1:6;
[C,h]=contour(ylat(46:90),rC./100.,cndht_w_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')


axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,cndht_h_hzav',v,'k--');
clabel(C,h);
hold on
v=0:1:6;
[C,h]=contour(ylat(46:90),rC./100.,cndht_h_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
hold off
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')


axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,cndht_q_hzav',v,'k--');
clabel(C,h);
hold on
v=0:1:6;
[C,h]=contour(ylat(46:90),rC./100.,cndht_q_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,cndht_d_hzav',v,'k--');
clabel(C,h);
hold on
v=0:1:6;
[C,h]=contour(ylat(46:90),rC./100.,cndht_d_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
set(gca, 'YTickLabel', []);
hold off
%text(-.15,-0.9,['(f)'],'color','k','fontw','b')

print('-dpdf','cndht.pdf')





hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,htrt_w_hzav',v,'k--');
clabel(C,h);
hold on
v=0:1:6.5;
[C,h]=contour(ylat(46:90),rC./100.,htrt_w_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')


axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,htrt_h_hzav',v,'k--');
clabel(C,h);
hold on
v=0:1:6.5;
[C,h]=contour(ylat(46:90),rC./100.,htrt_h_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
hold off
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')


axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,htrt_q_hzav',v,'k--');
clabel(C,h);
hold on
v=0:1:6.5;
[C,h]=contour(ylat(46:90),rC./100.,htrt_q_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,htrt_d_hzav',v,'k--');
clabel(C,h);
hold on
v=0:1:6.5;
[C,h]=contour(ylat(46:90),rC./100.,htrt_d_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
set(gca, 'YTickLabel', []);
hold off
%text(-.15,-0.9,['(f)'],'color','k','fontw','b')

print('-dpdf','htrt.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,q_w_hzav',v,'k--');
clabel(C,h);
hold on
v=0:2.5:20;
[C,h]=contour(ylat(46:90),rC./100.,q_w_hzav'./0.001,v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')


axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,q_h_hzav',v,'k--');
clabel(C,h);
hold on
v=0:2.5:20;
[C,h]=contour(ylat(46:90),rC./100.,q_h_hzav'./0.001,v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
%ylabel('Pressure, hPa')
set(gca, 'YTickLabel', []);
hold off
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')


axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,q_q_hzav',v,'k--');
clabel(C,h);
hold on
v=0:2.5:20;
[C,h]=contour(ylat(46:90),rC./100.,q_q_hzav'./0.001,v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
hold off
%text(-.15,-0.9,['(e)'],'color','k','fontw','b')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-6:1:0;
[C,h]=contour(ylat(46:90),rC./100.,q_d_hzav',v,'k--');
clabel(C,h);
hold on
v=0:2.5:20;
[C,h]=contour(ylat(46:90),rC./100.,q_d_hzav'./0.001,v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
set(gca, 'YTickLabel', []);
hold off
%text(-.15,-0.9,['(f)'],'color','k','fontw','b')

print('-dpdf','q.pdf')
