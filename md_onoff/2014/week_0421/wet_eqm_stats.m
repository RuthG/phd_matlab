%Calculate significance of results for the tropheat eqm experiment

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
ylat = -89:2:89;

%load year averages
load('yzav_w.mat')
load('yzav_c.mat')

%load years
load('years_w.mat')
load('years_c.mat')


N_pop = size(uE_w_years,3);

%calculate variance of each population for bottom part of lag covar
for i=1:N_pop


psi_w_vd(:,:,i) = (psi_w_years(:,:,i) - psi_w_yzav).^2;
uE_w_vd(:,:,i) = (uE_w_years(:,:,i) - uE_w_yzav).^2;
theta_w_vd(:,:,i) = (theta_w_years(:,:,i) - theta_w_yzav).^2;
htrt_w_vd(:,:,i) = (htrt_w_years(:,:,i) - htrt_w_yzav).^2;
uv_ed_w_vd(:,:,i) = (uv_ed_w_years(:,:,i) - uv_ed_w_yzav).^2;
vt_ed_w_vd(:,:,i) = (vt_ed_w_years(:,:,i) - vt_ed_w_yzav).^2;
Fphi_w_vd(:,:,i) = (Fphi_scaled_w_years(:,:,i) - Fphi_scaled_w_yzav).^2;
Fp_w_vd(:,:,i) = (Fp_scaled_w_years(:,:,i) - Fp_scaled_w_yzav).^2;
fluxdiv_w_vd(:,:,i) = (fluxdiv_w_years(:,:,i) - fluxdiv_w_yzav).^2;
eke_w_vd(:,:,i) = (eke_w_years(:,:,i) - eke_w_yzav).^2;
qgref_w_vd(:,:,i) = (qgref_w_years(:,:,i) - qgref_w_yzav).^2;

psi_c_vd(:,:,i) = (psi_c_years(:,:,i) - psi_c_yzav).^2;
uE_c_vd(:,:,i) = (uE_c_years(:,:,i) - uE_c_yzav).^2;
theta_c_vd(:,:,i) = (theta_c_years(:,:,i) - theta_c_yzav).^2;
htrt_c_vd(:,:,i) = (htrt_c_years(:,:,i) - htrt_c_yzav).^2;
uv_ed_c_vd(:,:,i) = (uv_ed_c_years(:,:,i) - uv_ed_c_yzav).^2;
vt_ed_c_vd(:,:,i) = (vt_ed_c_years(:,:,i) - vt_ed_c_yzav).^2;
Fphi_c_vd(:,:,i) = (Fphi_scaled_c_years(:,:,i) - Fphi_scaled_c_yzav).^2;
Fp_c_vd(:,:,i) = (Fp_scaled_c_years(:,:,i) - Fp_scaled_c_yzav).^2;
fluxdiv_c_vd(:,:,i) = (fluxdiv_c_years(:,:,i) - fluxdiv_c_yzav).^2;
eke_c_vd(:,:,i) = (eke_c_years(:,:,i) - eke_c_yzav).^2;
qgref_c_vd(:,:,i) = (qgref_c_years(:,:,i) - qgref_c_yzav).^2;

end

%account for lagged correlation. Assume small for years. CHECK
T0_w = 1 ;
T0_c = 1 ;

%%%%%%%%%%%%%%%%%%%
n_w = N_pop./T0_w;
n_c = N_pop./T0_c;

var_weight_w = N_pop - T0_w;
var_weight_c = N_pop - T0_c;

psi_w_var = sum(psi_w_vd,3)./var_weight_w;
uE_w_var = sum(uE_w_vd,3)./var_weight_w;
theta_w_var = sum(theta_w_vd,3)./var_weight_w;
htrt_w_var = sum(htrt_w_vd,3)./var_weight_w;
uv_ed_w_var = sum(uv_ed_w_vd,3)./var_weight_w;
vt_ed_w_var = sum(vt_ed_w_vd,3)./var_weight_w;
Fphi_w_var = sum(Fphi_w_vd,3)./var_weight_w;
Fp_w_var = sum(Fp_w_vd,3)./var_weight_w;
fluxdiv_w_var = sum(fluxdiv_w_vd,3)./var_weight_w;
eke_w_var = sum(eke_w_vd,3)./var_weight_w;
qgref_w_var = sum(qgref_w_vd,3)./var_weight_w;

