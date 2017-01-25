%load in total heating and vTheta and see if these balance?


% choose directory, load grid
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

%read files
i=0;
for nit = 259200:86400:604800;
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';

%heating rates
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_w(:,:,:,i)=dyn(:,:,:,J);

J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i)=dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'UVELTH  '));
ucsth_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vcsth_w(:,:,:,i)=dyn(:,:,:,J);
[uEth_w(:,:,:,i),vNth_w(:,:,:,i)] = rotate_uv2uvEN(ucsth_w(:,:,:,i),vcsth_w(:,:,:,i),AngleCS,AngleSN,Grid);


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';

%heating rates
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_h(:,:,:,i)=dyn(:,:,:,J);

J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_h(:,:,:,i)=dyn(:,:,:,J);
[uE_h(:,:,:,i),vN_h(:,:,:,i)] = rotate_uv2uvEN(ucs_h(:,:,:,i),vcs_h(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'UVELTH  '));
ucsth_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vcsth_h(:,:,:,i)=dyn(:,:,:,J);
[uEth_h(:,:,:,i),vNth_h(:,:,:,i)] = rotate_uv2uvEN(ucsth_h(:,:,:,i),vcsth_h(:,:,:,i),AngleCS,AngleSN,Grid);


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_quarterwv/';

%heating rates
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);


J=find(strcmp(fldList,'AtPhdTdt'));
htrt_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_q(:,:,:,i)=dyn(:,:,:,J);

J=find(strcmp(fldList,'THETA   '));
theta_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_q(:,:,:,i)=dyn(:,:,:,J);
[uE_q(:,:,:,i),vN_q(:,:,:,i)] = rotate_uv2uvEN(ucs_q(:,:,:,i),vcs_q(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'UVELTH  '));
ucsth_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vcsth_q(:,:,:,i)=dyn(:,:,:,J);
[uEth_q(:,:,:,i),vNth_q(:,:,:,i)] = rotate_uv2uvEN(ucsth_q(:,:,:,i),vcsth_q(:,:,:,i),AngleCS,AngleSN,Grid);


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';

%heating rates
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);


J=find(strcmp(fldList,'AtPhdTdt'));
htrt_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_d(:,:,:,i)=dyn(:,:,:,J);

J=find(strcmp(fldList,'THETA   '));
theta_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_d(:,:,:,i)=dyn(:,:,:,J);
[uE_d(:,:,:,i),vN_d(:,:,:,i)] = rotate_uv2uvEN(ucs_d(:,:,:,i),vcs_d(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'UVELTH  '));
ucsth_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vcsth_d(:,:,:,i)=dyn(:,:,:,J);
[uEth_d(:,:,:,i),vNth_d(:,:,:,i)] = rotate_uv2uvEN(ucsth_d(:,:,:,i),vcsth_d(:,:,:,i),AngleCS,AngleSN,Grid);


end


htrt_w_mean = mean(htrt_w,4);
difht_w_mean = mean(difht_w,4);
radht_w_mean = mean(radht_w,4);
cndht_w_mean = mean(cndht_w,4);
cnvht_w_mean = mean(cnvht_w,4);
vNth_w_mean = mean(vNth_w,4);
vN_w_mean = mean(vN_w,4);
theta_w_mean = mean(theta_w,4);

htrt_h_mean = mean(htrt_h,4);
difht_h_mean = mean(difht_h,4);
radht_h_mean = mean(radht_h,4);
cndht_h_mean = mean(cndht_h,4);
cnvht_h_mean = mean(cnvht_h,4);
vNth_h_mean = mean(vNth_h,4);
vN_h_mean = mean(vN_h,4);
theta_h_mean = mean(theta_h,4);

htrt_q_mean = mean(htrt_q,4);
difht_q_mean = mean(difht_q,4);
radht_q_mean = mean(radht_q,4);
cndht_q_mean = mean(cndht_q,4);
cnvht_q_mean = mean(cnvht_q,4);
vNth_q_mean = mean(vNth_q,4);
vN_q_mean = mean(vN_q,4);
theta_q_mean = mean(theta_q,4);

