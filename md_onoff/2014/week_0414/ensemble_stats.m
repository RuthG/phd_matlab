%run t test now we have 14 data points for spin up, how much better is this, how many more do we need...?

%try coding up t_test...

%start with u field, tropheat hw spinup run

%need: mean of each
%variance calculated using mean of each yr diff from mean
%correlation of each year (does this make sense here?)


%Read in iteration number, directory, MITgcm output and grid details

rDir='/disk1/MITgcm/verification/atm_gray_ruth/ensemble_control/';

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
for j=0:9
i=0;
for nit = 605040+j*14400:240:619200+j*14400; 
i=i+1
nitstart = 604800+j*14400;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Tropheat run%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rDir=['/disk1/MITgcm/verification/atm_gray_ruth/ensemble_wet/run_start_' num2str(nitstart) '/'];


[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i,j+1) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i,j+1) = dyn(:,:,:,J);
[uE_w(:,:,:,i,j+1),vN_w(:,:,:,i,j+1)] = rotate_uv2uvEN(ucs_w(:,:,:,i,j+1),vcs_w(:,:,:,i,j+1),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i,j+1) = dyn(:,:,:,J);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_w(:,:,:,i,j+1) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_w(:,:,:,i,j+1) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_w(:,:,:,i,j+1) = dyn(:,:,:,J);
[uEt_av_w(:,:,:,i,j+1),vNt_av_w(:,:,:,i,j+1)] = rotate_uv2uvEN(ut_av_w(:,:,:,i,j+1),vt_av_w(:,:,:,i,j+1),AngleCS,AngleSN,Grid);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Half wv run%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rDir='/disk1/MITgcm/verification/atm_gray_ruth/ensemble_control/';


