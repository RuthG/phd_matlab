%load_year_data
%load up and save spin up data as ten day avs and as the first 10 days


%Read in iteration number, directory, MITgcm output and grid details

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';

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

a=system('find ctrl_data.mat');

if a > 0

i=0;
for nit = 259200:86400:604800;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp(:,:,j,i)=theta(:,:,j,i).*convthetatoT(j,1);
end

J=find(strcmp(fldList,'UV_VEL_C'));
uv(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut(:,:,:,i) = dyn(:,:,:,J);
[uEt(:,:,:,i),vNt(:,:,:,i)] = rotate_uv2uvEN(ut(:,:,:,i),vt(:,:,:,i),AngleCS,AngleSN,Grid);

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

%Calculate av

uE_ctrl = mean(uE,4);
vN_ctrl = mean(vN,4);
uv_ctrl = mean(uv,4);
uEt_ctrl = mean(uEt,4);
vNt_ctrl = mean(vNt,4);
theta_ctrl = mean(theta,4);
temp_ctrl = mean(temp,4);
w_ctrl = mean(w,4);
q_ctrl = mean(q,4);
htrt_ctrl = mean(htrt_theta,4);
radht_ctrl = mean(radht_theta,4);
cndht_ctrl = mean(cndht_theta,4);
cnvht_ctrl = mean(cnvht_theta,4);
difht_ctrl = mean(difht_theta,4);

save('ctrl_data.mat', 'uE_ctrl', 'vN_ctrl', 'theta_ctrl', 'uv_ctrl', ...
'temp_ctrl', 'w_ctrl', 'uEt_ctrl', 'vNt_ctrl', 'q_ctrl', 'htrt_ctrl', ... 
'radht_ctrl', 'cndht_ctrl', 'cnvht_ctrl', 'difht_ctrl');


else
load('ctrl_data.mat')

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Prepare fields for plotting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[uE_cl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_ctrl,ny,yc,ar,hc);
[vN_cl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_ctrl,ny,yc,ar,hc);
[theta_cl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_ctrl,ny,yc,ar,hc);
[temp_cl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_ctrl,ny,yc,ar,hc);
[uv_cl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ctrl,ny,yc,ar,hc);
[vNt_cl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_ctrl,ny,yc,ar,hc);
[w_cl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_ctrl,ny,yc,ar,hc);
[q_cl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(q_ctrl,ny,yc,ar,hc);
[htrt_cl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_ctrl,ny,yc,ar,hc);
[radht_cl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_ctrl,ny,yc,ar,hc);
[cndht_cl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_ctrl,ny,yc,ar,hc);
[cnvht_cl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_ctrl,ny,yc,ar,hc);
[difht_cl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_ctrl,ny,yc,ar,hc);


uEvN_cl_zav = uE_cl_zav.*vN_cl_zav;
uv_ed_cl_zav = uv_cl_zav - uEvN_cl_zav;

vN_zav_t_zav_cl = vN_cl_zav.*theta_cl_zav;
vt_ed_cl_zav = vNt_cl_zav - vN_zav_t_zav_cl;


%take hemisphere averages

for i=1:45

uE_cl_hzav(46-i,:) = (uE_cl_zav(i,:) + uE_cl_zav(91-i,:))./2;

vN_cl_hzav(46-i,:) = (-1*vN_cl_zav(i,:) + vN_cl_zav(91-i,:))./2;

theta_cl_hzav(46-i,:) = (theta_cl_zav(i,:) + theta_cl_zav(91-i,:))./2;

temp_cl_hzav(46-i,:) = (temp_cl_zav(i,:) + temp_cl_zav(91-i,:))./2;

uv_ed_cl_hzav(46-i,:) = (-1*uv_ed_cl_zav(i,:) + uv_ed_cl_zav(91-i,:))./2;

vt_ed_cl_hzav(46-i,:) = (-1*vt_ed_cl_zav(i,:) + vt_ed_cl_zav(91-i,:))./2;

w_cl_hzav(46-i,:) = (w_cl_zav(i,:) + w_cl_zav(91-i,:))./2;

q_cl_hzav(46-i,:) = (q_cl_zav(i,:) + q_cl_zav(91-i,:))./2;

htrt_cl_hzav(46-i,:) = (htrt_cl_zav(i,:) + htrt_cl_zav(91-i,:))./2;

radht_cl_hzav(46-i,:) = (radht_cl_zav(i,:) + radht_cl_zav(91-i,:))./2;

cndht_cl_hzav(46-i,:) = (cndht_cl_zav(i,:) + cndht_cl_zav(91-i,:))./2;

cnvht_cl_hzav(46-i,:) = (cnvht_cl_zav(i,:) + cnvht_cl_zav(91-i,:))./2;

difht_cl_hzav(46-i,:) = (difht_cl_zav(i,:) + difht_cl_zav(91-i,:))./2;

end

save('ctrl_data.mat', 'uE_cl_hzav', 'vN_cl_hzav', 'theta_cl_hzav', ...
'temp_cl_hzav', 'uv_ed_cl_hzav', 'vt_ed_cl_hzav', 'w_cl_hzav', 'q_cl_hzav', 'htrt_cl_hzav', ... 
'radht_cl_hzav', 'cndht_cl_hzav', 'cnvht_cl_hzav', 'difht_cl_hzav','-append');

