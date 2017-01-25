%load_year_data
%load up and save spin up data as ten day avs and as the first 10 days


%Read in iteration number, directory, MITgcm output and grid details

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_extramonths/';

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


a=system('find extramonths_data.mat');

if a > 0


i=0;
for nit = 784800:7200:950400;
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

uE_extramonths = uE;
vN_extramonths = vN;
uv_extramonths = uv;
uEt_extramonths = uEt;
vNt_extramonths = vNt;
theta_extramonths = theta;
temp_extramonths = temp;
w_extramonths = w;
q_extramonths = q;
htrt_extramonths = htrt_theta;
radht_extramonths = radht_theta;
cndht_extramonths = cndht_theta;
cnvht_extramonths = cnvht_theta;
difht_extramonths = difht_theta;


save('extramonths_data.mat', 'uE_extramonths', 'vN_extramonths', 'theta_extramonths', 'uv_extramonths', ...
'temp_extramonths', 'w_extramonths', 'uEt_extramonths', 'vNt_extramonths', 'q_extramonths', 'htrt_extramonths', ... 
'radht_extramonths', 'cndht_extramonths', 'cnvht_extramonths', 'difht_extramonths');


else
load('extramonths_data.mat')

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Prepare fields for plotting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[uE_em_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_extramonths,ny,yc,ar,hc);
[vN_em_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_extramonths,ny,yc,ar,hc);
[theta_em_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_extramonths,ny,yc,ar,hc);
[temp_em_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_extramonths,ny,yc,ar,hc);
[uv_em_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_extramonths,ny,yc,ar,hc);
[vNt_em_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_extramonths,ny,yc,ar,hc);
[w_em_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_extramonths,ny,yc,ar,hc);
[q_em_zav,mskzon,ylat,areazon]=calcZonalAvgCube(q_extramonths,ny,yc,ar,hc);
[htrt_em_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_extramonths,ny,yc,ar,hc);
[radht_em_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_extramonths,ny,yc,ar,hc);
[cndht_em_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_extramonths,ny,yc,ar,hc);
[cnvht_em_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_extramonths,ny,yc,ar,hc);
[difht_em_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_extramonths,ny,yc,ar,hc);

for i = 1:24

uEvN_em_zav(:,:,i) = uE_em_zav(:,:,i).*vN_em_zav(:,:,i);
uv_ed_em_zav(:,:,i) = uv_em_zav(:,:,i) - uEvN_em_zav(:,:,i);

vN_zav_t_zav_em(:,:,i) = vN_em_zav(:,:,i).*theta_em_zav(:,:,i);
vt_ed_em_zav(:,:,i) = vNt_em_zav(:,:,i) - vN_zav_t_zav_em(:,:,i);

end


%take hemisphere averages

for i=1:45

uE_em_hzav(46-i,:,:) = (uE_em_zav(i,:,:) + uE_em_zav(91-i,:,:))./2;

vN_em_hzav(46-i,:,:) = (-1*vN_em_zav(i,:,:) + vN_em_zav(91-i,:,:))./2;

theta_em_hzav(46-i,:,:) = (theta_em_zav(i,:,:) + theta_em_zav(91-i,:,:))./2;

temp_em_hzav(46-i,:,:) = (temp_em_zav(i,:,:) + temp_em_zav(91-i,:,:))./2;

uv_ed_em_hzav(46-i,:,:) = (-1*uv_ed_em_zav(i,:,:) + uv_ed_em_zav(91-i,:,:))./2;

vt_ed_em_hzav(46-i,:,:) = (-1*vt_ed_em_zav(i,:,:) + vt_ed_em_zav(91-i,:,:))./2;

w_em_hzav(46-i,:,:) = (w_em_zav(i,:,:) + w_em_zav(91-i,:,:))./2;

q_em_hzav(46-i,:,:) = (q_em_zav(i,:,:) + q_em_zav(91-i,:,:))./2;

htrt_em_hzav(46-i,:,:) = (htrt_em_zav(i,:,:) + htrt_em_zav(91-i,:,:))./2;

radht_em_hzav(46-i,:,:) = (radht_em_zav(i,:,:) + radht_em_zav(91-i,:,:))./2;

cndht_em_hzav(46-i,:,:) = (cndht_em_zav(i,:,:) + cndht_em_zav(91-i,:,:))./2;

cnvht_em_hzav(46-i,:,:) = (cnvht_em_zav(i,:,:) + cnvht_em_zav(91-i,:,:))./2;

difht_em_hzav(46-i,:,:) = (difht_em_zav(i,:,:) + difht_em_zav(91-i,:,:))./2;

end

save('extramonths_data.mat', 'uE_em_hzav', 'vN_em_hzav', 'theta_em_hzav', ...
'temp_em_hzav', 'uv_ed_em_hzav', 'vt_ed_em_hzav', 'w_em_hzav', 'q_em_hzav', 'htrt_em_hzav', ... 
'radht_em_hzav', 'cndht_em_hzav', 'cnvht_em_hzav', 'difht_em_hzav','-append');

