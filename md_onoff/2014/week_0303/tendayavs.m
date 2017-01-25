%tendayavs
%read in spin up data  

%Read in iteration number, directory, MITgcm output and grid details

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_accidentalcontrol/';

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
for nit = 691440:240:705600;
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

J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp(:,:,j,i)=theta(:,:,j,i).*convthetatoT(j,1);
end

J=find(strcmp(fldList,'UV_VEL_C'));
uv(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av(:,:,:,i) = dyn(:,:,:,J);
[uEt_av(:,:,:,i),vNt_av(:,:,:,i)] = rotate_uv2uvEN(ut_av(:,:,:,i),vt_av(:,:,:,i),AngleCS,AngleSN,Grid);

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

for i=1:6

uE_mean(:,:,:,i) = mean(uE(:,:,:,10*i-9:10*i),4);
vN_mean(:,:,:,i) = mean(vN(:,:,:,10*i-9:10*i),4);
theta_mean(:,:,:,i) = mean(theta(:,:,:,10*i-9:10*i),4);
temp_mean(:,:,:,i) = mean(temp(:,:,:,10*i-9:10*i),4);
uv_mean(:,:,:,i) = mean(uv(:,:,:,10*i-9:10*i),4);
vNt_av_mean(:,:,:,i) = mean(vNt_av(:,:,:,10*i-9:10*i),4);
w_mean(:,:,:,i) = mean(w(:,:,:,10*i-9:10*i),4);
q_mean(:,:,:,i) = mean(q(:,:,:,10*i-9:10*i),4);
htrt_mean(:,:,:,i) = mean(htrt_theta(:,:,:,10*i-9:10*i),4);
radht_mean(:,:,:,i) = mean(radht_theta(:,:,:,10*i-9:10*i),4);
cndht_mean(:,:,:,i) = mean(cndht_theta(:,:,:,10*i-9:10*i),4);
cnvht_mean(:,:,:,i) = mean(cnvht_theta(:,:,:,10*i-9:10*i),4);
difht_mean(:,:,:,i) = mean(difht_theta(:,:,:,10*i-9:10*i),4);

end

%take zonal averages for plots

[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_mean,ny,yc,ar,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_mean,ny,yc,ar,hc);
[theta_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_mean,ny,yc,ar,hc);
[temp_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_mean,ny,yc,ar,hc);
[uv_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_mean,ny,yc,ar,hc);
[vNt_av_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_mean,ny,yc,ar,hc);
[w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_mean,ny,yc,ar,hc);
[q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(q_mean,ny,yc,ar,hc);
[htrt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_mean,ny,yc,ar,hc);
[radht_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_mean,ny,yc,ar,hc);
[cndht_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_mean,ny,yc,ar,hc);
[cnvht_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_mean,ny,yc,ar,hc);
[difht_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_mean,ny,yc,ar,hc);

uv_ed_zav = uv_zav - uE_zav.*vN_zav;
vt_ed_zav = vNt_av_zav - vN_zav.*theta_zav;

%take hemisphere averages

for i=1:45

uE_hzav(46-i,:,:) = (uE_zav(i,:,:) + uE_zav(91-i,:,:))./2;
vN_hzav(46-i,:,:) = (-1*vN_zav(i,:,:) + vN_zav(91-i,:,:))./2;
theta_hzav(46-i,:,:) = (theta_zav(i,:,:) + theta_zav(91-i,:,:))./2;
temp_hzav(46-i,:,:) = (temp_zav(i,:,:) + temp_zav(91-i,:,:))./2;
uv_ed_hzav(46-i,:,:) = (-1*uv_ed_zav(i,:,:) + uv_ed_zav(91-i,:,:))./2;
vt_ed_hzav(46-i,:,:) = (-1*vt_ed_zav(i,:,:) + vt_ed_zav(91-i,:,:))./2;
w_hzav(46-i,:,:) = (w_zav(i,:,:) + w_zav(91-i,:,:))./2;
q_hzav(46-i,:,:) = (q_zav(i,:,:) + q_zav(91-i,:,:))./2;
htrt_hzav(46-i,:,:) = (htrt_zav(i,:,:) + htrt_zav(91-i,:,:))./2;
radht_hzav(46-i,:,:) = (radht_zav(i,:,:) + radht_zav(91-i,:,:))./2;
cndht_hzav(46-i,:,:) = (cndht_zav(i,:,:) + cndht_zav(91-i,:,:))./2;
cnvht_hzav(46-i,:,:) = (cnvht_zav(i,:,:) + cnvht_zav(91-i,:,:))./2;
difht_hzav(46-i,:,:) = (difht_zav(i,:,:) + difht_zav(91-i,:,:))./2;

end

save('tendayavs.mat');

