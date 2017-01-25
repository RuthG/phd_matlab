%calculate the EKE integrated over the storm track as defined in O'Gorman and Schneider 2008

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Load data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=system('find eke_data.mat');

if a > 0

i=0;
for nit = 259200:86400:604800;
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_f(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_f(:,:,:,i) = dyn(:,:,:,J);
[uE_f(:,:,:,i),vN_f(:,:,:,i)] = rotate_uv2uvEN(ucs_f(:,:,:,i),vcs_f(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'UVELSQ  '));
uucs_f(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSQ  '));
vvcs_f(:,:,:,i) = dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_h(:,:,:,i) = dyn(:,:,:,J);
[uE_h(:,:,:,i),vN_h(:,:,:,i)] = rotate_uv2uvEN(ucs_h(:,:,:,i),vcs_h(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'UVELSQ  '));
uucs_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSQ  '));
vvcs_h(:,:,:,i) = dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_d(:,:,:,i) = dyn(:,:,:,J);
[uE_d(:,:,:,i),vN_d(:,:,:,i)] = rotate_uv2uvEN(ucs_d(:,:,:,i),vcs_d(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'UVELSQ  '));
uucs_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSQ  '));
vvcs_d(:,:,:,i) = dyn(:,:,:,J);

end

save('eke_data.mat')

else

load('eke_data.mat')

end

%calculate local |v^2|
ke_d = uucs_d + vvcs_d;
ke_h = uucs_h + vvcs_h;
ke_f = uucs_f + vvcs_f;

%calculate zonal average of u, v, and |v^2|
[uE_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_d,ny,yc,ar,hc);
[vN_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_d,ny,yc,ar,hc);
[uE_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_h,ny,yc,ar,hc);
[vN_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_h,ny,yc,ar,hc);
[uE_f_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_f,ny,yc,ar,hc);
[vN_f_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_f,ny,yc,ar,hc);

[ke_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(ke_d,ny,yc,ar,hc);
[ke_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(ke_h,ny,yc,ar,hc);
[ke_f_zav,mskzon,ylat,areazon]=calcZonalAvgCube(ke_f,ny,yc,ar,hc);

%calculate <v'^2> = <|v^2|> - <|v|>^2 (<> zon av)

eke_d_zav = ke_d_zav - uE_d_zav.^2 - vN_d_zav.^2;
eke_h_zav = ke_h_zav - uE_h_zav.^2 - vN_h_zav.^2;
eke_f_zav = ke_f_zav - uE_f_zav.^2 - vN_f_zav.^2;


%take time mean
eke_d_tzav = mean(eke_d_zav,3);
eke_h_tzav = mean(eke_h_zav,3);
eke_f_tzav = mean(eke_f_zav,3);

%To find in units of J/m2 calculate integral over dp/g

eke_d_jm2 = 0.5.*4000/9.81 .* sum(eke_d_tzav,2);
eke_h_jm2 = 0.5.*4000/9.81 .* sum(eke_h_tzav,2);
eke_f_jm2 = 0.5.*4000/9.81 .* sum(eke_f_tzav,2);

%%%%Following O'Gorman 2008 we define baroclinic zones as within 15 degrees of max of v'T', and as extending to the tropopause. Therefore we need to get these values!

load('bc_box.mat')

if(mod(barzon_lats_d(1),2)==0)
min_no_d = find(abs(ylat) == barzon_lats_d(1)-1);
max_no_d = find(abs(ylat) == barzon_lats_d(2)+1);
else
min_no_d = find(abs(ylat) == barzon_lats_d(1)-1);
max_no_d = find(abs(ylat) == barzon_lats_d(2)+1);
end

if(mod(barzon_lats_d(1),2)==0)
min_no_h = find(abs(ylat) == barzon_lats_h(1)-1);
max_no_h = find(abs(ylat) == barzon_lats_h(2)+1);
else
min_no_h = find(abs(ylat) == barzon_lats_h(1)-1);
max_no_h = find(abs(ylat) == barzon_lats_h(2)+1);
end

if(mod(barzon_lats_d(1),2)==0)
min_no_f = find(abs(ylat) == barzon_lats_f(1)-1);
max_no_f = find(abs(ylat) == barzon_lats_f(2)+1);
else
min_no_f = find(abs(ylat) == barzon_lats_f(1)-1);
max_no_f = find(abs(ylat) == barzon_lats_f(2)+1);
end

eke_diag_d = (mean(eke_d_jm2(max_no_d(1):min_no_d(1))) + mean(eke_d_jm2(min_no_d(2):max_no_d(2))))./2;
eke_diag_h = (mean(eke_h_jm2(max_no_h(1):min_no_h(1))) + mean(eke_h_jm2(min_no_h(2):max_no_h(2))))./2;
eke_diag_f = (mean(eke_f_jm2(max_no_f(1):min_no_f(1))) + mean(eke_f_jm2(min_no_f(2):max_no_f(2))))./2;

save('eke_data.mat')