htrt_d_mean = mean(htrt_d,4);
difht_d_mean = mean(difht_d,4);
radht_d_mean = mean(radht_d,4);
cndht_d_mean = mean(cndht_d,4);
cnvht_d_mean = mean(cnvht_d,4);
vNth_d_mean = mean(vNth_d,4);
vN_d_mean = mean(vN_d,4);
theta_d_mean = mean(theta_d,4);

g=9.81;
cp=1004.64;
intfac = 4000.*cp./g;
a=6371.0e3;
htrt_w_vint = sum(htrt_w_mean,3).*intfac;
difht_w_vint = sum(difht_w_mean,3).*intfac;
radht_w_vint = sum(radht_w_mean,3).*intfac;
cndht_w_vint = sum(cndht_w_mean,3).*intfac;
cnvht_w_vint = sum(cnvht_w_mean,3).*intfac;

htrt_h_vint = sum(htrt_h_mean,3).*intfac;
difht_h_vint = sum(difht_h_mean,3).*intfac;
radht_h_vint = sum(radht_h_mean,3).*intfac;
cndht_h_vint = sum(cndht_h_mean,3).*intfac;
cnvht_h_vint = sum(cnvht_h_mean,3).*intfac;

htrt_q_vint = sum(htrt_q_mean,3).*intfac;
difht_q_vint = sum(difht_q_mean,3).*intfac;
radht_q_vint = sum(radht_q_mean,3).*intfac;
cndht_q_vint = sum(cndht_q_mean,3).*intfac;
cnvht_q_vint = sum(cnvht_q_mean,3).*intfac;

htrt_d_vint = sum(htrt_d_mean,3).*intfac;
difht_d_vint = sum(difht_d_mean,3).*intfac;
radht_d_vint = sum(radht_d_mean,3).*intfac;
cndht_d_vint = sum(cndht_d_mean,3).*intfac;
cnvht_d_vint = sum(cnvht_d_mean,3).*intfac;

[htrt_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_w_vint,ny,yc,ar,hc);
[difht_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_w_vint,ny,yc,ar,hc);
[radht_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_w_vint,ny,yc,ar,hc);
[cndht_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_w_vint,ny,yc,ar,hc);
[cnvht_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_w_vint,ny,yc,ar,hc);
[theta_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_w_mean,ny,yc,ar,hc);
[vN_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_w_mean,ny,yc,ar,hc);
[vNth_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNth_w_mean,ny,yc,ar,hc);
vNth_zon_w_zav = vN_w_zav.*theta_w_zav;
vNth_ed_w_zav = vNth_w_zav - vNth_zon_w_zav;

[htrt_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_h_vint,ny,yc,ar,hc);
[difht_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_h_vint,ny,yc,ar,hc);
[radht_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_h_vint,ny,yc,ar,hc);
[cndht_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_h_vint,ny,yc,ar,hc);
[cnvht_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_h_vint,ny,yc,ar,hc);
[theta_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_h_mean,ny,yc,ar,hc);
[vN_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_h_mean,ny,yc,ar,hc);
[vNth_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNth_h_mean,ny,yc,ar,hc);
vNth_zon_h_zav = vN_h_zav.*theta_h_zav;
vNth_ed_h_zav = vNth_h_zav - vNth_zon_h_zav;


[htrt_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_q_vint,ny,yc,ar,hc);
[difht_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_q_vint,ny,yc,ar,hc);
[radht_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_q_vint,ny,yc,ar,hc);
[cndht_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_q_vint,ny,yc,ar,hc);
[cnvht_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_q_vint,ny,yc,ar,hc);
[theta_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_q_mean,ny,yc,ar,hc);
[vN_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_q_mean,ny,yc,ar,hc);
[vNth_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNth_q_mean,ny,yc,ar,hc);
vNth_zon_q_zav = vN_q_zav.*theta_q_zav;
vNth_ed_q_zav = vNth_q_zav - vNth_zon_q_zav;

[htrt_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_d_vint,ny,yc,ar,hc);
[difht_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_d_vint,ny,yc,ar,hc);
[radht_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_d_vint,ny,yc,ar,hc);
[cndht_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_d_vint,ny,yc,ar,hc);
[cnvht_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_d_vint,ny,yc,ar,hc);
[theta_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_d_mean,ny,yc,ar,hc);
[vN_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_d_mean,ny,yc,ar,hc);
[vNth_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNth_d_mean,ny,yc,ar,hc);
vNth_zon_d_zav = vN_d_zav.*theta_d_zav;
vNth_ed_d_zav = vNth_d_zav - vNth_zon_d_zav;

