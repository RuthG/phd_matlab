
rDir='/disk1/MITgcm/verification/atm_gray_ruth/ensemble_control/';

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


%load up 10 members of ensemble
for j=0:9
i=0;
j
% label for particular day
for nit = 605040+j*14400:240:619200+j*14400; 
i=i+1
%label for particular run
nitstart = 604800+j*14400;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Tropheat run%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rDir=['/disk1/MITgcm/verification/atm_gray_ruth/ensemble/run_start_' num2str(nitstart) '/'];


[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_th(:,:,:,i,j+1) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_th(:,:,:,i,j+1) = dyn(:,:,:,J);
[uE_th(:,:,:,i,j+1),vN_th(:,:,:,i,j+1)] = rotate_uv2uvEN(ucs_th(:,:,:,i,j+1),vcs_th(:,:,:,i,j+1),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'WVEL    '));
w_th(:,:,:,i,j+1) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_th(:,:,:,i,j+1) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_th(:,:,:,i,j+1) = dyn(:,:,:,J);
[uEt_av_th(:,:,:,i,j+1),vNt_av_th(:,:,:,i,j+1)] = rotate_uv2uvEN(ut_av_th(:,:,:,i,j+1),vt_av_th(:,:,:,i,j+1),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_th(:,:,:,i,j+1) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:25
temp_th(:,:,k,i,j+1)=theta_th(:,:,k,i,j+1).*convthetatoT(k,1);

end

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_th(:,:,:,i,j+1)=dyn(:,:,:,J);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Control run%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rDir='/disk1/MITgcm/verification/atm_gray_ruth/ensemble_control/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_c(:,:,:,i,j+1) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_c(:,:,:,i,j+1) = dyn(:,:,:,J);
[uE_c(:,:,:,i,j+1),vN_c(:,:,:,i,j+1)] = rotate_uv2uvEN(ucs_c(:,:,:,i,j+1),vcs_c(:,:,:,i,j+1),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'WVEL    '));
w_c(:,:,:,i,j+1) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_c(:,:,:,i,j+1) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_c(:,:,:,i,j+1) = dyn(:,:,:,J);
[uEt_av_c(:,:,:,i,j+1),vNt_av_c(:,:,:,i,j+1)] = rotate_uv2uvEN(ut_av_c(:,:,:,i,j+1),vt_av_c(:,:,:,i,j+1),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_c(:,:,:,i,j+1) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:25
temp_c(:,:,k,i,j+1)=theta_c(:,:,k,i,j+1).*convthetatoT(k,1);

end

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_c(:,:,:,i,j+1)=dyn(:,:,:,J);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Wet run%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rDir=['/disk1/MITgcm/verification/atm_gray_ruth/ensemble_wet/run_start_' num2str(nitstart) '/'];

%ignore run that failed for wet spin-up
if nitstart < 662400
counter = j+1;
elseif nitstart > 662400
counter = j;
end

if nitstart ~= 662400
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i,counter) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i,counter) = dyn(:,:,:,J);
[uE_w(:,:,:,i,counter),vN_w(:,:,:,i,counter)] = rotate_uv2uvEN(ucs_w(:,:,:,i,counter),vcs_w(:,:,:,i,counter),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'WVEL    '));
w_w(:,:,:,i,counter) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_w(:,:,:,i,counter) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_w(:,:,:,i,counter) = dyn(:,:,:,J);
[uEt_av_w(:,:,:,i,counter),vNt_av_w(:,:,:,i,counter)] = rotate_uv2uvEN(ut_av_w(:,:,:,i,counter),vt_av_w(:,:,:,i,counter),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i,counter) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:25
temp_w(:,:,k,i,counter)=theta_w(:,:,k,i,counter).*convthetatoT(k,1);

end

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_w(:,:,:,i,counter)=dyn(:,:,:,J);


end

end
end

'variables loaded'

[uE_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_c,ny,yc,ar,hc);
[vN_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_c,ny,yc,ar,hc);
[uEt_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uEt_av_c,ny,yc,ar,hc);
[vNt_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_c,ny,yc,ar,hc);
[w_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_c,ny,yc,ar,hc);
[theta_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_c,ny,yc,ar,hc);
[htrt_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_c,ny,yc,ar,hc);

'Ctrl zavs done'

[uE_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_th,ny,yc,ar,hc);
[vN_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_th,ny,yc,ar,hc);
[uEt_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uEt_av_th,ny,yc,ar,hc);
[vNt_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_th,ny,yc,ar,hc);
[w_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_th,ny,yc,ar,hc);
[theta_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_th,ny,yc,ar,hc);
[htrt_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_th,ny,yc,ar,hc);


'Tropheat zavs done'

