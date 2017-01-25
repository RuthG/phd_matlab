%Calculate significance of results for the tropheat10 spinup experiment

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
load('ezav_thd.mat')
load('ezav_c.mat')

%load ensemble members
load('ens_thd.mat')
load('ens_c.mat')


N_pop = size(uE_thd_ens,4);

%calculate variance of each population for bottom part of lag covar
for i=1:N_pop


psi_thd_vd(:,:,:,i) = (psi_thd_ens(:,:,:,i) - psi_thd_ezav).^2;
uE_thd_vd(:,:,:,i) = (uE_thd_ens(:,:,:,i) - uE_thd_ezav).^2;
theta_thd_vd(:,:,:,i) = (theta_thd_ens(:,:,:,i) - theta_thd_ezav).^2;
htrt_thd_vd(:,:,:,i) = (htrt_thd_ens(:,:,:,i) - htrt_thd_ezav).^2;
uv_ed_thd_vd(:,:,:,i) = (uv_ed_thd_ens(:,:,:,i) - uv_ed_thd_ezav).^2;
vt_ed_thd_vd(:,:,:,i) = (vt_ed_thd_ens(:,:,:,i) - vt_ed_thd_ezav).^2;
Fphi_thd_vd(:,:,:,i) = (Fphi_scaled_thd_ens(:,:,:,i) - Fphi_scaled_thd_ezav).^2;
Fp_thd_vd(:,:,:,i) = (Fp_scaled_thd_ens(:,:,:,i) - Fp_scaled_thd_ezav).^2;
fluxdiv_thd_vd(:,:,:,i) = (fluxdiv_thd_ens(:,:,:,i) - fluxdiv_thd_ezav).^2;
eke_thd_vd(:,:,:,i) = (eke_thd_ens(:,:,:,i) - eke_thd_ezav).^2;
qgref_thd_vd(:,:,:,i) = (qgref_thd_ens(:,:,:,i) - qgref_thd_ezav).^2;

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
T0_thd = 1 ;
T0_c = 1 ;

%%%%%%%%%%%%%%%%%%%
n_thd = N_pop./T0_thd;
n_c = N_pop./T0_c;

var_weight_thd = N_pop - T0_thd;
var_weight_c = N_pop - T0_c;

psi_thd_var = sum(psi_thd_vd,4)./var_weight_thd;
uE_thd_var = sum(uE_thd_vd,4)./var_weight_thd;
theta_thd_var = sum(theta_thd_vd,4)./var_weight_thd;
htrt_thd_var = sum(htrt_thd_vd,4)./var_weight_thd;
uv_ed_thd_var = sum(uv_ed_thd_vd,4)./var_weight_thd;
vt_ed_thd_var = sum(vt_ed_thd_vd,4)./var_weight_thd;
Fphi_thd_var = sum(Fphi_thd_vd,4)./var_weight_thd;
Fp_thd_var = sum(Fp_thd_vd,4)./var_weight_thd;
fluxdiv_thd_var = sum(fluxdiv_thd_vd,4)./var_weight_thd;
eke_thd_var = sum(eke_thd_vd,4)./var_weight_thd;
qgref_thd_var = sum(qgref_thd_vd,4)./var_weight_thd;

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

