%Calculate heat budget...
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

%Load in U, V, UV, Tau

%read fields
i=0;
for nit = 259200:86400:604800;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_ctrl(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_ctrl(:,:,:,i) = dyn(:,:,:,J);
[uE_ctrl(:,:,:,i),vN_ctrl(:,:,:,i)] = rotate_uv2uvEN(ucs_ctrl(:,:,:,i),vcs_ctrl(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'WVEL    '));
w_ctrl(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_ctrl(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_ctrl(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_ctrl(:,:,:,i),vNt_av_ctrl(:,:,:,i)] = rotate_uv2uvEN(ut_av_ctrl(:,:,:,i),vt_av_ctrl(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_ctrl(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:25
temp_ctrl(:,:,k,i)=theta_ctrl(:,:,k,i).*convthetatoT(k,1);
%rho(:,:,k,i) = rC(k)./(Ra.*temp_ctrl(:,:,k,i));
end

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_ctrl=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_ctrl=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_ctrl=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_ctrl=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_ctrl=dyn(:,:,:,J);


end


[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_ctrl,ny,yc,ar,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_ctrl,ny,yc,ar,hc);
[uEt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uEt_av_ctrl,ny,yc,ar,hc);
[vNt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_ctrl,ny,yc,ar,hc);
[w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_ctrl,ny,yc,ar,hc);
[theta_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_ctrl,ny,yc,ar,hc);
%[rho_zav,mskzon,ylat,areazon]=calcZonalAvgCube(rho_ctrl,ny,yc,ar,hc);
[htrt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_ctrl,ny,yc,ar,hc);
[difht_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_ctrl,ny,yc,ar,hc);
[radht_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_ctrl,ny,yc,ar,hc);
[cndht_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_ctrl,ny,yc,ar,hc);
[cnvht_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_ctrl,ny,yc,ar,hc);
a=6371.0e3;
vNt_ed_zav = vNt_zav - vN_zav.*theta_zav;

%w_z = -1.*w_zav./rho_zav./9.81;

dthetadp = gradient(theta_zav,-4000);

vert_adv = -1.*w_zav.*dthetadp;

for i=1:90
vNt_ed_zav_wt(i,:,:) = vNt_ed_zav(i,:,:).*cos(ylat(i).*pi./180);
vNt_zav_wt(i,:,:) = vNt_zav(i,:,:).*cos(ylat(i).*pi./180);
end

[moo,vNt_conv_s,boo] = gradient(vNt_ed_zav_wt,pi./90);
[moo,vNt_zav_conv_s,boo] = gradient(vNt_zav_wt,pi./90);

for i=1:90
vNt_conv(i,:,:) = -1.*vNt_conv_s(i,:,:)./cos(ylat(i).*pi./180)./a;
vNt_zav_conv(i,:,:) = -1.*vNt_zav_conv_s(i,:,:)./cos(ylat(i).*pi./180)./a;
end

vNt_conv_mean = mean(vNt_conv,3);
vert_adv_mean = mean(vert_adv,3);
htrt_mean = mean(htrt_zav,3);

vNt_conv_vint = sum(vNt_conv_mean,2).*4000./9.81;
vert_adv_vint = sum(vert_adv_mean,2).*4000./9.81;
htrt_vint = sum(htrt_mean,2).*4000./9.81;

figure
plot(ylat,vNt_conv_vint)
hold on
plot(ylat,vert_adv_vint,'g')
plot(ylat,htrt_vint,'r')
plot(ylat,htrt_vint+vert_adv_vint+vNt_conv_vint,'k')
xlabel('Latitude')
ylabel('Vertically integrated heat budget')
legend('Eddy heat term','Diabatic heating','Vertical advection term')
print('-dpng','heat_budget.png')