[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_h(:,:,:,i,j+1) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_h(:,:,:,i,j+1) = dyn(:,:,:,J);
[uE_h(:,:,:,i,j+1),vN_h(:,:,:,i,j+1)] = rotate_uv2uvEN(ucs_h(:,:,:,i,j+1),vcs_h(:,:,:,i,j+1),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i,j+1) = dyn(:,:,:,J);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_h(:,:,:,i,j+1) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_h(:,:,:,i,j+1) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_h(:,:,:,i,j+1) = dyn(:,:,:,J);
[uEt_av_h(:,:,:,i,j+1),vNt_av_h(:,:,:,i,j+1)] = rotate_uv2uvEN(ut_av_h(:,:,:,i,j+1),vt_av_h(:,:,:,i,j+1),AngleCS,AngleSN,Grid);


end
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

for i=1:6

uv_ed_w_tzav(:,:,i,:) = mean(uv_ed_w_zav(:,:,10*i-9:10*i,:),3);
vt_ed_w_tzav(:,:,i,:) = mean(vt_ed_w_zav(:,:,10*i-9:10*i,:),3);
theta_w_tzav(:,:,i,:) = mean(theta_w_zav(:,:,10*i-9:10*i,:),3);

uv_ed_h_tzav(:,:,i,:) = mean(uv_ed_h_zav(:,:,10*i-9:10*i,:),3);
vt_ed_h_tzav(:,:,i,:) = mean(vt_ed_h_zav(:,:,10*i-9:10*i,:),3);
theta_h_tzav(:,:,i,:) = mean(theta_h_zav(:,:,10*i-9:10*i,:),3);

end

save('ep_ensemble.mat','uv_ed_w_tzav','vt_ed_w_tzav','theta_w_tzav','uv_ed_h_tzav','vt_ed_h_tzav','theta_h_tzav','ylat','rC')
clear
load('ep_ensemble.mat')


%%%%%%%%%%%%%%%%%%%%%%% EP fluxes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dthetadp_w = gradient(theta_w_tzav,-4000.);
dthetadp_h = gradient(theta_h_tzav,-4000.);

ylat_radians = ylat.*pi./180;

costhi = cos(ylat_radians);
omega = 2*pi/(24*60*60);
f = 2*omega*sin(ylat_radians);
g=9.81;
rad=6371.0e3;				%radius of earth

prefactor = costhi.*2.*pi.*rad.^2./g;

%Calculate fluxes and scaled fluxes (Edmon 1980)
for i=1:90
Fphi_w(i,:,:,:) = -1.*rad.*costhi(i).*uv_ed_w_tzav(i,:,:,:);
Fp_w(i,:,:,:)   = rad.*f(i).*costhi(i).*vt_ed_w_tzav(i,:,:,:)./dthetadp_w(i,:,:,:);
Fphi_scaled_w(i,:,:,:) = Fphi_w(i,:,:,:).*prefactor(i)./rad;
Fp_scaled_w(i,:,:,:) = Fp_w(i,:,:,:).*prefactor(i);

Fphi_h(i,:,:,:) = -1.*rad.*costhi(i).*uv_ed_h_tzav(i,:,:,:);
Fp_h(i,:,:,:)   = rad.*f(i).*costhi(i).*vt_ed_h_tzav(i,:,:,:)./dthetadp_h(i,:,:,:);
Fphi_scaled_h(i,:,:,:) = Fphi_h(i,:,:,:).*prefactor(i)./rad;
Fp_scaled_h(i,:,:,:) = Fp_h(i,:,:,:).*prefactor(i);
end

for i=1:45
Fphi_scaled_w_thzav(46-i,:,:,:) = (-1.*Fphi_scaled_w(i,:,:,:) + Fphi_scaled_w(91-i,:,:,:))./2;
Fp_scaled_w_thzav(46-i,:,:,:) = (Fp_scaled_w(i,:,:,:) + Fp_scaled_w(91-i,:,:,:))./2;
Fphi_scaled_h_thzav(46-i,:,:,:) = (-1.*Fphi_scaled_h(i,:,:,:) + Fphi_scaled_h(91-i,:,:,:))./2;
Fp_scaled_h_thzav(46-i,:,:,:) = (Fp_scaled_h(i,:,:,:) + Fp_scaled_h(91-i,:,:,:))./2;
end

Fphi_scaled_w_ensav = mean(Fphi_scaled_w_thzav,4);
Fp_scaled_w_ensav = mean(Fp_scaled_w_thzav,4);
Fphi_scaled_h_ensav = mean(Fphi_scaled_h_thzav,4);
Fp_scaled_h_ensav = mean(Fp_scaled_h_thzav,4);

n=size(Fp_h,4)

for i=1:6
for j=1:n

Fphi_scaled_w_ens(:,:,i,j*2-1) = Fphi_scaled_w(46:90,:,i,j);
Fphi_scaled_w_ens(:,:,i,j*2) = -1*flipdim(Fphi_scaled_w(1:45,:,i,j),1);
Fp_scaled_w_ens(:,:,i,j*2-1) = Fp_scaled_w(46:90,:,i,j);
Fp_scaled_w_ens(:,:,i,j*2) = flipdim(Fp_scaled_w(1:45,:,i,j),1);

Fphi_scaled_h_ens(:,:,i,j*2-1) = Fphi_scaled_h(46:90,:,i,j);
Fphi_scaled_h_ens(:,:,i,j*2) = -1*flipdim(Fphi_scaled_h(1:45,:,i,j),1);
Fp_scaled_h_ens(:,:,i,j*2-1) = Fp_scaled_h(46:90,:,i,j);
Fp_scaled_h_ens(:,:,i,j*2) = flipdim(Fp_scaled_h(1:45,:,i,j),1);

end
end


N_pop = size(Fp_scaled_w_ens,4);


%calculate variance of each population for bottom part of lag covar
for i=1:N_pop
vardiff_phi_w (:,:,:,i) = (Fphi_scaled_w_ens(:,:,:,i) - Fphi_scaled_w_ensav).^2;
vardiff_phi_h (:,:,:,i) = (Fphi_scaled_h_ens(:,:,:,i) - Fphi_scaled_h_ensav).^2;
vardiff_p_w (:,:,:,i) = (Fp_scaled_w_ens(:,:,:,i) - Fp_scaled_w_ensav).^2;
vardiff_p_h (:,:,:,i) = (Fp_scaled_h_ens(:,:,:,i) - Fp_scaled_h_ensav).^2;
end



T0_w = 1 ;
T0_h = 1 ;


%%%%%%%%%%%%%%%%%%%
n_w = N_pop./T0_w;
n_h = N_pop./T0_h;

var_weight_w = N_pop - T0_w;
var_weight_h = N_pop - T0_h;

var_phi_w = sum(vardiff_phi_w,4)./var_weight_w;
var_phi_h = sum(vardiff_phi_h,4)./var_weight_h;
var_p_w = sum(vardiff_p_w,4)./var_weight_w;
var_p_h = sum(vardiff_p_h,4)./var_weight_h;

%%%%% initial t calculation...
T_phi = (Fphi_scaled_w_ensav - Fphi_scaled_h_ensav)./sqrt(var_phi_w./n_w + var_phi_h./n_h);
T_p = (Fp_scaled_w_ensav - Fp_scaled_h_ensav)./sqrt(var_p_w./n_w + var_p_h./n_h);

DF_phi = (var_phi_w./n_w + var_phi_h./n_h).^2./( (var_phi_w./n_w).^2./(n_w-1) + (var_phi_h./n_h).^2./(n_h-1) ) ;
DF_p = (var_p_w./n_w + var_p_h./n_h).^2./( (var_p_w./n_w).^2./(n_w-1) + (var_p_h./n_h).^2./(n_h-1) ) ;
%wh

%%% significance (one sided statistics? whatever that means...)

p_phi = tcdf(abs(T_phi),DF_phi);
p_p = tcdf(abs(T_p),DF_p);