psi_thd_T = (psi_thd_ezav - psi_c_ezav)./sqrt(psi_thd_var./n_thd + psi_c_var./n_thd);
uE_thd_T = (uE_thd_ezav - uE_c_ezav)./sqrt(uE_thd_var./n_thd + uE_c_var./n_thd);
theta_thd_T = (theta_thd_ezav - theta_c_ezav)./sqrt(theta_thd_var./n_thd + theta_c_var./n_thd);
htrt_thd_T = (htrt_thd_ezav - htrt_c_ezav)./sqrt(htrt_thd_var./n_thd + htrt_c_var./n_thd);
uv_ed_thd_T = (uv_ed_thd_ezav - uv_ed_c_ezav)./sqrt(uv_ed_thd_var./n_thd + uv_ed_c_var./n_thd);
vt_ed_thd_T = (vt_ed_thd_ezav - vt_ed_c_ezav)./sqrt(vt_ed_thd_var./n_thd + vt_ed_c_var./n_thd);
Fphi_thd_T = (Fphi_scaled_thd_ezav - Fphi_scaled_c_ezav)./sqrt(Fphi_thd_var./n_thd + Fphi_c_var./n_thd);
Fp_thd_T = (Fp_scaled_thd_ezav - Fp_scaled_c_ezav)./sqrt(Fp_thd_var./n_thd + Fp_c_var./n_thd);
fluxdiv_thd_T = (fluxdiv_thd_ezav - fluxdiv_c_ezav)./sqrt(fluxdiv_thd_var./n_thd + fluxdiv_c_var./n_thd);
eke_thd_T = (eke_thd_ezav - eke_c_ezav)./sqrt(eke_thd_var./n_thd + eke_c_var./n_thd);
qgref_thd_T = (qgref_thd_ezav - qgref_c_ezav)./sqrt(qgref_thd_var./n_thd + qgref_c_var./n_thd);

psi_thd_df = (psi_thd_var./n_thd + psi_c_var./n_c).^2./( (psi_thd_var./n_thd).^2./(n_thd-1) + (psi_c_var./n_c).^2./(n_c-1) ) ;
uE_thd_df = (uE_thd_var./n_thd + uE_c_var./n_c).^2./( (uE_thd_var./n_thd).^2./(n_thd-1) + (uE_c_var./n_c).^2./(n_c-1) ) ;
theta_thd_df = (theta_thd_var./n_thd + theta_c_var./n_c).^2./( (theta_thd_var./n_thd).^2./(n_thd-1) + (theta_c_var./n_c).^2./(n_c-1) ) ;
htrt_thd_df = (htrt_thd_var./n_thd + htrt_c_var./n_c).^2./( (htrt_thd_var./n_thd).^2./(n_thd-1) + (htrt_c_var./n_c).^2./(n_c-1) ) ;
uv_ed_thd_df = (uv_ed_thd_var./n_thd + uv_ed_c_var./n_c).^2./( (uv_ed_thd_var./n_thd).^2./(n_thd-1) + (uv_ed_c_var./n_c).^2./(n_c-1) ) ;
vt_ed_thd_df = (vt_ed_thd_var./n_thd + vt_ed_c_var./n_c).^2./( (vt_ed_thd_var./n_thd).^2./(n_thd-1) + (vt_ed_c_var./n_c).^2./(n_c-1) ) ;
Fphi_thd_df = (Fphi_thd_var./n_thd + Fphi_c_var./n_c).^2./( (Fphi_thd_var./n_thd).^2./(n_thd-1) + (Fphi_c_var./n_c).^2./(n_c-1) ) ;
Fp_thd_df = (Fp_thd_var./n_thd + Fp_c_var./n_c).^2./( (Fp_thd_var./n_thd).^2./(n_thd-1) + (Fp_c_var./n_c).^2./(n_c-1) ) ;
fluxdiv_thd_df = (fluxdiv_thd_var./n_thd + fluxdiv_c_var./n_c).^2./( (fluxdiv_thd_var./n_thd).^2./(n_thd-1) + (fluxdiv_c_var./n_c).^2./(n_c-1) ) ;
eke_thd_df = (eke_thd_var./n_thd + eke_c_var./n_c).^2./( (eke_thd_var./n_thd).^2./(n_thd-1) + (eke_c_var./n_c).^2./(n_c-1) ) ;
qgref_thd_df = (qgref_thd_var./n_thd + qgref_c_var./n_c).^2./( (qgref_thd_var./n_thd).^2./(n_thd-1) + (qgref_c_var./n_c).^2./(n_c-1) ) ;