[uE_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_w,ny,yc,ar,hc);
[vN_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_w,ny,yc,ar,hc);
[uEt_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uEt_av_w,ny,yc,ar,hc);
[vNt_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_w,ny,yc,ar,hc);
[w_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_w,ny,yc,ar,hc);
[theta_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_w,ny,yc,ar,hc);
[htrt_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_w,ny,yc,ar,hc);

'Wet zavs done'

a=6371.0e3;
vNt_c_ed_zav = vNt_c_zav - vN_c_zav.*theta_c_zav;
vNt_th_ed_zav = vNt_th_zav - vN_th_zav.*theta_th_zav;
vNt_w_ed_zav = vNt_w_zav - vN_w_zav.*theta_w_zav;

vNt_c_mean(:,:,:) = mean(vNt_c_ed_zav,4);
theta_c_mean(:,:,:) = mean(theta_c_zav,4);
htrt_c_mean(:,:,:) = mean(htrt_c_zav,4);
w_c_mean(:,:,:) = mean(w_c_zav,4);
vNt_th_mean(:,:,:) = mean(vNt_th_ed_zav,4);
theta_th_mean(:,:,:) = mean(theta_th_zav,4);
htrt_th_mean(:,:,:) = mean(htrt_th_zav,4);
w_th_mean(:,:,:) = mean(w_th_zav,4);
vNt_w_mean(:,:,:) = mean(vNt_w_ed_zav,4);
theta_w_mean(:,:,:) = mean(theta_w_zav,4);
htrt_w_mean(:,:,:) = mean(htrt_w_zav,4);
w_w_mean(:,:,:) = mean(w_w_zav,4);



for i=1:45
vNt_c_hzav(i,:,:) = (-vNt_c_mean(46-i,:,:) + vNt_c_mean(45+i,:,:))./2;
theta_c_hzav(i,:,:) = (theta_c_mean(46-i,:,:) + theta_c_mean(45+i,:,:))./2;
htrt_c_hzav(i,:,:) = (htrt_c_mean(46-i,:,:) + htrt_c_mean(45+i,:,:))./2;
w_c_hzav(i,:,:) = (w_c_mean(46-i,:,:) + w_c_mean(45+i,:,:))./2;

vNt_th_hzav(i,:,:) = (-vNt_th_mean(46-i,:,:) + vNt_th_mean(45+i,:,:))./2;
theta_th_hzav(i,:,:) = (theta_th_mean(46-i,:,:) + theta_th_mean(45+i,:,:))./2;
htrt_th_hzav(i,:,:) = (htrt_th_mean(46-i,:,:) + htrt_th_mean(45+i,:,:))./2;
w_th_hzav(i,:,:) = (w_th_mean(46-i,:,:) + w_th_mean(45+i,:,:))./2;

vNt_w_hzav(i,:,:) = (-vNt_w_mean(46-i,:,:) + vNt_w_mean(45+i,:,:))./2;
theta_w_hzav(i,:,:) = (theta_w_mean(46-i,:,:) + theta_w_mean(45+i,:,:))./2;
htrt_w_hzav(i,:,:) = (htrt_w_mean(46-i,:,:) + htrt_w_mean(45+i,:,:))./2;
w_w_hzav(i,:,:) = (w_w_mean(46-i,:,:) + w_w_mean(45+i,:,:))./2;
end

for i=1:6
vNt_c_thzav(:,:,i) = mean(vNt_c_hzav(:,:,10*i-9:10*i),3);
theta_c_thzav(:,:,i) = mean(theta_c_hzav(:,:,10*i-9:10*i),3);
htrt_c_thzav(:,:,i) = mean(htrt_c_hzav(:,:,10*i-9:10*i),3);
w_c_thzav(:,:,i) = mean(w_c_hzav(:,:,10*i-9:10*i),3);

vNt_th_thzav(:,:,i) = mean(vNt_th_hzav(:,:,10*i-9:10*i),3);
theta_th_thzav(:,:,i) = mean(theta_th_hzav(:,:,10*i-9:10*i),3);
htrt_th_thzav(:,:,i) = mean(htrt_th_hzav(:,:,10*i-9:10*i),3);
w_th_thzav(:,:,i) = mean(w_th_hzav(:,:,10*i-9:10*i),3);

vNt_w_thzav(:,:,i) = mean(vNt_w_hzav(:,:,10*i-9:10*i),3);
theta_w_thzav(:,:,i) = mean(theta_w_hzav(:,:,10*i-9:10*i),3);
htrt_w_thzav(:,:,i) = mean(htrt_w_hzav(:,:,10*i-9:10*i),3);
w_w_thzav(:,:,i) = mean(w_w_hzav(:,:,10*i-9:10*i),3);

end


save('heat_budg_bits.mat','vNt_c_thzav','theta_c_thzav','htrt_c_thzav','w_c_thzav', 'vNt_th_thzav','theta_th_thzav','htrt_th_thzav','w_th_thzav', 'vNt_w_thzav','theta_w_thzav','htrt_w_thzav','w_w_thzav')

