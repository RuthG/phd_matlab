%Calculate significance of results for the tropheat spinup experiment

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
ylat = -89:2:89;

%load ensemble averages
load('ezav_th.mat')
load('ezav_c.mat')

%load ensemble members
load('ens_th.mat')
load('ens_c.mat')


N_pop = size(uE_th_ens,4);

%calculate variance of each population for bottom part of lag covar
for i=1:N_pop


psi_th_vd(:,:,:,i) = (psi_th_ens(:,:,:,i) - psi_th_ezav).^2;
uE_th_vd(:,:,:,i) = (uE_th_ens(:,:,:,i) - uE_th_ezav).^2;
theta_th_vd(:,:,:,i) = (theta_th_ens(:,:,:,i) - theta_th_ezav).^2;
htrt_th_vd(:,:,:,i) = (htrt_th_ens(:,:,:,i) - htrt_th_ezav).^2;
uv_ed_th_vd(:,:,:,i) = (uv_ed_th_ens(:,:,:,i) - uv_ed_th_ezav).^2;
vt_ed_th_vd(:,:,:,i) = (vt_ed_th_ens(:,:,:,i) - vt_ed_th_ezav).^2;
Fphi_th_vd(:,:,:,i) = (Fphi_scaled_th_ens(:,:,:,i) - Fphi_scaled_th_ezav).^2;
Fp_th_vd(:,:,:,i) = (Fp_scaled_th_ens(:,:,:,i) - Fp_scaled_th_ezav).^2;
fluxdiv_th_vd(:,:,:,i) = (fluxdiv_th_ens(:,:,:,i) - fluxdiv_th_ezav).^2;
eke_th_vd(:,:,:,i) = (eke_th_ens(:,:,:,i) - eke_th_ezav).^2;
qgref_th_vd(:,:,:,i) = (qgref_th_ens(:,:,:,i) - qgref_th_ezav).^2;

psi_c_vd(:,:,:,i) = (psi_c_ens(:,:,:,i) - psi_c_ezav).^2;
uE_c_vd(:,:,:,i) = (uE_c_ens(:,:,:,i) - uE_c_ezav).^2;
theta_c_vd(:,:,:,i) = (theta_c_ens(:,:,:,i) - theta_c_ezav).^2;
htrt_c_vd(:,:,:,i) = (htrt_c_ens(:,:,:,i) - htrt_c_ezav).^2;
uv_ed_c_vd(:,:,:,i) = (uv_ed_c_ens(:,:,:,i) - uv_ed_c_ezav).^2;
vt_ed_c_vd(:,:,:,i) = (vt_ed_c_ens(:,:,:,i) - vt_ed_c_ezav).^2;
Fphi_c_vd(:,:,:,i) = (Fphi_scaled_c_ens(:,:,:,i) - Fphi_scaled_c_ezav).^2;
Fp_c_vd(:,:,:,i) = (Fp_scaled_c_ens(:,:,:,i) - Fp_scaled_c_ezav).^2;
fluxdiv_c_vd(:,:,:,i) = (fluxdiv_c_ens(:,:,:,i) - fluxdiv_c_ezav).^2;
eke_c_vd(:,:,:,i) = (eke_c_ens(:,:,:,i) - eke_c_ezav).^2;
qgref_c_vd(:,:,:,i) = (qgref_c_ens(:,:,:,i) - qgref_c_ezav).^2;

end

%accounts for lagged correlation. Assume no correlation for ensemble?
T0_th = 1 ;
T0_c = 1 ;

%%%%%%%%%%%%%%%%%%%
n_th = N_pop./T0_th;
n_c = N_pop./T0_c;

var_weight_th = N_pop - T0_th;
var_weight_c = N_pop - T0_c;

psi_th_var = sum(psi_th_vd,4)./var_weight_th;
uE_th_var = sum(uE_th_vd,4)./var_weight_th;
theta_th_var = sum(theta_th_vd,4)./var_weight_th;
htrt_th_var = sum(htrt_th_vd,4)./var_weight_th;
uv_ed_th_var = sum(uv_ed_th_vd,4)./var_weight_th;
vt_ed_th_var = sum(vt_ed_th_vd,4)./var_weight_th;
Fphi_th_var = sum(Fphi_th_vd,4)./var_weight_th;
Fp_th_var = sum(Fp_th_vd,4)./var_weight_th;
fluxdiv_th_var = sum(fluxdiv_th_vd,4)./var_weight_th;
eke_th_var = sum(eke_th_vd,4)./var_weight_th;
qgref_th_var = sum(qgref_th_vd,4)./var_weight_th;