%%% significance (one sided statistics? whatever that means...)

psi_thd_p = tcdf(abs(psi_thd_T),psi_thd_df);
uE_thd_p = tcdf(abs(uE_thd_T),uE_thd_df);
theta_thd_p = tcdf(abs(theta_thd_T),theta_thd_df);
htrt_thd_p = tcdf(abs(htrt_thd_T),htrt_thd_df);
uv_ed_thd_p = tcdf(abs(uv_ed_thd_T),uv_ed_thd_df);
vt_ed_thd_p = tcdf(abs(vt_ed_thd_T),vt_ed_thd_df);
Fphi_thd_p = tcdf(abs(Fphi_thd_T),Fphi_thd_df);
Fp_thd_p = tcdf(abs(Fp_thd_T),Fp_thd_df);
fluxdiv_thd_p = tcdf(abs(fluxdiv_thd_T),fluxdiv_thd_df);
eke_thd_p = tcdf(abs(eke_thd_T),eke_thd_df);
qgref_thd_p = tcdf(abs(qgref_thd_T),qgref_thd_df);

psi_thd_shad = psi_thd_p;
psi_thd_shad(find(psi_thd_p<0.95)) = 1.;
psi_thd_shad(find(psi_thd_p>=0.95)) = 0.;

uE_thd_shad = uE_thd_p;
uE_thd_shad(find(uE_thd_p<0.95)) = 1.;
uE_thd_shad(find(uE_thd_p>=0.95)) = 0.;

theta_thd_shad = theta_thd_p;
theta_thd_shad(find(theta_thd_p<0.95)) = 1.;
theta_thd_shad(find(theta_thd_p>=0.95)) = 0.;

htrt_thd_shad = htrt_thd_p;
htrt_thd_shad(find(htrt_thd_p<0.95)) = 1.;
htrt_thd_shad(find(htrt_thd_p>=0.95)) = 0.;

uv_ed_thd_shad = uv_ed_thd_p;
uv_ed_thd_shad(find(uv_ed_thd_p<0.95)) = 1.;
uv_ed_thd_shad(find(uv_ed_thd_p>=0.95)) = 0.;

vt_ed_thd_shad = vt_ed_thd_p;
vt_ed_thd_shad(find(vt_ed_thd_p<0.95)) = 1.;
vt_ed_thd_shad(find(vt_ed_thd_p>=0.95)) = 0.;

Fphi_thd_shad = Fphi_thd_p;
Fphi_thd_shad(find(Fphi_thd_p<0.95)) = 1.;
Fphi_thd_shad(find(Fphi_thd_p>=0.95)) = 0.;

Fp_thd_shad = Fp_thd_p;
Fp_thd_shad(find(Fp_thd_p<0.95)) = 1.;
Fp_thd_shad(find(Fp_thd_p>=0.95)) = 0.;

fluxdiv_thd_shad = fluxdiv_thd_p;
fluxdiv_thd_shad(find(fluxdiv_thd_p<0.95)) = 1.;
fluxdiv_thd_shad(find(fluxdiv_thd_p>=0.95)) = 0.;

eke_thd_shad = eke_thd_p;
eke_thd_shad(find(eke_thd_p<0.95)) = 1.;
eke_thd_shad(find(eke_thd_p>=0.95)) = 0.;

qgref_thd_shad = qgref_thd_p;
qgref_thd_shad(find(qgref_thd_p<0.95)) = 1.;
qgref_thd_shad(find(qgref_thd_p>=0.95)) = 0.;

save('sig_thd.mat','psi_thd_shad','uE_thd_shad','theta_thd_shad','htrt_thd_shad', 'uv_ed_thd_shad','vt_ed_thd_shad','Fphi_thd_shad','Fp_thd_shad','fluxdiv_thd_shad','eke_thd_shad','qgref_thd_shad')
