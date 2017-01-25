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


vNth_w_mean = mean(vNth_w,4);
vN_w_mean = mean(vN_w,4);
theta_w_mean = mean(theta_w,4);

vNth_h_mean = mean(vNth_h,4);
vN_h_mean = mean(vN_h,4);
theta_h_mean = mean(theta_h,4);

vNth_q_mean = mean(vNth_q,4);
vN_q_mean = mean(vN_q,4);
theta_q_mean = mean(theta_q,4);

vNth_d_mean = mean(vNth_d,4);
vN_d_mean = mean(vN_d,4);
theta_d_mean = mean(theta_d,4);

g=9.81;
cp=1004.64;
intfac = 4000./g;

[theta_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_w_mean,ny,yc,ar,hc);
[vN_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_w_mean,ny,yc,ar,hc);
[vNth_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNth_w_mean,ny,yc,ar,hc);
vNth_zon_w_zav = vN_w_zav.*theta_w_zav;
vNth_ed_w_zav = vNth_w_zav - vNth_zon_w_zav;

[theta_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_h_mean,ny,yc,ar,hc);
[vN_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_h_mean,ny,yc,ar,hc);
[vNth_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNth_h_mean,ny,yc,ar,hc);
vNth_zon_h_zav = vN_h_zav.*theta_h_zav;
vNth_ed_h_zav = vNth_h_zav - vNth_zon_h_zav;

[theta_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_q_mean,ny,yc,ar,hc);
[vN_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_q_mean,ny,yc,ar,hc);
[vNth_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNth_q_mean,ny,yc,ar,hc);
vNth_zon_q_zav = vN_q_zav.*theta_q_zav;
vNth_ed_q_zav = vNth_q_zav - vNth_zon_q_zav;

[theta_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_d_mean,ny,yc,ar,hc);
[vN_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_d_mean,ny,yc,ar,hc);
[vNth_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNth_d_mean,ny,yc,ar,hc);
vNth_zon_d_zav = vN_d_zav.*theta_d_zav;
vNth_ed_d_zav = vNth_d_zav - vNth_zon_d_zav;

vNth_ed_w_vint = intfac.*sum(vNth_ed_w_zav,2);
vNth_ed_h_vint = intfac.*sum(vNth_ed_h_zav,2);
vNth_ed_q_vint = intfac.*sum(vNth_ed_q_zav,2);
vNth_ed_d_vint = intfac.*sum(vNth_ed_d_zav,2);

figure
plot(ylat,vNth_ed_w_vint,'k')
hold on
plot(ylat,vNth_ed_h_vint,'b')
plot(ylat,vNth_ed_q_vint,'r')
plot(ylat,vNth_ed_d_vint,'g')
legend('1x','0.5x','0.25x','0x')
print('-dpng','vt_vint.png')