for i=1:90
vNth_zon_w_wt(i,:,:) = vNth_zon_w_zav(i,:,:).*cos(ylat(i).*pi./180);
vNth_zon_h_wt(i,:,:) = vNth_zon_h_zav(i,:,:).*cos(ylat(i).*pi./180);
vNth_zon_q_wt(i,:,:) = vNth_zon_q_zav(i,:,:).*cos(ylat(i).*pi./180);
vNth_zon_d_wt(i,:,:) = vNth_zon_d_zav(i,:,:).*cos(ylat(i).*pi./180);

vNth_ed_w_wt(i,:,:) = vNth_ed_w_zav(i,:,:).*cos(ylat(i).*pi./180);
vNth_ed_h_wt(i,:,:) = vNth_ed_h_zav(i,:,:).*cos(ylat(i).*pi./180);
vNth_ed_q_wt(i,:,:) = vNth_ed_q_zav(i,:,:).*cos(ylat(i).*pi./180);
vNth_ed_d_wt(i,:,:) = vNth_ed_d_zav(i,:,:).*cos(ylat(i).*pi./180);

vNth_w_wt(i,:,:) = vNth_w_zav(i,:,:).*cos(ylat(i).*pi./180);
vNth_h_wt(i,:,:) = vNth_h_zav(i,:,:).*cos(ylat(i).*pi./180);
vNth_q_wt(i,:,:) = vNth_q_zav(i,:,:).*cos(ylat(i).*pi./180);
vNth_d_wt(i,:,:) = vNth_d_zav(i,:,:).*cos(ylat(i).*pi./180);
end

[moo,vNth_zon_w_conv_s] = gradient(vNth_zon_w_wt,pi./90);
[moo,vNth_zon_h_conv_s] = gradient(vNth_zon_h_wt,pi./90);
[moo,vNth_zon_q_conv_s] = gradient(vNth_zon_q_wt,pi./90);
[moo,vNth_zon_d_conv_s] = gradient(vNth_zon_d_wt,pi./90);

[moo,vNth_ed_w_conv_s] = gradient(vNth_ed_w_wt,pi./90);
[moo,vNth_ed_h_conv_s] = gradient(vNth_ed_h_wt,pi./90);
[moo,vNth_ed_q_conv_s] = gradient(vNth_ed_q_wt,pi./90);
[moo,vNth_ed_d_conv_s] = gradient(vNth_ed_d_wt,pi./90);

[moo,vNth_w_conv_s] = gradient(vNth_w_wt,pi./90);
[moo,vNth_h_conv_s] = gradient(vNth_h_wt,pi./90);
[moo,vNth_q_conv_s] = gradient(vNth_q_wt,pi./90);
[moo,vNth_d_conv_s] = gradient(vNth_d_wt,pi./90);

for i=1:90
vNth_w_conv(i,:) = -1.*vNth_w_conv_s(i,:)./cos(ylat(i).*pi./180)./a;
vNth_h_conv(i,:) = -1.*vNth_h_conv_s(i,:)./cos(ylat(i).*pi./180)./a;
vNth_q_conv(i,:) = -1.*vNth_q_conv_s(i,:)./cos(ylat(i).*pi./180)./a;
vNth_d_conv(i,:) = -1.*vNth_d_conv_s(i,:)./cos(ylat(i).*pi./180)./a;

vNth_ed_w_conv(i,:) = -1.*vNth_ed_w_conv_s(i,:)./cos(ylat(i).*pi./180)./a;
vNth_ed_h_conv(i,:) = -1.*vNth_ed_h_conv_s(i,:)./cos(ylat(i).*pi./180)./a;
vNth_ed_q_conv(i,:) = -1.*vNth_ed_q_conv_s(i,:)./cos(ylat(i).*pi./180)./a;
vNth_ed_d_conv(i,:) = -1.*vNth_ed_d_conv_s(i,:)./cos(ylat(i).*pi./180)./a;

