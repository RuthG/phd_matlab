%load_drydays_data
%load up and save pre spin up data 


%Read in iteration number, directory, MITgcm output and grid details

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_oneyrdaily_wvoffradoff/';

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

a=system('find drydays_data.mat');

if a > 0

i=0;
for nit = 689040:240:691200;
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

uE_drydays = uE;
vN_drydays = vN;
uv_drydays = uv;
uEt_drydays = uEt;
vNt_drydays = vNt;
theta_drydays = theta;
temp_drydays = temp;
w_drydays = w;
q_drydays = q;
htrt_drydays = htrt_theta;
radht_drydays = radht_theta;
cndht_drydays = cndht_theta;
cnvht_drydays = cnvht_theta;
difht_drydays = difht_theta;

save('drydays_data.mat', 'uE_drydays', 'vN_drydays', 'theta_drydays', 'uv_drydays', ...
'temp_drydays', 'w_drydays', 'uEt_drydays', 'vNt_drydays', 'q_drydays', 'htrt_drydays', ... 
'radht_drydays', 'cndht_drydays', 'cnvht_drydays', 'difht_drydays');

else
load('drydays_data.mat')

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Prepare fields for plotting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[uE_dd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_drydays,ny,yc,ar,hc);
[vN_dd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_drydays,ny,yc,ar,hc);
[theta_dd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_drydays,ny,yc,ar,hc);
[temp_dd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_drydays,ny,yc,ar,hc);
[uv_dd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_drydays,ny,yc,ar,hc);
[vNt_dd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_drydays,ny,yc,ar,hc);
[w_dd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_drydays,ny,yc,ar,hc);
[q_dd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(q_drydays,ny,yc,ar,hc);
[htrt_dd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_drydays,ny,yc,ar,hc);
[radht_dd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_drydays,ny,yc,ar,hc);
[cndht_dd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_drydays,ny,yc,ar,hc);
[cnvht_dd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_drydays,ny,yc,ar,hc);
[difht_dd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_drydays,ny,yc,ar,hc);

for i = 1:10

uEvN_dd_zav(:,:,i) = uE_dd_zav(:,:,i).*vN_dd_zav(:,:,i);
uv_ed_dd_zav(:,:,i) = uv_dd_zav(:,:,i) - uEvN_dd_zav(:,:,i);

vN_zav_t_zav_dd(:,:,i) = vN_dd_zav(:,:,i).*theta_dd_zav(:,:,i);
vt_ed_dd_zav(:,:,i) = vNt_dd_zav(:,:,i) - vN_zav_t_zav_dd(:,:,i);

end




%take hemisphere averages

for i=1:45

uE_dd_hzav(46-i,:,:) = (uE_dd_zav(i,:,:) + uE_dd_zav(91-i,:,:))./2;

vN_dd_hzav(46-i,:,:) = (-1*vN_dd_zav(i,:,:) + vN_dd_zav(91-i,:,:))./2;

theta_dd_hzav(46-i,:,:) = (theta_dd_zav(i,:,:) + theta_dd_zav(91-i,:,:))./2;

temp_dd_hzav(46-i,:,:) = (temp_dd_zav(i,:,:) + temp_dd_zav(91-i,:,:))./2;

uv_ed_dd_hzav(46-i,:,:) = (-1*uv_ed_dd_zav(i,:,:) + uv_ed_dd_zav(91-i,:,:))./2;

vt_ed_dd_hzav(46-i,:,:) = (-1*vt_ed_dd_zav(i,:,:) + vt_ed_dd_zav(91-i,:,:))./2;

w_dd_hzav(46-i,:,:) = (w_dd_zav(i,:,:) + w_dd_zav(91-i,:,:))./2;

q_dd_hzav(46-i,:,:) = (q_dd_zav(i,:,:) + q_dd_zav(91-i,:,:))./2;

htrt_dd_hzav(46-i,:,:) = (htrt_dd_zav(i,:,:) + htrt_dd_zav(91-i,:,:))./2;

radht_dd_hzav(46-i,:,:) = (radht_dd_zav(i,:,:) + radht_dd_zav(91-i,:,:))./2;

cndht_dd_hzav(46-i,:,:) = (cndht_dd_zav(i,:,:) + cndht_dd_zav(91-i,:,:))./2;

cnvht_dd_hzav(46-i,:,:) = (cnvht_dd_zav(i,:,:) + cnvht_dd_zav(91-i,:,:))./2;

difht_dd_hzav(46-i,:,:) = (difht_dd_zav(i,:,:) + difht_dd_zav(91-i,:,:))./2;

end

save('drydays_data.mat', 'uE_dd_hzav', 'vN_dd_hzav', 'theta_dd_hzav', ...
'temp_dd_hzav', 'uv_ed_dd_hzav', 'vt_ed_dd_hzav', 'w_dd_hzav', 'q_dd_hzav', 'htrt_dd_hzav', ... 
'radht_dd_hzav', 'cndht_dd_hzav', 'cnvht_dd_hzav', 'difht_dd_hzav','-append');