psi_c_var = sum(psi_c_vd,3)./var_weight_c;
uE_c_var = sum(uE_c_vd,3)./var_weight_c;
theta_c_var = sum(theta_c_vd,3)./var_weight_c;
htrt_c_var = sum(htrt_c_vd,3)./var_weight_c;
uv_ed_c_var = sum(uv_ed_c_vd,3)./var_weight_c;
vt_ed_c_var = sum(vt_ed_c_vd,3)./var_weight_c;
Fphi_c_var = sum(Fphi_c_vd,3)./var_weight_c;
Fp_c_var = sum(Fp_c_vd,3)./var_weight_c;
fluxdiv_c_var = sum(fluxdiv_c_vd,3)./var_weight_c;
eke_c_var = sum(eke_c_vd,3)./var_weight_c;
qgref_c_var = sum(qgref_c_vd,3)./var_weight_c;



%%%%% initial t calculation...

psi_w_T = (psi_w_yzav - psi_c_yzav)./sqrt(psi_w_var./n_w + psi_c_var./n_w);
uE_w_T = (uE_w_yzav - uE_c_yzav)./sqrt(uE_w_var./n_w + uE_c_var./n_w);
theta_w_T = (theta_w_yzav - theta_c_yzav)./sqrt(theta_w_var./n_w + theta_c_var./n_w);
htrt_w_T = (htrt_w_yzav - htrt_c_yzav)./sqrt(htrt_w_var./n_w + htrt_c_var./n_w);
uv_ed_w_T = (uv_ed_w_yzav - uv_ed_c_yzav)./sqrt(uv_ed_w_var./n_w + uv_ed_c_var./n_w);
vt_ed_w_T = (vt_ed_w_yzav - vt_ed_c_yzav)./sqrt(vt_ed_w_var./n_w + vt_ed_c_var./n_w);
Fphi_w_T = (Fphi_scaled_w_yzav - Fphi_scaled_c_yzav)./sqrt(Fphi_w_var./n_w + Fphi_c_var./n_w);
Fp_w_T = (Fp_scaled_w_yzav - Fp_scaled_c_yzav)./sqrt(Fp_w_var./n_w + Fp_c_var./n_w);
fluxdiv_w_T = (fluxdiv_w_yzav - fluxdiv_c_yzav)./sqrt(fluxdiv_w_var./n_w + fluxdiv_c_var./n_w);
eke_w_T = (eke_w_yzav - eke_c_yzav)./sqrt(eke_w_var./n_w + eke_c_var./n_w);
qgref_w_T = (qgref_w_yzav - qgref_c_yzav)./sqrt(qgref_w_var./n_w + qgref_c_var./n_w);

psi_w_df = (psi_w_var./n_w + psi_c_var./n_c).^2./( (psi_w_var./n_w).^2./(n_w-1) + (psi_c_var./n_c).^2./(n_c-1) ) ;
uE_w_df = (uE_w_var./n_w + uE_c_var./n_c).^2./( (uE_w_var./n_w).^2./(n_w-1) + (uE_c_var./n_c).^2./(n_c-1) ) ;
theta_w_df = (theta_w_var./n_w + theta_c_var./n_c).^2./( (theta_w_var./n_w).^2./(n_w-1) + (theta_c_var./n_c).^2./(n_c-1) ) ;
htrt_w_df = (htrt_w_var./n_w + htrt_c_var./n_c).^2./( (htrt_w_var./n_w).^2./(n_w-1) + (htrt_c_var./n_c).^2./(n_c-1) ) ;
uv_ed_w_df = (uv_ed_w_var./n_w + uv_ed_c_var./n_c).^2./( (uv_ed_w_var./n_w).^2./(n_w-1) + (uv_ed_c_var./n_c).^2./(n_c-1) ) ;
vt_ed_w_df = (vt_ed_w_var./n_w + vt_ed_c_var./n_c).^2./( (vt_ed_w_var./n_w).^2./(n_w-1) + (vt_ed_c_var./n_c).^2./(n_c-1) ) ;
Fphi_w_df = (Fphi_w_var./n_w + Fphi_c_var./n_c).^2./( (Fphi_w_var./n_w).^2./(n_w-1) + (Fphi_c_var./n_c).^2./(n_c-1) ) ;
Fp_w_df = (Fp_w_var./n_w + Fp_c_var./n_c).^2./( (Fp_w_var./n_w).^2./(n_w-1) + (Fp_c_var./n_c).^2./(n_c-1) ) ;
fluxdiv_w_df = (fluxdiv_w_var./n_w + fluxdiv_c_var./n_c).^2./( (fluxdiv_w_var./n_w).^2./(n_w-1) + (fluxdiv_c_var./n_c).^2./(n_c-1) ) ;
eke_w_df = (eke_w_var./n_w + eke_c_var./n_c).^2./( (eke_w_var./n_w).^2./(n_w-1) + (eke_c_var./n_c).^2./(n_c-1) ) ;
qgref_w_df = (qgref_w_var./n_w + qgref_c_var./n_c).^2./( (qgref_w_var./n_w).^2./(n_w-1) + (qgref_c_var./n_c).^2./(n_c-1) ) ;

