[corr_000,htrtt_ed_000,th_sd_000,htrt_sd_000] = htrtt_corr_fun('htrt_000','theta_000');
'000'

[corr_010,htrtt_ed_010,th_sd_010,htrt_sd_010] = htrtt_corr_fun('htrt_010','theta_010');
'010'

[corr_025,htrtt_ed_025,th_sd_025,htrt_sd_025] = htrtt_corr_fun('htrt_025','theta_025');
'025'

[corr_050,htrtt_ed_050,th_sd_050,htrt_sd_050] = htrtt_corr_fun('htrt_050','theta_050');
'050'

[corr_075,htrtt_ed_075,th_sd_075,htrt_sd_075] = htrtt_corr_fun('htrt_075','theta_075');
'075'

[corr_100,htrtt_ed_100,th_sd_100,htrt_sd_100] = htrtt_corr_fun('htrt_100','theta_100');
'100'

save('/project/rg312/mat_files/htrt_theta_corr.mat')
clear


[corr_000,htrtt_ed_000,th_sd_000,htrt_sd_000] = htrtt_corr_fun_cold('htrt_000','theta_000');
'000'

[corr_010,htrtt_ed_010,th_sd_010,htrt_sd_010] = htrtt_corr_fun_cold('htrt_010','theta_010');
'010'

[corr_025,htrtt_ed_025,th_sd_025,htrt_sd_025] = htrtt_corr_fun_cold('htrt_025','theta_025');
'025'

[corr_050,htrtt_ed_050,th_sd_050,htrt_sd_050] = htrtt_corr_fun_cold('htrt_050','theta_050');
'050'

[corr_075,htrtt_ed_075,th_sd_075,htrt_sd_075] = htrtt_corr_fun_cold('htrt_075','theta_075');
'075'

[corr_100,htrtt_ed_100,th_sd_100,htrt_sd_100] = htrtt_corr_fun_cold('htrt_100','theta_100');
'100'


save('/project/rg312/mat_files/htrt_theta_corr_cold.mat')
clear




[corr_000,htrtt_ed_000,th_sd_000,htrt_sd_000] = htrtt_corr_fun_warm('htrt_000','theta_000');
'000'

[corr_010,htrtt_ed_010,th_sd_010,htrt_sd_010] = htrtt_corr_fun_warm('htrt_010','theta_010');
'010'

[corr_025,htrtt_ed_025,th_sd_025,htrt_sd_025] = htrtt_corr_fun_warm('htrt_025','theta_025');
'025'

[corr_050,htrtt_ed_050,th_sd_050,htrt_sd_050] = htrtt_corr_fun_warm('htrt_050','theta_050');
'050'

[corr_075,htrtt_ed_075,th_sd_075,htrt_sd_075] = htrtt_corr_fun_warm('htrt_075','theta_075');
'075'

[corr_100,htrtt_ed_100,th_sd_100,htrt_sd_100] = htrtt_corr_fun_warm('htrt_100','theta_100');
'100'

save('/project/rg312/mat_files/htrt_theta_corr_warm.mat')
clear
