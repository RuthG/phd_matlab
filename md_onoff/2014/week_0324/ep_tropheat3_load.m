%load in ensemble results


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_tropheat3/';

%slashes = findstr(rDir,'/');
%point1 = slashes(max(size(slashes))-2);
%dir_label = rDir(point1+1:max(size(rDir))-1);
%dir_label = strrep(dir_label,'/','_');

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

i=0;
for nit = 691440:240:705600; 
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'WVEL    '));
w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i) = dyn(:,:,:,J);
convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp(:,:,j,i)=theta(:,:,j,i).*convthetatoT(j,1);
end
J=find(strcmp(fldList,'UV_VEL_C'));
uv(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vt_av(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av(:,:,:,i) = dyn(:,:,:,J);
[uEt_av(:,:,:,i),vNt_av(:,:,:,i)] = rotate_uv2uvEN(ut_av(:,:,:,i),vt_av(:,:,:,i),AngleCS,AngleSN,Grid);

%take zonal mean eddy fluxes of momentum and heat
[uE_zav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(uE(:,:,:,i),ny,yc,ar,hc);
[vN_zav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(vN(:,:,:,i),ny,yc,ar,hc);
[theta_zav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(theta(:,:,:,i),ny,yc,ar,hc);
[w_zav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(w(:,:,:,i),ny,yc,ar,hc);
[uv_zav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(uv(:,:,:,i),ny,yc,ar,hc);
[vt_zav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av(:,:,:,i),ny,yc,ar,hc);
[temp_zav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(temp(:,:,:,i),ny,yc,ar,hc);

end

uv_ed_zav = uv_zav - uE_zav.*vN_zav;
vt_ed_zav = vt_zav - vN_zav.*theta_zav;
dthetadp = gradient(theta_zav,-4000.);

ylat_radians = ylat.*pi./180;

a = 6371.0e3;		%radius of the earth
costhi = cos(ylat_radians);
omega = 2*pi/(24*60*60);
f = 2*omega*sin(ylat_radians);
g=9.81;

prefactor = costhi.*2.*pi.*a.^2./g;

%Calculate fluxes and scaled fluxes (Edmon 1980)
for i=1:90
Fphi(i,:,:) = -1.*a.*costhi(i).*uv_ed_zav(i,:,:);
Fp(i,:,:)   = a.*f(i).*costhi(i).*vt_ed_zav(i,:,:)./dthetadp(i,:,:);
Fphi_scaled(i,:,:) = Fphi(i,:,:).*prefactor(i)./a;
Fp_scaled(i,:,:) = Fp(i,:,:).*prefactor(i); 
end


for i=1:6
theta_tav(:,:,i) = mean(theta_zav(:,:, 10*i-9:10*i),3);
temp_tav(:,:,i) = mean(temp_zav(:,:, 10*i-9:10*i),3);
uE_tav(:,:,i) = mean(uE_zav(:,:,10*i-9:10*i),3);
vN_tav(:,:,i) = mean(vN_zav(:,:,10*i-9:10*i),3);
w_tav(:,:,i) = mean(w_zav(:,:,10*i-9:10*i),3);
Fphi_scaled_tav(:,:,i) = mean(Fphi_scaled(:,:, 10*i-9:10*i),3);
Fp_scaled_tav(:,:,i) = mean(Fp_scaled(:,:,10*i-9:10*i),3);
end


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_accidentalcontrol/';
i=0;
for nit = 691440:240:705600; 
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_c(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_c(:,:,:,i) = dyn(:,:,:,J);
[uE_c(:,:,:,i),vN_c(:,:,:,i)] = rotate_uv2uvEN(ucs_c(:,:,:,i),vcs_c(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'WVEL    '));
w_c(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_c(:,:,:,i) = dyn(:,:,:,J);
convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_c(:,:,j,i)=theta_c(:,:,j,i).*convthetatoT(j,1);
end
J=find(strcmp(fldList,'UV_VEL_C'));
uv_c(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vt_av_c(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_c(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_c(:,:,:,i),vNt_av_c(:,:,:,i)] = rotate_uv2uvEN(ut_av_c(:,:,:,i),vt_av_c(:,:,:,i),AngleCS,AngleSN,Grid);

%take zonal mean eddy fluxes of momentum and heat
[uE_zav_c(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(uE_c(:,:,:,i),ny,yc,ar,hc);
[vN_zav_c(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(vN_c(:,:,:,i),ny,yc,ar,hc);
[theta_zav_c(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(theta_c(:,:,:,i),ny,yc,ar,hc);
[w_zav_c(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(w_c(:,:,:,i),ny,yc,ar,hc);
[uv_zav_c(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(uv_c(:,:,:,i),ny,yc,ar,hc);
[vt_zav_c(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_c(:,:,:,i),ny,yc,ar,hc);
[temp_zav_c(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(temp_c(:,:,:,i),ny,yc,ar,hc);

end

uv_ed_zav_c = uv_zav_c - uE_zav_c.*vN_zav_c;
vt_ed_zav_c = vt_zav_c - vN_zav_c.*theta_zav_c;
dthetadp_c = gradient(theta_zav_c,-4000.);

ylat_radians = ylat.*pi./180;

a = 6371.0e3;		%radius of the earth
costhi = cos(ylat_radians);
omega = 2*pi/(24*60*60);
f = 2*omega*sin(ylat_radians);
g=9.81;

prefactor = costhi.*2.*pi.*a.^2./g;

%Calculate fluxes and scaled fluxes (Edmon 1980)
for i=1:90
Fphi_c(i,:,:) = -1.*a.*costhi(i).*uv_ed_zav_c(i,:,:);
Fp_c(i,:,:)   = a.*f(i).*costhi(i).*vt_ed_zav_c(i,:,:)./dthetadp_c(i,:,:);
Fphi_scaled_c(i,:,:) = Fphi_c(i,:,:).*prefactor(i)./a;
Fp_scaled_c(i,:,:) = Fp_c(i,:,:).*prefactor(i); 
end

for i=1:6
theta_tav_c(:,:,i) = mean(theta_zav_c(:,:, 10*i-9:10*i),3);
temp_tav_c(:,:,i) = mean(temp_zav_c(:,:, 10*i-9:10*i),3);
uE_tav_c(:,:,i) = mean(uE_zav_c(:,:,10*i-9:10*i),3);
vN_tav_c(:,:,i) = mean(vN_zav_c(:,:,10*i-9:10*i),3);
w_tav_c(:,:,i) = mean(w_zav_c(:,:,10*i-9:10*i),3);
Fphi_scaled_tav_c(:,:,i) = mean(Fphi_scaled_c(:,:, 10*i-9:10*i),3);
Fp_scaled_tav_c(:,:,i) = mean(Fp_scaled_c(:,:,10*i-9:10*i),3);
end

theta_diff = theta_tav - theta_tav_c;
temp_diff = temp_tav - temp_tav_c;
uE_diff = uE_tav - uE_tav_c;
vN_diff = vN_tav - vN_tav_c;
w_diff = w_tav - w_tav_c;
Fphi_scaled_diff = Fphi_scaled_tav - Fphi_scaled_tav_c;
Fp_scaled_diff = Fp_scaled_tav - Fp_scaled_tav_c;

save('ep_fluxdiffs_tropheat3.mat','Fphi_scaled_diff','Fp_scaled_diff')
