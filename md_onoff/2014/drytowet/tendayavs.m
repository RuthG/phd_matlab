%tendayavs
%read in spin up data  

%Read in iteration number, directory, MITgcm output and grid details

load('/disk1/MITgcm/verification/atm_gray_ruth/md_offoff/means_ctrl.mat')


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

%read fields
i=0;
for nit = 691440:240:777600;
i=i+1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Load data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);
uEvN(:,:,:,i)=uE(:,:,:,i).*vN(:,:,:,i);

J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp(:,:,j,i)=theta(:,:,j,i).*convthetatoT(j,1);
end

J=find(strcmp(fldList,'UV_VEL_C'));
uv(:,:,:,i) = dyn(:,:,:,J);
uv_ed(:,:,:,i) = uv(:,:,:,i) - uEvN(:,:,:,i);

J=find(strcmp(fldList,'VVELTH  '));
vt_av(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av(:,:,:,i) = dyn(:,:,:,J);
[uEt_av(:,:,:,i),vNt_av(:,:,:,i)] = rotate_uv2uvEN(ut_av(:,:,:,i),vt_av(:,:,:,i),AngleCS,AngleSN,Grid);

vt(:,:,:,i) = vN(:,:,:,i).*theta(:,:,:,i);
vt_ed(:,:,:,i) = vNt_av(:,:,:,i) - vt(:,:,:,i);

J=find(strcmp(fldList,'WVEL    '));
w(:,:,:,i)=dyn(:,:,:,J);

J=find(strcmp(fldList,'SALT    '));
q(:,:,:,i)=dyn(:,:,:,J);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_in=dyn(:,:,:,J);
htrt_theta(:,:,:,i)=htrt_in*86400.;

J=find(strcmp(fldList,'AtPhdTrd'));
radht_in=dyn(:,:,:,J);
radht_theta(:,:,:,i)=radht_in*86400.;

J=find(strcmp(fldList,'AtPhdTcd'));
cndht_in=dyn(:,:,:,J);
cndht_theta(:,:,:,i)=cndht_in*86400.;

J=find(strcmp(fldList,'AtPhdTdf'));
difht_in=dyn(:,:,:,J);
difht_theta(:,:,:,i)=difht_in*86400.;

J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_in=dyn(:,:,:,J);
cnvht_theta(:,:,:,i)=cnvht_in*86400.;

end

for i=1:36

uE_mean(:,:,:,i) = mean(uE(:,:,:,10*i-9:10*i),4);
vN_mean(:,:,:,i) = mean(vN(:,:,:,10*i-9:10*i),4);
theta_mean(:,:,:,i) = mean(theta(:,:,:,10*i-9:10*i),4);
temp_mean(:,:,:,i) = mean(temp(:,:,:,10*i-9:10*i),4);
uv_ed_mean(:,:,:,i) = mean(uv_ed(:,:,:,10*i-9:10*i),4);
vt_ed_mean(:,:,:,i) = mean(vt_ed(:,:,:,10*i-9:10*i),4);
w_mean(:,:,:,i) = mean(w(:,:,:,10*i-9:10*i),4);
q_mean(:,:,:,i) = mean(q(:,:,:,10*i-9:10*i),4);
htrt_mean(:,:,:,i) = mean(htrt_theta(:,:,:,10*i-9:10*i),4);
radht_mean(:,:,:,i) = mean(radht_theta(:,:,:,10*i-9:10*i),4);
cndht_mean(:,:,:,i) = mean(cndht_theta(:,:,:,10*i-9:10*i),4);
cnvht_mean(:,:,:,i) = mean(cnvht_theta(:,:,:,10*i-9:10*i),4);
difht_mean(:,:,:,i) = mean(difht_theta(:,:,:,10*i-9:10*i),4);

end

save('means_spinup.mat', 'uE_mean', 'vN_mean', 'theta_mean', ...
'temp_mean', 'uv_ed_mean', 'vt_ed_mean', 'w_mean', 'q_mean', 'htrt_mean', ... 
'radht_mean', 'cndht_mean', 'cnvht_mean', 'difht_mean');

uE_firstten = uE(:,:,:,1:10);
vN_firstten = vN(:,:,:,1:10);
theta_firstten = theta(:,:,:,1:10);
temp_firstten = temp(:,:,:,1:10);
uv_ed_firstten = uv_ed(:,:,:,1:10);
vt_ed_firstten = vt_ed(:,:,:,1:10);
w_firstten = w(:,:,:,1:10);
q_firstten = q(:,:,:,1:10);
htrt_firstten = htrt_theta(:,:,:,1:10);
radht_firstten = radht_theta(:,:,:,1:10);
cndht_firstten = cndht_theta(:,:,:,1:10);
cnvht_firstten = cnvht_theta(:,:,:,1:10);
difht_firstten = difht_theta(:,:,:,1:10);

save('means_firstten.mat', 'uE_firstten', 'vN_firstten', 'theta_firstten', ...
'temp_firstten', 'uv_ed_firstten', 'vt_ed_firstten', 'w_firstten', 'q_firstten', 'htrt_firstten', ... 
'radht_firstten', 'cndht_firstten', 'cnvht_firstten', 'difht_firstten');

%take zonal averages for plots

[uE_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(uE_ctrl_mean,ny,yc,ar,hc);
[vN_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(vN_ctrl_mean,ny,yc,ar,hc);
[theta_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(theta_ctrl_mean,ny,yc,ar,hc);
[temp_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(temp_ctrl_mean,ny,yc,ar,hc);
[uv_ed_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ed_ctrl_mean,ny,yc,ar,hc);
[vt_ed_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(vt_ed_ctrl_mean,ny,yc,ar,hc);
[w_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(w_ctrl_mean,ny,yc,ar,hc);
[q_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(q_ctrl_mean,ny,yc,ar,hc);
[htrt_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_ctrl_mean,ny,yc,ar,hc);
[radht_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(radht_ctrl_mean,ny,yc,ar,hc);
[cndht_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_ctrl_mean,ny,yc,ar,hc);
[cnvht_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_ctrl_mean,ny,yc,ar,hc);
[difht_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(difht_ctrl_mean,ny,yc,ar,hc);


[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_mean,ny,yc,ar,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_mean,ny,yc,ar,hc);
[theta_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_mean,ny,yc,ar,hc);
[temp_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_mean,ny,yc,ar,hc);
[uv_ed_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ed_mean,ny,yc,ar,hc);
[vt_ed_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vt_ed_mean,ny,yc,ar,hc);
[w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_mean,ny,yc,ar,hc);
[q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(q_mean,ny,yc,ar,hc);
[htrt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_mean,ny,yc,ar,hc);
[radht_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_mean,ny,yc,ar,hc);
[cndht_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_mean,ny,yc,ar,hc);
[cnvht_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_mean,ny,yc,ar,hc);
[difht_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_mean,ny,yc,ar,hc);


%take hemisphere averages

for i=1:45

uE_hzav_c(46-i,:) = (uE_zav_c(i,:) + uE_zav_c(91-i,:))./2;
uE_hzav(46-i,:,:) = (uE_zav(i,:,:) + uE_zav(91-i,:,:))./2;

vN_hzav_c(46-i,:) = (-1*vN_zav_c(i,:) + vN_zav_c(91-i,:))./2;
vN_hzav(46-i,:,:) = (-1*vN_zav(i,:,:) + vN_zav(91-i,:,:))./2;

theta_hzav_c(46-i,:) = (theta_zav_c(i,:) + theta_zav_c(91-i,:))./2;
theta_hzav(46-i,:,:) = (theta_zav(i,:,:) + theta_zav(91-i,:,:))./2;

temp_hzav_c(46-i,:) = (temp_zav_c(i,:) + temp_zav_c(91-i,:))./2;
temp_hzav(46-i,:,:) = (temp_zav(i,:,:) + temp_zav(91-i,:,:))./2;

uv_ed_hzav_c(46-i,:) = (-1*uv_ed_zav_c(i,:) + uv_ed_zav_c(91-i,:))./2;
uv_ed_hzav(46-i,:,:) = (-1*uv_ed_zav(i,:,:) + uv_ed_zav(91-i,:,:))./2;

vt_ed_hzav_c(46-i,:) = (-1*vt_ed_zav_c(i,:) + vt_ed_zav_c(91-i,:))./2;
vt_ed_hzav(46-i,:,:) = (-1*vt_ed_zav(i,:,:) + vt_ed_zav(91-i,:,:))./2;

w_hzav_c(46-i,:) = (w_zav_c(i,:) + w_zav_c(91-i,:))./2;
w_hzav(46-i,:,:) = (w_zav(i,:,:) + w_zav(91-i,:,:))./2;

q_hzav_c(46-i,:) = (q_zav_c(i,:) + q_zav_c(91-i,:))./2;
q_hzav(46-i,:,:) = (q_zav(i,:,:) + q_zav(91-i,:,:))./2;

htrt_hzav_c(46-i,:) = (htrt_zav_c(i,:) + htrt_zav_c(91-i,:))./2;
htrt_hzav(46-i,:,:) = (htrt_zav(i,:,:) + htrt_zav(91-i,:,:))./2;

radht_hzav_c(46-i,:) = (radht_zav_c(i,:) + radht_zav_c(91-i,:))./2;
radht_hzav(46-i,:,:) = (radht_zav(i,:,:) + radht_zav(91-i,:,:))./2;

cndht_hzav_c(46-i,:) = (cndht_zav_c(i,:) + cndht_zav_c(91-i,:))./2;
cndht_hzav(46-i,:,:) = (cndht_zav(i,:,:) + cndht_zav(91-i,:,:))./2;

cnvht_hzav_c(46-i,:) = (cnvht_zav_c(i,:) + cnvht_zav_c(91-i,:))./2;
cnvht_hzav(46-i,:,:) = (cnvht_zav(i,:,:) + cnvht_zav(91-i,:,:))./2;

difht_hzav_c(46-i,:) = (difht_zav_c(i,:) + difht_zav_c(91-i,:))./2;
difht_hzav(46-i,:,:) = (difht_zav(i,:,:) + difht_zav(91-i,:,:))./2;

end

save('means_spinup_hzav.mat', 'uE_hzav', 'vN_hzav', 'theta_hzav', ...
'temp_hzav', 'uv_ed_hzav', 'vt_ed_hzav', 'w_hzav', 'q_hzav', 'htrt_hzav', ... 
'radht_hzav', 'cndht_hzav', 'cnvht_hzav', 'difht_hzav');

