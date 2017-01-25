%Calculate significance of results for the tropheat eqm experiment

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv_tropheat3eq/';

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
load('yzav_th.mat')
load('yzav_c.mat')

%load years
load('years_th.mat')
load('years_c.mat')


N_pop = size(uE_th_years,3);

%calculate variance of each population for bottom part of lag covar
for i=1:N_pop


psi_th_vd(:,:,i) = (psi_th_years(:,:,i) - psi_th_yzav).^2;
uE_th_vd(:,:,i) = (uE_th_years(:,:,i) - uE_th_yzav).^2;
theta_th_vd(:,:,i) = (theta_th_years(:,:,i) - theta_th_yzav).^2;
htrt_th_vd(:,:,i) = (htrt_th_years(:,:,i) - htrt_th_yzav).^2;
uv_ed_th_vd(:,:,i) = (uv_ed_th_years(:,:,i) - uv_ed_th_yzav).^2;
vt_ed_th_vd(:,:,i) = (vt_ed_th_years(:,:,i) - vt_ed_th_yzav).^2;
Fphi_th_vd(:,:,i) = (Fphi_scaled_th_years(:,:,i) - Fphi_scaled_th_yzav).^2;
Fp_th_vd(:,:,i) = (Fp_scaled_th_years(:,:,i) - Fp_scaled_th_yzav).^2;
fluxdiv_th_vd(:,:,i) = (fluxdiv_th_years(:,:,i) - fluxdiv_th_yzav).^2;
eke_th_vd(:,:,i) = (eke_th_years(:,:,i) - eke_th_yzav).^2;
qgref_th_vd(:,:,i) = (qgref_th_years(:,:,i) - qgref_th_yzav).^2;

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
T0_th = 1 ;
T0_c = 1 ;


%%%%% Code to do lag correlation if needed

%N_pop = size(uE_th_years,3);

%lag = 0;

%evaluate lag covar at each lag
%for lag=1:N_pop./2-1;

%calculate top part of lag covar; remember uE_th_years(:,:,1&2) are diff hems of same year etc.
%  for i=1:N_pop - lag*2;
%  uE_th_lg(:,:,i) = (uE_th_years(:,:,i) - uE_th_yzav).*(uE_th_years(:,:,i+lag*2) - uE_th_yzav);
%  uE_c_lg(:,:,i) = (uE_c_years(:,:,i) - uE_c_yzav).*(uE_c_years(:,:,i+lag*2) - uE_c_yzav);
%  end

%evaluate lag covar; check if this is ok despite sum()/sum() + sum()/sum() ne (sum()+sum())/(sum()+sum()) 
%  uE_th_step(:,:) = sum(uE_th_lg,3)./sum(uE_th_vd,3);
%  uE_c_step(:,:) = sum(uE_c_lg,3)./sum(uE_c_vd,3);

%if this is negative, or if it has a negative value for a previous lag, set value to 0
%  uE_th_step(find(uE_th_step(:,:)<=0)) = 0;
%  uE_c_step(find(uE_c_step(:,:)<=0)) = 0;
%  if lag > 1
%  uE_th_step(find(uE_th_rl(:,:,lag-1) <=0 )) = 0;
%  uE_c_step(find(uE_c_rl(:,:,lag-1) <=0 )) = 0;
%  end

%output lag covariances at each lag
%  uE_th_rl(:,:,lag) = uE_th_step(:,:);
%  uE_c_rl(:,:,lag) = uE_c_step(:,:);

%end

%for i=1:N_pop./2-1;
%uE_th_T_part(:,:,i) = (1 - i./(N_pop./2)).*uE_th_rl(:,:,i);
%uE_c_T_part(:,:,i) = (1 - i./(N_pop./2)).*uE_c_rl(:,:,i);
%end

%uE_th_T0 = 1 + 2.*sum(uE_th_T_part,3);
%uE_c_T0 = 1 + 2.*sum(uE_c_T_part,3);




%%%%%%%%%%%%%%%%%%%
n_th = N_pop./T0_th;
n_c = N_pop./T0_c;

var_weight_th = N_pop - T0_th;
var_weight_c = N_pop - T0_c;

psi_th_var = sum(psi_th_vd,3)./var_weight_th;
uE_th_var = sum(uE_th_vd,3)./var_weight_th;
theta_th_var = sum(theta_th_vd,3)./var_weight_th;
htrt_th_var = sum(htrt_th_vd,3)./var_weight_th;
uv_ed_th_var = sum(uv_ed_th_vd,3)./var_weight_th;
vt_ed_th_var = sum(vt_ed_th_vd,3)./var_weight_th;
Fphi_th_var = sum(Fphi_th_vd,3)./var_weight_th;
Fp_th_var = sum(Fp_th_vd,3)./var_weight_th;
fluxdiv_th_var = sum(fluxdiv_th_vd,3)./var_weight_th;
eke_th_var = sum(eke_th_vd,3)./var_weight_th;
qgref_th_var = sum(qgref_th_vd,3)./var_weight_th;

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

