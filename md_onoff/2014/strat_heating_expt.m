%load up data from strat heating expt and see if we now see the 'right' pattern...

%Read in iteration number, directory, MITgcm output and grid details
rDir_control='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';
rDir_perturbed='/disk1/MITgcm/verification/atm_gray_ruth/run/';

rDir=rDir_control;
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
%%%%%%%%%%%%%%%%%%%%%%%% Control Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir = rDir_control;

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_ctrl(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_ctrl(:,:,:,i) = dyn(:,:,:,J);
[uE_ctrl(:,:,:,i),vN_ctrl(:,:,:,i)] = rotate_uv2uvEN(ucs_ctrl(:,:,:,i),vcs_ctrl(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_ctrl(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_ctrl(:,:,j,i)=theta_ctrl(:,:,j,i).*convthetatoT(j,1);
end

J=find(strcmp(fldList,'UV_VEL_C'));
uv_ctrl(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_ctrl(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_ctrl(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_ctrl(:,:,:,i),vNt_av_ctrl(:,:,:,i)] = rotate_uv2uvEN(ut_av_ctrl(:,:,:,i),vt_av_ctrl(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'WVEL    '));
w_ctrl(:,:,:,i)=dyn(:,:,:,J);

J=find(strcmp(fldList,'SALT    '));
q_ctrl(:,:,:,i)=dyn(:,:,:,J);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_in=dyn(:,:,:,J);
htrt_theta_ctrl(:,:,:,i)=htrt_in*86400.;

J=find(strcmp(fldList,'AtPhdTrd'));
radht_in=dyn(:,:,:,J);
radht_theta_ctrl(:,:,:,i)=radht_in*86400.;

J=find(strcmp(fldList,'AtPhdTcd'));
cndht_in=dyn(:,:,:,J);
cndht_theta_ctrl(:,:,:,i)=cndht_in*86400.;

J=find(strcmp(fldList,'AtPhdTdf'));
difht_in=dyn(:,:,:,J);
difht_theta_ctrl(:,:,:,i)=difht_in*86400.;

J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_in=dyn(:,:,:,J);
cnvht_theta_ctrl(:,:,:,i)=cnvht_in*86400.;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Perturbed Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir = rDir_perturbed;

i=0
for nit = 950400:86400:1036800
i=i+1
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_pert(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_pert(:,:,:,i) = dyn(:,:,:,J);
[uE_pert(:,:,:,i),vN_pert(:,:,:,i)] = rotate_uv2uvEN(ucs_pert(:,:,:,i),vcs_pert(:,:,:,i),AngleCS,AngleSN,Grid);


J=find(strcmp(fldList,'THETA   '));
theta_pert(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_pert(:,:,j,i)=theta_pert(:,:,j,i).*convthetatoT(j,1);
end

J=find(strcmp(fldList,'UV_VEL_C'));
uv_pert(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_pert(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_pert(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_pert(:,:,:,i),vNt_av_pert(:,:,:,i)] = rotate_uv2uvEN(ut_av_pert(:,:,:,i),vt_av_pert(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'WVEL    '));
w_pert(:,:,:,i)=dyn(:,:,:,J);

J=find(strcmp(fldList,'SALT    '));
q_pert(:,:,:,i)=dyn(:,:,:,J);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_in=dyn(:,:,:,J);
htrt_theta_pert(:,:,:,i)=htrt_in*86400.;

J=find(strcmp(fldList,'AtPhdTrd'));
radht_in=dyn(:,:,:,J);
radht_theta_pert(:,:,:,i)=radht_in*86400.;

J=find(strcmp(fldList,'AtPhdTcd'));
cndht_in=dyn(:,:,:,J);
cndht_theta_pert(:,:,:,i)=cndht_in*86400.;

J=find(strcmp(fldList,'AtPhdTdf'));
difht_in=dyn(:,:,:,J);
difht_theta_pert(:,:,:,i)=difht_in*86400.;

J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_in=dyn(:,:,:,J);
cnvht_theta_pert(:,:,:,i)=cnvht_in*86400.;

end


uE_ctrl_mean = mean(uE_ctrl,4);
vN_ctrl_mean = mean(vN_ctrl,4);
theta_ctrl_mean = mean(theta_ctrl,4);
temp_ctrl_mean = mean(temp_ctrl,4);
uv_ctrl_mean = mean(uv_ctrl,4);
vt_ctrl_mean = mean(vNt_av_ctrl,4);
w_ctrl_mean = mean(w_ctrl,4);
q_ctrl_mean = mean(q_ctrl,4);
htrt_ctrl_mean = mean(htrt_theta_ctrl,4);
radht_ctrl_mean = mean(radht_theta_ctrl,4);
cndht_ctrl_mean = mean(cndht_theta_ctrl,4);
cnvht_ctrl_mean = mean(cnvht_theta_ctrl,4);
difht_ctrl_mean = mean(difht_theta_ctrl,4);


uE_pert_mean = mean(uE_pert,4);
vN_pert_mean = mean(vN_pert,4);
theta_pert_mean = mean(theta_pert,4);
temp_pert_mean = mean(temp_pert,4);
uv_pert_mean = mean(uv_pert,4);
vt_pert_mean = mean(vNt_av_pert,4);
w_pert_mean = mean(w_pert,4);
q_pert_mean = mean(q_pert,4);
htrt_pert_mean = mean(htrt_theta_pert,4);
radht_pert_mean = mean(radht_theta_pert,4);
cndht_pert_mean = mean(cndht_theta_pert,4);
cnvht_pert_mean = mean(cnvht_theta_pert,4);
difht_pert_mean = mean(difht_theta_pert,4);


%take zonal averages for plots

[uE_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(uE_ctrl_mean,ny,yc,ar,hc);
[vN_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(vN_ctrl_mean,ny,yc,ar,hc);
[theta_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(theta_ctrl_mean,ny,yc,ar,hc);
[temp_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(temp_ctrl_mean,ny,yc,ar,hc);
[uv_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ctrl_mean,ny,yc,ar,hc); 
uv_ed_zav_c = uv_zav_c - uE_zav_c.*vN_zav_c;
[vt_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(vt_ctrl_mean,ny,yc,ar,hc); 
vt_ed_zav_c = vt_zav_c - vN_zav_c.*theta_zav_c;
[w_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(w_ctrl_mean,ny,yc,ar,hc);
[q_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(q_ctrl_mean,ny,yc,ar,hc);
[htrt_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_ctrl_mean,ny,yc,ar,hc);
[radht_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(radht_ctrl_mean,ny,yc,ar,hc);
[cndht_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_ctrl_mean,ny,yc,ar,hc);
[cnvht_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_ctrl_mean,ny,yc,ar,hc);
[difht_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(difht_ctrl_mean,ny,yc,ar,hc);


[uE_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(uE_pert_mean,ny,yc,ar,hc);
[vN_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(vN_pert_mean,ny,yc,ar,hc);
[theta_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(theta_pert_mean,ny,yc,ar,hc);
[temp_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(temp_pert_mean,ny,yc,ar,hc);
[uv_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(uv_pert_mean,ny,yc,ar,hc); 
uv_ed_zav_p = uv_zav_p - uE_zav_p.*vN_zav_p;
[vt_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(vt_pert_mean,ny,yc,ar,hc); 
vt_ed_zav_p = vt_zav_p - vN_zav_p.*theta_zav_p;
[w_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(w_pert_mean,ny,yc,ar,hc);
[q_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(q_pert_mean,ny,yc,ar,hc);
[htrt_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_pert_mean,ny,yc,ar,hc);
[radht_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(radht_pert_mean,ny,yc,ar,hc);
[cndht_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_pert_mean,ny,yc,ar,hc);
[cnvht_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_pert_mean,ny,yc,ar,hc);
[difht_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(difht_pert_mean,ny,yc,ar,hc);


%take hemisphere averages

for i=1:45

uE_hzav_c(46-i,:) = (uE_zav_c(i,:) + uE_zav_c(91-i,:))./2;
uE_hzav_p(46-i,:) = (uE_zav_p(i,:) + uE_zav_p(91-i,:))./2;

vN_hzav_c(46-i,:) = (-1*vN_zav_c(i,:) + vN_zav_c(91-i,:))./2;
vN_hzav_p(46-i,:) = (-1*vN_zav_p(i,:) + vN_zav_p(91-i,:))./2;

theta_hzav_c(46-i,:) = (theta_zav_c(i,:) + theta_zav_c(91-i,:))./2;
theta_hzav_p(46-i,:) = (theta_zav_p(i,:) + theta_zav_p(91-i,:))./2;

temp_hzav_c(46-i,:) = (temp_zav_c(i,:) + temp_zav_c(91-i,:))./2;
temp_hzav_p(46-i,:) = (temp_zav_p(i,:) + temp_zav_p(91-i,:))./2;

uv_ed_hzav_c(46-i,:) = (-1*uv_ed_zav_c(i,:) + uv_ed_zav_c(91-i,:))./2;
uv_ed_hzav_p(46-i,:) = (-1*uv_ed_zav_p(i,:) + uv_ed_zav_p(91-i,:))./2;

vt_ed_hzav_c(46-i,:) = (-1*vt_ed_zav_c(i,:) + vt_ed_zav_c(91-i,:))./2;
vt_ed_hzav_p(46-i,:) = (-1*vt_ed_zav_p(i,:) + vt_ed_zav_p(91-i,:))./2;

w_hzav_c(46-i,:) = (w_zav_c(i,:) + w_zav_c(91-i,:))./2;
w_hzav_p(46-i,:) = (w_zav_p(i,:) + w_zav_p(91-i,:))./2;

q_hzav_c(46-i,:) = (q_zav_c(i,:) + q_zav_c(91-i,:))./2;
q_hzav_p(46-i,:) = (q_zav_p(i,:) + q_zav_p(91-i,:))./2;

htrt_hzav_c(46-i,:) = (htrt_zav_c(i,:) + htrt_zav_c(91-i,:))./2;
htrt_hzav_p(46-i,:) = (htrt_zav_p(i,:) + htrt_zav_p(91-i,:))./2;

radht_hzav_c(46-i,:) = (radht_zav_c(i,:) + radht_zav_c(91-i,:))./2;
radht_hzav_p(46-i,:) = (radht_zav_p(i,:) + radht_zav_p(91-i,:))./2;

cndht_hzav_c(46-i,:) = (cndht_zav_c(i,:) + cndht_zav_c(91-i,:))./2;
cndht_hzav_p(46-i,:) = (cndht_zav_p(i,:) + cndht_zav_p(91-i,:))./2;

cnvht_hzav_c(46-i,:) = (cnvht_zav_c(i,:) + cnvht_zav_c(91-i,:))./2;
cnvht_hzav_p(46-i,:) = (cnvht_zav_p(i,:) + cnvht_zav_p(91-i,:))./2;

difht_hzav_c(46-i,:) = (difht_zav_c(i,:) + difht_zav_c(91-i,:))./2;
difht_hzav_p(46-i,:) = (difht_zav_p(i,:) + difht_zav_p(91-i,:))./2;

end

save('means_0129.mat');



