%load_year_data
%load up and save spin up data as ten day avs and as the first 10 days


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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Load data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=system('find wcl_data.mat');

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

uE_wcl = mean(uE,4);
vN_wcl = mean(vN,4);
uv_wcl = mean(uv,4);
uEt_wcl = mean(uEt,4);
vNt_wcl = mean(vNt,4);
theta_wcl = mean(theta,4);
temp_wcl = mean(temp,4);
w_wcl = mean(w,4);
q_wcl = mean(q,4);
htrt_wcl = mean(htrt_theta,4);
radht_wcl = mean(radht_theta,4);
cndht_wcl = mean(cndht_theta,4);
cnvht_wcl = mean(cnvht_theta,4);
difht_wcl = mean(difht_theta,4);

save('wcl_data.mat', 'uE_wcl', 'vN_wcl', 'theta_wcl', 'uv_wcl', ...
'temp_wcl', 'w_wcl', 'uEt_wcl', 'vNt_wcl', 'q_wcl', 'htrt_wcl', ... 
'radht_wcl', 'cndht_wcl', 'cnvht_wcl', 'difht_wcl');


else
load('wcl_data.mat')

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Prepare fields for plotting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[uE_wl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_wcl,ny,yc,ar,hc);
[vN_wl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_wcl,ny,yc,ar,hc);
[theta_wl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_wcl,ny,yc,ar,hc);
[temp_wl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_wcl,ny,yc,ar,hc);
[uv_wl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_wcl,ny,yc,ar,hc);
[vNt_wl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_wcl,ny,yc,ar,hc);
[w_wl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_wcl,ny,yc,ar,hc);
[q_wl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(q_wcl,ny,yc,ar,hc);
[htrt_wl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_wcl,ny,yc,ar,hc);
[radht_wl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_wcl,ny,yc,ar,hc);
[cndht_wl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_wcl,ny,yc,ar,hc);
[cnvht_wl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_wcl,ny,yc,ar,hc);
[difht_wl_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_wcl,ny,yc,ar,hc);


uEvN_wl_zav = uE_wl_zav.*vN_wl_zav;
uv_ed_wl_zav = uv_wl_zav - uEvN_wl_zav;

vN_zav_t_zav_wl = vN_wl_zav.*theta_wl_zav;
vt_ed_wl_zav = vNt_wl_zav - vN_zav_t_zav_wl;


%take hemisphere averages

for i=1:45

uE_wl_hzav(46-i,:) = (uE_wl_zav(i,:) + uE_wl_zav(91-i,:))./2;

vN_wl_hzav(46-i,:) = (-1*vN_wl_zav(i,:) + vN_wl_zav(91-i,:))./2;

theta_wl_hzav(46-i,:) = (theta_wl_zav(i,:) + theta_wl_zav(91-i,:))./2;

temp_wl_hzav(46-i,:) = (temp_wl_zav(i,:) + temp_wl_zav(91-i,:))./2;

uv_ed_wl_hzav(46-i,:) = (-1*uv_ed_wl_zav(i,:) + uv_ed_wl_zav(91-i,:))./2;

vt_ed_wl_hzav(46-i,:) = (-1*vt_ed_wl_zav(i,:) + vt_ed_wl_zav(91-i,:))./2;

w_wl_hzav(46-i,:) = (w_wl_zav(i,:) + w_wl_zav(91-i,:))./2;

q_wl_hzav(46-i,:) = (q_wl_zav(i,:) + q_wl_zav(91-i,:))./2;

htrt_wl_hzav(46-i,:) = (htrt_wl_zav(i,:) + htrt_wl_zav(91-i,:))./2;

radht_wl_hzav(46-i,:) = (radht_wl_zav(i,:) + radht_wl_zav(91-i,:))./2;

cndht_wl_hzav(46-i,:) = (cndht_wl_zav(i,:) + cndht_wl_zav(91-i,:))./2;

cnvht_wl_hzav(46-i,:) = (cnvht_wl_zav(i,:) + cnvht_wl_zav(91-i,:))./2;

difht_wl_hzav(46-i,:) = (difht_wl_zav(i,:) + difht_wl_zav(91-i,:))./2;

end

save('wcl_data.mat', 'uE_wl_hzav', 'vN_wl_hzav', 'theta_wl_hzav', ...
'temp_wl_hzav', 'uv_ed_wl_hzav', 'vt_ed_wl_hzav', 'w_wl_hzav', 'q_wl_hzav', 'htrt_wl_hzav', ... 
'radht_wl_hzav', 'cndht_wl_hzav', 'cnvht_wl_hzav', 'difht_wl_hzav','-append');

