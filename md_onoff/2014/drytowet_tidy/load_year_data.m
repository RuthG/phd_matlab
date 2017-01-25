%load_year_data
%load up and save spin up data as ten day avs and as the first 10 days


%Read in iteration number, directory, MITgcm output and grid details

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Load data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=system('find tdayav_data.mat');
b=system('find firstten_data.mat');

c=a+b;

if c > 0

i=0;
for nit = 691440:240:777600;
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

%Calculate 10 day avs

for i=1:36

uE_tdayav(:,:,:,i) = mean(uE(:,:,:,10*i-9:10*i),4);
vN_tdayav(:,:,:,i) = mean(vN(:,:,:,10*i-9:10*i),4);
uv_tdayav(:,:,:,i) = mean(uv(:,:,:,10*i-9:10*i),4);
uEt_tdayav(:,:,:,i) = mean(uEt(:,:,:,10*i-9:10*i),4);
vNt_tdayav(:,:,:,i) = mean(vNt(:,:,:,10*i-9:10*i),4);
theta_tdayav(:,:,:,i) = mean(theta(:,:,:,10*i-9:10*i),4);
temp_tdayav(:,:,:,i) = mean(temp(:,:,:,10*i-9:10*i),4);
w_tdayav(:,:,:,i) = mean(w(:,:,:,10*i-9:10*i),4);
q_tdayav(:,:,:,i) = mean(q(:,:,:,10*i-9:10*i),4);
htrt_tdayav(:,:,:,i) = mean(htrt_theta(:,:,:,10*i-9:10*i),4);
radht_tdayav(:,:,:,i) = mean(radht_theta(:,:,:,10*i-9:10*i),4);
cndht_tdayav(:,:,:,i) = mean(cndht_theta(:,:,:,10*i-9:10*i),4);
cnvht_tdayav(:,:,:,i) = mean(cnvht_theta(:,:,:,10*i-9:10*i),4);
difht_tdayav(:,:,:,i) = mean(difht_theta(:,:,:,10*i-9:10*i),4);

end

save('tdayav_data.mat', 'uE_tdayav', 'vN_tdayav', 'theta_tdayav', 'uv_tdayav', ...
'temp_tdayav', 'w_tdayav', 'uEt_tdayav', 'vNt_tdayav', 'q_tdayav', 'htrt_tdayav', ... 
'radht_tdayav', 'cndht_tdayav', 'cnvht_tdayav', 'difht_tdayav');

uE_firstten = uE(:,:,:,1:10);
vN_firstten = vN(:,:,:,1:10);
uv_firstten = uv(:,:,:,1:10);
uEt_firstten = uEt(:,:,:,1:10);
vNt_firstten = vNt(:,:,:,1:10);
theta_firstten = theta(:,:,:,1:10);
temp_firstten = temp(:,:,:,1:10);
w_firstten = w(:,:,:,1:10);
q_firstten = q(:,:,:,1:10);
htrt_firstten = htrt_theta(:,:,:,1:10);
radht_firstten = radht_theta(:,:,:,1:10);
cndht_firstten = cndht_theta(:,:,:,1:10);
cnvht_firstten = cnvht_theta(:,:,:,1:10);
difht_firstten = difht_theta(:,:,:,1:10);

save('firstten_data.mat', 'uE_firstten', 'vN_firstten', 'theta_firstten', 'uv_firstten', ...
'temp_firstten', 'w_firstten', 'uEt_firstten', 'vNt_firstten', 'q_firstten', 'htrt_firstten', ... 
'radht_firstten', 'cndht_firstten', 'cnvht_firstten', 'difht_firstten');

else
load('firstten_data.mat')
load('tdayav_data.mat')

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Prepare fields for plotting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[uE_ft_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_firstten,ny,yc,ar,hc);
[vN_ft_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_firstten,ny,yc,ar,hc);
[theta_ft_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_firstten,ny,yc,ar,hc);
[temp_ft_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_firstten,ny,yc,ar,hc);
[uv_ft_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_firstten,ny,yc,ar,hc);
[vNt_ft_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_firstten,ny,yc,ar,hc);
[w_ft_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_firstten,ny,yc,ar,hc);
[q_ft_zav,mskzon,ylat,areazon]=calcZonalAvgCube(q_firstten,ny,yc,ar,hc);
[htrt_ft_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_firstten,ny,yc,ar,hc);
[radht_ft_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_firstten,ny,yc,ar,hc);
[cndht_ft_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_firstten,ny,yc,ar,hc);
[cnvht_ft_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_firstten,ny,yc,ar,hc);
[difht_ft_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_firstten,ny,yc,ar,hc);

for i = 1:10

uEvN_ft_zav(:,:,i) = uE_ft_zav(:,:,i).*vN_ft_zav(:,:,i);
uv_ed_ft_zav(:,:,i) = uv_ft_zav(:,:,i) - uEvN_ft_zav(:,:,i);

vN_zav_t_zav_ft(:,:,i) = vN_ft_zav(:,:,i).*theta_ft_zav(:,:,i);
vt_ed_ft_zav(:,:,i) = vNt_ft_zav(:,:,i) - vN_zav_t_zav_ft(:,:,i);

end


[uE_td_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_tdayav,ny,yc,ar,hc);
[vN_td_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_tdayav,ny,yc,ar,hc);
[theta_td_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_tdayav,ny,yc,ar,hc);
[temp_td_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_tdayav,ny,yc,ar,hc);
[uv_td_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_tdayav,ny,yc,ar,hc);
[vNt_td_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_tdayav,ny,yc,ar,hc);
[w_td_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_tdayav,ny,yc,ar,hc);
[q_td_zav,mskzon,ylat,areazon]=calcZonalAvgCube(q_tdayav,ny,yc,ar,hc);
[htrt_td_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_tdayav,ny,yc,ar,hc);
[radht_td_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_tdayav,ny,yc,ar,hc);
[cndht_td_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_tdayav,ny,yc,ar,hc);
[cnvht_td_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_tdayav,ny,yc,ar,hc);
[difht_td_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_tdayav,ny,yc,ar,hc);