psi_c_var = sum(psi_c_vd,4)./var_weight_c;
uE_c_var = sum(uE_c_vd,4)./var_weight_c;
theta_c_var = sum(theta_c_vd,4)./var_weight_c;
htrt_c_var = sum(htrt_c_vd,4)./var_weight_c;
uv_ed_c_var = sum(uv_ed_c_vd,4)./var_weight_c;
vt_ed_c_var = sum(vt_ed_c_vd,4)./var_weight_c;
Fphi_c_var = sum(Fphi_c_vd,4)./var_weight_c;
Fp_c_var = sum(Fp_c_vd,4)./var_weight_c;
fluxdiv_c_var = sum(fluxdiv_c_vd,4)./var_weight_c;
eke_c_var = sum(eke_c_vd,4)./var_weight_c;
qgref_c_var = sum(qgref_c_vd,4)./var_weight_c;



%%%%% initial t calculation...

psi_th_T = (psi_th_ezav - psi_c_ezav)./sqrt(psi_th_var./n_th + psi_c_var./n_th);
uE_th_T = (uE_th_ezav - uE_c_ezav)./sqrt(uE_th_var./n_th + uE_c_var./n_th);
theta_th_T = (theta_th_ezav - theta_c_ezav)./sqrt(theta_th_var./n_th + theta_c_var./n_th);
htrt_th_T = (htrt_th_ezav - htrt_c_ezav)./sqrt(htrt_th_var./n_th + htrt_c_var./n_th);
uv_ed_th_T = (uv_ed_th_ezav - uv_ed_c_ezav)./sqrt(uv_ed_th_var./n_th + uv_ed_c_var./n_th);
vt_ed_th_T = (vt_ed_th_ezav - vt_ed_c_ezav)./sqrt(vt_ed_th_var./n_th + vt_ed_c_var./n_th);
Fphi_th_T = (Fphi_scaled_th_ezav - Fphi_scaled_c_ezav)./sqrt(Fphi_th_var./n_th + Fphi_c_var./n_th);
Fp_th_T = (Fp_scaled_th_ezav - Fp_scaled_c_ezav)./sqrt(Fp_th_var./n_th + Fp_c_var./n_th);
fluxdiv_th_T = (fluxdiv_th_ezav - fluxdiv_c_ezav)./sqrt(fluxdiv_th_var./n_th + fluxdiv_c_var./n_th);
eke_th_T = (eke_th_ezav - eke_c_ezav)./sqrt(eke_th_var./n_th + eke_c_var./n_th);
qgref_th_T = (qgref_th_ezav - qgref_c_ezav)./sqrt(qgref_th_var./n_th + qgref_c_var./n_th);

psi_th_df = (psi_th_var./n_th + psi_c_var./n_c).^2./( (psi_th_var./n_th).^2./(n_th-1) + (psi_c_var./n_c).^2./(n_c-1) ) ;
uE_th_df = (uE_th_var./n_th + uE_c_var./n_c).^2./( (uE_th_var./n_th).^2./(n_th-1) + (uE_c_var./n_c).^2./(n_c-1) ) ;
theta_th_df = (theta_th_var./n_th + theta_c_var./n_c).^2./( (theta_th_var./n_th).^2./(n_th-1) + (theta_c_var./n_c).^2./(n_c-1) ) ;
htrt_th_df = (htrt_th_var./n_th + htrt_c_var./n_c).^2./( (htrt_th_var./n_th).^2./(n_th-1) + (htrt_c_var./n_c).^2./(n_c-1) ) ;
uv_ed_th_df = (uv_ed_th_var./n_th + uv_ed_c_var./n_c).^2./( (uv_ed_th_var./n_th).^2./(n_th-1) + (uv_ed_c_var./n_c).^2./(n_c-1) ) ;
vt_ed_th_df = (vt_ed_th_var./n_th + vt_ed_c_var./n_c).^2./( (vt_ed_th_var./n_th).^2./(n_th-1) + (vt_ed_c_var./n_c).^2./(n_c-1) ) ;
Fphi_th_df = (Fphi_th_var./n_th + Fphi_c_var./n_c).^2./( (Fphi_th_var./n_th).^2./(n_th-1) + (Fphi_c_var./n_c).^2./(n_c-1) ) ;
Fp_th_df = (Fp_th_var./n_th + Fp_c_var./n_c).^2./( (Fp_th_var./n_th).^2./(n_th-1) + (Fp_c_var./n_c).^2./(n_c-1) ) ;
fluxdiv_th_df = (fluxdiv_th_var./n_th + fluxdiv_c_var./n_c).^2./( (fluxdiv_th_var./n_th).^2./(n_th-1) + (fluxdiv_c_var./n_c).^2./(n_c-1) ) ;
eke_th_df = (eke_th_var./n_th + eke_c_var./n_c).^2./( (eke_th_var./n_th).^2./(n_th-1) + (eke_c_var./n_c).^2./(n_c-1) ) ;
qgref_th_df = (qgref_th_var./n_th + qgref_c_var./n_c).^2./( (qgref_th_var./n_th).^2./(n_th-1) + (qgref_c_var./n_c).^2./(n_c-1) ) ;

