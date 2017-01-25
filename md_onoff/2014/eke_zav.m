%evaluate vertically integrated (horiz) EKE for dry and wet equms

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

a=system('find eke_wet_data.mat');

if a > 0

i=0;
for nit = 259200:86400:604800;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i) = dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);


J=find(strcmp(fldList,'UVELSQ  '));
uucs_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSQ  '));
vvcs_w(:,:,:,i) = dyn(:,:,:,J);


end

%Total horiz KE should be invariant on the cube sphere (resultant horiz vel shouldn't change)
keh_w = uucs_w + vvcs_w;

%Take zavs of KE, vN, uE
[keh_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(keh_w,ny,yc,ar,hc);
[vN_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_w,ny,yc,ar,hc);
[uE_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_w,ny,yc,ar,hc);

%<u^2> = <u>^2 + <u^2'>
%We have <u^2 + v^2> = <u>^2 + <v>^2 + <u^2'> + <v^2'> 
%Square zonal averages and sum to get zonal mean KE component
uuvv_w = vN_w_zav.^2 + uE_w_zav.^2;

% keh - uuvv = <u^2'> + <v^2'> 
heke_w_zav = keh_w_zav - uuvv_w;

heke_w_zav_vertmean = mean(mean(heke_w_zav,3),2);

save('eke_wet_data.mat')

else

load('eke_wet_data.mat')

end

%%%%%%%%%%%%%%%%%%%%%%%%% Repeat for dry case %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';

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

a=system('find eke_dry_data.mat');

if a > 0

i=0;
for nit = 259200:86400:604800;
i=i+1

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

%Total horiz KE should be invariant on the cube sphere (resultant horiz vel shouldn't change)
keh_d = uucs_d + vvcs_d;

%Take zavs of KE, vN, uE
[keh_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(keh_d,ny,yc,ar,hc);
[vN_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_d,ny,yc,ar,hc);
[uE_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_d,ny,yc,ar,hc);

%<u^2> = <u>^2 + <u^2'>
%We have <u^2 + v^2> = <u>^2 + <v>^2 + <u^2'> + <v^2'> 
%Square zonal averages and sum to get zonal mean KE component
uuvv_d = vN_d_zav.^2 + uE_d_zav.^2;

% keh - uuvv = <u^2'> + <v^2'> 
heke_d_zav = keh_d_zav - uuvv_d;

heke_d_zav_vertmean = mean(mean(heke_d_zav,3),2);

save('eke_dry_data.mat')

else

load('eke_dry_data.mat')

end

%%%%%%%%%%%%%%%%%%%%%%%%% Repeat for half wv case %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Load data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=system('find eke_half_data.mat');

if a > 0

i=0;
for nit = 259200:86400:604800;
i=i+1

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


end

%Total horiz KE should be invariant on the cube sphere (resultant horiz vel shouldn't change)
keh_h = uucs_h + vvcs_h;

%Take zavs of KE, vN, uE
[keh_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(keh_h,ny,yc,ar,hc);
[vN_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_h,ny,yc,ar,hc);
[uE_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_h,ny,yc,ar,hc);

%<u^2> = <u>^2 + <u^2'>
%We have <u^2 + v^2> = <u>^2 + <v>^2 + <u^2'> + <v^2'> 
%Square zonal averages and sum to get zonal mean KE component
uuvv_h = vN_h_zav.^2 + uE_h_zav.^2;

% keh - uuvv = <u^2'> + <v^2'> 
heke_h_zav = keh_h_zav - uuvv_h;

heke_h_zav_vertmean = mean(mean(heke_h_zav,3),2);

save('eke_half_data.mat')

else

load('eke_half_data.mat')

end

plot(ylat,heke_w_zav_vertmean)
hold on
plot(ylat,heke_d_zav_vertmean,'r')
plot(ylat,heke_h_zav_vertmean,'g')
print('-dpng','eke.png')


