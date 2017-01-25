%load in vT data and plot up v'T' (instead of v' theta')

%copy heat_budg.m, but just do vint plot for all wv runs

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


convthetatoT=(rC/101325.0).^(2./7.);
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

for j=1:size(rC)
J=find(strcmp(fldList,'VVELTH  '));
vcst_w(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'UVELTH  '));
ucst_w(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'THETA   '));
t_w(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
end

J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i)=dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);
[uEt_w(:,:,:,i),vNt_w(:,:,:,i)] = rotate_uv2uvEN(ucst_w(:,:,:,i),vcst_w(:,:,:,i),AngleCS,AngleSN,Grid);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';


convthetatoT=(rC/101325.0).^(2./7.);
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

for j=1:size(rC)
J=find(strcmp(fldList,'VVELTH  '));
vcst_h(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'UVELTH  '));
ucst_h(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'THETA   '));
t_h(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
end

J=find(strcmp(fldList,'UVEL    '));
ucs_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_h(:,:,:,i)=dyn(:,:,:,J);
[uE_h(:,:,:,i),vN_h(:,:,:,i)] = rotate_uv2uvEN(ucs_h(:,:,:,i),vcs_h(:,:,:,i),AngleCS,AngleSN,Grid);
[uEt_h(:,:,:,i),vNt_h(:,:,:,i)] = rotate_uv2uvEN(ucst_h(:,:,:,i),vcst_h(:,:,:,i),AngleCS,AngleSN,Grid);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_quarterwv/';


convthetatoT=(rC/101325.0).^(2./7.);
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

for j=1:size(rC)
J=find(strcmp(fldList,'VVELTH  '));
vcst_q(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'UVELTH  '));
ucst_q(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'THETA   '));
t_q(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
end

J=find(strcmp(fldList,'UVEL    '));
ucs_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_q(:,:,:,i)=dyn(:,:,:,J);
[uE_q(:,:,:,i),vN_q(:,:,:,i)] = rotate_uv2uvEN(ucs_q(:,:,:,i),vcs_q(:,:,:,i),AngleCS,AngleSN,Grid);
[uEt_q(:,:,:,i),vNt_q(:,:,:,i)] = rotate_uv2uvEN(ucst_q(:,:,:,i),vcst_q(:,:,:,i),AngleCS,AngleSN,Grid);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';


convthetatoT=(rC/101325.0).^(2./7.);
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

for j=1:size(rC)
J=find(strcmp(fldList,'VVELTH  '));
vcst_d(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'UVELTH  '));
ucst_d(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'THETA   '));
t_d(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
end

J=find(strcmp(fldList,'UVEL    '));
ucs_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_d(:,:,:,i)=dyn(:,:,:,J);
[uE_d(:,:,:,i),vN_d(:,:,:,i)] = rotate_uv2uvEN(ucs_d(:,:,:,i),vcs_d(:,:,:,i),AngleCS,AngleSN,Grid);
[uEt_d(:,:,:,i),vNt_d(:,:,:,i)] = rotate_uv2uvEN(ucst_d(:,:,:,i),vcst_d(:,:,:,i),AngleCS,AngleSN,Grid);

end


vN_w_mean = mean(vN_w,4);
t_w_mean = mean(t_w,4);
vNt_w_mean = mean(vNt_w,4);

vN_h_mean = mean(vN_h,4);
t_h_mean = mean(t_h,4);
vNt_h_mean = mean(vNt_h,4);

vN_q_mean = mean(vN_q,4);
t_q_mean = mean(t_q,4);
vNt_q_mean = mean(vNt_q,4);

vN_d_mean = mean(vN_d,4);
t_d_mean = mean(t_d,4);
vNt_d_mean = mean(vNt_d,4);


[vN_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_w_mean,ny,yc,ar,hc);
[t_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(t_w_mean,ny,yc,ar,hc);
[vNt_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_w_mean,ny,yc,ar,hc);

vNt_w_ed = vNt_w_zav - vN_w_zav.*t_w_zav;

[vN_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_h_mean,ny,yc,ar,hc);
[t_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(t_h_mean,ny,yc,ar,hc);
[vNt_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_h_mean,ny,yc,ar,hc);

vNt_h_ed = vNt_h_zav - vN_h_zav.*t_h_zav;

[vN_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_q_mean,ny,yc,ar,hc);
[t_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(t_q_mean,ny,yc,ar,hc);
[vNt_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_q_mean,ny,yc,ar,hc);

vNt_q_ed = vNt_q_zav - vN_q_zav.*t_q_zav;

[vN_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_d_mean,ny,yc,ar,hc);
[t_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(t_d_mean,ny,yc,ar,hc);
[vNt_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_d_mean,ny,yc,ar,hc);

vNt_d_ed = vNt_d_zav - vN_d_zav.*t_d_zav;

v=-20:2:20;
figure
[C,h] = contourf(ylat,rC./100,vNt_w_ed',v);
colorbar
colormap(b2r(-20,20));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
print('-dpng','vt_w.png')

figure
[C,h] = contourf(ylat,rC./100,vNt_h_ed',v);
colorbar
colormap(b2r(-20,20));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
print('-dpng','vt_h.png')

figure
[C,h] = contourf(ylat,rC./100,vNt_q_ed',v);
colorbar
colormap(b2r(-20,20));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
print('-dpng','vt_q.png')

figure
[C,h] = contourf(ylat,rC./100,vNt_d_ed',v);
colorbar
colormap(b2r(-20,20));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
print('-dpng','vt_d.png')