for i = 1:36

uEvN_td_zav(:,:,i) = uE_td_zav(:,:,i).*vN_td_zav(:,:,i);
uv_ed_td_zav(:,:,i) = uv_td_zav(:,:,i) - uEvN_td_zav(:,:,i);

vN_zav_t_zav_td(:,:,i) = vN_td_zav(:,:,i).*theta_td_zav(:,:,i);
vt_ed_td_zav(:,:,i) = vNt_td_zav(:,:,i) - vN_zav_t_zav_td(:,:,i);

end




%take hemisphere averages

for i=1:45

uE_td_hzav(46-i,:,:) = (uE_td_zav(i,:,:) + uE_td_zav(91-i,:,:))./2;
uE_ft_hzav(46-i,:,:) = (uE_ft_zav(i,:,:) + uE_ft_zav(91-i,:,:))./2;

vN_td_hzav(46-i,:,:) = (-1*vN_td_zav(i,:,:) + vN_td_zav(91-i,:,:))./2;
vN_ft_hzav(46-i,:,:) = (-1*vN_ft_zav(i,:,:) + vN_ft_zav(91-i,:,:))./2;

theta_td_hzav(46-i,:,:) = (theta_td_zav(i,:,:) + theta_td_zav(91-i,:,:))./2;
theta_ft_hzav(46-i,:,:) = (theta_ft_zav(i,:,:) + theta_ft_zav(91-i,:,:))./2;

temp_td_hzav(46-i,:,:) = (temp_td_zav(i,:,:) + temp_td_zav(91-i,:,:))./2;
temp_ft_hzav(46-i,:,:) = (temp_ft_zav(i,:,:) + temp_ft_zav(91-i,:,:))./2;

uv_ed_td_hzav(46-i,:,:) = (-1*uv_ed_td_zav(i,:,:) + uv_ed_td_zav(91-i,:,:))./2;
uv_ed_ft_hzav(46-i,:,:) = (-1*uv_ed_ft_zav(i,:,:) + uv_ed_ft_zav(91-i,:,:))./2;

vt_ed_td_hzav(46-i,:,:) = (-1*vt_ed_td_zav(i,:,:) + vt_ed_td_zav(91-i,:,:))./2;
vt_ed_ft_hzav(46-i,:,:) = (-1*vt_ed_ft_zav(i,:,:) + vt_ed_ft_zav(91-i,:,:))./2;

w_td_hzav(46-i,:,:) = (w_td_zav(i,:,:) + w_td_zav(91-i,:,:))./2;
w_ft_hzav(46-i,:,:) = (w_ft_zav(i,:,:) + w_ft_zav(91-i,:,:))./2;

q_td_hzav(46-i,:,:) = (q_td_zav(i,:,:) + q_td_zav(91-i,:,:))./2;
q_ft_hzav(46-i,:,:) = (q_ft_zav(i,:,:) + q_ft_zav(91-i,:,:))./2;

htrt_td_hzav(46-i,:,:) = (htrt_td_zav(i,:,:) + htrt_td_zav(91-i,:,:))./2;
htrt_ft_hzav(46-i,:,:) = (htrt_ft_zav(i,:,:) + htrt_ft_zav(91-i,:,:))./2;

radht_td_hzav(46-i,:,:) = (radht_td_zav(i,:,:) + radht_td_zav(91-i,:,:))./2;
radht_ft_hzav(46-i,:,:) = (radht_ft_zav(i,:,:) + radht_ft_zav(91-i,:,:))./2;

cndht_td_hzav(46-i,:,:) = (cndht_td_zav(i,:,:) + cndht_td_zav(91-i,:,:))./2;
cndht_ft_hzav(46-i,:,:) = (cndht_ft_zav(i,:,:) + cndht_ft_zav(91-i,:,:))./2;

cnvht_td_hzav(46-i,:,:) = (cnvht_td_zav(i,:,:) + cnvht_td_zav(91-i,:,:))./2;
cnvht_ft_hzav(46-i,:,:) = (cnvht_ft_zav(i,:,:) + cnvht_ft_zav(91-i,:,:))./2;

difht_td_hzav(46-i,:,:) = (difht_td_zav(i,:,:) + difht_td_zav(91-i,:,:))./2;
difht_ft_hzav(46-i,:,:) = (difht_ft_zav(i,:,:) + difht_ft_zav(91-i,:,:))./2;

end

save('tdayav_data.mat', 'uE_td_hzav', 'vN_td_hzav', 'theta_td_hzav', ...
'temp_td_hzav', 'uv_ed_td_hzav', 'vt_ed_td_hzav', 'w_td_hzav', 'q_td_hzav', 'htrt_td_hzav', ... 
'radht_td_hzav', 'cndht_td_hzav', 'cnvht_td_hzav', 'difht_td_hzav','-append');

save('firstten_data.mat', 'uE_ft_hzav', 'vN_ft_hzav', 'theta_ft_hzav', ...
'temp_ft_hzav', 'uv_ed_ft_hzav', 'vt_ed_ft_hzav', 'w_ft_hzav', 'q_ft_hzav', 'htrt_ft_hzav', ... 
'radht_ft_hzav', 'cndht_ft_hzav', 'cnvht_ft_hzav', 'difht_ft_hzav','-append');


