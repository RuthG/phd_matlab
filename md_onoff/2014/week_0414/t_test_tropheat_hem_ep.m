%try coding up t_test...

%start with u field, tropheat hw spinup run

%need: mean of each
%variance calculated using mean of each yr diff from mean
%correlation of each year (does this make sense here?)


%Read in iteration number, directory, MITgcm output and grid details

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_tropheat_hw/';

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


%read fields
i=0;
for nit = 691440:240:693600; %703440:240:705600 ;% 
i=i+1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Full wv run%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_tropheat_hw/';


[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i) = dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_w(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_w(:,:,:,i),vNt_av_w(:,:,:,i)] = rotate_uv2uvEN(ut_av_w(:,:,:,i),vt_av_w(:,:,:,i),AngleCS,AngleSN,Grid);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Half wv run%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_tropheat_hw_control/';


[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_h(:,:,:,i) = dyn(:,:,:,J);
[uE_h(:,:,:,i),vN_h(:,:,:,i)] = rotate_uv2uvEN(ucs_h(:,:,:,i),vcs_h(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_h(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_h(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_h(:,:,:,i),vNt_av_h(:,:,:,i)] = rotate_uv2uvEN(ut_av_h(:,:,:,i),vt_av_h(:,:,:,i),AngleCS,AngleSN,Grid);


end

[uE_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_w,ny,yc,ar,hc);
[vN_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_w,ny,yc,ar,hc);
[theta_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_w,ny,yc,ar,hc);
[uv_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_w,ny,yc,ar,hc);
[vt_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_w,ny,yc,ar,hc);
vt_ed_w_zav = vt_w_zav - vN_w_zav.*theta_w_zav;
uv_ed_w_zav = uv_w_zav - uE_w_zav.*vN_w_zav;

[uE_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_h,ny,yc,ar,hc);
[vN_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_h,ny,yc,ar,hc);
[theta_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_h,ny,yc,ar,hc);
[uv_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_h,ny,yc,ar,hc);
[vt_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av_h,ny,yc,ar,hc);
vt_ed_h_zav = vt_h_zav - vN_h_zav.*theta_h_zav;
uv_ed_h_zav = uv_h_zav - uE_h_zav.*vN_h_zav;


%%%%%%%%%%%%%%%%%%%%%%% EP fluxes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% tropheat %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dthetadp_w = gradient(theta_w_zav,-4000.);
dthetadp_h = gradient(theta_h_zav,-4000.);

ylat_radians = ylat.*pi./180;

costhi = cos(ylat_radians);
omega = 2*pi/(24*60*60);
f = 2*omega*sin(ylat_radians);
g=9.81;
rad=6371.0e3;				%radius of earth

prefactor = costhi.*2.*pi.*rad.^2./g;

%Calculate fluxes and scaled fluxes (Edmon 1980)
for i=1:90
Fphi_w(i,:,:) = -1.*rad.*costhi(i).*uv_ed_w_zav(i,:,:);
Fp_w(i,:,:)   = rad.*f(i).*costhi(i).*vt_ed_w_zav(i,:,:)./dthetadp_w(i,:,:);
Fphi_scaled_w(i,:,:) = Fphi_w(i,:,:).*prefactor(i)./rad;
Fp_scaled_w(i,:,:) = Fp_w(i,:,:).*prefactor(i);

Fphi_h(i,:,:) = -1.*rad.*costhi(i).*uv_ed_h_zav(i,:,:);
Fp_h(i,:,:)   = rad.*f(i).*costhi(i).*vt_ed_h_zav(i,:,:)./dthetadp_h(i,:,:);
Fphi_scaled_h(i,:,:) = Fphi_h(i,:,:).*prefactor(i)./rad;
Fp_scaled_h(i,:,:) = Fp_h(i,:,:).*prefactor(i);
end




Fphi_scaled_w_tzav = mean(Fphi_scaled_w,3);
Fp_scaled_w_tzav = mean(Fp_scaled_w,3);
Fphi_scaled_h_tzav = mean(Fphi_scaled_h,3);
Fp_scaled_h_tzav = mean(Fp_scaled_h,3);

for i=1:45
Fphi_scaled_w_thzav(46-i,:) = (-1.*Fphi_scaled_w_tzav(i,:) + Fphi_scaled_w_tzav(91-i,:))./2;
Fp_scaled_w_thzav(46-i,:) = (Fp_scaled_w_tzav(i,:) + Fp_scaled_w_tzav(91-i,:))./2;
Fphi_scaled_h_thzav(46-i,:) = (-1.*Fphi_scaled_h_tzav(i,:) + Fphi_scaled_h_tzav(91-i,:))./2;
Fp_scaled_h_thzav(46-i,:) = (Fp_scaled_h_tzav(i,:) + Fp_scaled_h_tzav(91-i,:))./2;
end

Fphi_scaled_w_hzav(:,:,1) = Fphi_scaled_w_tzav(46:90,:);
Fphi_scaled_w_hzav(:,:,2) = -1*flipdim(Fphi_scaled_w_tzav(1:45,:),1);
Fp_scaled_w_hzav(:,:,1) = Fp_scaled_w_tzav(46:90,:);
Fp_scaled_w_hzav(:,:,2) = flipdim(Fp_scaled_w_tzav(1:45,:),1);

Fphi_scaled_h_hzav(:,:,1) = Fphi_scaled_h_tzav(46:90,:);
Fphi_scaled_h_hzav(:,:,2) = -1*flipdim(Fphi_scaled_h_tzav(1:45,:),1);
Fp_scaled_h_hzav(:,:,1) = Fp_scaled_h_tzav(46:90,:);
Fp_scaled_h_hzav(:,:,2) = flipdim(Fp_scaled_h_tzav(1:45,:),1);

N_pop = 2;

%calculate variance of each population for bottom part of lag covar
for i=1:N_pop
vardiff_phi_w (:,:,i) = (Fphi_scaled_w_hzav(:,:,i) - Fphi_scaled_w_thzav).^2;
vardiff_phi_h (:,:,i) = (Fphi_scaled_h_hzav(:,:,i) - Fphi_scaled_h_thzav).^2;
vardiff_p_w (:,:,i) = (Fp_scaled_w_hzav(:,:,i) - Fp_scaled_w_thzav).^2;
vardiff_p_h (:,:,i) = (Fp_scaled_h_hzav(:,:,i) - Fp_scaled_h_thzav).^2;
end


T0_w = 1 ;
T0_h = 1 ;


%%%%%%%%%%%%%%%%%%%
n_w = N_pop./T0_w;
n_h = N_pop./T0_h;

var_weight_w = N_pop - T0_w;
var_weight_h = N_pop - T0_h;

var_phi_w = sum(vardiff_phi_w,3)./var_weight_w;
var_phi_h = sum(vardiff_phi_h,3)./var_weight_h;
var_p_w = sum(vardiff_p_w,3)./var_weight_w;
var_p_h = sum(vardiff_p_h,3)./var_weight_h;

%%%%% initial t calculation...
T_phi = (Fphi_scaled_w_thzav - Fphi_scaled_h_thzav)./sqrt(var_phi_w./n_w + var_phi_h./n_h);
T_p = (Fp_scaled_w_thzav - Fp_scaled_h_thzav)./sqrt(var_p_w./n_w + var_p_h./n_h);

DF_phi = (var_phi_w./n_w + var_phi_h./n_h).^2./( (var_phi_w./n_w).^2./(n_w-1) + (var_phi_h./n_h).^2./(n_h-1) ) ;
DF_p = (var_p_w./n_w + var_p_h./n_h).^2./( (var_p_w./n_w).^2./(n_w-1) + (var_p_h./n_h).^2./(n_h-1) ) ;

%%% significance (one sided statistics? whatever that means...)

p_phi = tcdf(abs(T_phi),DF_phi);
p_p = tcdf(abs(T_p),DF_p);