%%% significance (one sided statistics? whatever that means...)

psi_w_p = tcdf(abs(psi_w_T),psi_w_df);
uE_w_p = tcdf(abs(uE_w_T),uE_w_df);
theta_w_p = tcdf(abs(theta_w_T),theta_w_df);
htrt_w_p = tcdf(abs(htrt_w_T),htrt_w_df);
uv_ed_w_p = tcdf(abs(uv_ed_w_T),uv_ed_w_df);
vt_ed_w_p = tcdf(abs(vt_ed_w_T),vt_ed_w_df);
Fphi_w_p = tcdf(abs(Fphi_w_T),Fphi_w_df);
Fp_w_p = tcdf(abs(Fp_w_T),Fp_w_df);
fluxdiv_w_p = tcdf(abs(fluxdiv_w_T),fluxdiv_w_df);
eke_w_p = tcdf(abs(eke_w_T),eke_w_df);
qgref_w_p = tcdf(abs(qgref_w_T),qgref_w_df);

psi_w_shad_y = psi_w_p;
psi_w_shad_y(find(psi_w_p<0.95)) = 1.;
psi_w_shad_y(find(psi_w_p>=0.95)) = 0.;

uE_w_shad_y = uE_w_p;
uE_w_shad_y(find(uE_w_p<0.95)) = 1.;
uE_w_shad_y(find(uE_w_p>=0.95)) = 0.;

theta_w_shad_y = theta_w_p;
theta_w_shad_y(find(theta_w_p<0.95)) = 1.;
theta_w_shad_y(find(theta_w_p>=0.95)) = 0.;

htrt_w_shad_y = htrt_w_p;
htrt_w_shad_y(find(htrt_w_p<0.95)) = 1.;
htrt_w_shad_y(find(htrt_w_p>=0.95)) = 0.;

uv_ed_w_shad_y = uv_ed_w_p;
uv_ed_w_shad_y(find(uv_ed_w_p<0.95)) = 1.;
uv_ed_w_shad_y(find(uv_ed_w_p>=0.95)) = 0.;

vt_ed_w_shad_y = vt_ed_w_p;
vt_ed_w_shad_y(find(vt_ed_w_p<0.95)) = 1.;
vt_ed_w_shad_y(find(vt_ed_w_p>=0.95)) = 0.;

Fphi_w_shad_y = Fphi_w_p;
Fphi_w_shad_y(find(Fphi_w_p<0.95)) = 1.;
Fphi_w_shad_y(find(Fphi_w_p>=0.95)) = 0.;

Fp_w_shad_y = Fp_w_p;
Fp_w_shad_y(find(Fp_w_p<0.95)) = 1.;
Fp_w_shad_y(find(Fp_w_p>=0.95)) = 0.;

fluxdiv_w_shad_y = fluxdiv_w_p;
fluxdiv_w_shad_y(find(fluxdiv_w_p<0.95)) = 1.;
fluxdiv_w_shad_y(find(fluxdiv_w_p>=0.95)) = 0.;

eke_w_shad_y = eke_w_p;
eke_w_shad_y(find(eke_w_p<0.95)) = 1.;
eke_w_shad_y(find(eke_w_p>=0.95)) = 0.;

qgref_w_shad_y = qgref_w_p;
qgref_w_shad_y(find(qgref_w_p<0.95)) = 1.;
qgref_w_shad_y(find(qgref_w_p>=0.95)) = 0.;

save('sig_y_w.mat','psi_w_shad_y','uE_w_shad_y','theta_w_shad_y','htrt_w_shad_y', 'uv_ed_w_shad_y','vt_ed_w_shad_y','Fphi_w_shad_y','Fp_w_shad_y','fluxdiv_w_shad_y','eke_w_shad_y','qgref_w_shad_y')
