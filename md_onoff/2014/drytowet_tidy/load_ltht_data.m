%load_year_data
%load up and save spin up data as ten day avs and as the first 10 days


%Read in iteration number, directory, MITgcm output and grid details

rDir='/disk1/MITgcm/verification/atm_gray_ruth/run/';

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

a=system('find lthtten_data.mat');

if a > 0

i=0;
for nit = 173040:240:175200;
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

uE_lthtten = uE(:,:,:,1:10);
vN_lthtten = vN(:,:,:,1:10);
uv_lthtten = uv(:,:,:,1:10);
uEt_lthtten = uEt(:,:,:,1:10);
vNt_lthtten = vNt(:,:,:,1:10);
theta_lthtten = theta(:,:,:,1:10);
temp_lthtten = temp(:,:,:,1:10);
w_lthtten = w(:,:,:,1:10);
q_lthtten = q(:,:,:,1:10);
htrt_lthtten = htrt_theta(:,:,:,1:10);
radht_lthtten = radht_theta(:,:,:,1:10);
cndht_lthtten = cndht_theta(:,:,:,1:10);
cnvht_lthtten = cnvht_theta(:,:,:,1:10);
difht_lthtten = difht_theta(:,:,:,1:10);

save('lthtten_data.mat', 'uE_lthtten', 'vN_lthtten', 'theta_lthtten', 'uv_lthtten', ...
'temp_lthtten', 'w_lthtten', 'uEt_lthtten', 'vNt_lthtten', 'q_lthtten', 'htrt_lthtten', ... 
'radht_lthtten', 'cndht_lthtten', 'cnvht_lthtten', 'difht_lthtten');

else
load('lthtten_data.mat')

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Prepare fields for plotting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[uE_lt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_lthtten,ny,yc,ar,hc);
[vN_lt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_lthtten,ny,yc,ar,hc);
[theta_lt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_lthtten,ny,yc,ar,hc);
[temp_lt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_lthtten,ny,yc,ar,hc);
[uv_lt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_lthtten,ny,yc,ar,hc);
[vNt_lt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_lthtten,ny,yc,ar,hc);
[w_lt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_lthtten,ny,yc,ar,hc);
[q_lt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(q_lthtten,ny,yc,ar,hc);
[htrt_lt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_lthtten,ny,yc,ar,hc);
[radht_lt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_lthtten,ny,yc,ar,hc);
[cndht_lt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_lthtten,ny,yc,ar,hc);
[cnvht_lt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_lthtten,ny,yc,ar,hc);
[difht_lt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_lthtten,ny,yc,ar,hc);

for i = 1:10

uEvN_lt_zav(:,:,i) = uE_lt_zav(:,:,i).*vN_lt_zav(:,:,i);
uv_ed_lt_zav(:,:,i) = uv_lt_zav(:,:,i) - uEvN_lt_zav(:,:,i);

vN_zav_t_zav_lt(:,:,i) = vN_lt_zav(:,:,i).*theta_lt_zav(:,:,i);
vt_ed_lt_zav(:,:,i) = vNt_lt_zav(:,:,i) - vN_zav_t_zav_lt(:,:,i);

end


%take hemisphere averages

for i=1:45

uE_lt_hzav(46-i,:,:) = (uE_lt_zav(i,:,:) + uE_lt_zav(91-i,:,:))./2;

vN_lt_hzav(46-i,:,:) = (-1*vN_lt_zav(i,:,:) + vN_lt_zav(91-i,:,:))./2;

theta_lt_hzav(46-i,:,:) = (theta_lt_zav(i,:,:) + theta_lt_zav(91-i,:,:))./2;

temp_lt_hzav(46-i,:,:) = (temp_lt_zav(i,:,:) + temp_lt_zav(91-i,:,:))./2;

uv_ed_lt_hzav(46-i,:,:) = (-1*uv_ed_lt_zav(i,:,:) + uv_ed_lt_zav(91-i,:,:))./2;

vt_ed_lt_hzav(46-i,:,:) = (-1*vt_ed_lt_zav(i,:,:) + vt_ed_lt_zav(91-i,:,:))./2;

w_lt_hzav(46-i,:,:) = (w_lt_zav(i,:,:) + w_lt_zav(91-i,:,:))./2;

q_lt_hzav(46-i,:,:) = (q_lt_zav(i,:,:) + q_lt_zav(91-i,:,:))./2;

htrt_lt_hzav(46-i,:,:) = (htrt_lt_zav(i,:,:) + htrt_lt_zav(91-i,:,:))./2;

radht_lt_hzav(46-i,:,:) = (radht_lt_zav(i,:,:) + radht_lt_zav(91-i,:,:))./2;

cndht_lt_hzav(46-i,:,:) = (cndht_lt_zav(i,:,:) + cndht_lt_zav(91-i,:,:))./2;

cnvht_lt_hzav(46-i,:,:) = (cnvht_lt_zav(i,:,:) + cnvht_lt_zav(91-i,:,:))./2;

difht_lt_hzav(46-i,:,:) = (difht_lt_zav(i,:,:) + difht_lt_zav(91-i,:,:))./2;

end

save('lthtten_data.mat', 'uE_lt_hzav', 'vN_lt_hzav', 'theta_lt_hzav', ...
'temp_lt_hzav', 'uv_ed_lt_hzav', 'vt_ed_lt_hzav', 'w_lt_hzav', 'q_lt_hzav', 'htrt_lt_hzav', ... 
'radht_lt_hzav', 'cndht_lt_hzav', 'cnvht_lt_hzav', 'difht_lt_hzav','-append');


