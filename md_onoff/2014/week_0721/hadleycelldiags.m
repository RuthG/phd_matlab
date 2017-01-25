%load, evaluate and plot Ro, Ht, held hou extent, and subcriticality from walker and schneider

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
for nit = 432000:86400:604800;
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i)=dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_h(:,:,:,i)=dyn(:,:,:,J);
[uE_h(:,:,:,i),vN_h(:,:,:,i)] = rotate_uv2uvEN(ucs_h(:,:,:,i),vcs_h(:,:,:,i),AngleCS,AngleSN,Grid);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_quarterwv/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_q(:,:,:,i)=dyn(:,:,:,J);
[uE_q(:,:,:,i),vN_q(:,:,:,i)] = rotate_uv2uvEN(ucs_q(:,:,:,i),vcs_q(:,:,:,i),AngleCS,AngleSN,Grid);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_d(:,:,:,i)=dyn(:,:,:,J);
[uE_d(:,:,:,i),vN_d(:,:,:,i)] = rotate_uv2uvEN(ucs_d(:,:,:,i),vcs_d(:,:,:,i),AngleCS,AngleSN,Grid);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv_tropheat3eq/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit+518400); 
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_th(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_th(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_th(:,:,:,i)=dyn(:,:,:,J);
[uE_th(:,:,:,i),vN_th(:,:,:,i)] = rotate_uv2uvEN(ucs_th(:,:,:,i),vcs_th(:,:,:,i),AngleCS,AngleSN,Grid);

end

uE_w_mean = mean(uE_w,4);
[uE_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_w_mean,ny,yc,ar,hc);
uE_h_mean = mean(uE_h,4);
[uE_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_h_mean,ny,yc,ar,hc);
uE_q_mean = mean(uE_q,4);
[uE_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_q_mean,ny,yc,ar,hc);
uE_d_mean = mean(uE_d,4);
[uE_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_d_mean,ny,yc,ar,hc);
uE_th_mean = mean(uE_th,4);
[uE_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_th_mean,ny,yc,ar,hc);

theta_w_mean = mean(theta_w,4);
[theta_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_w_mean,ny,yc,ar,hc);
theta_h_mean = mean(theta_h,4);
[theta_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_h_mean,ny,yc,ar,hc);
theta_q_mean = mean(theta_q,4);
[theta_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_q_mean,ny,yc,ar,hc);
theta_d_mean = mean(theta_d,4);
[theta_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_d_mean,ny,yc,ar,hc);
theta_th_mean = mean(theta_th,4);
[theta_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_th_mean,ny,yc,ar,hc);


a=6371.0e3;
omega = 2.*pi./60./60./24;
rd = 287;
cosphi = zeros(90,25);
sinphi = zeros(90,25);
for k=1:25
cosphi(:,k) = cos(ylat.*pi./180);
sinphi(:,k) = sin(ylat.*pi./180);
end

angmom_w = (omega.*a.*cosphi + uE_w_zav).*a.*cosphi;
angmom_h = (omega.*a.*cosphi + uE_h_zav).*a.*cosphi;
angmom_q = (omega.*a.*cosphi + uE_q_zav).*a.*cosphi;
angmom_d = (omega.*a.*cosphi + uE_d_zav).*a.*cosphi;
angmom_th = (omega.*a.*cosphi + uE_th_zav).*a.*cosphi;

f = 2.*omega.*sinphi;

bottom = a.*cosphi;
[b,top_w] = gradient(uE_w_zav.*cosphi,pi./90);
dudy_w = top_w./bottom;
[b,top_h] = gradient(uE_h_zav.*cosphi,pi./90);
dudy_h = top_h./bottom;
[b,top_q] = gradient(uE_q_zav.*cosphi,pi./90);
dudy_q = top_q./bottom;
[b,top_d] = gradient(uE_d_zav.*cosphi,pi./90);
dudy_d = top_d./bottom;
[b,top_th] = gradient(uE_th_zav.*cosphi,pi./90);
dudy_th = top_th./bottom;

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
t_w_zav(:,j)=theta_w_zav(:,j).*convthetatoT(j,1);
t_h_zav(:,j)=theta_h_zav(:,j).*convthetatoT(j,1);
t_q_zav(:,j)=theta_q_zav(:,j).*convthetatoT(j,1);
t_d_zav(:,j)=theta_d_zav(:,j).*convthetatoT(j,1);
t_th_zav(:,j)=theta_th_zav(:,j).*convthetatoT(j,1);
end

for k=1:25
rho_w(:,k) = rC(k)./(rd.*t_w_zav(:,k));
rho_h(:,k) = rC(k)./(rd.*t_h_zav(:,k));
rho_q(:,k) = rC(k)./(rd.*t_q_zav(:,k));
rho_d(:,k) = rC(k)./(rd.*t_d_zav(:,k));
rho_th(:,k) = rC(k)./(rd.*t_th_zav(:,k));
end

dTdz_w = rho_w.*g.*gradient(t_w_zav,-4000);
dTdz_h = rho_h.*g.*gradient(t_h_zav,-4000);
dTdz_q = rho_q.*g.*gradient(t_q_zav,-4000);
dTdz_d = rho_d.*g.*gradient(t_d_zav,-4000);
dTdz_th = rho_th.*g.*gradient(t_th_zav,-4000);

rossby_w = dudy_w./f;
rossby_h = dudy_h./f;
rossby_q = dudy_q./f;
rossby_d = dudy_d./f;
rossby_th = dudy_th./f;



