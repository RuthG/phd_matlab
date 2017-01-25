%e_m_spinup
%read in additional months of data for dry -> wet expt and see what it's doing!


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

%read fields
i=0;
for nit = 784800:7200:950400;
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



%take zonal averages for plots

[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE,ny,yc,ar,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN,ny,yc,ar,hc);
[theta_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta,ny,yc,ar,hc);
[temp_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp,ny,yc,ar,hc);
[uv_ed_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ed,ny,yc,ar,hc);
[vt_ed_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vt_ed,ny,yc,ar,hc);
[w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w,ny,yc,ar,hc);
[q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(q,ny,yc,ar,hc);
[htrt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_theta,ny,yc,ar,hc);
[radht_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_theta,ny,yc,ar,hc);
[cndht_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_theta,ny,yc,ar,hc);
[cnvht_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_theta,ny,yc,ar,hc);
[difht_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_theta,ny,yc,ar,hc);


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

save('means_monthly_hzav.mat', 'uE_hzav', 'vN_hzav', 'theta_hzav', ...
'temp_hzav', 'uv_ed_hzav', 'vt_ed_hzav', 'w_hzav', 'q_hzav', 'htrt_hzav', ... 
'radht_hzav', 'cndht_hzav', 'cnvht_hzav', 'difht_hzav');
