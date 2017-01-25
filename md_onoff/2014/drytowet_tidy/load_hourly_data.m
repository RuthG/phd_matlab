%load_year_data
%load up and save spin up data as ten day avs and as the first 10 days


%Read in iteration number, directory, MITgcm output and grid details

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_wvspinup_hourly/';

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

a=system('find hourly_data.mat');

if a > 0

i=0;
for nit = 604810:10:605040;
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


uE_hourly = uE;
vN_hourly = vN;
uv_hourly = uv;
uEt_hourly = uEt;
vNt_hourly = vNt;
theta_hourly = theta;
temp_hourly = temp;
w_hourly = w;
q_hourly = q;
htrt_hourly = htrt_theta;
radht_hourly = radht_theta;
cndht_hourly = cndht_theta;
cnvht_hourly = cnvht_theta;
difht_hourly = difht_theta;


save('hourly_data.mat', 'uE_hourly', 'vN_hourly', 'theta_hourly', 'uv_hourly', ...
'temp_hourly', 'w_hourly', 'uEt_hourly', 'vNt_hourly', 'q_hourly', 'htrt_hourly', ... 
'radht_hourly', 'cndht_hourly', 'cnvht_hourly', 'difht_hourly');


else
load('hourly_data.mat')

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Prepare fields for plotting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[uE_hr_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_hourly,ny,yc,ar,hc);
[vN_hr_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_hourly,ny,yc,ar,hc);
[theta_hr_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_hourly,ny,yc,ar,hc);
[temp_hr_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_hourly,ny,yc,ar,hc);
[uv_hr_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_hourly,ny,yc,ar,hc);
[vNt_hr_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_hourly,ny,yc,ar,hc);
[w_hr_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_hourly,ny,yc,ar,hc);
[q_hr_zav,mskzon,ylat,areazon]=calcZonalAvgCube(q_hourly,ny,yc,ar,hc);
[htrt_hr_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_hourly,ny,yc,ar,hc);
[radht_hr_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_hourly,ny,yc,ar,hc);
[cndht_hr_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_hourly,ny,yc,ar,hc);
[cnvht_hr_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_hourly,ny,yc,ar,hc);
[difht_hr_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_hourly,ny,yc,ar,hc);

for i = 1:24

uEvN_hr_zav(:,:,i) = uE_hr_zav(:,:,i).*vN_hr_zav(:,:,i);
uv_ed_hr_zav(:,:,i) = uv_hr_zav(:,:,i) - uEvN_hr_zav(:,:,i);

vN_zav_t_zav_hr(:,:,i) = vN_hr_zav(:,:,i).*theta_hr_zav(:,:,i);
vt_ed_hr_zav(:,:,i) = vNt_hr_zav(:,:,i) - vN_zav_t_zav_hr(:,:,i);

end


%take hemisphere averages

for i=1:45

uE_hr_hzav(46-i,:,:) = (uE_hr_zav(i,:,:) + uE_hr_zav(91-i,:,:))./2;

vN_hr_hzav(46-i,:,:) = (-1*vN_hr_zav(i,:,:) + vN_hr_zav(91-i,:,:))./2;

theta_hr_hzav(46-i,:,:) = (theta_hr_zav(i,:,:) + theta_hr_zav(91-i,:,:))./2;

temp_hr_hzav(46-i,:,:) = (temp_hr_zav(i,:,:) + temp_hr_zav(91-i,:,:))./2;

uv_ed_hr_hzav(46-i,:,:) = (-1*uv_ed_hr_zav(i,:,:) + uv_ed_hr_zav(91-i,:,:))./2;

vt_ed_hr_hzav(46-i,:,:) = (-1*vt_ed_hr_zav(i,:,:) + vt_ed_hr_zav(91-i,:,:))./2;

w_hr_hzav(46-i,:,:) = (w_hr_zav(i,:,:) + w_hr_zav(91-i,:,:))./2;

q_hr_hzav(46-i,:,:) = (q_hr_zav(i,:,:) + q_hr_zav(91-i,:,:))./2;

htrt_hr_hzav(46-i,:,:) = (htrt_hr_zav(i,:,:) + htrt_hr_zav(91-i,:,:))./2;

radht_hr_hzav(46-i,:,:) = (radht_hr_zav(i,:,:) + radht_hr_zav(91-i,:,:))./2;

cndht_hr_hzav(46-i,:,:) = (cndht_hr_zav(i,:,:) + cndht_hr_zav(91-i,:,:))./2;

cnvht_hr_hzav(46-i,:,:) = (cnvht_hr_zav(i,:,:) + cnvht_hr_zav(91-i,:,:))./2;

difht_hr_hzav(46-i,:,:) = (difht_hr_zav(i,:,:) + difht_hr_zav(91-i,:,:))./2;

end

save('hourly_data.mat', 'uE_hr_hzav', 'vN_hr_hzav', 'theta_hr_hzav', ...
'temp_hr_hzav', 'uv_ed_hr_hzav', 'vt_ed_hr_hzav', 'w_hr_hzav', 'q_hr_hzav', 'htrt_hr_hzav', ... 
'radht_hr_hzav', 'cndht_hr_hzav', 'cnvht_hr_hzav', 'difht_hr_hzav','-append');