%%% significance (one sided statistics? whatever that means...)

psi_th_p = tcdf(abs(psi_th_T),psi_th_df);
uE_th_p = tcdf(abs(uE_th_T),uE_th_df);
theta_th_p = tcdf(abs(theta_th_T),theta_th_df);
htrt_th_p = tcdf(abs(htrt_th_T),htrt_th_df);
uv_ed_th_p = tcdf(abs(uv_ed_th_T),uv_ed_th_df);
vt_ed_th_p = tcdf(abs(vt_ed_th_T),vt_ed_th_df);
Fphi_th_p = tcdf(abs(Fphi_th_T),Fphi_th_df);
Fp_th_p = tcdf(abs(Fp_th_T),Fp_th_df);
fluxdiv_th_p = tcdf(abs(fluxdiv_th_T),fluxdiv_th_df);
eke_th_p = tcdf(abs(eke_th_T),eke_th_df);
qgref_th_p = tcdf(abs(qgref_th_T),qgref_th_df);

psi_th_shad = psi_th_p;
psi_th_shad(find(psi_th_p<0.95)) = 1.;
psi_th_shad(find(psi_th_p>=0.95)) = 0.;

uE_th_shad = uE_th_p;
uE_th_shad(find(uE_th_p<0.95)) = 1.;
uE_th_shad(find(uE_th_p>=0.95)) = 0.;

theta_th_shad = theta_th_p;
theta_th_shad(find(theta_th_p<0.95)) = 1.;
theta_th_shad(find(theta_th_p>=0.95)) = 0.;

htrt_th_shad = htrt_th_p;
htrt_th_shad(find(htrt_th_p<0.95)) = 1.;
htrt_th_shad(find(htrt_th_p>=0.95)) = 0.;

uv_ed_th_shad = uv_ed_th_p;
uv_ed_th_shad(find(uv_ed_th_p<0.95)) = 1.;
uv_ed_th_shad(find(uv_ed_th_p>=0.95)) = 0.;

vt_ed_th_shad = vt_ed_th_p;
vt_ed_th_shad(find(vt_ed_th_p<0.95)) = 1.;
vt_ed_th_shad(find(vt_ed_th_p>=0.95)) = 0.;

Fphi_th_shad = Fphi_th_p;
Fphi_th_shad(find(Fphi_th_p<0.95)) = 1.;
Fphi_th_shad(find(Fphi_th_p>=0.95)) = 0.;

Fp_th_shad = Fp_th_p;
Fp_th_shad(find(Fp_th_p<0.95)) = 1.;
Fp_th_shad(find(Fp_th_p>=0.95)) = 0.;

fluxdiv_th_shad = fluxdiv_th_p;
fluxdiv_th_shad(find(fluxdiv_th_p<0.95)) = 1.;
fluxdiv_th_shad(find(fluxdiv_th_p>=0.95)) = 0.;

eke_th_shad = eke_th_p;
eke_th_shad(find(eke_th_p<0.95)) = 1.;
eke_th_shad(find(eke_th_p>=0.95)) = 0.;

qgref_th_shad = qgref_th_p;
qgref_th_shad(find(qgref_th_p<0.95)) = 1.;
qgref_th_shad(find(qgref_th_p>=0.95)) = 0.;

save('sig_th.mat','psi_th_shad','uE_th_shad','theta_th_shad','htrt_th_shad', 'uv_ed_th_shad','vt_ed_th_shad','Fphi_th_shad','Fp_th_shad','fluxdiv_th_shad','eke_th_shad','qgref_th_shad')
