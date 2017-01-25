%Read in iteration number, directory, MITgcm output and grid details

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';

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

a=system('find hwv_data.mat');

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

uE_hwv = mean(uE,4);
vN_hwv = mean(vN,4);
uv_hwv = mean(uv,4);
uEt_hwv = mean(uEt,4);
vNt_hwv = mean(vNt,4);
theta_hwv = mean(theta,4);
temp_hwv = mean(temp,4);
w_hwv = mean(w,4);
q_hwv = mean(q,4);
htrt_hwv = mean(htrt_theta,4);
radht_hwv = mean(radht_theta,4);
cndht_hwv = mean(cndht_theta,4);
cnvht_hwv = mean(cnvht_theta,4);
difht_hwv = mean(difht_theta,4);

save('hwv_data.mat', 'uE_hwv', 'vN_hwv', 'theta_hwv', 'uv_hwv', ...
'temp_hwv', 'w_hwv', 'uEt_hwv', 'vNt_hwv', 'q_hwv', 'htrt_hwv', ... 
'radht_hwv', 'cndht_hwv', 'cnvht_hwv', 'difht_hwv');


else
load('hwv_data.mat')

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Prepare fields for plotting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[uE_hw_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_hwv,ny,yc,ar,hc);
[vN_hw_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_hwv,ny,yc,ar,hc);
[theta_hw_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_hwv,ny,yc,ar,hc);
[temp_hw_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_hwv,ny,yc,ar,hc);
[uv_hw_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_hwv,ny,yc,ar,hc);
[vNt_hw_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_hwv,ny,yc,ar,hc);
[w_hw_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_hwv,ny,yc,ar,hc);
[q_hw_zav,mskzon,ylat,areazon]=calcZonalAvgCube(q_hwv,ny,yc,ar,hc);
[htrt_hw_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_hwv,ny,yc,ar,hc);
[radht_hw_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_hwv,ny,yc,ar,hc);
[cndht_hw_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_hwv,ny,yc,ar,hc);
[cnvht_hw_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_hwv,ny,yc,ar,hc);
[difht_hw_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_hwv,ny,yc,ar,hc);


uEvN_hw_zav = uE_hw_zav.*vN_hw_zav;
uv_ed_hw_zav = uv_hw_zav - uEvN_hw_zav;

vN_zav_t_zav_hw = vN_hw_zav.*theta_hw_zav;
vt_ed_hw_zav = vNt_hw_zav - vN_zav_t_zav_hw;


%take hemisphere averages

for i=1:45

uE_hw_hzav(46-i,:) = (uE_hw_zav(i,:) + uE_hw_zav(91-i,:))./2;

vN_hw_hzav(46-i,:) = (-1*vN_hw_zav(i,:) + vN_hw_zav(91-i,:))./2;

theta_hw_hzav(46-i,:) = (theta_hw_zav(i,:) + theta_hw_zav(91-i,:))./2;

temp_hw_hzav(46-i,:) = (temp_hw_zav(i,:) + temp_hw_zav(91-i,:))./2;

uv_ed_hw_hzav(46-i,:) = (-1*uv_ed_hw_zav(i,:) + uv_ed_hw_zav(91-i,:))./2;

vt_ed_hw_hzav(46-i,:) = (-1*vt_ed_hw_zav(i,:) + vt_ed_hw_zav(91-i,:))./2;

w_hw_hzav(46-i,:) = (w_hw_zav(i,:) + w_hw_zav(91-i,:))./2;

q_hw_hzav(46-i,:) = (q_hw_zav(i,:) + q_hw_zav(91-i,:))./2;

htrt_hw_hzav(46-i,:) = (htrt_hw_zav(i,:) + htrt_hw_zav(91-i,:))./2;

radht_hw_hzav(46-i,:) = (radht_hw_zav(i,:) + radht_hw_zav(91-i,:))./2;

cndht_hw_hzav(46-i,:) = (cndht_hw_zav(i,:) + cndht_hw_zav(91-i,:))./2;

cnvht_hw_hzav(46-i,:) = (cnvht_hw_zav(i,:) + cnvht_hw_zav(91-i,:))./2;

difht_hw_hzav(46-i,:) = (difht_hw_zav(i,:) + difht_hw_zav(91-i,:))./2;

end

save('hwv_data.mat', 'uE_hw_hzav', 'vN_hw_hzav', 'theta_hw_hzav', ...
'temp_hw_hzav', 'uv_ed_hw_hzav', 'vt_ed_hw_hzav', 'w_hw_hzav', 'q_hw_hzav', 'htrt_hw_hzav', ... 
'radht_hw_hzav', 'cndht_hw_hzav', 'cnvht_hw_hzav', 'difht_hw_hzav','-append');