vNth_zon_w_conv(i,:) = -1.*vNth_zon_w_conv_s(i,:)./cos(ylat(i).*pi./180)./a;
vNth_zon_h_conv(i,:) = -1.*vNth_zon_h_conv_s(i,:)./cos(ylat(i).*pi./180)./a;
vNth_zon_q_conv(i,:) = -1.*vNth_zon_q_conv_s(i,:)./cos(ylat(i).*pi./180)./a;
vNth_zon_d_conv(i,:) = -1.*vNth_zon_d_conv_s(i,:)./cos(ylat(i).*pi./180)./a;
end


vNth_w_vint = intfac.*sum(vNth_w_conv,2);
vNth_h_vint = intfac.*sum(vNth_h_conv,2);
vNth_q_vint = intfac.*sum(vNth_q_conv,2);
vNth_d_vint = intfac.*sum(vNth_d_conv,2);

vNth_ed_w_vint = intfac.*sum(vNth_ed_w_conv,2);
vNth_ed_h_vint = intfac.*sum(vNth_ed_h_conv,2);
vNth_ed_q_vint = intfac.*sum(vNth_ed_q_conv,2);
vNth_ed_d_vint = intfac.*sum(vNth_ed_d_conv,2);

vNth_zon_w_vint = intfac.*sum(vNth_zon_w_conv,2);
vNth_zon_h_vint = intfac.*sum(vNth_zon_h_conv,2);
vNth_zon_q_vint = intfac.*sum(vNth_zon_q_conv,2);
vNth_zon_d_vint = intfac.*sum(vNth_zon_d_conv,2);


figure
plot(ylat,htrt_w_zav,'k')
hold on
xlabel('Latitude')
ylabel('Vertically integrated heating rate, Wm^{-2}')
title('Vertically integrated heating rates: 1xe_{s0}')
plot(ylat,cndht_w_zav+cnvht_w_zav)
plot(ylat,radht_w_zav,'g')
plot(ylat,difht_w_zav,'r')
%plot(ylat,-vNth_w_vint,'c')
plot(ylat,-vNth_ed_w_vint,'c')
%plot(ylat,-vNth_zon_w_vint,'c--')
ylim([-150 550])
h=legend('Total','Latent','Radiative','Diffusive','Meridional eddy heat flux');
print('-dpng','vheat_wet.png')

figure
plot(ylat,htrt_h_zav,'k')
hold on
xlabel('Latitude')
ylabel('Vertically integrated heating rate, Wm^{-2}')
title('Vertically integrated heating rates: 0.5xe_{s0}')
plot(ylat,cndht_h_zav+cnvht_h_zav)
plot(ylat,radht_h_zav,'g')
plot(ylat,difht_h_zav,'r')
%plot(ylat,-vNth_h_vint,'c')
plot(ylat,-vNth_ed_h_vint,'c')
%plot(ylat,-vNth_zon_h_vint,'c--')
ylim([-150 550])
h=legend('Total','Latent','Radiative','Diffusive','Meridional eddy heat flux');
print('-dpng','vheat_half.png')

figure
plot(ylat,htrt_q_zav,'k')
hold on
xlabel('Latitude')
ylabel('Vertically integrated heating rate, Wm^{-2}')
title('Vertically integrated heating rates: 0.25xe_{s0}')
plot(ylat,cndht_q_zav+cnvht_q_zav)
plot(ylat,radht_q_zav,'g')
plot(ylat,difht_q_zav,'r')
%plot(ylat,-vNth_q_vint,'c')
plot(ylat,-vNth_ed_q_vint,'c')
%plot(ylat,-vNth_zon_q_vint,'c--')
ylim([-150 550])
h=legend('Total','Latent','Radiative','Diffusive','Meridional eddy heat flux');
print('-dpng','vheat_quarter.png')

figure
plot(ylat,htrt_d_zav,'k')
hold on
xlabel('Latitude')
ylabel('Vertically integrated heating rate, Wm^{-2}')
title('Vertically integrated heating rates: 0xe_{s0}')
plot(ylat,cndht_d_zav+cnvht_d_zav)
plot(ylat,radht_d_zav,'g')
plot(ylat,difht_d_zav,'r')
%plot(ylat,-vNth_d_vint,'c')
plot(ylat,-vNth_ed_d_vint,'c')
%plot(ylat,-vNth_zon_d_vint,'c--')
ylim([-150 550])
h=legend('Total','Latent','Radiative','Diffusive','Meridional eddy heat flux');
print('-dpng','vheat_dry.png')
