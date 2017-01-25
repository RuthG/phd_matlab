%Calculate heat budget for 3 control states

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';
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
for nit = 432000:86400:604800;
i=i+1
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_c(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_c(:,:,:,i) = dyn(:,:,:,J);
[uE_c(:,:,:,i),vN_c(:,:,:,i)] = rotate_uv2uvEN(ucs_c(:,:,:,i),vcs_c(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'WVEL    '));
w_c(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_c(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_c(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_c(:,:,:,i),vNt_av_c(:,:,:,i)] = rotate_uv2uvEN(ut_av_c(:,:,:,i),vt_av_c(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_c(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:25
temp_c(:,:,k,i)=theta_c(:,:,k,i).*convthetatoT(k,1);
%rho(:,:,k,i) = rC(k)./(Ra.*temp_c(:,:,k,i));
end

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_c=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_c=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_c=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_c=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_c=dyn(:,:,:,J);



rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv_tropheat3eq/';
nit_q = nit + 518400;
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit_q);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_th(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_th(:,:,:,i) = dyn(:,:,:,J);
[uE_th(:,:,:,i),vN_th(:,:,:,i)] = rotate_uv2uvEN(ucs_th(:,:,:,i),vcs_th(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'WVEL    '));
w_th(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_th(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_th(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_th(:,:,:,i),vNt_av_th(:,:,:,i)] = rotate_uv2uvEN(ut_av_th(:,:,:,i),vt_av_th(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_th(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:25
temp_th(:,:,k,i)=theta_th(:,:,k,i).*convthetatoT(k,1);
%rho(:,:,k,i) = rC(k)./(Ra.*temp_th(:,:,k,i));
end

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_th=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_th=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_th=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_th=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_th=dyn(:,:,:,J);





rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i) = dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'WVEL    '));
w_w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_w(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_w(:,:,:,i),vNt_av_w(:,:,:,i)] = rotate_uv2uvEN(ut_av_w(:,:,:,i),vt_av_w(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:25
temp_w(:,:,k,i)=theta_w(:,:,k,i).*convthetatoT(k,1);
%rho(:,:,k,i) = rC(k)./(Ra.*temp_w(:,:,k,i));
end

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_w=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_w=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_w=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_w=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_w=dyn(:,:,:,J);




end


[uE_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_c,ny,yc,ar,hc);
[vN_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_c,ny,yc,ar,hc);
[uEt_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uEt_av_c,ny,yc,ar,hc);
[vNt_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_c,ny,yc,ar,hc);
[w_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_c,ny,yc,ar,hc);
[theta_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_c,ny,yc,ar,hc);
%[rho_zav,mskzon,ylat,areazon]=calcZonalAvgCube(rho_c,ny,yc,ar,hc);
[htrt_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_c,ny,yc,ar,hc);
[difht_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_c,ny,yc,ar,hc);
[radht_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_c,ny,yc,ar,hc);
[cndht_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_c,ny,yc,ar,hc);
[cnvht_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_c,ny,yc,ar,hc);

[uE_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_th,ny,yc,ar,hc);
[vN_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_th,ny,yc,ar,hc);
[uEt_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uEt_av_th,ny,yc,ar,hc);
[vNt_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_th,ny,yc,ar,hc);
[w_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_th,ny,yc,ar,hc);
[theta_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_th,ny,yc,ar,hc);
%[rho_zav,mskzon,ylat,areazon]=calcZonalAvgCube(rho_th,ny,yc,ar,hc);
[htrt_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_th,ny,yc,ar,hc);
[difht_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_th,ny,yc,ar,hc);
[radht_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_th,ny,yc,ar,hc);
[cndht_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_th,ny,yc,ar,hc);
[cnvht_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_th,ny,yc,ar,hc);

[uE_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_w,ny,yc,ar,hc);
[vN_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_w,ny,yc,ar,hc);
[uEt_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uEt_av_w,ny,yc,ar,hc);
[vNt_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_w,ny,yc,ar,hc);
[w_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_w,ny,yc,ar,hc);
[theta_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_w,ny,yc,ar,hc);
%[rho_zav,mskzon,ylat,areazon]=calcZonalAvgCube(rho_w,ny,yc,ar,hc);
[htrt_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_w,ny,yc,ar,hc);
[difht_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_w,ny,yc,ar,hc);
[radht_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_w,ny,yc,ar,hc);
[cndht_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_w,ny,yc,ar,hc);
[cnvht_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_w,ny,yc,ar,hc);


a=6371.0e3;
vNt_c_ed_zav = vNt_c_zav - vN_c_zav.*theta_c_zav;
vNt_th_ed_zav = vNt_th_zav - vN_th_zav.*theta_th_zav;
vNt_w_ed_zav = vNt_w_zav - vN_w_zav.*theta_w_zav;

%w_z = -1.*w_zav./rho_zav./9.81;

dthetadp_c = gradient(theta_c_zav,-4000);
dthetadp_th = gradient(theta_th_zav,-4000);
dthetadp_w = gradient(theta_w_zav,-4000);

vert_c_adv = -1.*w_c_zav.*dthetadp_c;
vert_th_adv = -1.*w_th_zav.*dthetadp_th;
vert_w_adv = -1.*w_w_zav.*dthetadp_w;

for i=1:90
vNt_c_ed_zav_wt(i,:,:) = vNt_c_ed_zav(i,:,:).*cos(ylat(i).*pi./180);
vNt_c_zav_wt(i,:,:) = vNt_c_zav(i,:,:).*cos(ylat(i).*pi./180);

vNt_th_ed_zav_wt(i,:,:) = vNt_th_ed_zav(i,:,:).*cos(ylat(i).*pi./180);
vNt_th_zav_wt(i,:,:) = vNt_th_zav(i,:,:).*cos(ylat(i).*pi./180);

vNt_w_ed_zav_wt(i,:,:) = vNt_w_ed_zav(i,:,:).*cos(ylat(i).*pi./180);
vNt_w_zav_wt(i,:,:) = vNt_w_zav(i,:,:).*cos(ylat(i).*pi./180);
end

[moo,vNt_c_conv_s,boo] = gradient(vNt_c_ed_zav_wt,pi./90);
[moo,vNt_c_zav_conv_s,boo] = gradient(vNt_c_zav_wt,pi./90);
[moo,vNt_th_conv_s,boo] = gradient(vNt_th_ed_zav_wt,pi./90);
[moo,vNt_th_zav_conv_s,boo] = gradient(vNt_th_zav_wt,pi./90);
[moo,vNt_w_conv_s,boo] = gradient(vNt_w_ed_zav_wt,pi./90);
[moo,vNt_w_zav_conv_s,boo] = gradient(vNt_w_zav_wt,pi./90);

for i=1:90
vNt_c_conv(i,:,:) = -1.*vNt_c_conv_s(i,:,:)./cos(ylat(i).*pi./180)./a;
vNt_c_zav_conv(i,:,:) = -1.*vNt_c_zav_conv_s(i,:,:)./cos(ylat(i).*pi./180)./a;
vNt_th_conv(i,:,:) = -1.*vNt_th_conv_s(i,:,:)./cos(ylat(i).*pi./180)./a;
vNt_th_zav_conv(i,:,:) = -1.*vNt_th_zav_conv_s(i,:,:)./cos(ylat(i).*pi./180)./a;
vNt_w_conv(i,:,:) = -1.*vNt_w_conv_s(i,:,:)./cos(ylat(i).*pi./180)./a;
vNt_w_zav_conv(i,:,:) = -1.*vNt_w_zav_conv_s(i,:,:)./cos(ylat(i).*pi./180)./a;
end

vNt_c_conv_mean = mean(vNt_c_conv,3);
vert_c_adv_mean = mean(vert_c_adv,3);
htrt_c_mean = mean(htrt_c_zav,3);

vNt_th_conv_mean = mean(vNt_th_conv,3);
vert_th_adv_mean = mean(vert_th_adv,3);
htrt_th_mean = mean(htrt_th_zav,3);

vNt_w_conv_mean = mean(vNt_w_conv,3);
vert_w_adv_mean = mean(vert_w_adv,3);
htrt_w_mean = mean(htrt_w_zav,3);

vNt_c_conv_vint = sum(vNt_c_conv_mean,2).*4000./9.81;
vert_c_adv_vint = sum(vert_c_adv_mean,2).*4000./9.81;
htrt_c_vint = sum(htrt_c_mean,2).*4000./9.81;

vNt_th_conv_vint = sum(vNt_th_conv_mean,2).*4000./9.81;
vert_th_adv_vint = sum(vert_th_adv_mean,2).*4000./9.81;
htrt_th_vint = sum(htrt_th_mean,2).*4000./9.81;

vNt_w_conv_vint = sum(vNt_w_conv_mean,2).*4000./9.81;
vert_w_adv_vint = sum(vert_w_adv_mean,2).*4000./9.81;
htrt_w_vint = sum(htrt_w_mean,2).*4000./9.81;



for i=1:45

vNt_c_conv_vinth(i) = (vNt_c_conv_vint(46-i) + vNt_c_conv_vint(45+i))./2;
vert_c_adv_vinth(i) = (vert_c_adv_vint(46-i) + vert_c_adv_vint(45+i))./2;
htrt_c_vinth(i) = (htrt_c_vint(46-i) + htrt_c_vint(45+i))./2;

vNt_th_conv_vinth(i) = (vNt_th_conv_vint(46-i) + vNt_th_conv_vint(45+i))./2;
vert_th_adv_vinth(i) = (vert_th_adv_vint(46-i) + vert_th_adv_vint(45+i))./2;
htrt_th_vinth(i) = (htrt_th_vint(46-i) + htrt_th_vint(45+i))./2;

vNt_w_conv_vinth(i) = (vNt_w_conv_vint(46-i) + vNt_w_conv_vint(45+i))./2;
vert_w_adv_vinth(i) = (vert_w_adv_vint(46-i) + vert_w_adv_vint(45+i))./2;
htrt_w_vinth(i) = (htrt_w_vint(46-i) + htrt_w_vint(45+i))./2;

end






figure
plot(ylat(46:90),vNt_c_conv_vinth,'k')
hold on
plot(ylat(46:90),-1.*vert_c_adv_vinth,'k--')
plot(ylat(46:90),htrt_c_vinth,'k-.')
plot(ylat(46:90),htrt_c_vinth+vert_c_adv_vinth+vNt_c_conv_vinth,'k:')
xlabel('Latitude')
ylabel('Vertically integrated heat budget')
ylim([-0.2 0.8])
title('Vertically integrated heat budget: Control')
legend('Eddy heat term','(-1)x Vertical advection term','Diabatic heating','Residual')
print('-dpng','heat_budget_control.png')


figure
plot(ylat(46:90),vNt_th_conv_vinth,'k')
hold on
plot(ylat(46:90),-1.*vert_th_adv_vinth,'k--')
plot(ylat(46:90),htrt_th_vinth,'k-.')
plot(ylat(46:90),htrt_th_vinth+vert_th_adv_vinth+vNt_th_conv_vinth,'k:')
xlabel('Latitude')
ylabel('Vertically integrated heat budget')
ylim([-0.2 0.8])
title('Vertically integrated heat budget: Tropical Heating Expt')
legend('Eddy heat term','(-1)x Vertical advection term','Diabatic heating','Residual')
print('-dpng','heat_budget_tropheat.png')


figure
plot(ylat(46:90),vNt_w_conv_vinth,'k')
hold on
plot(ylat(46:90),-1.*vert_w_adv_vinth,'k--')
plot(ylat(46:90),htrt_w_vinth,'k-.')
plot(ylat(46:90),htrt_w_vinth+vert_w_adv_vinth+vNt_w_conv_vinth,'k:')
xlabel('Latitude')
ylabel('Vertically integrated heat budget')
ylim([-0.2 0.8])
title('Vertically integrated heat budget: Wet Expt')
legend('Eddy heat term','(-1)x Vertical advection term','Diabatic heating','Residual')
print('-dpng','heat_budget_wet.png')



figure
plot(ylat(46:90),vNt_th_conv_vinth-vNt_c_conv_vinth,'k')
hold on
plot(ylat(46:90),-1.*(vert_th_adv_vinth-vert_c_adv_vinth),'k--')
plot(ylat(46:90),htrt_th_vinth - htrt_c_vinth,'k-.')
plot(ylat(46:90),(htrt_th_vinth+vert_th_adv_vinth+vNt_th_conv_vinth) - (htrt_c_vinth+vert_c_adv_vinth+vNt_c_conv_vinth),'k:')
xlabel('Latitude')
ylabel('Vertically integrated heat budget')
ylim([-0.2 0.4])
title('Vertically integrated heat budget: Tropical Heating - Control')
legend('Eddy heat term','(-1)x Vertical advection term','Diabatic heating','Residual')
print('-dpng','heat_budget_thmc.png')


figure
plot(ylat(46:90),vNt_w_conv_vinth-vNt_c_conv_vinth,'k')
hold on
plot(ylat(46:90),-1.*(vert_w_adv_vinth-vert_c_adv_vinth),'k--')
plot(ylat(46:90),htrt_w_vinth - htrt_c_vinth,'k-.')
plot(ylat(46:90),(htrt_w_vinth+vert_w_adv_vinth+vNt_w_conv_vinth) - (htrt_c_vinth+vert_c_adv_vinth+vNt_c_conv_vinth),'k:')
xlabel('Latitude')
ylabel('Vertically integrated heat budget')
ylim([-0.2 0.4])
title('Vertically integrated heat budget: Wet - Control')
legend('Eddy heat term','(-1)x Vertical advection term','Diabatic heating','Residual')
print('-dpng','heat_budget_wmc.png')
