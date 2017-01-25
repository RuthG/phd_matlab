load('eke_wv_on_rad_off_run_5year_c.mat')
eke_a = eke_diag;
load('mape_wv_on_rad_off_run_5year_c.mat')
mape_a = mape;

load('eke_wv_on_rad_on_run_10yearradon.mat')
eke_b = eke_diag;
load('mape_wv_on_rad_on_run_10yearradon.mat')
mape_b = mape;

load('eke_atm_gray_ruth_run.mat')
eke_c = eke_diag;
load('mape_atm_gray_ruth_run.mat')
mape_c = mape;

mape_plot = [mape_a,mape_b,mape_c];
eke_plot = [eke_a,eke_b,eke_c];