psi_th_T = (psi_th_yzav - psi_c_yzav)./sqrt(psi_th_var./n_th + psi_c_var./n_th);
uE_th_T = (uE_th_yzav - uE_c_yzav)./sqrt(uE_th_var./n_th + uE_c_var./n_th);
theta_th_T = (theta_th_yzav - theta_c_yzav)./sqrt(theta_th_var./n_th + theta_c_var./n_th);
htrt_th_T = (htrt_th_yzav - htrt_c_yzav)./sqrt(htrt_th_var./n_th + htrt_c_var./n_th);
uv_ed_th_T = (uv_ed_th_yzav - uv_ed_c_yzav)./sqrt(uv_ed_th_var./n_th + uv_ed_c_var./n_th);
vt_ed_th_T = (vt_ed_th_yzav - vt_ed_c_yzav)./sqrt(vt_ed_th_var./n_th + vt_ed_c_var./n_th);
Fphi_th_T = (Fphi_scaled_th_yzav - Fphi_scaled_c_yzav)./sqrt(Fphi_th_var./n_th + Fphi_c_var./n_th);
Fp_th_T = (Fp_scaled_th_yzav - Fp_scaled_c_yzav)./sqrt(Fp_th_var./n_th + Fp_c_var./n_th);
fluxdiv_th_T = (fluxdiv_th_yzav - fluxdiv_c_yzav)./sqrt(fluxdiv_th_var./n_th + fluxdiv_c_var./n_th);
eke_th_T = (eke_th_yzav - eke_c_yzav)./sqrt(eke_th_var./n_th + eke_c_var./n_th);
qgref_th_T = (qgref_th_yzav - qgref_c_yzav)./sqrt(qgref_th_var./n_th + qgref_c_var./n_th);

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

psi_th_shad_y = psi_th_p;
psi_th_shad_y(find(psi_th_p<0.95)) = 1.;
psi_th_shad_y(find(psi_th_p>=0.95)) = 0.;

uE_th_shad_y = uE_th_p;
uE_th_shad_y(find(uE_th_p<0.95)) = 1.;
uE_th_shad_y(find(uE_th_p>=0.95)) = 0.;

theta_th_shad_y = theta_th_p;
theta_th_shad_y(find(theta_th_p<0.95)) = 1.;
theta_th_shad_y(find(theta_th_p>=0.95)) = 0.;

htrt_th_shad_y = htrt_th_p;
htrt_th_shad_y(find(htrt_th_p<0.95)) = 1.;
htrt_th_shad_y(find(htrt_th_p>=0.95)) = 0.;

uv_ed_th_shad_y = uv_ed_th_p;
uv_ed_th_shad_y(find(uv_ed_th_p<0.95)) = 1.;
uv_ed_th_shad_y(find(uv_ed_th_p>=0.95)) = 0.;

vt_ed_th_shad_y = vt_ed_th_p;
vt_ed_th_shad_y(find(vt_ed_th_p<0.95)) = 1.;
vt_ed_th_shad_y(find(vt_ed_th_p>=0.95)) = 0.;

Fphi_th_shad_y = Fphi_th_p;
Fphi_th_shad_y(find(Fphi_th_p<0.95)) = 1.;
Fphi_th_shad_y(find(Fphi_th_p>=0.95)) = 0.;

Fp_th_shad_y = Fp_th_p;
Fp_th_shad_y(find(Fp_th_p<0.95)) = 1.;
Fp_th_shad_y(find(Fp_th_p>=0.95)) = 0.;

fluxdiv_th_shad_y = fluxdiv_th_p;
fluxdiv_th_shad_y(find(fluxdiv_th_p<0.95)) = 1.;
fluxdiv_th_shad_y(find(fluxdiv_th_p>=0.95)) = 0.;

eke_th_shad_y = eke_th_p;
eke_th_shad_y(find(eke_th_p<0.95)) = 1.;
eke_th_shad_y(find(eke_th_p>=0.95)) = 0.;

qgref_th_shad_y = qgref_th_p;
qgref_th_shad_y(find(qgref_th_p<0.95)) = 1.;
qgref_th_shad_y(find(qgref_th_p>=0.95)) = 0.;

save('sig_y_th.mat','psi_th_shad_y','uE_th_shad_y','theta_th_shad_y','htrt_th_shad_y', 'uv_ed_th_shad_y','vt_ed_th_shad_y','Fphi_th_shad_y','Fp_th_shad_y','fluxdiv_th_shad_y','eke_th_shad_y','qgref_th_shad_y')
